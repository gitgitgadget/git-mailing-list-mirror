From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 15:23:08 -0400
Message-ID: <CABURp0qHb_nYsSHad8E_0s-n-VeZN2tqQjeApV4ssBXrqCQKeQ@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
 <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com> <CALkWK0nR1=Pgv0AY78p7n17C-VVvbc6BfJ4y_Df1ciZoc-xR-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:23:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKow-00011i-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626Ab3ENTXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:23:30 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:40351 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENTX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:23:29 -0400
Received: by mail-ve0-f179.google.com with SMTP id oz10so1095650veb.24
        for <git@vger.kernel.org>; Tue, 14 May 2013 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=iy0REbQ4RC+Nw3AOq99IHPwk94Q/Au0XPq6S0htTivM=;
        b=pe8pDHpHO4/Sxz41tal6ClF7fNaQwXEugMEPn4HJ1QPcdWVO3h5h2BJcHrTylNESyZ
         QDgQfNN24kMHfpgAPzyub+LErMgvFdIvHAicl7qndWjEUIcp3miaIaC0ZMBSgFqkBHqn
         5Z4diagEoqPjJ8YfS5cB+oXOqQme+7Emly9ce5fCZokYIB1yauHNatS23YIYUIyP4bM8
         cKgEpi9X7CZuDp3PNc8AzRHR0/Vlbm96NdL6UHoh/VI5vQGXDwsq/jw1mTLcQBx/IC87
         Vkro6NUAiHqKmQwgsf09mWABKaO3/ZJGZqehIqeObKK2SoM1ZDdNOJ5j1TQavQwnD1yn
         Y4aw==
X-Received: by 10.52.180.10 with SMTP id dk10mr2283828vdc.26.1368559408562;
 Tue, 14 May 2013 12:23:28 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Tue, 14 May 2013 12:23:08 -0700 (PDT)
In-Reply-To: <CALkWK0nR1=Pgv0AY78p7n17C-VVvbc6BfJ4y_Df1ciZoc-xR-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224320>

On Tue, May 14, 2013 at 2:44 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Phil Hord wrote:
>> References to git-log seem out of place to me here in git-diffcore.  I
>> know it's only an example, but it seems that Git normally describes
>> these 'reference selectors' more generically.  The generic description
>> may be more confusing to new users, but this patch is not the place to
>> consider whether it should change.
>
> It's not for new users at all.  The most useful application of -S and
> -G is in log.  The translation from a log -G to a diffcore -G is not
> obvious at all, and warrants an explanation.
>
> Oh, and for the user.  No user is going to type out `man gitdiffcore`
> out of the blue: she's most probably led there from log, and we're
> connecting the dots for her.

She may have been led here by some other help topic, too.  Maybe the
git log examples belong in the git-log documentation.

>> While the switches are called -S and -G, I do not think it is helpful
>> to name the two pickaxe options as "the S kind" and "the G kind".
>
> How do you describe something precisely without loss of meaning?  You
> stop abstracting unnecessarily.  Read the sources: you will literally
> see DIFF_PICKAXE_KIND_G there.

S and G are abstractions.

DIFF_PICKAXE_KIND_G is an implementer's distinction.

I agree this is a tricky subject.  When writing technical
documentation you must be precise and clear.  It is easy to forget
both.  It is common to forget to be either clear or precise.  It is
very difficult to be both clear and precise.

So, my suggestion is to use some meaningful names for the action of -S
and -G.  Relating these names to -S and -G in a clear way is likely to
be difficult.

>>> +
>>> +The S kind detects filepairs whose "result" side and "origin" side
>>> +have different number of occurrences of specified string.  While
>>> +rename detection works as usual, 'git log -S' cannot omit commits
>>
>> The "cannot omit" feels like a confusing double-negative.  How about
>> "includes" instead?
>
> Intended.  Omission is expected.

This is precision at the expense of clarity.  Omission is not expected
for the user who wants to ask this question:  "Where is that commit
that added 'foo'?"  To Git she wants to ask "Show me the commit that
added or removed 'foo'."  You and I both know that Git does this in
reverse.  Git translates this question into "Show all the commits, but
hide the ones which do not add or remove 'foo'."

And so we say Git 'cannot omit' commits


>
>> Is it worth mentioning that something in the documentation is "worth
>> mentioning"?
>
> You don't have to nitpick style.  We can allow this much creative
> freedom in documentation.

I think I do.  The concepts in here are complicated enough without
loading the language with excess verbiage.  I am chronically afflicted
with this disease where I am always adding extra decorations to my
sentences.  I work hard to combat that, especially when dealing with
technical writings.  This makes it easy for me to recognize in other
technical writing.

I didn't look closely, but these unnecessary introductory clause
appeared to be the only change in this paragraph.  I do not think it
adds anything, which is why I mentioned it.

I could have been more clear and less flippant about it, though.  I'm
sorry if my manner was offensive. This is another chronic problem I
seem to have.


>>> +in effect, diffcore-pickaxe leaves only such filepairs that touch the
>>> +specified string in its output.  When in effect, diffcore-pickaxe
>>> +leaves all filepairs intact if there is such a filepair, or makes the
>>> +output empty otherwise.  The latter behavior is designed to make
>>> +reviewing of the changes in the context of the whole changeset easier.
>>
>> I find this description (from the original code, not from this commit)
>> somewhat confusing.  It is written from the implementer's POV.
>
> I explained the entire -S and -G thing in terms of filepairs (and yes,
> that's implementation detail).  Why would I want to explain this in
> any other terms?

Clarity.

What is a 'filepair' when I am getting a short-log?  Internally there
was a diff, and the diff involves pairs of files.  But it's a tedious
detail to the user which might send her off needlessly trying to
understand the meaning of the term.

But you are right; gitdiffcore.txt is about precision and
implementation.  The goal is to address the technical user who is
trying to understand these operations in general, not just for log.
'filepairs' is a useful concept to lean on.

The clearer description probably belongs in git-log.

>> Does
>> this seem clearer to you?
>> [...]
>
> From diff-options.txt (the more end-user side):
>
> When -S or -G finds a change, show all the changes in that changeset,
> not just the files that contain the change in <string>.
>
> Not clear enough?

Yes, it was clear enough to me in git-log.  Perhaps it is not worth
mentioning here.

Phil
