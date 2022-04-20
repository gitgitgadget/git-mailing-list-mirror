Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA302C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377380AbiDTJ76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377359AbiDTJ7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060643298E
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k22so1516260wrd.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PnEkkU9Wx6HdLyfYv/KNN6gAbLsvuSzZ8V5DKhxVJIc=;
        b=oEJsw0JvcP65cLDbCjNX/BLHVKkrvVyncILHOPZ6H+tiqHtL9PwPqPH52wAnACPMr2
         MDifOHHUviiAU0hMOI/LPswj8hTjLjuPJrn1OVWuklOxNSwCr0NiD0smMDq//qOOVFIr
         WNPORbVLwz7z7f2WMitOyKZd/i+9IXnPfNACoPysEXZYdD01uBM+6Js3eShaF6l92c0y
         Wn3KdWZstSG5Y1kOFU8H5S1ez+SJ6wYExG6S8UhulOn2BDXk/GvPNABlseqoBHXCTDOb
         FfTzIreIfUKPDIgLq/54cThcR8H9jOMVC52ltMEwQT1zaAPYw6VhRqthZr1bOZ1ZgJ/A
         4ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PnEkkU9Wx6HdLyfYv/KNN6gAbLsvuSzZ8V5DKhxVJIc=;
        b=T4/ZTJ5/+ScLqt/ptwpBC0HIzwHqeQzgiRSyVSBxOwsIxCBvAzTGv0qKjibwzHBK0Q
         dB7I7ucpYzMuT51LWVqvx8URDVYHHzHyA4thNDmEJXnnW0s/fAFLKEqqgjL0TijQgxig
         5EXoiE76t3qIvZ87Bo9gEZuNbEyzkVNzkFLUq7j6YQeLCPJHgqHFHtUEGFErbe3Xbirw
         mmVjfzSP0jcYJPNttOfVNwP/oeYQmeiiZuTg/frGVOnHFlHGw1bRp2GrtQVwDZPT9WLg
         SWzs1rjCefT0HbalzUPWInQvTZKu3MhvlX5g7m9go3WQsfb+4FNL1bELxLuGFX1dmhW2
         MGTA==
X-Gm-Message-State: AOAM532LOky+ARh4CYCvd7iLG8ZLpnSTRdeo9/HYrCbocII9FNj3l4DR
        8xhWC5g3gEPgSdBE824YprgfoTcCPFM=
X-Google-Smtp-Source: ABdhPJw+2MWw7TtckneRFdQ3b0xyHCa/81luTwXOs2XgZJSiD70P4/qm968+7HEXd5anG6siajCCXg==
X-Received: by 2002:a05:6000:1844:b0:20a:77b3:716e with SMTP id c4-20020a056000184400b0020a77b3716emr15454445wri.231.1650448620289;
        Wed, 20 Apr 2022 02:57:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b0039288e17458sm14046484wmg.19.2022.04.20.02.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:56:59 -0700 (PDT)
Message-Id: <afa67abe01aed2a403a4f53d95347b1d2a6eac8b.1650448612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:48 +0000
Subject: [PATCH v2 5/8] rebase --apply: respect GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog messages when finishing a rebase hard code "rebase" rather
than using GIT_REFLOG_ACTION.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 7 ++++---
 t/t3406-rebase-message.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 36863117fba..e50361fc2a9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -580,10 +580,11 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
-		    opts->head_name);
+	strbuf_addf(&head_reflog, "%s finished: returning to %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 8aa6a79acc1..bb2a4949abc 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 write_reflog_expect () {
 	if test $mode = --apply
 	then
-		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
+		sed 's/(finish)/finished/; s/ ([^)]*)//'
 	else
 		cat
 	fi >expect
-- 
gitgitgadget

