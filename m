Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC131ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiIAQEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiIAQET (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:04:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B108002C
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:04:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c7so16320324wrp.11
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=0zu0RcKhd0E2/I612A/JsAkR03PbsKf3OL6OrXdZTr4=;
        b=Kn/MC2RJZtpWHfIN9rkoZPcG6ae9IBnoG5sRd0g7L+nYUt9iH1uR7hqatyd22rCZfz
         xWGArLEaZpYAMAwz6AzH+T2Fmd0tPTZHUhb2e8JtKpX1izLviXb9eq/Qf6EMGUPCOqso
         jDk3YpH5P3QMf9YwpC8bRPCi5DrhpsGllutUJ6W++BX5pBrjjlnOXVKBsKbJ00mEWQYw
         bBN+FHMAz33+BGntkIlsZyX3KJsxYXe5bo1eAnnqf38ggXUKhD36LOHz8rtamqIN4ojp
         QIube1Ppk9nDvYbeFHJsyGUJRPNido1jefOtTKS3yAgRsk4Gy9GNaqV9dSUbmbZeiFY0
         MbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=0zu0RcKhd0E2/I612A/JsAkR03PbsKf3OL6OrXdZTr4=;
        b=BEEsdOiE+P4lqhnB3VNtEGnhPSKxaKZZv2xGk7Fjbjnxhrzk4JIEEOAnMLUbWZGBKt
         O9SDuXZ6AiMJrz/7/p5hqFzCt6z0qq+pc9ho/h5izh4WFrOQYnLjFJ/Mjrsxq1DNAMcw
         KG6yz7yU0mlVj3kg0sYfRfUVCfqlgLXmJK/FZhQYwZ5/LpOIkN/zCYYdMAxknn/oD6o1
         Lid+eBbbCwhOE2/cbI2pv5AdXMwffU65sKckb3EoxoTc49UNhfBOmbhTmvsPvTauc295
         h3W5MBfkD/aLUTIUpW2TYQsBcm2wz4aQcLdxhx3fSHlUR1TvoWPfOBF57RkhCK3l37yD
         KNaQ==
X-Gm-Message-State: ACgBeo1aIpGnK+ZtThj1HvWi9L7v2MV7/sgmvhS75FIP2dT/joVc3ZKp
        ZeqIAlpnPBuslh63So9MdK4=
X-Google-Smtp-Source: AA6agR79KtA5RAXDdxqYiOrfdbdR+ilHDonJxS4vE/EUYURm5lOZGxpZOdv43XXumUTgZVRHFbdS2w==
X-Received: by 2002:a05:6000:81d:b0:226:dbad:1699 with SMTP id bt29-20020a056000081d00b00226dbad1699mr11662902wrb.212.1662048257059;
        Thu, 01 Sep 2022 09:04:17 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id t8-20020adfdc08000000b002258413c310sm15197194wri.88.2022.09.01.09.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:04:16 -0700 (PDT)
Message-ID: <ced55750-21bb-c264-ef2d-666aca77fa2b@gmail.com>
Date:   Thu, 1 Sep 2022 17:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] built-in add -p: support diff-so-fancy better
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
 <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 01/09/2022 16:42, Johannes Schindelin via GitGitGadget wrote:
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
> Changes since v4:
> 
>   * The second patch was further simplified, avoiding to print extra ANSI
>     sequences if the hunk header is shown verbatim.

That was a quick re-roll! I'm very happy with this version

Thanks

Phillip

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
> 
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
>   add-patch.c                | 33 +++++++++++++++++++++++----------
>   t/t3701-add-interactive.sh | 27 +++++++++++++++++++++++++--
>   2 files changed, 48 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 07ee72db0e97b5c233f8ada0abb412248c2f1c6f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1336
> 
> Range-diff vs v4:
> 
>   1:  25187c3a3c2 = 1:  25187c3a3c2 add -p: detect more mismatches between plain vs colored diffs
>   2:  cd1c5100506 ! 2:  93d0e3b4d2a add -p: gracefully handle unparseable hunk headers in colored diffs
>       @@ Commit message
>            we should show the hunk headers verbatim. This is what the Perl version
>            of the interactive `add` command did, too.
>        
>       -    This commit is best viewed with `--color-moved --ignore-space-change`.
>       -
>            [diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy
>        
>            Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
>       @@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hu
>        -	if (!p)
>        -		return error(_("could not parse colored hunk header '%.*s'"),
>        -			     (int)(eol - line), line);
>       -+	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
>       ++	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3))) {
>        +		header->colored_extra_start = p + 3 - s->colored.buf;
>       -+	else {
>       ++	} else {
>        +		/* could not parse colored hunk header, leave as-is */
>        +		header->colored_extra_start = hunk->colored_start;
>        +		header->suppress_colored_line_range = 1;
>       @@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hu
>         
>         	return 0;
>        @@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>       - 				- header->colored_extra_start;
>       - 		}
>       -
>       --		if (s->mode->is_reverse)
>       --			old_offset -= delta;
>       --		else
>       --			new_offset += delta;
>       --
>       --		strbuf_addf(out, "@@ -%lu", old_offset);
>       --		if (header->old_count != 1)
>       --			strbuf_addf(out, ",%lu", header->old_count);
>       --		strbuf_addf(out, " +%lu", new_offset);
>       --		if (header->new_count != 1)
>       --			strbuf_addf(out, ",%lu", header->new_count);
>       --		strbuf_addstr(out, " @@");
>       -+		if (!colored || !header->suppress_colored_line_range) {
>       -+			if (s->mode->is_reverse)
>       -+				old_offset -= delta;
>       -+			else
>       -+				new_offset += delta;
>       + 		if (!colored) {
>       + 			p = s->plain.buf + header->extra_start;
>       + 			len = header->extra_end - header->extra_start;
>       ++		} else if (header->suppress_colored_line_range) {
>       ++			strbuf_add(out,
>       ++				   s->colored.buf + header->colored_extra_start,
>       ++				   header->colored_extra_end -
>       ++				   header->colored_extra_start);
>        +
>       -+			strbuf_addf(out, "@@ -%lu", old_offset);
>       -+			if (header->old_count != 1)
>       -+				strbuf_addf(out, ",%lu", header->old_count);
>       -+			strbuf_addf(out, " +%lu", new_offset);
>       -+			if (header->new_count != 1)
>       -+				strbuf_addf(out, ",%lu", header->new_count);
>       -+			strbuf_addstr(out, " @@");
>       -+		}
>       -
>       - 		if (len)
>       - 			strbuf_add(out, p, len);
>       ++			strbuf_add(out, s->colored.buf + hunk->colored_start,
>       ++				   hunk->colored_end - hunk->colored_start);
>       ++			return;
>       + 		} else {
>       + 			strbuf_addstr(out, s->s.fraginfo_color);
>       + 			p = s->colored.buf + header->colored_extra_start;
>        
>         ## t/t3701-add-interactive.sh ##
>        @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output' '
>       @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output'
>        +	printf n >n &&
>        +	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
>        +		add -p >output 2>&1 <n &&
>       -+	grep "^[^@]*XX[^@]*$" output
>       ++	grep "^XX$" output
>        +'
>        +
>         test_expect_success 'handle very large filtered diff' '
>   3:  116f0cf5cab = 3:  47943b603b1 add -p: ignore dirty submodules
> 
