Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C532A20954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdKVQWm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:22:42 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:40723 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdKVQWm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:22:42 -0500
Received: by mail-wm0-f41.google.com with SMTP id b189so11339964wmd.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=irrTXkYfozpujQw5aNVvWBQXPYPRkbUaznHIBjhef0o=;
        b=TEedi0IWLlko770A5DiBKMBvAG7KkCvofAdKcfIMTu/CEPG4MYQtEerU+4v0Hkhg5A
         IFfk3CgyBOBHBfZPq9ADdaGPXWmRJOOed4s4RuOt0IDbaJ4iZrblSaFmCoEQPNLbQ91E
         50edl4SlLTRy7pd8Oz1MQuiVXBNHA3/1oybZEZQGRyzeThS0ODlH0yZcqdKIiIiTiVk+
         x5PnDR+YuGYXhoAPncHy+5lCyxZ8lpFOCj8SGXaHPItaKB45xcrr33DbHsEyvK9xaBxc
         MRprkF8vfq1xrAS82IeDKJvkfIohTtKitRhMro6lZQ8EUDyTO9ClPwT/LlwSMZUlPWE8
         +V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=irrTXkYfozpujQw5aNVvWBQXPYPRkbUaznHIBjhef0o=;
        b=smKxVLw0mZqbkht/0RR6SQq34d3ErUpEe2qRPxNFWSC5aVyRdm2OfTZg1iih2qkwy+
         RcO3aprNr0Yg1tF1jTbmXjX0lR82FxOT9OOnquxY3SmkZ74YxoT+G2XGbfqAd7dyveDZ
         okP/B8G1uob8l1np6qtAekGhOp6avMb8lXPWnBlGQzLWMEEJSI+yNoUE+lYhJcGQjVwM
         ZwmTIKLPZkEyoG4DkhblJzxBhO6FNBr4QcBrkZkvVwNZeTfYL4HMpAG9PB+L2V8FetEc
         gbcT7TRuhqSL8DsaDGPmDAjxtcT9hhHcQeZvol1xU+2WXHBfXc+tfuZVmfFwDgqA9RtZ
         yukA==
X-Gm-Message-State: AJaThX4kKS5m0B1rhiPw4UngQzWN5uCi7zeGG3yVftfUxI1z1/8EXqeo
        EESVGNq/fA3g4QYsu3sUJFNBxA==
X-Google-Smtp-Source: AGs4zMbKCxd5F262FCPLtOAtDGvNUFb5zhwLkeRuSIV3gBBwme8d+eCV/1fkYt72PVzPYEJtWcwVfQ==
X-Received: by 10.28.132.19 with SMTP id g19mr4431468wmd.90.1511367760913;
        Wed, 22 Nov 2017 08:22:40 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-144.NATPOOL.NYU.EDU. [216.165.95.144])
        by smtp.gmail.com with ESMTPSA id 80sm3709634wmk.14.2017.11.22.08.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 08:22:40 -0800 (PST)
Date:   Wed, 22 Nov 2017 11:24:06 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Nathan Neulinger <nneul@neulinger.org>
Cc:     git@vger.kernel.org
Subject: Re: git status always modifies index?
Message-ID: <20171122162405.rr2uyggfv3xj4bqb@LykOS.localdomain>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ziexfnr477kxvibi"
Content-Disposition: inline
In-Reply-To: <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ziexfnr477kxvibi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ah, my bad. I missed this patch...

Good luck!
-Santiago.

--ziexfnr477kxvibi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAloVpKMACgkQRo8SLOgW
IpWlQw/9HvZP1I03ma3SxXvPX3whVb2Bkd3zEDpBWSW1Oq2XDs3WzAfrnzsYMxvq
1Xs6VvIi6MfO+9NJ1Cqnq0J8H/cTOqmj0PmrIOTbRBrJylwa4RXGXiohn2G73XUF
REKJjKJXgHmEsdsyB8TQgfN3QymfyiXZUKp+xVf0+OzrzWCBGF2v4ww8SvuvO6FM
2U3ZdKodXpyQWP8Xrzs9sg1S2uzi52OywJ8wT3apRW/3VN9quaAEsVw/B2U4p0t4
NWus4txYiRi04qmJF9N7o+0F53Fe9XCzoo5FX44M4aTpx/czLx97tAszWMpEUo4H
DnfdrRgggbAGPJxQVJGZb4CfDV5Rpyt7AGi9uqiCTvex7S/Mo5XhOCqhfKx+QYu/
54zOWHj2qTL6LgNeKMccYK8FWL6Ni7W7ku7lfnN6KvogRsZxTaGkSThSnBim6izC
eC2MNMzsJj3TxrbFouHXmoCOl3dYCuRUUJIpUPN+L7EwEnVnFUAYg+lYcROmGh6o
OnUrDprnpRLGXIcwOGBJu9A3k4z8/1E0F5RmLbkbNiK1dMUq+qK9odnn6rUw1JLu
mpxYAnBRjUuwUCSjE9opL96RiRb7Z1KyojdPbdQhU/S7cgApq32v/YgzG52lAsh0
7kSkmNo+QMyZqptarVuzzrbWErO+Mo9+kuA+YqX7DwkgK5m2Vcg=
=YsNU
-----END PGP SIGNATURE-----

--ziexfnr477kxvibi--
