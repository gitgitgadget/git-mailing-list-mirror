Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DCE21F404
	for <e@80x24.org>; Sat, 24 Mar 2018 18:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeCXSiz (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 14:38:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36892 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeCXSiy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 14:38:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id n11so5771378pgp.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3a35urbkjY8jfr58AfiCyaMV/PwWjBDj767Hs36XPcU=;
        b=w332X5ByZni66LHDMjD6HKwtpE8o8R/p5AYe6Mqo/i/g334ehzSmlMJlhOi0yhESUe
         LytCkDU5hHqno4kVZspo9H6SgzD8ger1fA/dfvYpZ/OI+AnWhvaEqKpZO5ddVHsHM7X+
         C5DexSLg5+yrZFozWmzUPdPe59gYyhXlQbttLNT5PEVwrSryAhrq4/DyspDmHq0os1G7
         dekoFpqaXjjk6Vm/F94RKI+GhkII5GbAjqB5xJ8Z1CMBZcPTYdRo8vv6Z47KrCLRCyZo
         9h8BZdtuFOBOySfXAtNYfwlBVLLUBZsjxR9W+kIDM8z5IeBn13ovztTFYUhxCAtmWnnY
         SbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3a35urbkjY8jfr58AfiCyaMV/PwWjBDj767Hs36XPcU=;
        b=IMnOH7MdHuVFKLpNgYVF2PKtvnw+s8IdHkyevjVxus5crn75si8yyNFz9LAziED6JK
         RqmLo+qU2Q30gf+p7t1JqJENw80l4o5doZC3VX5VJiZs2H1Tfui6tmRpGgi5TEqABcj9
         m6qx8ZlY8ifWowitT2nA3iAL17n9sJQkwsFj78J24MOMkZ/Z8ihHsKmD5nNqOxi+QeFc
         Mp1WlpAsWPjK5nFC8kpS2q8VhecHiVrjnuFQGYG4W/P3j6zrT9jBU0H5Sk9WRyKqudW3
         F1PqRco4ZDTa6E5JfcBC1fckBJa8S4cX24wuI6dY3ljeMfNo8FKaQ57uquF/tnXMOW/A
         FCXA==
X-Gm-Message-State: AElRT7FRbn08J0wA93T/8kog7faCNQFYjQLaQtZVw5Ag1SBNVPjmHB4b
        bQex4QEtqYvy0wmYsOIm/RvhGy/Nphs=
X-Google-Smtp-Source: AG47ELu7J52bY2OH+w4uDT4ESrXv/jOY+nv5VO3BtTdAqAgs1licS2R83tue1f1zw0djTSRroBv2SA==
X-Received: by 10.99.96.66 with SMTP id u63mr24410992pgb.22.1521916733377;
        Sat, 24 Mar 2018 11:38:53 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id d12sm22007343pfn.42.2018.03.24.11.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 11:38:51 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com,
        jeffhost@microsoft.com, ramsay@ramsayjones.plus.com
Subject: [RFC PATCH v2 1/1] json-writer: add cast to uintmax_t
Date:   Sat, 24 Mar 2018 11:38:32 -0700
Message-Id: <1a6a4983b824e7b9f4eb1f7b83a39d24f72e552f.1521916335.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521916335.git.wink@saville.com>
References: <cover.1521916335.git.wink@saville.com>
In-Reply-To: <cover.1521916335.git.wink@saville.com>
References: <cover.1521868951.git.wink@saville.com> <cover.1521916335.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a compile error on Mac OSX by adding a cast to uintmax_t
in calls to strbuf_addf.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Tested-by: travis-ci
Signed-off-by: Wink Saville <wink@saville.com>
---
 json-writer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index 89a6abb57..1f40482ff 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
 	maybe_add_comma(jw);
 
 	append_quoted_string(&jw->json, key);
-	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
+	strbuf_addf(&jw->json, ":%"PRIuMAX, (uintmax_t)value);
 }
 
 void jw_object_double(struct json_writer *jw, const char *fmt,
@@ -225,7 +225,7 @@ void jw_array_uint64(struct json_writer *jw, uint64_t value)
 	assert_in_array(jw);
 	maybe_add_comma(jw);
 
-	strbuf_addf(&jw->json, "%"PRIuMAX, value);
+	strbuf_addf(&jw->json, "%"PRIuMAX, (uintmax_t)value);
 }
 
 void jw_array_double(struct json_writer *jw, const char *fmt, double value)
-- 
2.16.2

