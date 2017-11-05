Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB9E20281
	for <e@80x24.org>; Sun,  5 Nov 2017 21:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdKEVjL (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:39:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44122 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdKEViv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id n74so8658491wmi.1
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=riuhLQaFe6vItLvxa0Tc+rZx346UhVSR3N0DWR5DQdY=;
        b=u6J16red4DgRlcrSBPVB5mztFa2GXUmgiTkE31NlGDZSGHEpjCRCQwizXXsjWbzHaC
         6sZN3fKoAC7+IbxNruWy1qGRt/GXnwXquWDBrgI3EOUlPGolYpH9xH2Y2N/jX6UpgkjG
         O+HCaIN1Mld0ruymsXNUDDlSbN6hYQJruxN1toqAGE2B9t7g+zlhjs4KJcFRfe/1Bu1G
         zklvuektxNGrn4u8AgrOOgOiJDg9p+Sf28KVLAAgOofvM3MkIiHl3BzOnUb8/Il0EGih
         NU/D03FGn2oVIYki3F4HvV72jwZCFrtpZw6KPNJLfp44jCgxY1E58GiF5Jqp4MR9K83r
         19Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=riuhLQaFe6vItLvxa0Tc+rZx346UhVSR3N0DWR5DQdY=;
        b=j0F2vsKu1BQyUGvjOGUz0Z9Eo9AsZvD4zC1ZhtCNbJ5pE70UyWio1mMRy5V7IzXLRY
         6iG6QldPlvN8tjy414UFkUheqW5sDR4tuyVoiR3V6o5VI+xBHvmS7R1fejcgUe/4Ubk5
         Dm5czzyhFdwOVlkBk2wWhu6/9Zqsp5540sC4ECDbgJVm7Gxov6BErN76V3dh2n7SH3jT
         Q0kXT7hpqvUViPcwAycJeeqIHoILOSBuv0EoKsnJohWAjZ+k+CtmHJgtEEYpCRvn7MCP
         4l51uOMwgPFH6Bu04oh+6wMB1jY+XSoRl3XUyDZl8Jtvwyq7xVbC0wOJ2AebvJd0qlAW
         6pnA==
X-Gm-Message-State: AJaThX74AibO6m4QtMPbWWr84AdiR3vcN1gAEmgK84rQesUxJdrcby1+
        beRtxRZpcE8uFTE6h7O8bhoQx6Zh
X-Google-Smtp-Source: ABhQp+QkQBfYfIUWb6A1xFY7vfOd5NuiYej36bkI1S/hRudicWILd3qlw+YT4bTOeeJJGvjW6ZNczA==
X-Received: by 10.28.20.147 with SMTP id 141mr3406487wmu.132.1509917929591;
        Sun, 05 Nov 2017 13:38:49 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:48 -0800 (PST)
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
Subject: [PATCH v2 6/8] t0021/rot13-filter: refactor checking final lf
Date:   Sun,  5 Nov 2017 22:38:34 +0100
Message-Id: <20171105213836.11717-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
In-Reply-To: <20171105213836.11717-1-chriscool@tuxfamily.org>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As checking for a lf character at the end of a buffer
will be useful in another function, let's refactor this
functionality into a small remove_final_lf_or_die()
helper function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 2f74ab2e45..d47b7f5666 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -93,12 +93,20 @@ sub packet_bin_read {
 	}
 }
 
-sub packet_txt_read {
-	my ( $res, $buf ) = packet_bin_read();
-	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
+sub remove_final_lf_or_die {
+	my $buf = shift;
+	unless ( $buf =~ s/\n$// ) {
 		die "A non-binary line MUST be terminated by an LF.\n"
 		    . "Received: '$buf'";
 	}
+	return $buf;
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $res == -1 or $buf eq '' ) {
+		$buf = remove_final_lf_or_die($buf);
+	}
 	return ( $res, $buf );
 }
 
-- 
2.15.0.7.ga9ff306ed9.dirty

