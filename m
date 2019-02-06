Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 781A01F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfBFRQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39086 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbfBFRQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so6529679edt.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=mr3iKXEwZkYg+cRA5ozwMgbFw5t66UjW7JANCdp489Orauq78edUq23bonIaAvxS95
         cTJdIY91XsxoFugqde4X9DnmxKDLBWxVZhblmL6BQ540SkxmZveAmCIbJrgeDAGmBoXU
         H+nj0gGYC1flgNilp+RnF1Or4vH5wXJTYlKmaZYNoJr/6SWTk0h5WrMF2F2hFCbz4nUh
         Ko9WXEmGbarFoO0EwczvJbh3ckIUZsUYk+eBqyxNp5JTFP2EJZAzPpBthB7nU4XaFSkf
         U1To9cz8uNlMIx6VCRY5jMdYeuB1uVg54FcwOxBTfOIgExRUZO+BFWoa/5XuZtjY9Z93
         Q0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=VZNzzq+AhQ2cxhml7sNeE5hRoto57FNkcMo/43QHTYaS5WjW98gbh0OcKJcMiwv2ei
         HE21wXXz3w2ZK1/lOd5qQmOYvY9f4XuyBn/gfRe8PqArfTJNs202parOwYrK4yXqBh5F
         azU0jMDOyB2JL9x5stcgjsUDEDjvP0AshbGEn0sERzgx4BhymLasMrrcY0fECKI9Mwto
         hBKP9SsFof1PDpv0r6h/+mxAmI5WTEF8NyGKqnJCC9iVn0WTUPh6sHNkpuhETBTbaWp1
         f57of3j2NddRNsv/maFVoBASrtUxYy8ObGYOGeoCo63i62Q+9PVpwjGYz7XmN9ybFWa9
         /YcQ==
X-Gm-Message-State: AHQUAuYSVc+R3m1sTK6e3Au+URinobxjMW1hDJQ8deLH4nn9t/L/tlY1
        Zq9JYl4CrjgAUKUXdasTHBsY9DCl
X-Google-Smtp-Source: AHgI3IZCcrhStJYV+0cwmovg+qYMNnz7HsScly1LJlVqD9hsJXA//cCyNoqTAGbtnHuwxZBBERGrkw==
X-Received: by 2002:a17:906:1248:: with SMTP id u8mr8270010eja.33.1549473359671;
        Wed, 06 Feb 2019 09:15:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x58sm6073116edm.10.2019.02.06.09.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:15:59 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:15:59 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:42 GMT
Message-Id: <b70c289903d295da9fb89e587fc0d0d082b5ecc5.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 07/15] trace2:data: add trace2 transport child
 classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 child classification for transport processes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 connect.c          | 3 +++
 transport-helper.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/connect.c b/connect.c
index 24281b6082..3c6f829a05 100644
--- a/connect.c
+++ b/connect.c
@@ -1251,6 +1251,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
 		conn = git_connect_git(fd, hostandport, path, prog, version, flags);
+		conn->trace2_child_class = "transport/git";
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
@@ -1293,9 +1294,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				strbuf_release(&cmd);
 				return NULL;
 			}
+			conn->trace2_child_class = "transport/ssh";
 			fill_ssh_args(conn, ssh_host, port, version, flags);
 		} else {
 			transport_check_allowed("file");
+			conn->trace2_child_class = "transport/file";
 			if (version > 0) {
 				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 						 version);
diff --git a/transport-helper.c b/transport-helper.c
index 6cf3bb324e..a01cc0093f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -127,6 +127,8 @@ static struct child_process *get_helper(struct transport *transport)
 		argv_array_pushf(&helper->env_array, "%s=%s",
 				 GIT_DIR_ENVIRONMENT, get_git_dir());
 
+	helper->trace2_child_class = helper->args.argv[0]; /* "remote-<name>" */
+
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die(_("unable to find remote helper for '%s'"), data->name);
-- 
gitgitgadget

