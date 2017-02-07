Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18281FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 11:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbdBGLHr (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 06:07:47 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35218 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbdBGLHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 06:07:46 -0500
Received: by mail-oi0-f43.google.com with SMTP id j15so62674320oih.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 03:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=djZtj43Sc4QiiHELsRlrNd8shlKc9JDO8tznQNazJ8o=;
        b=GWzAcljzcwluZcrt95L6P0htvsDSyUNFTrTe9YmUPb+USmNM7ndFepxnoLZlnUsNsd
         mc/a/jrFcy/Cx6JU9+QVhREbRaAw+BI2u1LUz/F5SohPpZZMTg4+hBG3jBd79ZKJ9Msk
         W1yCum71b2jRg/MKtZl18uxal+m/d6gM0DPikF/z01zj4SNOuAw2G2G6m9WjcMJGbcsL
         5AMc3NtBy/ziHVAqog+1MNwutJUQIVBpJRaVqoKodvkyVlxL8Zr5+awmvR0mgUZasGGl
         ot7WIlcRpOpdALXuPQSl3jRqwQwz98VF8R0qaUnf4qv7/HFlZ0tGxb5qEjtCiIeO/gMz
         8AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=djZtj43Sc4QiiHELsRlrNd8shlKc9JDO8tznQNazJ8o=;
        b=ST9o8hSvYOWJ7ZqLOTVfhe51mhy52nQCUIiIw+PENqC/p3UfrrtILo/S3CxxZcfsNl
         VfhAz9yo0Tth3x7sUFRBzLTYJoBDsQ+WY+Rq2XUgUIzNvbFj7TY6EAdj73qRztJeblCI
         ispRlRnWPDhAnmMhTgUcBwVk5yzg/Dd55rebhwxj91mtihEYHuIVkS4gZuLQ+SfpKcfA
         2NeRpHbp1nkXIypg3lPn7nYjn5iSs3Bfu1C1dgCMZMxXtAOOfX3sucTCBiq2v9ZWRfOb
         0ZidiUEyEPHdBhroobYFyEQLOqgTH2c/kzxFQH4GBzEUWtAH6zDR+SrTSRreQG80toA8
         /Arw==
X-Gm-Message-State: AMke39kspFnE5LjK2A9Dxm3ADCN9JJ3ne+cjBwfJfXrMQ0zIGHrN+/FaXDTja3vwl0w5BCzTgODHxlpCCojpvg==
X-Received: by 10.202.60.67 with SMTP id j64mr7696818oia.124.1486465665607;
 Tue, 07 Feb 2017 03:07:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Tue, 7 Feb 2017 03:07:15 -0800 (PST)
In-Reply-To: <20170206174000357620972@bob.proulx.com>
References: <20170129002932.GA19359@dismay.proulx.com> <20170130172730.x5guphyqf5fsfi7m@sigill.intra.peff.net>
 <CACsJy8DED9WRr_T6g43bxHUGQYVnfaTx15hqSGiiajvi0TxtuA@mail.gmail.com>
 <20170206171225215133282@bob.proulx.com> <20170206174000357620972@bob.proulx.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 7 Feb 2017 18:07:15 +0700
Message-ID: <CACsJy8D_X7u+kttu=ZD734u6nhR=wjMh0m99RBvm0_FOW74pWA@mail.gmail.com>
Subject: Re: git-daemon shallow checkout fail
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2017 at 7:56 AM, Bob Proulx <bob@proulx.com> wrote:
> Bob Proulx wrote:
>>   17:20:40.590177 pkt-line.c:46           packet:        clone< 34e72022=
70c381f4e5734180dc19426ce69f2e1e HEAD\0multi_ack thin-pack side-band side-b=
and-64k ofs-delta shallow no-progress include-tag multi_ack_detailed symref=
=3DHEAD:refs/heads/master agent=3Dgit/1.9.1
>
> The evidence of it running the wrong version being the 1.9.1 which is
> not the bits I built.

I wonder if we should make this "git/1.9.1" information more visible. We co=
uld

1) Always print it when cloning
2) Print it when cloning with -v (printing all capabilities with -v
might not be a bad idea)
3) Include it in error messages when clone/fetch fails
--=20
Duy
