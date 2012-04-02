From: Sebastian Pipping <sebastian@pipping.org>
Subject: [PATCH] Gitweb: Fix unintended "--no-merges" for regular Atom feed
Date: Mon, 02 Apr 2012 18:44:29 +0200
Message-ID: <4F79D76D.80805@pipping.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040707080301070106000703"
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:51:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEkTv-0002QC-Ly
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab2DBQvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 12:51:42 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:33390 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2DBQvk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 12:51:40 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Apr 2012 12:51:40 EDT
Received: from [85.177.89.251] (helo=[192.168.1.2])
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <sebastian@pipping.org>)
	id 1SEkNO-0002cW-JY
	for git@vger.kernel.org; Mon, 02 Apr 2012 18:45:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120402 Thunderbird/11.0.1
X-Df-Sender: aGFydHdvcmtAYmluZXJhLmRl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194535>

This is a multi-part message in MIME format.
--------------040707080301070106000703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello!


Please excuse that I send the patch as an attachment and consider
application.  Thanks!

Best,



Sebastian

--------------040707080301070106000703
Content-Type: text/x-patch;
 name="0001-Gitweb-Fix-unintended-no-merges-for-regular-Atom-fee.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Gitweb-Fix-unintended-no-merges-for-regular-Atom-fee.pa";
 filename*1="tch"

>From 03bed689671df47040c4a0ad158c0c9b039a50bf Mon Sep 17 00:00:00 2001
From: Sebastian Pipping <sebastian@pipping.org>
Date: Mon, 2 Apr 2012 18:39:48 +0200
Subject: [PATCH] Gitweb: Fix unintended "--no-merges" for regular Atom feed

Before:
<link rel="alternate" title="[..] - Atom feed" href="/?p=.git;a=atom;opt=--no-merges" type="application/atom+xml" />
<link rel="alternate" title="[..] - Atom feed (no merges)" href="/?p=.git;a=atom;opt=--no-merges" type="application/atom+xml" />

After:
<link rel="alternate" title="[..] - Atom feed" href="/?p=.git;a=atom;opt=" type="application/atom+xml" />
<link rel="alternate" title="[..] - Atom feed (no merges)" href="/?p=.git;a=atom;opt=--no-merges" type="application/atom+xml" />
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..cc45ae3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3886,6 +3886,7 @@ sub print_feed_meta {
 				'-type' => "application/$type+xml"
 			);
 
+			$href_params{'extra_options'} = '';
 			$href_params{'action'} = $type;
 			$link_attr{'-href'} = href(%href_params);
 			print "<link ".
-- 
1.7.8.5


--------------040707080301070106000703--
