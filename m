From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 03/19] refs.c: make ref_transaction_commit return an
 error string
Date: Mon, 28 Apr 2014 10:46:30 -0700
Message-ID: <CAL=YDW=CBnWU3t05MwAYkGP+0cLPdVqypM-jjZhCzUiWEjCwsA@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-4-git-send-email-sahlberg@google.com>
	<20140425221001.GB9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:29:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerEh-0003DE-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbaD1T1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:27:44 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:50929 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbaD1TZT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:25:19 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz11so8587215veb.33
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IFvG6OLqig7Tyl6BH6rltLYH758jt7vExvGPDNF/Pm0=;
        b=DNMzOyjy3pngm7TNNHf9knUkxXHtTYDGQASmp+qsEI3Wl4Qx6YnhB9T8P61kcZpFxC
         +SW07lOByS0Xhz+MvJzFDG46NGgVlpiyYiYWql2M2Oq4hQUz3Iz3o762D0E9QkipMxKY
         8FFMMgFG84GZ2zSzZw0xZaN2bSXe3426G5LzkIR3i5875h7CSZQl9BfFQbVh0pcLrc6J
         Psdmq5ANVMM4Io3C2RURCS2DfbdJ3cA5AMpQYZEnlSZtEIfCeuVeUnY3QU1OjcI99DmI
         lBRUjsy/bbWeDKKLOE1UP/DHeUf9Q4YbUuwO5fnK+zkfel2cc0LFu49wBMDzgKJ9gRgQ
         rD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IFvG6OLqig7Tyl6BH6rltLYH758jt7vExvGPDNF/Pm0=;
        b=RFqdvf3jCCAR0r37QJgJRbOaGb773iS+WpB2aopvYe/vx2iP3kESJLAG+P1Tp6c3cz
         o+eTvgd6U4jcc2NDi7orgDWGvcY2KiChmuaMfCYsBdgEICBVDQ99sGLx2yTAKk0t5Nou
         dzJOvIBuT4WFkiam11O0CZhVql3KBzVAAOMQrqykBK24hDy0AwOH+gUv8kjZULY92dlv
         m48F2WUL9oRw+kGPDaKOqJATh1ipwF7aAfeuEbOdh3zTGPf6TEfTJ9cN5bYOOqIeewlX
         ydWtIbhsMvcjUej1Y/+sRymD22isQmYxUw6bsqnvbeJuZe3nbAd2WEDBa1nkY3XKBive
         3g4A==
X-Gm-Message-State: ALoCoQlzj+leUjurzeVBIPayCCTY71zNRn6Vk7zb2QBgoStW75jCBNNbJwniL2HYZDX9Ra2c+MUPHdU0SViEmNvJklxF/5MYM9/FbtqhXDupJvcGdb6GvMD7h/b7O3kUo8VP47LbVSC+xMhCVse68CnoJoNHd2fcK4RCZkkWUvHWl0x20AAn4l1Tt3LB0W9CapaCTBB+1qaZ
X-Received: by 10.58.49.10 with SMTP id q10mr24210892ven.5.1398707190797; Mon,
 28 Apr 2014 10:46:30 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 10:46:30 -0700 (PDT)
In-Reply-To: <20140425221001.GB9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247407>

Good points.



On Fri, Apr 25, 2014 at 3:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Let ref_transaction_commit return an optional error string that describes
>> the transaction failure.  Start by returning the same error as update_ref_lock
>> returns, modulo the initial error:/fatal: preamble.
>
> s/returns/prints/?

Done, and then was deleted when I reworded the message.

>
>> This will make it easier for callers to craft better error messages when
>> a transaction call fails.
>
> Interesting.  Can you give an example?  What kind of behavior are we
> expecting in callers other than die()-ing or cleaning up and then
> die()-ing?

I was thinking a bit too far ahead. You could in theory keep logging multiple
lock failures during the _commit() and then when the transaction fails
and returns
it will have appended a list of all refs that failed and not just the
first ref that failed.


>
> I like this more than having the caller pass in a flag/callback/etc to
> decide how noisy to be and whether to gracefully accept errors or exit.
> So it seems like an improvement, but may always returning error()
> would be better --- more context would help in clarifying this.
>
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -268,9 +268,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
>>   * Commit all of the changes that have been queued in transaction, as
>>   * atomically as possible.  Return a nonzero value if there is a
>>   * problem.  The ref_transaction is freed by this function.
>> + * If error is non-NULL it will return an error string that describes
>> + * why a commit failed. This string must be free()ed by the caller.
>>   */
>>  int ref_transaction_commit(struct ref_transaction *transaction,
>> -                        const char *msg, enum action_on_err onerr);
>> +                        const char *msg, char **err,
>> +                        enum action_on_err onerr);
>
> Is the idea that if I pass in a pointer &err then
> ref_transaction_commit will take the action described by onerr *and*
> write its error message to err?

Temporarily, yes.
Shortly after this patch I remove the onerr argument completely.
But I want to keep the "pass error back to caller" and "get rid of
onerr" as two separate patches.
I think it is easier to follow the flow of changes if they are done in
two separate steps.

>
> Probably squashing with patch 07 would make this easier to read (and
> wouldn't require changing any messages at that point).

See above.

>
> [...]
>> --- a/refs.c
>> +++ b/refs.c
> [...]
>> @@ -3443,6 +3447,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>                                              update->flags,
>>                                              &update->type, onerr);
>>               if (!update->lock) {
>> +                     if (err) {
>> +                             const char *str = "Cannot lock the ref '%s'.";
>> +                             *err = xmalloc(PATH_MAX + 24);
>> +                             snprintf(*err, PATH_MAX + 24, str,
>> +                                      update->refname);
>> +                     }
>
> Might be clearer to use a helper similar to path.c::mkpathdup
>
>         char *aprintf(const char *fmt, ...)
>         {
>                 char *result;
>                 struct strbuf sb = STRBUF_INIT;
>                 va_list args;
>
>                 va_start(args, fmt);
>                 strbuf_vaddf(&sb, fmt, args);
>                 va_end(args);
>
>                 return strbuf_detach(&sb);
>         }
>
> or to have the caller pass in a pointer to strbuf instead of char *.

strbuf as argument is probably the right thing to do. I am doing that change.

>
> The rest looks good to me.
>
> Thanks,
> Jonathan
