Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504CB1F42D
	for <e@80x24.org>; Fri, 25 May 2018 19:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968035AbeEYT20 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 15:28:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43509 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967998AbeEYT2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 15:28:24 -0400
Received: by mail-wr0-f196.google.com with SMTP id r13-v6so10926762wrj.10
        for <git@vger.kernel.org>; Fri, 25 May 2018 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uN/E5OftiseKty+mf4lM+4fE9QYw3Z4XmYU9RtMrtaM=;
        b=hiz67dwr9kSun8flFhcb1upgqnuwk5XBquK+DUbjGj/FPfKuzGeJfVg7P//OvguEYw
         wpKqHOmFG2FQAZwL6WqRv2m03xySlzumPLfM/HK5w7VdTWbWpMcsJL6+9B6jG8OLLsI2
         vf/LHNQxhgpRoWtxx8pchQOixTMqPUsfwEOW0OvC6Y/ZAGxGAuhhgjroiUmuXn5QpoS1
         iod8hpme02aXg1WYpxduJQ1h8sEru/BP16QJPW4Z2x4sBHW5szo2hf9yD3V43ZhlUllw
         GzgmpwV31e0qLBFcu2Xya6tvEiaJk22tuul8fuZDifQ05Obgj0WrseF824On24JyJbYD
         oHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uN/E5OftiseKty+mf4lM+4fE9QYw3Z4XmYU9RtMrtaM=;
        b=RJ63C+2g/OdZf3a/TABNfOcV/tSO35givMpfagc+MqC7xYJZSyczESEnqNErYScd12
         nC6TmrYwyvmLcLM1AVhAIfwRlbuMivT9jfOt8vRBLnHDyRsjSIflI1lFZAmszPWXP7Xq
         uhcBkHgZWCo8mJBR2in8V6MDR3ZcBVJo3WooBeg19GR0NkcDLoKk0JAdD1k76Dr5weEf
         WbUdNL/tpq6kf1KeNTD+1Y7oExNfhWVOM/TAmU0O7LHZnSIY7JVbDZTMilxN0E7tbrpO
         tQQz0VRrWA7vuK44Vn8D6NowH0JQEUDJNxCDTNzfqoNpFUFIAYuEMZaZVLkYTJlSBXUJ
         TmxA==
X-Gm-Message-State: ALKqPwfoG56Xu8QHmR8Bx7fh2nKk2yaIW777mIfYYBO07Sic8FWsSkE+
        /w9P2T893665smziDKOcpwmFLKbm
X-Google-Smtp-Source: AB8JxZp9iAnbxq/7THPB65d2pQucKNN+6aMLn08pI/Qg3CbTk5WlTkJFc3Y+8vAojNCwRPACz5kxfg==
X-Received: by 2002:adf:d4c5:: with SMTP id w5-v6mr3002102wrk.185.1527276503047;
        Fri, 25 May 2018 12:28:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a69-v6sm7276518wma.7.2018.05.25.12.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 12:28:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] config doc: don't describe *.fetchObjects twice
Date:   Fri, 25 May 2018 19:28:07 +0000
Message-Id: <20180525192811.25680-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's not duplicate the description of what *.fsckObjects does twice.
instead let's refer to transfer.fsckObjects from both fetch.* and
receive.*.

I don't think this description of it makes much sense, but for now I'm
just moving the existing documentation around. Making it better will
be done in a later patch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 84e2891aed..623dffd198 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1422,10 +1422,9 @@ fetch.recurseSubmodules::
 
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
-	objects. It will abort in the case of a malformed object or a
-	broken link. The result of an abort are only dangling objects.
-	Defaults to false. If not set, the value of `transfer.fsckObjects`
-	is used instead.
+	objects. See `transfer.fsckObjects` for what's
+	checked. Defaults to false. If not set, the value of
+	`transfer.fsckObjects` is used instead.
 
 fetch.unpackLimit::
 	If the number of objects fetched over the Git native
@@ -2845,10 +2844,9 @@ receive.certNonceSlop::
 
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
-	objects. It will abort in the case of a malformed object or a
-	broken link. The result of an abort are only dangling objects.
-	Defaults to false. If not set, the value of `transfer.fsckObjects`
-	is used instead.
+	objects. See `transfer.fsckObjects` for what's checked.
+	Defaults to false. If not set, the value of
+	`transfer.fsckObjects` is used instead.
 
 receive.fsck.<msg-id>::
 	When `receive.fsckObjects` is set to true, errors can be switched
@@ -3332,6 +3330,10 @@ transfer.fsckObjects::
 	When `fetch.fsckObjects` or `receive.fsckObjects` are
 	not set, the value of this variable is used instead.
 	Defaults to false.
++
+When set, the fetch or receive will abort in the case of a malformed
+object or a broken link. The result of an abort are only dangling
+objects.
 
 transfer.hideRefs::
 	String(s) `receive-pack` and `upload-pack` use to decide which
-- 
2.17.0.290.gded63e768a

