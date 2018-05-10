Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156711F406
	for <e@80x24.org>; Thu, 10 May 2018 12:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964788AbeEJMnc (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:43:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52164 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935483AbeEJMn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:43:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id j4-v6so3717256wme.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q6q1dA6rA2oktGHDPCS/Vhm1L1dXGaG+cQzZQWYki1k=;
        b=GTvjJnEFHAE34EjH5BKEYTMBPErNbyNdgWkc6YlfP4lCv6XrosGrGKvCEY63exVJ4i
         fYf9GkmBRdyv116Z3Vw3IyGSv11RCVjX8cvbW4LsodEwJEariII9ClSIQhiNLb7187RH
         zRQN5NVs71U27/FAeWhxIXKfUksAXE1gfmkUe2qmCyBiZtl9AUI1R8IAT2vrNVlyBVat
         Lf1iW+gr8wv2aBHeYOueaT0dY8H98eFcfUnKDotrf0s89hOX9FY6mHR1HeAO3Hqsre0n
         bvw5IIhDD3W5wuWxFRCJRMTBVrqgmlHGoFXNX0zq8Z5nShIv7Bz+jvvTfIksp83SzYDs
         AK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q6q1dA6rA2oktGHDPCS/Vhm1L1dXGaG+cQzZQWYki1k=;
        b=mVYvOOxN6qri1CjZfMzfstWIdq/YrLwvEU/G3Q1dxECDBbQMbJQOPMGRA1jEMypEMi
         cFkCgJQkNc7qdVxRtAjetPwcP8jXwyDKbjCVJDmxrze+4B/qTKQ3hLmcB/6Z+6Z1yDfC
         MwKMbERw0df5eaKWtZhQj41lbem9NYJO/kfWdPH3KMVHggxdVtVY+O+gJsBEVRjT2ADo
         +Kp7cZvJaa/ZaAPOe/TiZAwYL7gFFCvUAuwW2Zq8I5yhUEqn7B42SkMedChVKn8YEw+J
         mu9x/yxotHpkLCeFdQhXS8SVgYZGAp4dG1GVOPUe+axBAe0hZi8CeMYwZiwdQu0TEwDt
         Mb7w==
X-Gm-Message-State: ALKqPwfCbdvNBxbzLj+0wWG4mpdeqJnUgZX5iZEnsSKbW6jGsEK9qZs8
        UncHdvNf+U5LyiJQitTTTsiCmyEA
X-Google-Smtp-Source: AB8JxZrOAUhk/d9TZ0LSE5wMVRzDE8S8DnwX9i3Xx4mCWJsWdNegi7YAD1wjYS7mVJRIP6RrusHhRQ==
X-Received: by 2002:a1c:e3d4:: with SMTP id a203-v6mr1143608wmh.151.1525956205403;
        Thu, 10 May 2018 05:43:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q7-v6sm1203303wrf.49.2018.05.10.05.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 05:43:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/6] sha1-name.c: move around the collect_ambiguous() function
Date:   Thu, 10 May 2018 12:43:01 +0000
Message-Id: <20180510124303.6020-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g4ac3413cc8
In-Reply-To: <20180510124303.6020-1-avarab@gmail.com>
References: <20180510124303.6020-1-avarab@gmail.com>
In-Reply-To: <20180501184016.15061-10-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent change will make use of this static function in the
get_short_oid() function, which is defined above where the
collect_ambiguous() function is now. Without this we'd then have a
compilation error due to a forward declaration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index cd3b133aae..9d7bbd3e96 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -372,6 +372,12 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static int collect_ambiguous(const struct object_id *oid, void *data)
+{
+	oid_array_append(data, oid);
+	return 0;
+}
+
 static int get_short_oid(const char *name, int len, struct object_id *oid,
 			  unsigned flags)
 {
@@ -421,12 +427,6 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 	return status;
 }
 
-static int collect_ambiguous(const struct object_id *oid, void *data)
-{
-	oid_array_append(data, oid);
-	return 0;
-}
-
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
 	struct oid_array collect = OID_ARRAY_INIT;
-- 
2.17.0.410.g4ac3413cc8

