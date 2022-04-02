Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62BFC433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 16:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357838AbiDBQNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357799AbiDBQMx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 12:12:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2C2BB04
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 09:11:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso3128303wmn.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=EwPq+9rE7e8zBOOW8EY1TMYNsoLygqEpgTGSLz2TGu8=;
        b=JDGMNaWv8x7DtrGNfHvugeMfvSj/h+3CiHqyI/2EAOF068HIAxFT+fqWHFeQNSRgaw
         LBcw15TfS6TUSsycnfI3GJZ9l27EeDszaebptwEM0tQmQghBOvuPNiIMdQMHlDa5XLHc
         uw8aE6gaFNIXQIC3dAzm/ot0d/qZjcxykYo1E7h1ALwmuDRMZ/JUynd5k0i38t7cmMZS
         c25WMD8w5SiC05Lm+gw8Hb4RUq1siocrRSeVUGmjw9A/UldSGJH/6Ne6g9aYw7kF+o/8
         BZoJUr8lrGSbrLzwDGT6gkGTe4nyEk+Db8WlyQcwjEtrq9zUBdhIJvX6hz63tejj3jcD
         Ny6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=EwPq+9rE7e8zBOOW8EY1TMYNsoLygqEpgTGSLz2TGu8=;
        b=766KLi12IisOayGd7xjN0+DGSs5x6aDmxFijTB2eu6ffX945RJ8JSCTVw/mYxQGFE4
         AQcnxG5lCZ+U0XjF8TajqDT7dfG8boBZW1Mx7/7bUuhSc+fpzVuV5H3FfG33XTy/JeiN
         07uRW/lfyWGg2e92CQfTAKz40ZzsmA16dQBuqy1b1NcJDIamt5+m0dvQnYYQT7u0HlVF
         vKw7Mb3/GXRd35e2mIpwCONj/Nxxu1qbIKNZMhNh49yv/ojeq3w4OpM7jcqLUVkIkzLh
         KWNhBo0RukqRPkCGE/GJOx35BjHhQpedvokNkZeuM5kfpEJub5GaXNJ6rC6AvmIJbpKb
         9dZg==
X-Gm-Message-State: AOAM531gz97kAHIirOyXrv4wjkifjHYbNsDa54P3DiVTf0K05bdhwBAQ
        bXyYYbsFtYBoT15AI7BiI9PIGSnpmso=
X-Google-Smtp-Source: ABdhPJzKXD83I0o4jvbSUXe1fE+tZrCarCmBx4oTjdkEBkKUUzSU6kralfWFV0rNCZ8BRVT7lHk5cw==
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id s1-20020a7bc381000000b0037be01fc1c0mr13333739wmj.98.1648915858373;
        Sat, 02 Apr 2022 09:10:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5-20020adfde05000000b00205bdc6bd57sm5146430wrm.95.2022.04.02.09.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:10:58 -0700 (PDT)
Message-Id: <b06b76705163e49fe69680ceb3bf925fcfe8dc58.1648915853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
        <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 02 Apr 2022 16:10:50 +0000
Subject: [PATCH v2 3/6] i18n: factorize server support messages in fetch-pack
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The messages "Server supports foo" and "Server does not support bar"
are uniformized and options are quoted.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 fetch-pack.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 2e6795cd439..da3075f61f2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1044,78 +1044,78 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		advertise_sid = 0;
 
 	if (server_supports("shallow"))
-		print_verbose(args, _("Server supports %s"), "shallow");
+		print_verbose(args, _("Server supports '%s'"), "shallow");
 	else if (args->depth > 0 || is_repository_shallow(r))
 		die(_("Server does not support shallow clients"));
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 	if (server_supports("multi_ack_detailed")) {
-		print_verbose(args, _("Server supports %s"), "multi_ack_detailed");
+		print_verbose(args, _("Server supports '%s'"), "multi_ack_detailed");
 		multi_ack = 2;
 		if (server_supports("no-done")) {
-			print_verbose(args, _("Server supports %s"), "no-done");
+			print_verbose(args, _("Server supports '%s'"), "no-done");
 			if (args->stateless_rpc)
 				no_done = 1;
 		}
 	}
 	else if (server_supports("multi_ack")) {
-		print_verbose(args, _("Server supports %s"), "multi_ack");
+		print_verbose(args, _("Server supports '%s'"), "multi_ack");
 		multi_ack = 1;
 	}
 	if (server_supports("side-band-64k")) {
-		print_verbose(args, _("Server supports %s"), "side-band-64k");
+		print_verbose(args, _("Server supports '%s'"), "side-band-64k");
 		use_sideband = 2;
 	}
 	else if (server_supports("side-band")) {
-		print_verbose(args, _("Server supports %s"), "side-band");
+		print_verbose(args, _("Server supports '%s'"), "side-band");
 		use_sideband = 1;
 	}
 	if (server_supports("allow-tip-sha1-in-want")) {
-		print_verbose(args, _("Server supports %s"), "allow-tip-sha1-in-want");
+		print_verbose(args, _("Server supports '%s'"), "allow-tip-sha1-in-want");
 		allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
 	}
 	if (server_supports("allow-reachable-sha1-in-want")) {
-		print_verbose(args, _("Server supports %s"), "allow-reachable-sha1-in-want");
+		print_verbose(args, _("Server supports '%s'"), "allow-reachable-sha1-in-want");
 		allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
 	}
 	if (server_supports("thin-pack"))
-		print_verbose(args, _("Server supports %s"), "thin-pack");
+		print_verbose(args, _("Server supports '%s'"), "thin-pack");
 	else
 		args->use_thin_pack = 0;
 	if (server_supports("no-progress"))
-		print_verbose(args, _("Server supports %s"), "no-progress");
+		print_verbose(args, _("Server supports '%s'"), "no-progress");
 	else
 		args->no_progress = 0;
 	if (server_supports("include-tag"))
-		print_verbose(args, _("Server supports %s"), "include-tag");
+		print_verbose(args, _("Server supports '%s'"), "include-tag");
 	else
 		args->include_tag = 0;
 	if (server_supports("ofs-delta"))
-		print_verbose(args, _("Server supports %s"), "ofs-delta");
+		print_verbose(args, _("Server supports '%s'"), "ofs-delta");
 	else
 		prefer_ofs_delta = 0;
 
 	if (server_supports("filter")) {
 		server_supports_filtering = 1;
-		print_verbose(args, _("Server supports %s"), "filter");
+		print_verbose(args, _("Server supports '%s'"), "filter");
 	} else if (args->filter_options.choice) {
 		warning("filtering not recognized by server, ignoring");
 	}
 
 	if (server_supports("deepen-since")) {
-		print_verbose(args, _("Server supports %s"), "deepen-since");
+		print_verbose(args, _("Server supports '%s'"), "deepen-since");
 		deepen_since_ok = 1;
 	} else if (args->deepen_since)
-		die(_("Server does not support --shallow-since"));
+		die(_("Server does not support '%s'"), "--shallow-since");
 	if (server_supports("deepen-not")) {
-		print_verbose(args, _("Server supports %s"), "deepen-not");
+		print_verbose(args, _("Server supports '%s'"), "deepen-not");
 		deepen_not_ok = 1;
 	} else if (args->deepen_not)
-		die(_("Server does not support --shallow-exclude"));
+		die(_("Server does not support '%s'"), "--shallow-exclude");
 	if (server_supports("deepen-relative"))
-		print_verbose(args, _("Server supports %s"), "deepen-relative");
+		print_verbose(args, _("Server supports '%s'"), "deepen-relative");
 	else if (args->deepen_relative)
-		die(_("Server does not support --deepen"));
+		die(_("Server does not support '%s'"), "--deepen");
 	if (!server_supports_hash(the_hash_algo->name, NULL))
 		die(_("Server does not support this repository's object format"));
 
-- 
gitgitgadget

