Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027912C3253
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990736; cv=none; b=OObfUHSdS0FHOWyDW1udbI8N8Seu8bkdUBz9ge4oD170LlsXketMNrcujR4D8vZ3MypnTO13o/ck9+MsmiRM5/mOA0oMODkn0qO/FZrSoeacb44lQ2dO+PDKfrzyg06SphqGDI1bO2tlW2OrXe5wopO/Dp7hzgJJ8eiZjNPZW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990736; c=relaxed/simple;
	bh=4L8u9zcMr0Fd+/mp6TYRcTzg5UG6I4zjCPV4fTjQm4E=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GnsVikYYV65sMSAEWrEPUGeOdf+AgOuqBG/u1eFumuEqHJoH1a9mHecU/5r+lPEYH9wgpKfenFPiaQeMuUUc/W7z3/jGSEY3zUB+Xvqa3Sehq4j0VPfrS3NSBGCfPyG8rWDbwg73NUoWlIGhCG3SmdMUcQ9k6SarewSzUdY6GYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen ([185.122.133.20])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 553MjTC2250258
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Jun 2025 22:45:30 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        <git@vger.kernel.org>
References: <xmqqsekgn4gk.fsf@gitster.g> <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
In-Reply-To: <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
Subject: RE: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed 
Date: Tue, 3 Jun 2025 18:45:24 -0400
Organization: Nexbridge Inc.
Message-ID: <007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE/8OENAHtdeNmfXNuu5L7gSMXaAQGPhlBYtR1UKiA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250603-6, 6/3/2025), Outbound message
X-Antivirus-Status: Clean

On June 3, 2025 6:33 PM, I wrote:
>To: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org
>Subject: RE: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
>
>On June 3, 2025 1:03 PM, Junio C Hamano wrote:
>>A release candidate Git v2.50.0-rc1 is now available for testing at =
the
>>usual places.  It is comprised of 592 non-merge commits since v2.49.0,
>>contributed by 84 people, 33 of which are new faces [*].
>>
>>The tarballs are found at:
>>
>>    https://www.kernel.org/pub/software/scm/git/testing/
>>
>>The following public repositories all have a copy of the 'v2.50.0-rc1'
>>tag and the 'master' branch that the tag points at:
>>
>>  url =3D https://git.kernel.org/pub/scm/git/git
>>  url =3D https://kernel.googlesource.com/pub/scm/git/git
>>  url =3D git://repo.or.cz/alt-git.git
>>  url =3D https://github.com/gitster/git
>
>I hit a new issue during the test phase.
>
>Makefile:200: recipe for target 'lib/tclIndex' failed
>
>Is there any way to suppress this? I don't think we need TCL - don't =
have it anyway
>on NonStop.

More info:

The actual more complete error is:

/usr/coreutils/bin/bash generate-git-gui.sh "git-gui.sh" "git-gui" =
./GIT-GUI-BUILD-OPTIONS ./GIT-VERSION-FILE
/usr/coreutils/bin/bash generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS=20
usage: generate-tclindex.sh <BUILD_DIR> <BUILD_OPTIONS> <LIBFILE> =
[<LIBFILE>...]
Makefile:200: recipe for target 'lib/tclIndex' failed

This seems like a legit problem to be fixed rather than ignored.

Regards,
Randall

