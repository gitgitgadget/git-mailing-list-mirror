From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/3] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Wed, 22 Dec 2010 15:58:53 -0800
Message-ID: <jpN7nm-rtl4sNXi5qt9pXHOvlLOZP9xRq2h9eZev444l6GTi02jDn5C-Llxwsz3_tVhVKGvU5Vryto5cM6uchw@cipher.nrlssc.navy.mil>
References: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 23 01:22:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYwR-0002g6-LD
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 01:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab0LWAVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 19:21:55 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57131 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab0LWAVw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 19:21:52 -0500
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Dec 2010 19:21:50 EST
Received: by mail.nrlssc.navy.mil id oBMNxSP1032019; Wed, 22 Dec 2010 17:59:28 -0600
In-Reply-To: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Dec 2010 23:59:28.0300 (UTC) FILETIME=[4497F6C0:01CBA234]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164114>

From: Brandon Casey <drafnel@gmail.com>

The '--no-chain-reply-to' option is a Getopt::Long boolean option. The
'--no-' prefix (as in --no-chain-reply-to) for boolean options is not
supported in Getopt::Long version 2.32 which was released with Perl 5.8.0.
This version only supports '--no' as in '--nochain-reply-to'.  More recent
versions of Getopt::Long, such as version 2.34, support either prefix. So
use the older form in the tests.

See also:

907a0b1e04ea31cb368e9422df93d8ebb0187914
84eeb687de7a6c7c42af3fb51b176e0f412a979e
3fee1fe87144360a1913eab86af9ad136c810076

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9001-send-email.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 5e48318..1dc4a92 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -319,7 +319,7 @@ test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
-		--no-chain-reply-to \
+		--nochain-reply-to \
 		--in-reply-to="$(cat expect)" \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches $patches $patches \
-- 
1.7.3.1
