Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50D7B3E1
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496094; cv=none; b=l8w8HdIxM7ytA1P08xnWDIQEKRKXWW1b/TBJO3x7pa3B+pydJmuWxOaYu0d2Acwf/j51A3+iZHeAvkaVWCg1FHPseLfpE+JutX3JN8qaEqQEqt2p/Gw/b0y6XZME0j36NkGZQwQFh+UvUb78hblyjVb/+8AclOrEBwwZHG3ZOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496094; c=relaxed/simple;
	bh=ibko1/J+ojWR/DymCg1hNbPeLwvBQZEob7ULNJLunZE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pW/dRqsO+DHgQQo/WB+KNBEN4x2mwgI7bTw+vYxlzo7vo4H7hb4+k2LororSXSorUYIOMO7pDhHqAseXFnzI78p3vP7IoBKMI/Qsag02KQ6mHTTeo5gnx1fKkMqtV/tFGtpR+DXCNINMZoqp2bKR0e/YZplhAckgjH8HhNSW/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58LN7L7H1804468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 23:07:23 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ezekiel Newren'" <ezekielnewren@gmail.com>
Cc: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>,
        <Johannes.Schindelin@gmx.de>, <ben.knoble@gmail.com>, <cb@256bit.org>,
        <collin.funk1@gmail.com>, <contact@hacktivis.me>,
        <eschwartz@gentoo.org>, <git@vger.kernel.org>, <gitster@pobox.com>,
        <me@ttaylorr.com>, <newren@gmail.com>, <phillip.wood123@gmail.com>,
        <pierre-emmanuel.patry@embecosm.com>, <ps@pks.im>, <sam@gentoo.org>,
        <sandals@crustytoothpaste.net>
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org> <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com> <002001dc2a84$cda40380$68ec0a80$@nexbridge.com> <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com> <002c01dc2a95$400315f0$c00941d0$@nexbridge.com> <CAH=ZcbDGaxiW=QCTrRo3YqxS-rY0e5h5PrnKQt9htJfn4firJA@mail.gmail.com> <003401dc2aa6$623d1420$26b73c60$@nexbridge.com> <CAH=ZcbA0jpntXjPnrVi13Sz1PipnyBLNWKW4Q5taGEHqBrqj-A@mail.gmail.com>
In-Reply-To: <CAH=ZcbA0jpntXjPnrVi13Sz1PipnyBLNWKW4Q5taGEHqBrqj-A@mail.gmail.com>
Subject: RE: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
Date: Sun, 21 Sep 2025 19:07:15 -0400
Organization: Nexbridge Inc.
Message-ID: <008501dc2b4c$7f5ea450$7e1becf0$@nexbridge.com>
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
Thread-Index: AQLgmUmHR/cGrsIL/oCQ2NDpPqhQsAJqIl+QATT20pYCDwZOegJLM5dLApmyRbMCd1X2zwKjRYU7AV7GJwuyDQGlsA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250921-6, 9/21/2025), Outbound message
X-Antivirus-Status: Clean

On September 21, 2025 12:49 PM, Ezekiel Newren wrote:
>On Sat, Sep 20, 2025 at 9:18=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>> This is a much longer discussion. Windows is simply not a trusted
>> platform. NonStop is. Building on NonStop provides a virus
>> free/malware free container that passes audit requirements for
>> financial transactions that cannot be demonstrated on Windows. I have
>customers who refuse all attempts at building anything on NonStop.
>>
>> In addition, production control cannot be done from windows. There is
>> more to life than Dev in DevSecOps, which is the only thing Windows
>> builds gives you. Unless git runs on NonStop, production artifacts
>> (scripts, configuration, deployed objects) cannot be audited and =
controlled.
>
>Can linux cross compile to NonStop? If so, would Linux be able to pass =
audit
>requirements?
>
>It seems like this might be a first mover problem. HPE NonStop doesn't =
want to
>support Rust because no one is demanding it from them, but engineers =
don't ask
>for it (or rather, aren't heard) because HPE NonStop refuses to support =
it. I'll bet
>NonStop doesn't support Git because why would they pay for it when =
you're doing
>it for them for free. and now people are talking about adding Rust to =
Git which
>means Git won't work on NonStop and then something breaks and =
management
>screams at you to "fix it", but you can't because their policy forbade =
you from using
>the tools that would allow you to "fix it".
>
>Am I telling the story right?

Not really no. There is momentum for Rust on NonStop. It just takes time =
to get
budget for the effort. After getting budget, it takes time for the port. =
I am likely to
have some involvement in that, one way or another. NonStop does support =
git,
mostly through my ongoing efforts and they do use it extensively. This =
really is a
crucial application and the NonStop team does understand the =
implications. The
problem is that everything takes time, more than git is allowing in this =
case. I cannot
disclose more than that.

Yes, people are screaming at me to fix it, which is not easy. The policy =
is not the
Problem, but the technical limitations are. It is not a surprise, =
because I was involved
In the POSIX effort when it was first introduced on NonStop, not that =
many "in the know"
Listened to my concerns, which are now having significant consequences.

I am still working all possible angles to see that git stays relevant, =
and appreciate
any and all help from any source.

Randall "The Reluctant Prophet" Becker

