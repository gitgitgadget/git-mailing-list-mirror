Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C6C207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 19:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425486AbdDUTon (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 15:44:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36772 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425469AbdDUTol (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 15:44:41 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so4815083wrc.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlqoCi4Qi48d8YSr10oObUmSbhIhdspr9g3Eyk2QMtk=;
        b=sjKV5xoAV446GoJPwsGETlABFrrVYyuKUkveJYAL1ySlCW//HBH8CV3SIDQCE9LM7v
         HeZ2HtnTPYSF79HiXUCwnTEzwyJRv34/XkbQdkhUEfzP490vsyLEwuHaB7ik4FRsvhzy
         vFmjOQ0Ky5jBk7vb0rzp6rtr8iKFwep6GFRouY0OuSo5n837LNM5JjTxmuhf7G4/gI8p
         SsIm6Z8/e0dLQ3lJJOeV4AXmuGDyGm9NlX11j+kBSTSXux7z89qWT/WvLi/Ia4IilZ6P
         9EuedN0qzO90CA4UG6f1rXkm/ncc+Sgn5RRXOYN1caRrGkH4BvzRYUqgshP2dBcp2LBH
         sqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlqoCi4Qi48d8YSr10oObUmSbhIhdspr9g3Eyk2QMtk=;
        b=BVpKs3lWDkIKhwD/T1kpWQmGuHw4DMmpcWiydZDqv63g8X93vp8AiMJmpNg9nPpnFI
         MnL110jHcxe4MLrSk5adZUYhbbj08hUiSPuoSKDL6qvbWVhfGNTy3r21X2w96fx/R0P9
         /20tNAFWvkjsPxLESqFWFpSfGKPICQKxS+cOMeADgJ9NWtZsBE50LPW5LFzwGcbBKIHg
         WElT2jWswqMLA05KXhT0keA4RCSJZPRA06+LwpYNWnwRj5TtdkeAU9mfaWT3wjJlNFI9
         NkM2aj25nGHYmPDyfg3j3hCfsiS3DP9Eizy/JGFdo558kJ832skxD7gdVQ/n+QDNPBof
         Hmyw==
X-Gm-Message-State: AN3rC/5dn0HKBZ/L2in0DeBrbuns6Jmml96tJ5L5O2TKxaA33uCx4Ksb
        uwPs/i78Naiiaff+CbQ=
X-Received: by 10.223.172.2 with SMTP id v2mr7158929wrc.112.1492803879517;
        Fri, 21 Apr 2017 12:44:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w186sm3076475wme.26.2017.04.21.12.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Apr 2017 12:44:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t/perf: correctly align non-ASCII descriptions in output
Date:   Fri, 21 Apr 2017 19:44:28 +0000
Message-Id: <20170421194428.1377-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test descriptions from being treated as binary blobs by
perl to being treated as UTF-8. This ensures that e.g. a test
description like "æ" is counted as 1 character, not 2.

I have WIP performance tests for non-ASCII grep patterns on another
topic that are affected by this.

Now instead of:

    $ ./run p0000-perf-lib-sanity.sh
    [...]
    0000.4: export a weird var                                    0.00(0.00+0.00)
    0000.5: éḿíẗ ńöń-ÁŚĆÍÍ ćḧáŕáćẗéŕś   0.00(0.00+0.00)
    0000.7: important variables available in subshells            0.00(0.00+0.00)
    [...]

We emit:

    [...]
    0000.4: export a weird var                                 0.00(0.00+0.00)
    0000.5: éḿíẗ ńöń-ÁŚĆÍÍ ćḧáŕáćẗéŕś                          0.00(0.00+0.00)
    0000.7: important variables available in subshells         0.00(0.00+0.00)
    [...]

Fixes code originally added in 342e9ef2d9 ("Introduce a performance
testing framework", 2012-02-17).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/aggregate.perl           | 3 +++
 t/perf/p0000-perf-lib-sanity.sh | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 924b19dab4..1dbc85b214 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -88,6 +88,7 @@ for my $t (@tests) {
 sub read_descr {
 	my $name = shift;
 	open my $fh, "<", $name or return "<error reading description>";
+	binmode $fh, ":utf8" or die "PANIC on binmode: $!";
 	my $line = <$fh>;
 	close $fh or die "cannot close $name";
 	chomp $line;
@@ -147,6 +148,8 @@ for my $t (@subtests) {
 my $totalwidth = 3*@dirs+$descrlen;
 $totalwidth += $_ for (@colwidth);
 
+binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
+
 printf "%-${descrlen}s", "Test";
 for my $i (0..$#dirs) {
 	my $d = $dirs[$i];
diff --git a/t/perf/p0000-perf-lib-sanity.sh b/t/perf/p0000-perf-lib-sanity.sh
index cf8e1efce7..002c21e52a 100755
--- a/t/perf/p0000-perf-lib-sanity.sh
+++ b/t/perf/p0000-perf-lib-sanity.sh
@@ -33,6 +33,8 @@ test_perf 'export a weird var' '
 	test_export bar
 '
 
+test_perf 'éḿíẗ ńöń-ÁŚĆÍÍ ćḧáŕáćẗéŕś' 'true'
+
 test_expect_success 'test_export works with weird vars' '
 	echo "$bar" &&
 	test "$bar" = "weird # variable"
-- 
2.11.0

