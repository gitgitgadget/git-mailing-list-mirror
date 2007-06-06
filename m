From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] Add git-index-pack -l to list objects in a pack
Date: Thu, 07 Jun 2007 09:23:16 +1200
Message-ID: <466725C4.5090707@catalyst.net.nz>
References: <11811227811793-git-send-email-sam.vilain@catalyst.net.nz> <alpine.LFD.0.99.0706060952410.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw30q-00082U-IS
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933910AbXFFVZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934493AbXFFVZl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:25:41 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:49572 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933910AbXFFVZl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:25:41 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1Hw30R-0006Yz-07; Thu, 07 Jun 2007 09:25:27 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id EA25DCB9E8; Thu,  7 Jun 2007 09:25:26 +1200 (NZST)
In-Reply-To: <alpine.LFD.0.99.0706060952410.12885@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49317>

Nicolas Pitre wrote:
>> I couldn't figure out how to make git-unpack-objects -n work.
>> But it seems to be easy in the loop in index-pack
> 
> Why don't you simply use git-show-index?

Because I found the enticing -n switch in the documentation first?

That command certainly would have done the trick for what I needed it
to do.  Perhaps change the documentation of the switch?

Subject: [PATCH] fix documentation of unpack-objects -n

unpack-objects -n didn't print the object list as promised on the
manual page, so alter the documentation to reflect the behaviour
---
 Documentation/git-unpack-objects.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index ff6184b..b1b3ec9 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -27,8 +27,8 @@ new packs and replace existing ones.
 OPTIONS
 -------
 -n::
-        Only list the objects that would be unpacked, don't actually unpack
-        them.
+        Dry run.  Check the pack file without actually unpacking
+	the objects.
 
 -q::
 	The command usually shows percentage progress.  This
-- 
1.5.2.0.45.gfea6d-dirty
