Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577461F453
	for <e@80x24.org>; Tue, 30 Oct 2018 06:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeJ3PaQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 11:30:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41037 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeJ3PaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 11:30:16 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so6571384iob.8
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 23:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z3d6rUkTO7KeP/02CtZ828c0vmRx/2fHeSlTr/uV0Ww=;
        b=B99Tc3rQ9yiYsXFqmjXiSM21ws2Qtf2mvF77s7SCamlu6ETwX8FgAjjf8xq7haHetw
         dzCw96vwYclBWG0e66Jfv0CDjT5bEa4G+kvaoJM80e7Fe2e5/Rvs61fUCdWW/m0gJCeR
         y8xhQTOLygGtglRt0IBf96Z6mxQalEtUygieskoPBGJtDEt2EFc4svAEBw5LZ3QAaBRO
         v8BGdZ+GC7bdBrWdhxa9czZYd5ew8v+Fh3E8JU6Glfz4xBhLGA7qHarCMKqb4ogCCTd6
         iLsk0k1VORnZYnyQYiQOReOEHDaMC+MWmt0sHu/L/Pb2KoaoYmKrS57iR1GssnS7SQoh
         Edtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z3d6rUkTO7KeP/02CtZ828c0vmRx/2fHeSlTr/uV0Ww=;
        b=WdQmxcd/bhda4popeCDAWAck2N2yYyWU5phAh7Ci/n6OQ5NRA8mKMttR7cY9boipa4
         MXsxw/7mTHkRSKWq+lwIHCnd9luqqxsjOYR1uP6BK3J1PjUylitl99Oq0Elplu6U8ek5
         ljywPjF5mco9P6mHMCjJHeEgVws26xwezxOi2/tg2c8PhK7q+TgDhnt9SsMAPapmz60W
         Zb2YEUth6KWR84QRCse6IDFLojwFdK4Q0mPu04nRMt7eIVuBf4BBqIdJgIfgokx61KDc
         dwuiUFBGU0HeFMGK+c8ZmuDsD/Cz+gnLc+CBbQkagNqSyWfQpPjW7BE6gZg5DR+WHXXF
         E4sw==
X-Gm-Message-State: AGRZ1gKTdU/YbX8vyNERoBTsZQIdzlky9G/UAxan36+FZ/TG7Qnn4Dk5
        8o5BT7jztApPNKQ5N5hizU8=
X-Google-Smtp-Source: AJdET5fTvjNOWHYvgZRHcQmrolOUDzWJq1acB/eXaD8OZmIq/aLdi5W1JITlmr2ung7tsL1m9Mpi6w==
X-Received: by 2002:a6b:1846:: with SMTP id 67-v6mr4726918ioy.263.1540881483470;
        Mon, 29 Oct 2018 23:38:03 -0700 (PDT)
Received: from archbookpro.localdomain ([216.1.133.205])
        by smtp.gmail.com with ESMTPSA id y7-v6sm8277270itb.40.2018.10.29.23.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 23:38:02 -0700 (PDT)
Date:   Tue, 30 Oct 2018 02:38:00 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: [PATCH v2] completion: use builtin completion for format-patch
Message-ID: <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch offloads completion functionality for format-patch to
__gitcomp_builtin. In addition to this, send-email was borrowing some
completion options from format-patch so those options are moved into
send-email's completions.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

I ran t9902-completion.sh on this patch and it seems to pass. Thus, this
should address the concerns about losing some completion options in
send-email.

---
 contrib/completion/git-completion.bash | 34 +++++++++++---------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d63d2dffd..cb4ef6723 100644
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
@@ -2080,16 +2071,19 @@ _git_send_email ()
 		return
 		;;
 	--*)
-		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
-			--compose --confirm= --dry-run --envelope-sender
-			--from --identity
-			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
-			--no-suppress-from --no-thread --quiet --reply-to
-			--signed-off-by-cc --smtp-pass --smtp-server
-			--smtp-server-port --smtp-encryption= --smtp-user
-			--subject --suppress-cc= --suppress-from --thread --to
-			--validate --no-validate
-			$__git_format_patch_options"
+		__gitcomp "--all --annotate --attach --bcc --binary --cc --cc= --cc-cmd
+			--chain-reply-to --compose --confirm= --cover-letter --dry-run
+			--dst-prefix= --envelope-sender --from --full-index --identity
+			--ignore-if-in-upstream --inline --in-reply-to --in-reply-to=
+			--keep-subject --no-attach --no-chain-reply-to --no-prefix
+			--no-signature --no-signed-off-by-cc --no-suppress-from --not --notes
+			--no-thread --no-validate --numbered --numbered-files
+			--output-directory --quiet --reply-to --reroll-count --signature
+			--signed-off-by-cc --signoff --smtp-encryption= --smtp-pass
+			--smtp-server --smtp-server-port --smtp-user --src-prefix=
+			--start-number --stdout --subject --subject-prefix= --suffix=
+			--suppress-cc= --suppress-from --thread --thread= --to --to=
+			--validate"
 		return
 		;;
 	esac
-- 
2.19.1

