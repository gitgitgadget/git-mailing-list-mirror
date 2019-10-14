Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DE01F4C1
	for <e@80x24.org>; Mon, 14 Oct 2019 20:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbfJNUrA (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:47:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33338 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfJNUrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:47:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so11041035pfl.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 13:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=od8c9RneSCB+cCFZhL4csi1gn7iCep0IlOsUM0EZcCI=;
        b=gKXwg+ncjRT90G7EjIC0YCxVcHN3yGQXyxxZSFINXoexsofT3MA77m21OxDuy7zK5e
         o+Nn4/ul3GJsPgrajhiLQkY6gR5GuSSKFhgEF+b1gIV97zHc8t9gXDgq/DSoOhS43wqi
         V15FRBvzx7crVb2vlNvkQOa2jGmTEbIqIJOKE20ga+6o+MOvC3liR7aU5CfjnlItX2YD
         zZN9W/XVrnmmFwj+Z1BUrK4uyk8iwRyEFk3Ewdp3mqk6IhYKsVnWCAiZqmU2uNEwlov4
         A++TfOGY/I55z0fvRux8FQnr7LgO0EpDFv3e5bRxijapclHiI/uUURWMnEA/BuOqS/xt
         H3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=od8c9RneSCB+cCFZhL4csi1gn7iCep0IlOsUM0EZcCI=;
        b=QDC+EH5JNpb3wBensP9J/3vAtuP6Eu4DfBAbS8OpjSxcqlGPSxx5gKgW9ppPXh2x3K
         QMftpiEvCS+s33nydgBClaG8FKQkCMtlnvryHno3S9nUYNfYc0IknLE0c2zcXzpIs4Mv
         TQzgn6z3CNv/tQ/r8PDL+4P49LHcQz1ICaesti8IlaelLbaqL40/ankcng5FvORfrDo4
         PpmGL2atNawig375vEy6sLVmX1gpCMnFhcIBGsRNSKLG0B9uRcw7HqG6FXKMWD884EZy
         neBNb3dFuzxThMiPthOQgcqjEDUuo88ePhNYHI7hUn8FwkA+bO+K49aGDC5vwcQYZl6o
         QOvw==
X-Gm-Message-State: APjAAAU4OEAkoPZ7Ei6jBq8wx3pHOd/MTRHQYzH2MSVVRUMCx+MerA7r
        dDHLYA8QeBI/znsImPbgGmRDf1ld
X-Google-Smtp-Source: APXvYqzEG8f0fOGVNhqVP4fNKQTvhH1DPZufs3d2A1ek0M8z/3HqgakXp9yEmKkITGLJT0Ax4+StiA==
X-Received: by 2002:a63:6d8c:: with SMTP id i134mr34440534pgc.321.1571086018933;
        Mon, 14 Oct 2019 13:46:58 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id z20sm20400171pfj.156.2019.10.14.13.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 13:46:57 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:46:55 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 0/3] format-patch: learn --cover-from-description option
Message-ID: <cover.1571085952.git.liu.denton@gmail.com>
References: <cover.1570821015.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570821015.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, format-patch only puts "*** SUBJECT HERE ***" when a cover
letter is generated. However, it is already smart enough to be able to
populate the cover letter with the branch description so there's no
reason why it cannot populate the subject as well.

Teach format-patch the `--cover-from-description` option and
corresponding `format.coverFromDescription` configuration option which
will allow it to populate not only the body but the subject as well.

Changes since v4:

* Modify 1/3 to more closely reflect intent of the original author

* Incorporate Junio's suggestions into the documentation

* Extract branch desc logic into pp_from_desc()

* Fix broken tests

Changes since v3:

* Change --infer-cover-subject to --cover-from-description

* No more test cleanup patches (they were merged in
  'dl/format-patch-doc-test-cleanup')

Changes since v2:

* Break 1/4 into many different patches (one per paragraph of the
  original patch)

* Incorporate Eric's documentation/commit message suggestions

Changes since v1:

* Incorporate Eric's suggestions for cleanup in all patches

* Add patch 3/4 to make it clear what is the default value for
  format.coverLetter (since format.inferCoverSubject was borrowed from
  this config but it also did not state what the default value was)

* In 1/4, rename all instances of "expected" to "expect"

Denton Liu (3):
  format-patch: change erroneous and condition
  format-patch: use enum variables
  format-patch: teach --cover-from-description option

 Documentation/config/format.txt    |   6 +
 Documentation/git-format-patch.txt |  22 ++++
 builtin/log.c                      | 125 +++++++++++++++------
 t/t4014-format-patch.sh            | 172 +++++++++++++++++++++++++++++
 t/t9902-completion.sh              |   5 +-
 5 files changed, 296 insertions(+), 34 deletions(-)

Range-diff against v4:
1:  267bc00dc8 ! 1:  56fb230ad2 format-patch: remove erroneous and condition
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    format-patch: remove erroneous and condition
    +    format-patch: change erroneous and condition
     
         Commit 30984ed2e9 (format-patch: support deep threading, 2009-02-19),
         introduced the following lines:
    @@ Commit message
                 thread = git_config_bool(var, value) && THREAD_SHALLOW;
     
         Since git_config_bool() returns a bool, the trailing `&& THREAD_SHALLOW`
    -    is a no-op. Remove this erroneous and condition.
    +    is a no-op.
    +
    +    In Python, `x and y` is equivalent to `y if x else x`[1]. Since this
    +    seems to be a Python-ism that's mistakenly leaked into our code, convert
    +    this to the equivalent C expression.
    +
    +    [1]: https://docs.python.org/3/reference/expressions.html#boolean-operations
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/log.c ##
     @@ builtin/log.c: static int git_format_config(const char *var, const char *value, void *cb)
    @@ builtin/log.c: static int git_format_config(const char *var, const char *value,
      			return 0;
      		}
     -		thread = git_config_bool(var, value) && THREAD_SHALLOW;
    -+		thread = git_config_bool(var, value);
    ++		thread = git_config_bool(var, value) ? THREAD_SHALLOW : THREAD_UNSET;
      		return 0;
      	}
      	if (!strcmp(var, "format.signoff")) {
2:  638a5b40d2 ! 2:  e2769092fa format-patch: use enum variables
    @@ Commit message
         variables to use these new definitions.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/log.c ##
     @@ builtin/log.c: static void add_header(const char *value)
3:  3289ce62bb ! 3:  315c308950 format-patch: teach --cover-from-description option
    @@ Commit message
         populate different parts of the cover letter (including the subject
         now).
     
    -    Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
      ## Documentation/config/format.txt ##
     @@ Documentation/config/format.txt: format.subjectPrefix::
      	The default for format-patch is to output files with the '[PATCH]'
    @@ Documentation/git-format-patch.txt: will want to ensure that threading is disabl
     ++
     +If `<mode>` is `message` or `default`, the cover letter subject will be
     +populated with placeholder text. The body of the cover letter will be
    -+populated with the branch's description.
    ++populated with the branch's description. This is the default mode when
    ++no configuration nor command line option is specified.
     ++
    -+If `<mode>` is `subject`, the beginning of the branch description (up to
    -+the first blank line) will populate the cover letter subject. The
    -+remainder of the description will populate the body of the cover
    -+letter.
    ++If `<mode>` is `subject`, the first paragraph of the branch description will
    ++populate the cover letter subject. The remainder of the description will
    ++populate the body of the cover letter.
     ++
    -+If `<mode>` is `auto`, if the beginning of the branch description (up to
    -+the first line) is greater than 100 characters then the mode will be
    -+`message`, otherwise `subject` will be used.
    ++If `<mode>` is `auto`, if the first paragraph of the branch description
    ++is greater than 100 bytes, then the mode will be `message`, otherwise
    ++`subject` will be used.
     ++
     +If `<mode>` is `none`, both the cover letter subject and body will be
     +populated with placeholder text.
    @@ builtin/log.c: static void print_signature(FILE *file)
      static char *find_branch_name(struct rev_info *rev)
      {
      	int i, positive = -1;
    -@@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_stdout,
    +@@ builtin/log.c: static void show_diffstat(struct rev_info *rev,
    + 	fprintf(rev->diffopt.file, "\n");
    + }
    + 
    ++static void pp_from_desc(struct pretty_print_context *pp,
    ++			 const char *branch_name,
    ++			 struct strbuf *sb,
    ++			 const char *encoding,
    ++			 int need_8bit_cte)
    ++{
    ++	const char *subject = "*** SUBJECT HERE ***";
    ++	const char *body = "*** BLURB HERE ***";
    ++	struct strbuf description_sb = STRBUF_INIT;
    ++	struct strbuf subject_sb = STRBUF_INIT;
    ++
    ++	if (cover_from_description_mode == COVER_FROM_NONE)
    ++		goto do_pp;
    ++
    ++	if (branch_name && *branch_name)
    ++		read_branch_desc(&description_sb, branch_name);
    ++	if (!description_sb.len)
    ++		goto do_pp;
    ++
    ++	if (cover_from_description_mode == COVER_FROM_SUBJECT ||
    ++			cover_from_description_mode == COVER_FROM_AUTO)
    ++		body = format_subject(&subject_sb, description_sb.buf, " ");
    ++
    ++	if (cover_from_description_mode == COVER_FROM_MESSAGE ||
    ++			(cover_from_description_mode == COVER_FROM_AUTO &&
    ++			 subject_sb.len > COVER_FROM_AUTO_MAX_SUBJECT_LEN))
    ++		body = description_sb.buf;
    ++	else
    ++		subject = subject_sb.buf;
    ++
    ++do_pp:
    ++	pp_title_line(pp, &subject, sb, encoding, need_8bit_cte);
    ++	pp_remainder(pp, &body, sb, 0);
    ++
    ++	strbuf_release(&description_sb);
    ++	strbuf_release(&subject_sb);
    ++}
    ++
    + static void make_cover_letter(struct rev_info *rev, int use_stdout,
      			      struct commit *origin,
      			      int nr, struct commit **list,
    - 			      const char *branch_name,
    -+			      enum cover_from_description cover_from_description_mode,
    +@@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_stdout,
      			      int quiet)
      {
      	const char *committer;
     -	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
     -	const char *msg;
    -+	const char *subject = "*** SUBJECT HERE ***";
    -+	const char *body = "*** BLURB HERE ***";
      	struct shortlog log;
      	struct strbuf sb = STRBUF_INIT;
    -+	struct strbuf description_sb = STRBUF_INIT;
    -+	struct strbuf subject_sb = STRBUF_INIT;
      	int i;
    - 	const char *encoding = "UTF-8";
    - 	int need_8bit_cte = 0;
     @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_stdout,
      	if (!branch_name)
      		branch_name = find_branch_name(rev);
      
     -	msg = body;
    -+	if (branch_name && *branch_name)
    -+		read_branch_desc(&description_sb, branch_name);
    -+
    -+	if (cover_from_description_mode != COVER_FROM_NONE && description_sb.len) {
    -+		if (cover_from_description_mode == COVER_FROM_SUBJECT ||
    -+				cover_from_description_mode == COVER_FROM_AUTO)
    -+			body = format_subject(&subject_sb, description_sb.buf, " ");
    -+
    -+		if (cover_from_description_mode == COVER_FROM_MESSAGE ||
    -+				(cover_from_description_mode == COVER_FROM_AUTO &&
    -+				 subject_sb.len > COVER_FROM_AUTO_MAX_SUBJECT_LEN))
    -+			body = description_sb.buf;
    -+		else
    -+			subject = subject_sb.buf;
    -+	}
    -+
      	pp.fmt = CMIT_FMT_EMAIL;
      	pp.date_mode.type = DATE_RFC2822;
      	pp.rev = rev;
    @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_stdou
     -	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
     -	pp_remainder(&pp, &msg, &sb, 0);
     -	add_branch_description(&sb, branch_name);
    -+	pp_title_line(&pp, &subject, &sb, encoding, need_8bit_cte);
    -+	pp_remainder(&pp, &body, &sb, 0);
    -+	strbuf_addch(&sb, '\n');
    ++	pp_from_desc(&pp, branch_name, &sb, encoding, need_8bit_cte);
      	fprintf(rev->diffopt.file, "%s\n", sb.buf);
      
    -+	strbuf_release(&description_sb);
    -+	strbuf_release(&subject_sb);
      	strbuf_release(&sb);
    - 
    - 	shortlog_init(&log);
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
      	int use_patch_format = 0;
      	int quiet = 0;
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      	if (0 < reroll_count) {
      		struct strbuf sprefix = STRBUF_INIT;
      		strbuf_addf(&sprefix, "%s v%d",
    -@@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    - 		if (thread)
    - 			gen_message_id(&rev, "cover");
    - 		make_cover_letter(&rev, use_stdout,
    --				  origin, nr, list, branch_name, quiet);
    -+				  origin, nr, list, branch_name, cover_from_description_mode, quiet);
    - 		print_bases(&bases, rev.diffopt.file);
    - 		print_signature(rev.diffopt.file);
    - 		total++;
     
      ## t/t4014-format-patch.sh ##
     @@ t/t4014-format-patch.sh: test_expect_success 'format patch ignores color.ui' '
    @@ t/t4014-format-patch.sh: test_expect_success 'format patch ignores color.ui' '
      test_expect_success 'cover letter using branch description (1)' '
      	git checkout rebuild-1 &&
      	test_config branch.rebuild-1.description hello &&
    +
    + ## t/t9902-completion.sh ##
    +@@ t/t9902-completion.sh: test_expect_success 'complete tree filename with metacharacters' '
    + '
    + 
    + test_expect_success PERL 'send-email' '
    +-	test_completion "git send-email --cov" "--cover-letter " &&
    ++	test_completion "git send-email --cov" <<-\EOF &&
    ++	--cover-from-description=Z
    ++	--cover-letter Z
    ++	EOF
    + 	test_completion "git send-email ma" "master "
    + '
    + 
-- 
2.23.0.17.g315c308950

