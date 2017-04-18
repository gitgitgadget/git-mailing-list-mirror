Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A071FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 08:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756260AbdDRIx7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 04:53:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36830 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756252AbdDRIxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 04:53:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id o21so23751539wrb.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=MI2hUK7+CfCYGCPKMzYqB3LoEoowBYeYhzX0BDqHP6s=;
        b=os7wMZXicDhq2UXxP+Kjd7F/jwHSGeZXoUuhPobZIAHonbXAcC+j6GraLG7KcxBh6d
         dpwCwJO76YJ2edfhF1E0lCZp7jS3njXaWPPQyJY5sArZhgdOwoKVTkoYUNOoUXJfMWzO
         krxJMxNJWyjs8uD8g5KZaq9JaHblLhEfxSlcoM1XYQgov/MHIvIEK/tuGBugpDZBwvGQ
         Cu+ZnE9oJMdKbxTMNIxGi+vkOLYQfflJ1m3oGCtH4QKDspNteN1JavreIu6xa2uIcfFX
         OlZ+zckNVSNIvtZ1skEkJyQz6I2LJeSA+ZzzGvnh4S7jPbetSd+IAH+oAsjA7tAv6dKr
         AmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:in-reply-to:mime-version
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=MI2hUK7+CfCYGCPKMzYqB3LoEoowBYeYhzX0BDqHP6s=;
        b=OdxkIak8OHtXZ8+6vUuFXUSL5UBkfOcG49EDyXy136eRmDcEmIE0Mhhq2+OcYDka58
         9/PYkaTtEH7n+BaZzn9782MwnE+vGYViBqPU35gyi+yWrODbCc7FW+xdpRanRSxwC0of
         oXz9SAzvpX7dBGdXF/n/FsODgWAtGTmSBF51lmEJ2Ko+XlqIdpmwjOsNJkrpkg0KqxQ4
         7crGUOnNzXDHjy2QAXJYwGAaWxGUif/x7hJxnU5CPPEAP68L33kYSOl0m0Xe0M8F60Aq
         taCkRYd0KOJw+iUYzUw5AQcUYuRioE0ERmhAMAdKechXnz3UCnSlvLEzSxTdD+Hy5WGb
         Pr9Q==
X-Gm-Message-State: AN3rC/4w54aMWC25SigrkCntBxN2e2Dk6+gZXLHpbwjn1tmLxyrG0MIc
        jmJz7denAG+x8A==
X-Received: by 10.223.145.106 with SMTP id j97mr20172103wrj.129.1492505627979;
        Tue, 18 Apr 2017 01:53:47 -0700 (PDT)
Received: from [172.16.1.108] ([92.70.185.162])
        by smtp.gmail.com with ESMTPSA id b42sm17923931wra.10.2017.04.18.01.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 01:53:47 -0700 (PDT)
References: <20170409191107.20547-1-larsxschneider@gmail.com> <20170409191107.20547-5-larsxschneider@gmail.com> <a7fd3bef-49b2-0b0a-8ca4-89e41a402661@web.de> <388C3F2A-AC77-499F-9C74-216F5DC00FD8@gmail.com> <106c2be9-c558-edcc-2d97-5091c15010d1@web.de>
In-Reply-To: <106c2be9-c558-edcc-2d97-5091c15010d1@web.de>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=utf-8
Message-Id: <638E6914-6B66-4C66-996F-F04A285A2129@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net, e@80x24.org,
        ttaylorr@github.com
X-Mailer: iPhone Mail (14E304)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process protocol
Date:   Tue, 18 Apr 2017 10:53:45 +0200
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12. Apr 2017, at 06:37, Torsten B=C3=B6gershausen <tboegi@web.de> wrote=
:
>=20
> On 2017-04-11 21:50, Lars Schneider wrote:
>=20
> []
>>> packet:          git> command=3Dsmudge
>>> packet:          git> pathname=3Dpath/testfile.dat
>>> packet:          git> delay-id=3D1
>>> packet:          git> 0000
>>> packet:          git> CONTENT
>>> packet:          git> 0000
>>> packet:          git< status=3Ddelayed # this means: Git, please feed mo=
re
>>> packet:          git> 0000
>> Actually, this is how I implemented it first.
>>=20
>> However, I didn't like that because we associate a
>> pathname with a delay-id. If the filter does not
>> delay the item then we associate a different
>> pathname with the same delay-id in the next request.=20
>> Therefore I think it is better to present the delay-id=20
>> *only* to the filter if the item is actually delayed.
>>=20
>> I would be surprised if the extra round trip does impact
>> the performance in any meaningful way.
>>=20
>=20
> 2 spontanous remarks:
>=20
> - Git can simply use a counter which is incremented by each blob
>  that is send to the filter.
>  Regardless what the filter answers (delayed or not), simply increment a
>  counter. (or is this too simple and I miss something?)

I am not sure I understand what you mean. Do you want to say that the filter=
 just starts to delay items with an increasing counter by itself (first item=
 =3D 0, second item =3D 1, ...). That could work but I would prefer a more e=
xplicitly defined solution. The self counting implicit way could easily get c=
onfused/mixed up I think.


> - I was thinking that the filter code is written as either "never delay" o=
r
>  "always delay".
>  "Never delay" is the existing code.
>  What is your idea, when should a filter respond with delayed ?
>  My thinking was "always", silently assuming the more than one core can be=

>  used, so that blobs can be filtered in parallel.

In case of Git LFS I expect the filter to answer with "delay" if a network c=
all is required to fulfill the (smudge-) filter request.


>> We could do this but I think this would only complicate
>> the protocol. I expect the filter to spool results to the
>> disk or something.
>  Spooling things to disk was not part of my picture, to be honest.
>  This means additional execution time when a SSD is used, the chips
>  are more worn out...
>  There may be situations, where this is OK for some users (but not for oth=
ers)
>  How can we prevent Git from (over-) flooding the filter?

I don't think this is Git's responsibility. If the filter can't handle the d=
ata then I expect the filter to *not* ask Git for a delay.


>  The protocol response from the filter would be just "delayed", and the fi=
lter
>  would block Git, right ?
>  But, in any case, it would still be nice if Git would collect converted b=
lobs
>  from the filter, to free resource here.
>  This is more like the "streaming model", but on a higher level:
>  Send 4 blobs to the filter, collect the ready one, send the 5th blob to
>  the filter, collect the ready one, send the 6th blob to the filter, colle=
ct
>  ready one....

That sounds nice, but I don't think that it is necessary in this (first) ite=
ration. I think it is acceptable for the filter to spool data to disk.


> (Back to the roots)
> Which criteria do you have in mind: When should a filter process the blob
> and return it immediately, and when would it respond "delayed" ?

See above: it's up to the filter. In case of Git LFS: delay if a network cal=
l is required.

Thanks,
Lars=
