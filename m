Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B924B4A
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379648; cv=none; b=oh7WwvDQZi528FsX6P7Xv0H+20bZtz8+XUwYmTM0m+xKWt2v/MftAogXGNnCwtH5d64Fc3CJK3JZ64Pc4Zemp2pHdU7Oo3vLJ7JAenpgXWAmVyMd/v6m0NwDubJFoxsPGtT27nN8k/7cg9VS65kjxII8co/pASeutwYZZY1ZDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379648; c=relaxed/simple;
	bh=9OpyxrY6t2qz2oGXyPAVAxVR5pxGq4SRPWPWDMEw8vY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uwCsE5eXJQEva9ZCpBbT0TjYE1/Mq+4ZGHhDAmRxP6hG4v4ze7XXuOW11eKct5qZAo44ktr/wjuaoU/FNmpMbqUPBWG3wo9t0wIJIZbkHr2EPoYfCqHv+GXW/SpoYUEbWMdzyWSxzXOCehfnNiYBkeK+CFkPZtGcPYN8a0Rnjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name; spf=pass smtp.mailfrom=spwhitton.name; dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b=eN6k0nYD; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=VUWGwwAe; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spwhitton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spwhitton.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spwhitton.name header.i=@spwhitton.name header.b="eN6k0nYD";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="VUWGwwAe"
DKIM-Signature: a=rsa-sha256; b=eN6k0nYD2D/8qDV28Ptj5qrJwU3huWAomkBwMG773tuGTiPepURtJRI5WLJFVcxCNeTsrQsxOUXCDMzsw358KBxAakS62SuFu4e8miIwufyFLLJVOCd6hpJGAb995I+w4dMhyk4zyhvjilww04PFeKsCH8P93wRz9om2G75FUKeA5YnOTP6tEfmB9672Sj1/zbbRm7zk9P5tJoDoIU6ZXvUOOhh1GvKpmDbZNTyGaemB+p6ApW0WndfBS+/Jz53cYoy/+72LFGXg4M8oFVwpZ2UIptE6tnXjpW1ciGuApxndOWe8UPvBbKNx+MdKChgQGLFJbwk/UuU+JTh92N6ERA==; s=purelymail2; d=spwhitton.name; v=1; bh=9OpyxrY6t2qz2oGXyPAVAxVR5pxGq4SRPWPWDMEw8vY=; h=Received:Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=VUWGwwAe1qNtAMuUafyQFTX5CMbrIOWkJvLFIZgk5v47PGJZsowmrjNnA1l7Sj7xO4tEW+P6uWpzwvEf2t8IiYcbBbTZN+qZzjfdiiWPxzukTkJ0nrTVrHbhaVYHnf6vt0n2Wp9xEilHXNIcO0m50RwWjvmsk6qhgWMIZT56pKb8A92aTcL/1bnEGQ9IhwXSEivwp6Ay5keir5bN3hlyycitS6tcouUiKG2ul/CgyjJUNSMH3zYjt1SteqMtPZfCCR0fbV3xeCnCOXYszia4tVst3+JsRy9rfXVw+0I41mgu+dZ0n2nu6cJPvJAtiWAhbPvFRy1ucwfgGeG+8ROqQw==; s=purelymail2; d=purelymail.com; v=1; bh=9OpyxrY6t2qz2oGXyPAVAxVR5pxGq4SRPWPWDMEw8vY=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 20115:3760:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 674298715;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 23 Aug 2024 02:20:24 +0000 (UTC)
Received: by melete.silentflame.com (Postfix, from userid 1000)
	id D4EB17E0A5B; Fri, 23 Aug 2024 10:20:20 +0800 (CST)
From: Sean Whitton <spwhitton@spwhitton.name>
To: Simon Richter <sjr@debian.org>
Cc: git@vger.kernel.org,  debian-devel@lists.debian.org
Subject: Re: Representing Debian Metadata in Git
In-Reply-To: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org> (Simon
	Richter's message of "Tue, 20 Aug 2024 16:10:34 +0900")
References: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org>
Date: Fri, 23 Aug 2024 10:20:19 +0800
Message-ID: <874j7cou8s.fsf@melete.silentflame.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I think that more than you realise of this already exists :)

On Tue 20 Aug 2024 at 04:10pm +09, Simon Richter wrote:

> From a requirements perspective, I'd like to be able to
>
>  - express patches as commits:
>    - allow cherry-picking upstream commits as Debian patches
>    - allow cherry-picking Debian patches for upstream submission

git-debrebase and git-dpm already achieve this.

>  - express filter steps for generating the upstream archive(s) from a tre=
e=E2=80=91ish
>   and some metadata

Excluded-Files in d/copyright is for this.
I guess that you disprefer that because it's part of the tree, though.

>  - store upstream signatures inside Git

Well, there's signatures on their tags.

>  - keep a history of patches, including patches applied to previously rel=
eased
>   packages

This is already there with git-debrebase and git-dpm, though it is a bit
fiddly to dig it out.

=2D-=20
Sean Whitton

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCgA3FiEEm5FwB64DDjbk/CSLaVt65L8GYkAFAmbH8eMZHHNwd2hpdHRv
bkBzcHdoaXR0b24ubmFtZQAKCRBpW3rkvwZiQJ1CEACNcSelg9bt9m1/Hkp9TFJn
RjexekGK+MIX7qn5JSoVQgshZLmd01C6mAGIsh4d0CmdT17Ajp+kJSFnaEYiRHcl
g1LESSuSNc7xC7tP1N3V/yEic6TWN+sL/GBw18AxITRvW/JvpVdpLKCsuJbWnpZv
gu+ev2yiHFMCFFPVBAR5vyFt5m/ora4VcRK41Z5mlXf2jedlH/q5QtERPHMFD/Ko
KGwmFMrPMlfZh07aBs5ZgpRg+5VrSxgCWXKOjVIjc11PpYUmcNAyIozAoj4jbbfi
z8SOB3zSEThE1vrM39QMk1snLFagD6BAvtoKaJRRy+owr4jr7CZ7KK35AyNTJwNl
X6I//CzpaJk39TeEQaMUzBWABqpBZ5ORzTUGKdg1HovTQgrJ8j0JMg7qym1SC7o0
gJEj9B7LHacInnm2/JgOR1H2cpJB7offDnZUDxjlcGCG3z0VOxvwkg4+q603T/6v
HRZoJxtILf0BBClb+ptMlblzQtaFW0TC49CwvI2MEza09fsBuHYfLM+XjZ/MYDov
HsyZusjsEmbjq2NWxycnyv1zNCi4Pd431XZDJvrw9i/cXVV0XkdYM6dpnkHzjG1o
HhTFvtH+3bI46KivURr8yUaqxCaKAXTXDsxmGwjOB+WHmVTTKrUMpVzpg8o2jhtR
1JiO8bQFpf480aToR2MLLA==
=G1yo
-----END PGP SIGNATURE-----
--=-=-=--
