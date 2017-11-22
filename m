Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA542036D
	for <e@80x24.org>; Wed, 22 Nov 2017 05:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdKVFMR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 00:12:17 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:43621 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdKVFMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 00:12:16 -0500
Received: by mail-it0-f53.google.com with SMTP id m191so4746270itg.2
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 21:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CcL4HQncU42e3qk9GzfiM1zcmOzi63wauCBqisTsCKs=;
        b=WFyWIGQaBOYCoXXml712GQskk37DPyxJr3yHYaQPiWZWrZwYRinOdHA14dx8MdVam7
         89tUMtRaT7+G1e+4wnW3FdiLlaKWPhMAHhK21nCgquYGy9EKZ5qCva8bUG+Kc942p2y6
         AUL9ff8oMmEoMDXocbFSmoS1KEgOHczkI/a6kgdfTdraspjNGlcZT6lU58hCnMBvLGyh
         KAJayMIvKUNHD9cDbNDVFaUVNo2MRjDfAc0vJs4lzxT4A6itJkt2chnl5k1OOyYWvcQW
         dMwezGtjmshtM9HSWMfI7WKIFNR/Xf/z6Yj3J9/MZbJ4wDY43rYDw9sYloL0tBw47RQ0
         sVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CcL4HQncU42e3qk9GzfiM1zcmOzi63wauCBqisTsCKs=;
        b=MMKyjJt3l498aRo8finFHN51ym3UpC7cD/O53IGxXWh+66LNUD2Eo6aPZA356+5hS+
         LBlgZiYwUAVbmUfMLJw+N+1mltz60P//SYwRzXIFj/Z1y6UtYobaPddNY4BivUparW/v
         AQxjnuj3Wf7rLA2dfO0bbGMCqJ0V1LDiAcSPL1/pTr4sYQ4XFg0HLBEKoo5LeSbv1udO
         SdMKtBXXnYucuVsF9gtzjMPjnIj6e60lzzoSX1fsOl+KpyFSmVwnGP3XQLqG/wz/WvLy
         RNJMyDQRWcyl61HfJ8OC3QtdrkXzw3olpqO5wWQQjCD5+mtZsc8VGoskYeRL4RkYUP2n
         wVrA==
X-Gm-Message-State: AJaThX7btOat5abHoeYAPLYacf9u/8IReC8akmLjweJEycUngCR9LwYj
        l5LAoezsOi6KX9BW718hZtU=
X-Google-Smtp-Source: AGs4zMYb9ZyJnI8uZopKRIxIkltrGnWekl26rSfWVZ1e/vYALnKu//daA96gCjpKiwVY/2Q9n8A2Pg==
X-Received: by 10.36.160.68 with SMTP id o65mr5384487ite.45.1511327535641;
        Tue, 21 Nov 2017 21:12:15 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 134sm3047804ion.0.2017.11.21.21.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 21:12:15 -0800 (PST)
Date:   Tue, 21 Nov 2017 21:12:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Documentation: allow overriding timestamps of
 generated asciidoc
Message-ID: <20171122051213.GB7625@aiede.mtv.corp.google.com>
References: <20171121232935.GM3429@aiede.mtv.corp.google.com>
 <20171121233432.GN3429@aiede.mtv.corp.google.com>
 <20171122005433.kwv4bin6y65xuxm5@genre.crustytoothpaste.net>
 <20171122011531.GQ3429@aiede.mtv.corp.google.com>
 <alpine.DEB.2.10.1711212317440.27951@mass-toolpike.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.10.1711212317440.27951@mass-toolpike.mit.edu>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg wrote:
> On Tue, 21 Nov 2017, Jonathan Nieder wrote:

>> http://asciidoc.org/CHANGELOG.html is stale but asciidoc still seems
>> to be getting changes at https://github.com/asciidoc/asciidoc.  I
>> wonder how difficult it would be to add any required SOURCE_DATE_EPOCH
>> support there.
>
> In fact I already did (https://github.com/asciidoc/asciidoc/pull/106),
> which is why I’d been holding off on trying to upstream this Git patch.
> The trouble was, the AsciiDoc developers had not been cutting new releases
> “because nobody knows how”
> (https://github.com/asciidoc/asciidoc/issues/103#issuecomment-322077321).
> However, it looks like AsciiDoc 8.6.10 was recently tagged and Debian got
> a 8.6.10-1 package yesterday, so I guess that trouble has been quietly
> resolved.

Ah, lovely.  I'll add a build-time dependency on that version to the
Debian package.

Junio, please disregard this patch (patch 1/3).

Thanks,
Jonathan
