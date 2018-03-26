Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D2C1F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeCZHZA (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:25:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38348 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeCZHY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:24:58 -0400
Received: by mail-wr0-f196.google.com with SMTP id m13so4443795wrj.5
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eg0Iqx+lGybFeJFaPqzQcbG73opvK4nGSSaVBpGqG5U=;
        b=YV4qq4FsSB0paUX7186Ih9u1bayi33ut/NcglmjpkkYvHsRCw4oOnggxn3o7L87YcN
         UAWge9RMGtBJ98NK28TsaaejbJUQqqopYRKQzdPj6cVdbS4pVf9lh8/msFiFa9AbZvId
         +odCXPbWG7rXCQgSeNdRFJ8ugYri7ULue5thHLV5aSKBR28qrQ9E4MgoVP1zgWgVWDoi
         AfcVcyewDQR3Hn1/nswClcKAyl65zqAhAh4K7I5oIIE5ounWtAKHgn+N/JYDQ/lTqbmB
         jhvDtWvuzm6yLzRJEewWjHnSldern+MoGi3Po/PRlO80Vi8OX6pCHi6gyJbMC0t7DSEU
         6GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eg0Iqx+lGybFeJFaPqzQcbG73opvK4nGSSaVBpGqG5U=;
        b=i/ZtgJnNLCH8ppBKh4ynNa/pOZEnSn3QM8gGgILCm4bbih5qQR6PjPMq+4zz/hN/Wg
         40jp3m6rQhZVXXHskGFjDepKF+71Vub260pC/343TJ8LqeZN1qKxCZDIxHoBctOfPb8I
         YMn2K7vWqe0ttqUePjg86+uqCFF7HjgJViAmES4wfJEHARHrW8vhvdAai80I+N5XcSKL
         kWw29Ys5+9R2AlKldtQ2rIWmdnfG/iEFP9eYHit0HFnGdZMOxSyziM+NYMdT8eNu0V87
         QImgU64/4eNWcGiYWtf9DRJV2EQP7tVHM7TA+CCt9omXwdxsbZ53e8CZ6taFGd24nyEf
         xXpg==
X-Gm-Message-State: AElRT7HmbsKXj0Scl+WKtc6RR9NoxFt3GNxeCB8tX/HWP0WsmLKo1T1T
        ec6Fq6PaMqnqau37d3vxVrYWN6Z2
X-Google-Smtp-Source: AG47ELsMbTfzSfBcC53rcyrO6g2UOi9eff9/RucfSqy1i12QXzj93u18rx0Cmdn4c3eL9erFwEn+Zw==
X-Received: by 10.223.172.236 with SMTP id o99mr25587500wrc.36.1522049096699;
        Mon, 26 Mar 2018 00:24:56 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u8sm2820922wmf.2.2018.03.26.00.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 00:24:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 1/2] perf/aggregate: add display_dir()
Date:   Mon, 26 Mar 2018 09:24:30 +0200
Message-Id: <20180326072431.30771-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc1.36.g098d832c9.dirty
In-Reply-To: <20180326072431.30771-1-chriscool@tuxfamily.org>
References: <20180326072431.30771-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new helper function will be reused in a subsequent
commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 821cf1498b..890d85fa7b 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -147,6 +147,11 @@ sub have_slash {
 	return 0;
 }
 
+sub display_dir {
+	my ($d) = @_;
+	return exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d};
+}
+
 sub print_default_results {
 	my %descrs;
 	my $descrlen = 4; # "Test"
@@ -168,8 +173,7 @@ sub print_default_results {
 	my %times;
 	my @colwidth = ((0)x@dirs);
 	for my $i (0..$#dirs) {
-		my $d = $dirs[$i];
-		my $w = length (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
+		my $w = length display_dir($dirs[$i]);
 		$colwidth[$i] = $w if $w > $colwidth[$i];
 	}
 	for my $t (@subtests) {
@@ -188,8 +192,7 @@ sub print_default_results {
 
 	printf "%-${descrlen}s", "Test";
 	for my $i (0..$#dirs) {
-		my $d = $dirs[$i];
-		printf "   %-$colwidth[$i]s", (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
+		printf "   %-$colwidth[$i]s", display_dir($dirs[$i]);
 	}
 	print "\n";
 	print "-"x$totalwidth, "\n";
-- 
2.17.0.rc1.36.g098d832c9.dirty

