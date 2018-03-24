Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9DA81F404
	for <e@80x24.org>; Sat, 24 Mar 2018 05:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeCXFhV (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 01:37:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45616 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeCXFhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 01:37:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id n15-v6so8707674plp.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 22:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ic0QvOv9JDXDEsZEZfp/8NF7qTnArQAqxrGlIp0zl+8=;
        b=Flq1sE7IzFEto9NOT0tJQmCOLxopYkyPOnaC7DmHUa+l14F0m20naknyX+Q6BrlbpX
         TtyFt0tkN/NdCzewCXwsprknIRsgvro5qgUqZimKHtNSJCWokpzVXNEkY+g4rKCShMd4
         v3VZ/PmatApixJPep+40ToiwKQkCVU0TuCSjs3Zsms1Kpf3HqmUI8b3QUgOOYpolMBRm
         ng1bD2GARN6MVMrv6uSsKk/g1Y/wrtg1s6LyOZhvqVj+HhXfQ6Df2ilnOObDJ8Nm1IYK
         PRqK87s2mWZeexp0YQvyAvwFgAIBL7UYjtaj+PPEx6XTdJKTxRpglqd66qNycWBY0a0s
         OiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ic0QvOv9JDXDEsZEZfp/8NF7qTnArQAqxrGlIp0zl+8=;
        b=QXqLQpmpSlmXPBdZA/j7pWI2Y5Ou7D8vu0rOo/mZ4CoYI08B/gigEeSyJplJxHh6ZZ
         vHQvRxV+OEnXJ4hx5bk5PX8FM8gqDUaxeSvYlDmU+CcpW+VNfNKD71x6DOTMYhLFjMe+
         vOnc5elIYb6twlHGPzQgFFH8xcaqmaXYrxBYfmkRIuTF5xIQtihl8Y0qIOs+XamUuVqz
         wqZOCj/bPJnBF8GBh7ju5WASewNz6zBXawe4gHi1uBqh8fg3MBClpQn514x0qP5WjFXI
         gnqojohoR05LbmXBPXwS6xqspFS5cbnFsoocb9tR7s+Fm1F8b1hJIBfacR+WQBgg4Cfi
         q23w==
X-Gm-Message-State: AElRT7FIZYDoBk53brTjKLHNxC1qyM9y9UC/uQ9IaAIyjj7PSfKAN+oq
        yKb0MOHqHDiYSoD/uqD2ErZc8PeXglk=
X-Google-Smtp-Source: AG47ELsnFAl0fHd4qBj/kUy9xJ2+AYDmEb+LOj8ZexYlavJARoIuio0KzrkqN4dB9Y1mOnIi8qxK8w==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17-v6mr32409811plo.233.1521869838859;
        Fri, 23 Mar 2018 22:37:18 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id h2sm22691447pfd.119.2018.03.23.22.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 22:37:17 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com,
        jeffhost@microsoft.com
Subject: [RFC PATCH 1/1] json-writer: incorrect format specifier
Date:   Fri, 23 Mar 2018 22:37:11 -0700
Message-Id: <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521868951.git.wink@saville.com>
References: <cover.1521868951.git.wink@saville.com>
In-Reply-To: <cover.1521868951.git.wink@saville.com>
References: <cover.1521868951.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In routines jw_object_uint64 and jw_object_double strbuf_addf is
invoked with strbuf_addf(&jw->json, ":%"PRIuMAX, value) where value
is a uint64_t. This causes a compile error on OSX.

The correct format specifier is PRIu64 instead of PRIuMax.

Signed-off-by: Wink Saville <wink@saville.com>
---
 json-writer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index 89a6abb57..04045448a 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
 	maybe_add_comma(jw);
 
 	append_quoted_string(&jw->json, key);
-	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
+	strbuf_addf(&jw->json, ":%"PRIu64, value);
 }
 
 void jw_object_double(struct json_writer *jw, const char *fmt,
@@ -225,7 +225,7 @@ void jw_array_uint64(struct json_writer *jw, uint64_t value)
 	assert_in_array(jw);
 	maybe_add_comma(jw);
 
-	strbuf_addf(&jw->json, "%"PRIuMAX, value);
+	strbuf_addf(&jw->json, "%"PRIu64, value);
 }
 
 void jw_array_double(struct json_writer *jw, const char *fmt, double value)
-- 
2.16.2

