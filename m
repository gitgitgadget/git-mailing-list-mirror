Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31091F406
	for <e@80x24.org>; Thu, 17 May 2018 00:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeEQAoE (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 20:44:04 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:37133 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbeEQAoD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 20:44:03 -0400
Received: by mail-pl0-f42.google.com with SMTP id w19-v6so1413658plq.4
        for <git@vger.kernel.org>; Wed, 16 May 2018 17:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iNI3bih+niv6jbmoIocVWQQEzsrQ+SGDUvHbpSMWuxg=;
        b=gr4tPC8scDkvLm5O+2e5KdaToAd9SyyzILQtqcnzzJZ/AuVXb9Sd/zddZXJgh5//wD
         YS0+Riavcc8HVEQR4CQ+7VD7EZUFN5oxKALsMVh/a90Gl0z2m9QxsV6p/wQPDnW530D6
         yBeBNNDwUxCxIXvIRoVt2NBDCNuk/X1YJidwajCT2DNpoQN9yS5g91OUFbhhY1mi982K
         22dttP2XXwpLDJV87hEXz5i/JC++5KypAdNWGSqw8LqTSrcRzEN3Uyh/I15AAdxwhPiI
         ZlvdByMXRluFxOzfuC1OSb8UndkOkCtmtMujUMPLSRspGz39UJO0mO4RsMqX7h+Raxt8
         PqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iNI3bih+niv6jbmoIocVWQQEzsrQ+SGDUvHbpSMWuxg=;
        b=f6khC60+ivbXvXn/uHffYweFMD4QOKpC3iCkcLvvjNMssanjN2kWwJFazwAA2lODYG
         LlvkeYvCvWWXNWQaeDPZc9rr+nBxu7OjTiEpY9/g4KkoNgDVuDpcESv3i6GFy8G2fTJV
         MXemcmI5X1mexbm8sse7HxQNmfwVnmllmZNSvf+bK1KjS9GyevC3s1rVjBejC7OP2HNJ
         ZaZYHMZeaGvKLjeRgxBGmOxqrx0pujyyakWxCBrDiq/NxdetGno3R17mC1xkU9cT6OC1
         3iJ1NnJtiDQMYnBFgZKZydsmdZ5wZkxh9gvHC10gk/5oNkq8hX8PlC0p/PUwTbB+OEw8
         jntA==
X-Gm-Message-State: ALKqPwdpgvROPyiqxT6ViZ+rHarKLHWX0jLIc6EUSy8xraTKZUNgdIfq
        rTlcDoS/YohorFuoadRuAI8=
X-Google-Smtp-Source: AB8JxZrT0MlX+YHwBmxIcOtFCLP1Le2iJOJBOlHt0q9yoqCLMBuItalP9ZhVU3RWCpkqCSkn+GdTMQ==
X-Received: by 2002:a17:902:5ac1:: with SMTP id g1-v6mr3056196plm.43.1526517842909;
        Wed, 16 May 2018 17:44:02 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([103.208.62.210])
        by smtp.gmail.com with ESMTPSA id e10-v6sm6083935pfb.136.2018.05.16.17.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 17:44:01 -0700 (PDT)
Date:   Thu, 17 May 2018 06:13:55 +0530
From:   Sitaram Chamarty <sitaramc@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180517004355.GA9431@sita-lt.atc.tcs.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <20180516192343.GB3417@sigill.intra.peff.net>
 <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
 <20180516193744.GA4036@sigill.intra.peff.net>
 <5156717b-6fc9-b792-dfa4-1ba48ac50333@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <5156717b-6fc9-b792-dfa4-1ba48ac50333@linuxfoundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 04:02:53PM -0400, Konstantin Ryabitsev wrote:
> On 05/16/18 15:37, Jeff King wrote:
> > Yes, that's pretty close to what we do at GitHub. Before doing any
> > repacking in the mother repo, we actually do the equivalent of:
> >=20
> >   git fetch --prune ../$id.git +refs/*:refs/remotes/$id/*
> >   git repack -Adl
> >=20
> > from each child to pick up any new objects to de-duplicate (our "mother"
> > repos are not real repos at all, but just big shared-object stores).
>=20
> Yes, I keep thinking of doing the same, too -- instead of using
> torvalds/linux.git for alternates, have an internal repo where objects
> from all forks are stored. This conversation may finally give me the
> shove I've been needing to poke at this. :)

I may have missed a few of the earlier messages, but in the last
20 or so in this thread, I did not see namespaces mentioned by
anyone. (I.e., apologies if it was addressed and discarded
earlier!)

I was under the impression that, as long as "read" access need
not be controlled (Konstantin's situation, at least, and maybe
Peff's too, for public repos), namespaces are a good way to
create and manage that "mother repo".

Is that not true anymore?  Mind, I have not actually used them
in anger anywhere, so I could be missing some really big point
here.

sitaram

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEVgraZHVCgW9BLliRpEKQhQiCN6UFAlr80EsACgkQpEKQhQiC
N6XFZg//a8Jf/U7tjWOBsDQ9izTGvLpNyvDhWLTfFmGpP64uL86YlCuKRGZEGMAi
M1sXPDYEWu7Bp2Gwh8wfeNym8Tztjm0OsalcwGjeWR+AY1TbwEqeMDzsWIE/cKju
8Od139VuKZO6NDftc1goLuoHCzirKJ3zs/mdk1AuCS0oNQqp+zRVY63x/uGPYi2L
Vmcfbbk+IxAPbIkLXZexd2UZ6ifrHpS/bsUkSf6q6u/YHulEQrE3+H/bP2+vipu5
CTNt3okDi8sFbc5XoqDQlYgQyqhgvnmcJTj6nXb3DlcJCpbg5bdgXyRC7EAKHl6y
MT14JAr0X2nJ9sS7oJl3wy31stUcZf+jNMUGgUgifjOK4dAyCGp28mhiOVKa8SKj
7cCk0iF0YtCbZ8SiFXrUzG4wdtjG+0vllEhSH/4wwzBfq42koqFxt97rIpFIEYNR
p2eT4aod8/jzq7naAqNHn/2HDQh7zcuIEOUCwnLBNxihvUeNWL4yWpkQKqnTd+Ak
r+LmEIg8LmwqaQQPY13Va87++MQ+F84L2qPZ3a+2IWJn6xV1YWhfkAWlqQ1w/U6g
+7T3MmDNfN1f/+h5Yqox7sUMGXDXs1wrXraPT+xIypdcjZHexpN0XPHat9wk5Ota
zaPwzpdik3PvbmzvKInb8xuL4zGLIZSHE7Pbc40vyf2M0UYWvEg=
=YiMo
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
