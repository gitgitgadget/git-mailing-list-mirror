Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368471F42E
	for <e@80x24.org>; Sat,  5 May 2018 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeEEIrk (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 04:47:40 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46582 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEEIr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 04:47:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id v85-v6so34048995lfa.13
        for <git@vger.kernel.org>; Sat, 05 May 2018 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCLAgjPVtoFPUEtJJjanTe6ngqYIDEO/5XDuWbgiEqg=;
        b=nDRJFBbe62UR7OtZLRbBeVd0D5ek1w7qsYQ512R4RSwJCMV7UX7gW+RNzjIZ7n+3bf
         f90aoAXjYcVk9M3qMUmyPvIT1jWw+J65ddaOD3JQVW5sLVUxyQFo9WjXX8x8tIHrcYC6
         S+zWlG+iURsZfDSENQdw1vpW2ounQbODgdHCOitkchM1eQOHIr+9WNHij68toE2ulPTB
         3YOpv8596hqWvYO3hZGPI2bqQkWLrfXhdIH/fgkBKk7i6KbT89hFWPP4FSEe+XdyMATr
         /RYVmHYJOfVOHYADm/hYtm5YBuKOXDayqSPNQJoTJ4Brq9J5QxCWP7AkMhVVSr1l4uIV
         Wbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCLAgjPVtoFPUEtJJjanTe6ngqYIDEO/5XDuWbgiEqg=;
        b=LQalRMEEb6dRsI88l5qZzQrp7dPLKmvIn4qQo0K5zej2YfiP4NOyoAchnUfYmzyMpt
         U5lpX45YKNY1fEVAm+GCbwckUYPSTuk6GTsIa2gC+gGJAsmgW66TeKpezrB3cP8+ctF9
         IRZ/GI3cUG0oBcQORQQwQMdSo0NFBPZdXUFL4n3cXDO8zCEtNgAskmO6EAQfuQBJzi2W
         5RAb3ID0qKVWnFcC9QPPFQN0Jabyn7hFHRy++pN+OX7hbA8sHJsL62Gf/8zwRETKr9pO
         oHTvZbp8/Ka9TVk9DW+ckKGhjlVkMaZqupyus2k9tri+K+2wogEoX7+o7Vxr2VIBE9LZ
         ZW9g==
X-Gm-Message-State: ALQs6tD4+t4bzwmLnbNOJsKObSS2LdRNu0qvK+fiiN4+2tFik+uzpK52
        mID5tSkZ6MXrQYbNBAtt9H8a7A==
X-Google-Smtp-Source: AB8JxZp3YCU1HitWU9ZBCpQYlWJH9+RjYj+SDBGC0jaVYbk4RPrixjugZP7YiumUyuOUz3So40b89g==
X-Received: by 2002:a19:2687:: with SMTP id m129-v6mr13166538lfm.132.1525510046051;
        Sat, 05 May 2018 01:47:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w79-v6sm3705308lfi.49.2018.05.05.01.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 May 2018 01:47:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] pack-objects: validation and documentation about unreachable options
Date:   Sat,  5 May 2018 10:47:16 +0200
Message-Id: <20180505084716.2345-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These options are added in [1] [2] [3]. All these depend on running
rev-list internally which is normally true since they are always used
with "--all --objects" which implies --revs. But let's keep this
dependency explicit.

While at there, add documentation for them. These are mostly used
internally by git-repack. But it's still good to not chase down the
right commit message to know how they work.

[1] ca11b212eb (let pack-objects do the writing of unreachable objects
    as loose objects - 2008-05-14)
[2] 08cdfb1337 (pack-objects --keep-unreachable - 2007-09-16)
[3] e26a8c4721 (repack: extend --keep-unreachable to loose objects -
    2016-06-13)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-pack-objects.txt | 13 +++++++++++++
 builtin/pack-objects.c             |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 81bc490ac5..44245e5815 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -267,6 +267,19 @@ Unexpected missing object will raise an error.
 	locally created objects [without .promisor] and objects from the
 	promisor remote [with .promisor].)  This is used with partial clone.
 
+--keep-unreachable::
+	Objects unreachable from the refs in packs named with
+	--unpacked= option are added to the resulting pack, in
+	addition to the reachable objects that are not in packs marked
+	with *.keep files. This implies `--revs`.
+
+--pack-loose-unreachable::
+	Pack unreachable loose objects (and their loose counterparts
+	removed). This implies `--revs`.
+
+--unpack-unreachable::
+	Keep unreachable objects in loose form. This implies `--revs`.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4bdae5a1d8..cfac021360 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3085,6 +3085,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		fetch_if_missing = 0;
 		argv_array_push(&rp, "--exclude-promisor-objects");
 	}
+	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
+		use_internal_rev_list = 1;
 
 	if (!reuse_object)
 		reuse_delta = 0;
-- 
2.17.0.705.g3525833791

