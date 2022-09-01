Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CD3ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 13:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiIANzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiIANzf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 09:55:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC22A1AD
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 06:55:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b16so14854088wru.7
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=h4IgwZB9Xswft18Jm1wVObKUK09rDQVw1EJ5T9piYn4=;
        b=C9t1wJ6nvs5CS63/We4fhQtjvcSjHgcAOcFh53WsvTAGuScPio2ZWYUr1PEdoVzFjD
         qZDz/k0N+jwVvAjGLCD5E/AX3GIFvezJONN+ciZaSq/CbdDcSsLGX4zBJTXfL2MQtZLV
         gcuCznNWYTNvjulyvHC0EyKp62jJU8RZBnKaTItKz4ieeGlIv+a0fqWgnWaWJBDqR65t
         lGFq+Ovu0f3MvMv3E+wQCUqbcpuQgHMusL/FH87Bec/7aRddeUA2VwG3iMLiRCwBrf+/
         T3qe9Asasty0Ieq3Lts7sjkHo2XsOcbYHvCh0LCoa9hRt5HoNmZOwQgCAMkxSBDViiDe
         62NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=h4IgwZB9Xswft18Jm1wVObKUK09rDQVw1EJ5T9piYn4=;
        b=t56SkBvLGvGl6ZCvY5R+VFFxQBxF4NP8QJ2492KEXrq3WUshFbG4VvLeTfbXQcG3xS
         WGpSNTaNqvnCrT/RCtls7MbVHFUl0/Xst9rIxcpaxwuj/YbExtlXmvngV7Vp3lSF3Dmg
         vJBzlPPACvPUnCWwppm7CgS+ogMC0wNv8+glkkT+6uWJ7sgha/s/PNWvLsHODZAOHVhB
         msDLndjNjUbfaFZkXkGro541/bwfO1DbPLdzWZmHWnv3Ahj0Rhh38c1OwsPehCa4BMVc
         b/MaEDtqJKUHmEaSS6on1qniRDAwIGS0Qmrh1QjaEegnv9JzJp8x1oY9ncH5KRlNB8qo
         Chcg==
X-Gm-Message-State: ACgBeo2Wfceh7EChKMInCRBfsRIzqIUbpTUfxLgh+nyqc4cPg4cBdAss
        I1A8zf8FtI3JkqvlenpN94U=
X-Google-Smtp-Source: AA6agR5p6R0niFAm0E9Prlo09LRJ2ugnryhX33uCoo+4tdaspiXLRXbxByGVHM0mt46vrrVB/23wsQ==
X-Received: by 2002:a05:6000:2a3:b0:226:dff3:b031 with SMTP id l3-20020a05600002a300b00226dff3b031mr8924990wry.495.1662040531977;
        Thu, 01 Sep 2022 06:55:31 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b002254880c049sm14543435wrq.31.2022.09.01.06.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:55:31 -0700 (PDT)
Message-ID: <77046611-03ae-3b0f-736a-c377a63274c2@gmail.com>
Date:   Thu, 1 Sep 2022 14:55:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/3] built-in add -p: support diff-so-fancy better
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 31/08/2022 21:31, Johannes Schindelin via GitGitGadget wrote:
> Philippe Blain reported in
> https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
> that there is a problem when running the built-in version of git add -p with
> diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
> The symptom is this:
> 
>      error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'
> 
> 
> This patch series addresses that and should fix
> https://github.com/so-fancy/diff-so-fancy/issues/437
> 
> Changes since v3:
> 
>   * Instead of deviating from how the Perl version of git add -p did things,
>     we now teach the built-in version to display hunk headers verbatim when
>     no line range could be parsed out (instead of showing the line range
>     anyways). This was a very good idea of Phillip's, dramatically
>     simplifying the patch series.
>   * Also, this iteration drops the first patch that claims to redefine what
>     we consider bogus, but only hides an off-by-one. In its stead, there is
>     now a patch that fixes said off-by-one.

This version is looking much simpler and nicer, I've left a couple of 
comments on the second patch as we're still not quite printing the 
output of the diff filter verbatim.

Thanks

Phillip

> Changes since v2:
> 
>   * Added the appropriate "Reported-by" trailer to the commit message.
>   * Split out the logic to insert a space between the colored line range and
>     the extra information, if needed.
>   * That logic was now corrected to see whether that space is really needed.
>   * To verify that the logic does what we need it to do, the added regression
>     test now specifically tests for that (single) extra space that we want to
>     be inserted.
>   * Reworded a stale comment that claimed that we might suppress the entire
>     colored hunk header (which we no longer do).
>   * Rebased to the current tip of the main branch to avoid a merge conflict
>     with 716c1f649e3 (pipe_command(): mark stdin descriptor as non-blocking,
>     2022-08-17).
> 
> Changes since v1:
> 
>   * Added a commit to ignore dirty submodules just like the Perl version
>     does.
> 
> Johannes Schindelin (3):
>    add -p: detect more mismatches between plain vs colored diffs
>    add -p: gracefully handle unparseable hunk headers in colored diffs
>    add -p: ignore dirty submodules
> 
>   add-patch.c                | 50 +++++++++++++++++++++-----------------
>   t/t3701-add-interactive.sh | 27 ++++++++++++++++++--
>   2 files changed, 53 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 07ee72db0e97b5c233f8ada0abb412248c2f1c6f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1336
> 
> Range-diff vs v3:
> 
>   1:  a01fa5d25e4 ! 1:  25187c3a3c2 t3701: redefine what is "bogus" output of a diff filter
>       @@ Metadata
>        Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>        
>         ## Commit message ##
>       -    t3701: redefine what is "bogus" output of a diff filter
>       +    add -p: detect more mismatches between plain vs colored diffs
>        
>            When parsing the colored version of a diff, the interactive `add`
>            command really relies on the colored version having the same number of
>       -    lines as the non-colored version. That is an invariant.
>       -
>       -    However, in the 'detect bogus diffFilter output' test case in t3701, we
>       -    essentially required a hunk header that contains parseable `@@ ... @@`
>       -    hunk headers, and called all colored diffs without such hunks bogus.
>       -
>       -    The reason for this is that we would like to show the users the adjusted
>       -    hunk headers _including_ the extra part after the `@@ ... @@`
>       -    information, which usually contains things like the function name or
>       -    soms such.
>       -
>       -    Now, there is a _very_ popular diff colorizer called `diff-so-fancy`
>       -    that does not produce such colored diffs as the built-in `add` command
>       -    expects. Nevertheless, the Perl variant of the `add` command handles
>       -    those nicely, essentially by ignoring the hunk header and saying "there
>       -    is nothing else we can show except the original hunk header, even if we
>       -    had to adjust the line range and the original hunk header might get that
>       -    wrong".
>       -
>       -    In preparation for teaching the built-in interactive `add` to be a bit
>       -    more lenient, let's change the 'detect bogus diffFilter output' test
>       -    case so that it verifies that a mismatched number of lines causes the
>       -    command to error out, but not an unparseable hunk header.
>       +    lines as the plain (uncolored) version. That is an invariant.
>       +
>       +    We already have code to verify correctly when the colored diff has less
>       +    lines than the plain diff. Modulo an off-by-one bug: If the last diff
>       +    line has no matching colored one, the code pretends to succeed, still.
>       +
>       +    To make matters worse, when we adjusted the test in 1e4ffc765db (t3701:
>       +    adjust difffilter test, 2020-01-14), we did not catch this because `add
>       +    -p` fails for a _different_ reason: it does not find any colored hunk
>       +    header that contains a parseable line range.
>       +
>       +    If we change the test case so that the line range _can_ be parsed, the
>       +    bug is exposed.
>       +
>       +    Let's address all of the above by
>       +
>       +    - fixing the off-by-one,
>       +
>       +    - adjusting the test case to allow `add -p` to parse the line range
>       +
>       +    - making the test case more stringent by verifying that the expected
>       +      error message is shown
>       +
>       +    Also adjust a misleading code comment about the now-fixed code.
>        
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>       + ## add-patch.c ##
>       +@@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>       + 			if (colored_eol)
>       + 				colored_p = colored_eol + 1;
>       + 			else if (p != pend)
>       +-				/* colored shorter than non-colored? */
>       ++				/* non-colored has more lines? */
>       ++				goto mismatched_output;
>       ++			else if (colored_p == colored_pend)
>       ++				/* last line has no matching colored one? */
>       + 				goto mismatched_output;
>       + 			else
>       + 				colored_p = colored_pend;
>       +
>         ## t/t3701-add-interactive.sh ##
>        @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output' '
>         	git reset --hard &&
>         
>         	echo content >test &&
>        -	test_config interactive.diffFilter "sed 1d" &&
>       -+	test_config interactive.diffFilter "sed q" &&
>       ++	test_config interactive.diffFilter "sed 6d" &&
>         	printf y >y &&
>       - 	force_color test_must_fail git add -p <y
>       +-	force_color test_must_fail git add -p <y
>       ++	force_color test_must_fail git add -p <y >output 2>&1 &&
>       ++	grep "mismatched output" output
>         '
>       +
>       + test_expect_success 'handle very large filtered diff' '
>   2:  cbe833bd141 ! 2:  cd1c5100506 add -p: gracefully ignore unparseable hunk headers in colored diffs
>       @@ Metadata
>        Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>        
>         ## Commit message ##
>       -    add -p: gracefully ignore unparseable hunk headers in colored diffs
>       +    add -p: gracefully handle unparseable hunk headers in colored diffs
>        
>            In
>            https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com,
>       @@ Commit message
>            and therefore we cannot detect any part in that header that comes after
>            the line range.
>        
>       -    Let's punt for now and simply show nothing apart from the line range in
>       -    that case.
>       +    As proposed by Phillip Wood, let's take that for a clear indicator that
>       +    we should show the hunk headers verbatim. This is what the Perl version
>       +    of the interactive `add` command did, too.
>       +
>       +    This commit is best viewed with `--color-moved --ignore-space-change`.
>        
>            [diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy
>        
>            Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
>       +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>         ## add-patch.c ##
>       +@@ add-patch.c: struct hunk_header {
>       + 	 * include the newline.
>       + 	 */
>       + 	size_t extra_start, extra_end, colored_extra_start, colored_extra_end;
>       ++	unsigned suppress_colored_line_range:1;
>       + };
>       +
>       + struct hunk {
>        @@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
>       - 	eol = memchr(line, '\n', s->colored.len - hunk->colored_start);
>         	if (!eol)
>         		eol = s->colored.buf + s->colored.len;
>       --	p = memmem(line, eol - line, "@@ -", 4);
>       + 	p = memmem(line, eol - line, "@@ -", 4);
>        -	if (!p)
>        -		return error(_("could not parse colored hunk header '%.*s'"),
>        -			     (int)(eol - line), line);
>       @@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hu
>        -	if (!p)
>        -		return error(_("could not parse colored hunk header '%.*s'"),
>        -			     (int)(eol - line), line);
>       - 	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
>       --	header->colored_extra_start = p + 3 - s->colored.buf;
>       -+	p = memmem(line, eol - line, "@@ -", 4);
>        +	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
>        +		header->colored_extra_start = p + 3 - s->colored.buf;
>       -+	else
>       -+		/* could not parse colored hunk header, showing nothing */
>       ++	else {
>       ++		/* could not parse colored hunk header, leave as-is */
>        +		header->colored_extra_start = hunk->colored_start;
>       ++		header->suppress_colored_line_range = 1;
>       ++	}
>       + 	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
>       +-	header->colored_extra_start = p + 3 - s->colored.buf;
>         	header->colored_extra_end = hunk->colored_start;
>         
>         	return 0;
>       +@@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>       + 				- header->colored_extra_start;
>       + 		}
>       +
>       +-		if (s->mode->is_reverse)
>       +-			old_offset -= delta;
>       +-		else
>       +-			new_offset += delta;
>       +-
>       +-		strbuf_addf(out, "@@ -%lu", old_offset);
>       +-		if (header->old_count != 1)
>       +-			strbuf_addf(out, ",%lu", header->old_count);
>       +-		strbuf_addf(out, " +%lu", new_offset);
>       +-		if (header->new_count != 1)
>       +-			strbuf_addf(out, ",%lu", header->new_count);
>       +-		strbuf_addstr(out, " @@");
>       ++		if (!colored || !header->suppress_colored_line_range) {
>       ++			if (s->mode->is_reverse)
>       ++				old_offset -= delta;
>       ++			else
>       ++				new_offset += delta;
>       ++
>       ++			strbuf_addf(out, "@@ -%lu", old_offset);
>       ++			if (header->old_count != 1)
>       ++				strbuf_addf(out, ",%lu", header->old_count);
>       ++			strbuf_addf(out, " +%lu", new_offset);
>       ++			if (header->new_count != 1)
>       ++				strbuf_addf(out, ",%lu", header->new_count);
>       ++			strbuf_addstr(out, " @@");
>       ++		}
>       +
>       + 		if (len)
>       + 			strbuf_add(out, p, len);
>        
>         ## t/t3701-add-interactive.sh ##
>        @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output' '
>       - 	force_color test_must_fail git add -p <y
>       + 	grep "mismatched output" output
>         '
>         
>        +test_expect_success 'handle iffy colored hunk headers' '
>       @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output'
>        +
>        +	echo content >test &&
>        +	printf n >n &&
>       -+	force_color git -c interactive.diffFilter="sed s/@@/XX/g" \
>       -+		add -p <n
>       ++	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
>       ++		add -p >output 2>&1 <n &&
>       ++	grep "^[^@]*XX[^@]*$" output
>        +'
>        +
>         test_expect_success 'handle very large filtered diff' '
>   3:  7a9f0b107e6 < -:  ----------- add -p: insert space in colored hunk header as needed
>   4:  e3e3a178f98 < -:  ----------- add -p: handle `diff-so-fancy`'s hunk headers better
>   5:  cfa6914aee0 = 3:  116f0cf5cab add -p: ignore dirty submodules
> 
