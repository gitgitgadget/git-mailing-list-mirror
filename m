Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36011F453
	for <e@80x24.org>; Thu,  7 Feb 2019 23:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfBGX5b (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 18:57:31 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44573 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGX5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 18:57:31 -0500
Received: by mail-wr1-f49.google.com with SMTP id v16so1698757wrn.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 15:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FCnEVLt1DHZB1xT4w/9dUa8SDhRQ5GnLcEP/BBAhZk0=;
        b=VvawFmtcSZzDrZLvW9Zfjbb/h3fzqzwZKxDOfWVkQ8oG9tSkhhOzHf8ooRWgJWEJBY
         ZB6FDmrfUYmrX8jhssW1qpNiSG9IrePyDO+DQL9jBFWbuPnsrLWUYTUmovWRyFJeEmhc
         7so29PUlcTvoEpbj/sPrHELwXyyrq/Mp32U9AnFgliHhB9EUj8bo6MrkPe6289BCLITf
         dVYEMY8spQqRaNf6aWjcS906J89f5a3UoXu7LGtlZRwr7V0UDsSmw+GU9qt/WCvG6pQR
         f/37eZ6j2syGc5QEyJSb2xJ1EupP76UUUBKmnxpShX3ppOubLlOr/k7AJE55+JWN41zy
         tNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FCnEVLt1DHZB1xT4w/9dUa8SDhRQ5GnLcEP/BBAhZk0=;
        b=DPJmOXrUxpoMKTqkm+35foOC2rVzJPDQXHn7MsLlaZjlkuAgtNh6uksfvJFwR+InAe
         S2EqqkB0jBUsOGu+sK/1/MyUlqgSMzcdNVPOeqJVtg4yaURlpkYQySCZINL2g9mMwuGp
         oNtQVl28OIRCyE27BxJAH79/0rcOc0oOFfes5wxzU/+vdxUF9+//xc0/lCRCnGUKfAIU
         HUJANnwSvIMk0/cPAM5xP9dj3Q4jwUbXy68OZ0OtPpDxOZp9d5s+dlBX/P6/uN+DOMwX
         FJxX/ognKA7kqfp8+Z5Hvljuurq50MHDdUPA0ONsi6oB1Z+xO0uxwdbk2aFNfYhwVS32
         4gsw==
X-Gm-Message-State: AHQUAuYZTeEXilleQXQTFVqtUnMQd2zZEHnfWYs8drd0h14Ao2lraMle
        dXjx5bSt1XTOW0JPQD35fIc=
X-Google-Smtp-Source: AHgI3IYMNM2yoSbYhrbZ3I+ThBxfxzfJG5BGj9c7iNNiFV/pjV42+g6GugTdRDa6G6Kw5HJnWydfGA==
X-Received: by 2002:a5d:4487:: with SMTP id j7mr8432491wrq.83.1549583849628;
        Thu, 07 Feb 2019 15:57:29 -0800 (PST)
Received: from szeder.dev (x4db57a12.dyn.telefonica.de. [77.181.122.18])
        by smtp.gmail.com with ESMTPSA id t199sm35744244wmt.1.2019.02.07.15.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 15:57:28 -0800 (PST)
Date:   Fri, 8 Feb 2019 00:57:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Torsten =?utf-8?Q?B=C3=B6gershausen'?= <tboegi@web.de>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Jeff King' <peff@peff.net>, git@vger.kernel.org
Subject: Re: t0025 flakey?
Message-ID: <20190207235726.GR10587@szeder.dev>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
 <20190206104243.GJ10587@szeder.dev>
 <nycvar.QRO.7.76.6.1902061450280.41@tvgsbejvaqbjf.bet>
 <20190206171517.s5lskawpdodc74ui@tb-raspi4>
 <001501d4bf06$506b8640$f14292c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001501d4bf06$506b8640$f14292c0$@nexbridge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 11:58:08AM -0500, Randall S. Becker wrote:
> > The NonStop port has traditionally had issues with t0025, which we tended
> > to ignore because things did work. We wrote those off as bash issues in
> > t0025 since they seemed to be corrected when we picked up a new bash
> > version about a year ago. I will keep monitoring this, particularly when
> 2.21
> > comes out.
> 
> FYI: t0020-t0027 all passed on the NonStop port for 2.21.0-rc0 - so no
> issues for us on this one.

Note that t0021 is very likely flaky on NonStop, too:

  https://public-inbox.org/git/20190111140408.GC840@szeder.dev/T/#u

