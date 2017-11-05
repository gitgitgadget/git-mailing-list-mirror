Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C71420281
	for <e@80x24.org>; Sun,  5 Nov 2017 21:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdKEVjH (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:39:07 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56429 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdKEViw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id z3so10586210wme.5
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G2pKQdXV0MNzOC6cWO1YuB9J89KFxKo0DsXB46QDlok=;
        b=nw3IgCb7Z/VSCxMOdpBSEFrskE517u+Ye6ByWpXorUgXOH3RxSPSwUEC4RdSPbIDrD
         RvwkudGUKRbvj8j/xqCFmsoXigcsl6mdBlC9dfDqBXa2081x3E/ws8ajFyDVNOuTy6jQ
         NPC2rDv+aeCEn16j8j9/Axx6ou2MSImzd/hhezYQ2Tg4ddXhtchWOSfZnQ6c/mv9qLQ/
         zKBj421Qm4pmXIQ34o8EkFMH9iVtoA82YBqqBK5he93DevD4sadSAfRL8h+XYkIeP5SG
         OI+DgCs8CyjmKNXRY4uPuAsGwhEHIBfJv/yztabvAbNPdPQf+8RuUdo9b90+PmVsolqZ
         j/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G2pKQdXV0MNzOC6cWO1YuB9J89KFxKo0DsXB46QDlok=;
        b=fg9LxPRxDhA7W2W0FHykoQpOOOEFIMXQtxMjFGj7m1Yr2sMsMIjZrnY7USMsUQT9il
         c9eLv8OgFcQP8y4m99ZGQ7NDu6Z6PtJO/WewBOf6hD6pfN4czLTE6ZWzkHekCUWjPw3G
         8lXs7aotBYcxN4++EAkLYpARA1NTXyoKP8Lwj1vWUR9z5yG4eZ77B9dnBqJiK15bwvye
         5X0KJIgF7tEpceV3zcNnF+RnXG2oaCMdOaIWBo0n1HXBhFFcD0i0Rgu8lbj6yLKBcjPi
         Olo78HFfEIy9G+KK13/JNjdDWoJiPvcin6j+dkxFKr31GUlUvc55vnCMWN2czPlLNWOa
         Q1Eg==
X-Gm-Message-State: AJaThX4Zn/rZKTSsScf1BUAVqxEFlekqmqYF7QLbvZKkVstmTONToGj6
        s4buQ/RjBDfkHdbSHKcx7Uj8uHoL
X-Google-Smtp-Source: ABhQp+SA5T4CWZ1ZuQUpCxkIqTUVDHidRXM+LJJ7fPvlgAD2sMLaKDNddIw0XaHmUBGwAVjkE7473A==
X-Received: by 10.28.223.132 with SMTP id w126mr4048062wmg.39.1509917930997;
        Sun, 05 Nov 2017 13:38:50 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:50 -0800 (PST)
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
Subject: [PATCH v2 7/8] t0021/rot13-filter: add capability functions
Date:   Sun,  5 Nov 2017 22:38:35 +0100
Message-Id: <20171105213836.11717-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
In-Reply-To: <20171105213836.11717-1-chriscool@tuxfamily.org>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These function help read and write capabilities.

To make them more generic and make it easy to reuse them,
the following changes are made:

- we don't require capabilities to come in a fixed order,
- we allow duplicates,
- we check that the remote supports the capabilities we
  advertise,
- we don't check if the remote declares any capability we
  don't know about.

The reason behind the last change is that the protocol
should work using only the capabilities that both ends
support, and it should not stop working if one end starts
to advertise a new capability.

Despite those changes, we can still require a set of
capabilities, and die if one of them is not supported.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 58 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index d47b7f5666..f919d798a6 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -150,24 +150,56 @@ sub packet_initialize {
 	packet_flush();
 }
 
+sub packet_read_capabilities {
+	my @cap;
+	while (1) {
+		my ( $res, $buf ) = packet_bin_read();
+		if ( $res == -1 ) {
+			die "unexpected EOF when reading capabilities";
+		}
+		return ( $res, @cap ) if ( $res != 0 );
+		$buf = remove_final_lf_or_die($buf);
+		unless ( $buf =~ s/capability=// ) {
+			die "bad capability buf: '$buf'";
+		}
+		push @cap, $buf;
+	}
+}
+
+# Read remote capabilities and check them against capabilities we require
+sub packet_read_and_check_capabilities {
+	my @required_caps = @_;
+	my ($res, @remote_caps) = packet_read_capabilities();
+	my %remote_caps = map { $_ => 1 } @remote_caps;
+	foreach (@required_caps) {
+		unless (exists($remote_caps{$_})) {
+			die "required '$_' capability not available from remote" ;
+		}
+	}
+	return %remote_caps;
+}
+
+# Check our capabilities we want to advertise against the remote ones
+# and then advertise our capabilities
+sub packet_check_and_write_capabilities {
+	my ($remote_caps, @our_caps) = @_;
+	foreach (@our_caps) {
+		unless (exists($remote_caps->{$_})) {
+			die "our capability '$_' is not available from remote"
+		}
+		packet_txt_write( "capability=" . $_ );
+	}
+	packet_flush();
+}
+
 print $debug "START\n";
 $debug->flush();
 
 packet_initialize("git-filter", 2);
 
-packet_compare_lists([0, "capability=clean"], packet_txt_read()) ||
-	die "bad capability";
-packet_compare_lists([0, "capability=smudge"], packet_txt_read()) ||
-	die "bad capability";
-packet_compare_lists([0, "capability=delay"], packet_txt_read()) ||
-	die "bad capability";
-packet_compare_lists([1, ""], packet_bin_read()) ||
-	die "bad capability end";
-
-foreach (@capabilities) {
-	packet_txt_write( "capability=" . $_ );
-}
-packet_flush();
+my %remote_caps = packet_read_and_check_capabilities("clean", "smudge", "delay");
+packet_check_and_write_capabilities(\%remote_caps, @capabilities);
+
 print $debug "init handshake complete\n";
 $debug->flush();
 
-- 
2.15.0.7.ga9ff306ed9.dirty

