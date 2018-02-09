Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1A01F576
	for <e@80x24.org>; Fri,  9 Feb 2018 07:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeBIHDf (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 02:03:35 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33626 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBIHDe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 02:03:34 -0500
Received: by mail-qt0-f174.google.com with SMTP id d8so9417178qtm.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 23:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hPZe6BOUUPArnymvkwL+R3fUXfxyOj3tRH4x560TtQM=;
        b=EBTvcMXhaTo+c1MjZuJssz+maRJ8tmDBgwNBiTbBNUzxAwpjSkiuBIstq6n/8I8qfF
         9o0atod4GyTD0rIoCB3rBLh3wan8mM2eLHZgNHLsNIKOJL4dDQbUhe4chNenU5H2AG5+
         dbybDXvkow+ODryaRctEnj3RP7DrkRUMmhic2SDo5IfvB4PL7ng31/jEh0KRqIZdyL+T
         5yCr8k/kr1GDiylZU4ywfovnzaVfzmB2Sv9zhU4shU4Vb9N1qwLKl7WstW4mmV2ViU9H
         0FZRnS1y1Gfgkqk5I56D/GhXAGSGiu0r/gYHMFIuIOoBj+sEsi/F21aAq/3fOZrl6sE0
         LK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hPZe6BOUUPArnymvkwL+R3fUXfxyOj3tRH4x560TtQM=;
        b=Elut9xnr8/yKdWR1t06T8Kf1SM8URoD+6RYUx5+7zhOvYLoO6utlS3DWGJjauABtuC
         vElbiV/Djy4Gzem/bHC7wgXk+Ia9pZft9p+z3AD06EZs3xd1MH9/4blCPRSmvtuaWDsk
         ISRthlQtjvnpFaoxEC5pnCA8QD5yJcOOBpG8FFGTiS75jvzLoy8HqLPgiDsOGEtt1y1w
         j5PXnVaxXzLyRO37w5JVSORmYroD6eeZUfTYBRIs8v9kj9cv2vILfVH5S0B+m229qMwR
         kkx1bVuSbWpJbTkWWGZfNo7AqMsJ5V/eyZEeNenBDzBq+mCo+gMihl7nj6WKqsW6cwjj
         LLUw==
X-Gm-Message-State: APf1xPBfGPaWhWaYTZQx4VD/8OXJVDy6jTz82X1Yu/YRMaMT9J7K3aEt
        Q17mWqGs6R13zUK74XGtgCHHstzX8dpOYOxOccc=
X-Google-Smtp-Source: AH8x226LJ4mYkpcnRjRxTStYuvF5qUbbv3o506D3N+f7p4Esv6MqpkA00JgU1Wnu1nWa0ugiqkyP7oQ6mUdxgkQ/fZs=
X-Received: by 10.200.27.34 with SMTP id y31mr2989692qtj.161.1518159814294;
 Thu, 08 Feb 2018 23:03:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 23:03:33 -0800 (PST)
In-Reply-To: <20180208161936.8196-18-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com> <20180208161936.8196-1-avarab@gmail.com>
 <20180208161936.8196-18-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Feb 2018 02:03:33 -0500
X-Google-Sender-Auth: ZFkXQi-KynqLk1y12lIDSd4EcCc
Message-ID: <CAPig+cRJzKF9a4=-qkdUH1kUzvx3azf_gY85yqU0Y7NHXTJrdQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/17] fetch: make the --fetch-prune work with <url>
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
> fetch: make the --fetch-prune work with <url>

Do you mean s/--fetch-prune/--prune-tags/ ?

> Make the new --prune-tags option work properly when git-fetch is
> invoked with a <url> parameter instead of a <remote name>
> parameter.
>
> This change is split off from the introduction of --prune-tags due to
> the relative complexity of munging the incoming argv, which is easier
> to review as a separate change.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
