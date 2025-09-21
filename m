Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F4323E
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 01:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758417370; cv=none; b=DWx+jtnMiJri/J/ZtXevrS8BWqIMYcDfd8+C4P/VT6iE9eOWaKmv8tDs4AcXGHGWc2B52aAbVXSFFNYz9zeHwZbbuf7AhL+oizT9Jh54OqJHeNXHL6vMJw4Ksk/295P7UfSTBsyx10kN+jZFMe9euv0p2a0K3PCvU1SyRTpuXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758417370; c=relaxed/simple;
	bh=Vky6XK7hK0NEza2R3qJrJEQVinTIiE/0433ep1/nuaQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=s1CXL8SUzmyZJoH+7ARMWpQmvQe2Val7O4FroUHZaBwuUn88utxpqf4vvS8rjHMoLMC6XVgTxRtrqLhZ02c5S8X5ZD5PGu9roJJty3S+bJOqBhhwF6XynC2VC0X95THJwE/GhpNcznjfn6KEngsa8khcMAyLK2V7kiruTQOcb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58L1FdCL1599325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 01:15:40 GMT
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
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org> <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com> <CAH=ZcbDJR7gJ0tyQ-bk-n+Zid_csED74+X5OkTfbEiy5-_2R-w@mail.gmail.com> <002001dc2a84$cda40380$68ec0a80$@nexbridge.com> <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com>
In-Reply-To: <CAH=ZcbCf4sWKhOcCe4UkX3Y9VXZ-iHeh4QZ3ExrX1hbn5GE3vA@mail.gmail.com>
Subject: RE: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
Date: Sat, 20 Sep 2025 21:15:34 -0400
Organization: Nexbridge Inc.
Message-ID: <002c01dc2a95$400315f0$c00941d0$@nexbridge.com>
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
Thread-Index: AQLgmUmHR/cGrsIL/oCQ2NDpPqhQsAJqIl+QATT20pYCDwZOegJLM5dLslQs2EA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250920-8, 9/20/2025), Outbound message
X-Antivirus-Status: Clean

On September 20, 2025 7:48 PM, Ezekiel Newren wrote:
>On Sat, Sep 20, 2025 at 5:18=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>> All I have is a C++17 compiler. gcc -std=3Dc17 might work for
>> compatibility on Linux but none of the gcc extensions work.
>
>What I meant was: Is there a compiler that can be compiled to both =
NonStop and
>Linux. What is the name of the C++17 compiler that you use on NonStop? =
Is there a
>Linux or Windows cross compiler that can target NonStop?

We have c99, c11, c17. The only Windows cross compiler is c99, but that =
requires
a license from HPE that I cannot provide. There are not non-commercial =
compilers
available that can be used to cross compile. Also, standard configure =
processing
does not work on Windows for NonStop.

