From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
Date: Thu,  3 Dec 2009 11:52:46 -0600
Message-ID: <cQVSAldE71QbE653CpBd7h4xSyLF0IW0Sr3unEDh7mhF8GHwF9Yy4OITTeQ_lmvCLmR9qnBq9a8@cipher.nrlssc.navy.mil>
References: <cQVSAldE71QbE653CpBd7qjd43g8URlxW7WO99KN4T0njgcXAbpAJQhTbfLeU5wxWrW84lsFVZE@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 18:53:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGFs5-0002hF-H5
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 18:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbZLCRxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 12:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbZLCRxM
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 12:53:12 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50547 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbZLCRxL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 12:53:11 -0500
Received: by mail.nrlssc.navy.mil id nB3HrDaL002966; Thu, 3 Dec 2009 11:53:13 -0600
In-Reply-To: <cQVSAldE71QbE653CpBd7qjd43g8URlxW7WO99KN4T0njgcXAbpAJQhTbfLeU5wxWrW84lsFVZE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 03 Dec 2009 17:53:13.0475 (UTC) FILETIME=[7BF3C530:01CA7441]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134462>

From: Brandon Casey <drafnel@gmail.com>

The '--no-chain-reply-to' option is a Getopt::Long boolean option. The
'--no-' prefix (as in --no-chain-reply-to) for boolean options is not
supported in Getopt::Long version 2.32 which was released with Perl 5.8.0.
This version only supports '--no' as in '--nochain-reply-to'.  More recent
versions of Getopt::Long, such as version 2.34, support either prefix. So
use the older form in the tests.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9001-send-email.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index fb51ab3..752adaa 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -827,7 +827,7 @@ test_expect_success 'no warning with an explicit --no-chain-reply-to' '
 	--dry-run \
 	--from="Example <nobody@example.com>" \
 	--to=nobody@example.com \
-	--no-chain-reply-to \
+	--nochain-reply-to \
 	outdir/000?-*.patch 2>errors >out &&
 	! grep "no-chain-reply-to" errors
 '
-- 
1.6.5.3
