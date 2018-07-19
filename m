Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF4C1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeGSWa0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:30:26 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33221 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbeGSWa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:30:26 -0400
Received: by mail-wr1-f52.google.com with SMTP id g6-v6so9445422wrp.0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Utix0/+f/eEQK8BjMAFOlAAsGlNhuvnMFW9j+To2nj8=;
        b=QfmXC2OziI4wuOQLsEfp21XgEmP+7G1pHPsq6vI2YK1mErhXKZwBMKQ29Mt92jPph/
         wv0ZkDRWXjDvKTZBbz7mMDwW8XnBp4Uv71EntuNEcpkCB95uT0gUZAuXoXqKsIxX80TI
         25wb9atGClIt9PjSMr6Bv9ZhbO859gsyjRBwfCG3tEi50kSLdHmFpGWsx56kKYUN9TV4
         xXRyWVpCsOPtwOy7nLqO6yNtq2on/sBLE5r77UJ2hpUq+1HwEWVUtxDqQiILrNqA938U
         +Xrz4X/aDuksESCXwoG4VQfcj5yjo2NitfAkefoXSl9G2ARJDzdjq4KkE1UN0LpOaluH
         7kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Utix0/+f/eEQK8BjMAFOlAAsGlNhuvnMFW9j+To2nj8=;
        b=UBzeKOyzNmoXrWKUDSzF6BgX0VKMylTZTnujpsR+MgS+QvmMflLbgWK7UKnJUzRjI8
         Fv6e6eR6FjiblvmZaYgWhaVYqZbZKDAEnM49WPKkL+3SZkO85GSZkrP0YQFmma8MhHI2
         yeNaQ0E9GANy4XfLX1u9D/StLDTMPVV9uz2Xefli4hG5NEmM7OqSeTIYVn/J3ZHU7YjL
         bdmf/u9JrnNyoJCHM8ON2anL6jQ7XR59ZydAKz59GNPvcLO7OFGDHs8GHvRfAGrKQeI4
         ArdfKS6Ih+4niBLKfhwQF/tXxxXZmuTQ7Qowfg80rj3SZi7zMk8T91dST3ASSjHDjiZr
         I+ZA==
X-Gm-Message-State: AOUpUlHm6GJqu3NMCQvg/VyxnUgIRxY8Cye1jxkz55COetBcIOtTUOmm
        4RKnwiPhJLWHVcVHuCXA4zPcENdM
X-Google-Smtp-Source: AAOMgpedW4EikOGkr09+JGn8/uVtH0fGKMmhv40snnnOh+EgCpYicOmpZ9DDfFqdBvZZZCpiidEfow==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr8315644wrt.71.1532036725081;
        Thu, 19 Jul 2018 14:45:25 -0700 (PDT)
Received: from larsbook.fritz.box (p5DDB4D1C.dip0.t-ipconnect.de. [93.219.77.28])
        by smtp.gmail.com with ESMTPSA id b10-v6sm156600wrp.49.2018.07.19.14.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 14:45:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Find commit that referenced a blob first
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kbJnyRbeH8yMa=QaqNofA_Ek_SwmH5qRaCaq4cyQ26Kqg@mail.gmail.com>
Date:   Thu, 19 Jul 2018 23:45:23 +0200
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        primetheus@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E632E745-03C6-4C7F-9B3F-CB46C0D7FCA7@gmail.com>
References: <C00CED1F-D685-40E5-A5CC-4040BFD82886@gmail.com>
 <CAGZ79kbJnyRbeH8yMa=QaqNofA_Ek_SwmH5qRaCaq4cyQ26Kqg@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Jul 19, 2018, at 11:19 PM, Stefan Beller <sbeller@google.com> =
wrote:
>=20
> On Thu, Jul 19, 2018 at 2:02 PM Lars Schneider =
<larsxschneider@gmail.com> wrote:
>>=20
>> Hi,
>>=20
>> I have a blob hash and I would like to know what commit referenced
>> this blob first in a given Git repo.
>=20
> git describe <blob>
>=20
> If the given object refers to a blob, it will be described as
> <commit-ish>:<path>,
> such that the blob can be found at <path> in the <commit-ish>, which =
itself
> describes the first commit in which this blob occurs in a reverse
> revision walk from HEAD.
>=20
> Since
> 644eb60bd01 (builtin/describe.c: describe a blob, 2017-11-15)
> (included first in 2.16.0
>=20
> You're welcome,
> Stefan

Awesome! Thank you very much :-)

- Lars=
