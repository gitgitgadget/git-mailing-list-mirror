Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130F620248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfCUNUE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:20:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44027 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfCUNUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:20:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so4269188pfd.10
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udPqif4esze3K/WRYG8SGK5cRM+Ex7lZ2dIR6VfgId4=;
        b=gwC7U9Y16MFiLNPsiXijIgL+bLye9BQzASzAb6pt7BnQYSg3ihmqtrAgI/D/zx3w7v
         8JPu8Cug2QCi46JoWQK6FQkayL0DsS6bfl3e2WAcphw6tMgV/b2eznun3OPZuWC18hsM
         LSlNkbDCN7K8LeuYsbomG3kSXW6GWE0N4KnlCpmilXbY/w92A+9/8nxmnDhu9d+GUVpl
         gQgTJ/nWzL7PP2a3Oj+a9svUOnbpEr6Et75G0g4mEbKNPzvuI8GpscUzqsTRgVdFA4S4
         lH8sLVAhuWtxO2fg1AprODPLh+i+j1WfecAE9GHbsPFYP+ztZwK7c6Vt0PUm6akVzdl/
         rTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udPqif4esze3K/WRYG8SGK5cRM+Ex7lZ2dIR6VfgId4=;
        b=Yz/FkcnJxG/s56fuyYPXsKP8Lxio9xJ7zJ0/vRUU1KkOZ6TnERNFGd+JoVDkIFmQUx
         1uhgsRB/OBEOeTW2v+TBY0a3z8zJOPtlaN2myZ9KDcQ0/uPYYtK2g5nh/ILFXIk5BFTO
         b0pNs2THjyWtlZ1p8gDsDi2oZ3B7TT2M+rvrdo9iSK8IMd88InF+QtyxegxcS+u+4aGd
         qkyZyR4mrtT/Zwxfj1LQGHRmgHijU36efrbFZSXYzLLjA7QRUnvLFlw0UKf8kkdFZTS8
         D5iXZ+NzjJNDR+rIiJKSQ1QxfaMZmi7RIIbfFpTe7yOA0VZrE2E1wHwLL/uFoH9hJTUz
         bZaQ==
X-Gm-Message-State: APjAAAWBA1fBc5K3VzYzpn0eZfxD+YPpCQuVU67ItcfLleE24iJ+nFo/
        cgFULzV+0uoUueeVgTmcLZQ=
X-Google-Smtp-Source: APXvYqyRfd7svYchWOFfmIGw4CCczHfhPdgy1Ncc7Ugy0NgfJK8cU9Gf71FCFeZr0zo991yY91Cwug==
X-Received: by 2002:a63:720f:: with SMTP id n15mr3210044pgc.216.1553174403164;
        Thu, 21 Mar 2019 06:20:03 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 7sm10105999pgj.64.2019.03.21.06.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:20:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 25/26] completion: support switch
Date:   Thu, 21 Mar 2019 20:16:54 +0700
Message-Id: <20190321131655.15249-26-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion support for --guess could be made better. If no --detach is
given, we should only provide a list of refs/heads/* and dwim ones,
not the entire ref space. But I still can't penetrate that
__git_refs() function yet.
---
 contrib/completion/git-completion.bash | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 976e4a6548..b24bc48276 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -37,7 +37,8 @@
 #   GIT_COMPLETION_CHECKOUT_NO_GUESS
 #
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
-#     completion (e.g., completing "foo" when "origin/foo" exists).
+#     and git-switch completion (e.g., completing "foo" when "origin/foo"
+#     exists).
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -2158,6 +2159,40 @@ _git_status ()
 	__git_complete_index_file "$complete_opt"
 }
 
+_git_switch ()
+{
+	case "$cur" in
+	--conflict=*)
+		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		;;
+	--*)
+		__gitcomp_builtin switch
+		;;
+	*)
+		# check if --track, --no-track, or --no-guess was specified
+		# if so, disable DWIM mode
+		local track_opt="--track" only_local_ref=n
+		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
+		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
+			track_opt=''
+		fi
+		# explicit --guess enables DWIM mode regardless of
+		# $GIT_COMPLETION_CHECKOUT_NO_GUESS
+		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
+			track_opt='--track'
+		fi
+		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
+			only_local_ref=y
+		fi
+		if [ $only_local_ref = y -a -z "$track_opt" ]; then
+			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
+		else
+			__git_complete_refs $track_opt
+		fi
+		;;
+	esac
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-- 
2.21.0.548.gd3c7d92dc2

