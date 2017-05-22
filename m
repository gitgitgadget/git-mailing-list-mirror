Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64A72023D
	for <e@80x24.org>; Mon, 22 May 2017 13:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933202AbdEVNuO (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 09:50:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35278 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759904AbdEVNuK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 09:50:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so13759695wmc.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v+xfbbVoOjF+S1W8inBt7UaDDyM9cwPXO6S+VvhteMw=;
        b=SSDe1gtsTPUHg52fODypMOwqlqHU0hcR2jhyYJXGd4OVG5hvzxfvZI+UaH8D+uQLUs
         ncnDcbxe7lcyZAs+9CNATEJcbVH22htu8o/U4UBFIE5orA83BJT1fStYPt6ZVFtvpo1x
         qYOsDDAeORKF/qJaDMQ0n6yMUhs1HQOs7s5lvucxNgk5jf8kQPHLvwabbCJcWFgUPiXF
         cc+zagDvRqHbHAXKnwgPWVTbJ1NxOPrjnu7+19NFfR7W5tZ2tVxY7MQpGNaY8nnRhYUu
         kH+a1xbiV5a+XryUouiO0RP+R+QspGGtfzym0/yI0ytQWZUSbUA314pqDhRZynbGp2oS
         hPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+xfbbVoOjF+S1W8inBt7UaDDyM9cwPXO6S+VvhteMw=;
        b=BdRVNLAyfkVX1r/+wKUDPqi7OEHy1vQRDAhbrJTYeSQM2M356CVk3JjWvUP3yQ3lqA
         lK7Lwrgh9OHm1qN/zo7SdVGe3/4nagYMm1O2bOiQRruqx19H7b8TyDNa5YN1p5WVv68r
         QVFbH6zbVLsRTo2ThScGKZ4yqkGvoxDIqRV4uoRMKEuFEbpcw/UOXzbK9dXZxn+fp9Lb
         aF5/PdPBOPQzXAOCVGrn/ZdWNJ2gAGJn8j0Ras/SW9F3A3r9crOFy5K8rbm/BQWs4yrN
         Yjbr4SA5HNOUofWxgwXq1gKFad5BgOc3Cded21DIOkNWEW9AYCLlucSEAJi4UrdBiLBL
         CvjA==
X-Gm-Message-State: AODbwcAcbqZwjL+vXqwwz4eZUSIoagwOqPb0ac5BMnF+p2tbXj8yklVm
        EcRdzOxf3R2p8g==
X-Received: by 10.28.58.143 with SMTP id h137mr24510522wma.72.1495461008623;
        Mon, 22 May 2017 06:50:08 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y3sm22638070wmh.21.2017.05.22.06.50.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 06:50:08 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com
Subject: [PATCH v4 3/4] t0021: write "OUT" only on success
Date:   Mon, 22 May 2017 15:50:00 +0200
Message-Id: <20170522135001.54506-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170522135001.54506-1-larsxschneider@gmail.com>
References: <20170522135001.54506-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"rot13-filter.pl" used to write "OUT <size>" to the debug log even in case of
an abort or error. Fix this by writing "OUT <size>" to the debug log only in
the successful case if output is actually written.

This is useful for the subsequent patch 'convert: add "status=delayed" to
filter process protocol'.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh   | 6 +++---
 t/t0021/rot13-filter.pl | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 0139b460e7..0c04d346a1 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -588,7 +588,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge smudge-write-fail.r $SF [OK] -- OUT: $SF [WRITE FAIL]
+			IN: smudge smudge-write-fail.r $SF [OK] -- [WRITE FAIL]
 			START
 			init handshake complete
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
@@ -634,7 +634,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
+			IN: smudge error.r $SE [OK] -- [ERROR]
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
@@ -673,7 +673,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
+			IN: smudge abort.r $SA [OK] -- [ABORT]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 0b943bb377..5e43faeec1 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -153,9 +153,6 @@ while (1) {
 		die "bad command '$command'";
 	}
 
-	print $debug "OUT: " . length($output) . " ";
-	$debug->flush();
-
 	if ( $pathname eq "error.r" ) {
 		print $debug "[ERROR]\n";
 		$debug->flush();
@@ -178,6 +175,9 @@ while (1) {
 			die "${command} write error";
 		}
 
+		print $debug "OUT: " . length($output) . " ";
+		$debug->flush();
+
 		while ( length($output) > 0 ) {
 			my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
 			packet_bin_write($packet);
-- 
2.13.0

