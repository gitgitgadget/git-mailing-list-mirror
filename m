Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53081F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeCUTbC (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:31:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33608 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeCUTa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:30:56 -0400
Received: by mail-lf0-f65.google.com with SMTP id x205-v6so9601789lfa.0
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrB+fTJtvjN733/tkRelZ9/jVDfZyd6ytaPPmatR7z8=;
        b=FlspqksvIBC80gE/LNxgBihww2yUSdzoPxBpnqsORvj9Rslr5FoN+CMegb+MCwD0LD
         WdMfdv/XPFku/RfNeI1503TIamIuq6d7clOx0R3wzJD9rLPt20meIFuCKvcp86yvCFAM
         bjr1aTidemnObAN2X9/oucENCMsqdzMtdhjB6t+H5YPE/W4MCg2leiGEK2KfvXqMyV/D
         UV9vBJhvVt34SGQnw0ftlooSEdYs5sA4q5m1V+YZjY02wunkwpedmosqeaC1LV9Ge9sc
         irFghnDtE16QUyu11hEV9nbrVpPpdn6BJzDQaB7KRu9JfEOhYjxLjcR+zou78Ye5PbAT
         4fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrB+fTJtvjN733/tkRelZ9/jVDfZyd6ytaPPmatR7z8=;
        b=iETf0tZevFeqPMDzKr3kR/ZUS3Zrw1RglhvvsEGy3DnYkGUYt4Sp8nRrXGsHURkp7j
         cB4UEV+ik4W5S7ySWKXrCAWF7GHjwJv6HGGeL8dtM1WJRsMYua4DmCNkEe+b00tTtHKi
         SjQ/jVWhUd+jiFUlpLcrcMSEmBvq2nA3UJPch6CJqwDFFK3ZXyVK0vUg7OUpJSZER21H
         Wstf4D+O8Y5ByQWe2WQsL1j9keGUrjxf/r3+LFfA4YJO/q/4Szzl1RaaitYf/M2Cl4+5
         7LhZzsN/ze1LH0WpAk8YTy4SpzNir6YErx6KJHUVJxMPgZzxdgO8mWhiU5Pkn+biqtQj
         KWzA==
X-Gm-Message-State: AElRT7HsQdnU8P+MQ+f5BueFbD7KU9HcN97TRwvfFBgj6CZ9EBcN170A
        /A5fwuXRokZTV//bFNFgN78jmQ==
X-Google-Smtp-Source: AG47ELtRmmVbPXLr4F5PJf7faE+erlJGXq53V45QRmg2d1KBNgZ7d2n7HOTLlSOGO5GDyR+ChIthKw==
X-Received: by 10.46.29.69 with SMTP id d66mr14266864ljd.22.1521660654270;
        Wed, 21 Mar 2018 12:30:54 -0700 (PDT)
Received: from duynguyen.does.not.exist (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g10-v6sm1200415lfe.21.2018.03.21.12.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:30:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] completion: add option completion for most builtin commands
Date:   Wed, 21 Mar 2018 20:30:39 +0100
Message-Id: <20180321193039.19779-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These commands can take options and use parse-options so it's quite
easy to allow option completion. This does not pollute the command
name completion though. "git <tab>" will show you the same set as
before. This only kicks in when you type the correct command name.

Some other builtin commands are not still added because either they
don't use parse-options, or they are deprecated, or they are those
-helper commands that are used to move some logic back in C for
sh-based commands.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 276 +++++++++++++++++++++++++
 1 file changed, 276 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6da95b8095..0cd9180f48 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1202,6 +1202,15 @@ _git_bisect ()
 	esac
 }
 
+_git_blame() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin blame
+		return
+		;;
+	esac
+}
+
 _git_branch ()
 {
 	local i c=1 only_local_ref="n" has_r="n"
@@ -1254,6 +1263,42 @@ _git_bundle ()
 	esac
 }
 
+_git_cat_file() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin cat-file
+		return
+		;;
+	esac
+}
+
+_git_check_attr() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin check-attr
+		return
+		;;
+	esac
+}
+
+_git_check_ignore() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin check-ignore
+		return
+		;;
+	esac
+}
+
+_git_check_mailmap() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin check-mailmap
+		return
+		;;
+	esac
+}
+
 _git_checkout ()
 {
 	__git_has_doubledash && return
@@ -1278,6 +1323,15 @@ _git_checkout ()
 	esac
 }
 
+_git_checkout_index() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin checkout-index
+		return
+		;;
+	esac
+}
+
 _git_cherry ()
 {
 	__git_complete_refs
@@ -1326,6 +1380,15 @@ _git_clone ()
 	esac
 }
 
+_git_column() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin column
+		return
+		;;
+	esac
+}
+
 __git_untracked_file_modes="all no normal"
 
 _git_commit ()
@@ -1365,6 +1428,15 @@ _git_commit ()
 	fi
 }
 
+_git_count_objects() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin count-objects
+		return
+		;;
+	esac
+}
+
 _git_describe ()
 {
 	case "$cur" in
@@ -1446,6 +1518,15 @@ _git_difftool ()
 	__git_complete_revlist_file
 }
 
+_git_fast_export() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin fast-export
+		return
+		;;
+	esac
+}
+
 __git_fetch_recurse_submodules="yes on-demand no"
 
 _git_fetch ()
@@ -1573,6 +1654,15 @@ _git_grep ()
 	__git_complete_refs
 }
 
+_git_hash_object() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin hash-object
+		return
+		;;
+	esac
+}
+
 _git_help ()
 {
 	case "$cur" in
@@ -1590,6 +1680,15 @@ _git_help ()
 		"
 }
 
+_git_index_pack() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin index-pack
+		return
+		;;
+	esac
+}
+
 _git_init ()
 {
 	case "$cur" in
@@ -1606,6 +1705,15 @@ _git_init ()
 	esac
 }
 
+_git_interpret_trailers() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin interpret-trailers
+		return
+		;;
+	esac
+}
+
 _git_ls_files ()
 {
 	case "$cur" in
@@ -1765,6 +1873,15 @@ _git_merge ()
 	__git_complete_refs
 }
 
+_git_merge_file() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin merge-file
+		return
+		;;
+	esac
+}
+
 _git_mergetool ()
 {
 	case "$cur" in
@@ -1790,6 +1907,15 @@ _git_merge_base ()
 	__git_complete_refs
 }
 
+_git_mktree() {
+	case "$cur" in
+	--*)
+		__gitcomp_builtin mktree
+		return
+		;;
+	esac
+}
+
 _git_mv ()
 {
 	case "$cur" in
@@ -1853,6 +1979,46 @@ _git_notes ()
 	esac
 }
 
+_git_pack_objects ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin pack-objects
+		return
+		;;
+	esac
+}
+
+_git_pack_refs ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin pack-refs
+		return
+		;;
+	esac
+}
+
+_git_prune ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin prune
+		return
+		;;
+	esac
+}
+
+_git_prune_packed ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin prune-packed
+		return
+		;;
+	esac
+}
+
 _git_pull ()
 {
 	__git_complete_strategy && return
@@ -1925,6 +2091,16 @@ _git_push ()
 	__git_complete_remote_or_refspec
 }
 
+_git_read_tree ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin read-tree
+		return
+		;;
+	esac
+}
+
 _git_rebase ()
 {
 	__git_find_repo_path
@@ -1974,6 +2150,16 @@ _git_reflog ()
 	fi
 }
 
+_git_repack ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin repack
+		return
+		;;
+	esac
+}
+
 __git_send_email_confirm_options="always never auto cc compose"
 __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
 
@@ -2031,6 +2217,26 @@ _git_send_email ()
 	__git_complete_revlist
 }
 
+_git_send_pack ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin send-pack
+		return
+		;;
+	esac
+}
+
+_git_show_ref ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin show-ref
+		return
+		;;
+	esac
+}
+
 _git_stage ()
 {
 	_git_add
@@ -2082,6 +2288,26 @@ _git_status ()
 	__git_complete_index_file "$complete_opt"
 }
 
+_git_stripspace ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin stripspace
+		return
+		;;
+	esac
+}
+
+_git_symbolic_ref ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin symbolic-ref
+		return
+		;;
+	esac
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
@@ -2998,6 +3224,46 @@ _git_tag ()
 	esac
 }
 
+_git_update_index ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin update-index
+		return
+		;;
+	esac
+}
+
+_git_update_ref ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin update-ref
+		return
+		;;
+	esac
+}
+
+_git_verify_commit ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin verify-commit
+		return
+		;;
+	esac
+}
+
+_git_verify_tag ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin verify-tag
+		return
+		;;
+	esac
+}
+
 _git_whatchanged ()
 {
 	_git_log
@@ -3032,6 +3298,16 @@ _git_worktree ()
 	fi
 }
 
+_git_write_tree ()
+{
+	case "$cur" in
+	--*)
+		__gitcomp_builtin write-tree
+		return
+		;;
+	esac
+}
+
 __git_main ()
 {
 	local i c=1 command __git_dir __git_repo_path
-- 
2.17.0.rc0.348.gd5a49e0b6f

