From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/6] Teach git-describe --exact-match to avoid expensive tag searches
Date: Sun, 24 Feb 2008 05:32:23 -0500
Message-ID: <20080224103223.GI8410@spearce.org>
References: <20080224080731.GE22587@spearce.org> <m3skzibqjo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 11:33:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTEAQ-000786-Ht
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 11:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbYBXKc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 05:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbYBXKc2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 05:32:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36253 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbYBXKc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 05:32:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTE9e-0008Ba-GD; Sun, 24 Feb 2008 05:32:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6F99220FBAE; Sun, 24 Feb 2008 05:32:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <m3skzibqjo.fsf@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74921>

Jakub Narebski <jnareb@gmail.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >  A common idiom is to run git-describe twice:
> > 
> >   if test $(git describe $commit) = $(git describe --abbrev=0 $commit)
> >   ...
> 
> Wouldn't it be easier to use?
> 
>     if test $(git rev-parse $(git describe --abbrev=0 $commit)^0) = $commit
> 
> But this is also one unnecessary, although not as costly, call to git
> command.

Yea, that's the other way I've done this in a script before.  But
its obtuse and non-obvious.  --exact-match is a little easier to
figure out.  :-)

-- 
Shawn.
