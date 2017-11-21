Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C112036D
	for <e@80x24.org>; Tue, 21 Nov 2017 16:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdKUQJ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 11:09:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46886 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdKUQJw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 11:09:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id u83so4534273wmb.5
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 08:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0GZPXB8TNZDacR1Sr2a8hUmgwJNN2vonCXFQQB38Zc=;
        b=ieacXDXXFpdZWj5Er9Z31PGDRVc6OB9Zbeq4kzgO30PulUBCQwSfJNNcEaLnmcrs3Y
         kiAnlYAlthKDZKICI87FdEuKOMOWxCSBvRZUCiTj5CVdeeZvlkRxqQT4Grvp3HJmhPIs
         ELFlb12Yv8iZpygE2lLD/uK+aGSzL9ut+UeEcIGmn1EeQWj9Z7cSbUej3ojHCK/qKFHk
         D09l3t7bLkWFvsnwpiJV4dabkNnJALFVCCcWo8gyqrXdcgrTRrEW9mvS0RG7Gt6Gl4Y1
         IDHF5X1eOJfwnH3ZrwrFscj4eAyEJYB5X1yGQIBKVh7h/+DtHnwhejTdhj+FDGtdZSih
         pPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l0GZPXB8TNZDacR1Sr2a8hUmgwJNN2vonCXFQQB38Zc=;
        b=HSsLrvSaexXQesqcwIAERiJUL7rEegm3MeJ+0D0abcV/WK/3Z2JMpqbaeu59bZpLCy
         wdy7VHKkU2zpPgRLo4PiBLTyr4HyGMA+8h1Bp87WOK8DmBgzOXYTuF2XzRuzxMR3r4sI
         oEUxT5q76IAGezQnLkPPYVqfUkA2bAgQm2olsmVgAJMzo/lY0LkFIheJM2VTvzqCNKxw
         inine6PE2zn/2e7Pj9awFBocRwYVy/B+kbCYPAu3Ys94Hej1DcyJWJ7Nx4qSMHTqtnI6
         R8EKPUH4CgffdZ1Rb5QDuMxlqOJ9uhQuZYSeOgORKBo8xlneGb1LGVGsR1rAbouldA56
         bwzQ==
X-Gm-Message-State: AJaThX7frm/OJdLnjkFB4p3YGBOjv1dhQ+vHk0M4u8jmY198tQHOGlla
        QGzf0vK9eCkjkaL0wWiz9dCuU3J2
X-Google-Smtp-Source: AGs4zMaoJf0/JLrzjPNLG7MorfsTEsefNerVqaU1QgwMD4ImMBiiDRqZAbZXL9k6Eubh/LsVZlI14A==
X-Received: by 10.28.88.137 with SMTP id m131mr1679168wmb.48.1511280591380;
        Tue, 21 Nov 2017 08:09:51 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id m11sm11129219wrf.56.2017.11.21.08.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Nov 2017 08:09:50 -0800 (PST)
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
Subject: [PATCH 2/2] Git/Packet.pm: use 'if' instead of 'unless'
Date:   Tue, 21 Nov 2017 17:09:39 +0100
Message-Id: <20171121160939.22962-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.318.g4f69657937
In-Reply-To: <20171121160939.22962-1-chriscool@tuxfamily.org>
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code is more understandable with 'if' instead of 'unless'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 perl/Git/Packet.pm | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index 82da0cf0db..1682403ffc 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -68,16 +68,16 @@ sub packet_bin_read {
 
 sub remove_final_lf_or_die {
 	my $buf = shift;
-	unless ( $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.\n"
-		    . "Received: '$buf'";
+	if ( $buf =~ s/\n$// ) {
+		return $buf;
 	}
-	return $buf;
+	die "A non-binary line MUST be terminated by an LF.\n"
+	    . "Received: '$buf'";
 }
 
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
-	unless ( $res == -1 or $buf eq '' ) {
+	if ( $res != -1 and $buf ne '' ) {
 		$buf = remove_final_lf_or_die($buf);
 	}
 	return ( $res, $buf );
@@ -87,10 +87,10 @@ sub packet_txt_read {
 sub packet_key_val_read {
 	my ( $key ) = @_;
 	my ( $res, $buf ) = packet_txt_read();
-	unless ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
-		die "bad $key: '$buf'";
+	if ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
+		return ( $res, $buf );
 	}
-	return ( $res, $buf );
+	die "bad $key: '$buf'";
 }
 
 sub packet_bin_write {
-- 
2.15.0.318.g4f69657937

