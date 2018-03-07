Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668CE1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 01:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeCGBFa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 20:05:30 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36271 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932613AbeCGBFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 20:05:30 -0500
Received: by mail-pg0-f67.google.com with SMTP id i14so258548pgv.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 17:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5thiU/jyXOo+WO3b+1JFVAjXdvbKRrlW4eNPh00HoY=;
        b=Xtg22MASOO+Ys9SG3+73XJWf4+20d7o4au1/2mMLrkXlFmiODOB3YWDnv1URNt3tnF
         gxtW9T278XmtmvdAJPLCO0crd4p6Ku8QRrQy56VSaShnKy+cTBIsrHq63QYBzy6NFSKz
         pn2zm2WbjsI2+KgdEMgG2Knz8bgotV7W4sOd7bI0gHfetIo88/48i1y88SIRCh4DcP8b
         10TTPujKStzlyyi7r7zbeXhkdz4U5os1Zan8LzQN5rPk/rrxXioEs427fpGcsArZaoM5
         IgnwWm9nZu/cb91gV9QZSgSlZ4C7nHNmdcgQNN74uPhVxd28G0KsldbAyVuqms+O3vxG
         ge6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5thiU/jyXOo+WO3b+1JFVAjXdvbKRrlW4eNPh00HoY=;
        b=scZye3Nb82K/lJb2QoidxGIVc9Xh+YrsB0uRGOHSCusI5D8afBMLrZ0ZmInXz8eBOT
         2TC6RcDvV2umm4Ojc4Q4YvAtbXD7Y+De/6WAlKpWd0SeI7qOVLL4qwQORUZfXCOeWoCJ
         w4vzI6zyeevr1dSt8jmF57n/ZgwZzvbvGt1K8tmJh2arm04PYUkKmn9N/AoFPubbp/ww
         T58LcLBhWvhLc2P9Q54rh9cFtt57on90CwmZHzJYMLJNiJftAFQyjndp+sGAWN5b84Q0
         2VAXLzQhbyYkjM+QVhhBC2jIgN5V4bdaVCaIl06d+RWOUfQ82U5vcCvQfNYuGNAwmolR
         c00Q==
X-Gm-Message-State: AElRT7GeTV6C4MpdEJGVGc8uMjDw1JaXeiUW6UvWvhcSQX17T/HpP8UX
        O8WXtLVPAB2tLOl5JOLAuohluw==
X-Google-Smtp-Source: AG47ELtt9zH0CVd3xhkN2qDgp9xNwP1TM7r1NbaRRJjS7TALx9sYNLt3TRp5anzlbdqmVIPxe+eXUA==
X-Received: by 10.101.78.139 with SMTP id b11mr9530408pgs.229.1520384729492;
        Tue, 06 Mar 2018 17:05:29 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p10sm27664133pgd.28.2018.03.06.17.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 17:05:28 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        phillip.wood@talktalk.net
Subject: [PATCH v2 0/4] nd/parseopt-completion fixups
Date:   Wed,  7 Mar 2018 08:05:00 +0700
Message-Id: <20180307010504.9289-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.785.g429c04a1b9
In-Reply-To: <20180303092307.3796-1-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes the comments from v1 and adds to new patches to improve
_git_notes() (sorry I couldn't resist)

Interdiff with what's on 'pu'

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5f7495cda3..2e30950299 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1815,7 +1815,7 @@ _git_name_rev ()
 
 _git_notes ()
 {
-	local subcommands='add append copy edit list prune remove show'
+	local subcommands='add append copy edit get-ref list merge prune remove show'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 
 	case "$subcommand,$cur" in
@@ -1832,18 +1832,15 @@ _git_notes ()
 			;;
 		esac
 		;;
-	add,--reuse-message=*|append,--reuse-message=*|\
-	add,--reedit-message=*|append,--reedit-message=*)
+	*,--reuse-message=*|*,--reedit-message=*)
 		__git_complete_refs --cur="${cur#*=}"
 		;;
-	prune,--*)
-		__gitcomp_builtin notes_prune
-		;;
-	prune,*)
-		;;
 	*,--*)
 		__gitcomp_builtin notes_$subcommand
 		;;
+	prune,*|get-ref,*)
+		# this command does not take a ref, do not complete it
+		;;
 	*)
 		case "$prev" in
 		-m|-F)
@@ -1956,6 +1953,7 @@ _git_rebase ()
 			--autostash --no-autostash
 			--verify --no-verify
 			--keep-empty --root --force-rebase --no-ff
+			--rerere-autoupdate
 			--exec
 			"
 

Nguyễn Thái Ngọc Duy (4):
  completion: don't set PARSE_OPT_NOCOMPLETE on --rerere-autoupdate
  completion: simplify _git_notes
  completion: complete --{reuse,reedit}-message= for all notes subcmds
  completion: more subcommands in _git_notes()

 contrib/completion/git-completion.bash | 25 ++++++++-----------------
 parse-options.h                        |  4 ++--
 rerere.h                               |  3 +--
 3 files changed, 11 insertions(+), 21 deletions(-)

-- 
2.16.2.785.g429c04a1b9

