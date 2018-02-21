Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3B11F404
	for <e@80x24.org>; Wed, 21 Feb 2018 19:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeBUTsi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 14:48:38 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:40165 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeBUTsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 14:48:37 -0500
Received: by mail-yw0-f181.google.com with SMTP id y186so903253ywf.7
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 11:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TRhWHTfA4TWYpPgrfUti9i6u+iDtZMEwKtjYuHf7HyM=;
        b=Xjx6Yu+jXWeXWkDRT/ck3u+nc/099bSjPC8GBN0OW7+Xi3izCGxGCzms8l1WOC3xTc
         TBGD6Ps0HxQ798lIGNvd/FQEN+OBwvh9Y1oaVrUT9opKnhwCxeWL4EhTQsUJlNE6M/3W
         eCQl3QVJJkWE1/2jLL/Lxb0Xt6vXlqZM+C4Zm5vExQ9qjYjMxMk3Z79AmvTmrJLKkusW
         pFt7izHY61oh1Bl2y7IqaMfDn7qpxhEUOke4P4e0hOxMHNUQIO2WsQf1Chcs+fi6WfhJ
         sDHWPsgiFBsvYdBILArjbIHeOx3QIaVcuLoS3Eqk/XkE5RhbENiS/pjAPGmqlBGrKYkG
         UKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TRhWHTfA4TWYpPgrfUti9i6u+iDtZMEwKtjYuHf7HyM=;
        b=lfL8GWKvl+hdqa2IYAfLjAZNO0WG4HwAm/Jrve0xW3P87RysGyrjDbLCt0loNtakAJ
         XfzY2QG73KHRhP1JMLWbjEypFrDEAe610cyStkLb/3TMGjlARlhj1VNnKNo7hDuEVUX9
         nUHTkGVIJ+jymiHaWF9OAZ+yMmUFUWQJTsyf3CpfyzMspWzxKdr/Z/cJ004fcGLue+vo
         9nBr78/IVh3179K0IHBU/O3VGc8AbgFL1WzavdHGN5uTuSvnsMJb5+IZzCRhonk9Kecv
         xaiPfeEpmM50335zm0LpKc4N9H6yry8+jevu9TWJze3RJnwP0pjafDdISyxZwtYlKsy9
         shQQ==
X-Gm-Message-State: APf1xPBZwQt/KtPL+SysvIhcfNm0y+WxlFXmWG2gbhNR5Rbr6vLh79iy
        wbPbc6gIiAJ7sb8TeS1NedY0JYDCs4usbxyo7Y+xuw==
X-Google-Smtp-Source: AH8x227xTe0jcGl3z9ODUDo7gebDXTuFoudn1IjsPdOAl0WLES9CJ0d9UzmCx1ZOK7Qs5WeG9vWGoawyn49MVfutg0Q=
X-Received: by 10.13.237.70 with SMTP id w67mr3132550ywe.414.1519242516005;
 Wed, 21 Feb 2018 11:48:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 21 Feb 2018 11:48:35
 -0800 (PST)
In-Reply-To: <fa9754a6-2cc9-5b2e-5d53-e8acfe3a1113@gmail.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com> <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
 <CAGZ79kawTtSzVV2=sNn_OFsmCbcLGhVi1pt4bVrOYfZA28E+6Q@mail.gmail.com> <fa9754a6-2cc9-5b2e-5d53-e8acfe3a1113@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Feb 2018 11:48:35 -0800
Message-ID: <CAGZ79kY2rAG2ac06fSFMb1nr1Nh4CKE7PoqDPnh7RZg6qQHLaQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] commit-graph: add format document
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>
>> [ so in small repos, where there are fewer than 256 objects,
>> F[i] == F[i+1], for all i'th where there is no object starting with i
>> byte]
>
>
> Correct. I'm not sure this additional information is valuable for the
> document, though.

It is not, I was just making sure I'd understand correctly.
