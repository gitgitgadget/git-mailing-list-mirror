From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 2/5] t5512 (ls-remote): modernize style
Date: Fri,  2 Mar 2012 18:15:34 -0800
Message-ID: <1330740942-25130-3-git-send-email-tmgrennan@gmail.com>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:16:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3eWe-0001tn-4d
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab2CCCQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:16:33 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37868 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2CCCQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:16:00 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so2055487vbb.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:16:00 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.95.74 as permitted sender) client-ip=10.52.95.74;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.95.74 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.95.74])
        by 10.52.95.74 with SMTP id di10mr20299120vdb.46.1330740960265 (num_hops = 1);
        Fri, 02 Mar 2012 18:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=DqripzCL7+49GRHw09oLzJqjn/WGcb19VQDJ/P46j3s=;
        b=Y32mJyqyYMiQNtm3etwU8inehJh4QgJ2o8U2mnLWr5iv6ZbXN5L8vn1QTWaWOmdCz+
         2k2Ll5rwGDOhEvF/Oe/3aK0rnVgNh0l1mv54stZxom0ryOcFD9cFEbrca3clu7yYU/q/
         Tfohb2zc9kyMT9lAd/vwD7iAu4I70pcb1pJu0O2fC1KAJQWewLutyKVGvN2/eDB15mFb
         nbuFAcRaWKzr+NPamhJuINBfF3wDjlpgeCn/u5rQLZhVf7Wj6Z2uvwJ7jtvOphUBbF0C
         7/duPzOlgZrDJkB1i2pqM6mePt4Ea9wkBFrzAPMXn2l9Y6ei8AyEJGX1nKc3oyPOPuPl
         KsTw==
Received: by 10.52.95.74 with SMTP id di10mr17321090vdb.46.1330740960226;
        Fri, 02 Mar 2012 18:16:00 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id e10sm11763981vdj.21.2012.03.02.18.15.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:15:59 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192080>

Guard setup with test_expect_success

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t5512-ls-remote.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 5c546c9..811dcc3 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -102,11 +102,13 @@ test_expect_success 'use branch.<name>.remote if possible' '
 
 '
 
-cat >exp <<EOF
-fatal: 'refs*master' does not appear to be a git repository
-fatal: The remote end hung up unexpectedly
-EOF
 test_expect_success 'confuses pattern as remote when no remote specified' '
+	'"
+	cat >exp <<-EOF
+		fatal: 'refs*master' does not appear to be a git repository
+		fatal: The remote end hung up unexpectedly
+	EOF
+	"'
 	#
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote, correctly,
 	# confuses <pattern> for <remote>. Although ugly, this behaviour is akin
-- 
1.7.8
