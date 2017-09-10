Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7DEB20286
	for <e@80x24.org>; Sun, 10 Sep 2017 12:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbdIJMaR (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 08:30:17 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34579 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbdIJMaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 08:30:16 -0400
Received: by mail-wr0-f173.google.com with SMTP id v109so10251099wrc.1
        for <git@vger.kernel.org>; Sun, 10 Sep 2017 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gWK8fDqJtIgj3afTpBWQ2npWpiL0A0gJ6Sv3qIo6NOM=;
        b=ae8muU35qcqNv9f6SVXPc4mlV8JMW3zcpK06r2Sl7jVJdLxYV/C5TLLT/t337+hbYq
         c2D8b82K/3TkPngQd+e/fltoJydKr9xO4xOhEhVhX9rW5HcaY/NG12a7iBpY7z+zzFp1
         wsbQFujXTIMCFBb9unyL93cNi5RQX0x3S4wei61YHHUfHtNgy5l6r/5ICl19XAs208Nb
         9NOhR2Ee/U1da4UwUiuz6Z3w1GpriqE594MsuHSrq8O0AAeIJ9v0omzKY3PiH8FJrEC8
         0z8oA7cq0b7N9srGG4VmOHle5sG79NESzclZv3CN4nHWVEVRGC/OdYY8Oxm6nvC9DXhc
         9NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gWK8fDqJtIgj3afTpBWQ2npWpiL0A0gJ6Sv3qIo6NOM=;
        b=bVdE+2pSKbYdcezaeZ8QCwBmBrcI1YRbP+AVT1tmnbC7mCxMMebeQobR0xgUCbUGoB
         M6fKeWMR8Jstz4XVcwt8z9BgEyj1M8i7G+4/Jts8oJcMKJwJoTaxJcCJht0pC6iFRMnB
         6MVQQ2h7MnTNu8gkbzSmOgyONnkE/bRFX4j/xsZ/IS1eM0kB9TSWjlCwaKdTAt4/qDIq
         kwsrI7etyWVm7UkykcM3N9/5+c9DBE/Gow2c7TnNZgDIvuBn+s3C1rAGubGibSeAjdM1
         S7z1tZ6ARJtW1VQ+QySCeWn033ONOAtyGp6U8NUS2iA1FM8L14y6Std7wzw9uXgYlQiL
         vJpg==
X-Gm-Message-State: AHPjjUg+PKrleia5QKjhMI1+XIAMUPc4oPRAESo7P9F5fO+n9BdNGdXp
        RZpMYFafU7tiTw==
X-Google-Smtp-Source: ADKCNb5qjQ2r/luMJFNvEhn9faKEg73GbA6LoP7khe9esununvYw+7hR15AZD3Zpah1NsoodOYTHZA==
X-Received: by 10.223.172.14 with SMTP id v14mr6719990wrc.142.1505046615554;
        Sun, 10 Sep 2017 05:30:15 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB7AFE.dip0.t-ipconnect.de. [93.219.122.254])
        by smtp.gmail.com with ESMTPSA id 193sm11529774wmh.47.2017.09.10.05.30.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Sep 2017 05:30:14 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 00/40] Add initial experimental external ODB support
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
Date:   Sun, 10 Sep 2017 14:30:13 +0200
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE9DF8E9-3771-42DD-B1F6-EC77783380F7@gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Aug 2017, at 10:18, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> ...
>=20
> * The "helpers" (registered commands)
>=20
> Each helper manages access to one external ODB.
>=20
> There are 2 different modes for helper:
>=20
>  - Helpers configured using "odb.<odbname>.scriptCommand" are
>    launched each time Git wants to communicate with the <odbname>
>    external ODB. This is called "script mode".
>=20
>  - Helpers configured using "odb.<odbname>.subprocessCommand" are
>    launched launched once as a sub-process (using sub-process.h), and
>    Git communicates with them using packet lines. This is called
>    "process mode".

I am curious, why would we support two modes? Wouldn't that increase
the maintenance cost? Wouldn't the subprocess command be superior?
I imagine the script mode eases testing, right?!


> ...
>=20
> These odb refs point to a blob that is stored in the Git
> repository and contain information about the blob stored in the
> external odb. This information can be specific to the external odb.
> The repos can then share this information using commands like:
>=20
> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
>=20
> At the end of the current patch series, "git clone" is teached a
> "--initial-refspec" option, that asks it to first fetch some specified
> refs. This is used in the tests to fetch the odb refs first.
>=20
> This way only one "git clone" command can setup a repo using the
> external ODB mechanism as long as the right helper is installed on the
> machine and as long as the following options are used:
>=20
>  - "--initial-refspec <odbrefspec>" to fetch the odb refspec
>  - "-c odb.<odbname>.command=3D<helper>" to configure the helper

The "odb" config could, of course, go into the global git config.=20
The odbrefspec is optional, right?

I have the impression there are a number of topics on the list
that tackle the "many/big objects in a Git repo" problem. Is
there a write up about the status of them, how they relate
to each other, and what the current problems are?=20
I found the following but it looks abandoned:
https://github.com/jrn/git-large-repositories

- Lars=
