From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 19:29:35 -0500
Message-ID: <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIpML-00029w-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab3IIA3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 20:29:37 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:45257 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3IIA3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 20:29:36 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so4399680lbj.41
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n8ewF2jwZE6Du+WjLYAkg22cQupzkbPoTIMp4V1N0ko=;
        b=FYOhwb1MhvObNe7TxgeqXvc9iU5hEd//QBmFHWrE5N8zOu30Wodvdg1pDdpo60t1Q/
         KpwzsxT/bIbgy8b/TpACEKrchNEV2c09BPGUTzP+edPMfDqrj7OoDdMlD8ULhF05oFvz
         niWA7g/4+iZuM+CA/OuRYZMFPGOt7NuXOw3DUY0/bK41pmeXv404fJ9iCzZJepw1Zfbb
         CUov+f36Ffk1gTKLmeR3J2FgT/bMIXilUZjMZSXVtlmZEPdQe15umaFX32cK7CfXyqpl
         qItdVKtS0QpJJJrosZY/Y3BHDK6275ghqf35u/luwiFv0GAi68wcKtiV442Fr4f2abk8
         BxMQ==
X-Received: by 10.112.51.166 with SMTP id l6mr14060805lbo.5.1378686575386;
 Sun, 08 Sep 2013 17:29:35 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 17:29:35 -0700 (PDT)
In-Reply-To: <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234289>

On Sun, Sep 8, 2013 at 7:01 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Sep 08, 2013 at 05:38:50PM -0500, Felipe Contreras wrote:
>> Yeah, but the key question at hand in this discussion is; what happens
>> when 'git pull' stops working for them, and they don't know what to
>> do, will they choose 'git pull --rebase' by mistake?
>
> I agree, they will not choose git pull --rebase by mistake.
>
>> I say the answer is no, because:
>>
>> 1) As you say in your scenario, somebody is telling these guys what to
>> do, so when 'git pull' fails, somebody will figure out that they were
>> doing a merge, so 'git pull --merge' is what they want to type from
>> now on.
>
> Yes, that would be me.  My hesitance here is that as the one usually
> driving git updates (which so far have happened once a year), I will end
> up retraining forty developers.  I don't think the current behavior is
> broken or really problematic at all: merging has always been the
> default, and people have come to expect that.

It may not be broken for you, but it is for other people. Would you be
so egocentric as to ignore everybody else because "it works for you"?

> People using workflows
> that don't want merge have always either needed to set a configuration
> option or use --rebase.  As the man page says, --rebase is unsafe, and
> that's why it's not the default.

Yes, but the problem is that people using other workflows end up
avoiding 'git pull' at all, so at the end of the day we have one core
command that the majority of users avoid, that's not good.

> I would be much less unhappy with your earlier change that did not
> affect uses with arguments.  That would limit the number of use cases
> affected.

I have no problem with:
git pull $remote $branch

Allowing non-fast-forward merges.

And:
git pull $remote
git pull

Not allowing them by default.

But the problem is that it's not easy to implement.

Either way, I'll venture that you don't want 'git pull $remote' to
change, so it would be a waste of the time to try to get the above to
work.

>> 2) Git itself would be warning them for months that a 'non
>> fast-forward was found, and a merge will be done for them', so when
>> the warning turns to an error, they'll know they want a merge, so
>> they'll do 'git pull --merge', either because the warning told them
>> that's git was doing all along, or because they figured that out by
>> googling, or reading the man page, or whatever.
>
> Again, you assume that git updates happen on a regular basis, and you
> assume that most developers really know what happens under the hood.

No. The developers don't have to know what happens under the hood, Git
would be telling them "WARNING: we are doing a merge", what else is
the developer to think, but that 'git pull' is doing a merge?

As for the updates, yes, I assume updates happen at least each three
months. If your company updates each year, I don't see what much more
we can do to you help you. Doing a single change per year is certainly
going to hold the project back.

Fortunately this was only point 2), there's still point 1); you can
tell them to use 'git pull --merge' from now on, and since you update
once every year, you can do it while you give the training for the
year.

Or there's another option:

3) Distribute Git in your company with /etc/gitconfig having pull.mode
= merge. This way nothing will change.

I think we are being very accommodating to your company's use-case
which is very far from the norm. Even in the absolute worst case
scenario, you would have to tell people to use 'git pull --merge'
instead, is that really so horrible? Should we really halt Git's
progress because you would have to tell people to type nine extra
characters or run one configuration command?

> I don't see a warning now; in fact, I see:
>
>   vauxhall ok % git status
>   # On branch master
>   # Your branch and 'upstream/master' have diverged,
>   # and have 1 and 128 different commits each, respectively.
>   #   (use "git pull" to merge the remote branch into yours)
>   #
>
> The current behavior of git is to explicitly encourage this behavior,
> and now you want to make it not work.

Yes, that's why it's a change.

> I think this change is a bad
> idea, and I think the number of changes required to the test suite
> indicates that.  If there's going to be a change here, it should have a
> deprecation period with the above message changed and appropriate
> warnings, not a flag day; your patches don't do that.

My patches pretty much do nothing else but introduce a warning.
Nothing is broken, nothing is changed in the test suite:

http://article.gmane.org/gmane.comp.version-control.git/233669

You are confusing my proposal with Junio's one.

Also, my proposal was to enable this behavior (pull.mode =
merge-ff-only) only for Git v2.0, which might happen probably way
later than a year from now, so you your users might actually see the
warning after all. But yeah, that's _my_ proposal.

-- 
Felipe Contreras
