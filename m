From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t9001: use older Getopt::Long boolean prefix '--no' rather
 than '--no-'
Date: Fri, 10 Oct 2008 19:21:34 -0500
Message-ID: <zAKaSrh5XLrzXloxZrj-A1EletXL_wuSGpTQgLXMT3MZYK_o3tUBfA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 02:22:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoSFv-00079c-Qm
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 02:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbYJKAVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 20:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbYJKAVh
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 20:21:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52397 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbYJKAVg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 20:21:36 -0400
Received: by mail.nrlssc.navy.mil id m9B0LZVq022432; Fri, 10 Oct 2008 19:21:35 -0500
X-OriginalArrivalTime: 11 Oct 2008 00:21:35.0038 (UTC) FILETIME=[51AEDDE0:01C92B37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97957>

Since dbf5e1e9, the '--no-validate' option is a Getopt::Long boolean
option. The '--no-' prefix (as in --no-validate) for boolean options
is not supported in Getopt::Long version 2.32 which was released with
Perl 5.8.0. This version only supports '--no' as in '--novalidate'.
More recent versions of Getopt::Long, such as version 2.34, support
either prefix. So use the older form in the tests.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9001-send-email.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d098a01..561ae7d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -109,7 +109,7 @@ test_expect_success 'allow long lines with --no-validate' '
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		--no-validate \
+		--novalidate \
 		$patches longline.patch \
 		2>errors
 '
-- 
1.6.0.2.468.gd5b83
