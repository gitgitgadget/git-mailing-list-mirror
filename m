Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937EF1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfEHPCN (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:02:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52008 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfEHPCN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:02:13 -0400
Received: by mail-it1-f196.google.com with SMTP id s3so4577431itk.1
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zY6XnqxW586UUqkm6mdbUm0kW6RJ4GSXIHxu77W0pC8=;
        b=u+Dtko7UiDA7frbn4nWzPM3hSGdieiBsUutVQmpp58W88BFKn+OR1WZks2GsiQK6xg
         2ND53v1x2LpH1LvZOFUIi+SWi8BBcU9i85d0/kC8KICXpGdUnzoA1jj0X0r+D+sI/tUf
         qOS4ZAYKc7ltU6RSqTcHOrzFO7SSm47at2QBU9qRF/riNzCcMFEUdqPjEkEXDhn7PW9Y
         FIXEZG8hUPUNsdh2iLDjZD/ne4VzUecGS0WBThNSHF7B1lCzUS8Umb1ctx/exJtpADDB
         L89PU1wxQubIGzrvbxE4mZMqu9+nfFDCf2q65x9m4RtkSr5dzXOuYR7l7hzoyd0BMh1l
         0t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zY6XnqxW586UUqkm6mdbUm0kW6RJ4GSXIHxu77W0pC8=;
        b=g99X1rHvp6TbEdIRRbNbuspoL4/e9gT0MDbz6NeV+v7llxqN4y2UfQYWXdr7ZwcqvB
         EsW1wPow9C08qjal2l14GEcz8/DA3z6sroJP+kFwPKpzgiOQhEKHoeC8ZH4vXTgjhNOU
         FPtjSoN0XAokzFrlfVyoilNhCUt9Qrtmtpx9jI9TAfB7RStGMXd/1XcT7lDnCOTH8pIz
         WuiPfFQ1Nfp2ID3VAK3jC/jqW/yuQt4V6BfCBATe96dUFGer1LdQPYkZlMQVUuAKowmd
         00sLm9A4HA07L0KpnKLhMC3FGRNojf4iA9oYESdyjpxfzEhDv+LGvMIo3tDxdMz2qAgK
         Ul+w==
X-Gm-Message-State: APjAAAU9k89NBKKPKK6quPXaONFl+bfL2DjqV32IfWeGkfSaYjoHtkUH
        yMJ8BkH8ETc+WfnwZL2J02aVAHL/
X-Google-Smtp-Source: APXvYqx8QhCu44uBlXlcP1OLZw/ZWItP5B9BYvB7stggjjcvtexde/rXeoHsYVanN8fVeMrtE56Q+Q==
X-Received: by 2002:a24:b57:: with SMTP id 84mr1743623itd.53.1557327731615;
        Wed, 08 May 2019 08:02:11 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:780:ed13:bfd5:1bea:adb7])
        by smtp.gmail.com with ESMTPSA id v6sm5553083ioj.67.2019.05.08.08.02.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:02:10 -0700 (PDT)
Date:   Wed, 8 May 2019 11:02:08 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] format-patch: teach format.notes config option
Message-ID: <cover.1557327652.git.liu.denton@gmail.com>
References: <cover.1556388260.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556388260.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for the review. I made format.notes accept one (or more) refs
now.

Changes since v1:

* Made format.notes accept a notes ref instead of a boolean


Denton Liu (2):
  git-format-patch.txt: document --no-notes option
  format-patch: teach format.notes config option

 Documentation/config/format.txt    | 13 ++++++
 Documentation/git-format-patch.txt |  7 ++-
 builtin/log.c                      | 18 +++++++-
 t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  48b6331d75 = 1:  4c3535f25b git-format-patch.txt: document --no-notes option
2:  1338045be4 ! 2:  fe674bf63e format-patch: teach format.notes config option
    @@ -8,8 +8,9 @@
         that they may forget to include it and generate a patch series without
         notes.
     
    -    Teach git-format-patch the `format.notes` config option where if its
    -    value is true, notes will automatically be appended. This option is
    +    Teach git-format-patch the `format.notes` config option its value is a
    +    notes ref that will be automatically be appended. The special value of
    +    "standard" can be used to specify the standard notes. This option is
         overridable with the `--no-notes` option in case a user wishes not to
         append notes.
     
    @@ -24,8 +25,17 @@
      	format-patch by default.
     +
     +format.notes::
    -+	A boolean value which lets you enable the `--notes` option of
    -+	format-patch by default.
    ++	A ref which specifies where to get the notes (see
    ++	linkgit:git-notes[1]) that are appended for the commit after the
    ++	three-dash line.
    +++
    ++If the special value of "standard" is specified, then the standard notes
    ++ref is used (i.e. the notes ref used by `git notes` when no `--ref`
    ++argument is specified). If one wishes to use the ref
    ++`ref/notes/standard`, please use that literal instead.
    +++
    ++This configuration can be specified multiple times in order to allow
    ++multiple notes refs to be included.
     
      diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
      --- a/Documentation/git-format-patch.txt
    @@ -45,32 +55,45 @@
      --- a/builtin/log.c
      +++ b/builtin/log.c
     @@
    - static const char *signature_file;
    - static int config_cover_letter;
    - static const char *config_output_directory;
    -+static int show_notes;
      
    - enum {
    - 	COVER_UNSET,
    + static int git_format_config(const char *var, const char *value, void *cb)
    + {
    ++	struct rev_info *rev = cb;
    ++
    + 	if (!strcmp(var, "format.headers")) {
    + 		if (!value)
    + 			die(_("format.headers without value"));
     @@
      			from = NULL;
      		return 0;
      	}
     +	if (!strcmp(var, "format.notes")) {
    -+		show_notes = git_config_bool(var, value);
    ++		struct strbuf buf = STRBUF_INIT;
    ++
    ++		rev->show_notes = 1;
    ++		if (!strcmp(value, "standard"))
    ++			rev->notes_opt.use_default_notes = 1;
    ++		else {
    ++			strbuf_addstr(&buf, value);
    ++			expand_notes_ref(&buf);
    ++			string_list_append(&rev->notes_opt.extra_notes_refs,
    ++					strbuf_detach(&buf, NULL));
    ++		}
     +		return 0;
     +	}
      
      	return git_log_config(var, value, cb);
      }
     @@
    - 	rev.max_parents = 1;
    - 	rev.diffopt.flags.recursive = 1;
    - 	rev.subject_prefix = fmt_patch_subject_prefix;
    -+	rev.show_notes = show_notes;
    - 	memset(&s_r_opt, 0, sizeof(s_r_opt));
    - 	s_r_opt.def = "HEAD";
    - 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
    + 	extra_to.strdup_strings = 1;
    + 	extra_cc.strdup_strings = 1;
    + 	init_log_defaults();
    +-	git_config(git_format_config, NULL);
    + 	repo_init_revisions(the_repository, &rev, prefix);
    ++	git_config(git_format_config, &rev);
    + 	rev.commit_format = CMIT_FMT_EMAIL;
    + 	rev.expand_tabs_in_log_default = 0;
    + 	rev.verbose_header = 1;
     
      diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
      --- a/t/t4014-format-patch.sh
    @@ -94,7 +117,7 @@
     +	git format-patch -1 --stdout --no-notes --notes >out &&
     +	grep "notes config message" out &&
     +
    -+	test_config format.notes true &&
    ++	test_config format.notes standard &&
     +	git format-patch -1 --stdout >out &&
     +	grep "notes config message" out &&
     +	git format-patch -1 --stdout --notes >out &&
    @@ -106,6 +129,48 @@
     +	git format-patch -1 --stdout --no-notes --notes >out &&
     +	grep "notes config message" out
     +'
    ++
    ++test_expect_success 'format-patch with multiple notes refs' '
    ++	git notes --ref note1 add -m "this is note 1" HEAD &&
    ++	test_when_finished git notes --ref note1 remove HEAD &&
    ++	git notes --ref note2 add -m "this is note 2" HEAD &&
    ++	test_when_finished git notes --ref note2 remove HEAD &&
    ++
    ++	git format-patch -1 --stdout >out &&
    ++	! grep "this is note 1" out &&
    ++	! grep "this is note 2" out &&
    ++	git format-patch -1 --stdout --notes=note1 >out &&
    ++	grep "this is note 1" out &&
    ++	! grep "this is note 2" out &&
    ++	git format-patch -1 --stdout --notes=note2 >out &&
    ++	! grep "this is note 1" out &&
    ++	grep "this is note 2" out &&
    ++	git format-patch -1 --stdout --notes=note1 --notes=note2 >out &&
    ++	grep "this is note 1" out &&
    ++	grep "this is note 2" out &&
    ++
    ++	test_config format.notes note1 &&
    ++	git format-patch -1 --stdout >out &&
    ++	grep "this is note 1" out &&
    ++	! grep "this is note 2" out &&
    ++	git format-patch -1 --stdout --no-notes >out &&
    ++	! grep "this is note 1" out &&
    ++	! grep "this is note 2" out &&
    ++	git format-patch -1 --stdout --notes=note2 >out &&
    ++	grep "this is note 1" out &&
    ++	grep "this is note 2" out &&
    ++	git format-patch -1 --stdout --no-notes --notes=note2 >out &&
    ++	! grep "this is note 1" out &&
    ++	grep "this is note 2" out &&
    ++
    ++	git config --add format.notes note2 &&
    ++	git format-patch -1 --stdout >out &&
    ++	grep "this is note 1" out &&
    ++	grep "this is note 2" out &&
    ++	git format-patch -1 --stdout --no-notes >out &&
    ++	! grep "this is note 1" out &&
    ++	! grep "this is note 2" out
    ++'
     +
      echo "fatal: --name-only does not make sense" > expect.name-only
      echo "fatal: --name-status does not make sense" > expect.name-status
-- 
2.21.0.1049.geb646f7864

