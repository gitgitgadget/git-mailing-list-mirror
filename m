Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4939FC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbiEYPCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiEYPB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6992E4
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so11875017wrg.12
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=BosjjlA3Gv+q6+td9cgqxOEAe5yrdqAUvyGOYBeAbElPZ/VzY2yX3bDd4g9pLQzkQu
         +t+1VzG5h/pFGAnjHVkFq7Q3XiSB0cNrZArCN/GJfEKDW+Aab0awiJp0R5v7CQyzPlQz
         ddxZXjGRzyXOo35kAbDCy9ulsSmlmNyfck9pyE/VxviOFobZQlRfZ5a6zeVuLOLShMEc
         cPXHsET6dpcA1/nTtzb9y2fJ5PNBOu/jhlbZ9IqdrFUdu0jwXXmvFcNFldNwIvNN6e/e
         CPmWI+5r8T+Z3tm7aSwXkKM3Wn4MbsRx9r6VzHWLdthBUoVO15S09U02C6Oe/RMw65HB
         ytjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=KYIafoi1CMxXc0XLHwoxOupv+WY4CHqXcI9m3wARIkhHHyASn/jlaLtEuiMkhUk+7u
         mYX4wSZ/N3yOCZXTyI6Pgn/h9Hz/s3TN9bi8A2nh850lkuad0VVzngvcLhS9enBctI60
         5Yd48lRfYNd2OTaFGgo+iBPY4c6CNZdmLim9SvqNsu2jLRqQ14AtyhPXX7OG4+Yx67aZ
         cxsSvhsN3mTLBgihUbgrxOzo9/vVA2wmVV6dLuFnZfE2tfYQivpqiPg6HcWFAA+cdXTA
         PKIVtccVI/7Bq/wkoa31CiQtVBHKP93d27j97f02HR8sQ4C2xCfpuij+39YORHrWdMU7
         Jcjw==
X-Gm-Message-State: AOAM5305jhb2xQZu8x/xEWwdSsW1/Lu2PRZUe7p4h+c0dMYCkltYZWIF
        21Ny9npcX5K6z0BPG4pKt46H/l/DDEM=
X-Google-Smtp-Source: ABdhPJxVfUTXr7wy/82Zl7k4UXigV7RWhSOjZCXj3UNys9Bv9c62JNvGy+dahut5kdy74vo1J7wpSw==
X-Received: by 2002:adf:d1cf:0:b0:20f:d7fd:4d68 with SMTP id b15-20020adfd1cf000000b0020fd7fd4d68mr13979585wrd.13.1653490883694;
        Wed, 25 May 2022 08:01:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi27-20020a05600c3d9b00b003942a244ee7sm2265512wmb.44.2022.05.25.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:23 -0700 (PDT)
Message-Id: <95cf1299d445696630d8c0850a69dc2c0ee040ce.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:41 +0000
Subject: [PATCH v8 19/30] fsm-listen-darwin: shutdown daemon if worktree root
 is moved/renamed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the listener thread to shutdown the daemon if the spelling of the
worktree root directory changes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 07113205a61..83d38e8ac6c 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -106,6 +106,11 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	strbuf_release(&msg);
 }
 
+static int ef_is_root_changed(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagRootChanged);
+}
+
 static int ef_is_root_delete(const FSEventStreamEventFlags ef)
 {
 	return (ef & kFSEventStreamEventFlagItemIsDir &&
@@ -215,6 +220,26 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			continue;
 		}
 
+		if (ef_is_root_changed(event_flags[k])) {
+			/*
+			 * The spelling of the pathname of the root directory
+			 * has changed.  This includes the name of the root
+			 * directory itself or of any parent directory in the
+			 * path.
+			 *
+			 * (There may be other conditions that throw this,
+			 * but I couldn't find any information on it.)
+			 *
+			 * Force a shutdown now and avoid things getting
+			 * out of sync.  The Unix domain socket is inside
+			 * the .git directory and a spelling change will make
+			 * it hard for clients to rendezvous with us.
+			 */
+			trace_printf_key(&trace_fsmonitor,
+					 "event: root changed");
+			goto force_shutdown;
+		}
+
 		if (ef_ignore_xattr(event_flags[k])) {
 			trace_printf_key(&trace_fsmonitor,
 					 "ignore-xattr: '%s', flags=0x%x",
-- 
gitgitgadget

