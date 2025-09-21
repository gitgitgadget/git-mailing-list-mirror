Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E33F9D2
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758424727; cv=none; b=MsUQb3EB+wu4jCn7kb2iaS12SlkMRezoXTnA0xxPlMMUk2F3WvK/Yw9UScqV4DlyMOFC3fdD9+pvex3mX05J5Y6EWjTUlnA/V5IwQ8A5hm4igH5cqpQuENNBsV5qe2C1JTofZgiPcHFNnRE4hfC2bM1Bqko9qcZumpQujGbset0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758424727; c=relaxed/simple;
	bh=YIpdeWbA5NyScFkEqBp6Xt6/fTPEDgBHH9RqUdEOGkc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRJhSNsQ1P8I1OoyAoi11tafb8OwKIk1ODw8x8SSad8BHqtEQr1JQyMB8IAtU1PiBu+4EanZf8Bj9NrVTExwpVB/NdCaoQjGxQFblRc1dvDNuhjXqFr3GG4Dj5LcV8KNJDGumHtjlughW67jWTqy3Y04+XYBnjTr1UHfbtRx/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58L3IHPF1628321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 03:18:18 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ezekiel Newren'" <ezekielnewren@gmail.com>
Cc: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>,
        <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>,
        <Johannes.Schindelin@gmx.de>, <ben.knoble@gmail.com>, <cb@256bit.org>,
        <collin.funk1@gmail.com>, <contact@hacktivis.me>,
        <eschwartz@gentoo.org>, <git@vger.kernel.org>, <gitster@pobox.com>,
        <me@ttaylorr.com>, <newren@gmail.com>, <phillip.wood123@gmail.com>,
        <pierre-emmanuel.patry@embecosm.com>, <ps@pks.im>, <sam@gentoo.org>,
        <sandals@crustytoothpaste.net>
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org> <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com> <002001dc2a84$cda40380$68ec0a80$@nexbridge.com> <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com> <002c01dc2a95$400315f0$c00941d0$@nexbridge.com> <CAH=ZcbDGaxiW=QCTrRo3YqxS-rY0e5h5PrnKQt9htJfn4firJA@mail.gmail.com>
In-Reply-To: <CAH=ZcbDGaxiW=QCTrRo3YqxS-rY0e5h5PrnKQt9htJfn4firJA@mail.gmail.com>
Subject: RE: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
Date: Sat, 20 Sep 2025 23:18:12 -0400
Organization: Nexbridge Inc.
Message-ID: <003401dc2aa6$623d1420$26b73c60$@nexbridge.com>
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
Thread-Index: AQLgmUmHR/cGrsIL/oCQ2NDpPqhQsAJqIl+QATT20pYCDwZOegJLM5dLApmyRbMCd1X2z7IrxilQ
Content-Language: en-ca
X-Antivirus: Norton (VPS 250920-8, 9/20/2025), Outbound message
X-Antivirus-Status: Clean

On September 20, 2025 9:24 PM, Ezekiel Newren wrote:
>On Sat, Sep 20, 2025 at 7:15=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>> >What I meant was: Is there a compiler that can be compiled to both
>> >NonStop and Linux. What is the name of the C++17 compiler that you
>> >use on NonStop? Is there a Linux or Windows cross compiler that can =
target
>NonStop?
>>
>> We have c99, c11, c17. The only Windows cross compiler is c99, but
>> that requires a license from HPE that I cannot provide. There are not
>> non-commercial compilers available that can be used to cross compile.
>> Also, standard configure processing does not work on Windows for =
NonStop.
>
>If C/C++ can be cross compiled from Windows to a NonStop target, then =
why does
>Git need to run on NonStop itself? Why couldn't you use Git on Windows =
and then
>copy the compiled executables to your NonStop targets?

This is a much longer discussion. Windows is simply not a trusted =
platform. NonStop
is. Building on NonStop provides a virus free/malware free container =
that passes audit
requirements for financial transactions that cannot be demonstrated on =
Windows. I
have customers who refuse all attempts at building anything on NonStop.

In addition, production control cannot be done from windows. There is =
more to
life than Dev in DevSecOps, which is the only thing Windows builds gives =
you. Unless
git runs on NonStop, production artifacts (scripts, configuration, =
deployed objects)
cannot be audited and controlled.

