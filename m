Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79866EC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjIGUVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbjIGUVM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:21:12 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CBF1BDC
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694118051; x=1694722851; i=l.s.r@web.de;
 bh=OzpN+rbHdKR2GZ9M3F6dXdArPKta51fnil5aT8WS3cc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HBsXXMFrzzRB6osUiW8lhCEPrQd/Ng5Lt5FEu0MEjbZsFRyHaYbx7DUtJ7O6/keUPMGMMVO
 Snp2iyoxVHrCpAUrWEBid61nkFCnEoPUZxJKtipDui3ZApsB6nKQjkPTNy2DALd1cTVI/OLNc
 W/xLu2vbpKa2gBQQc2FCp61FwQum93vl+szWRyCQPiDJcqt8GtyTho1NDYocVEZdvsOf9h2AH
 km7uoVVZfma9L2WywOJ/mfRH+xHDzQiFHWyh//eeBBWYO1su4ksQWak96ip1JMV8ntcT4wkIf
 5b6KS2oJkB4OP77TPGxvHGwKL5ldzn0MgWygcc2E77Lz0SwUY62g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.74]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgibW-1pzmUJ3LDw-00h7gk; Thu, 07
 Sep 2023 22:20:51 +0200
Message-ID: <9c3c935f-6661-e763-9036-f86c03f6267f@web.de>
Date:   Thu, 7 Sep 2023 22:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 10/10] parse-options: mark unused parameters in noop
 callback
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212220.GJ949469@coredump.intra.peff.net>
 <3bf1bd4a-9d28-32c1-7838-09acd2c85d03@web.de>
 <20230905070948.GD199565@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230905070948.GD199565@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJgqBXxOQ7FueSDKnjVlkuTk3ZvRgz3DZsTCaWHpSduqaCbOqP+
 /lrSYjbYoh+YvodWy1lXa7Nrv24iH6fl2sufeLVsyGB05ZClVdGECZI6UNZOo8UHydBPUMI
 E+nskbDqwqpG0lJhgunUKonJeJlX2/GgYaezaT635X93LAcq1bB2HaZKAJasT7sa6U1nrIa
 TLxlY7eOXvJ006zKjQvpQ==
UI-OutboundReport: notjunk:1;M01:P0:eL2Qm7UBLlw=;OeX63xo+DtWYGtUX+x1b4pc8FlN
 Zgva7gB1h44Wod0z3QACtYdfjXva21qxUUb30HZEbfF2zVYCO1sUaJeQuGB5BH679f/IJXFEk
 wF337tpSrIQuG/Iu/VOtjFtAZ5UXZouABlOKSm83+/4GKknmtenELyzgWi549Zts1lnlclmL5
 cwcOGL0iswoNyb8MIKul4ngKEl49mR6IcWMHVBqRoHZkWlfeLGEZRLeoOluryTmgNLupeey1B
 ag4DluK0fM662osOBH1gdRkUB91KvUS5cWHEkabe5Jg/+I27fSmyQDQoLTPc/3D+tU0aUYzXl
 3VP/zRAXPMZiR+WK5ZsZjIXb94+X+IdcEBHPFxFDIrY1IdFLgrQQPmftaX2D+O75GIGORzKnr
 kfdcWI+ZzaNkDA0/hT/kljTJ1rvNbQvmDzxureI1gTvQGQfgPP/nShS2r3Vf8y9Gb0ubXjjWo
 o1kubmo3wLw5/ukj7UjoA8e+D3kQ2dfcxpLQCbDCSRNnE0xdX4tzr/5K/e09FQWA575RKOIkS
 JnwU8zJiQVbMJLnFhiv6LMfoxtPEInu4+0x07D3I0mfgn3hK6N8K8JuplQf5xLM9jc9Cvsqmq
 6ZuRlLjMgkzmpNtfF/Ty7s+gJM4ANQXjGLPFVgmBAaFZAsnuJBnxNQ+VnOsV9c66a+ZCRzjMC
 YvtkVWSJDMmvidrTeNDLTY7Oqh8kPlkMCYo+asMOlcT7WMgv5p1iRbHOVNGV2NTNJhHqhaalG
 Fo9nt2iJoEHFe41FaiuDUJeZet4mJkPs5cb26RPAQcQfWj+reGfiX5enWV0xLn9xfgYzodcVx
 U689tbUc/zXq+Gu+llAIuBD8GYbL/i5nW7JC36PxAGh3tcBiGR5ZwNpbXfxdhy6SszYNZBqEg
 JgzAhw6Haxe9o6tZNHEEzTptMfhzADHVx1WlC0NgAH9dayA9qmwho+fI/uFW/ee/5qZniUKSZ
 QVDsZw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.23 um 09:09 schrieb Jeff King:
>
> Your patch looks correct to me. I probably wouldn't have bothered to
> write it, but now you did. :) My inclination would be to go with my
> dumb-simple one for this series,

Fair enough.

> and it looks like you may have
> collected a few slight-more-risky-but-maybe-worthwhile parseopt cleanups
> on top that could make their own series.

Well, my aim is more to simplify and improve type safety, but I get
carried away a bit at times.

Ren=C3=A9
