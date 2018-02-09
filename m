Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFAC1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 05:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbeBIFdw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 00:33:52 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:37888 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeBIFdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 00:33:51 -0500
Received: by mail-qk0-f176.google.com with SMTP id w128so8666057qkb.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 21:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fen8UARMxT+g17VMmdLlF/i2x+8oEPUeEQCCef2sk/M=;
        b=avqYKsePwvI5VTb7sljYriINhCq3rbzsvIfTDx8ExNOJfDaqidgIcBC6qsP2WfXvcL
         6cvnng2Mgm7KRAaDfDb4mupYMpQd22gXJ7gSn5qJqkeCd/uxg+NB42YtplS/hIQSBDCZ
         Zgh3tEf0ubA7L50G6i+sw5lMxrRj/Gue1etb/3ib6PZVjRdSsRsNWqZRfUN7MLuGRoIU
         o7rklMu3pDUv0nyWlDMEmS0vsDST0AeIECjvpzOuVt9ZNOLMvnLAvD8tmX3AilnNfnas
         n2FfZCmdlHgN/e9HHE+BZuc1Q2IOU7aAO+9vTdUec5J/rdgWvCAFiGlgAKU/WLdupapH
         6Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=fen8UARMxT+g17VMmdLlF/i2x+8oEPUeEQCCef2sk/M=;
        b=JTy2d6V6OE1fPZgI+IcyCdKyj4KcGGaNwoBUzIJMxCLtbdYnqxO1bO6I37Z04P8NdG
         PXnLdR5FMyvQ+aXlXyn5aB1BfgDnj1lm8jmlCHWYFdWGsm+aswbeesh5nHP8tbmYw0wo
         TbM76Z9KflrySkbfAB/jA3FgXHcWQCOVqInD1QffhvWzZ8yp0ManbmDmRfZxDwk3Qa8c
         9ttdvDnUZdxX9BtOBzbR8/B0LIo4Inz1p4VNQqA7Mvfp0Y+1Ce6JgqRajQWrwNvgdAfr
         uxTyTQQH6gpLEFY5QFcvIaioAe9G0pLSNj6rA0C7fi58TF1QdLKc/WSIvKHhrKqtSAaw
         w4Ag==
X-Gm-Message-State: APf1xPDz862Ej/RzHIyDO7yaudPcMGB0whS49yEW8zSRuR86oFE+Ki3H
        vEsJOg8LQyHpQGIUn26yYcGNL0yHk7b18M3mC7Q=
X-Google-Smtp-Source: AH8x2241uRWTVZDBDUWDAmqI2P5fYvbjwGhPXcvf8rP4Cn/LQCnuJKP2utMtLsE/tK0K6Fzwjh8GaFg0zbXu9xn+NMs=
X-Received: by 10.55.221.76 with SMTP id n73mr2142335qki.53.1518154430201;
 Thu, 08 Feb 2018 21:33:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 21:33:49 -0800 (PST)
In-Reply-To: <20180208161936.8196-14-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-14-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Feb 2018 00:33:49 -0500
X-Google-Sender-Auth: VaV4e0srSs9XXfoproGljxEJNSg
Message-ID: <CAPig+cQCuMyWYrsMq8=FDJC5D+EuZk=eoK6ri3Lgs62VPzAX2A@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] git remote doc: correct dangerous lies about
 what prune does
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
> The "git remote prune <name>" command uses the same machinery as "git
> fetch <name> --prune", and shares all the same caveats, but its
> documentation has suggested that it'll just "delete stale
> remote-tracking branches under <name>".
>
> This isn't true, and hasn't been true since at least v1.8.5.6 (the
> oldest version I could be bothered to test).
>
> E.g. if "refs/tags/*:refs/tags/*" is explicitly set in the refspec of
> the remote it'll delete all local tags <name> doesn't know about.

Not worth a re-roll as this is only the commit message: s/remote/&,/

More below...

> Instead, briefly give the reader just enough of a hint that this
> option might constitute a shotgun aimed at their foot, and point them
> to the new PRUNING section in the git-fetch documentation which
> explains all the nuances of what this facility does.
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> @@ -172,10 +172,14 @@ With `-n` option, the remote heads are not queried =
first with
> -Deletes all stale remote-tracking branches under <name>.
> -These stale branches have already been removed from the remote repositor=
y
> -referenced by <name>, but are still locally available in
> -"remotes/<name>".
> +Deletes stale references associated with <name>. By default stale

Nit: s/default/&,/

> +remote-tracking branches under <name>, but depending on global
> +configuration and the configuration of the remote we might even prune
> +local tags that haven't been pushed there.

This is a bit difficult to digest grammatically due to the phrase
being incomplete. It could say either:

    By default, stale ... under <name> _are deleted_, but
    depending...

or:

    Deletes stale ... <name>; by default, stale...
