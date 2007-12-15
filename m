From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-svn: handle our top-level path is deleted and
	later re-added
Date: Sat, 15 Dec 2007 17:35:03 +0100
Message-ID: <20071215163503.GA25053@xp.machine.xx>
References: <475C8748.6000005@cryos.net> <20071210104235.GA7521@xp.machine.xx> <20071213164134.GD18433@soma> <20071213181312.GA4441@xp.machine.xx> <20071214163909.GA18300@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Marcus D. Hanwell" <marcus@cryos.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 17:35:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3ZzS-0004CD-7b
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 17:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbXLOQf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 11:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbXLOQf2
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 11:35:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:54313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317AbXLOQf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 11:35:27 -0500
Received: (qmail invoked by alias); 15 Dec 2007 16:35:23 -0000
Received: from p54AA80A6.dip0.t-ipconnect.de (EHLO localhost) [84.170.128.166]
  by mail.gmx.net (mp010) with SMTP; 15 Dec 2007 17:35:23 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18H4ap05toHMVfz1j+htaH4ziWN7mu9uUlPMDuXnA
	3M5fAWeIMyyd//
Content-Disposition: inline
In-Reply-To: <20071214163909.GA18300@soma>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68393>

On Fri, Dec 14, 2007 at 08:39:09AM -0800, Eric Wong wrote:
> Previously, git-svn would ignore cases where the path we're
> tracking is removed from the repository.  This was to prevent
> heads with follow-parent from ending up with a tree full of
> empty revisions (and thus breaking rename detection).
> 
> The previous behavior is fine until the path we're tracking
> is re-added later on, leading to the old files being merged
> in with the new files in the directory (because the old
> files were never marked as deleted)
> 
> We will now only remove all the old files locally that were
> deleted remotely iff we detect the directory we're in is being
> created from scratch.
> 
> Thanks for Marcus D. Hanwell for the bug report and
> Peter Baumann for the analysis.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
[...]

It seems to solve the problem seen in the avogadro repo. At least
the suspicious revisions I checked looked identical in the imported
version.

-Peter
