Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68DDE55A
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648280; cv=none; b=b/Rtt/vrIv9K+yO0L9lHZYYhmY4QRUNvKxdd1xOs+jyYCfW3GBy2yHUcRdAS7JH8UThGMaamcuBz+SPyUxK270dMl9F102PuKPGjo6om6s1a7Qca83xBtSppCsEbl8rJeKu4PeijCJyXhh+YEBb8tg1dXpiWJVoiueUr8cNNlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648280; c=relaxed/simple;
	bh=d4CIL9nOYLjHWmeNNgPjQCDCES06XIUWHKkUQ9mU/lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3/ELPdXu6l6VUm3F/uKuH5TO0e/WXAc3xXli2kBGHfVbS0BeyNI2BmN0XVeQW5iBvo1Rz1tWX2KZZYd39clvGdx6hd7hp9G+4m3v4RmRC1eNbHfaUrrTPl8cCyg+NoTJBunMRcWdFnBGElbC4vdgdDeE1y7eG9xSWGWHzaWlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=T8Pr34Lt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="T8Pr34Lt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1774648271;
	bh=d4CIL9nOYLjHWmeNNgPjQCDCES06XIUWHKkUQ9mU/lI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=T8Pr34LtRypnXqxeSFVuLgckCU96CPIMvtIoN2PeMikTBVrmma698UU2OuUP8BB8i
	 akwIkrzrMyEFFMvomterehf/WD3AzJlTlzSylO2ejyheLTrrLgZo3IvAL3g2INzjUx
	 9HCfyLe+vVCFrKT2xlkP/J1ac1ELgDPzOHjqeAQuRbReufFrh/v85zfpRa4l4qFWrc
	 YNnlH6Z7ijPhW2oR1OpU5EthFHX15b/4cNI9Rd5m7vo3msEGhJpanzzT1RVIS405kT
	 mfg0eqQiPI9+nQC+6smZYlcN/ibwgMVVPokzzGQR5XUx5d4P6Hh//YXv+6R2uffjpm
	 jieQVZATFZsIJnp5rCpXTDTGuKPXIZBBJyYbNihxFRIsJ8lfmhOzxRbq8S6XjJ0FXP
	 N5jNkKTpCV99j5G6i2K6V5Pjlh+rtt8BpIaDHXU6oyks5OswQ9ggclfvfUDQS2+rwj
	 IR5iPaqNHIMEGv9JjnENdM6P7/JMtabkwQPlKo8vZ9YbFAf9uhx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:31c6:2b0b:94a9:e348])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 23A122011B;
	Fri, 27 Mar 2026 21:51:11 +0000 (UTC)
Date: Fri, 27 Mar 2026 21:51:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Wesley Schwengle <wesleys@opperschaap.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
Message-ID: <acb7zRGLkQUSIZkU@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Wesley Schwengle <wesleys@opperschaap.net>, git@vger.kernel.org
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
 <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org>
 <xmqqbjg9mex2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cy6tjqSbRw3qXc7x"
Content-Disposition: inline
In-Reply-To: <xmqqbjg9mex2.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--cy6tjqSbRw3qXc7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-27 at 16:10:33, Junio C Hamano wrote:
> I somehow thought that this practice is so widespread that it was
> one of the few first things any new people learn to do, but perhaps
> we do not have a good documentation coverage?

I actually added this to the Git FAQ:
https://git-scm.com/docs/gitfaq#multiple-accounts-ssh.  It was added
because I saw the question a lot online but we never documented how to
do this.

Certainly we might want to improve the documentation (patches welcome),
but I would not honestly say we have bad documentation coverage here.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--cy6tjqSbRw3qXc7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnG+80JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzrl7Le5JwG+jLYU09k++meBaILjmD4g4L9P+wj+X1we
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKcZAP42Cusnx/C91rqZtdIFi3n9Q5HY
LBy/w1bJ0S1VoUyxTwEAzoy906US/CHeSW4b/wYiikk6yDLRy94Ldix7L8H7vAA=
=TJmi
-----END PGP SIGNATURE-----

--cy6tjqSbRw3qXc7x--
