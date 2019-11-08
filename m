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
	by dcvr.yhbt.net (Postfix) with ESMTP id AA85A1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfKHUIR (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:17 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:42476 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbfKHUIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:17 -0500
Received: by mail-pg1-f176.google.com with SMTP id q17so4615437pgt.9
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XFJ7oYIW3jEmGG55YwZA5z9/zQ04aeXZ67VeO8EpI8w=;
        b=XdiDqtSmgcoAQ/xHV+vtcbzF5lMVGvJhhLmzKgxHKleZw3ubJ4d6lrRd8pxDvoFAhk
         pn/qvcoXRCGLoT1dXJLWrhvY/oq+pgn/1xxs1gShi9WxP2+dXe0+zeOKjfibXxmMWMqF
         XweEf0XKju9eOMH54JlcpsQq+QqJW1gEmm530u6H7ZjdojpTEUe3W5tFaJss3pPVFppU
         n6QwaLv0G6GX7LlUFcV/8IieGC0t8KycQEyzSM39r6iZEoPUZfY83KiqWNY/LyYuoaZZ
         poG5UJ59DE1nD+5xtM21R5UhaPPUL8aBVZcJDCaHG5/corHAI69v9t1x0xrrx1y2lu5I
         S9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XFJ7oYIW3jEmGG55YwZA5z9/zQ04aeXZ67VeO8EpI8w=;
        b=fWRMpzyhj2h6soGzVM7zuAtoyfla+tiyqnpRXUh6y9GpxMbyb0bZ3Np61rzEKVKAk9
         LMQCTmUaVbOhVQt4n9Ee3pYBd639CXY6BR3AG/y2Jrq6Lq6/mfwdkA2QFG7eBvSp5bTq
         rUBZOE4gutN/3mkhCxabdNUh1Z7DuKUQyHQ4YdwiNZjkTMSbTjAAls9Og5dxaxigKRiZ
         rk4mzon5SMLmQ0ESoIgFDB5IDpUx0jT3AST4pZojxCWzRbOP3Yj539FTQ3AXetpAU37m
         6Uvo9VZSEdK4MfWfeHlcQeFb+Do4X82YiguQszdVgevibTDuBgm6su/KNpb/v0JLhciW
         t7rQ==
X-Gm-Message-State: APjAAAVyG232J4SF76RPiJSxsbPFdQWp2gzx/OHcvfgO4ncNtI3IldvJ
        En8k+d9fULTjSvsmKIMxssU/x8hi
X-Google-Smtp-Source: APXvYqyCxdcwrlN4UXeK85NTIEzPJo5bSckrGLt5q0PN1wBFRpCML5icLRH52n6iI+hpVNQtsPYrig==
X-Received: by 2002:a63:d703:: with SMTP id d3mr13823655pgg.102.1573243695874;
        Fri, 08 Nov 2019 12:08:15 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 193sm8843048pfv.18.2019.11.08.12.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:15 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:12 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/10] learn the "summary" pretty format
Message-ID: <cover.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572897736.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On this mailing list (and many others) the standard way to reference
other commits with the "summary" format, e.g. "f86a374 ("pack-bitmap.c:
fix a memleak", 2015-03-30)". Since it's so commonly used, let's
standardise it as a pretty format.

Changes since v1:

* Replace more references to "sha1" with "hash"

* Clean up 8/10 by losing the allocation and making the subject less
  misleading

* Add tests in 7/10 to ensure 8/10 does not change any behaviour

Denton Liu (10):
  SubmittingPatches: use generic terms for hash
  pretty-formats.txt: use generic terms for hash
  revision: make get_revision_mark() return const pointer
  revision: change abbrev_commit_given to abbrev_commit_explicit
  pretty.c: inline initalize format_context
  pretty.c: extract functionality to repo_format_commit_generic()
  t4205: cover `git log --reflog -z` blindspot
  reflog-walk.c: move where the newline is added
  pretty: implement 'summary' format
  SubmittingPatches: use `--pretty=summary`

 Documentation/SubmittingPatches    |  8 ++-
 Documentation/pretty-formats.txt   | 25 ++++++---
 Documentation/pretty-options.txt   |  2 +-
 Documentation/rev-list-options.txt |  2 +-
 builtin/log.c                      | 30 ++++++++--
 log-tree.c                         | 15 +++--
 pretty.c                           | 74 ++++++++++++++++++++----
 pretty.h                           |  1 +
 reflog-walk.c                      |  8 ++-
 revision.c                         |  7 ++-
 revision.h                         |  6 +-
 t/t4205-log-pretty-formats.sh      | 90 ++++++++++++++++++++++++++++++
 12 files changed, 227 insertions(+), 41 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  b34e9aea56 SubmittingPatches: use generic terms for hash
 1:  dc88d700b8 =  2:  922cc6d849 pretty-formats.txt: use generic terms for hash
 2:  9d30c287fa =  3:  b31cffd5ef revision: make get_revision_mark() return const pointer
 3:  9ea8d676f7 =  4:  b970e52b57 revision: change abbrev_commit_given to abbrev_commit_explicit
 4:  21809581df =  5:  a2e90c78e6 pretty.c: inline initalize format_context
 5:  7f3a3b5828 =  6:  fd2bbcd169 pretty.c: extract functionality to repo_format_commit_generic()
 -:  ---------- >  7:  b5950823ce t4205: cover `git log --reflog -z` blindspot
 6:  004164c781 !  8:  05dc446d41 reflog-walk.c: don't print last newline with oneline
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    reflog-walk.c: don't print last newline with oneline
    +    reflog-walk.c: move where the newline is added
     
         In a future commit, we want to possibly be able to continue the reflog message on
         the same line without breaking the line. As a result, when
    @@ Commit message
     
         Add these missing newlines back in show_log().
     
    +    While we're at it, cuddle the else with the closing brace of the if to
    +    more closely match the existing style.
    +
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
      ## log-tree.c ##
    @@ reflog-walk.c: void show_reflog_message(struct reflog_walk_info *reflog_info, in
      		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
      		if (oneline) {
     -			printf("%s: %s", selector.buf, info->message);
    -+			struct strbuf message = STRBUF_INIT;
    -+			strbuf_addstr(&message, info->message);
    -+			strbuf_trim_trailing_newline(&message);
    -+			printf("%s: %s", selector.buf, message.buf);
    -+			strbuf_release(&message);
    - 		}
    - 		else {
    +-		}
    +-		else {
    ++			int len = strlen(info->message);
    ++			if (len > 0)
    ++				len--; /* strip away trailing newline */
    ++			printf("%s: %.*s", selector.buf, len, info->message);
    ++		} else {
      			printf("Reflog: %s (%s)\nReflog message: %s",
    + 			       selector.buf, info->email, info->message);
    + 		}
 7:  1e280b968c !  9:  e74eab6d21 pretty: implement 'summary' format
    @@ Commit message
         Documentation/SubmittingPatches as
     
                 If you want to reference a previous commit in the history of a stable
    -            branch, use the format "abbreviated sha1 (subject, date)",
    +            branch, use the format "abbreviated hash (subject, date)",
                 with the subject enclosed in a pair of double-quotes, like this:
     
                 ....
    @@ Documentation/pretty-formats.txt: This is designed to be as compact as possible.
     +	  <abbrev hash> ("<title line>", <short author date>)
     ++
     +This format is useful for referring to other commits when writing a new
    -+commit message. Although by default, '<abbrev sha1>' is used, this can
    ++commit message. Although by default, '<abbrev hash>' is used, this can
     +be overridden with '--no-abbrev'. In addition, '<short author date>' can
     +be overridden by with '--date='.
     +
    @@ pretty.h: enum cmit_fmt {
      	CMIT_FMT_USERFORMAT,
     
      ## t/t4205-log-pretty-formats.sh ##
    +@@ t/t4205-log-pretty-formats.sh: do
    + 	'
    + done
    + 
    +-test_expect_success 'NUL termination with --reflog --pretty=oneline' '
    +-	>expect &&
    +-	revs="$(git rev-list --reflog)" &&
    +-	for r in $revs
    +-	do
    +-		# trim trailing newline
    +-		output="$(git show -s --pretty=oneline "$r")" || return 1
    +-		printf "%s" "$output" >>expect
    +-		emit_nul >>expect
    +-	done &&
    +-	git log -z --pretty=oneline --reflog >actual &&
    +-	# no trailing NUL
    +-	test_cmp expect actual
    +-'
    ++for p in oneline summary
    ++do
    ++	test_expect_success "NUL termination with --reflog --pretty=$p" '
    ++		>expect &&
    ++		revs="$(git rev-list --reflog)" &&
    ++		for r in $revs
    ++		do
    ++			# trim trailing newline
    ++			output="$(git show -s --pretty='$p' "$r")" || return 1
    ++			printf "%s" "$output" >>expect
    ++			emit_nul >>expect
    ++		done &&
    ++		git log -z --pretty='$p' --reflog >actual &&
    ++		# no trailing NUL
    ++		test_cmp expect actual
    ++	'
    ++done
    + 
    + test_expect_success 'setup more commits' '
    + 	test_commit "message one" one one message-one &&
     @@ t/t4205-log-pretty-formats.sh: test_expect_success '%S in git log --format works with other placeholders (part
      	test_cmp expect actual
      '
 8:  80e7c4fc66 = 10:  3aaa7a318b SubmittingPatches: use `--pretty=summary`
-- 
2.24.0.298.g3e88fbd976

