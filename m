From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Fri, 21 Mar 2014 00:03:28 -0400
Message-ID: <CAPig+cRv-WvoMVY0PDgtLawywe0QfpX8oPetzNwD-9Jq6BOjyw@mail.gmail.com>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com>
	<loom.20140318T124348-742@post.gmane.org>
	<lg9l22$qto$1@ger.gmane.org>
	<CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com>
	<lgekju$u6t$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Aleksey Mokhovikov <moxobukob@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:03:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQqgF-0002RA-7R
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 05:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbaCUEDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 00:03:30 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:65249 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaCUED3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 00:03:29 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so1867447yha.30
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 21:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=To26lqO4UbFJLRi9uOOrT2sVB1UeHVOI6z8nYcbA5sU=;
        b=ynzhWmTDuB9Zml1MzTonsPsDDHhyEyc1NetUjBNlhUI5t3y8U1LVtngNpVXpe/cP9B
         o25kqTUjUcjF8IXAjNDgIgmcKLc/Gx9tBvwjObEud0kbKtKdaRgOWg97IDowKCPiupSb
         Davj345GrhKwO8tt1mL0zSc7KL9LeXeFeji2OF7HZUcTeMNgPAKUpysilcZ9RENfBS32
         mliIl0Biiob4KAeShTOgodhS2C9P87/Hj+Ex0b8X3ncUVUtmZNDcPlh1iaCFMr8CGE1Q
         tbmG3fCroBQGjiNL/6oS6dyL7B29dZxWG/0u/lsK7F21HJioyG7Li34EZZyhEC22bawM
         dAwQ==
X-Received: by 10.236.126.81 with SMTP id a57mr23693747yhi.95.1395374608604;
 Thu, 20 Mar 2014 21:03:28 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 21:03:28 -0700 (PDT)
In-Reply-To: <lgekju$u6t$1@ger.gmane.org>
X-Google-Sender-Auth: qdDjWioY0qIHLUiTA92xS5NUL3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244635>

On Thu, Mar 20, 2014 at 7:56 AM, Aleksey Mokhovikov <moxobukob@gmail.com> wrote:
> On 03/19/2014 04:21 PM, Eric Sunshine wrote:
>> Thanks for the resubmission. Comments below...
>>
>> On Tue, Mar 18, 2014 at 10:33 AM, Aleksey Mokhovikov
>> <moxobukob@gmail.com> wrote:
>>> Subject: [PATCH][GSOC] Selection of the verbose message is replaced with generated message in install_branch_config()
>>
>> Say [PATCH v2] to indicate your second attempt.
>>
>> This subject is quite long. Try to keep it short but informative.
>> Mention the module or function first. Use imperative voice. You might
>> say:
>>
>>     Subject: install_branch_config: replace if-chain with table lookup
>
> Thanks. This is my first experience with such newsgroups. I don't know explicitly how this mail-nntp newsgroups work
> under the hood, so I was afraid, that if I'll change the subject, gmane will create a new thread instead of placing a
> comment.

The --in-reply-to option of "git send-email" may be useful. It's
important to satisfy the requirements of patch correctness; and
probably not worth worrying about satisfying Gmane, or any of the
other services archiving the mailing list, which are beyond our
control.

>>> If !!(x) is out of the coding guide, then message_id construction
>>> can be rewritten in several other ways.
>>> The guideline tells that !!(x) is not welcome and should not be
>>> unless needed. But looks like this is normal place for it.
>>
>> Curious. !!x is indeed used regularly. Where did you read that it is
>> not welcome?
>
> In git/Documentation/CodingGuidelines:
>>   170   - Some clever tricks, like using the !! operator with arithmetic
>>   171     constructs, can be extremely confusing to others.  Avoid them,
>>   172     unless there is a compelling reason to use them.

Interesting. A quick grep shows that most !! are used on pointer
values but some are used with arithmetic constructs (mentioned in the
excerpt). In the context of this type of patch where you need to
restrict those values to 0 or 1 before multiplying or shifting, !!
might qualify for the "unless there is a compelling reason" exception.

>>>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>>>  {
>>>         const char *shortname = remote + 11;
>>>         int remote_is_branch = starts_with(remote, "refs/heads/");
>>>         struct strbuf key = STRBUF_INIT;
>>>         int rebasing = should_setup_rebase(origin);
>>> +       int message_id = (!!remote_is_branch << 2) | (!!origin << 1) | (!!rebasing);
>>
>> It works, but it's also a fairly magical incantation, placing greater
>> cognitive demands on the reader. You could achieve a similar result
>> with a multi-dimensional table which is indexed directly by
>> !!remote_is_branch, !!origin, and !!rebasing. (Whether you actually
>> want to do so is a different question.)
>
> I thought about a multidimensional table and about this approach before submitting a patch
> and it looks easier for me to read without multidimensional table. But I mentioned that indexing can be rewritten
> several ways. It will be even easier if the named function or macro is used:
>
> #define BOOL_TO_BITFLAG(x, shift) (!!(x) << (shift))
> ...
> int message_id = BOOL_TO_BITFLAG(remote_is_branch, 2) | BOOL_TO_BITFLAG(origin, 1) | BOOL_TO_BITFLAG(rebasing, 0);

Verbosity doesn't necessarily equal clarity. (1 << n) is a standard
idiom for setting the n'th bit, and should be well understood. The
macro usage also doesn't reduce the cognitive load since the reader
still has to puzzle out how 'bool' and 'bitflag' relate to table
positions.

(But that's only my opinion, and as part of the review process, you
are welcome to present yours. And, as it's Junio's tree into which
patches will be accepted -- or not -- he has final say-so.)

>>> +       const char *message_table[][4] =
>>> +               {{N_("Branch %s set up to track local ref %s."),
>>> +                 local, remote},
>>> +                {N_("Branch %s set up to track local ref %s by rebasing."),
>>> +                 local, remote},
>>> +                {N_("Branch %s set up to track remote ref %s."),
>>> +                 local, remote},
>>> +                {N_("Branch %s set up to track remote ref %s by rebasing."),
>>> +                 local, remote},
>>> +                {N_("Branch %s set up to track local branch %s."),
>>> +                 local, shortname},
>>> +                {N_("Branch %s set up to track local branch %s by rebasing."),
>>> +                 local, shortname},
>>> +                {N_("Branch %s set up to track remote branch %s from %s."),
>>> +                 local, shortname, origin},
>>> +                {N_("Branch %s set up to track remote branch %s from %s by rebasing."),
>>> +                 local, shortname, origin}};
>>
>> Indeed, this is a reasonably decent way to keep the arguments and
>> messages together and can simplify the code nicely. Unfortunately,
>> this project is still restricted primarily to C89, so using
>> non-constant C99 initializers is likely to prevent the patch from
>> being accepted.
>
> Strange. This is not a static variable. N_(x) is expanded to x - is just a marker for xgetext.
> array dimensions are known on compile time. Thought here will be no problems with standard.

I was referring to the variables 'local', 'remote', 'shortname',
'origin', all of which are, um, variable (non-constant).

>>> +               if (!message || !message[0])
>>> +                       die("BUG: message is NULL. Fix verbose message table.");
>>
>> Meh. May be overkill. If either of these is NULL, you'll get a crash
>> anyhow, which is a good indication of a bug.
>
> If either of them is NULL it can be UB. And if message[0] is NULL, it's quite likely. that
> printf will just skip it, so I think it's better to assert message[0].

Sorry, you're right about message[0] case not being a crasher (though
the assert() still seems overkill).
