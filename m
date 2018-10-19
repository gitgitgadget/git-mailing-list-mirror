Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F4D1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJSW7P (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35805 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbeJSW7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id o14-v6so31121537ljj.2
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Vbi19/ChPsYLaFnOm7ahsyPrzFymaFSS+Cl4srI4Go=;
        b=GPXFVDRYO1WJNposWb0Uj7bf7gDhca9mg7CnFRTUGD2NT93JBxwPaYdJ6KyPh6rhA3
         1iZ5YKfkHzZ8UgUk8LniVHLc0UYliTUJbAZyfKSUPO6DJNAcC7tsMav7pJsUko5ecQDz
         sUj8kdEK4amowk+AOlPYDukvcTMj8uYLrux6EHqc81uCHJSHIWMxau/cYE13vsVLBDKm
         i39ZMHOM3k/zbYcbNUpPd6xWUaq0z1blhpzl5NrUdmtMMtxyxkZ4Vr5yP4si8mt/e1Ha
         QhoQVfF5nN/wcpwPIJPMgPdlQNdYMycpw9oc0GvcSm6g8wzFllBgwQcUleJWKlR6FI/K
         i/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Vbi19/ChPsYLaFnOm7ahsyPrzFymaFSS+Cl4srI4Go=;
        b=uHws95utD2C+UF0QW3Dbwc8Hro6fPDiEqC+PZMDP81j79iO/tD1Kiu3vGZI2UMg7IF
         G0dYRXHXYnXRkir32dk3anhdacmzijn2cSpI0SGhQ+BOpEwpe56boeZ42V8m5vDD8hsS
         F0f0GixzWjGJdZb19YzqP98qfKVVoPIjuIItzRu6qXmMtUP+ezfufSO71z/VmXQW3BfV
         ZalXfEZb8gvX7VL7Y5rbv6y5QMYAd3zn+7X92vc+1XF6EMWKO8Mg8AggSXsFVs6g/qbW
         cQRP2z4UgxlQrDYJFVy21TVkSn/4vWuw5mU6tccTXZ2z3DefnV/Bg16kJG5ZOMGCeC1l
         PA6Q==
X-Gm-Message-State: ABuFfohC3kNW2V8AbTv8lzXahh+Uk8JZpP4Y6pOvFyHVyIRfqLsjvKbH
        r93ZklxgSRdipV+mYH/VD2Dgp+XG
X-Google-Smtp-Source: ACcGV62U25MrhsIL3c034z8gKwuBjF6szdP6hfNwrgIkX3zrYkWEtElqhXY320Jk/FpfFA/mNpd0+w==
X-Received: by 2002:a2e:88da:: with SMTP id a26-v6mr22783775ljk.85.1539960765523;
        Fri, 19 Oct 2018 07:52:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/19] list-objects-filter.c: remove implicit dependency on the_index
Date:   Fri, 19 Oct 2018 16:52:21 +0200
Message-Id: <20181019145237.16079-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 list-objects-filter.c | 7 +++++--
 list-objects-filter.h | 1 +
 list-objects.c        | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index a0ba78b20c..8825e2a5ab 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -38,6 +38,7 @@ static enum list_objects_filter_result filter_blobs_none(
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
+	struct index_state *istate,
 	void *filter_data_)
 {
 	struct filter_blobs_none_data *filter_data = filter_data_;
@@ -94,6 +95,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
+	struct index_state *istate,
 	void *filter_data_)
 {
 	struct filter_blobs_limit_data *filter_data = filter_data_;
@@ -200,6 +202,7 @@ static enum list_objects_filter_result filter_sparse(
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
+	struct index_state *istate,
 	void *filter_data_)
 {
 	struct filter_sparse_data *filter_data = filter_data_;
@@ -216,7 +219,7 @@ static enum list_objects_filter_result filter_sparse(
 		dtype = DT_DIR;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
-					    &the_index);
+					    istate);
 		if (val < 0)
 			val = filter_data->array_frame[filter_data->nr].defval;
 
@@ -279,7 +282,7 @@ static enum list_objects_filter_result filter_sparse(
 		dtype = DT_REG;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
-					    &the_index);
+					    istate);
 		if (val < 0)
 			val = frame->defval;
 		if (val > 0) {
diff --git a/list-objects-filter.h b/list-objects-filter.h
index a6f6b4990b..dfa29595d1 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -58,6 +58,7 @@ typedef enum list_objects_filter_result (*filter_object_fn)(
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
+	struct index_state *istate,
 	void *filter_data);
 
 typedef void (*filter_free_fn)(void *filter_data);
diff --git a/list-objects.c b/list-objects.c
index 0c2989d5ca..f9d36dabf2 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -51,6 +51,7 @@ static void process_blob(struct rev_info *revs,
 	if (!(obj->flags & USER_GIVEN) && filter_fn)
 		r = filter_fn(LOFS_BLOB, obj,
 			      path->buf, &path->buf[pathlen],
+			      &the_index,
 			      filter_data);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
@@ -136,6 +137,7 @@ static void process_tree(struct rev_info *revs,
 	if (!(obj->flags & USER_GIVEN) && filter_fn)
 		r = filter_fn(LOFS_BEGIN_TREE, obj,
 			      base->buf, &base->buf[baselen],
+			      &the_index,
 			      filter_data);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
@@ -175,6 +177,7 @@ static void process_tree(struct rev_info *revs,
 	if (!(obj->flags & USER_GIVEN) && filter_fn) {
 		r = filter_fn(LOFS_END_TREE, obj,
 			      base->buf, &base->buf[baselen],
+			      &the_index,
 			      filter_data);
 		if (r & LOFR_MARK_SEEN)
 			obj->flags |= SEEN;
-- 
2.19.1.647.g708186aaf9

