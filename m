Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1A3C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiFDLSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 07:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiFDLR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 07:17:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032F1D30E
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 04:17:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u8so9056048wrm.13
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SB5BD0xi1BgeKYveuZXRwolzoUpagPJ9nSfk/TvDhRI=;
        b=CV0u5qAnrB7VtQMb//m42uagcKSlaqQmkj28bs9QWwAJZAX9EK4ztObX0onHELyoof
         7iRy+v3fyJmQET0PVKCKV4Zt5jshQpFMGaNHcR3Fww8voVc2n1o+1oI+x/8V4buxQTwo
         d5Ds6AbdS6M0Q/JIBwmuA07CswftmeB4YEZ8aj7EWtLG3uKSdLWlTDtcwTPykKYq6WgZ
         P8AQFxyVdOXTD4l6r11033s1JHFYXmN11J4DwpBjrM5amj0BV3xnIAVeGYmYsaGg1tia
         w8c+ShE8/415I/fyOBvBUF4/Et5rhb8YqyQp0eHmGvMojsGE4A5N5+UW2N3KDBSz4McO
         EUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SB5BD0xi1BgeKYveuZXRwolzoUpagPJ9nSfk/TvDhRI=;
        b=Me1tBftyifamIDKsQjmm/XKN08E3Qw1BTaZEE7vy2HZZBbiODHTRu8jpREovPUOySw
         TxfMbuDCTwubzz0wQjC/mYW+Q4KMjaqqvunf1HQ3FlptP5hDq7GReHHrQ3As7ps36SWx
         NTgZl0ogHVeV5eKusgB9Nv8xdmChcIIAltq21SZ542+MHdM8Ujg/ZGHTavGeZRt6ZTOg
         /SObiqmTqVUsd03Gn6LXtuGECAYdcsR7iZCfpgaiO4+FUKVhnL4ftCyYd1x5DUr7tolW
         PqgYXzxF2WUhkQ8Byv+mas0g3PvgCy0SRH+KTCKFQY8U+/4qtDb7DpyYZKzxCPoOZtR2
         hzig==
X-Gm-Message-State: AOAM531OsNDtSxaqxVzc683cFU2gOZ4oZF1uzhxEeMim84MolFX+7pCE
        wspUCQwySkKF5uOOEsAyz0PBkEY40zf4wyS3
X-Google-Smtp-Source: ABdhPJx3jCbo7ZoR6dC7kx64o49hww8dURyUSdCKas9LFI7SdVPmRYKck52SLaO9Qm2jF5/v255aCg==
X-Received: by 2002:a05:6000:1f0e:b0:20e:6f3e:d882 with SMTP id bv14-20020a0560001f0e00b0020e6f3ed882mr11917178wrb.370.1654341473246;
        Sat, 04 Jun 2022 04:17:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020adff285000000b002101ed6e70fsm5806121wro.37.2022.06.04.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:17:52 -0700 (PDT)
Message-Id: <47f271875291d24666c5a3cec895421ab646f1f3.1654341469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Jun 2022 11:17:47 +0000
Subject: [PATCH v2 2/4] rebase: help users when dying with `preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Git would die if a "rebase --preserve-merges" was in progress.
Users could neither --quit, --abort, nor --continue the rebase.

Make the `rebase --abort` option available to allow users to remove
traces of any preserve-merges rebase, even if they had upgraded
during a rebase.

One trigger case was an unexpectedly difficult to resolve conflict, as
reported on the `git-users` group.
(https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)

Other potential use-cases include git-experts using the portable
'Git on a stick' to help users with an older git version.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/rebase.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index bad95d98adf..17cc776b4b1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1182,8 +1182,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else if (is_directory(merge_dir())) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
-		if (is_directory(buf.buf)) {
-			die("`rebase -p` is no longer supported");
+		if (!(action == ACTION_ABORT) && is_directory(buf.buf)) {
+			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
+			"Use `git rebase --abort` to terminate current rebase.\n"
+			"Or downgrade to v2.33, or earlier, to complete the rebase.");
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/interactive", merge_dir());
-- 
gitgitgadget

