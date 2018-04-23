Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E521F404
	for <e@80x24.org>; Mon, 23 Apr 2018 11:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754693AbeDWLUV (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 07:20:21 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:45670 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754614AbeDWLUU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 07:20:20 -0400
Received: by mail-ua0-f182.google.com with SMTP id j18so9904909uae.12
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rGxu5+w7IqD92ZJhXkZFJFvMQZvGcpwcCWhijDJB1So=;
        b=WwgevGKczqA/3Jh+YVpl2DmfPZYxUweAGJwhOUyqHy0h51g6t1inMyIwhrbL7jTw2o
         h9Ok/gy9isIwN01QxBtB2vAaL5jGbb0Jozs2Ciz7s+Egv1KIqVZ3Sh0G/FjL6C59acdG
         gtDuWmqNLpgX0m684e6Qv4a1QE8A4AmDf5niJWDH6dE65hmzXl3krvsdG83VjVS/m0BL
         e/TaLftAsTQTt8BLgxWnRm9TpvkVMz0LW/v37WAFl8z68hC+VCBVNXuk/Gm4WHeWV2pW
         /ST+yST1F3IqZ5RXrK/OE6Q3/08W7n5CVj+R7w2J4k5hsmNzMNEIG/PlKuHUXxFcz0lF
         ZAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rGxu5+w7IqD92ZJhXkZFJFvMQZvGcpwcCWhijDJB1So=;
        b=Xt2PBO55FvYLA/k0F5pmiWatV/+dog456vxDJmtsET5fF5bh8FjTW/juSmEV8nU0dP
         6xnUPTrNPCepUt7qGZqyPu154MIHTo1ABz7dsd0pUPqkyVhGAk2zJ7nCVFJ6tyZTYiiq
         xYPElxTOK+wdBxEYk3oKw10XqlIrlcaINzEpTXAtJwYB2hmDG3tOMtw1tVCrRMKUkALi
         nL5/bcKoHNaNc5fJewUXcHhYNhk8gTdxucTGUq0xOn95x3NhbyJ14GJFsRORLx4t38U7
         9OUMgPamlvCFNh3TXtWZG8Q0XoI/gZd25pHBVemCjawuzwu5/E/A0+oPbsrQ5or9+yty
         qsdA==
X-Gm-Message-State: ALQs6tAcCEN+LtQRTO4Enac+gVncMCEevE7OClIbHzdWEuuKH7Fm0w70
        j2Fj1of12o8HxSnZDgkmgGtOsgGhYJ84pq/xDc4=
X-Google-Smtp-Source: AIpwx48H088ojdFJe5+M/miBaL5uKt2Th/t9DII21Vgf6gnJwT70uaSdtJ440naSe7sT705XG52J9C+9/1y0xIkyKAQ=
X-Received: by 10.176.10.129 with SMTP id d1mr7887088uak.39.1524482420079;
 Mon, 23 Apr 2018 04:20:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Mon, 23 Apr 2018 04:20:19 -0700 (PDT)
In-Reply-To: <20180421165414.30051-3-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-3-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 23 Apr 2018 13:20:19 +0200
Message-ID: <CAM0VKjk_vvVgUHAQDRAs6+dyBd55qKO+ZG_-X2DgaqnNtPjGUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] git.c: implement --list-cmds=all and use it in git-completion.bash
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 6:54 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

Oh, look, an empty commit message! :)
So what does this option do and why use it in the completion script?
