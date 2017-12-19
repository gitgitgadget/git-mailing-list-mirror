Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08111F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbdLSWof (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:44:35 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:40243 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdLSWof (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:44:35 -0500
Received: by mail-it0-f43.google.com with SMTP id f190so4638980ita.5
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qxeedEloUolk3gwIVmADRisWNbJfxyVXLK+g4mmCF8Q=;
        b=WnIL6scFJIb1TczYwlAP6wtgX3g62PwQEexAvVAh0urFzrm8gx3sKXRI0i0do3xwDd
         E7kl8gFPrgq2KXCP7PxZJmX194gtq45mthiSPE2wUEGd9u4o4RJEHjHgBOF46kx1N3La
         PDo96Dk+CTYTKRQgnZUIVBHp8Gc2qzQx8XRpUIT4xhkTEfSV8FhToZWzvMJm6Vr1EQJV
         lSXluRcdVHFvAeeInujuFZe1K99D9O8x8U/v16kHSkTe4+/P6PR64eC1JhE3iyT08QfI
         cW0FLf1yP3nwYexMwJdiqfS8oheIYZSxduAvYq0o1S347Q0UE/DS0y56wJa+PcIyF138
         1w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qxeedEloUolk3gwIVmADRisWNbJfxyVXLK+g4mmCF8Q=;
        b=TN/o7NbefT8mX9LyOgGj2AfJaGqAaFMgC1VoSZPnyF38AdLRj3YOscK1yX+8MtEVnz
         fSO3VeRmo+Dd/CFXAlmqOqUFVYvq5R8eeRAxvFkitaB354yTxfMhUpFOaJ7fkiuyOVbZ
         Ely5/gIoe90iz1QdL6rvbq05lAN5UB7wr9YDYqHU8MtcBFKKng1EFRBhopM5H8VJj+JH
         6DH4OGs4RIHO4FfYv0Lc5Bcpe7CzMGXmTEzR1ttGmjvGYt2GnjJnm5YDCxuwv0ZaGNU5
         EfaCt/7G2BQ/RfNgl1M9XQeboiqHC8jgTohHeTei2R4xE+N2kJ6ykFgL2si9gNP+zZmU
         vYng==
X-Gm-Message-State: AKGB3mJdtzHN19KxCZctfKUvsCvZi+vb6EzRHvN4Kkj2hUkKBbYVmeIs
        1Hgm2AdoDG5N61l+ufn9UavfP4ST
X-Google-Smtp-Source: ACJfBoupQCE6kevHKlBEtHp4aeB/x1VgDVuUKgirFAVYLmYmdxwdykGO5FLfcLns8A8N+dDSAikbjw==
X-Received: by 10.36.108.212 with SMTP id w203mr5393704itb.148.1513723474132;
        Tue, 19 Dec 2017 14:44:34 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s2sm8329244ioa.45.2017.12.19.14.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 14:44:33 -0800 (PST)
Date:   Tue, 19 Dec 2017 14:44:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] submodule: submodule_move_head omits old argument in
 forced case
Message-ID: <20171219224431.GG240141@aiede.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171219222636.216001-6-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219222636.216001-6-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I had trouble understanding what this fixes, so I'll try nitpicking a
bit as a sideways way to address that.

Stefan Beller wrote:

> With the previous patch applied (fix of the same() function),

This tripped me up a bit.  Usually commits assume that all previous
patches have already been applied, since that allows the maintainer to
apply the early part of a series on one day and the later part another
day without losing too much context.

I think this intends to say something like

	Now that we allow recursing into an unchanged submodule (see
	"unpack-trees: Fix same() for submodules", 2017-12-19), it is
	possible for ...

>                                                               the
> function `submodule_move_head` may be invoked with the same argument
> for the `old` and `new` state of a submodule, for example when you
> run `reset --hard --recurse-submodules` in the superproject that has no
> change in the gitlink entry, but only worktree related change in the
> submodule. The read-tree call in the submodule is not amused about
> the duplicate argument.

What is the symptom of read-tree being unamused?  Is that a sign that
these patches are out of order (i.e. that we should prepare to handle an
unchanged submodule first, and then adjust the caller to pass in
unchanged submodules)?

> It turns out that we can omit the duplicate old argument in all forced
> cases anyway, so let's do that.

What is the end-user visibile effect of such a change?  E.g. what
becomes possible to a user that wasn't possible before?

Among the commands you mentioned before:

  checkout -f
	I think I would expect this not to touch a submodule that
	hasn't changed, since that would be consistent with its
	behavior on files that haven't changed.

  reset --hard
	Nice!  Yes, recursing into unchanged submodules is a big part
	of the psychological comfort of being able to say "you can
	always use reset --hard <commit> to get back to a known
	state".

  read-tree -u --reset
	This is essentially the plumbing equivalent of reset --hard,
	so it makes sense for them to be consistent.  Ok.

Based on the checkout -f case, if I've understood correctly then patch
4/5 goes too far on it (but I could easily be convinced otherwise).

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c               | 4 +++-
>  t/lib-submodule-update.sh | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index fa25888783..db0f7ac51e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1653,7 +1653,9 @@ int submodule_move_head(const char *path,
>  	else
>  		argv_array_push(&cp.args, "-m");
>  
> -	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
> +	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
> +		argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);

Interesting.  What is the effect when old != new?

Thanks,
Jonathan
