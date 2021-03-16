Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2297C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0EA65009
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhCPEik (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 00:38:40 -0400
Received: from mail.archlinux.org ([95.216.189.61]:58216 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCPEiN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 00:38:13 -0400
To:     Jonathan Nieder <jrnieder@gmail.com>, Drew DeVault <sir@cmpwn.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1615869492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EA1C97Lx2gR21nZ139+snmDVxkLTTiXaa0aWJ3QS/Vc=;
        b=cl3JmLlqdLiStMkbT6RQVYKvtb9Bl0BhkC+J5bMmdlE8pzDP0Cz9rEI7UhqSNqJTInNCI+
        JVWkT+6MVse8N9bEbkaEfpJH+VTMzlpsef4cu/5muKxZ//ziZlOJtXWEy8hwe6NS5v0tp/
        dS4K+g8kF9DrlziTtkFt/SG2v6YBuge2/O/kE/EI+lfC1AijHuZvDCr4Mxfej2dQuPFZ1X
        osim8TDTxYDxM+NBMXFnQPFdM1ziqSFG9G9KZgTIxGiY1w7ba1mOpq3v6s2WtzQDbmWYDf
        s6+GNj9YBcZjUs3c5HBL1X0SzxQtTdclR14lpkSgNjtbFrAtebcVvIHhVyIO45ltba/hIs
        hQ06QGVtVc3khyiKVqymn4w/S8AVz65BGCEHcsAd76cHOlGfhgAIu69D5Zi0MCwkWlIZ89
        GoX//6rM1skpms6kxLd4TD2/iUl+5EZdQ9343ranWrCgoCqoD7MNjjvxJ9KA80/u2+g4d6
        aBXAMODXUo33mE1EUT/VmXWf+kCoEq8kDtcvophyA0ETJ7eugiP3vk2YikYNKnrRJYqQwy
        EwTcVkV63WbZcxOWpqbrRZWwa2ef4E5jYAchRcY0oYT8tHcI2/OHufCS5bJi/GnMM+5WSn
        eOGxcyhSvlDnIdvo0fgbwYy7HswB0PSA6u7lkVGoOYgY10dF8qZO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1615869492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EA1C97Lx2gR21nZ139+snmDVxkLTTiXaa0aWJ3QS/Vc=;
        b=CjAg+W8QMFIzxmdh0is3IHYzfKoP9RW1Sxz5YzGv3yJ7Oah7BN+8ZmyWQcFHeIFCtHYJ5P
        igfkM0aRuqjitxDQ==
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
From:   Eli Schwartz <eschwartz@archlinux.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
Date:   Tue, 16 Mar 2021 00:38:08 -0400
MIME-Version: 1.0
In-Reply-To: <YFADuptwV7iR76g5@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2fJ9hO339t8yeYfFAGWglkyjsQf2kUVWW"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2fJ9hO339t8yeYfFAGWglkyjsQf2kUVWW
Content-Type: multipart/mixed; boundary="yBDxmPh3KcUz7cEOld8rP8B6oQveWy70g";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Jonathan Nieder <jrnieder@gmail.com>, Drew DeVault <sir@cmpwn.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Message-ID: <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
In-Reply-To: <YFADuptwV7iR76g5@google.com>

--yBDxmPh3KcUz7cEOld8rP8B6oQveWy70g
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

On 3/15/21 9:02 PM, Jonathan Nieder wrote:
> Drew DeVault wrote:
>> On Mon Mar 15, 2021 at 6:01 PM EDT, brian m. carlson wrote:
>=20
>>> So I don't think this is a thing we can do, simply because in general=

>>> URLs aren't suitable for sharing this kind of information.
>>
>> That's simply not true. They are quite capable at this task, and are
>> fulfilling this duty for a wide varitety of applications today.
>>
>> I don't really understand the disconnect here. No, URLs are not magic,=

>> but they are perfectly sufficient for this use-case.
>=20
> I'm not sure it's a disconnect; instead, it just looks like we
> disagree.  That said, with more details about the use case it might be
> possible to sway me in another direction.
>=20
> To maintain the URI analogy: the URI does not tell me the content-type
> of what I can access from there.  Until I know that content-type, I
> may not know what the best tool is to access it.

This is a pretty odd argument. Drew is recommending that the URI
"git+https://" tells a person the right tool to obtain the resource ("do
I use curl/wget, or git clone"), and now you're arguing that that it is
somehow insufficient because "git+https://" doesn't tell the person
which media viewer application is best suited to display the contents
after it's been downloaded and no longer has an associated URI at all
(but does exchange that particular variety of metadata for a mimetype).

Why does this even matter? Again, the point here is the assertion by
Drew that, for the purpose of listing a manifest of remotely fetchable
resources, he sees a benefit to having some standard format for the URI
itself, describing how it's intended to be fetched.

- ftp:// -> use the `ftp` tool
- scp:// -> use the `scp` tool
- http:// -> use the `wget` tool
- git+http:// -> use the `git` tool

But instead of needing every program with a git integration to
reimplement "recognize git+http and do substring prefix removal before
passing to git", the suggestion is for git to do this.

There is definitely a (strange) disconnect here.

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User


--yBDxmPh3KcUz7cEOld8rP8B6oQveWy70g--

--2fJ9hO339t8yeYfFAGWglkyjsQf2kUVWW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmBQNjEACgkQzrFn77Vy
K9ZYJBAA2p877qdQ6tm+zzjtozKN5wqTHuTzojlwztG6hdMih34TfrTa091asCTN
USnGqEuoFZLidsnZm66221rgY5H/pGek/i3MGws5GRfxac3PyGI0Stwr0Et4qJik
EdIyXPdBJUo0JUVLAbx8l3QcKakS6HFbwMZ/AP4P6vhOMh1kpusLOvkrGznoOkS0
Nk7Cfgn6Ery5WsLOFY9fK29iJiceyz6qsdkwRBPDcVmG020wsDNgnPl537Zqthwn
svFXGPrAN0qbh6OCzcDJKVi1TkRmiNU7tZg/aVgMJ0vHncNLcqCrHbQk0nB+WnHF
e9ZLEh9KeXME708iGYz9eheRGrZO1OAw7iTZcT4vSglpMGGdU+QAXjki5tqBlNcZ
NomT02CUyD+gJN4EGr1SZ/JzSv40PimBvTiCObDCZKFgZWVFvjd1DXYlgVS07Rnr
sSYCLDCyBY0zUWOivl8zOjo1fnznUtaa3jsT9SQ+GtWPkChPqHdgUoEd8SYB7TDo
8flPhsk+6IrcinOL+g1Ktmx3ZsoaGIj1BkmrhN0xgIrSnw4GKXu++QpByjRADF7I
ypjNfihJn0zx+8AXCs9+mPzKtRcWcVYOnOaIIZCICrOIcmZ1UUAkER9PgBXYTKhL
hFKLRem8wAjLWT4eelwGuFCqXqUgKRx/1ZriU6LxrgNFjNTHrUc=
=SvoG
-----END PGP SIGNATURE-----

--2fJ9hO339t8yeYfFAGWglkyjsQf2kUVWW--
