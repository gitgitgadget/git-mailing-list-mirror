Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B67020401
	for <e@80x24.org>; Mon, 26 Jun 2017 09:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdFZJ0f (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 05:26:35 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33710 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdFZJ0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 05:26:33 -0400
Received: by mail-wr0-f196.google.com with SMTP id x23so28800415wrb.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 02:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V3gIhnWGQXIXJmF+OdD4VDZm4gxXLpY4SXr49HyFKu8=;
        b=t8Q8FfHBt81TT0Ug/J8Kvr/0VbOMrM6KB7CpzMKPD9DWJc137hfW8FxxKnjHuNz0ni
         Zo1nNOUm6AMd/C9i3msnhzOm4hS6wUrsn3EGQ/9e+lCTJ40A0zf++d0Y6fNKYfs6quoT
         b9JPwTZlwqVgfQ5cZz/hZg49qOzzVc9Sp2CPFhD8qOmG9csOLbYw2PXW6leLjGpOrsE+
         18OX6iObifAcrvzfbG0dhfMkDry6G9AHs6Ii1VCwZMfTVgOAZvN76oBsBlyBuFqzJs/Z
         qU26RtkxgVKoMDnuAZwuRW59ICeOgfCld9S71miyp0tInW+j4ZVEUx8NR67u1VDn97Bt
         OIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V3gIhnWGQXIXJmF+OdD4VDZm4gxXLpY4SXr49HyFKu8=;
        b=G8z8JDFPMDGO7d9AonSpZM2OL364XwtHcmbp7lH/Qn/FB1yDqlPg4UcVlPkkdLTSeu
         /w8H9v0055/tpW/Re+Pchtj8pq6DdE/VYex+wk61jfo+EqCzS7CIrOLtp8UUqVH0MGrs
         WxiJ0t9IG6iGDGbcbH7BhyVkIExqU+KC1BBGp2/MW/nTMY5bc2wStpNFFAqS1TFwN1ig
         Lo75OBtLsGwnPU6uNDsUjplJvFULxMSri6r9BEAU3vUPbxmC4qeroUYE4MYvC2AxwfJx
         vNixMaVhTDy3GQXIV+KtsmhosKMJp90F5w9eo7+IEowU08ZHvdM8tz33oaSCUqbPrRHk
         cTUA==
X-Gm-Message-State: AKS2vOxKxrxpb5GlKoD2Qj36iq95EA2XZqwz3mpeIl/tqjiHgLN5Ka90
        cun1tXYmQ3Oblw==
X-Received: by 10.223.170.75 with SMTP id q11mr13939230wrd.72.1498469192457;
        Mon, 26 Jun 2017 02:26:32 -0700 (PDT)
Received: from [10.32.249.40] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m187sm9573260wmb.10.2017.06.26.02.26.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 02:26:31 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 3/6] t0021: write "OUT" only on success
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlgof7lw7.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Jun 2017 11:26:30 +0200
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FC46284-650F-411D-845F-0DF4F32071FF@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com> <20170625182125.6741-4-larsxschneider@gmail.com> <xmqqlgof7lw7.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Jun 2017, at 00:17, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> "rot13-filter.pl" used to write "OUT <size>" to the debug log even in =
case of
>> an abort or error. Fix this by writing "OUT <size>" to the debug log =
only in
>> the successful case if output is actually written.
>=20
> Again, use of "Fix this" without clarifying what the problem is.  Is
> this change needed because the size may not be known when the new
> filter protocol is in use, or something?

How about this?

    "rot13-filter.pl" always writes "OUT <size>" to the debug log at the =
end
    of an interaction.

    This works without issues for the existing cases "abort", "error", =
and=20
    "success". In a subsequent patch 'convert: add "status=3Ddelayed" to=20=

    filter process protocol' we will add a new case "delayed". In that =
case=20
    we do not send the data right away and it would be wrong/misleading =
to
    the reader if we would write "OUT <size>" to the debug log.

    Address this issue by writing "OUT <size>" to the debug log only if=20=

    output is actually written in the successful case.

- Lars=
