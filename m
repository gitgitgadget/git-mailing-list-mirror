Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162F34BA47
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758356707; cv=pass; b=NT4XrSzNlu9+2HPFbQ7+UVOzhM5hfLjfhgF4bVZonWgNbD00UjrVZhnNj1WI0cewaIdFvJsODR8B5ch0Ep4c9v8oaZvrdFQliCNx96IIJaSizDKPvoWZo61VPwBxVsUTEYFG7nZDS2THdMVH8PG0TXNotj3659kY52hKewDimLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758356707; c=relaxed/simple;
	bh=zOyGO40Egsow13jajKEErhXSsAeZHutnE0dlaxlmoV0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h3wkhOttM61zUVle8+0yF2dihirx+Re4koEJXhOx2xOAqKOb7LlmcYEn7G2d1ob06Pz0DZZiVIDyen04NvSX+vV0x6y6bORU8BAj7oZ0jGJnfvx9T750Pc0qTqOOQTM56APEdECNyX1t6tH2Jl77fjOT+/C9sKNIjAZebDZ7fwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=florianmaerkl.de; spf=none smtp.mailfrom=florianmaerkl.de; dkim=pass (2048-bit key) header.d=florianmaerkl.de header.i=@florianmaerkl.de header.b=IqS8nnso; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=florianmaerkl.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=florianmaerkl.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=florianmaerkl.de header.i=@florianmaerkl.de header.b="IqS8nnso"
ARC-Seal: i=1; a=rsa-sha256; t=1758356683; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gPHjAoTQ1dd7GCeNmI0nd8o6udvGG0Eqzli9QM9b/olc/6l8IrOV6YbTzQybgjvYAZ
    +FTHUHsscilscxEpC5GvQRNu6UgIYZ+8v4G4odS5Qj7g+90iIhMBjm3hH7/O+U3l2V07
    WFDed9pJEYhlmMSSYp6KwLCJJiaEhfJbkVscvMnzxZKHpAouY5VN2cgI7gOT2kPfefWH
    plvCeLvnCgRtmo2SbW4pPqbnYk/xmtDXaTksHmYarw0goP2VtGTKnJsqe7PbBGCcPCXq
    8YREkjoOLOqsutTPwNx7qMSJTC8hg5VIU6OphMMxj5Ye/l0GVm1DXiam5Fm/F6MSspTl
    FN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758356683;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=zOyGO40Egsow13jajKEErhXSsAeZHutnE0dlaxlmoV0=;
    b=DB2FYIjdQQ8qSRGskTcybbMJRZLPhstbw5yVKKmMk0nayKSQGQPzRn6Hvoh1eMWAw2
    22pqYPO+dYiawwD3vgIDgsMdrZbPT9lK9zhnzWLWijhGnuUnSMtM1PFskE2wMUnz6nNl
    0/1R8dtCBnLvjNHct42fd+4fJYZX1ikyO91kwKFsqyhdC7PQwGY19ThniZaUoc8FDhmF
    A17QS0nquNJdXWIBi1AP8J03OaGxWJivOHL/mxGicKOFvyyWQ3AWcTl2uoKJYOTeysGn
    xfdD+J3+jaaoNMz9TJ2VW/C1j+4m0QTEi2lOfQPD8y4WOiX1djVKPgAziYSh38NHiIyG
    IDMA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758356683;
    s=strato-dkim-0002; d=florianmaerkl.de;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=zOyGO40Egsow13jajKEErhXSsAeZHutnE0dlaxlmoV0=;
    b=IqS8nnsoA89KBuDA4FPjf9Nn33wuN7LU6WjxmTdTgUxR/oy6gYSccWVmx67tQzrrE3
    dJW0LnboPsspLuVClHL5sOrfNj+VhEHokl7FqlOkDDwxuQSM7WOUBGtjxgpnqmRVxUUD
    zFdN78EtvJmggbWoQtWp+fkC/rs5UaltTEVDPiqT1cb2azTlnCEPMBuv/7m8tMQztIxt
    ddbw6aUl4K6BMsRfK7+W93bptyUy+hDist0kLxmlaf2vZQkGzrpnBis7mZ+aLO2uAMrW
    xmGOUXZyWIQzEaHCQlQvOVt6/SJKRe2zldwP+W/aLimLSdrI2nwLgaGE7UsnyxXfnue/
    /y7Q==
X-RZG-AUTH: ":JWICemCud/DxHoRx2yg49oX0O/FjOgMCY83ji5SkI9B9AAtJgnUUXiwnUKWxDhLInxJKiw=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 52.1.2 DYNA|AUTH)
    with ESMTPSA id h2873618K8OgpGu
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sat, 20 Sep 2025 10:24:42 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
From: =?utf-8?Q?Florian_M=C3=A4rkl?= <info@florianmaerkl.de>
In-Reply-To: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
Date: Sat, 20 Sep 2025 10:24:32 +0200
Cc: 20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
 ps@pks.im,
 Johannes.Schindelin@gmx.de,
 ben.knoble@gmail.com,
 cb@256bit.org,
 collin.funk1@gmail.com,
 contact@hacktivis.me,
 eschwartz@gentoo.org,
 git@vger.kernel.org,
 gitster@pobox.com,
 me@ttaylorr.com,
 newren@gmail.com,
 phillip.wood123@gmail.com,
 pierre-emmanuel.patry@embecosm.com,
 sam@gentoo.org,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2D395CF-ED37-4D96-8C0A-683638FF2058@florianmaerkl.de>
References: <4C760AB2-C102-43A3-B0B9-11E248F3FCE0@macos-powerpc.org>
 <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)


> Ezekiel Newren <ezekielnewren@gmail.com> wrote:
>=20
> I'd like to hear what OSes
> and Architectures you use personally and professionally and why adding
> Rust would be a bad idea.

To add some specific cases from my side as well, problematic platforms =
include
Mac OS X on ppc as well as OpenBSD/macppc (32-bit). Both of these are =
still
relevant, as OpenBSD is actively maintained on this architecture and Mac =
OS X
10.5 is supported by MacPorts, resulting in a system with modern tools =
that is
still able to run and debug certain legacy software.

In particular, in the Rizin project, we use both platforms regularly to =
test
our code for architecture and OS-specific bugs, and we also support them =
to run
Rizin itself for debugging and analyzing software there.

I do not advocate not adopting Rust because of the language itself, but =
I think
it is important to compare the maturity of the compiler and ecosystem to =
the
project that will strictly depend on it.=
