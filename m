Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D1C1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 02:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeH3Gaq (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 02:30:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbeH3Gaq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Aug 2018 02:30:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 082BD60428;
        Thu, 30 Aug 2018 02:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535596255;
        bh=9uTlflniNzpWkD433ID1PKj39FCGrC7e2fOGZ0uKnq8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ngxvhh6/IrPyCLdoSt7PQtC4umMiCeU07ymiaB+0XsebC9CNqGnsuZ3LyQxr7MhlP
         l+BkdxrKFXv19TXG3o7d7SZCXhJxDCs4kJJCVcO7k40a21f0Nu2gH6JQBxiihEi65E
         sMRiwK2cb3by4o/h8RIVHfFixfP3xCUpWgam245H/ZOtoxn+XaIc4T6Mq7cSFwI01k
         Y4RY6Ep0CHdn5sPLebx9JeMdEbUxLUM1G7BUAZ+POoiWU/YsF5b1Uo8jpZ/gkA9nHG
         IX43Qz2t/a3s9yXbgU8h7kiHRxx+oOf1VP4FLXlz9c0SCFXeKsfkeqqayAEMVoAH6a
         Tvv04PfCzmf3PMtmz/y2WoBfvc9EgFHhHs+cX6GZMgrm4Uxnpklu+Q3ryiDChX3zbX
         YsIpjuWznxznYLdMersIAsrsL3cSABRfZNV0/89HWCN117QhdD65Usa83CvVj5bp07
         UfskJh/i+6GusrZJ0dbN+r59aEPUyO8JGGWPK/wFMKKwZByvSvn
Date:   Thu, 30 Aug 2018 02:30:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 08/12] commit-graph: convert to using the_hash_algo
Message-ID: <20180830023050.GJ432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
 <20180829005857.980820-9-sandals@crustytoothpaste.net>
 <ef3f5ff2-a774-9e9b-d73a-b21630bede53@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MMMIZFJzhAsRj/+"
Content-Disposition: inline
In-Reply-To: <ef3f5ff2-a774-9e9b-d73a-b21630bede53@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3MMMIZFJzhAsRj/+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 08:41:36AM -0400, Derrick Stolee wrote:
> On 8/28/2018 8:58 PM, brian m. carlson wrote:
> > Instead of using hard-coded constants for object sizes, use
> > the_hash_algo to look them up.  In addition, use a function call to look
> > up the object ID version and produce the correct value.
>=20
> The C code in this patch looks good to me. The only issue is that I predi=
ct
> failure in the 'git commit-graph verify' tests in t5318-commit-graph.sh.
> Squashing in this commit should help (assuming that test_oid works, it
> doesn't at my current branch):

Yeah, this is a separate series not based on the other one.  If I
finally submit this after the other series lands, I'll squash that
change in.

Thanks for the patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3MMMIZFJzhAsRj/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluHVtoACgkQv1NdgR9S
9osULQ/7BaaVaP/4Y7lFXAUhsrwGUyC3/CKc7wXBuVbCQeLBVt8yjMWw5P4aUz4X
tXIUk56WuoFKsFXUXdGSrIDCrGgQyz6o+7N92o1/0BenXM8vTcZFOH+9x1nWyqW/
aIgz3pM5M8C+0XcikQ3osX/VrAuLurjRbfa/slPWNsPtvT+n+4KIQVTf+Yq0HOnp
scqbxTPf70a9kgLzIpoRZdnzam4y0ULepKv++OLRwNrspJIhCIYrNuRnBNDJPi1s
rUcb/f6Z8JLDBjwGovP+fP8STmujPMRNLxzwkQB9kXeEqAHCMIR4Z0ngdyWtUJQ3
riNRpWKcY6fd5CqALJOGYzMFNHBy+PtGB9C9oZdchFm+5bFjY/DUGO7oyMQ8V+pW
o6aWzkJsgIWfFYlz2VbAqHHS9Z42cLIKOPWTCWLoAvl/icAosscXF5TI1V8ClFVP
XQoNm9dGV7QRSv463n2JfJ+KDtwuiL3+/s40yd8xDfL+aWnR29Al525CTg/uSfM1
DPqjqHO5ltE/qTTBb9DQXykbdqR0uUhfxtERoSpIjgCcszLx1RjSLHvyZroK+QZn
RtH8ArzbHRZTuj5sJFfHed8bQ9U3XExy4zBwqwZFXmGsWmy+j9KkMlTAt7uGyV1Q
2ADJsaaLRUdaivws4AJQGmxe0LLtvvjr+biJl1xIrZzH7cEf8nI=
=91hR
-----END PGP SIGNATURE-----

--3MMMIZFJzhAsRj/+--
