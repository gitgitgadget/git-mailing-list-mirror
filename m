Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843241F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEHPCS (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:02:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45955 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfEHPCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:02:18 -0400
Received: by mail-io1-f68.google.com with SMTP id b3so11649232iob.12
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GsrmezleQJpT1av+fMClQqA8GAh9SF4urUTtqMqyZAU=;
        b=LMwT38CeWnRTvN6IpNfqX1WA5f14Nt+N567obvslyCaX1/ws0R9D/SPP+GUDFJXky0
         aI0Us7AFsSqlqHZFcbEwK0oKtuySUrGiSovnaPJ/8+Af2BbePjKYz3WnAExLlrXlBN56
         vLx38VtEOA+jk6kVikg+Pp/iNHZ0sVEUMx4EkqPTgaAfz9v5EazIha5Zbmf31rco6SPb
         Fnc5Du2bQ10s+SwSLw8mN6TzRRLjRbS+Nz/35kCdlzs602Tfq1lIGiax7/E2D3x9hpVr
         gZrmnt7LcQEpu1SqcbtYJ3oSL+6xJ3N7AnF0+f31SPsDb94xiiZbu3x8AraLbCgAKf42
         Xx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GsrmezleQJpT1av+fMClQqA8GAh9SF4urUTtqMqyZAU=;
        b=HYquPuTeuDxp/cxz8wfRtHPsc4FdKhrqzk90g76mHsBIBp5HE1hxozyf67KmLzoZrB
         28nOzIREMCSZFPyVEucfKSK7N8zU3hX7n5oJpcT1KVX1KIVa7CRUSGhcHTPzw7U5QEIH
         aaZL3ZLFefrVSqyECtApp81oZoKa1qbpUAY2KimJO7uGWk+MYKr+Ks5MPXeY54BBdIte
         p3CfX63op6wX7kF4GbZmeLAm9NyodRU+A1Kwi5zdqjWcqFEtEA0CVg3VTwZPWBoF+jUN
         QyzQXl34cyLilDlJe27bSXpzEXyL0UdSQw/66LLCZ1/J6CupB69ZxYIzL7sQnp4FC+QT
         7ARw==
X-Gm-Message-State: APjAAAW9YsCMirdcgw7A8Zu/k87YH61aUBEMqRGSpvOvlY7QD0+qcpx4
        4JlKiqc0LplYyjIoSvHblbY3z+Dq
X-Google-Smtp-Source: APXvYqwjz3IJ0opKH3w4q0eq3H2/J1SEygsZT0VsnjiIBCpyzZEW/az+ln6l2dBG2M1SFzRMvQRaoA==
X-Received: by 2002:a6b:3e04:: with SMTP id l4mr4184770ioa.80.1557327736697;
        Wed, 08 May 2019 08:02:16 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:780:ed13:bfd5:1bea:adb7])
        by smtp.gmail.com with ESMTPSA id a196sm1319174itc.1.2019.05.08.08.02.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:02:15 -0700 (PDT)
Date:   Wed, 8 May 2019 11:02:14 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] format-patch: teach format.notes config option
Message-ID: <fe674bf63e8d5b8a06a3f880db4dc4bcfd2183f6.1557327652.git.liu.denton@gmail.com>
References: <cover.1556388260.git.liu.denton@gmail.com>
 <cover.1557327652.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557327652.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-format-patch, notes can be appended with the `--notes` option.
However, this must be specified by the user on an
invocation-by-invocation basis. If a user is not careful, it's possible
that they may forget to include it and generate a patch series without
notes.

Teach git-format-patch the `format.notes` config option its value is a
notes ref that will be automatically be appended. The special value of
"standard" can be used to specify the standard notes. This option is
overridable with the `--no-notes` option in case a user wishes not to
append notes.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
One thing I'm worried about is that I'm not really sure using "standard"
as the special value is a good idea. Would "auto" be a better special
value?

 Documentation/config/format.txt    | 13 ++++++
 Documentation/git-format-patch.txt |  3 ++
 builtin/log.c                      | 18 +++++++-
 t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index dc77941c48..e25f9cfc61 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -85,3 +85,16 @@ format.outputDirectory::
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
 	format-patch by default.
+
+format.notes::
+	A ref which specifies where to get the notes (see
+	linkgit:git-notes[1]) that are appended for the commit after the
+	three-dash line.
++
+If the special value of "standard" is specified, then the standard notes
+ref is used (i.e. the notes ref used by `git notes` when no `--ref`
+argument is specified). If one wishes to use the ref
+`ref/notes/standard`, please use that literal instead.
++
+This configuration can be specified multiple times in order to allow
+multiple notes refs to be included.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 2c3971390e..9ce5b8aaee 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -275,6 +275,9 @@ these explanations after `format-patch` has run but before sending,
 keeping them as Git notes allows them to be maintained between versions
 of the patch series (but see the discussion of the `notes.rewrite`
 configuration options in linkgit:git-notes[1] to use this workflow).
++
+The default is `--no-notes`, unless the `format.notes` configuration is
+set.
 
 --[no-]signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature
diff --git a/builtin/log.c b/builtin/log.c
index e43ee12fb1..24954e42b0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -779,6 +779,8 @@ enum {
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
+	struct rev_info *rev = cb;
+
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
 			die(_("format.headers without value"));
@@ -864,6 +866,20 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			from = NULL;
 		return 0;
 	}
+	if (!strcmp(var, "format.notes")) {
+		struct strbuf buf = STRBUF_INIT;
+
+		rev->show_notes = 1;
+		if (!strcmp(value, "standard"))
+			rev->notes_opt.use_default_notes = 1;
+		else {
+			strbuf_addstr(&buf, value);
+			expand_notes_ref(&buf);
+			string_list_append(&rev->notes_opt.extra_notes_refs,
+					strbuf_detach(&buf, NULL));
+		}
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1617,8 +1633,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
 	init_log_defaults();
-	git_config(git_format_config, NULL);
 	repo_init_revisions(the_repository, &rev, prefix);
+	git_config(git_format_config, &rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b6e2fdbc44..e0127282ba 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -738,6 +738,76 @@ test_expect_success 'format-patch --notes --signoff' '
 	sed "1,/^---$/d" out | grep "test message"
 '
 
+test_expect_success 'format-patch notes output control' '
+	git notes add -m "notes config message" HEAD &&
+	test_when_finished git notes remove HEAD &&
+
+	git format-patch -1 --stdout >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes --notes >out &&
+	grep "notes config message" out &&
+
+	test_config format.notes standard &&
+	git format-patch -1 --stdout >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --notes >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes --notes >out &&
+	grep "notes config message" out
+'
+
+test_expect_success 'format-patch with multiple notes refs' '
+	git notes --ref note1 add -m "this is note 1" HEAD &&
+	test_when_finished git notes --ref note1 remove HEAD &&
+	git notes --ref note2 add -m "this is note 2" HEAD &&
+	test_when_finished git notes --ref note2 remove HEAD &&
+
+	git format-patch -1 --stdout >out &&
+	! grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git format-patch -1 --stdout --notes=note1 >out &&
+	grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git format-patch -1 --stdout --notes=note2 >out &&
+	! grep "this is note 1" out &&
+	grep "this is note 2" out &&
+	git format-patch -1 --stdout --notes=note1 --notes=note2 >out &&
+	grep "this is note 1" out &&
+	grep "this is note 2" out &&
+
+	test_config format.notes note1 &&
+	git format-patch -1 --stdout >out &&
+	grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git format-patch -1 --stdout --notes=note2 >out &&
+	grep "this is note 1" out &&
+	grep "this is note 2" out &&
+	git format-patch -1 --stdout --no-notes --notes=note2 >out &&
+	! grep "this is note 1" out &&
+	grep "this is note 2" out &&
+
+	git config --add format.notes note2 &&
+	git format-patch -1 --stdout >out &&
+	grep "this is note 1" out &&
+	grep "this is note 2" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "this is note 1" out &&
+	! grep "this is note 2" out
+'
+
 echo "fatal: --name-only does not make sense" > expect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
 echo "fatal: --check does not make sense" > expect.check
-- 
2.21.0.1049.geb646f7864

