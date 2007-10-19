From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 20:24:51 -0400
Message-ID: <20071019002451.GQ14735@spearce.org>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se> <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: joakim.tjernlund@transmode.se, git <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiffm-0007GE-Q2
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbXJSAYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXJSAYz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:24:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39231 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbXJSAYz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:24:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiffL-00085G-0s; Thu, 18 Oct 2007 20:24:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A511620FBAE; Thu, 18 Oct 2007 20:24:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61582>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Oct 18, 2007, at 4:50 PM, Joakim Tjernlund wrote:
> >
> ># > git push ssh://devsrv/var/git/os2kernel.git linus:refs/linus
...
> >error: refusing to create funny ref 'refs/linus' locally
> >ng refs/linus funny refname
> >error: failed to push to 'ssh://devsrv/var/git/os2kernel.git'
...
> You may need to cleanup though. I'm not sure if the remote side
> already created 'refs/linus'. The error message only indicates that
> locally git refused to create the "funny refname".

Cute.  The error message "error: refusing to create .. locally"
is actually coming from the remote site.  Locally here is
actually remotely.  We *really* should change that.  Its l.169 of
receive-pack.c, which is only running on the remote side.  :)

Anyone game to improve that error message?  Should be a pretty
simple patch.  One of the may low-hanging fruits in Git.

-- 
Shawn.
