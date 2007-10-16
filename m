From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 03:17:08 -0400
Message-ID: <E1Ihgfs-0004DL-S5@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org> <47145D6D.80001@viscovery.net>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: barkalow@iabervon.org, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, ae@op5.se, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:17:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihgg6-0002Ol-SL
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758513AbXJPHRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758038AbXJPHRL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:17:11 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:46685 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbXJPHRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:17:10 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1Ihgfs-0004DL-S5; Tue, 16 Oct 2007 03:17:08 -0400
In-reply-to: <47145D6D.80001@viscovery.net> (message from Johannes Sixt on
	Tue, 16 Oct 2007 08:42:53 +0200)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61101>

> Date: Tue, 16 Oct 2007 08:42:53 +0200
> From: Johannes Sixt <j.sixt@viscovery.net>
> Cc: Daniel Barkalow <barkalow@iabervon.org>, raa.lkml@gmail.com,
> 	Johannes.Schindelin@gmx.de, ae@op5.se,
> 	Benoit SIGOURE <tsuna@lrde.epita.fr>,
> 	"git@vger.kernel.org >> Git Mailing List" <git@vger.kernel.org>,
> 	Make Windows <make-w32@gnu.org>
> 
> Thanks to Marius Storm-Olsen we already have a stat replacement that's twice 
> as fast as msvcrt's stat. I calls only one API function 
> (GetFileAttributesEx, but of course I don't know what's going on under its 
> hood), because we need only a small part of struct stat filled in correctly.

Yes, I've seen that.  What I'm saying is that you can combine
`readdir' with `stat' in one API call (FindFirstFile/FindNextFile),
which will both read the directory and return you the attributes you
get from `stat'.  Think about `readdir' that brings you mode bits and
modification time together with the name, as some modern systems do.
