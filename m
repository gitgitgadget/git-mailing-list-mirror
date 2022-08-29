Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E9ECAAD5
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 15:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiH2PMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiH2PMD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 11:12:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909582F9B
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bu22so10252809wrb.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=E3weF9LxtndMAqlCnJ8JVZDT4r5Nt4ammySbezW0fMg=;
        b=hGtMbazWJ1G94SOazspq3/ON5U8R7+W8xja2SSTCt1BDrf8zTj1pS90gbqINoWy5AM
         BLXncRLIUSqORw/9AsNMdf9E/FkaataT0E+G6z8RiyIByDVG0PkdcUauygqmdQrIkmmW
         XuaG2e2TuGGjaQs9p5cOF5TB8D2HGugYwB3WGG26zBNzJ6NxkQ37XOmsfU4d3fTNtsnf
         sLuEvODs0Zc8n6XOukXK9agI7Hp2+iYGqUSCJehwPb1aEpfkhlbcmmvWa5k5tTNMNxgX
         WnYXUhiY0QCKfEr7Us7ub+KmVcjIiK01IZPeWjgjRI8TdPQoolh7BSoOgx49EKX7Ptgj
         O+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=E3weF9LxtndMAqlCnJ8JVZDT4r5Nt4ammySbezW0fMg=;
        b=7IKjkZoAxskLs0GWsNn+6F9nD/hoW+Z5Ve7cILYmp0SlO+pztC5mIvp6kn7/MbafCl
         5YfTSuBsz4QH8I18kfnCnP34Dq1QLOEE3JZ+VeEuBib7oI5kgJKTCqNQH90WszdDPGr3
         rVyXpi/SZIHAPGptAYDaqIKmfQaSoQFrzntMqKe/91P6/MuSjIJXZmQU3y04pcWMy+H8
         t6BNKOWz8S5mfeH3pXJL/f81a0IapTMKDya2RdttnO5DPzE2JTvhq9Z3LXaQ31Nc5Bly
         3UlfqR/wbATukwkopfvWo42NsLe12KPcOyUsEOQO9DYbHZUq3X+YPTDl3g/nnxv+cQt7
         0Hjw==
X-Gm-Message-State: ACgBeo1gzWAvflTp7XlWNfVf70LfCz2JgOXeZphe0vgoK++Xdyf5Xw35
        ntgpRPGGn0Hj1paYMGoTXGGBRYP84kk=
X-Google-Smtp-Source: AA6agR4iCU7FKCvViMIW1MdANZ1qyCVVw8lZm90O3CeKr4VrpTBk0qb8as+bSzaVUl6FpKf0KKRPjA==
X-Received: by 2002:a5d:6f0d:0:b0:226:d1c8:a1 with SMTP id ay13-20020a5d6f0d000000b00226d1c800a1mr5956234wrb.476.1661785919084;
        Mon, 29 Aug 2022 08:11:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6091000000b002237fd66585sm7254238wrt.92.2022.08.29.08.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:11:58 -0700 (PDT)
Message-Id: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 15:11:51 +0000
Subject: [PATCH v3 0/5] built-in add -p: support diff-so-fancy better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain reported in
https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
that there is a problem when running the built-in version of git add -p with
diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
The symptom is this:

    error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'


This patch series addresses that and should fix
https://github.com/so-fancy/diff-so-fancy/issues/437

Changes since v2:

 * Added the appropriate "Reported-by" trailer to the commit message.
 * Split out the logic to insert a space between the colored line range and
   the extra information, if needed.
 * That logic was now corrected to see whether that space is really needed.
 * To verify that the logic does what we need it to do, the added regression
   test now specifically tests for that (single) extra space that we want to
   be inserted.
 * Reworded a stale comment that claimed that we might suppress the entire
   colored hunk header (which we no longer do).
 * Rebased to the current tip of the main branch to avoid a merge conflict
   with 716c1f649e3 (pipe_command(): mark stdin descriptor as non-blocking,
   2022-08-17).

Changes since v1:

 * Added a commit to ignore dirty submodules just like the Perl version
   does.

Johannes Schindelin (5):
  t3701: redefine what is "bogus" output of a diff filter
  add -p: gracefully ignore unparseable hunk headers in colored diffs
  add -p: insert space in colored hunk header as needed
  add -p: handle `diff-so-fancy`'s hunk headers better
  add -p: ignore dirty submodules

 add-patch.c                | 49 ++++++++++++++++++++++++++++++--------
 t/t3701-add-interactive.sh | 35 ++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 11 deletions(-)


base-commit: 07ee72db0e97b5c233f8ada0abb412248c2f1c6f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1336

Range-diff vs v2:

 1:  74ab50eeb1c = 1:  a01fa5d25e4 t3701: redefine what is "bogus" output of a diff filter
 2:  b07f85a0359 ! 2:  cbe833bd141 add -p: gracefully ignore unparseable hunk headers in colored diffs
     @@ Commit message
      
          [diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy
      
     +    Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## add-patch.c ##
     @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output'
       	force_color test_must_fail git add -p <y
       '
       
     -+test_expect_success 'gracefully fail to parse colored hunk header' '
     ++test_expect_success 'handle iffy colored hunk headers' '
      +	git reset --hard &&
      +
      +	echo content >test &&
     -+	test_config interactive.diffFilter "sed s/@@/XX/g" &&
     -+	printf y >y &&
     -+	force_color git add -p <y
     ++	printf n >n &&
     ++	force_color git -c interactive.diffFilter="sed s/@@/XX/g" \
     ++		add -p <n
      +'
      +
     - test_expect_success 'diff.algorithm is passed to `git diff-files`' '
     + test_expect_success 'handle very large filtered diff' '
       	git reset --hard &&
     - 
     + 	# The specific number here is not important, but it must
 3:  9dac9f74d2e ! 3:  7a9f0b107e6 add -p: handle `diff-so-fancy`'s hunk headers better
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    add -p: handle `diff-so-fancy`'s hunk headers better
     +    add -p: insert space in colored hunk header as needed
      
     -    The `diff-so-fancy` diff colorizer produces hunk headers that look
     -    nothing like the built-in `add -p` expects: there is no `@@ ... @@` line
     -    range, and therefore the parser cannot determine where any extra
     -    information starts, such as the function name that is often added to
     -    those hunk header lines.
     +    We are about to teach `git add -p` to show the entire hunk header if the
     +    `@@ ... @@` line range cannot be parsed. Previously, we showed only the
     +    remainder of that hunk header as an "colored_extra" part.
      
     -    However, we can do better than simply swallowing the unparseable hunk
     -    header. In the `diff-so-fancy` case, it shows something like `@ file:1
     -    @`. Let's just show the complete hunk header because it probably offers
     -    useful information.
     +    To prepare for that, detect if that "colored_extra" part starts with any
     +    non-whitespace character (ignoring ANSI escape sequences) and insert a
     +    space, to make the output much more pleasant.
     +
     +    Note that this has an effect already before we make `git add -p` more
     +    lenient when parsing the hunk headers: diff filters could already remove
     +    the space after the line range, which is precisely what we do in the
     +    regression test introduced by this commit.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ add-patch.c
       
       enum prompt_mode_type {
       	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HUNK,
     -@@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
     - 		header->colored_extra_start = p + 3 - s->colored.buf;
     - 	else
     - 		/* could not parse colored hunk header, showing nothing */
     --		header->colored_extra_start = hunk->colored_start;
     -+		header->colored_extra_start = line - s->colored.buf;
     - 	header->colored_extra_end = hunk->colored_start;
     +@@ add-patch.c: static size_t find_next_line(struct strbuf *sb, size_t offset)
     + 	return eol - sb->buf + 1;
     + }
       
     - 	return 0;
     ++static int starts_with_non_ws(const char *p, size_t len)
     ++{
     ++	for (;;) {
     ++		size_t skip;
     ++
     ++		if (!len || isspace(*p))
     ++			return 0;
     ++		skip = display_mode_esc_sequence_len(p);
     ++		if (!skip)
     ++			return 1;
     ++		if (skip > len)
     ++			return 0;
     ++		p += skip;
     ++		len -= skip;
     ++	}
     ++}
     ++
     + static void render_hunk(struct add_p_state *s, struct hunk *hunk,
     + 			ssize_t delta, int colored, struct strbuf *out)
     + {
      @@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
       		size_t len;
       		unsigned long old_offset = header->old_offset;
     @@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
       			p = s->colored.buf + header->colored_extra_start;
       			len = header->colored_extra_end
       				- header->colored_extra_start;
     -+			if (utf8_strnwidth(p, len, 1 /* skip ANSI */) > 0)
     -+				needs_extra_space = 1;
     ++			needs_extra_space = starts_with_non_ws(p, len);
       		}
       
       		if (s->mode->is_reverse)
     @@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
       		else if (colored)
      
       ## t/t3701-add-interactive.sh ##
     -@@ t/t3701-add-interactive.sh: test_expect_success 'gracefully fail to parse colored hunk header' '
     +@@ t/t3701-add-interactive.sh: test_expect_success 'handle iffy colored hunk headers' '
       	echo content >test &&
     - 	test_config interactive.diffFilter "sed s/@@/XX/g" &&
     - 	printf y >y &&
     --	force_color git add -p <y
     -+	force_color git add -p >output 2>&1 <y &&
     -+	grep XX output
     + 	printf n >n &&
     + 	force_color git -c interactive.diffFilter="sed s/@@/XX/g" \
     +-		add -p <n
     ++		add -p <n &&
     ++	force_color git -c interactive.diffFilter="sed \"s/\(.*@@\).*/\1FN/\"" \
     ++		add -p >output 2>&1 <n &&
     ++	if test_have_prereq ADD_I_USE_BUILTIN
     ++	then
     ++		grep "@ FN\$" output
     ++	else
     ++		grep "@FN\$" output
     ++	fi
       '
       
     - test_expect_success 'diff.algorithm is passed to `git diff-files`' '
     + test_expect_success 'handle very large filtered diff' '
 -:  ----------- > 4:  e3e3a178f98 add -p: handle `diff-so-fancy`'s hunk headers better
 4:  540ce27c38a = 5:  cfa6914aee0 add -p: ignore dirty submodules

-- 
gitgitgadget
