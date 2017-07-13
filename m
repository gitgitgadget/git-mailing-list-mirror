Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3597A202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbdGMSkf (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:40:35 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36402 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdGMSke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:40:34 -0400
Received: by mail-pg0-f46.google.com with SMTP id u62so33609966pgb.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZONXI8I+NYXcfIFl9lC7NUZ1oO4jHcHJGLmHRVuQoOo=;
        b=AyPfxOVHdDWt1ukQlfFKR3xeMk8m1RbIAMeo6zgPXpiFaUZoKl45EyNejOzUxZnIqh
         EznJeQXa/dmSOlF+QHC1jaSWQbol7dlnYH569d1GbryB8yIRM7kLmijfvP8DBrm5so6I
         I5l6mNK+TYdsh+/l3avupoQTPkXEIazq6qzX6kBiVs5md65sywTRh4H8nlLepstNlu1X
         KamInShz5kEHXRJZmWH1eTp0naFaUiMVlviaDwhuvgxyNiayQDLxlTirSdlTzLktOZUO
         YyB5BBlUfzvjHgKex4F5zr14CTkRtTiPTzRXsGhK2tu/VemWY19hSHMOC6Kdtpm2WvOK
         1hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZONXI8I+NYXcfIFl9lC7NUZ1oO4jHcHJGLmHRVuQoOo=;
        b=c7FEtZjZRBvEZJfAgzceSlxJS+9dec3HtWAB7LXD+Ob0oXXaM6n+OMFY9yg819bz7x
         ff2E7O7u3khK01LaDXPNzGzgTQ6OCY4Tn9/42FgBYvMz3y5cjkhsPypsvb34v2vxr3/O
         Lad+MPrA5K8tHuBw8Lof7XuY6mx+xbAw9aODb9J21pSje/6T2nshzjqV1NLy5vscJGnO
         UEK6WU+Bw1cH22bMXox6M2QSigFxQzY592uxuZ3lVlwPDopIWmaU5D0aHzmGpdPaezme
         eYVfU7+EvN4mjR/JeMySXVWX6gY7Eb7D01KAtAjTLNMxmz5Mf1ACJsp8OHi9aunKY2ag
         ouqg==
X-Gm-Message-State: AIVw111DDphZO97KQRtIxL85E62P4iVjBnDBTGAXs854nCoTcVggQZsG
        Ol7vVYmMnwephc1hvvhtuk++UbLOjWlc
X-Received: by 10.99.149.83 with SMTP id t19mr10607082pgn.247.1499971233216;
 Thu, 13 Jul 2017 11:40:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 11:40:32 -0700 (PDT)
In-Reply-To: <20170713145841.4win5tbx4efwjsa2@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net> <20170713145841.4win5tbx4efwjsa2@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 11:40:32 -0700
Message-ID: <CAGZ79kaE7wjFR-=DiPU5xwknS1nxDHR5+S6+UGPFTF0uNBA3dQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] t: use test_decode_color rather than literal ANSI codes
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 7:58 AM, Jeff King <peff@peff.net> wrote:

> I really only need t6300 and t6006 converted to build on for the rest of
> the series. But t4207 was easy to do. t4026 still uses raw codes, but
> converting it would be a pretty big job, so I punted.
>

I think it is good to have raw codes in at least one place to test
that raw codes work, but then again it could be specific test calling
out that this is tested.

> @@ -59,7 +54,8 @@ EOF
>  # to this test since it does not contain any decoration, hence --first-parent
>  test_expect_success 'Commit Decorations Colored Correctly' '
>         git log --first-parent --abbrev=10 --all --decorate --oneline --color=always |
> -       sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" >out &&
> +       sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
> +       test_decode_color >out &&

Just some thoughts:

This extension of the pipe-chain is not making it worse as gits exit code
is already hidden.

The sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" is sort of funny, because
I would have expected it to break in the future with e.g. the sha1 to longer
hash conversion. But as we specify --abbrev=10, this seems future proof.
In an ideal world this would be encapsulated in a function (c.f. t/diff-lib.sh).



> @@ -61,8 +61,9 @@ test_format () {
>  # Feed to --format to provide predictable colored sequences.
>  AUTO_COLOR='%C(auto,red)foo%C(auto,reset)'
>  has_color () {
> -       printf '\033[31mfoo\033[m\n' >expect &&
> -       test_cmp expect "$1"
> +       test_decode_color <"$1" >decoded &&
> +       echo "<RED>foo<RESET>" >expect &&
> +       test_cmp expect decoded
>  }

Thanks for removing hard coded colors :)
