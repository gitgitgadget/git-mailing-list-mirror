Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE5D1F42D
	for <e@80x24.org>; Tue, 22 May 2018 10:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeEVKPi (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 06:15:38 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43520 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeEVKPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 06:15:34 -0400
Received: by mail-ua0-f194.google.com with SMTP id d4-v6so11893854ual.10
        for <git@vger.kernel.org>; Tue, 22 May 2018 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MuvJlQtuE+K7LiFCMVlESa9ZtiYHTPqiwypB/60tjz0=;
        b=dYQ5o7lvqBvnlhQwG4F8rMvDRytTVCkl43uykLErp2EOFrBrmL6A2JyOMEHMm5ozXR
         eL+RTvq5bmpHhQCmfgj/4TNYuQg2Vomdj2CYuQ7ObWTVeyxVnTerq09AIvf3O/Xe/f1f
         vNxdcP0dLvzpQB7MCCronUItGnX+bNaR7bqVCeTwRvd+ijNhsr7SrVueJ3R0Ie40eN4Q
         /DHG/bDA+689VQOXIZZiUPj193gRQ5uCO0hOxYS54v21CgwvBZchrAW4BKWM6D8yQpaA
         XnKuD9XF2zG6bPCICyKrHLqWBdEG51Gkw0HJQHAlKKapS8Rit66IZ+9/mfvDWvtcYWfe
         gr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MuvJlQtuE+K7LiFCMVlESa9ZtiYHTPqiwypB/60tjz0=;
        b=tZOJ1OXVhqESYElSE/sX4NJTRbKydqIrFaK9CsVJIw/6F+sK18TGRimM8gvAsyv72K
         8M+tfSi7vf562ku/QcSrxR0UQNnnPciGlpJP8yLUWllEsPqdnZFnxMtJi4IEoqhlZy9g
         1STXM2mJEpp1uR8RC3muEenX/2OUaF9sN1+MtEUd80UbsNRLL1L8/1Lf97UTFEuiHWlC
         LFDsL2waf27IQd5JU+AWR7c7PBIXeZXGqV0JQJmLKY2gk1bx7hIP4sxUYw77xB+RMfPO
         ipiC9x0ikxElmAnQ4fWZgHPVI5Z3gMej0y8ZpfUiutwx1fOV0kafDkYyht0XE7ptSyAD
         bG7A==
X-Gm-Message-State: ALKqPwfDq650nSQxeaeBkuOIQH9R3ODIOA1H78Qj2N0k9ObKCTDC6/yL
        YQ8D1Foar8tqXehxdofdaQ/Onhd1SzlSfzwL7n0=
X-Google-Smtp-Source: AB8JxZoBs1ZkBmID8c9lNscXisPJFtyXewDLAe5SAle7PpO7NYQ0vyqPUQry18v2wRaiz9eFkxxqeHwWMzokUunVLRg=
X-Received: by 2002:ab0:a81:: with SMTP id d1-v6mr17357849uak.39.1526984133415;
 Tue, 22 May 2018 03:15:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Tue, 22 May 2018 03:15:33 -0700 (PDT)
In-Reply-To: <20180522084109.29787-2-luke@diamand.org>
References: <20180522084109.29787-1-luke@diamand.org> <20180522084109.29787-2-luke@diamand.org>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 22 May 2018 12:15:33 +0200
Message-ID: <CAM0VKjkdGByfTtj5cunUzqeneu4Bi8Qw4vj428zV1h3ezHXyQg@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: unshelve: use action==add instead of rev==none
To:     Luke Diamand <luke@diamand.org>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 22, 2018 at 10:41 AM, Luke Diamand <luke@diamand.org> wrote:
> SZEDER G=C3=A1bor found that the unshelve tests fail with newer
> versions of Perforce (2016 vs 2015).
>
> The problem arises because when a file is added in a P4
> shelved changelist, the depot revision is shown as "none"
> if using the older p4d (which makes sense - the file doesn't
> yet exist, so can't have a revision), but as "1" in the newer
> versions of p4d.
>
> For example, adding a file called "new" with 2015.1 and then
> shelving that change gives this from "p4 describe" :
>
>     ... //depot/new#none add
>
> Using the 2018.1 server gives this:
>
>     ... //depot/new#1 add
>
> We can detect that a file has been added simply by using the
> file status ("add") instead, rather than the depot revision,
> which is what this change does.
>
> This also fixes a few verbose prints used for debugging this
> to be more friendly.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>

For what it's worth, I can confirm that 't9832-unshelve.sh' passes
with these changes, here and in all Linux and OSX build jobs on Travis
CI.

However, instead of a separate patch, wouldn't it be better to squash
it into the previous one?  So 'make test' would succeed on every
commit even with a newer p4 version.
