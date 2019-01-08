Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBCD1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 14:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfAHOTc (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 09:19:32 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40271 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727662AbfAHOTc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Jan 2019 09:19:32 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 730DC220A4;
        Tue,  8 Jan 2019 09:19:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 08 Jan 2019 09:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=mesmtp; bh=iS+uv0BM8V2u7zPxRIsQaAfN
        QyREP9ot8RixQE9mJr8=; b=xSNVGTXVi7BsmtlOHIoqdcvlIZOM0ksMGo2yXrq0
        tbhirBrOXkfTBnEzQufxpRgL9q+bGzna91KUKm+lvX2CAuRyxHNzRw+YzoagLCRq
        gL/FjatqvLH2s+tXmCYkpWLnhSeb2OX81ckNX3aFwpxqtRXcJZwkQZCPjm5gakx0
        JQo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iS+uv0
        BM8V2u7zPxRIsQaAfNQyREP9ot8RixQE9mJr8=; b=BuDB6q1lnDbMHjwQLaLybQ
        Anep7v+1dBLNpYexAZGIh3UeMAvJpWETLq9YqA3YBnhyxBGZtC2lBQE/lXL0X5+P
        ZKtqJKAY6tzpiinXHFdoXZ+9yr8WihnO6NB/PAU9a7ru0jG+K3nr1UQqWc+808Jo
        dlPmjz8FyiB5qA79JQfIPFLbn/SIbn1UUZVdfz9N0r/aoe5L39UtUHtHl0DPhXn1
        rFZj0E/+JkKBRSO8qQmSEi2uzcs5MUDPfZswhU8uYMbrssfzwNeS1BnXbjEPmjRM
        jNY2+XbHkL6WMKj11vU6PnCnsySdGUc5Rn1Gs7shQbmt/eZVHxE9CeooUeJrJK4g
        ==
X-ME-Sender: <xms:crE0XEUOkiWmx6tqa2zUuKxRDRbF16qAtPg6XQovcpVU8dw6gjkQFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrvdelgdeiudculddtuddrgedtkedrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehgtd
    erredtredvnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdr
    ihhsqeenucfkphepkedurddukeejrddvvdegrddufedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehhihesrghlhihsshgrrdhishenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:crE0XGhZ14vFZTXt15GitBRUSZ46lnmd5Er_gdJcVUqaSXP23g2FWw>
    <xmx:crE0XKvCVZjFrnzGXK5GNe8LCfoHDjB-SD9M8rjhGzD3K-AvhCMf2g>
    <xmx:crE0XH7f0PFp4hooHqpxxbdWFUxBHM_qz80keWU8DP7NOmRH6E1hUw>
    <xmx:c7E0XBgl1Gf1Zc0R2p22y5ICLmysVCQKSK07NYULOOWEy6aW69qwKw>
Received: from localhost (130.224.187.81.in-addr.arpa [81.187.224.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 58DE5E4598;
        Tue,  8 Jan 2019 09:19:30 -0500 (EST)
Date:   Tue, 8 Jan 2019 14:19:27 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Recovering from a "detached from" HEAD
Message-ID: <20190108141927.a4q5fqug3ymkh5v3@x220>
References: <20190107161748.pyhgpewymdgjmgoh@x220>
 <xmqq8szw8d8o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqhff5rw7otmx6ff"
Content-Disposition: inline
In-Reply-To: <xmqq8szw8d8o.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bqhff5rw7otmx6ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> The commit the message shows is meant to indicate where your unnamed
> branch diverged at named branches.  Immediately after moving to the
> unnamed branch by detaching the HEAD, the message says "at"; the
> HEAD is pointing directly at the tip of the then-current branch and
> that is where the tip of the unnamed branch is.  You can tell from
> that message that you will not lose any commit if you were to check
> out a named branch from that state.
>
> After you make a commit on the unnamed branch, you have something to
> lose if you were to check out a named branch from that state, as the
> detached HEAD is the _only_ thing these new commits you built on top
> of the fork point.  Upon seeing "HEAD detached from 9745ede235", you
> could do "git log 9745ede235.." and see what you would end up losing
> if you were to switch to another branch without saving them first to
> a named branch.

Thank you for the detailed explanation. I was for some reason under the
impression that "git status" would show the current HEAD, rather than
where it was detached. Why I thought that, I don't know.

--bqhff5rw7otmx6ff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYJiwim6S7nrCK5qc2f/n8MS4v1AFAlw0sW4ACgkQ2f/n8MS4
v1Ar3w//QXxIaI5Ph5fZXjKUT3JnkEy/b5L6l8Bx6goh51nPIkZTYeRv1q36NO3J
s92TlhUa6BCzHw/8luOvhCaEN423jy+Tjq0KVdU7QVH7lTTblw4UqHe1tmPP/iwo
W99Nk3Vd1mGuCFgv+kqnWaPbF4if4WNCt138FvZTvLig5/ejdbKlpfWlbyoqD/Di
mRJpOtx3VxmWmzqTbuWDqSj696B9ZVeGof5JVIbPtKAtDAcg+td+Xt24+lSZlAWO
P19kvWbMdGgDXSKhdIHyno6C1zS4WdFtLWaf1FkY+fu5IWNPss9W8NGO31dcmNx9
cSAGtD5fDX3E9kBhj4Jf1Laxr53NPR8jVFPeHhQfnohdOGHynzXls33xiW2Z0TEx
BaqHZIPwNW+9fYQOjdnJpbfh36j5RqfvpnUUd4OtEoZNxqAmcuz2vMP9MqOHwylC
6h15nHnwf3390dXdlaDjyeaml0eLYhL1P5EthI6g+bToaFj9BSmH1kSS04KRuxID
jSxyxqD18YOHRlJ7arkebVzDF5ef3GA2nbxgmUZxpAUQ5+utEqiGujvpRrSA3kQz
Y8i6pazHWc10Zlgi0HiaB4RHkwwUvCje0OvFvoaPG8EAllCSSe2/qcOBeBerGVyp
ViUuKwB7WgRw3e6/SGvcjYEIb7KVZy41CAObkiBWtSdj7AiMdNo=
=vnRh
-----END PGP SIGNATURE-----

--bqhff5rw7otmx6ff--
