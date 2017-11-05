Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26F220564
	for <e@80x24.org>; Sun,  5 Nov 2017 21:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbdKEViq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:38:46 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52970 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdKEVio (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id t139so10627845wmt.1
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qgqFDyFbVEazdj5N2GPaHfdyNG2mGVanS3j6BPjbHWU=;
        b=fdXi+8IXbJHrxAQtiyX/zqof8+WQpMNw69AL7kQH2t7K2d9hrOsxYs5L+XjNbhZeyr
         nc/Q4gNsd9ROJ0THu3YV0F1jImC7Tu4232wt+CNqIIhAcrACnK07D06Q+oBXVbaPrYtg
         hnfOgvUuNAOG9J4tYxWHg7yc1eQ2KQ7+xaoNkWSzoMCE7yHGJrISZDGHn2MRUswO4CKX
         H6e5E2ZXrqYFcGcTrLm+KPzPY6yBCR0sEJoILSUaWYepGsas5n4Kul6Uhv0HpDChFadh
         NEufqMHO1vaMxIbc/x8NCDAwnV3xxt8GYYY1aUfIGpjbZQYnoEsimd8X8at6A+2HcVqZ
         O2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qgqFDyFbVEazdj5N2GPaHfdyNG2mGVanS3j6BPjbHWU=;
        b=ZNY5+9m15DuezLQwRlvQzAN3ooe33myMpedSFymHdcx7LDJ78YhyQT0dnW677OFJMA
         sKgvIfM2oTQ4Lwx5eaHulxTGkB0KC/ciKZrBERxi95mN07FlwyQALoPaz1cHvM1m4WaD
         tra8djqAJDsklZi9CFHIHJR6Iba1KjaKgihz10YHMSB0UIFxPRtPure5H3YKyUGNIr7H
         f63iG6GHuR8d6uUpwOjGJABy2EqcBhaP4d5wpDKpnGFaMW5beDy6u+1Rc6TUyZ4MA2HW
         iJJopeyw2P3zDEZMJRWkuYnxbzoEPeuFJi6XSuOjWpULhXaFLeLbmGZCPZhx5MmQJWeW
         +xJA==
X-Gm-Message-State: AJaThX5C+PWpZ/cxlWyHXoJYomukaTyfYa4IWzmha6QzXH67LQzhJuhi
        SePt3GfhHJj0AtZwBzrbiEnclfdV
X-Google-Smtp-Source: ABhQp+TNeiJkE7ny9T6BQ6ezKhggRXBZEc9aH0/kIaKxslY4hOv/VgV0B3VP3LDWQTKAQ9aAuSLeRQ==
X-Received: by 10.28.24.70 with SMTP id 67mr3402911wmy.7.1509917922874;
        Sun, 05 Nov 2017 13:38:42 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:42 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/8] t0021/rot13-filter: fix list comparison
Date:   Sun,  5 Nov 2017 22:38:29 +0100
Message-Id: <20171105213836.11717-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
In-Reply-To: <20171105213836.11717-1-chriscool@tuxfamily.org>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since edcc8581 ("convert: add filter.<driver>.process
option", 2016-10-16) when t0021/rot13-filter.pl was created, list
comparison in this perl script have been quite broken.

packet_txt_read() returns a 2-element list, and the right hand
side of "eq" also has a list with (two, elements), but "eq" takes
the last element of the list on each side, and compares them. The
first elements (0 or 1) on the right hand side lists do not matter,
which means we do not require to see a flush at the end of the
version -- a simple empty string or an EOF would do, which is
definitely not what we want.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index ad685d92f8..4b2d9087d4 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -55,6 +55,20 @@ sub rot13 {
 	return $str;
 }
 
+sub packet_compare_lists {
+	my ($expect, @result) = @_;
+	my $ix;
+	if (scalar @$expect != scalar @result) {
+		return undef;
+	}
+	for ($ix = 0; $ix < $#result; $ix++) {
+		if ($expect->[$ix] ne $result[$ix]) {
+			return undef;
+		}
+	}
+	return 1;
+}
+
 sub packet_bin_read {
 	my $buffer;
 	my $bytes_read = read STDIN, $buffer, 4;
@@ -110,18 +124,25 @@ sub packet_flush {
 print $debug "START\n";
 $debug->flush();
 
-( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
-( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
+packet_compare_lists([0, "git-filter-client"], packet_txt_read()) ||
+	die "bad initialize";
+packet_compare_lists([0, "version=2"], packet_txt_read()) ||
+	die "bad version";
+packet_compare_lists([1, ""], packet_bin_read()) ||
+	die "bad version end";
 
 packet_txt_write("git-filter-server");
 packet_txt_write("version=2");
 packet_flush();
 
-( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=delay" ) )  || die "bad capability";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+packet_compare_lists([0, "capability=clean"], packet_txt_read()) ||
+	die "bad capability";
+packet_compare_lists([0, "capability=smudge"], packet_txt_read()) ||
+	die "bad capability";
+packet_compare_lists([0, "capability=delay"], packet_txt_read()) ||
+	die "bad capability";
+packet_compare_lists([1, ""], packet_bin_read()) ||
+	die "bad capability end";
 
 foreach (@capabilities) {
 	packet_txt_write( "capability=" . $_ );
-- 
2.15.0.7.ga9ff306ed9.dirty

