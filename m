Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EADC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbiEPU2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348774AbiEPU1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:27:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7F118386
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so213577wme.5
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=wZpY20xg1QCdEl2cqv2CF8ziDvQ7Pr5cuiwF4YhmDLU=;
        b=nfZoMMHxphRrNNcRLWH1wRQq9/MRlFT9YpUf0ikmjayE9W7aOUixzABBQ9lIznz++A
         8/ddkjqOQ484H7RM/RTJW9UURXHEGDMc/FHjx9uKivPbir3uD2E3qHtzAqGPHau/3yZL
         oCyW+y+KM8To73qffrbBzlljt5mpONrUzRk2mbsozy6PX0oBYgrr6YPoY5LKN6CZNRhi
         4YZEO4RudilAAtjfSzUpLjfqy5NY5lt84vUznxgW2tqus3CTLHl64OxAhQFDgUPH6+ly
         HK8bObLO1DvIKUxeFeFSwcsD1nnzzrFEi93k3vGc+m7/qCX9xqeWV4TetbCTGv7s7Vpv
         1dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=wZpY20xg1QCdEl2cqv2CF8ziDvQ7Pr5cuiwF4YhmDLU=;
        b=gZIM2S/ON/9wvHTeAH8f+L54/B7U9LvugBoUnKPv9XBotwFDaJWYERh5/zDw6of2Lp
         zi0aFh3zoruUyTIRH2g8Fn4x9Sv7C5xqI3nedpwWsqCMrhGYsnSLiHF1/TGi7dJmuVCg
         THCMz4EnvWpfODZ4Rv81+auDlK5Hd4tXSODp+0sqnAgLJaR4eTG/tNfcFHTjCqPBFYBg
         pYADa2FeHNMKVXuoWPTm4nQwGECSFQSr4O7L4ByTrH3apg3jUjgk9AjbYvscDgNGilUY
         x73nq7hturw89wbM/dWdOozdImp22migcLC+ESXITdjbjY6p1yDTHV9L2IPQ1mslB26a
         NY/w==
X-Gm-Message-State: AOAM531kJMC/Wfr0+FzimOVB1T3KoRPU+VaV0FhQlGK2O9VMF30YktNG
        DbJxqdhUQNEdMk66mnI990Mqj3B4T2s=
X-Google-Smtp-Source: ABdhPJwxVqPnz5LdCFbxr9311G+qJuYfs6wu0PJYU7lnmYt1xuVxaluM0BlmXpArcJQeZzYtt1d9DA==
X-Received: by 2002:a05:600c:1f13:b0:396:fee5:ebcf with SMTP id bd19-20020a05600c1f1300b00396fee5ebcfmr8169041wmb.201.1652731868615;
        Mon, 16 May 2022 13:11:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020adf9c88000000b0020d106c0386sm1766364wre.89.2022.05.16.13.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:08 -0700 (PDT)
Message-Id: <bd592ebba4179bb3f6adc0f67e4c026fe07c426b.1652731865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
References: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 20:10:58 +0000
Subject: [PATCH 1/8] connect.c: refactor sending of agent & object-format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, albertqcui@gmail.com, robbat2@gentoo.org,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Refactor the sending of the "agent" and "object-format" capabilities
into a function.

This was added in its current form in ab67235bc4 (connect: parse v2
refs with correct hash algorithm, 2020-05-25). When we connect to a v2
server we need to know about its object-format, and it needs to know
about ours. Since most things in connect.c and transport.c piggy-back
on the eager getting of remote refs via the handshake() those commands
can make use of the just-sent-over object-format by ls-refs.

But I'm about to add a command that may come after ls-refs, and may
not, but we need the server to know about our user-agent and
object-format. So let's split this into a function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 connect.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/connect.c b/connect.c
index afc79a6236e..e6d0b1d34bd 100644
--- a/connect.c
+++ b/connect.c
@@ -473,6 +473,24 @@ void check_stateless_delimiter(int stateless_rpc,
 		die("%s", error);
 }
 
+static void send_capabilities(int fd_out, struct packet_reader *reader)
+{
+	const char *hash_name;
+
+	if (server_supports_v2("agent", 0))
+		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
+
+	if (server_feature_v2("object-format", &hash_name)) {
+		int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo == GIT_HASH_UNKNOWN)
+			die(_("unknown object format '%s' specified by server"), hash_name);
+		reader->hash_algo = &hash_algos[hash_algo];
+		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
+	} else {
+		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	}
+}
+
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     struct transport_ls_refs_options *transport_options,
@@ -480,7 +498,6 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     int stateless_rpc)
 {
 	int i;
-	const char *hash_name;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	const char **unborn_head_target = transport_options ?
@@ -490,18 +507,8 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (server_supports_v2("ls-refs", 1))
 		packet_write_fmt(fd_out, "command=ls-refs\n");
 
-	if (server_supports_v2("agent", 0))
-		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
-
-	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo == GIT_HASH_UNKNOWN)
-			die(_("unknown object format '%s' specified by server"), hash_name);
-		reader->hash_algo = &hash_algos[hash_algo];
-		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
-	} else {
-		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
-	}
+	/* Send capabilities */
+	send_capabilities(fd_out, reader);
 
 	if (server_options && server_options->nr &&
 	    server_supports_v2("server-option", 1))
-- 
gitgitgadget

