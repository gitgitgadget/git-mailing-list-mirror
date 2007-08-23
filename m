From: bdowning@lavos.net (Brian Downing)
Subject: [BUG] git-gui: "Stage Hunk For Commit" doesn't work at all anymore
Date: Thu, 23 Aug 2007 15:30:24 -0500
Message-ID: <20070823203024.GF21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:30:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJKE-00016A-Hg
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758216AbXHWUaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 16:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758648AbXHWUaf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:30:35 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:43797 "EHLO
	asav01.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757759AbXHWUaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:30:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAOqKzUZKhvbz/2dsb2JhbAA
X-IronPort-AV: E=Sophos;i="4.19,301,1183348800"; 
   d="scan'208";a="72446870"
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav01.insightbb.com with ESMTP; 23 Aug 2007 16:30:34 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 7E8A9309F21; Thu, 23 Aug 2007 15:30:24 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56525>

This commit:

commit a13ee29b975d3a9a012983309e842d942b2bbd44
Author: Shawn O. Pearce <spearce@spearce.org>
Date:   Thu Aug 2 22:55:22 2007 -0400

    git-gui: Avoid Tcl error in popup menu on diff viewer

    If there is no path currently shown in the diff viewer then we
    were getting Tcl errors anytime the user right-clicked on the
    diff viewer to bring up its popup menu.  The bug here is caused
    by trying to get the file_state for the empty string; this path
    is never seen so we never have file_state for it.  In such cases
    we now disable the Stage Hunk For Commit option.

    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

seems to have broken the "Stage Hunk For Commit" option entirely for me
-- it is now disabled whether or not there is a patch in the viewer.

-bcd
