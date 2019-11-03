Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2FB21F454
	for <e@80x24.org>; Sun,  3 Nov 2019 15:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKCPEv (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 10:04:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42714 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCPEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 10:04:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id n5so3861803ljc.9
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 07:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Br/PaP3+uTm9+jRN1UztUCHPTpFM3gLqEpG8mmfbTOs=;
        b=Jl5tE8E4Nd/if2kjrycX4BGhIdwhOmEqBa2Vkbb1J5U3cCjZVgX5faP+PXhsPl7ty5
         SrHdXPyRPcQ+/aQUzLhqxpl/xiIJ3rzNB0ISzYjelWLTnCxStlORVWHdHfbexaY0SAWf
         fcImudfOOClNcScoe1t7tVS1JpVENjxGmZprJf748bVcd1AN0V2LqadgxbKQIOyPxCqU
         i5xtP9IojO+vEdS7oJMsz+IpwF9/XhGrntY7Tx05X9BrYVcav2a3XyLHnWnEQthZcKdn
         k2cjg7ebgCrNUQL0qPQrb3pQdxWzVeX2TlSP5G3FdCHO5SnnKlUGY102lEYN5Gy3vwha
         N5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Br/PaP3+uTm9+jRN1UztUCHPTpFM3gLqEpG8mmfbTOs=;
        b=TU4FpdNPaxGdXz7TaN0sECDBR7VVT4fHu64FxngFm7WLVvvV2WiM0vMyeB443SR+o+
         BCdqeLANp2z9/gxtqVVghT1QbhKf6M8ZcpHfbqdVWAT1IGO7V9KsrlTs6Tdtc/B2qfnY
         V49Blq8fNhfhDV/QOdwcizVf1caxZN32ZLvahxenfpTRTvy2Tl4UThflSiZJfgsUHj5f
         bEDIwlEk1XGA+3R5PpY3VM5LZclaB7VBuRGCcjjBymE/qYVJ+owmpqXPMTV0nkW2tYZK
         0/WayoTdOuP8wUQV3LeevuKrfocPooWi7WpKdrrXVqFz2Wfrc36qf+hq45LOHJSqvbCF
         bMww==
X-Gm-Message-State: APjAAAXcQbPapM+Nk0rHFsn30N+qQ/ywWRUiByetXIGkS6A54zHwG2cw
        P1kuT34VKhRSgVdGwCgTU6U=
X-Google-Smtp-Source: APXvYqydHF+erJwQzEutYGjrV1D3OoIwMnGfSlgzxRII2/wyFy7hwRZ1oXQK3WR2GQ3W/KS8XaTctw==
X-Received: by 2002:a2e:9985:: with SMTP id w5mr9071135lji.162.1572793487991;
        Sun, 03 Nov 2019 07:04:47 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id f25sm5108687lfm.26.2019.11.03.07.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 07:04:46 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked files
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191102192615.10013-4-sandals@crustytoothpaste.net>
Date:   Sun, 03 Nov 2019 16:04:44 +0100
In-Reply-To: <20191102192615.10013-4-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 2 Nov 2019 19:26:14 +0000")
Message-ID: <86h83lhugj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It is quite common for users to want to ignore the changes to a file
> that Git tracks.  Common scenarios for this case are IDE settings and
> configuration files, which should generally not be tracked and possibly
> generated from tracked files using a templating mechanism.
>
> However, users learn about the assume-unchanged and skip-worktree bits
> and try to use them to do this anyway.  This is problematic, because
> when these bits are set, many operations behave as the user expects, but
> they usually do not help when git checkout needs to replace a file.
>
> There is no sensible behavior in this case, because sometimes the data
> is precious, such as certain configuration files, and sometimes it is
> irrelevant data that the user would be happy to discard.
>
> Since this is not a supported configuration and users are prone to
> misuse the existing features for unintended purposes, causing general
> sadness and confusion, let's document the existing behavior and the
> pitfalls in the documentation for git update-index so that users know
> they should explore alternate solutions.
>
> In additon, let's provide a recommended solution to dealing with the
> common case of configuration files, since there are well-known
> approaches used successfully in many environments.

All right, looks sensible and good thing to have.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-update-index.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-updat=
e-index.txt
> index 1c4d146a41..11230376c8 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -543,6 +543,22 @@ The untracked cache extension can be enabled by the
>  `core.untrackedCache` configuration variable (see
>  linkgit:git-config[1]).
>=20=20
> +NOTES
> +-----
> +
> +Users often try to use the ``assume unchanged'' and skip-worktree bits

Why the change between formatting '``assume unchanged''' (with double
quotes and space separated) and 'skip-worktree' (without quotes, and
kebab-cased)?  In the commit message you write about assume-unchanged
and skip-worktree.

I guess that follows the inconsistency in git-update-index(1) headers,
namely we have

  USING ``ASSUME UNCHANGED'' BIT
  ------------------------------

but

  SKIP-WORKTREE BIT
  -----------------

This incconsistency is much more viible when both names are on the same
line, however.

This is a minor nit.

> +to tell Git to ignore changes to files that are tracked.  This does not
> +work as expected, since Git may still check working tree files against
> +the index when performing certain operations.  In general, Git does not
> +provide a way to ignore changes to tracked files, so alternate solutions
> +are recommended.

I'm not sure if it is a place for it, but the proposed text treats
assume-unchanged and skip-worktree as similarly unsuited for intended
purpose.  However, their failure modes are different: (ab)using the
assume-unchanged for "ignore changed to tracked files" may lead to data
loss (as changes are overwritten), while with skip-worktree the trouble
is that some operations that should succeed (like unstashing) are
unnecessarily blocked - but no data loss.

> +
> +If the file you want to change is some sort of configuration file (say,
> +for a build tool, IDE, or editor), a common solution is to use a
> +templating mechanism, such as Ruby's ERB, to generate the ignored
> +configuration file from a template stored in the repository and a source
> +of data using a script or build step.

I would really like to see a simple example of such template, so that
even people who are unfamiliar with Ruby's ERB can think of equivalent
solution for their language or toolchain of choice.

> +
>  SEE ALSO
>  --------
>  linkgit:git-config[1],

Best,
--=20
Jakub Nar=C4=99bski
