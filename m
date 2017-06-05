Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89D21F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdFESXQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:23:16 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35543 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdFESXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:23:14 -0400
Received: by mail-pf0-f177.google.com with SMTP id l89so12355929pfi.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e3xGEgUdCeYgEQSRFt7mtYaUjdWozoYyPX16vwEQn64=;
        b=XvPcyay6mqgFl8fsEpyED5BN6p4M3aY0aL3wG4ytI5YAE4CUcRGMQUmBHnnayASRgw
         5TWMG4ow4kIeBX3VcLuOUnJxaMtsnw1fMLe2dOwH02u5YPLdew5Y+ARlo28qUkDiMYGd
         6DWYCeFzfc3VstQXfvGbEmX2zTK8uG5xZ7HIrKqDnrXBwyJ7Wue19QlbpkA9jmT5rxaL
         KdASHXsG7unefcF7P22BypFcVyTeUecz+hvt7WwtbYf0/6NYEtlpZbfINw55Pemunw1Q
         XSpZyBBy/YdH40e4cULA1JFlAp7iUUn2MJ7e73UBqJM6FoTEbu/w4ef9/+Fk3eifh3Gy
         KGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e3xGEgUdCeYgEQSRFt7mtYaUjdWozoYyPX16vwEQn64=;
        b=PToU+QI4OiFznZuakcTDNDTVURYFB5ps24jmHaCNLqBbbktkod1jCGyW6mZvnflXG8
         ICwdYZjJeUgfIu88L+/UT69EpvhMH+vQy6frbhZq7RpDMvSA0uEmqbL9Kpq9OAOlb7km
         /vEcpl7zk4snEBnVITrP1a+Z/b3aU2+K0tNOnqKxksCksgo2I17gBmgFft9cBJtTT4FC
         0nAX8qk0XoXRvYSKLlmqNLQP8WrZP1OJ8mum1cbQ1wsDBBFRYHAc2uErrOSrgIrjCRLf
         tD1Q2iA8bjs6wro1o1IQcWVg1yTSrA5HJuoyBci5DCYbRkoFUBXn3hKXTr3WXgbY8ZZ6
         L0Tg==
X-Gm-Message-State: AODbwcDA9l37ZYUL+kLdcqM9zZgOWbWV5y75z0kXHEOwbm60di6TCFbw
        glpPfYZuFty09V2/iP7dA+/k2RN69V3l
X-Received: by 10.101.76.201 with SMTP id n9mr22979421pgt.40.1496686993289;
 Mon, 05 Jun 2017 11:23:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 5 Jun 2017 11:23:12 -0700 (PDT)
In-Reply-To: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Jun 2017 11:23:12 -0700
Message-ID: <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/diff-color-move (2017-06-01) 17 commits
>  - diff.c: color moved lines differently
>  - diff: buffer all output if asked to
>  - diff.c: emit_line includes whitespace highlighting
>  - diff.c: convert diff_summary to use emit_line_*
>  - diff.c: convert diff_flush to use emit_line_*
>  - diff.c: convert word diffing to use emit_line_*
>  - diff.c: convert show_stats to use emit_line_*
>  - diff.c: convert emit_binary_diff_body to use emit_line_*
>  - submodule.c: convert show_submodule_summary to use emit_line_fmt
>  - diff.c: convert emit_rewrite_lines to use emit_line_*
>  - diff.c: convert emit_rewrite_diff to use emit_line_*
>  - diff.c: convert builtin_diff to use emit_line_*
>  - diff.c: convert fn_out_consume to use emit_line
>  - diff: introduce more flexible emit function
>  - diff.c: factor out diff_flush_patch_all_file_pairs
>  - diff: move line ending check into emit_hunk_header
>  - diff: readability fix
>
>  "git diff" has been taught to optionally paint new lines that are
>  the same as deleted lines elsewhere differently from genuinely new
>  lines.
>
>  Are we happy with these changes?

I advertised this series e.g. for reviewing Brandons
repo object refactoring series and used it myself to inspect
some patches there[1]. I am certainly happy (but biased) with
what we have available there.

Jacob intended to use this series
for review as well, but has given no opinion yet.

You seemed to have used it for js/blame-lib?

--
Those patches had a wide reviewer audience cc'd,
so I would think people are aware of this series.

--
Things to come, but not in this series as they are more advanced:

    Discuss if a block/line needs a minimum requirement.

When doing reviews with this series, a couple of lines such
as "\t\t}" were marked as a moved, which is not wrong as they
really occurred in the text with opposing sign.
But it was annoying as it drew my attention to just closing
braces, which IMO is not the point of code review.

To solve this issue I had the idea of a "minimum requirement", e.g.
* at least 3 consecutive lines or
* at least one line with at least 3 non-ws characters or
* compute the entropy of a given moved block and if it is too low, do
  not mark it up.

I am not sure if such a "minimum requirement" is the right approach
at all. The nature of this discussion comes close to the diff heuristics
at which Michael did present a wonderful solution, hence I had him cc'd
on the series as he may have some good insights on how to improve
the diffs. :)

--
In conclusion:

We are happy to move to next as it seems technically sound.

But we want more exposure on usage to point out UX bugs.
(e.g. is the default mode for just giving --color-moved good for the
majority of people/use cases? Are there subtle annoyances such
as the closing braces?)

So maybe merge to next with the strong option to evict it
when finding more fundamentally wrong things?

Thanks,
Stefan

[1]
https://public-inbox.org/git/CAGZ79kZJF9iDsVgyi-hSKb6N8w0uhVCU4W-r89F0eRJPXe_4Og@mail.gmail.com/
