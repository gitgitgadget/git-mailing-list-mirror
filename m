From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git push --mirror" update mirrors
Date: Sat, 26 Apr 2008 13:01:26 -0400
Message-ID: <20080426170126.GC29771@spearce.org>
References: <4812DA50.3000702@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:02:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpnn3-0006JZ-Cu
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 19:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758704AbYDZRBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 13:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758651AbYDZRBd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 13:01:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54613 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757996AbYDZRBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 13:01:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jpnm5-00066V-Ue; Sat, 26 Apr 2008 13:01:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4E6D720FBAE; Sat, 26 Apr 2008 13:01:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4812DA50.3000702@gnu.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80381>

Paolo Bonzini <bonzini@gnu.org> wrote:
> This patch builds on the infrastructure for remote.<nick>.mirror and
> tweaks the behavior of "git push".  The idea is that "git push",
> "git push --all", "git push --mirror", instead of defaulting to origin,
> become DWIM commands:
> 
> - "git push" pushes to origin *and* to all mirrors
> 
> - "git push --all" pushes to origin with --all.  I didn't make it push
>   to mirrors because --all and --mirror are incompatible.
> 
> - "git push --mirror" only updates mirror repositories, without touching
>   origin.
> 
> This is useful when a project has a public repository managed by the
> integrator, but the integrator also wants to publish his own mirror
> somewhere.  In this case, the integrator will just do "git push".

Sorry, I don't really see a use case behind this.  `git push` today
will push to origin all branches that exist both locally and already
on the remote.  If you want to push to multiple locations, just
specify the other URLs in the remote.origin.url configuration list.
Linus added support for that years ago.

> Similarly, if a developer uses the integrator's repository but
> wishes to publish his own mirror somewhere, he can just do "git push
> --mirror".

Why not just have a remote named "my-mirror" and do `git push my-mirror`?
Yes, its on keystroke longer to type.  Call it foo.  `git push foo` would
be shorter, and not require code changes in Git.

-- 
Shawn.
