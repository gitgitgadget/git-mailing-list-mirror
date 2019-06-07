Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E6F1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfFGBJB (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:01 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56218 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:01 -0400
Received: by mail-qk1-f202.google.com with SMTP id i4so229773qkk.22
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OBydD6eL9VmS3BzqiNqy5emtEyKf3i9DZ26gosDHIaE=;
        b=jyOp+zzZ+E/7n5ldjXnh0aiDUh1YfX2XuCkt6XgCQiZqM54EiX0cXBDtx4FLLu2DqM
         sV6hBAckmGBm+9Km64fkeEwCxDd0r2k7Va4fWrPBQ5+ihIGmd5ZUZPsIuzLX2Jif8yJ7
         f3S1eQjoL50VN8bHdNULwyMbtV+KmFH+edWIm2UjwMr8vjss+OV6+tAaTsg4Hlp2ad6n
         8hT4cPTjSWkzdsW5OKoaO+YQAmLFR4QVcr0opjjRGzC9cgCAz/Sl4soU54G1cjwKg+Qk
         rUNFxqJ5LF1ALjnXa5zq+lKwcEe3TTI2sDHMpz1DXHQl4kkdMrzW4RJfYIZDM9oonzp+
         yZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OBydD6eL9VmS3BzqiNqy5emtEyKf3i9DZ26gosDHIaE=;
        b=M9ieAY+EAUHCTJ92ZbzScp/3mRLGKKiNyZNqzhHaNrDK/4P5dKj75w0Z7ZqeeIgUer
         INEvGjyFw+fFixBODLbvJLA3AfQprj2VvYhnE1u/+QvWuhaKVhnrIPd4B0vm1BD7LsOh
         zRnyjw3hFJN/JPwyixr/z0E0t3NqvBcuhe8SImrVtr/TTn43Y8E5r5Qu53+hc+8oegUR
         RP6vVgqkaRfCjm6rVwGqFbEFVo0TPq3hM4axETjFhTbaRbWiGCp9z74Ov068UiO/OoxP
         KBWugYYL+DTcOoppXhk1MdLlCIWUD7QM0tJWQV55Ohp61P05XL0DJ51JLWX3cPN0K8kN
         JPog==
X-Gm-Message-State: APjAAAVUFCasIUP/UVYuFRS8uy57eCQoaC8BMZ5wQ6UIZ9U1DyHACJkU
        mel0RH8tO/HlbXPTDFPlzYjA25gQBAE3uscTk3m5G/wOxl17Ss6StHfzhy/rx0UcYhE6OXOsJ3Q
        d3b4GJ82uz4uyFBNJHnsbV2TgkZxzPzvkFvrdOI2uuvTaN+b/SU0CeD5BjjHvQesFxutR9g7Rew
        ==
X-Google-Smtp-Source: APXvYqzW+7ReCIdW3NW5Sqz7VFFDVwTHXCcBusSKmZSWVdTvo5vQ5b6Nquz3ehORrzSGjOr+F+RpACaROfXPYnBAj4U=
X-Received: by 2002:ac8:94d:: with SMTP id z13mr15443984qth.137.1559869740616;
 Thu, 06 Jun 2019 18:09:00 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:01 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 03/13] walken: add placeholder to initialize defaults
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventually, we will want a good place to initialize default variables
for use during our revision walk(s) in `git walken`. For now, there's
nothing to do here, but let's add the scaffolding so that it's easy to
tell where to put the setup later on.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index 5ae7c7d93f..dcee906556 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -13,6 +13,18 @@ static const char * const walken_usage[] = {
 	NULL,
 };
 
+/*
+ * Within init_walken_defaults() we can call into other useful defaults to set
+ * in the global scope or on the_repository. It's okay to borrow from other
+ * functions which are doing something relatively similar to yours.
+ */
+static void init_walken_defaults(void)
+{
+	/* We don't actually need the same components `git log` does; leave this
+	 * empty for now.
+	 */
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
@@ -21,6 +33,7 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
 
+	init_walken_defaults();
 	printf(_("cmd_walken incoming...\n"));
 	return 0;
 }
-- 
2.22.0.rc1.311.g5d7573a151-goog

