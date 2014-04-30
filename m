From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 08/12] MINGW: fix main() signature in http-fetch.c and
 remote-curl.c
Date: Wed, 30 Apr 2014 11:38:39 -0500
Message-ID: <5361270f70fed_1404fdd3102e@nysa.notmuch>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
 <1398762726-22825-9-git-send-email-marat@slonopotamus.org>
 <5360B5EC.1070907@gmail.com>
 <CABPQNSbSipaCAgJV0LimP-J1-WOXHQU5w9qOoBq-ccRYQFrAxw@mail.gmail.com>
 <alpine.DEB.1.00.1404301424590.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:49:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfXhB-0004HR-OB
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 18:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895AbaD3QtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 12:49:18 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:56020 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbaD3QtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 12:49:17 -0400
Received: by mail-yk0-f180.google.com with SMTP id q9so1713474ykb.11
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=BJevbS8Xv06gGdK3IZWnkNTbryc/cGDHBJw8p8EAsSs=;
        b=zQy4j8Bd76asKrH1aRs+pWH1dnRbK4oG18OvAlpgj4v87GQOzTq1lJ2E8nTEke2297
         GJK/I4njrUl7WNqnqQTNtjwuAeNrx8i/+8niXgXRsW8hqzTV+1qut6Lxzglmx1GLL2oW
         n+M1P1PVyAQt9B7WWLSoqhn/g2EfA/6fApa7XT4KXD737luzOWu+DVG7V9QQoNH5SmvT
         kvggHV2Emu8LSLX7sRAF5bEVITVDIVSO0XH8x4/lHRvlCpffWnSGpZ3vlUw5TVcJ+e0m
         WP5vfLzXpKtI7SEnxhK9O1MFWFp2B0W5guy0wGVsN+kVyKkCGBuRlyr7vBtRLdLV4J5a
         Xmmg==
X-Received: by 10.236.135.104 with SMTP id t68mr7296253yhi.35.1398876556485;
        Wed, 30 Apr 2014 09:49:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t63sm43764125yhm.32.2014.04.30.09.49.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 09:49:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1404301424590.14982@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247742>

Johannes Schindelin wrote:
> On Wed, 30 Apr 2014, Erik Faye-Lund wrote:
> 
> > While it's certainly a good point, I think this is *our* fault for not
> > upstreaming our changes, and the responsibility of cleaning up merges
> > should lie on our shoulders. We've diverged a lot. Sure, Dscho does a
> > great job making the divergence less painful, but IMO we should try to
> > reduce the delta as well.
> 
> Just for historical context: we *did* try to get our changes upstream. In
> fact, that was in large part everything Steffen Prohaska did while he was
> maintaining Git for Windows. The going has been tough, though, to the
> point that we were losing contributors who were not *quite* willing to put
> up with such a detailed vetting process as the Git mailing list requires.
> 
> I have to admit that it is really, really hard even for someone like me,
> who is used to the ways of the Git mailing list, because just a simple
> thing like this curl-config issue already eats up several days of my Git
> time budget.
> 
> So while I am sympathetic to the point of view that the Git for Windows
> project failed to upstream its changes, I am *equally* sympathetic to the
> point of view that it is an undue burden to have to go through the process
> of getting patches included by upstream Git. I, for one, simply ain't got
> the time, man.

As a maintainer of another friendly fork of Git (or downstream), because
of very similar reaons, I symphathize.

It's something that has to be done though, otherwise the burden of
maintaining the friendly fork becomse unberable.

The trick is to only send the trivial patches upstream, and also to
constantly keep track of what is missing from upstream.

In oder to do this I've found invaluable to have an integration branch,
which I constnatly regenerate with `git reintegrate`[1]. IIRC you do a
similar kind of reintegration for each new release of msysgit, and it
appears to me that you do it by hand, which must be tedious.

I'm planning to write a blog post about the subject, but basically I
have a bunch of branches that are direct descendants of an upstream
version, I tell `git reintegrate` to merge them on top of certain
upstream release, the result must match *exactly* what my main master
branch has. The descendant branches I constanly keep rebasing, and the
main master branch always mergering and cherry-picking, never rebasing.

[1] https://github.com/felipec/git-reintegrate

-- 
Felipe Contreras
