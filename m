From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Wed, 18 Mar 2015 11:36:26 +0100
Message-ID: <CAP8UFD3=w_7Mm-ew6HDWyK-x9uUTwcw=URNp+gNvfFXueAkgBg@mail.gmail.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
	<xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
	<20150310225509.GA5442@vps892.directvps.nl>
	<xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
	<20150311184512.GB5442@vps892.directvps.nl>
	<xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
	<20150316163306.GB11832@vps892.directvps.nl>
	<xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
	<065AE7977A54488198B39564E3E174E6@PhilipOakley>
	<xmqqr3sops9f.fsf@gitster.dls.corp.google.com>
	<CAP8UFD12UX+3psD2=9_RsGv8JA2C8N54qAYGydYgr7n5ta7dzw@mail.gmail.com>
	<xmqqtwxjo4nf.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0Mn3SPimYU3fdF5pV1MDAHXhKUVSutfJKrXzPpaXM=bA@mail.gmail.com>
	<xmqq3853nyia.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, Kevin Daudt <me@ikke.info>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 11:36:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYBL4-0004ru-Qb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 11:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662AbbCRKg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 06:36:28 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36056 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbbCRKg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 06:36:27 -0400
Received: by igbue6 with SMTP id ue6so96001607igb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qbroKNT1QOa6GoKLywugqUsNCDaPb2r00hCQgD2dqaM=;
        b=UuAKrGuztWqaXckL90QYsj3ZLLndos+xf4ov8Cv/X0+DCrBIhwMAU/vRecVK9RGFsk
         bRR36NfSBvJeO9g5P587kb3/uHCksRaxY63DACkJVBPOtCrYmmKAEWWze5cvabpBIYN3
         fzZXSWLVpzNnh9hUx6OGBCktKXeVLoMNYnz+eHQVIPaz+VDbC12beO0ixPs3Lfl7Oj0h
         DzFwG6uJea6IJcXReM3xbfAD3P5Dry7fPM1zMBpDbUIz9e258X3L/xQoFwvR/zr9R0Hf
         5kdJYO7MMcibuhqxAX++znu5HsOx2VOM7GqwgVfIB8izz6UPS+mwa1b2BTMoz2C1Fpav
         q+vA==
X-Received: by 10.50.176.196 with SMTP id ck4mr5473633igc.40.1426674986454;
 Wed, 18 Mar 2015 03:36:26 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Wed, 18 Mar 2015 03:36:26 -0700 (PDT)
In-Reply-To: <xmqq3853nyia.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265715>

On Tue, Mar 17, 2015 at 9:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Tue, Mar 17, 2015 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> Yes, but the user is supposed to not change the "bad" pointer for no
>>>> good reason.
>>>
>>> That is irrelevant, no?  Nobody is questioning that the user is
>>> supposed to judge if a commit is "good" or "bad" correctly.
>>
>> So if there is already a bad commit and the user gives another
>> bad commit, that means that the user knows that it will replace the
>> existing bad commit with the new one and that it's done for this
>> purpose.
>
> ECANNOTQUITEPARSE.  The user may say "git bisect bad $that" and we
> do not question $that is bad. Git does not know better than the
> user.
>
> But that does not mean Git does not know better than the user how
> the current bad commit and $that commit are related.  The user is
> not interested in "replacing" at all.  The user is telling just one
> single fact, that is, "$that is bad".

The user may make mistakes and try to fix them, like for example:

$ git checkout master
$ git bisect bad
$ git log --oneline --decorate --graph --all
# Ooops I was not on the right branch
$ git checkout dev
$ git bisect bad
$ git log --oneline --decorate --graph --all
# Everything looks ok now; the "bad" commit is what I expect
# I can properly continue bisecting using "git bisect good"...

In this case the user, who knows how git bisect works, expected that
the second "git bisect bad" would fix the previous mistake made using
the first "git bisect bad".

If we make "git bisect bad" behave in another way we may break an
advanced user's expectation.

>>> I am not quite sure if I am correctly getting what you meant to say,
>>> but if you meant "only when --alternate is given, we should do the
>>> merge-base thing; we should keep losing the current 'bad' and
>>> replace it with the new one without the --alternate option", I would
>>> see that as an exercise of a bad taste.
>>
>> What I wanted to say is that if we change "git bisect bad <commitish>",
>> so that now it means "add a new bad commit" instead of the previous
>> "replace the current bad commit, if any, with this one", then experienced
>> users might see that change as a regression in the user interface and
>> it might even break scripts.
>
> Huh?
>
> Step back a bit.  The place you need to start from is to admit the
> fact that what "git bisect bad <committish>" currently does is
> broken.
>
> Try creating this history yourself
>
>     a---b---c---d---e---f
>
> and start bisection this way:
>
>     $ git bisect start f c
>     $ git bisect bad a
>
> Immediately after the second command, "git bisect" moans
>
>     Some good revs are not ancestor of the bad rev.
>     git bisect cannot work properly in this case.
>     Maybe you mistake good and bad revs?
>
> when it notices that the good rev (i.e. 'c') is no longer an
> ancestor of the 'bad', which now points at 'a'.
>
> But that is because "git bisect bad" _blindly_ moved 'bad' that used
> to point at 'f' to 'a', making a good rev (i.e. 'c') an ancestor of
> the bad rev, without even bothering to check.

Yeah, "git bisect bad" currently does what it is asked and then
complains when it looks like a mistake has been made.

You might see that as a bug. I am seeing that more as "git bisect"
expecting users to know what they are doing.

For example an advanced user might have realized that the first "git
bisect start f c" was completely rubish for some reason, and the "git
bisect bad a" might be a first step to fix that. (The next step might
then be deleting the "good" pointer...)

> Now, if we fixed this bug and made the bisect_state function more
> careful (namely, when accepting "bad", make sure it is not beyond
> any existing "good", or barf like the above, _without_ moving the
> bad pointer), the user interface and behaviour would be changed.  Is
> that a regression?  No, it is a usability fix and a progress.

Yeah, you might see that as a usability fix and a progress.

> Simply put, bisect_state function can become more careful and
> intelligent to help users.

Yeah, we can try to help users more, but doing that we might annoy
some advanced users,  who are used to the current way "git bisect"
works, and perhaps break some scripts.
