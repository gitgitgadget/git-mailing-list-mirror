Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90671F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfHTHSr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:18:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45086 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:18:47 -0400
Received: by mail-io1-f68.google.com with SMTP id t3so10031106ioj.12
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PJymlEV06ALy1MaJ75xJwz5/JUXBdPg88cRTAsTYwYA=;
        b=td/xe29IjMN27f82st3DG0BxjJSlos04GAyWNyVuiSFerCZ0zKjCnxg4CgNgK7ZVVH
         PN5lZaGJfaEwOO52OA/XtLOBQhIi5BKs2uYxbjWZg26U/RdfjQJYxZcte7x3PgUcFaRn
         g4bP5Dmzo5MbsfoY57vt5bhf/E+cozdxj34WPkzcHg/qWtax/jqpMq6KqEpUerqZN55E
         jmD9l2SouPTOcoIjhwJy0OAtINLwpowXUsnGuQKmOq+Z6LFiRBPuCkzaj3zgQmuJYRXH
         ku3Rqs+IZdTGLw1Xs7GfvOPQL6eGFjrLSGX1v1rq4oBeK3wlO9urfLpHv3lCUSvQBcyx
         cPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJymlEV06ALy1MaJ75xJwz5/JUXBdPg88cRTAsTYwYA=;
        b=X+0s53vsLqN7oItgenVQJHu0Rkjhpvw7ctt9cNjkSW4dGvF5cbpVjTXgD+6JwaFs8G
         MKEl6LTDWIpd2NmHr9c7BJXqx5XxPxvgPGpr+EIWHonYnnJeBraMSzwjAZZCXBnqBiwK
         mIaFTYRyxYS7oCI8AW3xxdP0rIL28lx3yrHJjtXx7mKlubakrSXBO5ssvX+3rUoMPE+K
         m5dcG52vULebBhgfA7EDS2S3MiYBWxc0CETuBv4wZmsCXi6XV7l5eLdZlcpNVIwLHJ9V
         46ZBuH0gOCWhVXB6ZsWCxzKtztEUtNLuqu++fTSGts7QP5Z6A3XLU+ZMr0hUSAfrn18l
         Sgkw==
X-Gm-Message-State: APjAAAXTGURnzBpRTUX5HhuZ/UxLPoaVwnR7sRYWMZUUjqpaIgZluz/r
        DSyyTAUDPFH47cYXgx6vKHRe8H6L
X-Google-Smtp-Source: APXvYqwEg4WQK2mGKSk1s467E2jbo6XLAwBksKKNV3psVWMi2cncXs8NIHesvMgeNcFuNhYMMTN0xA==
X-Received: by 2002:a6b:a12:: with SMTP id z18mr17337761ioi.222.1566285526122;
        Tue, 20 Aug 2019 00:18:46 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id j16sm16224789iok.34.2019.08.20.00.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:18:45 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:18:43 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/13] format-patch: learn --infer-cover-subject option
 (also t4014 cleanup)
Message-ID: <cover.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566258525.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for another round of reviews, Eric. I've incorporated most of
your suggestions, including breaking the t4014 cleanup patch into
multiple patches. Hopefully it isn't such a doozy to review now.

Currently, format-patch only puts "*** SUBJECT HERE ***" when a cover
letter is generated. However, it is already smart enough to be able to
populate the cover letter with the branch description so there's no
reason why it cannot populate the subject as well.

Teach format-patch the `--infer-cover-subject` option and corresponding
`format.inferCoverSubject` configuration option which will read the
subject from the branch description using the same rules as for a commit
message (that is, it will expect a subject line followed by a blank
line).

While we're at it, perform some major cleanup of t4014 including some
stylistic cleanup and also, unmasking of Git return codes.

This was based on patches 1-3 of an earlier patchset I sent[1].

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


Denton Liu (13):
  t4014: drop unnecessary blank lines from test cases
  t4014: s/expected/expect/
  t4014: move closing sq onto its own line
  t4014: use sq for test case names
  t4014: remove spaces after redirect operators
  t4014: use indentable here-docs
  t4014: drop redirections to /dev/null
  t4014: use test_line_count() where possible
  t4014: remove confusing pipe in check_threading()
  t4014: stop losing return codes of git commands
  Doc: add more detail for git-format-patch
  config/format.txt: specify default value of format.coverLetter
  format-patch: learn --infer-cover-subject option

 Documentation/config/format.txt    |   7 +
 Documentation/git-format-patch.txt |  24 +-
 builtin/log.c                      |  56 +-
 t/t4014-format-patch.sh            | 822 +++++++++++++++--------------
 4 files changed, 486 insertions(+), 423 deletions(-)

Range-diff against v2:
 1:  76a0a274fd <  -:  ---------- t4014: clean up style
 -:  ---------- >  1:  fb000bfca2 t4014: drop unnecessary blank lines from test cases
 -:  ---------- >  2:  568b3a03a0 t4014: s/expected/expect/
 -:  ---------- >  3:  a205a920bd t4014: move closing sq onto its own line
 -:  ---------- >  4:  66bf2e3dd4 t4014: use sq for test case names
 -:  ---------- >  5:  6f1371275e t4014: remove spaces after redirect operators
 -:  ---------- >  6:  b4295846f5 t4014: use indentable here-docs
 -:  ---------- >  7:  34315412c8 t4014: drop redirections to /dev/null
 -:  ---------- >  8:  de08dd886d t4014: use test_line_count() where possible
 -:  ---------- >  9:  dec5a62e82 t4014: remove confusing pipe in check_threading()
 -:  ---------- > 10:  64069c0c54 t4014: stop losing return codes of git commands
 2:  fd908bcc01 ! 11:  c12534ab5d Doc: add more detail for git-format-patch
    @@ Commit message
         Doc: add more detail for git-format-patch
     
         In git-format-patch.txt, we were missing some key user information.
    -    First of all, using the `--to` and `--cc` options don't override
    -    `format.to` and `format.cc` variables, respectively. They add on to each
    -    other. Document this.
    -
    -    In addition, document the special value of `--base=auto`.
    +    First of all, document the special value of `--base=auto`.
     
         Next, while we're at it, surround option arguments with <>.
     
 3:  94a778c9aa <  -:  ---------- config/format.txt: make clear the default value of format.coverLetter
 -:  ---------- > 12:  a08273ebcc config/format.txt: specify default value of format.coverLetter
 4:  e682bd347a ! 13:  de599f7ca9 format-patch: learn --infer-cover-letter option
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    format-patch: learn --infer-cover-letter option
    +    format-patch: learn --infer-cover-subject option
     
    -    We used to populate the subject of the cover letter generated by
    -    git-format-patch with "*** SUBJECT HERE ***". However, if a user submits
    -    multiple patchsets, they may want to keep a consistent subject between
    -    rerolls.
    +    Teach format-patch to use the first line of the branch description as
    +    the Subject: of the generated cover letter, rather than "*** SUBJECT
    +    HERE ***" if `--infer-cover-subject` is specified or the corresponding
    +    `format.inferCoverSubject` option is enabled. This complements the
    +    existing inclusion of the branch description in the cover letter body.
     
    -    If git-format-patch is run with `--infer-cover-letter` or
    -    `format.inferCoverSubject`, infer the subject for the cover letter from
    -    the top line(s) of a branch description, similar to how a subject is
    -    read from a commit message.
    +    The reason why this behaviour is not made default is because this change
    +    is not backwards compatible and may break existing tooling that may rely
    +    on the default template subject.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ Documentation/config/format.txt: format.subjectPrefix::
      	subject prefix. Use this variable to change that prefix.
      
     +format.inferCoverSubject::
    -+	A boolean value which lets you enable the
    -+	`--infer-cover-subject` option of format-patch by default.
    ++	A boolean that controls whether or not to take the first line of
    ++	the branch description as the subject for the cover letter. See the
    ++	`--infer-cover-subject` option in linkgit:git-format-patch[1].
    ++	Default is false.
     +
      format.signature::
      	The default for format-patch is to output a signature containing
    @@ Documentation/git-format-patch.txt: will want to ensure that threading is disabl
      	ignored.
      
     +--[no-]infer-cover-subject::
    -+	Instead of using the default "*** SUBJECT HERE ***" subject for
    -+	the cover letter, infer the subject from the branch's
    -+	description.
    -++
    -+Similar to a commit message, the subject is inferred as the beginning of
    -+the description up to and excluding the first blank line.
    ++	Use the beginning of the branch description (up to the first
    ++	blank line) as the cover letter subject instead of the default
    ++	"*** SUBJECT HERE ***".
     +
      --subject-prefix=<Subject-Prefix>::
      	Instead of the standard '[PATCH]' prefix in the subject
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      			    N_("Use [RFC PATCH] instead of [PATCH]"),
      			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback },
     +		OPT_BOOL(0, "infer-cover-subject", &infer_cover_subject,
    -+			    N_("infer a cover letter subject from the branch description")),
    ++			    N_("infer a cover letter subject from branch description")),
      		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
      			    N_("Use [<prefix>] instead of [PATCH]"),
      			    PARSE_OPT_NONEG, subject_prefix_callback },
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
      		total++;
     
      ## t/t4014-format-patch.sh ##
    +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
    + '
    + 
    + test_expect_success 'get git version' '
    +-	git_version="$(git --version | sed "s/.* //")"
    ++	git_version="$(git --version >version && sed "s/.* //" <version)"
    + '
    + 
    + signature() {
     @@ t/t4014-format-patch.sh: test_expect_success 'format patch ignores color.ui' '
      	test_cmp expect actual
      '
-- 
2.23.0.248.g3a9dd8fb08

