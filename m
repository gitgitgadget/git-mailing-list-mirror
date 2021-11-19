Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36DEC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82314615E6
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 05:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhKSFIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhKSFIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 00:08:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7AC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:05:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so15873862wru.13
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 21:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PAaEEKCqQ8+zs1wbCxLCty3jmK6UUWPR6ezzA1MGoeI=;
        b=kUaq2HjfxqjJoIaRuoMAPpFGYowHMevVoS7QQibNxAavrugdxTLExBcpFoNr/zvsby
         0764nJgjk4VX+UEeehDQNoOvabQExFNAHKaE5aA5rws/oFcVlcEnBYXrwS49NulznTuI
         jcz+GfuZr9iyyeFGrgvBCu+gklQXt7T8n/gDyOB6RmSZjLB2rxwzgCPF2swp5FKzbNv9
         2OIT43UA+qFUzAJdiWS/GPuryvM0KCy/0qZPu118lGANlasLUm6twkPzUdgNxs2JHj+6
         yEYE9EE7WyLOcVKMxPfrH9mvOvBh9PUyxI75o7XmFaO4NiqBNuDAjq5vWFd9TeqiIADB
         7clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PAaEEKCqQ8+zs1wbCxLCty3jmK6UUWPR6ezzA1MGoeI=;
        b=19zmDG/ny021iT1n71oa4f1M5fCGKs4ocQcNSmoMzDKLbA1Z6lVQP1zYPyOdvobbBv
         oxOCQcuGaMd+4288Mxp2BfHAdRKZI0/30dR+anJwpR9/hm05b8nYLZNo1BbIt+ZRAptt
         wLbP5YY7j3HyJsxu/ItemIz0IlKhmLxJDggnT8NVYBy8tc2CzxArUJEiEKB1s4X0flN1
         VBDJggWDtPse7bCnMpxmHdPIVmWGuQndtLqhy5FJVOPopiMEkfotvSdS0HNRZ4M8yMyW
         Qf6+si1jp9VCo0Mr6bNAsMKL030Dga1wNp4yqeERZbl4tER0bcLdGlCXLj8zXZ0rMEMT
         Os1Q==
X-Gm-Message-State: AOAM532WEBEFQcV1j/MdOpx5EBQ4pbBlqkAnVOEQxKb/UGBy6s5S1zAk
        8chxZz0CaZUy0SxjPZ7R5kICPXN7VrE=
X-Google-Smtp-Source: ABdhPJz9fVzn4xWPO/ZbB7pHcQc/ws0jvMqGAztY51lzOSF7lp9KIKtjg32lZmFH8oIp8+O4Cg1R5w==
X-Received: by 2002:adf:d22a:: with SMTP id k10mr3894832wrh.80.1637298303128;
        Thu, 18 Nov 2021 21:05:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm1920334wms.15.2021.11.18.21.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 21:05:02 -0800 (PST)
Message-Id: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
References: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 05:04:56 +0000
Subject: [PATCH v7 0/2] am: support --empty=(die|drop|keep) option to handle empty patches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

cc: René Scharfe l.s.r@web.de cc: Phillip Wood phillip.wood123@gmail.com cc:
Aleen 徐沛文 pwxu@coremail.cn

Aleen (2):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches

 Documentation/git-am.txt           |  8 +++++
 Documentation/git-format-patch.txt |  6 +++-
 builtin/am.c                       | 55 +++++++++++++++++++++++++++---
 po/bg.po                           |  2 +-
 po/ca.po                           |  2 +-
 po/de.po                           |  2 +-
 po/el.po                           |  2 +-
 po/es.po                           |  2 +-
 po/fr.po                           |  2 +-
 po/git.pot                         |  2 +-
 po/id.po                           |  2 +-
 po/it.po                           |  2 +-
 po/ko.po                           |  2 +-
 po/pl.po                           |  2 +-
 po/pt_PT.po                        |  8 ++---
 po/ru.po                           |  4 +--
 po/sv.po                           |  2 +-
 po/tr.po                           |  2 +-
 po/vi.po                           |  2 +-
 po/zh_CN.po                        |  9 +++--
 po/zh_TW.po                        |  7 +++-
 t/t4150-am.sh                      | 49 ++++++++++++++++++++++++++
 22 files changed, 145 insertions(+), 29 deletions(-)


base-commit: ca35af825273b98fc8dc11527488952f5db8eb80
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v6:

 1:  9f1b3dd6d0b ! 1:  d612bc49d57 doc: git-format-patch: describe the option --always
     @@ Metadata
       ## Commit message ##
          doc: git-format-patch: describe the option --always
      
     +    This commit has described how to use '--always' option in the command
     +    'git-format-patch' to include patches for commits that emit no changes.
     +
          Signed-off-by: Aleen <aleen42@vip.qq.com>
      
       ## Documentation/git-format-patch.txt ##
 2:  96d8573dc80 ! 2:  9e60e77c041 am: support --empty option to handle empty patches
     @@ Metadata
      Author: Aleen <aleen42@vip.qq.com>
      
       ## Commit message ##
     -    am: support --empty option to handle empty patches
     +    am: support --empty=<option> to handle empty patches
     +
     +    Since that the command 'git-format-patch' can include patches of
     +    commits that emit no changes, the 'git-am' command should also
     +    support an option, named as '--empty', to specify how to handle
     +    those empty patches. In this commit, we have implemented three
     +    valid options ('die', 'drop' and 'keep').
      
          Signed-off-by: Aleen <aleen42@vip.qq.com>
      
     @@ Documentation/git-am.txt: OPTIONS
       	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
       
      +--empty-commit=(die|drop|keep)::
     -+	The command usually errors out when seeing an input e-mail
     -+	message that lacks a patch. When this option is set to
     -+	'drop', skip such an e-mail message without outputting error.
     ++	By default, or when the option is set to 'die', the command
     ++	errors out on an input e-mail message that lacks a patch. When
     ++	this option is set to 'drop', skip such an e-mail message instead.
      +	When this option is set to 'keep', create an empty commit,
      +	recording the contents of the e-mail message as its log.
     -+	'die' is specified by default.
      +
       -m::
       --message-id::
     @@ builtin/am.c: enum show_patch_type {
       
      +enum empty_action {
      +	DIE_EMPTY_COMMIT = 0,  /* output errors */
     -+	DROP_EMPTY_COMMIT,     /* skip without outputting errors */
     ++	DROP_EMPTY_COMMIT,     /* skip with a notice message, unless "--quiet" has been passed */
      +	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
      +};
      +
     @@ builtin/am.c: static int am_option_parse_quoted_cr(const struct option *opt,
       	return 0;
       }
       
     -+static int am_option_parse_empty_commit(const struct option *opt,
     ++static int am_option_parse_empty(const struct option *opt,
      +				     const char *arg, int unset)
      +{
      +	int *opt_value = opt->value;
      +
     -+	if (unset || !strcmp(arg, "die"))
     ++	BUG_ON_OPT_NEG(unset);
     ++
     ++	if (!strcmp(arg, "die"))
      +		*opt_value = DIE_EMPTY_COMMIT;
      +	else if (!strcmp(arg, "drop"))
      +		*opt_value = DROP_EMPTY_COMMIT;
     @@ builtin/am.c: static int parse_mail(struct am_state *state, const char *mail)
       	strbuf_addstr(&msg, "\n\n");
       	strbuf_addbuf(&msg, &mi.log_message);
       	strbuf_stripspace(&msg, 0);
     +@@ builtin/am.c: static void am_run(struct am_state *state, int resume)
     + 	while (state->cur <= state->last) {
     + 		const char *mail = am_path(state, msgnum(state));
     + 		int apply_status;
     ++		int to_keep;
     + 
     + 		reset_ident_date();
     + 
      @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
       		if (state->interactive && do_interactive(state))
       			goto next;
       
     ++		to_keep = 0;
      +		if (is_empty_or_missing_file(am_path(state, "patch"))) {
     -+			if (state->empty_type == DROP_EMPTY_COMMIT)
     ++			switch (state->empty_type) {
     ++			case DROP_EMPTY_COMMIT:
     ++				say(state, stdout, _("Skipping: %.*s"), linelen(state->msg), state->msg);
      +				goto next;
     -+			else if (state->empty_type == KEEP_EMPTY_COMMIT) {
     -+				if (run_applypatch_msg_hook(state))
     -+					exit(1);
     -+				else
     -+					goto commit;
     -+			} else if (state->empty_type == DIE_EMPTY_COMMIT) {
     ++				break;
     ++			case KEEP_EMPTY_COMMIT:
     ++				to_keep = 1;
     ++				break;
     ++			case DIE_EMPTY_COMMIT:
      +				printf_ln(_("Patch is empty."));
      +				die_user_resolve(state);
     ++				break;
      +			}
      +		}
      +
       		if (run_applypatch_msg_hook(state))
       			exit(1);
     ++		if (to_keep)
     ++			goto commit;
     + 
     + 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
       
      @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
       			die_user_resolve(state);
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
       		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
       		  N_("GPG-sign commits"),
       		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
     -+		{ OPTION_CALLBACK, 0, "empty", &state.empty_type,
     -+		  "(die|drop|keep)",
     -+		  N_("specify how to handle empty patches"),
     -+		  PARSE_OPT_OPTARG, am_option_parse_empty_commit },
     ++		OPT_CALLBACK_F(0, "empty", &state.empty_type, "{drop,keep,die}",
     ++		  N_("how to handle empty patches"),
     ++		  PARSE_OPT_NONEG, am_option_parse_empty),
       		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
       			N_("(internal use for git-rebase)")),
       		OPT_END()
      
     + ## po/bg.po ##
     +@@ po/bg.po: msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr ""
     + "Индексът не е чист: кръпките не може да бъдат приложени (замърсени са: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Прилагане: %.*s"
     +
     + ## po/ca.po ##
     +@@ po/ca.po: msgstr "no s'ha pogut escriure el fitxer d'índex"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Índex brut: no es poden aplicar pedaços (bruts: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "S'està aplicant: %.*s"
     +
     + ## po/de.po ##
     +@@ po/de.po: msgstr "Konnte Index-Datei nicht schreiben."
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Geänderter Index: kann Patches nicht anwenden (geändert: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Wende an: %.*s"
     +
     + ## po/el.po ##
     +@@ po/el.po: msgstr "Να γίνει εφαρμογή; [y]es/[n]o/[e]dit/[v]iew patch/[a]ccep
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr ""
     + 
     +-#: builtin/am.c:1749 builtin/am.c:1817
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr ""
     +
     + ## po/es.po ##
     +@@ po/es.po: msgstr "no es posible escribir el archivo índice"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Índice sucio: no se puede aplicar parches (sucio: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Aplicando: %.*s"
     +
     + ## po/fr.po ##
     +@@ po/fr.po: msgstr "impossible d'écrire le fichier d'index"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Index sale : impossible d'appliquer des patchs (sales : %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Application de  %.*s"
     +
     + ## po/git.pot ##
     +@@ po/git.pot: msgstr ""
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr ""
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr ""
     +
     + ## po/id.po ##
     +@@ po/id.po: msgstr "tidak dapat menulis berkas indeks"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Indeks kotor: tidak dapat menerapkan tambalan (kotor: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Menerapkan: %.*s"
     +
     + ## po/it.po ##
     +@@ po/it.po: msgstr "impossibile scrivere il file indice"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Indice sporco: impossibile applicare le patch (elemento sporco: %s)"
     + 
     +-#: builtin/am.c:1761 builtin/am.c:1829
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Applicazione in corso: %.*s"
     +
     + ## po/ko.po ##
     +@@ po/ko.po: msgstr "적용? 예[y]/아니오[n]/편집[e]/패치 보기[v]/모두 적용[a]:
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "변경된 인덱스: 패치를 적용할 수 없습니다 (dirty: %s)"
     + 
     +-#: builtin/am.c:1808 builtin/am.c:1879
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "적용하는 중: %.*s"
     +
     + ## po/pl.po ##
     +@@ po/pl.po: msgstr "nie można zapisać pliku indeksu"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Brudny indeks: nie można zastosować łatek (brudny: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Stosowanie: %.*s"
     +
     + ## po/pt_PT.po ##
     +@@
     + #   bisect                           |  bisetar
     + #   blame                            |  blame
     + #   blob object                      |  objeto-blob
     +-#   branch                           |  ramo 
     ++#   branch                           |  ramo
     + #   bug                              |  bug
     + #   bundle                           |  conjunto
     + #   bypass                           |  desviar
     +@@
     + #   loose refs                       |  refs soltas
     + #   mark                             |  marca
     + #   master                           |  master
     +-#   merge                            |  junção 
     ++#   merge                            |  junção
     + #   mergetag                         |  etiqueta-junção
     + #   object                           |  objeto
     + #   object database                  |  base dados de objeto
     +@@
     + #   token                            |  token
     + #   unset                            |  desdefinir
     + #   untrack                          |  desmonitorizar
     +-#   
     ++#
     + #
     + msgid ""
     + msgstr ""
     +@@ po/pt_PT.po: msgstr "incapaz escrever ficheiro de index"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Index sujo: incapaz aplicar patches (sujo: %s)"
     + 
     +-#: builtin/am.c:1797 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "A aplicar: %.*s"
     +
     + ## po/ru.po ##
     +@@
     + # SOME DESCRIPTIVE TITLE.
     + # Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
     + # This file is distributed under the same license as the PACKAGE package.
     +-# 
     ++#
     + # Translators:
     + # Alexander Golubev <fatzer2@gmail.com>, 2020
     + # Dimitriy Ryazantcev <DJm00n@mail.ru>, 2014-2021
     +@@ po/ru.po: msgstr "не удалось записать индекс"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Индекс изменён: нельзя применять патчи (изменено: %s)"
     + 
     +-#: builtin/am.c:1748 builtin/am.c:1816
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Применение: %.*s"
     +
     + ## po/sv.po ##
     +@@ po/sv.po: msgstr "kan inte skriva indexfil"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Smutsigt index: kan inte tillämpa patchar (smutsiga: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Tillämpar: %.*s"
     +
     + ## po/tr.po ##
     +@@ po/tr.po: msgstr "indeks dosyası yazılamıyor"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Kirli indeks: Yamalar uygulanamıyor (kirli: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Uygulanıyor: %.*s"
     +
     + ## po/vi.po ##
     +@@ po/vi.po: msgstr "không thể ghi tập tin lưu mục lục"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "Bảng mục lục bẩn: không thể áp dụng các miếng vá (bẩn: %s)"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "Áp dụng: %.*s"
     +
     + ## po/zh_CN.po ##
     +@@ po/zh_CN.po: msgstr "坏的索引文件 sha1 签名"
     + msgid "index uses %.4s extension, which we do not understand"
     + msgstr "索引使用不被支持的 %.4s 扩展"
     + 
     +-# 	
     ++#
     + #: read-cache.c:1834
     + #, c-format
     + msgid "ignoring %.4s extension"
     +@@ po/zh_CN.po: msgstr "无法写入索引文件"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "脏索引：不能应用补丁（脏文件：%s）"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "应用：%.*s"
     + 
     ++#: builtin/am.c:1818
     ++#, c-format
     ++msgid "Skipping: %.*s"
     ++msgstr "跳过：%.*s"
     ++
     + #: builtin/am.c:1815
     + msgid "No changes -- Patch already applied."
     + msgstr "没有变更 —— 补丁已经应用过。"
     +
     + ## po/zh_TW.po ##
     +@@ po/zh_TW.po: msgstr "無法寫入索引檔案"
     + msgid "Dirty index: cannot apply patches (dirty: %s)"
     + msgstr "髒索引：不能套用修補檔（髒檔案：%s）"
     + 
     +-#: builtin/am.c:1798 builtin/am.c:1865
     ++#: builtin/am.c:1834 builtin/am.c:1902
     + #, c-format
     + msgid "Applying: %.*s"
     + msgstr "套用：%.*s"
     + 
     ++#: builtin/am.c:1818
     ++#, c-format
     ++msgid "Skipping: %.*s"
     ++msgstr "忽略：%.*s"
     ++
     + #: builtin/am.c:1815
     + msgid "No changes -- Patch already applied."
     + msgstr "沒有變更——修補檔已經套用過。"
     +
       ## t/t4150-am.sh ##
      @@ t/t4150-am.sh: test_expect_success setup '
       
     @@ t/t4150-am.sh: test_expect_success setup '
      +	git checkout -b empty-commit &&
      +	git commit -m "empty commit" --allow-empty &&
      +
     -+	git format-patch --stdout empty-commit^ >empty.patch &&
     -+	git format-patch --stdout --cover-letter empty-commit^ >cover-letter.patch &&
     ++	: >empty.patch &&
      +	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
      +
       	# reset time
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
       	git -C client am ../patch
       '
       
     -+test_expect_success 'still output error with --empty when meeting empty files' '
     ++test_expect_success 'An empty input file is error regardless of --empty option' '
      +	test_must_fail git am --empty=drop empty.patch 2>actual &&
      +	echo Patch format detection failed. >expected &&
      +	test_cmp expected actual
      +'
      +
     -+test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
     ++test_expect_success 'invalid when passing the --empty option alone' '
      +	git checkout empty-commit^ &&
     ++	test_must_fail git am --empty empty-commit.patch 2>err &&
     ++	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
     ++	test_cmp expected err
     ++'
     ++
     ++test_expect_success 'a message without a patch is an error (default)' '
     ++	test_when_finished "git am --abort || :" &&
      +	test_must_fail git am empty-commit.patch >err &&
     -+	test_path_is_dir .git/rebase-apply &&
     -+	test_i18ngrep "Patch is empty." err &&
     -+	rm -fr .git/rebase-apply &&
     ++	grep "Patch is empty" err &&
     ++	rm -fr .git/rebase-apply
     ++'
      +
     ++test_expect_success 'a message without a patch is an error where an explicit "--empty=die" is given' '
     ++	test_when_finished "git am --abort || :" &&
      +	test_must_fail git am --empty=die empty-commit.patch >err &&
     -+	test_path_is_dir .git/rebase-apply &&
     -+	test_i18ngrep "Patch is empty." err &&
     -+	rm -fr .git/rebase-apply &&
     -+
     -+	test_must_fail git am --empty=die cover-letter.patch >err &&
     -+	test_path_is_dir .git/rebase-apply &&
     -+	test_i18ngrep "Patch is empty." err &&
     ++	grep "Patch is empty." err &&
      +	rm -fr .git/rebase-apply
      +'
      +
     -+test_expect_success 'skip without error when meeting e-mail message that lacks a patch' '
     -+	git am --empty=drop empty-commit.patch >err &&
     -+	test_path_is_missing .git/rebase-apply &&
     ++test_expect_success 'a message without a patch will be skipped when "--empty=drop" is given' '
     ++	git am --empty=drop empty-commit.patch >output &&
      +	git rev-parse empty-commit^ >expected &&
      +	git rev-parse HEAD >actual &&
      +	test_cmp expected actual &&
     -+
     -+	git am --empty=drop cover-letter.patch >err &&
     -+	test_path_is_missing .git/rebase-apply &&
     -+	test_cmp_rev empty-commit^ HEAD
     ++	grep "Skipping: empty commit" output
      +'
      +
      +test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
      +	git am --empty=keep empty-commit.patch &&
      +	test_path_is_missing .git/rebase-apply &&
     -+	{
     -+		git show empty-commit --format="%B" &&
     -+		echo "--" &&
     -+		git version | sed -e "s/^git version //" &&
     -+		echo
     -+	} >expected &&
     -+	git show HEAD --format="%B" >actual &&
     -+	test_cmp actual expected &&
     -+
     -+	git am --empty=keep cover-letter.patch &&
     -+	test_path_is_missing .git/rebase-apply &&
     -+	{
     -+		echo "*** SUBJECT HERE ***" &&
     -+		echo &&
     -+		echo "*** BLURB HERE ***" &&
     -+		echo &&
     -+		echo "A U Thor (1):" &&
     -+		printf "  " &&
     -+		git show empty-commit --format="%B" &&
     -+		echo "--" &&
     -+		git version | sed -e "s/^git version //" &&
     -+		echo
     -+	} >expected &&
     -+	git show HEAD --format="%B" >actual &&
     ++	git show empty-commit --format="%s" >expected &&
     ++	git show HEAD --format="%s" >actual &&
      +	test_cmp actual expected
      +'
      +
 3:  e907a2b2faa < -:  ----------- am: throw an error when passing --empty option without value

-- 
gitgitgadget
