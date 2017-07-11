Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2393E202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 13:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755900AbdGKNrw (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 09:47:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36703 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755897AbdGKNrv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 09:47:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so1902pfk.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4H0z566Mwjg5N2YWc7Qd1e+l63Vt/83n/VCBJ4CjvBY=;
        b=b4UwSpYQ5dyRZaB+bi+a0MM3XRlRwkzvALT71E5/t2pUJKhxTkTUo35Q8m0JV5S9aP
         CD46XfWZ5c79CZ+sGRkwieJYwuJUvBkbeRNXSMrqyAJNVrIqM+tgCXx756BhoLr8I7Zi
         xGJRW68ELsrdREdt3e5tcGDGSO5uHnqSc1MAEDyHPzYdYTiNTZEpLi425FdHS0i5lAma
         rGYyy7pt/Oj886lGf6d/EnMjIprOsuEfYNi5Y2o//r6Cx/0w7hAC0pOHDW8FNk+izKGF
         SulZooAQZAVA5bSFreHDkV/prE2qVPAtjQ5ZzaCapFkdGFK4DN/94TI3CnJtPGn1u5Wc
         Nt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4H0z566Mwjg5N2YWc7Qd1e+l63Vt/83n/VCBJ4CjvBY=;
        b=giJlcmifIBw0GpQLrAgmid19jZAyOh+W4qfdFXUlBdNeTGQvRZuGSdOcSFaY/Gxm6q
         fPtWaMFZdjqHPsvxutdENOOI6Hx+flx+u+LplJy1k/VIt/l5odpz5eypv8MAKEahnKk7
         gGXII/WG0daQH9Bj9ePznojndDKzjUIQsU4UBqbz9Zxa8mvI50F54sWfliiJ4PWTx+oj
         sYVs3snT8qVcF+yOO8KtEvdp2Y+Al/PNJlPoyDSrZdX8TAwtTZcomXBE0qvXKzE2VsJJ
         M0yQfVlZTz2qn5Py7HojMlhxjUlAA0cRBu8o5L2V8YTg41bBAzrJ62Wc1ahRCec/+rb3
         ykeQ==
X-Gm-Message-State: AIVw110ZOwerbpaeSZQvkNzYKvVjCrlkCBRfDfRJDgzDX6k/h35fAfBE
        719KDHwoNlY12rZ4zDwcIWhICT8Txw==
X-Received: by 10.84.229.77 with SMTP id d13mr24173456pln.239.1499780870794;
 Tue, 11 Jul 2017 06:47:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Tue, 11 Jul 2017 06:47:50 -0700 (PDT)
In-Reply-To: <20170711103715.a4jfbjop227bfuhh@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com> <1d639a4c7be5f1c173502f79e85aadd017ef5f7c.1499723297.git.martin.agren@gmail.com>
 <20170711103715.a4jfbjop227bfuhh@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 Jul 2017 15:47:50 +0200
Message-ID: <CAN0heSr0czHkoxaYKeR-L-G01PWrHnLF-cArkH3ufpoR1+HZzw@mail.gmail.com>
Subject: Re: [PATCH 3/7] git.c: provide setup_auto_pager()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 July 2017 at 12:37, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 10, 2017 at 11:55:16PM +0200, Martin =C3=85gren wrote:
>
>> +void setup_auto_pager(const char *cmd, int def)
>> +{
>> +     if (use_pager !=3D -1)
>> +             return;
>
> I think you probably also want to return early here if pager_in_use()
> is true. If a script runs "git tag -l", you wouldn't want to start a new
> pager when the outer script has already been paged (either via config,
> or via "git -p").

Good point. Thanks.

Martin
