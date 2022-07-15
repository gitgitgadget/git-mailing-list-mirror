Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65386C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiGOCi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbiGOCiu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:38:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAD213DD4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:38:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2230053wmb.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hvfoc8unMaEmjzxkbxlLn6cq/ISSTIo+LgnkVDfLiHw=;
        b=N6RsoOBCN6KlTxehauttsbabfdl1jrcXk3A1asKl05plnVB6CUK09W3BHq8YJTDZsA
         D7q2A3nwaOXf8lxxHo3fV4taHbUf0ZTXohoELnKAcmXyjYeYG/x9ZwLRgXZIlGU0fSDq
         I5VfiLGWpyKgocScFjs9+1ci9+22bS5/il4xosUm6cII7T/mG501Wrq4QpAHbTAjaaJd
         01OYUg/KeHDcoresaLq7B/349jhtKnWacarew1qIA78Fb7Zdmn4mStVQR+rO7O/X+vi4
         vtmzuInuBiu19HmBR5IYsezkZxWtknbpo/Z9frn51yCiW3tv/H6qjkyaizbKbgvBtCiM
         lgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hvfoc8unMaEmjzxkbxlLn6cq/ISSTIo+LgnkVDfLiHw=;
        b=T0+wxhRSNTFHXjJOThmlXDOhlOBqiALWHqRy1QE5wSRry4N+umtdYsT3Dt8RJJS378
         ChITiM92fIayA8Uzgrs4909395VnZpO6bBmrUL+UbXOnZBnfZYN3UgDedY99TyCkdpbp
         jNqLtQVoKi0XS6TLmhnl1zFO1AeiV44ctgEROFFWJBCCUMhyaS94fX0u8e7lr9Dk7VIj
         K2TgXfjfm7qXRzvcBXmSIz/NaGSwJc52R1nLtupTqWmmFoGjD5C8+v8o7VRnaJRR9Vlq
         lHmnTrhW2A+amGr6vWa44ff7nu7KZWDMBWNhEZ/Ug4gRNuEzD5zn6n9pljDaPBiZhaGy
         QoOg==
X-Gm-Message-State: AJIora8u+OrLNP5KqJTTFhQ54nUHF6ldkA2irHyyaJ07ySQg9qbuzHY1
        NvoIv9AdRSHL/DNE4kpSDYqm06pFa2A=
X-Google-Smtp-Source: AGRyM1srppYfDo7E0Iev8b00QyxdbutWvBscqdOrlfSVMNotQ/hlnT9DSBCE3XbusSE1W12vwVQaPQ==
X-Received: by 2002:a05:600c:2157:b0:3a2:fea7:4390 with SMTP id v23-20020a05600c215700b003a2fea74390mr9205986wml.117.1657852727382;
        Thu, 14 Jul 2022 19:38:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1-20020adfebc1000000b0021b98d73a4esm2743704wrn.114.2022.07.14.19.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:38:46 -0700 (PDT)
Message-Id: <0d862cbbebe1a9f47f72255217faf734b1db4055.1657852722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
        <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Jul 2022 02:38:42 +0000
Subject: [PATCH v2 3/3] *: avoid "whitelist"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The word "whitelist" has cultural implications that are not inclusive.
Thankfully, it is not difficult to reword and avoid its use.

A previous change already modified the documentation for git-cvsserver
and git-daemon to refer to a directory list. It is simple to update the
comments and error messages here to refer to that directory list.

In the case of transport.c, the GIT_ALLOW_PROTOCOL environment variable
was referred to as a "whitelist", but the word "allow" is already part
of the variable. Replace "whitelist" with "allow_list" in these cases to
demonstrate that we are processing a list of allowed protocols.

After this change, the only remaining uses of "whitelist" and its
companion "blacklist" are in release notes for older versions of Git and
in the sha1dc project, which is maintained independently.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 daemon.c           | 8 ++++----
 git-cvsserver.perl | 2 +-
 transport.c        | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/daemon.c b/daemon.c
index 58f1077885c..e0706efc652 100644
--- a/daemon.c
+++ b/daemon.c
@@ -279,7 +279,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		/* The validation is done on the paths after enter_repo
 		 * appends optional {.git,.git/.git} and friends, but
 		 * it does not use getcwd().  So if your /pub is
-		 * a symlink to /mnt/pub, you can whitelist /pub and
+		 * a symlink to /mnt/pub, you can include /pub and
 		 * do not have to say /mnt/pub.
 		 * Do not say /pub/.
 		 */
@@ -298,7 +298,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 			return path;
 	}
 
-	logerror("'%s': not in whitelist", path);
+	logerror("'%s': not in directory list", path);
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
@@ -403,7 +403,7 @@ static int run_service(const char *dir, struct daemon_service *service,
 	 * a "git-daemon-export-ok" flag that says that the other side
 	 * is ok with us doing this.
 	 *
-	 * path_ok() uses enter_repo() and does whitelist checking.
+	 * path_ok() uses enter_repo() and checks for included directories.
 	 * We only need to make sure the repository is exported.
 	 */
 
@@ -1444,7 +1444,7 @@ int cmd_main(int argc, const char **argv)
 		cred = prepare_credentials(user_name, group_name);
 
 	if (strict_paths && (!ok_paths || !*ok_paths))
-		die("option --strict-paths requires a whitelist");
+		die("option --strict-paths requires a directory list");
 
 	if (base_path && !is_directory(base_path))
 		die("base-path '%s' does not exist or is not a directory",
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 4c8118010a8..ec64f06af7c 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -152,7 +152,7 @@ $state->{allowed_roots} = [ @ARGV ];
 
 # don't export the whole system unless the users requests it
 if ($state->{'export-all'} && !@{$state->{allowed_roots}}) {
-    die "--export-all can only be used together with an explicit whitelist\n";
+    die "--export-all can only be used together with an explicit directory list\n";
 }
 
 # Environment handling for running under git-shell
diff --git a/transport.c b/transport.c
index 52db7a3cb09..b51e991e443 100644
--- a/transport.c
+++ b/transport.c
@@ -940,7 +940,7 @@ static int external_specification_len(const char *url)
 	return strchr(url, ':') - url;
 }
 
-static const struct string_list *protocol_whitelist(void)
+static const struct string_list *protocol_allow_list(void)
 {
 	static int enabled = -1;
 	static struct string_list allowed = STRING_LIST_INIT_DUP;
@@ -1020,9 +1020,9 @@ static enum protocol_allow_config get_protocol_config(const char *type)
 
 int is_transport_allowed(const char *type, int from_user)
 {
-	const struct string_list *whitelist = protocol_whitelist();
-	if (whitelist)
-		return string_list_has_string(whitelist, type);
+	const struct string_list *allow_list = protocol_allow_list();
+	if (allow_list)
+		return string_list_has_string(allow_list, type);
 
 	switch (get_protocol_config(type)) {
 	case PROTOCOL_ALLOW_ALWAYS:
-- 
gitgitgadget
