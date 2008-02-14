From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH RESEND 0/6] Sideband support in push (send-pack/receive-pack)
Date: Thu, 14 Feb 2008 01:22:02 -0500
Message-ID: <20080214062202.GI24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 07:22:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXUd-0002sF-9F
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbYBNGWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbYBNGWL
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:22:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58300 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYBNGWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:22:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXU0-0003mK-CY
	for git@vger.kernel.org; Thu, 14 Feb 2008 01:22:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7E17E20FBAE; Thu, 14 Feb 2008 01:22:03 -0500 (EST)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73849>

This series adds the same sort of sideband channel we use in fetch
(fetch-pack/upload-pack) to pass progress messages back to the
client from the server side.

  1)  Allow run_command stdout_to_stderr when stderr is a pipe
  2)  Automatically close stderr pipes created by run_command
  3)  Refactor packet_write to prepare to integrate with sideband
  4)  Refactor send-pack/receive-pack capability handshake for extension
  5)  Add side-band-64k extension to send-pack/receive-pack for hook output
  6)  Redirect receive-pack hook output into sideband channel

I didn't really see any comments from the list on this topic the
last time I posted it for comment, so here is a rebased version
on current master.

-- 
Shawn.
