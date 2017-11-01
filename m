Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F682055E
	for <e@80x24.org>; Wed,  1 Nov 2017 20:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754865AbdKAUBW (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 16:01:22 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:56412 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdKAUBV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 16:01:21 -0400
Received: by mail-qk0-f172.google.com with SMTP id l194so4142062qke.13
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=K8Tw9EhKxaJ+kMVxAPWiW5v9knbhFcPUxrhfn65PN3Y=;
        b=teEfnanGwJkLVJWjR9MYC4c5OM36UROaCTLPTd9OYvVTXskFbsyc7GHv0kkxopN8eP
         +T4pXmNhFZKgOC7/DOS6wBDI0z6tpo9DT7elZpdo4cB+BQpF10BidcjKot46BEh41brD
         A/r33JhsefnjCj5pOO5iuwMR5BoF047/ldqtoF/hzyzSPTeEh3hqw5Ek3Dn1H6sonqeu
         CcX8erUHs9fgdy0eb5SQ5itTQvxJ9fSIIfeVFQIfIXQ2c1lDpNpDYp6E2q/XFwsnIerd
         WHwFxak8Hm3vtw2l8k7sei2RwMiE24YY6yINUWwLYeh5JiHrstvQjKre7FxztSOjdtNG
         594A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=K8Tw9EhKxaJ+kMVxAPWiW5v9knbhFcPUxrhfn65PN3Y=;
        b=ZMcyha2Qh/NojuvFHeteFUbN9PAveqdHY1JhdVsQK5C9HGl0MhFkBBcL1eBT1XLaAf
         TkqJCOlPpZ08+YZfRG8s8env+L5yTO4OazUK7xB6+7hCMn8w1grp3HewSQPfTiInVBg3
         0bTpMgAo8W5wci/JmxMpLGalvmBGPKS0Ffdem6xobYcCKUHLltSzIJlNjvjo4rbnc6YX
         YmQUmyvecFW0fihfjJE0CLpY/6Z0hAAiCxA2aoiTot6RUdlDXf3B79yxDBXJl3/EY17u
         ArPuj5tp4ndVhJwFRRBAHMtPxuAXjrFZxUyWPCmCWCEnBHVfl/YG0a2JcgJfD/TISciS
         D2rg==
X-Gm-Message-State: AMCzsaXWehItZLftzfJVAG13faeuT1+xEpGXd8A5Qnt9BG7VnSxfRM3p
        AN65Ht9cp/xytBrNNTDjFwr/iin2HebqPcICsNo=
X-Google-Smtp-Source: ABhQp+SrynA2g/wh/NW0t9XBHT1MVBrCUzz96Wkr1EQlyQfJAGNHEmom1rXs9AmBpxoZoVt+OOh3TFY10wvZxTpGJv4=
X-Received: by 10.233.222.134 with SMTP id s128mr1546563qkf.14.1509566480614;
 Wed, 01 Nov 2017 13:01:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Wed, 1 Nov 2017 13:01:20 -0700 (PDT)
In-Reply-To: <20171030025142.19421-8-anarcat@debian.org>
References: <20171029160857.29460-2-anarcat@debian.org> <20171030025142.19421-1-anarcat@debian.org>
 <20171030025142.19421-8-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Nov 2017 16:01:20 -0400
X-Google-Sender-Auth: FwcDY2YRLL2S0MDHGstLw5aewV4
Message-ID: <CAPig+cR9h-DS3NLzHVdnad420HtN3Afg+1BHBZBzG1EG0=U45g@mail.gmail.com>
Subject: Re: [PATCH 7/7] remote-mediawiki: show progress while fetching namespaces
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 10:51 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org>=
 wrote:
> Without this, the fetch process seems hanged while we fetch page
> listings across the namespaces. Obviously, it should be possible to
> silence this with -q, but that's an issue already present everywhere
> in the code and should be fixed separately:
>
> https://github.com/Git-Mediawiki/Git-Mediawiki/issues/30

Unlike the previous round, this commit message makes it clear that
this new printed message is indeed intentional. Thanks.

> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-=
git/git-remote-mediawiki.perl
> index 5199af6f6..61e6dd798 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -278,6 +278,7 @@ sub get_mw_tracked_namespaces {
>              aplimit =3D> 'max' } )
>              || die $mediawiki->{error}->{code} . ': '
>                  . $mediawiki->{error}->{details} . "\n";
> +        print {*STDERR} "$#{$mw_pages} found in namespace $local_namespa=
ce ($namespace_id)\n";
>          foreach my $page (@{$mw_pages}) {
>              $pages->{$page->{title}} =3D $page;
>          }
> --
> 2.11.0
