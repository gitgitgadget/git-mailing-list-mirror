Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D6E1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbeACUpS (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:45:18 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:37642 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeACUpS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:45:18 -0500
Received: by mail-wr0-f177.google.com with SMTP id f8so2999602wre.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L9Z87ouR11Kv/wBOwD8B/1xBjYR8FTuA5o851vGChOc=;
        b=pMhQ2N0jozGODPLv5CjTUy4J1TrFoRhyneYTklqYNil4kHGBrFd5IaDVtFsQCYVOix
         xwNv1e1go1KvMXzga630hRKSpmPHCFZUqn2w5v8qDfaIwsWwJAA3eI0H7nkZ6xmIasGU
         mUfMidlI0twN1/359PBQNEVYFf5Y0S5z3SvvkvNg7WeLHxCmpE1QMBBsBi8FngHY2HR4
         ML6/pcz/v5Ro39cb/mnPtWEMaA15bXmQ8I8udGE6b6D11zisaPHRW++zEA7DREbyDXbD
         J5ChnGENFsjucREAaHnmRFiR8hRcJHIz+bw/cWk3tMKQqnSeDeBArKPnc+Sj0H8kZbaZ
         +h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L9Z87ouR11Kv/wBOwD8B/1xBjYR8FTuA5o851vGChOc=;
        b=CvADyUgASHjGgtCExoMr9i5N+bqbhtNk7ZRlUMfFpZw7Gnfh6hQr8IJEvFIr4TphDb
         VF7OpWALsYOuJXRYhawn8lRMunCXA6D6fKLpP8SRo0zBcKb5hH0A0yw3Yd3kalkSX9/s
         Sv5e7aMb7r3D8O+DhvdpDOIH70Plin/cYBVJACFk5m6KHG7Xwc/erSS+msp+GgnP8sr9
         FnXnEXQjafTLcSFVDWscUEyEtPDevUSpf399z2cZ1ySCjUKIktlE9l1Cw96TYqYhqOy6
         8GCSvjCJXQbsMahc84xptzh1Poo+6UxZknpg8JJVEw2BPQBYZ+Vdaz8TWRbxwuf4MKMW
         6HCg==
X-Gm-Message-State: AKGB3mJz+R0dRmMQ0h+WbeQGKfbeGhnwiYuvUu1jkuQNFU8Njs94G9ff
        HDkmknKRBDoz0JmCdidTFAY=
X-Google-Smtp-Source: ACJfBoshy6iPGarBf0G1/Z4GmUP7kD60ZPxG1lkIIVs/uKVJok9P6mbhg4foIZr0WSZbKvIh0cVKyA==
X-Received: by 10.223.143.54 with SMTP id p51mr2585998wrb.104.1515012316876;
        Wed, 03 Jan 2018 12:45:16 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB59EF.dip0.t-ipconnect.de. [93.219.89.239])
        by smtp.gmail.com with ESMTPSA id g78sm2638688wmc.30.2018.01.03.12.45.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jan 2018 12:45:16 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq7esyiwju.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 3 Jan 2018 21:45:13 +0100
Cc:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>, peff@peff.net,
        patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <31DC76F1-7D11-4EDE-96C4-97F3AE50EDE9@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <20171217171404.GA18175@tor.lan> <BF5C58AC-C1E6-4AD5-A4F8-C4CC5C9108F7@gmail.com> <20171229125954.GA9772@tor.lan> <xmqq7esyiwju.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 03 Jan 2018, at 20:15, Junio C Hamano <gitster@pobox.com> wrote:

> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
>> May be.
>> Originally utf8.c was about encoding and all kind of UTF-8 related =
stuff.
>> Especially it didn't know anything about strbuf.
>> I don't know why strbuf.h and other functions had been added here,
>>=20
>> I once moved them into strbuf.c without any problems, but never send =
out
>> a patch, because of possible merge conflicts in ongoing patches.
>>=20
>> In any case, if it is about strbuf, I would try to put it into =
strbuf.c
>=20
> Please don't.
>=20
> A code that happens to use strbuf as a container and about
> manipulating the contents is quite different from a code about
> strbuf.  The latter is to enhance and extend how the strbuf as a
> container behaves.  An operation about character encoding for a
> string that happens to be stored in strbuf is more about the
> encoding, and much much less about strbuf.
>=20
> convert.c is about massaging contents coming from the outside world
> into a shape stored in Git and the other way around, and there are
> multiple ways the contents are massaged.  EOL convention may be
> adjusted, characters may be reencoded, end-user defined conversion
> may be applied.  Some of these operations may use helpers specific
> for the task from other more library-ish files, like checking if a
> string looks like encoded in UTF-8 from utf8.[ch].

Agreed. I did that in v2. See these patches:

=
https://public-inbox.org/git/20171229152222.39680-3-lars.schneider@autodes=
k.com/
=
https://public-inbox.org/git/20171229152222.39680-4-lars.schneider@autodes=
k.com/

- Lars=
