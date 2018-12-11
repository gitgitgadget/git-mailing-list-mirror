Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE21C211B4
	for <e@80x24.org>; Tue, 11 Dec 2018 14:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLKO6N (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 09:58:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41863 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKO6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 09:58:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so6747561pgh.8
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 06:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2zAVFgByiYaZhRv1KMxW+b14Ef/qtVYjHxNui6FH3Ms=;
        b=U8qH0AyNGaw5QJhJBpVoqNULzGezyupGhdhJF77dMa18VtmmV/bPquql6S98D7ruwu
         9CwRyFVLmsUVDOmmk7erKRJyEuTwJ9TN1W3K7gqmTTqSfLawXjh7GiHWB5ujy8SI7kTS
         KkvkjH5YfrwIt14UIzJ/+1Cr8kRSC1GISH7w1C+93wjZ34qB2RsMJwXH0oOmYYBaV7SQ
         JufV62Nd7CVphhnl6wUyVWsKyoSnWS4N9yCUeMsoEhby5gjWlZwN0D4EsTCxDRmI6h0R
         uPDyQDZc/+IxxE+sJgcH9rVTY+Us8SM+eYkjN6PwxOF7LDnqFmMawnX3GuF9juH8jJCp
         YnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2zAVFgByiYaZhRv1KMxW+b14Ef/qtVYjHxNui6FH3Ms=;
        b=f9o/pY/qORbzKE8ogNN/i86TV46aQaUpd7eK5Yt6dE3rYojqIKAwWq6rEkHe4Kqv85
         roAxV6lslMLVn6Ik6lm0fkaItuVpqcppyNaVpK6phJHEPGC41WkDxZzzZED+m4ariqEu
         nw0VCKQGgIoL66GYaJN6BSfoS7Ke78q6kxRC7mrXatYeZv3+bZ7vL6EEpYX86BRAQCQI
         TyjoSVLl/I99Z5tiICUaiIhM4Bcc9v0oVKx/AuIm6G7Gvk/Ikt2CMeyxGZC82MV3Fvw2
         82kz7Zi0VTC+/JOYMMm8nnKSQECa+LSFNifALyR/NLPEva1N/3S0XPJ2cvpA7kVEWhnU
         Ud3A==
X-Gm-Message-State: AA+aEWZTc38RvMG2zGvMN5m0PbP06ku44IUFGuNwKzFLAi9fh1qJjH/X
        bbmdewp3dFOV16TVh7RBy48rtph5
X-Google-Smtp-Source: AFSGD/VjFJRD8zX8IFygZod0vzM0t0j1hAksHcNfESF/mEA3udckvc6N2NvqcPf2vdQ/OX7Fg0rHBg==
X-Received: by 2002:a62:1bd7:: with SMTP id b206mr16509072pfb.213.1544540291810;
        Tue, 11 Dec 2018 06:58:11 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 84sm33462181pfk.134.2018.12.11.06.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:58:11 -0800 (PST)
Date:   Tue, 11 Dec 2018 06:58:11 -0800 (PST)
X-Google-Original-Date: Tue, 11 Dec 2018 14:58:06 GMT
Message-Id: <850cd5d15abe5b8a4356efe86ba81bc032278dce.1544540287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.97.git.gitgitgadget@gmail.com>
References: <pull.97.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] help -a: handle aliases with long names gracefully
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We take pains to determine the longest command beforehand, so that we
can align the category column after printing the command names.

However, then we re-use that value when printing the aliases. If any
alias name is longer than the longest command name, we consequently try
to add a negative number of spaces (but `mput_char()` does not expect
any negative values and simply decrements until the value is 0, i.e.
it tries to add close to 2**31 spaces).

Let's fix this by adjusting the `longest` variable before printing the
aliases.

This fixes https://github.com/git-for-windows/git/issues/1975.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 help.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 4745b32299..ff05fd22df 100644
--- a/help.c
+++ b/help.c
@@ -83,8 +83,9 @@ static void print_command_list(const struct cmdname_help *cmds,
 
 	for (i = 0; cmds[i].name; i++) {
 		if (cmds[i].category & mask) {
+			size_t len = strlen(cmds[i].name);
 			printf("   %s   ", cmds[i].name);
-			mput_char(' ', longest - strlen(cmds[i].name));
+			mput_char(' ', longest > len ? longest - len : 1);
 			puts(_(cmds[i].help));
 		}
 	}
@@ -526,6 +527,13 @@ void list_all_cmds_help(void)
 
 	git_config(get_alias, &alias_list);
 	string_list_sort(&alias_list);
+
+	for (i = 0; i < alias_list.nr; i++) {
+		size_t len = strlen(alias_list.items[i].string);
+		if (longest < len)
+			longest = len;
+	}
+
 	if (alias_list.nr) {
 		printf("\n%s\n", _("Command aliases"));
 		ALLOC_ARRAY(aliases, alias_list.nr + 1);
-- 
gitgitgadget
