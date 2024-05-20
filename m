Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2328E7
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221240; cv=none; b=EuXiP9EX8RleW+g03WhmhIOccX3E0sTnS4cXUBsTdK2pO6oaVD+vBm9tUTJM9DhD9ARVYR6YPV38PmYZLDPKfiX030dl/TWYfU3PO5Nfg2frdNaoFypS6ONdzOrM8Wj5hYRD8Qe9JURa9BEP7HBBNNosfIAKOsJ8UShW14bClUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221240; c=relaxed/simple;
	bh=d1LoASRgw7w6DnuxbnrucE8/R293WRD22ULp3umZscg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7NfbOGvlAZ+DmYopbABx9TvBvUWEUsxgX9P+B6sLfV4D5B1T3jrcKrDxnZWXNMJ+L/TFbxvSBFSw5YI6n/yk/bN56UkYkqwJdMYvQgbp/pfMc92thrnUAVCxHWmkvfKGU8Fw1FAh5qnASN8YS8TvYmnip7Uwq+bEiLDsjIZiN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Q60JTROH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Q60JTROH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bF/XkNeB3KFWtWOP+HG9Jr4viOfwlVwJQldz3e3vH9c=; t=1716221236; x=1716826036; 
	b=Q60JTROHEeOwA6WmQ9Lj2Eq+c4J692u/I4BbB2CMeQRu16vnzC2XzhrqnpfekZqTY1ERq7x73Z/
	amLyk4/6nygU0YlE/XDarMugZqDrrH0Zjfsexao3hFeLcd+6H45JqyfsiDIAntfCGcaRxiUzrlqYm
	2VS1aFN0eGNv0yxOEl4iBpmJ9LqWjiHRDSEVVibJCd/nhYd7f/ijoPVH4Oqjt1LOh+7lxaZ5ILPAl
	PsM8uuqYtAHc1ViT+l6gp+D2LAZ9oTfBPAK7qF461pclIogt4dEvveodDGg92oQ5SjACvkGY2WgaD
	6kSIrwaWhawB+Hs/3BP5jitpKjxq8i3mAisQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s95Xd-00000001BYH-3W3r; Mon, 20 May 2024 18:07:13 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s95Xd-0000000252O-2W6z; Mon, 20 May 2024 18:07:13 +0200
Message-ID: <001ecb0316534ea5e0fbfaecf0d020220b273210.camel@physik.fu-berlin.de>
Subject: Re: chainlint test failing on Linux sparc64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Date: Mon, 20 May 2024 18:07:13 +0200
In-Reply-To: <xmqq4jasmpv5.fsf@gitster.g>
References: 
	<8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
	 <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
	 <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
	 <bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de>
	 <CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
	 <CAPig+cQLsUTpjiZ_TXh2GJAS=tJScUWYxiuR87rtwdTu8H9PXw@mail.gmail.com>
	 <7acbd5c6c68bd7ba020e2d1cc457a8954fd6edf4.camel@physik.fu-berlin.de>
	 <46caaa2d204844cbe5625428ece5b2fe8656364b.camel@physik.fu-berlin.de>
	 <xmqq4jasmpv5.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2024-05-20 at 09:04 -0700, Junio C Hamano wrote:
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:
>=20
> > Hi Eric,
> > ...
> > In order to verify this theory, I made the following temporary change:
> >=20
> > diff --git a/t/chainlint.pl b/t/chainlint.pl
> > index 556ee91a15..63cac942ac 100755
> > --- a/t/chainlint.pl
> > +++ b/t/chainlint.pl
> > @@ -718,7 +718,7 @@ sub ncores {
> >         # Windows
> >         return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROC=
ESSORS});
> >         # Linux / MSYS2 / Cygwin / WSL
> > -       do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^proces=
sor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
> > +       do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^proces=
sor[\s\d]*:||^CPU[\d]*:/, <>)); } if -r '/proc/cpuinfo';
> >         # macOS & BSD
> >         return qx/sysctl -n hw.ncpu/ if $^O =3D~ /(?:^darwin$|bsd)/;
> >         return 1;
> >=20
> > and I confirm that this fixes the problem.
> >=20
> > Let me whip up a patch and post it here.
>=20
> Thanks for working so well together.  Very much appreciated.

Thanks for the praise! I very much enjoyed it.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
