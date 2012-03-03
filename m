From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2-w 102/105] t5512 (ls-remote): modernize style
Date: Fri,  2 Mar 2012 18:15:39 -0800
Message-ID: <1330740942-25130-8-git-send-email-tmgrennan@gmail.com>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:17:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3eX3-00026b-8E
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab2CCCQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:16:40 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48188 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2CCCQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:16:12 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2024061vcq.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:16:12 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.38.102 as permitted sender) client-ip=10.52.38.102;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.38.102 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.38.102])
        by 10.52.38.102 with SMTP id f6mr20669399vdk.70.1330740972459 (num_hops = 1);
        Fri, 02 Mar 2012 18:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=QN1UaEucexhuTaGe3k8NOhaPNYzH03RrdHrJzOFPPpk=;
        b=TA8rSPbfxCP/QQlGSs6VzjJbRGA/Lxs0HS+WdIsERI85K/5idAN+XtBEzBiPnWJF0k
         blDWQwISF59jfrBwJD3W53oNZlep1ugc4qh6Gb7JRaHXn1JkrgpJSgKI4MqBi6oog9LR
         K87BY0/nesJpezKgTjyeE+FTLzKIusN8v2O5MJNyGLjqwqVPgDjh02OeciBf9TDLHSqP
         2tzgAqfFXRlhOAO0EPeP8upmkbSvdCK+Z5f1Czg9Frm6PSs3I9S+O0f5EBCvmSaddrQh
         KwmDA/g/NQX0n3HBXIElWA3f1jmvJlcrm6RHx2l+4VR04YkZfn7wQum323lfPZM2fnZ7
         zI0A==
Received: by 10.52.38.102 with SMTP id f6mr17648360vdk.70.1330740972424;
        Fri, 02 Mar 2012 18:16:12 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id e10sm11763981vdj.21.2012.03.02.18.16.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:16:11 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192088>

Guard setup with test_expect_success

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t5512-ls-remote.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 5c546c9..811dcc3 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -102,11 +102,13 @@ test_expect_success 'use branch.<name>.remote if possible' '
 
 '
 
-cat >exp <<EOF
+test_expect_success 'confuses pattern as remote when no remote specified' '
+	'"
+	cat >exp <<-EOF
 fatal: 'refs*master' does not appear to be a git repository
 fatal: The remote end hung up unexpectedly
 EOF
-test_expect_success 'confuses pattern as remote when no remote specified' '
+	"'
 	#
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote, correctly,
 	# confuses <pattern> for <remote>. Although ugly, this behaviour is akin
-- 
1.7.8
