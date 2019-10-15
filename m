Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDC71F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 09:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfJOJGg (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 05:06:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34339 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfJOJGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 05:06:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so12071825pfa.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LaBqj3xeb5q9Cnmgn4MqXFkVPdiHV2EE0IRpvbAefh0=;
        b=n0QF+xdf8OeMoHWc1r8hXYbY2kOhvgxNcDUViWPjV3+Ty5ZneTrrFrx3hXXTz7oIQp
         seSByl0udYk263uRbCAASRg5lZuX/4y2HjF6J2lJjR5qUYHuvMbpO/pV1OZ5zBct3fxb
         nuv2oPpxjFZ4/5TZqbuwkQENvEV/m7oYHspryZXUouT7FTRyA2+d+QCaWsUUnownDED3
         Q0XMXnz++H4eBY5F/1a7YXdAQaQdlW4HVPkfGo9U/sh/mZJdQfGKytXutjcDXVq7KenN
         eKerkX7ixpxeSQzRs9YfUkXnusfQ4sl6TmVuoHnikBJLzUVLozuc7GFESDK+rAfYvKSo
         eUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LaBqj3xeb5q9Cnmgn4MqXFkVPdiHV2EE0IRpvbAefh0=;
        b=Fo3e+DPCxgrnX+arphK2ECWkwdKgjS/1rD1p2oMrHYnT8MXkZ1wHE3prxB1uwid45/
         xCNgx20HXokV65knuMw2eFAMAkXSzHH7f/E2RRS199zNlK0YcdGBO4Rnt3syzK1FzUwP
         X9QB+m9GL/8uHvZrPysn1KuBOa4p0OtMlMq0XON3BySLyPuUt7CkkOjCxVsmEHEr3GhK
         wBD94CfA2tjqUhrnh1T4bV7BQv/EFHB1rmNTQlUIgl+e8pr0uiCu5zfiz9QKBhfOVwJa
         MVBUyQdMzaeMdpzgaZm1C5uvdvXXNwxBpVTb3oUIR09oqUbvGac8JXaeC89t1G4+bUVu
         s9bw==
X-Gm-Message-State: APjAAAV3e6ua8VVZP3ddDfDSUTfnbSA1MbdH8s9lYa8fyXW2BbsoM7N4
        rXKwK9T33tqqFN4q7jeFRQ/TPIUQ
X-Google-Smtp-Source: APXvYqwzXMUvOqufcPBXnJbM3HP35tFtY6P89uWGREVjhllyzXzhp614WRbNL5UBfmOu6sGJmWjZ0g==
X-Received: by 2002:a17:90a:a00c:: with SMTP id q12mr41723324pjp.102.1571130394895;
        Tue, 15 Oct 2019 02:06:34 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id l21sm20189104pgm.55.2019.10.15.02.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 02:06:33 -0700 (PDT)
Date:   Tue, 15 Oct 2019 02:06:31 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 0/3] format-patch: learn --infer-cover-subject option
 (also t4014 cleanup)
Message-ID: <cover.1571130298.git.liu.denton@gmail.com>
References: <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, format-patch only puts "*** SUBJECT HERE ***" when a cover
letter is generated. However, it is already smart enough to be able to
populate the cover letter with the branch description so there's no
reason why it cannot populate the subject as well.

Teach format-patch the `--infer-cover-subject` option and corresponding
`format.inferCoverSubject` configuration option which will read the
subject from the branch description using the same rules as for a commit
message (that is, it will expect a subject line followed by a blank
line).

This was based on patches 1-3 of an earlier patchset I sent[1].

Changes since v5:

* Remove speculation in log message of 1/3

* Rename pp_from_desc() to prepare_cover_text()

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

[1]: https://public-inbox.org/git/cover.1558492582.git.liu.denton@gmail.com/

Denton Liu (3):
  format-patch: replace erroneous and condition
  format-patch: use enum variables
  format-patch: teach --cover-from-description option

 Documentation/config/format.txt    |   6 +
 Documentation/git-format-patch.txt |  22 ++++
 builtin/log.c                      | 125 +++++++++++++++------
 t/t4014-format-patch.sh            | 172 +++++++++++++++++++++++++++++
 t/t9902-completion.sh              |   5 +-
 5 files changed, 296 insertions(+), 34 deletions(-)

Range-diff against v5:
1:  f89e56545b ! 1:  9d41068e73 format-patch: change erroneous and condition
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    format-patch: change erroneous and condition
    +    format-patch: replace erroneous and condition
     
         Commit 30984ed2e9 (format-patch: support deep threading, 2009-02-19),
         introduced the following lines:
    @@ Commit message
                 thread = git_config_bool(var, value) && THREAD_SHALLOW;
     
         Since git_config_bool() returns a bool, the trailing `&& THREAD_SHALLOW`
    -    is a no-op.
    -
    -    In Python, `x and y` is equivalent to `y if x else x`[1]. Since this
    -    seems to be a Python-ism that's mistakenly leaked into our code, convert
    -    this to the equivalent C expression.
    -
    -    [1]: https://docs.python.org/3/reference/expressions.html#boolean-operations
    -
    -    Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    is a no-op. Replace this errorneous and condition with a ternary
    +    statement so that it is clear what the configured value is when a
    +    boolean is given.
     
      ## builtin/log.c ##
     @@ builtin/log.c: static int git_format_config(const char *var, const char *value, void *cb)
2:  1fe780b5a4 = 2:  821e706bae format-patch: use enum variables
3:  d5cd34a44b ! 3:  42b4a60fd2 format-patch: teach --cover-from-description option
    @@ builtin/log.c: static void show_diffstat(struct rev_info *rev,
      	fprintf(rev->diffopt.file, "\n");
      }
      
    -+static void pp_from_desc(struct pretty_print_context *pp,
    -+			 const char *branch_name,
    -+			 struct strbuf *sb,
    -+			 const char *encoding,
    -+			 int need_8bit_cte)
    ++static void prepare_cover_text(struct pretty_print_context *pp,
    ++			       const char *branch_name,
    ++			       struct strbuf *sb,
    ++			       const char *encoding,
    ++			       int need_8bit_cte)
     +{
     +	const char *subject = "*** SUBJECT HERE ***";
     +	const char *body = "*** BLURB HERE ***";
    @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_stdou
     -	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
     -	pp_remainder(&pp, &msg, &sb, 0);
     -	add_branch_description(&sb, branch_name);
    -+	pp_from_desc(&pp, branch_name, &sb, encoding, need_8bit_cte);
    ++	prepare_cover_text(&pp, branch_name, &sb, encoding, need_8bit_cte);
      	fprintf(rev->diffopt.file, "%s\n", sb.buf);
      
      	strbuf_release(&sb);
-- 
2.23.0.17.gd2208d9060

