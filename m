Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71DC20C13
	for <e@80x24.org>; Tue,  5 Dec 2017 23:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdLEXZO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 18:25:14 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41287 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbdLEXZN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 18:25:13 -0500
Received: by mail-qt0-f193.google.com with SMTP id i40so4902365qti.8
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+MVxr+g0MTDdcLjm+BnLsfMqjRYmdfm4s9fei2bf81M=;
        b=G1s89jA3heoeJlAtMuY3tZUIkORxmuToeT1Fz6xCO6dgMZAPl0V9Lv0ECvlQDJtHah
         m3GMvRdRJXhsJUgWDu3/ERNYsYPvEPMIUXSh3xSuHX0s5/Q13rpoUL450lVsYg4atQQX
         SDUCcr0h0sZE1UyfihDm5xCPNs84e26ho+EolQPEfVXYisPeLNTRuzYgzgaRCvRcCuzs
         zu9TtNEKKx2Wd0ua05JX4iW/5z7CEHNz/EGQDigKzKFXwM2ni6CkvMtQ1K1D/tqQw2C3
         h6P7hhZdfUAv6h05dWIDIXfPGLpFOoeUj9pK34VibAKQVwy7o0uWr3pHgwhKizjYLhd5
         oq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+MVxr+g0MTDdcLjm+BnLsfMqjRYmdfm4s9fei2bf81M=;
        b=HWJDPEVnwzgbTXyj/2iTXg62mwSVjqydQMkzq8BwCD1r2pu4pIwPcTrqyEy/Yf1QX6
         pixdh0oJ7M/Enq9UujXa8pqbIKfk88Z6Ahvo0/zjF1YLbFEAqRF9EdXVn02jkiaKbk3D
         H/gnCZbG6hR5GvOrKV/b+0d0bwskTKGuWUrmuBR9xyUF5oBsO3IMD628EpCGJWTubA79
         eWfGXCVgGNydnZ3us3q7YRVGEmhJHHxMz093YDDGvgzpzpG2RfNLW7e2jvo0RIFvVsJ/
         M3Cv9gXgxI3cmitwJg00SUkFWkCEOnbSOg8740f55Yu4iCXB9rl2tQ/6uMWsmROgKPOJ
         cdoA==
X-Gm-Message-State: AKGB3mLUCH1P+US1c+fLzju6ZUycc7LMUxZi9z//O9vV7g46IV1LSN0V
        5AzSrUroSx98XuwCmvCk8v64KeUFju05+pNyokc=
X-Google-Smtp-Source: AGs4zMaLpyI2l7Si3VZeL1V1qia/Cg82e7QD13JfQwIot1rEEBl0J6oSfNVqtuznbTMSapThYMCKuHRHFWtHZZH+8J0=
X-Received: by 10.55.126.7 with SMTP id z7mr22653697qkc.306.1512516312651;
 Tue, 05 Dec 2017 15:25:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Tue, 5 Dec 2017 15:25:12 -0800 (PST)
In-Reply-To: <20171205221337.140548-1-bmwill@google.com>
References: <20171205194801.GA31721@megas.kitware.com> <20171205221337.140548-1-bmwill@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Dec 2017 18:25:12 -0500
X-Google-Sender-Auth: LKrHDjOFB_QNtdsupm2rK_-WUA0
Message-ID: <CAPig+cS6zf3AvQVi7PZf=ignL-7JZKzYUyN9RoJSPZzL=Dj7FA@mail.gmail.com>
Subject: Re: [PATCH] diff-tree: read the index so attribute checks work in
 bare repositories
To:     Brandon Williams <bmwill@google.com>
Cc:     Git List <git@vger.kernel.org>, ben.boeckel@kitware.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 5, 2017 at 5:13 PM, Brandon Williams <bmwill@google.com> wrote:
> A regression was introduced in 557a5998d (submodule: remove
> gitmodules_config, 2017-08-03) to how attribute processing was handled
> in bare repositories when running the diff-tree command.
>
> By default the attribute system will first try to read ".gitattribute"
> files from the working tree and then falls back to reading them from the
> index if there isn't a copy checked out in the worktree.  Prior to
> 557a5998d the index was read as a side effect of the call to
> 'gitmodules_config()' which ensured that the index was already populated
> before entering the attribute subsystem.
>
> Since the call to 'gitmodules_config()' was removed the index is no
> longer being read so when the attribute system tries to read from the
> in-memory index it doesn't find any ".gitattribute" entries effectively
> ignoring any configured attributes.
>
> Fix this by explicitly reading the index during the setup of diff-tree.

This commit message does a good job of explaining the issue, so
someone who hasn't followed the thread (or has not followed it
closely, like me) can understand the problem and solution. Thanks.

A few comments below...

> Reported-by: Ben Boeckel <ben.boeckel@kitware.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> @@ -110,6 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>
>         git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>         init_revisions(opt, prefix);
> +       read_cache();

557a5998d (submodule: remove gitmodules_config, 2017-08-03) touched a
fair number of built-in commands. It's not clear from the current
patch's commit message if diff-tree is the only command which
regressed. Is it? Or are other commands also likely to have regressed?
Perhaps the commit message could say something about this. For
instance: "All other commands touched by 557a5998d have been audited
and were found to be regression-free" or "Other commands may regress
in the same way, but we will take a wait-and-see attitude and fix them
as needed because <fill-in-reason>".

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> @@ -636,6 +636,23 @@ test_expect_success 'check with space before tab in indent (diff-tree)' '
> +test_expect_success 'check with ignored trailing whitespace attr (diff-tree)' '
> +       test_when_finished "git reset --hard HEAD^" &&

A few style nits...

> +       # Create a whitespace error that should be ignored.

Comments in nearby tests are not capitalized and do not end with period.

> +       echo "* -whitespace" > ".gitattributes" &&

Please drop unnecessary quotes around the filename, as the extra noise
makes it a bit harder to read. Also, lose space after redirection
operator:

    echo "* -whitespace" >.gitattributes &&

> +       git add ".gitattributes" &&
> +       echo "trailing space -> " > "trailing-space" &&

All the nearby tests use some variation of:

    echo "foo ();  " >x &&

which differs from the "trailing space ->" and filename
'trailing-space' used in this test. Lack of consistency makes this new
test stick out like a sore thumb.

> +       git add "trailing-space" &&
> +       git commit -m "trailing space" &&
> +
> +       # With a worktree diff-tree ignores the whitespace error
> +       git diff-tree --root --check HEAD &&
> +
> +       # Without a worktree diff-tree still ignores the whitespace error
> +       git -C .git diff-tree --root --check HEAD
> +'
