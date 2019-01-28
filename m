Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D40CC211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 23:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfA1XaZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 18:30:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33688 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfA1XaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 18:30:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id d15so10529830qkj.0
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 15:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wNEWUTRMXJzKnAQpa4CxOZycXQAGqJr2olhkN/KALPc=;
        b=FGFueISiGvnUOgLSyTSoVEXbh5I9fYj7e1/LIpQ3gGetHFYb6B3cP5T2+uguaGzeNQ
         gqYHJgFoUQBLowyM37u8QRnTbRwIhSxuFrgMl0QChr1ZQK+zxoklr5VaFwRiJvauRAJd
         oaCucQr3e9jARaGMDw1wajjFBU28oddfpezwTiDtduHGTUJdvDS/YJX6TrjhZfvu/VH4
         vqDwUP9oRciDpewvuZ3RK2xpAmNtUZasRQ8CRo5XJz6RGgq2fUpvBSJCHnYCUgZ8EpQW
         Bbih3bAmv/lMH/6SJ6E9pKwRKObQE8Tsrl0pavjLwEGdpFGyIOK/HjhH7DPwLDCDvZ4t
         ffoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wNEWUTRMXJzKnAQpa4CxOZycXQAGqJr2olhkN/KALPc=;
        b=BPdf9gXHMXMNsR1EfTZe2FjrD+dA/njMUmN1n0GTtO3zFjiicQKtjLcD2y+QXrJFSe
         6AAATDWsKSH1y0e0iQZJZXPZR4m0nLDlHSPM+e6mpfBBBKr0BBDs7g1qqiZyRK25DAXV
         ftA2YAOzLnfI9KZnlrSQaBqUFarpgWx/4d6KCOWtRW7V4IQ8FFvuYnq1e53IWtGLZY+8
         la5Ce5J4HVnTO9HTztyUcjj9oj2ZY6qdpuWFfEwBq0QbCmorh5fdrWVYFmL7zSEgqmy/
         fxnL+cxtPNwy2KTaai9xM9ra1MiYH17VmThuAANTZnnUfqeVqSKZZ2RA+GcpObnsDKTw
         WO9A==
X-Gm-Message-State: AJcUukcBHbPoL9YehBvPcU0Tgffoitrhnnn4iSqbIwQMWWrwwwtZ3YR8
        yfC001uraQW1RiuvXbPPHAo=
X-Google-Smtp-Source: ALg8bN6RMaSzyaF0vEULw0rvZgFa85EdO+WvUdtCFjHdhuGoW+r2N0Aj3NorRqpTLrRaMuu8OJG8Xw==
X-Received: by 2002:a37:85c7:: with SMTP id h190mr20999414qkd.225.1548718224776;
        Mon, 28 Jan 2019 15:30:24 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id v22sm2489216qkj.42.2019.01.28.15.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 15:30:23 -0800 (PST)
Received: (nullmailer pid 29099 invoked by uid 1000);
        Mon, 28 Jan 2019 23:30:22 -0000
Date:   Mon, 28 Jan 2019 17:30:22 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v2 1/2] config: allow giving separate author and
 committer idents
Message-ID: <20190128233022.GA29068@whubbs1.gaikai.biz>
References: <20190125215955.30032-1-williamh@gentoo.org>
 <20190125215955.30032-2-williamh@gentoo.org>
 <877ees4a65.fsf@evledraar.gmail.com>
 <20190128185817.GA28155@whubbs1.gaikai.biz>
 <871s4w4khs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <871s4w4khs.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 09:04:15PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> Adjusting for limited time, I'm happy to help out with this series,
> particularly if you have visual (screen reader) issues that make some of
> this prohibitive for you. Just say what you need.

I guess the best way to handle formatting issues would be, during your
normal review, make a note directly below the affected line about what
is wrong with the formatting and I'll fix it during the next pass.

Or, another option would be to reply with a diff that I can apply on top
of my patch.

Thanks,

William
