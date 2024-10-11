Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9D1863F
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621925; cv=none; b=j/utvd/F+SUOkb2+b1MsE2ge5X1c88ar2H3vXyijzDC9dUc8xafdcTY+ksItNTw9NUsaSv7gh0VkAJeGn5rH0kDcyf/PL1lv9Z2GaKNIiQ5zAkdgpoZF0idScMZOku9ROkWZ03UMXuSXsMW9IusrFy7bxDKxD+vh7AQmJK+srfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621925; c=relaxed/simple;
	bh=z+f51KoswhLPNknYi7Yg4pEp1XRkQ8jhXIlRvVNTuE4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCIDqvQxAZvJNUDT7/evEqypGYagHHuj+3spOwfV8EcDl+mEZ2NeqkVvk6nYPSQUzAZljgZVRh/Vrny7EwL9mxBaRb/UOapVe1oF276RMYg5jMaIdTNQjIe/HM64owrTl5HtVaHqe+SekwRvCVi4ookQcorwIrQY3eapjYH9aqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=UDSeKJ8z; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="UDSeKJ8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728621906; x=1729226706; i=tboegi@web.de;
	bh=veA0VwUxSaltcQqx+iksKsxWZXXxbZeQouG8DBEVprU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UDSeKJ8zY6PxrJTPj6E9sr0LfRG1ATDlLlIYD7UlyEjcNnuZfHZJG5bGnLAkq8mE
	 4hRNCX2rk0SAiFare9MjpOeDHycthok+q0bl1u0Mvd1THxTR9L0BxAtkA7rH7QTle
	 1GhEQirpL/HVB9gtAQa/oOgZqMrQlvVgJF4QU6e8ag8LWzAwGH4tw6q5EDhnLCb2B
	 9dOL8fd2Fz6/a+LmBNGUq3Yj0c0iqapXv7FF7yZ8KEK/D6gJqAMt1IgZKI+/JMqfK
	 vxJO/R0LW3Du8d27etXOp/Pe9gezYf+nRcDEnuP6iE0JK6Sxt51QU+ZGQQ/S5+3eo
	 iEtmoV3yalMp9IZu3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28WT-1sxBaC3mcj-004GB1; Fri, 11
 Oct 2024 06:45:05 +0200
Date: Fri, 11 Oct 2024 06:45:05 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Spencer Fretwell <spencer.fretwell@gmail.com>, git@vger.kernel.org
Subject: Re: Verbose Commit Ignore Line Fails via CRLF Line Endings
Message-ID: <20241011044505.GA1764@tb-raspi4>
References: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
 <CABa71BwtEWS79CZwPOa_Nrh1iMrXRo+hyxNBc5F8GsQiwjdapw@mail.gmail.com>
 <ZwWDd1_76Z6zH4mP@tapette.crustytoothpaste.net>
 <CABa71By0WYkbNip6-hmcX2jH1GuHWEx=WBTda5=RV9koR-cVFg@mail.gmail.com>
 <ZwWNgc6JY46bmcjE@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwWNgc6JY46bmcjE@tapette.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:XADyDDZnFD3BF/Y+4FW32EJQdPPBVGa1Axc5T1I8Y2gyqgaO8x8
 Fgh++U34J96QgqHogMCpHAQDSvCRVYl3dxNdxvj9K90QIAEosv7jbPeLPxqBO6DMUSHmcwx
 aeKdB0rwAF1SxWbErmPeNZ5i5Wgkz01yvIX7lb2vzfAZ/1Hx/EqBS6hnyJWtKhJEhWWyM4b
 JBKg3GmRg1AipLC2G9C8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nRK4VHLQ9XU=;laVBxe2lfJR09+OJEs+pxZWy9mt
 2jaiuBjo1IuFjli7JdENj83FJSDO5kR7erVitADIyHNceNvEtoMSajDZ1A/fWMTPGRgdmGdrX
 B6hE2QjzjlHPRqZwrRo1oEz+CVR8KsC+q0m49RlMrccm+laQ0qk9ZSC7117RnLP/YxMAIscuQ
 ufxsDtvpag4SROmHNmRQFf05PlK3Xmzv3x3S1I2IbqfSv45+bj0OSLWCyMIcs2QuflYnWwHTt
 CXFlBi0hf3Mmo8QGXWti8z2LEq6Ulod7YkeyERZahJ+XW8SaKF+XMxhNX6C33pAYyOylJqzFX
 TKDASr3eVHi2xzxZi2S8LBMjH+Htvsp7H3AGf3gSF3tVcDH34Npqn19tf1Pq407kbpbDIyZDv
 ikSKfvsx9WzNWQx+sM7/rGKdaBWdNF80mILJvb4wTFUEGZUrXE+YMfeHoLBTBcMpFl/cXrtFs
 Ex2RAocRIqgXits0ESx1cZdR/Zay4PCfEjR7GVEC+SxWPB5EW0V1nxhe3zW+8PiNg86ysxW+Y
 Cib8TVK5yATdUx61+wHsoOAI5/M/L8Zw7XH7gb2W5K2xYllzyV1+ggU87Zk+1O/qjtqpB5Jc4
 tO3eU6avoJbip2+CURouci6lope3v73Hgt/0CYRmdirGi9iAXDvPKN8/cAZW3WtLGVRD1de08
 AwcbFH2lLEOTmXm5MOU5QHxwFIUdWxQswaH+MX1t/HZuMKSAX7ALqQngD3li3PwS7ruUbXT5m
 azAR1X4FlnV90sJL4A7gfTmq+tYYRPBPyVKkmC0vuVX6jDot24CZHEjmvIL2V4huwr/6LldEr
 3akx0gLbMMCcHk6GwKD1uBsw==
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 07:52:33PM +0000, brian m. carlson wrote:
> On 2024-10-08 at 19:34:46, Spencer Fretwell wrote:
> > Thanks Brian,
> >
> > It appears sublime auto-normalizes endings to "whatever occurs most
> > frequently in the first 32kB". So, I guess it was witnessing the CRLF
> > from the verbose output and replacing all lines with CRLF. Thanks for
> > the reminder about --renormalize.
> >
> > Is there any chance for git to support a CRLF magic ignore line,
> > particularly considering the variation in standard line ending across
> > different platforms? I tried autocrlf=3Dinput as well and it sadly
> > doesn't normalize the commit message file itself. Either way (magic
> > ignore with CRLF or normalizing line endings in the commit message),
> > would be appreciated for mixed line ending workflows (especially
> > considering WSL)
>
> The answer is essentially that I don't know.  We typically make
> decisions on whether we'll accept features when we see the patch.  My
> guess is that, assuming someone (maybe you) sends a patch, it will
> probably be accepted, since I wouldn't expect it would be very difficult
> to do or have major impacts on the code.  It might, as with any patch,
> take a couple of rounds, though.
>
> I use Linux or rarely other Unix systems and always use LF endings, so I
> don't plan to send a patch since this doesn't affect me, but assuming
> the patch looked reasonable, I don't see myself having an objection to
> it.

Hej Spencer,

you are probably the first one reporting this, thanks for doing so.

I have the suspicion, that your repo has files commit with CRLF,
and that leads to a CRLF entering the diff, and that leads your
editor to produce CRLF in the commit-message.

In order to debug this a little bit, can you run a
git ls-files --eol | grep i/crlf
in your repo ?

In general, when working with cross-platform, or only with windows,
it is a good practice to use a .gitattributes file to specify the
line endings.
Do you have such a file in your repo, and is it commited ?



