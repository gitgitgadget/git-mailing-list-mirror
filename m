From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Implement "Stage/Unstage Line"
Date: Wed, 2 Jul 2008 01:23:42 -0400
Message-ID: <20080702052342.GN11793@spearce.org>
References: <48649519.1010307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 07:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDupm-0007z5-H2
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 07:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbYGBFXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 01:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbYGBFXr
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 01:23:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55376 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbYGBFXq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 01:23:46 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KDuoi-00048P-MI; Wed, 02 Jul 2008 01:23:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1063820FBAE; Wed,  2 Jul 2008 01:23:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48649519.1010307@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87085>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> From: Johannes Sixt <johannes.sixt@telecom.at>
> 
> This adds a context menu entry below "Stage/Unstage Hunk" that stages or
> unstages just the line under the mouse pointer.

Thanks!  After some brief testing this is in now my tree on repo.or.cz.
 
> 	Disclaimer: I'm Tcl/Tk illiterate. Feel free to munge the patch
> 	to your taste.

I wouldn't say illiterate, given this contribution.  :)
 
> 	The 'do_rescan' is probably a bit heavy-weight. But editing the
> 	diff window like we do in "Stage Hunk" would be a bit complex, and
> 	just redisplaying the diff is easier.

Yea, I see why you are doing a do_rescan at the end.  I was going
to suggest just calling reshow_diff but that doesn't get the lists
updated properly when a file is being initially staged as a result
of the current line being added.

Editing the Tk widget is possible, but it can be a pain.

> 	Furthermore, I don't know why I have to do the loop until
> 	"end - 1 chars". If it goes until "end", then the hunk contains
> 	an extra line, so that the patch in general does not apply.
> 	Is there an extra newline in the diff view that is not in the
> 	git diff output?

Yup.  Tk text widgets have an extra "\n" at the end of the content
that was inserted into it.  Thus an empty text widget has a single
LF as its content.  Weird, I know.
 
-- 
Shawn.
