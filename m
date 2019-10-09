Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298891F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 15:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfJIP3D (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 11:29:03 -0400
Received: from kitenet.net ([66.228.36.95]:42158 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbfJIP3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 11:29:03 -0400
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1570634931; bh=eiMKMcnV0mbQQAjVMd7BUVS6CSJ28HNhUOarXMbYHJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwXLVgCUqUCj7mEY1JdOf1Yb9MgBxRTJDmGHqmGODTX1+1JhsaxD4pZSkA/6Bbmic
         z3Zj8QjY2I6R8JIIn135wYfzsqDQC4Dr3qUn/qY2iO4gi4vRDNkM2tlA6cJsTGWcUJ
         Gifq5EYHFg9HHXiXEJN7QS6iS0qYM9Y2bsgFEK5U=
Date:   Wed, 9 Oct 2019 11:28:51 -0400
From:   Joey Hess <id@joeyh.name>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: git cat-file --batch surprising carriage return behavior
Message-ID: <20191009152851.GC19679@kitenet.net>
References: <20191008192257.GA16870@kitenet.net>
 <20191008200050.GA26453@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <20191008200050.GA26453@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> If we just add a new "-z", that's less disruptive_and_ easier to use.

Agreed.=20

> I suspect it's not entirely sufficient for clean input, though. You're
> not feeding filenames but rather full "object names". I wouldn't be
> surprised if we mis-parse "$rev:$path" when $path has "@{}" or similar
> in it.

Nothing I've tried along the lines of "HEAD:{yesterday}" has misparsed
the part after the colon as anything but a filename.

The one I can think of where there's a parse ambiguity is that while
:foo gets file foo, :1:foo does not get file "1:foo". Instead it's
treated as a stage number. Using either HEAD:1:foo or :./1:foo
will avoid that ambiguity.

--=20
see shy jo

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAl2d/LMACgkQ2xLbD/Bf
jzg/8g//bF45ltdmJNmwXRaJdZjhtCpKnusL+xqbaVQGgN3MIpHltWMp7ka/N0HY
KIw9A6/BczWxy0+en+jM42/5Oo46qTvnhyop3+7nVJJ2uFrL1VBMvBp92oEUTRdq
Z6wBXIdv2XhAmlWnH9SAaF1x4nni6hjnN7C0EjwHKCez0iDG36y3RpKWPJ8uhLkF
92invHu5SzDqcntYZTFP7u6lTeHKLelS2pii2RUiKpJleMnylwpjMOrUjEyiX4lq
1Hd5W1rAjNqpILa6g42D7K336kG6PhLtFEDSe1b9zbFy3A9iRJs2I0BhSNS0bCOA
uQ38teqe1QtqJskdwpudGDQXqWAt43ig4wDJkMWg3Cu5aoNRYN7W5qNjfPtkqQK2
7fnFsRw2Yi+lbiQy+hiOOQNILfm20TNfvYI0hPlv0viiMue6U27FaRD5+OQpPa1v
RPWM0F1VISu+//wkTjvmWLjbMRx5RlJQ55IVW0IAdKnyRqgnfBjIwyST+ePsYkt3
J95MZb70nWfPpS0cruRqZjA8bDjcfyMlAtWZI9vHwbzpZkxP+yXq6TenC1vxeRdI
lOiIkoPEvOUhgqVThbo1T69S9exi5yrJaEUxurLpXfeX5m9ia3Nff/tTcm2RFAlJ
t5jRW+iP3tk/tfvQ0bsB5kgclKe3hbBUXooIu/GQThpw5mQM5Kw=
=3yYF
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
