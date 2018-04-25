Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7CF1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756142AbeDYSYv (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:24:51 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35844 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbeDYSMo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:44 -0400
Received: by mail-qk0-f195.google.com with SMTP id a202so23403139qkg.3
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1DzuLZgDQQeYue39LbjuWS74mBvcTWfHAawx8DRxz3o=;
        b=NAVaibICZssNi59fHOI5U756lmL0qaazRvTz1If8j02j77smLMe39NtJu9WKamEO5g
         M/MZkt57/Uec4O/rDKwiIjmq2ulZW29zTp6oLmI+8FjZX4AU44NJaBnq5hzBY9ocTTfX
         czUVDbI3wjRndDhy+E0hKUvTG4gZgaauee8qDGBfxoZv9VgoZXSVyc7xDNB5KUmG1Nwi
         CbFtfsf0xdhHkqRXss0R6f8VMEjotsNg6KYwwBtHfBg+EhtYfI2zd70TaKGzoZm1Bc7z
         oboyq5YtNHmsCw7TpuMXotaszl1EFQRHDPQJI3Ah0dhZBiO4IDPLQuC7wBD5932x09IM
         FEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1DzuLZgDQQeYue39LbjuWS74mBvcTWfHAawx8DRxz3o=;
        b=tO20B3n/kdKJHcEfATxG1X+Ph3lzZ8U3BTy5sS63enIlFfMGhxivBqbBwfxuirj1HS
         gGDX1OawJ0sG8Bb1HK0kozcCzMf0tb0ch2o152nXvAoz11ljBKzrrsDks6D42r5Lu+AD
         BKjJma1KdJUwyQF07n+hG1oH4qiGMERMUd1UVjaE6ddWbd7zuYwxBl6+75duzEpDH9oT
         Bjq07AkVoXaErOhk/rn8DabRh8JsuumCin78S7QwThdTVAr7PhZ/Gp3SgtPjZaYfJJ+q
         mfEknCKtesyzaoGGyc0SBz/tkF2un0OXXguWVjabYzWMTVqmqhqO7pSIDtyslHl8Z6p2
         SZvw==
X-Gm-Message-State: ALQs6tB4qkh9vIvBgj5iratgtrDJMfuWCnilGnVnZFlaRgdzuw3/Z/by
        P4LT72hVtQrf/w0XakuiezIUKybWFagTagWhTi8=
X-Google-Smtp-Source: AB8JxZqrqVat/GtcRFfKBphHdXFDoBI9Vjo4vNqdNIrmeR9+m/uT4CCS2n9C5c+EYcY/R12CqvrnxOxtrO7igJp3tlc=
X-Received: by 10.55.99.199 with SMTP id x190mr30339213qkb.91.1524679964176;
 Wed, 25 Apr 2018 11:12:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Wed, 25 Apr 2018 11:12:43 -0700 (PDT)
In-Reply-To: <20180425163107.10399-7-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com> <20180425163107.10399-1-pclouds@gmail.com>
 <20180425163107.10399-7-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Apr 2018 14:12:43 -0400
X-Google-Sender-Auth: r90I_kDu-lHhAGAZJhSWS9bAXOE
Message-ID: <CAPig+cQCy_ZSUit83YcVBSCzpvXAX1kNWjpG0nh+76ESXRD8Mg@mail.gmail.com>
Subject: Re: [PATCH v4/wip 06/12] git: accept multiple --list-cmds options
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 12:31 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> Later on we may support non-overlapping command groups to
> --list-cmds. Allow the user to execute just one "git" process and get
> multiple groups. This may matter for git-completion.bash on Windows
> because we don't want the user to way for long when TAB-ing and

s/way/wait/

> Windows is slow on launching new processes.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
