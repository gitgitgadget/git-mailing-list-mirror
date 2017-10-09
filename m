Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18B220404
	for <e@80x24.org>; Mon,  9 Oct 2017 23:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754959AbdJIX1U (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 19:27:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35415 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754644AbdJIX1U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 19:27:20 -0400
Received: by mail-qt0-f194.google.com with SMTP id z19so5034255qtg.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 16:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=q1qO/OwX47/WhylP6nHqLOGxyfnL8mrzORSyfl08aTc=;
        b=gsdJjrJltHZ/Kzij6jq7iS5ZgMUTZITgKue8rWQh33UqAYVkLyEJE01ub5ttAsEtU/
         BTFemkJgNCit8Ie6lqVzdEx8LmYUnR3rPY4xhRYpX2C8s3XBpxeiS4tttpKpuSoZYEqF
         nw2R7Zv/jYJ0bsGA12uzGtwNV8Dp9HvQbWxtYw1B4u3yIb+tKdR95ZGZe24y/cTB7EEw
         qRvtCe5wiMLDQoA7+foCx1R2bAfD0Ul0jBVmEKiH+MRciJH1QuJh/D58SLTsNu41FGsY
         rJOxYqZb5NEX2VqqNIYdjiwpnHUtEzj8v1YDJIo1nI7rV4DEq4AnWmN8khBjyUGnROPJ
         CuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=q1qO/OwX47/WhylP6nHqLOGxyfnL8mrzORSyfl08aTc=;
        b=ANmynyKy5BPytVcz4M1CO/1nvEQVctOPQtqxo2bH8sSUa3GpuPHFBmX+FI/gZNGMvY
         nj9bkqgIBWWsTcZzq20N8/oe2yX2bmMwze06Bug11Y6x0jVoqmnCrbPhfcJw2q52KN/2
         /JlOTHvzN0ZT6R6GPdx8hrYTX9i6floCj3650INfjK/B3Ei6miuKfrfvmmezjj2xFwZQ
         wpDdCpEaSizvrpgPiqFITTYTOmP4lg/AyjiUeiPES6H9WGx3YMR4TyRTEBpywX2o9ily
         xGntERstYqNqHa4ybw6Cj5Zv0fHAGakYV4gmqH99IHK9WXJu5gjDvf+/56Vq3IeE2SMR
         zrHg==
X-Gm-Message-State: AMCzsaXahusy1NDxTmOFPqO0nUTdgaTBUiHqZu/kiyZKmbV/QRjlJXil
        aUR6ovl2jnazJQPCtYeOGK+4oSncDeVSG9xVswc=
X-Google-Smtp-Source: AOwi7QDHh37NupzYxXTA3RGNNKl0i3yKg33ZiF5SpSKpUpEOmCPJaxXqm1kVdoqJ8MNA0AhbPW2OEzgBbcWA5gbO0zk=
X-Received: by 10.233.222.134 with SMTP id s128mr9010404qkf.14.1507591639529;
 Mon, 09 Oct 2017 16:27:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Mon, 9 Oct 2017 16:27:19 -0700 (PDT)
In-Reply-To: <20171009214543.12986-1-me@ikke.info>
References: <20171009214543.12986-1-me@ikke.info>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Oct 2017 19:27:19 -0400
X-Google-Sender-Auth: GznCXjgff00tsodp5oIPkUFo3K8
Message-ID: <CAPig+cTnm01CJJN6tf-K_6Ah7uDoMeMJAxHUbC9YE1TxvAKF5g@mail.gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
To:     Kevin Daudt <me@ikke.info>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2017 at 5:45 PM, Kevin Daudt <me@ikke.info> wrote:
> When columns are set to automatic for git tag and the output is
> paginated by git, the output is a single column instead of multiple
> columns.
>
> Standard behaviour in git is to honor auto values when the pager is
> active, which happens for example with commands like git log showing
> colors when being paged.
>
> Since ff1e72483 (tag: change default of `pager.tag` to "on",
> 2017-08-02), the pager has been enabled by default, exposing this
> problem to more people.
>
> finalize_colopts in column.c only checks whether the output is a TTY to
> determine if columns should be enabled with columns set to autol. Also ch=
eck

Presumably: s/autol/auto/

> if the pager is active.
>
> Helped-by: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>
> Signed-off-by: Kevin Daudt <me@ikke.info>
