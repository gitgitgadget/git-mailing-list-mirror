Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F36C1BC23
	for <git@vger.kernel.org>; Mon, 20 May 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193487; cv=none; b=mNXdlRgUVO2sUj1mrff42e6aROylMID1vqhTMZw8B2RRDmMrNwiSdL3j4L9HB+tf1JpKBQSvFZCLldlxX4npkj/IEXLl5l8HedxVwfI2/F+JRhV3nfcETlcDRII0a1I2DJM1bPgtlAGWZDS5jV4FrFpdBpb+CV2Gs41199kO2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193487; c=relaxed/simple;
	bh=1jhoZBwyw2pfCKDOGYChoLb6QSG21msxkIb0ale3XlY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kidakISbxUMiw2FdENagvYkyRdWPDRL7VlAneNyaalgnq1hfyh3dyYSB0gj1ZNsrJm6j1WgTbE7PHQKNGEBU4fGqBOccMxWBSi9Er/GvTBIkzBKAFPwHRsW2EqoHVl6xSSvrXcEcJ0FkoTTEZiZ4LHELO+ZoxDoFO9nyTJfc4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CV8uQVPe; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CV8uQVPe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qCtSikXWyxC/xBvUk6+cy5i46aVGgHvOS4EwafNsurE=; t=1716193484; x=1716798284; 
	b=CV8uQVPeAuM1/snib+si16aVU8cMjUl/XvjjSp322LE1lu4lMHM17nOybA127l+lZGicUYD7/Ce
	+uOF/jxrEH02bM7ONt6w93Jq7mAdU3P65Jz3Ryd24bXzzPPXwQ1H3+qitXJGcml79RgF/IPnW9UZb
	Xop9hAWnrv/qPV7Dx8J7O4g+N+fuGfHaRSX0RN19kzJq803FoZtGv8AtASMq6ZNOOq0+OQ8DWspGN
	rpb/7W6Hs6cZpOx+MBcqkAs1UwM1ubUL6KhzpwbghB7u25kLPubrWUk5+CVuZS3tIQzIFHaWrr6Qs
	ZoeSHpUtS/fw9Qt4iVCVqIaNIkEm4TERO46g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s8yK2-00000003o8B-0lhk; Mon, 20 May 2024 10:24:42 +0200
Received: from dynamic-077-191-101-125.77.191.pool.telefonica.de ([77.191.101.125] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s8yK1-00000001B7B-49Zm; Mon, 20 May 2024 10:24:42 +0200
Message-ID: <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de>
Subject: Re: chainlint test failing on Linux sparc64
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Date: Mon, 20 May 2024 10:24:41 +0200
In-Reply-To: <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
References: 
	<8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
	 <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
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

Hi Eric,

On Mon, 2024-05-20 at 04:21 -0400, Eric Sunshine wrote:
> The thing failing here is chainlint's own self-test, which you don't
> actually need if you're merely building Git. You'd only care about
> chainlint (let alone its self-test) if you're modifying tests or
> creating new ones. You can bypass chainlint altogether by setting
> environment variable GIT_TEST_CHAIN_LINT=3D0.
>=20
> That said, chainlint is just a Perl script, and you can manually run
> the self-test like this:
>=20
>     cd t
>     make check-chainlint
>=20
> The output you posted is coming from this line in t/Makefile:
>=20
>     diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
>=20
> Based upon what you pasted, it looks like the "actual" file has no
> content. That might suggest a problem with this line which immediately
> precedes it:
>=20
>     $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
>         sed -e 's/^[1-9][0-9]* //' >'$(CHAINLINTTMP_SQ)'/actual && \
>=20
> "actual" might end up empty if the Perl script isn't emitting anything
> for some reason, or if `sed` isn't emitting anything. Presumably you
> have a working `sed` installed(?), but do you have Perl installed?

Thanks a lot for the elaborate answer!

I think the problem seems to be that the testsuite is not properly invoked
at all. When I run the testsuite with v2.37.7, all tests are run and pass,
but starting with v2.38.0, it only runs the chainlint test and exists.

I am trying to bisect this now.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
