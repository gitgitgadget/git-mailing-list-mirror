From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/RFC] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Fri, 18 Mar 2016 01:52:13 +0530
Message-ID: <CAFZEwPPJ37+Yc1ANoOEcniOTpocKVUsXkh1fKoJr50-=ZcCp+Q@mail.gmail.com>
References: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
	<20160317015044.GB12830@sigill.intra.peff.net>
	<CAPig+cRkAE4BzbgniP=peHE-pBfKt1i2C4MqJcJ36sMfsSh3KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 21:22:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ageR4-0008VS-6M
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 21:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935781AbcCQUWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 16:22:16 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33336 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbcCQUWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 16:22:14 -0400
Received: by mail-yw0-f169.google.com with SMTP id m126so90696252ywd.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8R2kZj5chqTtM2kgxcF15wmfpA0WThIqDMRZi+lzW8E=;
        b=lbUlg23IVDkZTEI/HJP1G+BmoVRBGSsGWi+SJ6yVdvi/kx0T2j+8WdQIDwGI5eflqS
         9dL0wJmeWkVFC3gEFU2egHtKAaTugG+x6erW4k0CEe9VVAoR5FUyBHcwYgVldv8/g6QP
         OOFF9NFt5Dt8ibUyTyEJFrhoe40981RUfElKC6YbPD/VjesDVFVj4yisR+8YKPp5cqh2
         G2QUtoFFsv0DjwWSKflN8lMmHSF8jz4uzadsf8Trg9GqaiGqfj/ICAr+NMdyFL/Dlrcs
         aAG7vbnq7wImpB8+sbbHUINq19iCGEKDzWU3mo5tFENDqpx7yNtC0zZZ3F6fwPBDaxy1
         C3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8R2kZj5chqTtM2kgxcF15wmfpA0WThIqDMRZi+lzW8E=;
        b=M0AYp1fhar9299LQsLVqsCxk3HuzNn4Y301Qdspd1Cx74WLsEtkQsUA03F1gdrg0y5
         LHx0M0ZT2G6IX+qyTQJ6p8rbJ3VSfrUZVB5/PA1XLekzlaM4ul+E+aV3QnJdsFLPMKzb
         EV+Dj2+5XRwbjtQ9qD52u4hHkFUMgTjKjEnmb/StNPYzo2gFFHv+urE642mpMHpRg7XZ
         6CgfqnRp7VRXOHq+VQqTKwKaR69k7IfOqj+vfxC7ab02uQqFwJEIs0PWba6xMC3BkMrY
         /SzSglWByRnXi7YGOm9KXdIcChJ7/5IkgAh+88v/cuH6Mn/p8kfhBBuM579MRYZePEVX
         KXEw==
X-Gm-Message-State: AD7BkJJnGgJt7ZqUyIaupFZIROgl3EgL8/lJUBtBmy8JxGCp14sxTKbtJT/349B7hSEnnxeFWNvrTDDtWp6yZg==
X-Received: by 10.13.252.67 with SMTP id m64mr5527978ywf.67.1458246133201;
 Thu, 17 Mar 2016 13:22:13 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 17 Mar 2016 13:22:13 -0700 (PDT)
In-Reply-To: <CAPig+cRkAE4BzbgniP=peHE-pBfKt1i2C4MqJcJ36sMfsSh3KQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289154>

On Thu, Mar 17, 2016 at 12:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 16, 2016 at 9:50 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Mar 16, 2016 at 11:16:58PM +0000, Pranit Bauva wrote:
>>> The reason to make it consider negative values or more specifically
>>> "unspecified" values is to differentiate between the option passed
>>> once, multiple times or with --no-option. This makes the receiver
>
> This is inaccurate and rather confusing. It's not that an
> "unspecified" value gives you the ability to "differentiate between
> once, multiple time or with --no-option", but rather that it allows
> you to determine wether --option or --no-option was encountered at
> all.

I guess the language wasn't very clear. I will change this.

>>> know what actually happened with the arguments which is particularly
>>> required with option have multiple levels of that option.
>>>
>>> Eg. :
>>> initialize verbose = -1
>>> `git commit` => verbose = -1
>>> `git commit -v` => verbose = 1
>>> `git commit -v -v` => verbose = 1
>>> `git commit --no-verbose` => verbose = 0
>>
>> This second to last example would be 2, right?
>
> Right.

My bad, it should be 2.

>
> I'm not sure that this example block is helpful, though. A clearer
> commit message which does a better job of explaining the reason for
> the change would likely eliminate the need for an example.
>
>> That aside, this patch does mean that one can no longer use
>> OPT_COUNTUP() for negative values (i.e., the caller must start it at
>> either 0 or 1, and it must always go up from there).
>>
>> And we would need to verify that all of the existing callers are OK with
>> this. Did you check that that (not rhetorical; I suspect they are all
>> OK, but somebody needs to check)?
>>
>> We are also changing semantics without changing the interface, which
>> means any topics in flight (that you _cannot_ review, because you have
>> not seen them yet) may be subtly broken. To me that is not an absolute
>> deal-breaker, but something to weigh against the utility of the change.
>
> Indeed, I was envisioning a more conservative approach of having
> OPT__VERBOSE use a custom callback or perhaps introducing a new
> 'flags' value or even (probably too ugly) abusing the 'defval' field
> to specially indicate that it wants the "negative means unspecified"
> behavior; the other consumers of OPT_COUNTUP would not request this
> special behavior. But, as you say, changing the behavior of
> OPT_COUNTUP unconditionally may not be a deal-breaker.
>
> I also realized that Pranit can achieve the desired behavior without
> modifying OPT__VERBOSE at all. Specifically, rather than initializing
> his opt_verbose variable to -1, he can instead initialize it to 1.
> Then:
>
> * if --verbose is seen (one or more times), opt_verbose will be >=2,
> and the real verbosity level will be (opt_verbose - 1)
>
> * if --no-verbose is seen, opt_verbose will be 0
>
> * if neither is seen, then opt_verbose will remain 1
>
> However, I think this approach is far too ugly and non-obvious to
> seriously suggest using it, whereas the change to OPT__VERBOSE is
> easily understood and could prove useful in the future for other
> commands with multiple verbosity levels.
>
>> When looking more carefully at builtin/commit.c for the other thread, it
>> occurred to me that OPT_BOOL might be a better fit for commit's "-v". It
>> really is a boolean "show the diff or not" and thus unlike the other
>> "make me more verbose". And OPT_BOOL already has the behavior you want,
>> I think.
>
> For completeness (for readers of this thread), it was pointed out in
> the other thread[1] that git-commit does indeed recognize multiple
> verbosity levels, so changing it to use OPT_BOOL would be undesirable
> (wrong).
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/289027/focus=289074
