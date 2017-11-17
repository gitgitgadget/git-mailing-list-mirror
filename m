Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F0E202D7
	for <e@80x24.org>; Fri, 17 Nov 2017 20:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759153AbdKQUq5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 15:46:57 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:43531 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbdKQUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 15:44:13 -0500
Received: by mail-qk0-f178.google.com with SMTP id j202so926515qke.10
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 12:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OZ3OXMUFYfzNr5H68KCGlN1u+V0R5gwsWkDmiFpD7Po=;
        b=eaynKnYwX3oaDtA3VDle7jnd5HBRPcPSvkpXqLO80jOzU8Ms/R4EM4b2r69R+LIIYZ
         3G3382wOeOB9MAAh7rNvnRTAHrl9FrRgx457Q21D6IIrUOmVXSnutd5QY/TPdNS1wWcd
         6Up/IU2WFvI0xrm+WDu0eCzE5y52DlKxNZwRt0gIg/3RDtrGjbxAuQzsfNrYdGqTgYLp
         R7/iccCnHEsvJV4UWhHNqHW2g9VOxseS3CLp37BeGFltqGz3kikFwNfQe1xL/MpjwPYd
         oO/4ATtEN/6QWWuhHiUSLc6y2UEtKF6jYsUSF0HhK0cJbDXrPsPzX3IgJ0wyIzpp6ANf
         Ey6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=OZ3OXMUFYfzNr5H68KCGlN1u+V0R5gwsWkDmiFpD7Po=;
        b=pG0e3PZbtN1SHITMbwc4uXlMURTbKlKbiyWKZrved3Wx3Sgmr7wVntGbV4VBw2ALPM
         pW1LzI8XW3EIW24WNpIx3RgelzCewrWOc/3y4tj/4y3YTwa88BPkiVJ/1NLIxiEKT5U9
         GFx2kLUgTtI5tyMvIj8fDtRSxO6Jm8PzJLNMfqdVBdKDtC+WOR5UAGsFjidxwmqtBlrN
         VRe4MMTJGKcyxcwRMT+0vSq4+ctZMM+5Okr/INbsvotyJMSEssM/9ES14WRYWN/qFNnT
         9EA2yHZJbXT3DNw6V3+Ioi7cYNkQfnLijSMcxaGVU436lQFS4M1OnZYimsFK0cxL2NLM
         AYvQ==
X-Gm-Message-State: AJaThX5bGiZw8ENvXJDIg34UMmzASRept1w3L9eM5h7igyMjU5iIw7m6
        EFf5+W2SapMdcEEq9SzdDZXP+qsLYufekzCZI+mpfw==
X-Google-Smtp-Source: AGs4zMbRMbo+/iZ6YI5knqCmmr/dXPLma5RcIF9mrIXDVeeENDCHY8KqzYFClPbYwZUFEsUHLiH8qB/It++ipPmGgJ0=
X-Received: by 10.55.114.69 with SMTP id n66mr9964380qkc.306.1510951452405;
 Fri, 17 Nov 2017 12:44:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Fri, 17 Nov 2017 12:44:11 -0800 (PST)
In-Reply-To: <20171116163828.14937-1-tboegi@web.de>
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com> <20171116163828.14937-1-tboegi@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Nov 2017 15:44:11 -0500
X-Google-Sender-Auth: A8Chblb4okoD_hpGaIjRM_8flfQ
Message-ID: <CAPig+cQocmJyoALeQeCRQPNsRgvJ5PSe=u2LN8Ec6aC86D4iQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] Introduce git add --renormalize .
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 16, 2017 at 11:38 AM,  <tboegi@web.de> wrote:
> Make it safer to normalize the line endings in a repository:
> Files that had been commited with CRLF will be commited with LF.
>
> The old way to normalize a repo was like this:
>  # Make sure that there are not untracked files
>  $ echo "* text=3Dauto" >.gitattributes
>  $ git read-tree --empty
>  $ git add .
>  $ git commit -m "Introduce end-of-line normalization"
>
> The user must make sure that there are no untracked files,
> otherwise they would have been added and tracked from now on.
>
> The new "add ..renormalize" does not add untracked files:
>  $ echo "* text=3Dauto" >.gitattributes
>  $ git add --renormalize .
>  $ git commit -m "Introduce end-of-line normalization"
>
> Note that "git add --renormalize <pathspec>" is the short form for
> "git add -u --renormalize <pathspec>".
>
> While add it, document that the same renormalization may be needed,
> whenever a clean filter is added or changed.

Forgive me for chiming in so late, but as a newcomer to this topic,
the high-level choice made by this patch feels a bit questionable. I
understand that, for people familiar with the "old way" of normalizing
files, git-add might seems like the right place to house this
functionality (and perhaps that's true from an implementation angle?),
but as one coming to this topic with no existing bias about
implementation or the "old way", git-add feels like an odd choice.
This sort of normalization (emptying the index, potentially modifying
files, repopulating the index) seems too high-level for git-add.

I _could_ understand if this functionality lived in, say, a new
command git-attr:

    SYNOPSIS

    git attr renormalize [--no-commit | [-m <msg>]] pathname...
    git attr check [-a | --all | attr=E2=80=A6] [--] pathname=E2=80=A6
    git attr check --stdin [-z] [-a | --all | attr=E2=80=A6]

    DESCRIPTION

    'git attr renormalize'

    Apply the "clean" process ... and commit the results. This is
    useful after changing `core.autocrlf` ... etc. With '-m', uses
    <msg> as the commit message, else launches the editor. Use
    '--no-commit' to skip the automatic commit.

The 'git attr check' command subsumes the role of existing
git-check-attr. One could envision git-attr growing additional
subcommands to edit .gitattributes, much like git-config edits
.gitconfig.

(I have since read the thread in which Junio's suggested[1] that
git-add could house this functionality, but it still feels too
high-level.)

More below...

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> @@ -175,6 +175,13 @@ for "git add --no-all <pathspec>...", i.e. ignored r=
emoved files.
> +--renormalize::
> +       Apply the "clean" process freshly to all tracked files to

This is the only time "clean" appears in git-add documentation. Every
newcomer to git learns about git-add very early on, but "clean
process" is a fairly advanced topic, unlikely to be on a newcomer's
radar. The term "renormalize" also feels out of place in git-add
documentation. If I was a newcomer reading git-add documentation, I
think I'd be left pretty well clueless by this description. At the
very least, perhaps add links to git-attributes and 'core.autocflf'
configuration.

> +       forcibly add them again to the index.  This is useful after
> +       changing `core.autocrlf` configuration or the `text` attribute
> +       in order to correct files added with wrong CRLF/LF line endings.
> +       This option implies `-u`.

[1]: https://public-inbox.org/git/xmqqbmlm9y94.fsf@gitster.mtv.corp.google.=
com/
