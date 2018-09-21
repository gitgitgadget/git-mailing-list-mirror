Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631CF1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 18:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391259AbeIVAMu (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 20:12:50 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33180 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391231AbeIVAMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 20:12:50 -0400
Received: by mail-pf1-f201.google.com with SMTP id t26-v6so6930943pfh.0
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JPpRgA3jjI9s3WJLpJx7Qk4EQx/3MPtwPClDugEcezY=;
        b=FgEmYEs5Gt48hwUERjA5EHpsCxjqrLDqLIhTl+wZcwfi512gpFiSb2tro6IDELM2+X
         NC1XZALAupOdbl6D0kuTPGWNiK+wW8zFEuCMDJDEbgaMLCdnbpy21Kd2XghjuPoO4Gpi
         8NuCE0CG0VYpzak65QcclpeygEgGITEy1fbjIoHiJsWF9ZC/GuYN06tR2zAwGf0HKCls
         BKTdJHWCref5MkN5QKOyNp1dV2KTABLYkjQU++nDKyCkm/lL/zNFw+Rf81mz7LnT7c9n
         plA9twiblcTqO+IsLge12o5ZoxJrRFe/1o+hiJ/nvl5Gf69dsStA5NDjDuhMUXnM5sr2
         wAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JPpRgA3jjI9s3WJLpJx7Qk4EQx/3MPtwPClDugEcezY=;
        b=RyvlM5WYHSlzZ2D40iozz4/hIVLR2cgWRCcAouhtjZKc5BrwlZ3iqVqRAxsfFWuxom
         s2NWOv4XuHIUclVjXrzZbUkVFb5mTGffhGGjT0XnOMLgkamfbakFib2QGZjeivaZxLJW
         Xt5sTTar+72rTQht+oBrOnJ4IzOi4gWVK59VsC2Vsgojbjd2rESW59hsPMBJ2knzEk8a
         3dxDiQq1MuNzLFhtLGNd2X13i30xDiwecWStvniY+vPhPFjzIIiA2FWt4Mym7nqzeLeI
         ZoziF+s6kPEQ3WTTZrkLDUc1lYnJRbmUGJQGpdXNe0GbHUeH7RrF3nrGqX+t5VswJOdL
         EkmA==
X-Gm-Message-State: APzg51D7MF+Tc5EXA1u1nwzFzINrZQAFlbeaZI8hs2KvGaxHEXtyZoUR
        hNjIzJjTW+mq/aX849iRmA+edwGmqdQvlV9LZNWtAI/o8qI6Qm/Z0JG5ODGRdp+fO15+Je51Oqb
        nST7L58IhMrrXV0KUOekSqq4O0c9fiS5ZkPW00MgzAtbD/YMeBbcH/k94CHlPj5M0yaZ1zT4WqK
        ZX
X-Google-Smtp-Source: ANB0VdYE/Q9JeoKRDDO5RaJgA9Ti7EMTuWW0nA7Q9ZKLFv2hFG7/sx6T8Pz9Z/ePyHxnnfuu9Ho0kCkAXxbFf9nceuxE
X-Received: by 2002:a63:f65:: with SMTP id 37-v6mr2119387pgp.110.1537554165295;
 Fri, 21 Sep 2018 11:22:45 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:22:38 -0700
In-Reply-To: <cover.1537553700.git.jonathantanmy@google.com>
Message-Id: <f575afa9393c4262853547ba536dc90f9511da5c.1537553700.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180920184843.20898-1-jonathantanmy@google.com> <cover.1537553700.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 2/2] fetch: in partial clone, check presence of targets
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching an object that is known as a promisor object to the local
repository, the connectivity check in quickfetch() in builtin/fetch.c
succeeds, causing object transfer to be bypassed. However, this should
not happen if that object is merely promised and not actually present.

Because this happens, when a user invokes "git fetch origin <sha-1>" on
the command-line, the <sha-1> object may not actually be fetched even
though the command returns an exit code of 0. This is a similar issue
(but with a different cause) to the one fixed by a0c9016abd
("upload-pack: send refs' objects despite "filter"", 2018-07-09).

Therefore, update quickfetch() to also directly check for the presence
of all objects to be fetched. Its documentation and name are also
updated to better reflect what it does.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c          | 15 +++++++++++++--
 t/t5616-partial-clone.sh | 17 +++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d21..b9e74c129 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -924,10 +924,11 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
  * everything we are going to fetch already exists and is connected
  * locally.
  */
-static int quickfetch(struct ref *ref_map)
+static int check_exist_and_connected(struct ref *ref_map)
 {
 	struct ref *rm = ref_map;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
+	struct ref *r;
 
 	/*
 	 * If we are deepening a shallow clone we already have these
@@ -938,13 +939,23 @@ static int quickfetch(struct ref *ref_map)
 	 */
 	if (deepen)
 		return -1;
+
+	/*
+	 * check_connected() allows objects to merely be promised, but
+	 * we need all direct targets to exist.
+	 */
+	for (r = rm; r; r = r->next) {
+		if (!has_object_file(&r->old_oid))
+			return -1;
+	}
+
 	opt.quiet = 1;
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
-	int ret = quickfetch(ref_map);
+	int ret = check_exist_and_connected(ref_map);
 	if (ret)
 		ret = transport_fetch_refs(transport, ref_map);
 	if (!ret)
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index bbbe7537d..359d27d02 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -170,6 +170,23 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
 	git -C dst fsck
 '
 
+test_expect_success 'fetch what is specified on CLI even if already promised' '
+	rm -rf src dst.git &&
+	git init src &&
+	test_commit -C src foo &&
+	test_config -C src uploadpack.allowfilter 1 &&
+	test_config -C src uploadpack.allowanysha1inwant 1 &&
+
+	git hash-object --stdin <src/foo.t >blob &&
+
+	git clone --bare --filter=blob:none "file://$(pwd)/src" dst.git &&
+	git -C dst.git rev-list --objects --quiet --missing=print HEAD >missing_before &&
+	grep "?$(cat blob)" missing_before &&
+	git -C dst.git fetch origin $(cat blob) &&
+	git -C dst.git rev-list --objects --quiet --missing=print HEAD >missing_after &&
+	! grep "?$(cat blob)" missing_after
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.19.0.444.g18242da7ef-goog

