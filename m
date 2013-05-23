From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Fri, 24 May 2013 00:36:51 +0530
Message-ID: <CALkWK0nXRxL706t4EJoc2SHjwEdjCa_Q1UXZcwz8tsdDmQOneA@mail.gmail.com>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
 <x2ip2b6udr.fsf@bacon.lysator.liu.se> <20130522134212.GB13731@poseidon.cudanet.local>
 <20130522144531.GB2777@thunk.org> <7v8v36kiau.fsf@alter.siamese.dyndns.org>
 <20130522180403.GB20848@thunk.org> <7vvc6aj14r.fsf@alter.siamese.dyndns.org>
 <20130523021123.GA23155@thunk.org> <CALkWK0kyRno4eMYHXC3RkJFCVZ6DJWgFX=pR+WCu8=Gaf9q=Mw@mail.gmail.com>
 <20130523183759.GB1275@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>,
	Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu May 23 21:07:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfarR-000885-0X
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 21:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472Ab3EWTHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 15:07:33 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41311 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758028Ab3EWTHc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 15:07:32 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so9887488iee.27
        for <git@vger.kernel.org>; Thu, 23 May 2013 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DnH8zL0HXk+nVjxHs1n5u2M8gm9ECLEOjP3sBHziK2w=;
        b=Zq4p5cGcUVtVBFUSANqXiaHiUhSffsF/8elFknuZyKijrMnR0s8mZT32eEatuBeWQx
         HE7CEcr9U42ORZOAOBnLw76KKvDeBVA5zx9RgNeGIzTf4k7kRZpBUOjw2Jd5Nm6WzP4A
         Zfs3WvRvB6h5Zwf6U85+mQ2zMCk85nRNU623PwqJJ8aJb4aldU7ZReVF4MEPDfWxQsgT
         nkOoxIV8DmcdFXbSp8ual1/qK450NyDrPQ4lTGAfb18dOzK/84nPddZR7dNqzQiGc6dy
         UoO7DYWu4ZuPu6FuBBWUoOMbQ0jh6cYpSXcZCUuFli5jywznoRJE2D9ZNDsJoblSbqQb
         Mb0w==
X-Received: by 10.42.70.147 with SMTP id f19mr10509025icj.30.1369336051987;
 Thu, 23 May 2013 12:07:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 23 May 2013 12:06:51 -0700 (PDT)
In-Reply-To: <20130523183759.GB1275@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225283>

Theodore Ts'o wrote:
> Spekaing of which, what I'd really appreciate is timestamps associated
> with the reflog.  That's because the most common time when I've
> screwed something up is after doing a "git rebase -i" and so the
> reflog has a *huge* number of entries on it, and figuring out which
> entry in the reflog is the right one is painful.  If could tell at a
> glance when each entry of the reflog was created, it would make it a
> lot easier to untangle a tree mangled by git rebase -i.

Yeah, I completely agree with this one.  I've wished for the reflog to
be presented in a nicer ui, with humanized timestamps and colors.

> Meh; I don't *need* it.  But then again, I'm an fairly experienced git
> user.  The fact that I use guilt without the "guilt/master" safety
> feature and have never gotten bitten by it --- in fact I deliberately
> publish rewindable branches with a guilt patch series applies speaks
> to the fact that I'm pretty experienced at rewindable heads.

Oh, and thanks for mentioning guilt: I just learnt about it.

> The only reason why I suggested it is because I believe it would be
> useful for people with less experience, and perhaps it would help make
> rewindable branches less scary, and less subject to a lot of the
> fearmongering that you see on the blogosphere.

My message was a critique.  I'm not denying that the feature may be
useful; it's just that we should have a good rationalization of the
usecase and design something carefully.

> Sure, and if I cared I'd make a git alias to automate this, instead of
> depending on finger macros.

Yes.  My comment was more of question: can --multiple be more than a
for loop written in shell?  If not, is it worth writing?  Are there
enough users?

Junio mentioned pushurl in the other email: if they're perfect
mirrors, won't pushurl suffice?

> I create new branches all the time.  But they are for my own personal
> testing purposes.  So it's fairer to say that I rarely *publish* new
> branches; I generally stick to the standard set of next, master,
> maint, and pu.  And part of that is that even publishing this number
> of branches is enough to sometimes confuse the e2fsprogs developers
> who are pulling from my tree.

Just for contrast: I never keep anything locally.  I publish as much
of my setup as humanly possible so that I'm not tied to one machine.

> In general, no, I don't do that, for the reasons stated above --- even
> publishing four branches gets to be confusing enough for people who
> are looking at my tree.

Just publish different branches to different locations?  Isn't that
why we got triangular workflows?

> I'm sure other people and other communities use git differently, so
> please insert the standard disclaimer that there's more than one way
> to skin a cat.

Ofcourse.  I believe in being all-inclusive, and not dropping a single
feature that has users.
