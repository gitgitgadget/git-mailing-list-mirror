Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD931F404
	for <e@80x24.org>; Fri,  9 Feb 2018 05:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbeBIFRH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 00:17:07 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45425 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeBIFRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 00:17:06 -0500
Received: by mail-qk0-f195.google.com with SMTP id x127so8613638qkb.12
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=EWBOKcD3nCWWtDxD/8o8naxykks6rV62hOOdHANQOBw=;
        b=IbqIfLx6y+npquPfmjNAWx7n88hgaalhRV3EDYivt+mfpXCJyxnB5853WZZKJzhvOq
         4kr4mwVX7b3Ca0PSi1M3EqqkpXOTTE/AfJND0LCAxHHluCCeERsRn9mmr/UkBvruvsYA
         OgXcZTxwWf0Hd1x5Qb68lTia9ExgHTHc8OCAugX2mZyKPDdB52zVKazMJPMCpn/54aUs
         GVQJ9b8j9RY9A7AAE1JLO6JihslkOfoVG7auFMmbw4HZYtjc+w0SgxJlDkSMQjYn7vxo
         vaP8gbvVsFLTeiC+H36XPz7cCd/gRgDoRVNdXLPIaypUFC/ja8EeU+OhslRZLjGG3AaH
         MxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=EWBOKcD3nCWWtDxD/8o8naxykks6rV62hOOdHANQOBw=;
        b=KeTA+VAuglAIoqDGDUZVlylUUHL/nUWjqkMPcATG9uxmUEgnsrUOO2cFRpeY5bYQbw
         YBr6DxLZ76uIiJbRx01Yy3vBSW2jpgWzweqTEbG4BUBpYoQBKsp60z7dU4medCuCc/Ub
         De8dXM1Sba1dt3LLB3h+y6Zv6jHACOXVxGTIxALSNBanLmBvxQpHOF2p5F3AZ5ldvHty
         7wzGO0mRz0p+4S47itzHOvoVVfE9CSVv2vvVdBv+5e4dSKXTbJCQrQ72iT4IyuF9vCLj
         fE+JNH430lCE6HeBHg1EQEDz+P1SXEm6Q6UK9RSHA2aqhEgSmWvojjnrTL5eCYwpZS5T
         al5w==
X-Gm-Message-State: APf1xPAbNuOinkdjYdbDYgODiD+X5K1nTDh9cCitH9SrSzALJFGnjZCT
        5fZB9127ztajZgrN0cCKVZfixo36mev6xLfTGzs=
X-Google-Smtp-Source: AH8x227K3g4xqHNDIkm44Xu+L4x1fqxwn2OUYURx/EzOkuwXdvEIhDe2hB84EOR9X5iw+ZA3nFb7ody6DtUeYdumDkM=
X-Received: by 10.55.183.70 with SMTP id h67mr2127811qkf.331.1518153426025;
 Thu, 08 Feb 2018 21:17:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 21:17:05 -0800 (PST)
In-Reply-To: <20180208161936.8196-12-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-12-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Feb 2018 00:17:05 -0500
X-Google-Sender-Auth: iPkmlwTS1Ye0ZksCcoC-vXbJMg8
Message-ID: <CAPig+cS4xhyYSnUHXshB=2SPYELe_HXUwxL-OGU4zx=PMFXdqg@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] fetch tests: fetch <url> <spec> as well as fetch [<remote>]
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Daniel Barkalow <barkalow@iabervon.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 11:19 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> When a remote URL is supplied on the command-line the internals of the
> fetch are different, in particular the code in get_ref_map(). An
> earlier version of the subsequent fetch.pruneTags patch hid a segfault
> because the difference wasn't tested for.
>
> Now all the tests are run as both of the variants of:
>
>     git fetch
>     git -c [...] fetch $(git config remote.origin.url) $(git config remot=
e.origin.fetch)
>
> I'm using -c because while the [fetch] config just set by
> set_config_tristate will be picked up, the remote.origin.* config
> won't override it as intended.
>
> Work around that and turn this into a purely command-line test by
> always setting the variables on the command-line, and translate any
> setting of remote.origin.X into fetch.X.
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -548,18 +548,52 @@ set_config_tristate () {
>         *)
>                 git config "$1" "$2"
> +               key=3D$(echo $1 | sed -e 's/^remote\.origin/fetch/')

Faster (thus more Windows-friendly) assuming that $1 always starts
with "remote.origin":

    key=3Dfetch${u#remote.origin}

> +               git_fetch_c=3D"$git_fetch_c -c $key=3D$2"
>                 ;;
>         esac
>  }
>
> +test_configured_prune_type () {
>         fetch_prune=3D$1
>         remote_origin_prune=3D$2
>         expected_branch=3D$3
>         expected_tag=3D$4
>         cmdline=3D$5
> -
> -       test_expect_success "prune fetch.prune=3D$1 remote.origin.prune=
=3D$2${5:+ $5}; branch:$3 tag:$4" '
> +       mode=3D$6
> +
> +       if ! test -e prune-type-setup-done
> +       then
> +               test_expect_success 'prune_type setup' '
> +                       git -C one config remote.origin.url >one.remote-u=
rl &&
> +                       git -C one config remote.origin.fetch >one.remote=
-fetch &&
> +                       remote_url=3D"file://$(cat one.remote-url)" &&
> +                       remote_fetch=3D"$(cat one.remote-fetch)" &&

Is there a reason that these values need to be captured to files
(which are otherwise not used) before being assigned to variables?
That is, wouldn't this work?

    remote_url=3D"file://$(git -C one config remote.origin.url)" &&
    remote_fetch=3D"$(git -C one config remote.origin.fetch)" &&

> +                       cmdline_setup=3D"\"$remote_url\" \"$remote_fetch\=
"" &&
> +                       touch prune-type-setup-done

Why does "prune-type-setup-done" need to be a file rather than a
simple shell variable (which is global by default even when assigned
inside test_expect_success)?

Also, since the purpose of this code seems to compute 'cmdline_setup'
just once, can't you do away with 'prune-type-setup-done' altogether
and change:

    if ! test -e prune-type-setup-done

to:

    if test -z "$cmdline_setup"

> +               '
> +       fi
