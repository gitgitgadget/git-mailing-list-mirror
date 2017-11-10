Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654D01F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbdKJNX0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:23:26 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56850 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbdKJNXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:23:25 -0500
Received: by mail-wm0-f66.google.com with SMTP id z3so2726878wme.5
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Zdye4zhFYqr/2BpjWdRx1TrHqLbViko/TWZSEtGnGA=;
        b=aQ+RnasLlShVdda3L6ODOtn0HiOBG8CWTZXqMZoE5PEvS0C3Jb92QOlbo8g1rtAC1x
         nBjwPeBZ48WJAOlewZdBtZWPW7ZZiqm7n3k6fNAx+gQtBNmwMuwddOAV4rg1YOdYKdal
         fkQZqHAE/Qk4YYdRjrEEvWDplK68Qjjl+vWon6d+FtpueQby8zX+qM77kbxTEu+CqOnQ
         w1gvKH2ZKn9HMhGahPbPmbltCmONu21stT+4EhhQWbz5xXScNAgJklViBwVviL2SKOtA
         eP9T+06foeYOaPpb3+vckVeDZj+D4yi6XQBhhNcg4pYG+EFpfuqe5rh4l0vVu6m8ct5J
         nUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Zdye4zhFYqr/2BpjWdRx1TrHqLbViko/TWZSEtGnGA=;
        b=FZPjAI7RMNkucD970CQpAHIWAftt6H0RtzDwkZiMG2wwV/XseB/HiRTBO+wWIpU3P+
         GGVQCK1jPaidFKx3g79jIxgVL4jot9bkXVmSK5c4nm10122yBB5+VnizzNTEWxD5mzFP
         +0TKGUGIeVyZeTOkLEbOBys11ff/OAPCL1EMfd+tdrd/3pitFPNMMc2Le0pTwY8qjLfC
         ffNW9a+26qfbaKCR73eUbKDLSDUQnd5e0Q7S3tzrP/MjjSgi2ZWwGD+kDMEyJar2hmjA
         zirKG3Zv33kjgOKAQ+JqjJ9V8SsRB9V6zNIVs3l4IbQeFC0b+areXfiIIS/aSohrtkNs
         CjWw==
X-Gm-Message-State: AJaThX7+lqbuke1tBseLkYB6iBw6QWF8/Nn0Y1FEyJrETchKms7lSq1a
        pT+gQsip6lDDSaINJPGkv9oS73OL
X-Google-Smtp-Source: AGs4zMbLgE8yR0zm3z+Cr1nctMlDBPFMhFIRlyweCSsWoMeKG0vnWedhL6GXYGPFIF1gwCNwGdfN1g==
X-Received: by 10.28.2.213 with SMTP id 204mr247702wmc.106.1510320203941;
        Fri, 10 Nov 2017 05:23:23 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:23:23 -0800 (PST)
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
Subject: [PATCH v3 7/8] t0021/rot13-filter: add capability functions
Date:   Fri, 10 Nov 2017 14:21:59 +0100
Message-Id: <20171110132200.7871-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org>
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
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
index 8f255b6131..6cd9ecffee 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -151,24 +151,56 @@ sub packet_initialize {
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
2.15.0.132.g7ad97d78be

