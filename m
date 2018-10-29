Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66FA61F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeJ3Crk (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:47:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35845 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeJ3Crk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:47:40 -0400
Received: by mail-it1-f193.google.com with SMTP id t4-v6so2195334itf.1
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/XgQCD7KxYGUNLJTH7DrHcVExAGH6oDGd3QOndRWhmg=;
        b=AHJOBRr4Lpic48SJxv3JHI6MjUfGW/pkvEY3JJB/gQZa5s8Nw6yIqm2bJbvnteIsle
         iTT7rEb3YTr0shQ7KHBwlP+0ap5wCBztcI05+5YDiijydW38J/PA/wQOlgvjH6ldTR4x
         6+Q3C9TIIQjT7CqADPfEyGGIXDEh82vL27xBJSq9+OItH6n4x4CCyp9zVaaiBngx3Ox7
         cGbM4aIrETwi5IHXodC9MjN3Ta64dSoe9G0MjHOkoU/2hGoELpcYORnncTAigwoz6Ugl
         jnnVm6UrCIKxbKL+of0qd7N8YjEjATK1o1WnAP+tphg6cPkppbhRfXgmq7HaJNWyM5/f
         yL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/XgQCD7KxYGUNLJTH7DrHcVExAGH6oDGd3QOndRWhmg=;
        b=K5RWSKeEYXra29D7iq+fhJUPrYNxI5VC7dzu+1qM9NRTJ0aYB9YzBKl7LBjsqRzhhL
         H9R0UzHuBNlOPZoJpQZfICyoeQYHItv3ktYUr6lw7mIIxuvfqqeLQmQkqaHdBj7vfr9J
         lGCfqfquyXMeGCcDaBNsbqMZ8n83qGk3CF27rg6i6GWITCcx8M77E3Zg9p/9XSfXO9IR
         Rohcnz1RnUscI7w1GLNftYEoOO3qqOZcaA5IgpGiiLPh1bYkJ+BtmQBVJS9W51BRcE2W
         RCEusWA/wbxhydD9mA1Kwx8dL9lXllruK+G4P9iDu2Whc9+QpcYX4AHG5vjv2sF7BznG
         /hZg==
X-Gm-Message-State: AGRZ1gJlAfhnD31wjl1VC4uHNGRbH0CTJFrdqWdn5mr/W93zSBSdu7CH
        72LQUSub6bEW6EDBTo/xiGm32nbF
X-Google-Smtp-Source: AJdET5cEE4e0Uma7nzNa3XB0KCimhUysI09BMkFwGQ/7gF6OdVgPtLLyDeAA51rOsSTNn9DGLMU+fw==
X-Received: by 2002:a24:ee46:: with SMTP id b67-v6mr12527486iti.19.1540835879037;
        Mon, 29 Oct 2018 10:57:59 -0700 (PDT)
Received: from archbookpro.localdomain ([209.226.201.236])
        by smtp.gmail.com with ESMTPSA id w189-v6sm6839912itb.40.2018.10.29.10.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 10:57:58 -0700 (PDT)
Date:   Mon, 29 Oct 2018 13:57:55 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: [PATCH] completion: use builtin completion for format-patch
Message-ID: <31160e8c63399e8c866eef40462d0b699bae9b59.1540835698.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d63d2dffd..da77da481 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1531,15 +1531,6 @@ _git_fetch ()
 	__git_complete_remote_or_refspec
 }
 
-__git_format_patch_options="
-	--stdout --attach --no-attach --thread --thread= --no-thread
-	--numbered --start-number --numbered-files --keep-subject --signoff
-	--signature --no-signature --in-reply-to= --cc= --full-index --binary
-	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
-	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
-	--output-directory --reroll-count --to= --quiet --notes
-"
-
 _git_format_patch ()
 {
 	case "$cur" in
@@ -1550,7 +1541,7 @@ _git_format_patch ()
 		return
 		;;
 	--*)
-		__gitcomp "$__git_format_patch_options"
+		__gitcomp_builtin format-patch
 		return
 		;;
 	esac
-- 
2.19.1

