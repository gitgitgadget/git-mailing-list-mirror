From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Thu, 4 Sep 2008 00:50:18 -0400
Message-ID: <32541b130809032150i418014bdo8a838f529e109f50@mail.gmail.com>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
	 <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
	 <20080902210524.GB7757@leksak.fem-net>
	 <200809022339.20123.johan@herland.net>
	 <alpine.LFD.1.10.0809021849390.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Pieter de Bie" <pdebie@ai.rug.nl>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 06:51:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb6oY-0001df-FU
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 06:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbYIDEuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 00:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbYIDEuU
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 00:50:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:10531 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbYIDEuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 00:50:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3103011rvb.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nP7y6kJnXbbxLyh43MlipYv8GYqzkm3/nO+B/RxPtUY=;
        b=nn1Bab8ma+sYa6ltMl5f0NkulBx9ltIPn9T34BGy+WCaE9ZF+6FCYhui8Rdur/mmpS
         CljzJ8SCteRPMQd+6ukMF/GmZ85xz+u8AzaVV/ipzliBh2Ra0oXYRbEqVCaCEj+bMOIH
         YlL66aKN8yBBF55AJq1mGHQKSVN9gUIlLAPPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=e/MqtCAHOmg682lCuSzbJGWR2li9gCEEeNPenVCIuLQkE2COM6bE2HgFpuuim1RIym
         hkYcbFY6jz+cdHl40YnsdK7sP+ibt4yDY9wfboyt8V5URyjSaKTytXzB9arNfA6c5SAg
         7fK+N9+DQeBf46w1b1enQ/USA3zZzfF1K3+oo=
Received: by 10.141.210.13 with SMTP id m13mr5434364rvq.25.1220503818837;
        Wed, 03 Sep 2008 21:50:18 -0700 (PDT)
Received: by 10.141.194.15 with HTTP; Wed, 3 Sep 2008 21:50:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809021849390.23787@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94892>

On Tue, Sep 2, 2008 at 6:53 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 2 Sep 2008, Johan Herland wrote:
>> Vienna:git pieter$ ./git commit --allow-empty -m"test"
>> You are on a detached head, so this commit would not be recorded in a
>> branch. If you don't want to lose this commit, please switch to a (new)
>> branch before committing. If you know what you're doing, and want to
>> proceed on a detached HEAD, please enable commit.detached in your
>> configuration (git config --global commit.detached true)
>>
>> ...but I sympathize with those that think this is overkill.
>
> This is going over board indeed.
>
> Adding commits to a detached head is _cool_, and it is also _useful_ in
> many occasions.  Let's not obfuscate that capability.
>
> Adding an extra line of warning when the commit is done is fine, but
> more than that is too much IMHO.

I think maybe we're looking at this the wrong way.  The bad thing
isn't committing to a detached HEAD; the bad thing is detaching the
HEAD *by accident* in the first place.

Why do people (including me) spend so much time with a detached HEAD?
I think it happens mainly for the following reasons:

1) Checking out a remote branch "git checkout origin/master" detaches
my HEAD, which is kind of bad, since it's such a common thing to want
to do.  And "git checkout -b master origin/master" is *not* actually
what I want to do, *most* of the time. What I actually want is for git
to remember that I'm on origin/master, but not let me change
origin/master, because it's a remote branch.  If I want to make
changes, I need to first make a topic branch, with "git checkout -b
topic".  git should prevent me from committing until I do.

2) git-rebase and git-am detach the HEAD while they work.  I think
this is fine, but: you shouldn't be able to *reattach* the HEAD
without first aborting the rebase or am operations.  When I've lost my
work, it's usually because I turned out to be in the middle of a
rebase or am and forgot about it, then I checked out another branch
and did some work, then ran git-rebase --abort, and oops! It moved me
somewhere else.  git should prevent me from switching branches when a
rebase or am is in progress.

3) git-submodule detaches and moves the HEAD of submodules
automatically.  This is a whole separate discussion :)

The remaining situations where someone is working on a detached HEAD
(eg. checking out a particular commit, or actually implementing
git-rebase like operations) seem to be pretty obviously *intentional*,
and in that case, git should stay out of their way and let them do
what they're doing.

I believe the reason this is such a hotly debated topic is that people
confuse situations #1 and #2, and try to apply the same solution to
both.  But in situation #1, you want to be able to switch branches; in
situation #2, you want to be able to commit.  They are different
situations, even though technically the fact that "I'm on a detached
HEAD!" is the same.

Have fun,

Avery
