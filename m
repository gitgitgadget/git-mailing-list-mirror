Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D00E1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 18:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935936AbeFRSbG (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 14:31:06 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38645 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935726AbeFRSbF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 14:31:05 -0400
Received: by mail-yw0-f195.google.com with SMTP id w13-v6so5980862ywa.5
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyqGkKjslKpIITg0p2UQF44qfAAkIEJspKETXuHnGIA=;
        b=Unzoq4EZ2hc21DlEnjNAj7vZarkgq6TlPvxwyYd1YPuiRPU5u7dl4PDi+ONv/aYh42
         fqjO3wRqf8U6XwZTipqISVC3Bui4mky6fAz4DjqxfA6aFUY/5vnlHGxhOXTYpnEhFaDk
         Q9vN726kX56Ah9M5UVaRlqEcY75izGA8HjykO2WaW8f6st31krykOqQUzV1ml8VkrZ53
         Aeafe/7aSAr61G6cNmpm0X/mSXOGRwBDQbw6L1+iA5ED+pcyHm7dT7lqIhLTya6cZ4VW
         fXqibu65hebJjekvXfMnetvhKQ/m4N7CrOn69V05IoKWMgfx5K7Hs6MwlwWwwC3eh87G
         M4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyqGkKjslKpIITg0p2UQF44qfAAkIEJspKETXuHnGIA=;
        b=N3lZd/l/sCqYG+WNo0HlWKNw2aHgjAUBIgeBVjFdLH+HS+0kza8f42qEuf/heGE+Xo
         cM7DA7IaJ+26CJVSry72XHtUTLK/JXHZHdPYfz00CIK2Yn5QLrJWC7GSO3ugGJp/7DUk
         co56ese8H052pp0dhgSx5pMcyx3KUVclfHx6Ij6sKjy8Bja/FtsR8A77fz+XOmfIWruY
         o1pFJPKtiYiWGeXvkZaTeNt8bnkRyf9BrGD0lVEEq9kDrI5aKVEoRQlCTGEIqUY1B1nc
         cYsKJ3hLkk4B3GnSb7vtER+OfirXdosgObvvJMAG9LCB4xbadjeRdn8PifRalHmcE4Eu
         Zltw==
X-Gm-Message-State: APt69E2RRXObVtBM6sokGbOAlTd+IBhvrVTrEtZOIdfDPP+xSOha3vQY
        6V0b3aVkbaBqqi4In8AprEHxrRZWVjM770VC8Mc7A/IR
X-Google-Smtp-Source: ADUXVKLbPM63FaHA88nL5lrc60FglOKJGqENjRbB0stmCQinDJC5Ug1p54tCHsEP9X9fccoc20TB146dSHnVQGIw8As=
X-Received: by 2002:a81:4d43:: with SMTP id a64-v6mr6548541ywb.33.1529346663946;
 Mon, 18 Jun 2018 11:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528233146.git.jonathantanmy@google.com>
 <cover.1528234587.git.jonathantanmy@google.com> <2bc7df55a6451afbd35638b31a1551c648129b22.1528234587.git.jonathantanmy@google.com>
In-Reply-To: <2bc7df55a6451afbd35638b31a1551c648129b22.1528234587.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 11:30:53 -0700
Message-ID: <CAGZ79kbVsV390C0p3dAs3Ddp=K7mLnzfBhFC2jS4oon3Uy_nvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t5702: test fetch with multiple refspecs at a time
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 2:40 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Extend the protocol v2 tests to also test fetches with multiple refspecs
> specified. This also covers the previously uncovered cases of fetching
> with prefix matching and fetching by SHA-1.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  t/t5702-protocol-v2.sh | 47 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index a4fe6508b..261e82b0f 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -359,6 +359,53 @@ test_expect_success 'default refspec is used to filter ref when fetchcing' '
>         grep "ref-prefix refs/tags/" log
>  '
>
> +test_expect_success 'fetch supports various ways of have lines' '
> +       rm -rf server client trace &&

Can we move these deletions to test_when_finished of the previous(?) test
as well as have them here in a test_when_finished line?

> +       git init server &&
> +       test_commit -C server dwim &&
> +       TREE=$(git -C server rev-parse HEAD^{tree}) &&
> +       git -C server tag exact \
> +               $(git -C server commit-tree -m a "$TREE") &&
> +       git -C server tag dwim-unwanted \
> +               $(git -C server commit-tree -m b "$TREE") &&
> +       git -C server tag exact-unwanted \
> +               $(git -C server commit-tree -m c "$TREE") &&
> +       git -C server tag prefix1 \
> +               $(git -C server commit-tree -m d "$TREE") &&
> +       git -C server tag prefix2 \
> +               $(git -C server commit-tree -m e "$TREE") &&
> +       git -C server tag fetch-by-sha1 \
> +               $(git -C server commit-tree -m f "$TREE") &&
> +       git -C server tag completely-unrelated \
> +               $(git -C server commit-tree -m g "$TREE") &&

So you create different commits all with the same tree; no parents;
this seems to convey nicely that this is about testing tags.

> +       git init client &&
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
> +               fetch "file://$(pwd)/server" \
> +               dwim \
> +               refs/tags/exact \
> +               refs/tags/prefix*:refs/tags/prefix* \
> +               "$(git -C server rev-parse fetch-by-sha1)" &&
> +
> +       # Ensure that the appropriate prefixes are sent (using a sample)
> +       grep "fetch> ref-prefix dwim" trace &&
> +       grep "fetch> ref-prefix refs/heads/dwim" trace &&
> +       grep "fetch> ref-prefix refs/tags/prefix" trace &&
> +
> +       # Ensure that the correct objects are returned
> +       git -C client cat-file -e $(git -C server rev-parse dwim) &&
> +       git -C client cat-file -e $(git -C server rev-parse exact) &&
> +       git -C client cat-file -e $(git -C server rev-parse prefix1) &&
> +       git -C client cat-file -e $(git -C server rev-parse prefix2) &&
> +       git -C client cat-file -e $(git -C server rev-parse fetch-by-sha1) &&
> +       test_must_fail git -C client cat-file -e \
> +               $(git -C server rev-parse dwim-unwanted) &&
> +       test_must_fail git -C client cat-file -e \
> +               $(git -C server rev-parse exact-unwanted) &&
> +       test_must_fail git -C client cat-file -e \
> +               $(git -C server rev-parse completely-unrelated)
> +'

This test is precise and easy to understand; the patch is
Reviewed-by: Stefan Beller <sbeller@google.com>
(considering the test_when_finished comment as
an optional nit)
