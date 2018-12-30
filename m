Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93AC21F770
	for <e@80x24.org>; Sun, 30 Dec 2018 05:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbeL3FcN (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 00:32:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43391 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeL3FcN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 00:32:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so12080924pfk.10
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 21:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sALHYwJw31OkgkPXDuqn9STQ6ntxhlUMtaejlwsIbCA=;
        b=M2BfYVhaAfrhe4XcpIJNSyvr8KB0OxRNIV9+YWxi5LliSOXrig6CiVxLdaPz7szTRv
         Ec1kEW0ew+lqxsuB1ynYZbXEnoLz2djYyvuLCAWBUqDL/jxvyFbk5z6kfxjn1gkqUQ7a
         u1aXeEJw5sG44p4LpIlEQudRIjK7H2qV4uYMrJD/2OG4QEkHlT4dO8Wn0j8YrKsZw/Al
         H70vG6s7Oq+XthVmFDKye4Zyd4kHvQJkLGs6ZYuHgq0wxcsy8btY1Oo9bRElgey1/7iw
         ZBFKKRIk5z6x/mgbZJ+y0vCIMNEcgHrYbdiCwNWkjtYYxAyDuE3TZJoRQ+Wvo93vJWi5
         Kpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sALHYwJw31OkgkPXDuqn9STQ6ntxhlUMtaejlwsIbCA=;
        b=GqPtenYbAkXiFELQtke08ElbiU0VjWdztb05gXm9p65VWaqxw+KlRWGYK6MFbH9g5s
         R+i4PM+NiEqf0hSXDMIO6Kd/mUjOKBC/a66H8liCac6xfNffwglnOHzsUC9e8SWy3Or6
         hN349jNmgd+2YeucugUA6UQE+fDwWeofqU/6Gfd1QKMKMZnhiLXcERXSLntKp0GsXVK1
         CSUvwxqwEQ6a8NRYqBcEM5zX+QskIBRhEPxWUFZMrtCecARQku/jRDAp9+oEd2mcVtcR
         y7IE+c40h5gzQKtF3Kh9Y1pSCpZlSOWvyqHsyOm+vd/3Bja+iLt0ex/1OIFD0rWVNa73
         YDgw==
X-Gm-Message-State: AJcUukc+9wqw2X5H9OMuiof9oft0J2Q1PO9j0AiqGNgdceJbDlkkAMcl
        J4VmW0Dqu+wHtBFqsE1O+2VmiaNF
X-Google-Smtp-Source: ALg8bN5t/ToT+HHuDC9aQqcV5lCfj3TclwKDKigY2+N2E/Cqa9tztUDRTxSx9tbezPklstu/yIQSEA==
X-Received: by 2002:a62:8d4f:: with SMTP id z76mr34856689pfd.2.1546147931899;
        Sat, 29 Dec 2018 21:32:11 -0800 (PST)
Received: from localhost.localdomain ([39.119.71.29])
        by smtp.gmail.com with ESMTPSA id 22sm57404259pgd.85.2018.12.29.21.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Dec 2018 21:32:11 -0800 (PST)
From:   Chayoung You <yousbe@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] zsh: complete unquoted paths with spaces correctly
Date:   Sun, 30 Dec 2018 14:31:26 +0900
Message-Id: <20181230053125.55896-1-yousbe@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqefa1kzcp.fsf@gitster-ct.c.googlers.com>
References: <xmqqefa1kzcp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following is the description of -Q flag of zsh compadd [1]:

    This flag instructs the completion code not to quote any
    metacharacters in the words when inserting them into the command
    line.

Let's say there is a file named 'foo bar.txt' in repository, but it's
not yet added to the repository. Then the following command triggers a
completion:

    git add fo<Tab>
    git add 'fo<Tab>
    git add "fo<Tab>

The completion results in bash:

    git add foo\ bar.txt
    git add 'foo bar.txt'
    git add "foo bar.txt"

While them in zsh:

    git add foo bar.txt
    git add 'foo bar.txt'
    git add "foo bar.txt"

The first one, where the pathname is not enclosed in quotes, should
escape the space with a backslash, just like bash completion does.
Otherwise, this leads git to think there are two files; foo, and
bar.txt.

The main cause of this behavior is __gitcomp_file_direct(). The both
implementions of bash and zsh are called with an argument 'foo bar.txt',
but only bash adds a backslash before a space on command line.

[1]: http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html

Signed-off-by: Chayoung You <yousbe@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e8ec95c3..816ee3280 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2993,7 +2993,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -f -- ${=1} && _ret=0
+		compadd -f -- ${=1} && _ret=0
 	}
 
 	__gitcomp_file ()
@@ -3002,7 +3002,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+		compadd -p "${2-}" -f -- ${=1} && _ret=0
 	}
 
 	_git ()
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 049d6b80f..886bf95d1 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -99,7 +99,7 @@ __gitcomp_file_direct ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -f -- ${=1} && _ret=0
+	compadd -f -- ${=1} && _ret=0
 }
 
 __gitcomp_file ()
@@ -108,7 +108,7 @@ __gitcomp_file ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+	compadd -p "${2-}" -f -- ${=1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
2.20.1

