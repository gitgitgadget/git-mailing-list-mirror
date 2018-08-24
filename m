Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623FE1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHXSzn (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:55:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53852 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXSzn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:55:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so1944863wme.3
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//K+q9BJzyUB3j0s6RVf0plU9hbpD3Mq0d5M69cR6dI=;
        b=bmurXm3bUyI8lK8gDEJBbHbLYanZJvb48hO3MHQFUBeqOCqPm5NrE5h7XwC8rBnqE+
         AedUCYEz6lffv8X6Tt/U5Smt2DZGniZPBMws1ihu85vyxJZEPXUCBJChrYfyl3hL/42Q
         wVVZQQou1irJo2bCryRFlQ0CxkollYHRJ+RqJ691pfnXcT3cEM1aUPhrVzxone8pkd+a
         U1FLmKm2BcoENYON6eG1jcN2QwecccnYj+SFQdqKgozdJElyT2KZhaXFnFcCrx1Wm7Nd
         t0pg78ypMNsnE3UUE29mKMEpAnJW7vxcPh+TY3zFfN/QGp3c54FSUrh2kouO2W3xcae0
         KICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//K+q9BJzyUB3j0s6RVf0plU9hbpD3Mq0d5M69cR6dI=;
        b=lucYa61kTDbJgT9aw4dBxKw/Fyc1snSluVmJSHbV1OK3KEjs+4PUsHDfqQz1NV9v/z
         ZhIMrH/ZOpd/3e7ySF08VOzFBjyoRU8Q56lkXfPc7i53SdHMzyOSdCMyHKe53dwG4mbB
         xgqdkUf/ydwK+lPmxG8fpVSdaN7uAxtxS7m4r3D5B7S09JWu2EDs+ohKB1EVh50cWivU
         32dM9VaDZWn/gyTowAvHTE6pGIVXCzBm0Gw1WJYpqyXLSPJTNfRpqhbRUF7/VLsqBlMG
         QM2WfM81t9sFHmjQ6CSYvELZ4UnS3ts4K7088QPvM/N7bYuD80YUVg8xhK58dSotvrhv
         rG/g==
X-Gm-Message-State: APzg51CXKD8H/r85JVaKCghhHNDO0hCeZI5dJ6AjHREAiomay69YrV0z
        mE9iXZ25/zecU+1qH87ZG2hIlxHo7Ig=
X-Google-Smtp-Source: ANB0VdbUl4NuLsx0hNvU6nwzgY+FHJAGb+mabMnK0p4B8bZWL+B3sapVzzPWCVCy65+RGiUgix5fxg==
X-Received: by 2002:a1c:cc0e:: with SMTP id h14-v6mr1750509wmb.2.1535124035737;
        Fri, 24 Aug 2018 08:20:35 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z16-v6sm6689485wrq.78.2018.08.24.08.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:20:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/6] tests: fix version-specific portability issue in Perl JSON
Date:   Fri, 24 Aug 2018 15:20:15 +0000
Message-Id: <20180824152016.20286-6-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test guarded by PERLJSON added in 75459410ed ("json_writer: new
routines to create JSON data", 2018-07-13) assumed that a JSON boolean
value like "true" or "false" would be represented as "1" or "0" in
Perl.

This behavior can't be relied upon, e.g. with JSON.pm 2.50 and
JSON::PP A JSON::PP::Boolean object will be represented as "true" or
"false". To work around this let's check if we have any refs left
after we check for hashes and arrays, assume those are JSON objects,
and coerce them to a known boolean value.

The behavior of this test still looks odd to me. Why implement our own
ad-hoc encoder just for some one-off test, as opposed to say Perl's
own Data::Dumper with Sortkeys et al? But with this change it works,
so let's leave it be.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0019/parse_json.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0019/parse_json.perl b/t/t0019/parse_json.perl
index ca4e5bfa78..fea87fb81b 100644
--- a/t/t0019/parse_json.perl
+++ b/t/t0019/parse_json.perl
@@ -34,6 +34,9 @@ sub dump_item {
     } elsif (ref($value) eq 'HASH') {
 	print "$label_in hash\n";
 	dump_hash($label_in, $value);
+    } elsif (ref $value) {
+	my $bool = $value ? 1 : 0;
+	print "$label_in $bool\n";
     } elsif (defined $value) {
 	print "$label_in $value\n";
     } else {
-- 
2.18.0.865.gffc8e1a3cd6

