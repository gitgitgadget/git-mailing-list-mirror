Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7651C1F6C1
	for <e@80x24.org>; Tue, 16 Aug 2016 02:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbcHPCCP (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 22:02:15 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35545 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201AbcHPCCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 22:02:14 -0400
Received: by mail-oi0-f53.google.com with SMTP id 4so82187643oih.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 19:02:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ITn+Qx36ZKk5m9FyDPAVL0gHcmt1A4LrdQL5T9dfMXk=;
        b=fSTzUKuGLRSOO+5Ak/aZXSKp/IZw/4dij98vaMcrTnN7frUxaXOwj4zmJ0QVYb524h
         xIWmCOZFen35LIlC1SqU9CuYvITqDYwIhN3iBEvvnr+vyFCuQqQAcJ7kcRFju1G1OxnB
         jSrb8bD3wMBV6U1MyAepnzDZ7yufBIL1xXGk26s1fXJ4EiHo2u7uxoQqrClmm7tSmJ/Y
         SwXCUkKQH5a0sUkwRXYnZQh6Qc2mD65nwfDEYcyVWwSDFyQP/pEB3ATS+g76gP7ZGw2K
         mWJaF4tvqPHAqHzabrs9Z3au8oz+PzHPyaX/tsx/CNcEY/NuzItouR1Js8lFT+PiV+m7
         vKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ITn+Qx36ZKk5m9FyDPAVL0gHcmt1A4LrdQL5T9dfMXk=;
        b=VuU8L39Fx6fLSYdehRW0xnJQ2yXQrWYVO55wO5pIpXsDWYoDqeLM5ACyMPHyjQwmnK
         4uJ9lPFkuGQqw275M+8Jwu/igP9NiBcv1PjxC+U16P/p9kfvpn8CfTZyrhm+X2bLGC3O
         5jT9tZINbL9Dim/imPsX6oG1b9SOL2fD/cTU0tLZsVR9CLE2STRfqQiCGsTGPDHpDv/b
         qmOhTgNlL/JprYXUba5IeFpjaGRq1AMJH0S1k4rBrXvNrp+SJe9euooGIgTawOaOL6A+
         KG/PgOqAtfNOKBaXema1bxJoXUfBTTA6OWygG5A7/b18qIRy8r+PcovMTUKsnuNCLAmy
         92UA==
X-Gm-Message-State: AEkooutpEqh7PjVI03EC0I7V/GuBGGOehVkgx4TL+NLdRn2yX2ZohMhHu1Qs8pfb09s6neCL1U+wxS7HxRuMeg==
X-Received: by 10.202.48.205 with SMTP id w196mr15363867oiw.181.1471312933745;
 Mon, 15 Aug 2016 19:02:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.94.133 with HTTP; Mon, 15 Aug 2016 19:01:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608151422210.4924@virtualbox>
References: <CAKkAvaxWk6SK4EYPaWXHQoVBh9qLgHoEqAh9+dgOrjncsi5QyA@mail.gmail.com>
 <alpine.DEB.2.20.1608151422210.4924@virtualbox>
From:	ryenus <ryenus@gmail.com>
Date:	Tue, 16 Aug 2016 10:01:53 +0800
Message-ID: <CAKkAvaxEeOvCy-8EZ=BeWVUPCLec_dFNv+dNpj9_VsECzAT2YA@mail.gmail.com>
Subject: Re: [PATCH] make rebase respect core.hooksPath if set
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 15 August 2016 at 20:24, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Would it not be more appropriate to teach --git-path hooks to respect the
> core.hooksPath variable? This would be in line with --git-path objects
> respecting the GIT_OBJECT_DIRECTORY environment variable.

Indeed, I've thought about that, too, due to the bad smell of duplication,
but not sure if that's the right position among all the abstraction layers.

Also it's more convenient to come up with a shell based fix on local
installation.

Thanks
