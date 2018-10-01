Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3C21F453
	for <e@80x24.org>; Mon,  1 Oct 2018 19:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeJBCCy (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 22:02:54 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44323 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBCCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 22:02:54 -0400
Received: by mail-yw1-f68.google.com with SMTP id s73-v6so5974509ywg.11
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 12:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p1MdRn/HxhPL/5NccjRze/Tpi3ncRoEFOeB+EfSecyY=;
        b=MOUjJb+mdwCn5NhEd8V9hCib8/PBYqzMS4H07SM+aO+C/kwcNwZbek9rbti9uwp3Hj
         zpYQQDK187+sTKiUuIRKnuJNfjaQrSaA0mDneg7R573XVWW/odqdEZnbc+AbKWUuEFmt
         q5ACZyyOlw+2gmEoKtkPjdMp+xQpixeVkR5qoWR4hVf6ch9gWtNebwBwgEHojDYdtj9W
         MZI/vKUwDzYI1q2g+vNp6tRUh8F4yEH7QE8ghxK4NLpJpJ0SUvqnKm3q8EHPYPjLXi6z
         SfTFIZ9Rlb/lOIH5gatnS/6Hqld0KvIzInfpjB4SpsyxgTphra40xtnkwyZguNwsHNwq
         GHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p1MdRn/HxhPL/5NccjRze/Tpi3ncRoEFOeB+EfSecyY=;
        b=Azq8ExC6x9ZWhPAZwOUqDrPB4Q3uBu0Ka/fEQ2cjRaUf5My6wmYdNOt34aS2+6YwZl
         JMHE4qMWA4vvRbe/b2s8mQQfKK9JFeTVaaxIyQlEFUceZKeiRJaahdbHxr5Ho0P/0GfR
         Re56L1x78r4zG8QgN7i2Ftfjj5HerGSBrlCrRkzLLma21dLhDi3xxksvcOxTFrhj/QbL
         jqQljOzQ/RuOj+l1Q7T+x3J7fp55vXAKIS104hM4mMxkO+ey5Y6AHUfLJqEKfiwppp1K
         bNPO2MUDb6kbyC2LFjrBGXAMHF7v8MM2E3+BdKGZMEMnV/3fg5w5LzvjmNqpsWv97GbE
         urcg==
X-Gm-Message-State: ABuFfohKu1iI7kF4BtH5fuJ89ub/C7SDxY9XY3z0Nz1w9pBIJzkJKu7+
        bWpfKS6YtJpnrcLv83ILcEcQhZDlFV8QccYIool5jw==
X-Google-Smtp-Source: ACcGV63tWRDgn6hLJVBtWqXDg9xoqiZ0FrCpUHY8kM7DgcYJaUE2F4I6XxP9rCmL4FDYM0HGhhK4HtTMxwEnBRtMzQI=
X-Received: by 2002:a81:b64c:: with SMTP id h12-v6mr6867380ywk.119.1538421816992;
 Mon, 01 Oct 2018 12:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180929140132.GA31238@msg.df7cb.de> <20180929145527.23444-1-avarab@gmail.com>
In-Reply-To: <20180929145527.23444-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 Oct 2018 12:23:26 -0700
Message-ID: <CAGZ79kbw96x2Dow7d-sUfOHXiVN8j9KgqEObo+TrVd5zWKbaEA@mail.gmail.com>
Subject: Re: [PATCH] grep: provide a noop --recursive option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        myon@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 7:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This --recursive (-r) option does nothing, and is purely here to
> appease people who have "grep -r ..." burned into their muscle memory.
>
> Requested-by: Christoph Berg <myon@debian.org>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> On Sat, Sep 29, 2018 at 4:10 PM Christoph Berg <myon@debian.org> wrote:
> >
> > I often use "grep -r $pattern" to recursively grep a source tree. If
> > that takes too long, I hit ^C and tag "git" in front of the command
> > line and re-run it. git then complains "error: unknown switch `r'"
> > because "git grep" is naturally recursive.
> >
> > Could we have "git grep -r" accept the argument for compatibility?
> > Other important grep switches like "-i" are compatible, adding -r
> > would improve usability.
>
> I don't have an opinion on this either way, it doesn't scratch my
> itch, but hey, why not. Here's a patch to implement it.
>
>  Documentation/git-grep.txt | 6 ++++++
>  builtin/grep.c             | 3 +++
>  t/t7810-grep.sh            | 8 ++++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index a3049af1a3..a1aea8be4e 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -290,6 +290,12 @@ providing this option will cause it to die.
>         Do not output matched lines; instead, exit with status 0 when
>         there is a match and with non-zero status when there isn't.
>
> +-r::
> +--recursive::
> +       This option does nothing. git-grep is always recursive. This
> +       noop option is provided for compatibility with the muscle
> +       memory of people used to grep(1).

git-grep is always file/tree recursive, but there is --recurse-submodules
which is off by default. Instead of providing a short alias to a noop,
we could use -r for submodules. (And if you happen to have no
submodules, this is a noop for you)
