Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96880C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 02:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbiBBCh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 21:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbiBBChp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 21:37:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5CC061401
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:37:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m13-20020a05600c3b0d00b00353951c3f62so2813933wms.5
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 18:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3DjTSuxoeCeG9xk74b8MP4D3yFu5DTvO02bZbX9rQ60=;
        b=C+WKaIpPGtY7s6NZ+PRwjTAKfd0dQSLJ3rDmcIf0jhx3gVPiBerMFy/eSvAp6yoYMT
         9G2faSS/tIQhLSo6s4arQuu9G04WxnrHYlRBIcPCXMzBIoxjUjpryLxL+/lxNbIpxj+1
         iwET8NpglOPR3WmYrSPrAC1EHwPC6B7HJNDFQq5QT4yq7lfRHhhGMILh3g4OaWkLeBmq
         bLuR6OIPe2YlfKA4PnTQEchHmIsiaOKc4T+nJq17QISLZG/e13r6xQCRIw6Cpq2uPxMs
         Fd5L351jB/EAvYzZ8bs1OfREdHnB3JkdmzOsXTvLPDtYDrfaau+lqajwsC785JvpV+vV
         H8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3DjTSuxoeCeG9xk74b8MP4D3yFu5DTvO02bZbX9rQ60=;
        b=xZTiNE/3JtPb9VmAff/uSBJ382EC+cZ8XjTUY9UxKkUHv/92xGx7t3jNrKptYYCrN5
         av6ujFbu0jXhzRNdRXtKE3GgTdfT2rClg50MjY3DAaAYqN0c52+FJ2YxBsPMDIQ+j0ep
         S3LIiOhb54WPDCCnwRrh8ubUHTrX8mZxQ9tfblWJaJkfLs35e10B2oiiJy2Sebyg2y84
         LBHi1G5qdMocGXuPELq1bK8eS3l2KXLeL7x9beEc2MxcbvzYwmJCDOwXeGWkwSCgIgIb
         6KNCQQADLAGDOsizFPd53RNtvT4nGGbJRLNHM289eATfNjooM0BvVDET4aHUnilu6RaX
         AUjg==
X-Gm-Message-State: AOAM530TUjH/E3R5jz9oCip6+D/oEfuO/ezvJ11g1MqOXuAiEPH/GKZn
        /Z1MOgOIpb0X4pyABXDENtOOpUdKObM=
X-Google-Smtp-Source: ABdhPJwDTA1HIuaDMTp0tcJW5/MZKp4CFXqnEmw7Conww+TItNy23m9KaO1zp4ZIzj6TtOxhVbAgFA==
X-Received: by 2002:a05:600c:288:: with SMTP id 8mr4158586wmk.25.1643769463402;
        Tue, 01 Feb 2022 18:37:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm3355876wmq.46.2022.02.01.18.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 18:37:43 -0800 (PST)
Message-Id: <cbde4e5d37280c5bfb2e61889506cfd0c3ed30c4.1643769457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
References: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
        <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 02:37:32 +0000
Subject: [PATCH v5 05/10] merge-ort: mark a few more conflict messages as
 omittable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

path_msg() has the ability to mark messages as omittable, designed for
remerge-diff where we'll instead be showing conflict messages as diff
headers for a subsequent diff.  While all these messages are very useful
when trying to create a merge initially, early use with the
--remerge-diff feature (the only user of this omittable conflict message
capability), suggests that the particular messages marked in this commit
are just noise when trying to see what changes users made to create a
merge commit.  Mark them as omittable.

Note that there were already a few messages marked as omittable in
merge-ort when doing a remerge-diff, because the development of
--remerge-diff preceded the upstreaming of merge-ort and I was trying to
ensure merge-ort could handle all the necessary requirements.  See
commit c5a6f65527 ("merge-ort: add modify/delete handling and delayed
output processing", 2020-12-03) for the initial details.  For some
examples of already-marked-as-omittable messages, see either
"Auto-merging <path>" or some of the submodule update hints.  This
commit just adds two more messages that should also be omittable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a18f47e23c5..998e92ec593 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2420,7 +2420,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		 */
 		ci->path_conflict = 1;
 		if (pair->status == 'A')
-			path_msg(opt, new_path, 0,
+			path_msg(opt, new_path, 1,
 				 _("CONFLICT (file location): %s added in %s "
 				   "inside a directory that was renamed in %s, "
 				   "suggesting it should perhaps be moved to "
@@ -2428,7 +2428,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 				 old_path, branch_with_new_path,
 				 branch_with_dir_rename, new_path);
 		else
-			path_msg(opt, new_path, 0,
+			path_msg(opt, new_path, 1,
 				 _("CONFLICT (file location): %s renamed to %s "
 				   "in %s, inside a directory that was renamed "
 				   "in %s, suggesting it should perhaps be "
-- 
gitgitgadget

