Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3648FC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbiC3FHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiC3FHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB06621B
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c7so982350wrd.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W9Vimte0sGyR2DMe0rSIsRe6vitxNiJv2vsesuc0ht0=;
        b=Oh77vFaTu3RR7W4K3ofhuIo+hBGtysl+oowvms0G2uxrqZCs2uK5lg2+dA4yGjSak9
         heSX0hKqrMNJ0hoUlzk2EUEZt4KRwmaTT66Pysf6ImRP7WGmCd6x9QjafFJTv0pBZV3o
         UpxVZ7P6K2eBkvaK1jhp0Mj6SRoUOgpjINAshD9GBEsOpLc5NZpEfrnn8cTxV9XXmWBb
         7+Ma/UKBLNcNFq5lVA3lSVmcDlWUxzoZfhbHDWRss0ltQ/8iS6DSSFGetIhSserIlwQZ
         pIuF1OR/IJnpv/ru5192PgJBxr3p9cKPlmwt7eGOchVcZFZv+Azs3XZh9PDMisDVrPQu
         lqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W9Vimte0sGyR2DMe0rSIsRe6vitxNiJv2vsesuc0ht0=;
        b=CFLz8lkxhshkvs7Buoa5upV9CvkXOQqFIA6LEntUvtbfJWzMAnmm8oDGdE10jcqbFj
         Q1POxE9GSX8+oMbVWKNUuGdz14NI1d7IcylDps2IC2NNEDZT3zEeexNCoI7VBHIizB9N
         jLbpj63k/j+PnFmWf4GvfVFtlwTAYSmhx6zh19GbdzHykxUSZM3n4LfvQY0bXFtLQFrT
         pzSpN3/uTZnszhWYipnwmgE/DRQsgUIkjNO2iTlaQtsP1lf0D3kknpzTyxOxZ3lv9/6x
         MIHe86hpuqzwKp3BbbUqm7Odua1vxEGTD6dkD0Y07M9iU9RyuAUW4eBxfR4pgKyOAzUn
         EbyQ==
X-Gm-Message-State: AOAM533AgYza+GrNfhz9AZufazIbnfSgx5wr+0/nC9ZOgPKSbY5YTqiD
        qQcegIbDVE6Cm6iQGcHV5+4i37/aehk=
X-Google-Smtp-Source: ABdhPJyVv2riFIYlWqBUPYT86Fy6LvU/yjR2V2wQ2NHj7aPYbcJQ4D4nNe+eCQ1WANpG2UGYS7d7KQ==
X-Received: by 2002:a5d:584f:0:b0:204:171b:a4bc with SMTP id i15-20020a5d584f000000b00204171ba4bcmr35887798wrf.592.1648616738855;
        Tue, 29 Mar 2022 22:05:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b0038c8fdc93d6sm3610464wmc.28.2022.03.29.22.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:38 -0700 (PDT)
Message-Id: <2d1bc4568ac744f11c886a5f964dbe563c04ce8b.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:21 +0000
Subject: [PATCH v5 03/14] object-file: pass filename to fsync_or_die
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

If we die while trying to fsync a loose object file, pass the actual
filename we're trying to sync. This is likely to be more helpful for a
user trying to diagnose the cause of the failure than the former
'loose object file' string. It also sidesteps any concerns about
translating the die message differently for loose objects versus
something else that has a real path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 object-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index b254bc50d70..5ffbf3d4fd4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1888,16 +1888,16 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_loose_object(int fd)
+static void close_loose_object(int fd, const char *filename)
 {
 	if (the_repository->objects->odb->will_destroy)
 		goto out;
 
 	if (fsync_object_files > 0)
-		fsync_or_die(fd, "loose object file");
+		fsync_or_die(fd, filename);
 	else
 		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
-				       "loose object file");
+				       filename);
 
 out:
 	if (close(fd) != 0)
@@ -2011,7 +2011,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd);
+	close_loose_object(fd, tmp_file.buf);
 
 	if (mtime) {
 		struct utimbuf utb;
-- 
gitgitgadget

