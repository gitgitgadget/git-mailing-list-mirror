Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707E17BA5
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.142.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732819988; cv=none; b=EhluXgTsUBgENboP91Gkzl2lRQLxlyZ28N5CoBDjfJAC1pptbMclTazgH3XAhYbMERe7v7hvZfsZB1yJlVNrpmjvyXzsPnEESvVLG90T0+FpIwC3i4GYuBkQMdo8BNHtPun0cP2GO1vc55nu07x0ugBcJ4ISTzepyBNfOnerAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732819988; c=relaxed/simple;
	bh=qZJ0r8WEK+a89NUnbDwISOP+NRaKtVZItUhrd1gAQnQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABY4tq9kGMiHh9G+5+AX1IBf4w4PpYbf12v/DYxqW5kk+gEW4tSgQAcQIglHaFtJZLnIE6g0dLjttQPAmdofABwA2DApJcRpWhaP17GofXBiJgeVRvD+IQylWtN1qEgAsICAO5BgiDWDRqCuW8IzfCxoBIhtYT5GJUK3HmeYpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org; spf=pass smtp.mailfrom=aegee.org; dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b=beiXcPr8; arc=none smtp.client-ip=144.76.142.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aegee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aegee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aegee.org header.i=dkim+MSA-ssl@aegee.org header.b="beiXcPr8"
Authentication-Results: mail.aegee.org/4ASIqt9b1729488; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
	t=1732819975; i=dkim+MSA-ssl@aegee.org;
	bh=qZJ0r8WEK+a89NUnbDwISOP+NRaKtVZItUhrd1gAQnQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=beiXcPr8/3zEJOLD1WYEPYjc2dyP3JG2x3HE2v4V3t1QV++ye/ZkAHMj0yEedp5oL
	 KyoxnF4TfPlhrDxjaA5+riem4nXqk3NPnMYb3ARRnIf7rTLt9vIzEdtyrFUAW1iLCF
	 k0Drcyb7fFRSUh7P1D5QwP2TziXCP2II7yMf9VWck9QaHiDqemw6JjctfHU2qMW4Uy
	 BFhvbpluPWAIkF0Po3lMA+KWREvZPIJwOxFcOXhVgia8O7ariCTAjmGa/m7C+OzkNT
	 YQClxKpXBKKnMg+d6GOWbYJso5T7qrR3riIduTtoTR4MVKqIdMoUm8JHK03UXx4aOR
	 QORLh6pAshE0vFBabrliE/suTB+Tdz+84YCCxcZBpWe7pVBIUAVp0F73nN4o8Y+eul
	 MYiBP0s4sTfhoGjRh2IGrjuacxtap6rwBLErsUOX2iD6RJyGafOL6n1SodHmB/ZKKp
	 7yOg8Wkl0FS3rK6N1O4So67ya3IzsJ5oU9p4edAck9oqvM6jOZFrufqlgIdcwyF1Gn
	 cW1Qp19SSjYuTXxFiIxWoHzgJ8lG3hGY79YF1u0ZqYoSY6ADDu1LC5m8RtNaCvur1Y
	 +KXnVtcCDTe36Yv25nFagyd5SwOb4nBhsx3ghmDorkc2eHfALnjyIaB3do7ITvQldY
	 85FKtyVpEh2kRM9xyV4SXkK8=
Authentication-Results: mail.aegee.org/4ASIqt9b1729488; dkim=none
Received: from [192.168.0.100] (ip-046-223-162-065.um13.pools.vodafone-ip.de [46.223.162.65])
	(authenticated bits=0)
	by mail.aegee.org (8.18.1/8.18.1) with ESMTPSA id 4ASIqt9b1729488
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 28 Nov 2024 18:52:55 GMT
Message-ID: <580342884c7b59f74f29ce1b824ffcb096113ee7.camel@aegee.org>
Subject: Re: Building git with =?UTF-8?Q?=2Fbin=2Fsh=E2=87=94dash?= produces
 suboptimal GIT-CFLAGS file
From: =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
 =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?=
	 <dilyan.palauzov@aegee.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Date: Thu, 28 Nov 2024 19:52:55 +0100
In-Reply-To: <Z0inflH-gQbZwNCX@tapette.crustytoothpaste.net>
References: <b4ef94b2a0294c338d115fee68e0c31e44dad3b9.camel@aegee.org>
	 <Z0inflH-gQbZwNCX@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.55.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

echo U\"\\\"U > out

puts in out=20

U"\"U

under bash, and=20

U""U

with dash.  Every time I report to=C2=A0dash@vger.kernel.org that something=
 is broken, e.g. because it behaves differently in dash from bash, the answ=
er is that both behaviours are allowed by POSIX, echo is not portable and s=
hould not be used.  git=E2=80=99s Makefile does  echo "$$FLAGS" >GIT-CFLAGS=
 so I am not going to report this to dash.

Greetings
  =D0=94=D0=B8=D0=BB=D1=8F=D0=BD

-----Original Message-----
From: brian m. carlson <sandals@crustytoothpaste.net>
To: =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=
=BE=D0=B2 <dilyan.palauzov@aegee.org>
Cc: git@vger.kernel.org
Subject: Re: Building git with /bin/sh=E2=87=94dash produces suboptimal GIT=
-CFLAGS file
Date: 28/11/24 18:25:18

On 2024-11-28 at 13:53:21, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=
=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 wrote:
> Hello,
>=20
> when /bin/sh is bash, target GIT-CFLAGS: FORCE in Makefile puts in the fi=
le GIT-CFLAGS the content
>=20
> gcc:=C2=A0 -g -O2=C2=A0 -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" =
-DUSE_LIBPCRE2 -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEN=
D -DSUPPORTS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_IN=
IT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"git-compat-uti=
l.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA2=
56_BLK=C2=A0 -DHAVE_PATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GE=
TTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-
> DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DS=
HELL_PATH=3D'"/bin/sh"':
>=20
> when /bin/sh is dash (b3e38ad), the same file GIT-CFLAGS contains
>=20
> gcc:=C2=A0 -g -O2=C2=A0 -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D""x86_64"" -D=
USE_LIBPCRE2 -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND =
-DSUPPORTS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT=
_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D""git-compat-util.h=
"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D""git-compat-util.h"" -DSHA256_BLK=
=C2=A0 -DHAVE_PATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME =
-DHAVE_CLOCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-
> DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DS=
HELL_PATH=3D'"/bin/sh"':
>=20
> Note the differences in the -DGIT_HOST_CPU, -DSHA1DC_CUSTOM_INCLUDE_SHA1_=
C values.=C2=A0 Because of the differences, in Makefile:3150=C2=A0=C2=A0 if=
 test x"$$FLAGS" !=3D x"`cat GIT-CFLAGS 2>/dev/null`" ; then=C2=A0 always s=
ucceeds, prints =E2=80=9C* new build flags=E2=80=9D and every run of make s=
tarts rebuilding daemon.o.=C2=A0 So the empty build is not empty.

I don't see this on Debian unstable's 0.5.12-9, so I'd say that this is
likely a dash bug upstream, probably a regression, and I'd suggest you
report it to them.=C2=A0 I don't see any reason that the Makefile should be
doing anything incorrect here after some inspection.

I've noted, looking at the upstream Git repository, that (unlike zsh)
there's no testsuite, so perhaps this is the kind of thing that could
well end up in a future testsuite.

