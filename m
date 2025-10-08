Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE720296E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960515; cv=none; b=LtGWSS7SUTUO9PrEAS3qxQKgfxfTKj8zb/yGOMz+z/ttOzfLY9lduARi16zZnSXsp0WcPDiBAomjhca2s4nTnQt/hIMqTNtROU5zrM6/abs6IIq2r9OpoNSjejKfhaLDU7lMGl35BfedVsNtBDSW/5ipFd2OwEquYl4T2E8S4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960515; c=relaxed/simple;
	bh=HMthtNjyBOol/LtsIEiYPP7KcMQx6FBr6XMF/pEaOzs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqT8zkmsP2Z4WIw+/AVTr6BbLK3Z79zePKKA++iLaN+sGUmlPW8Wl/1q5B38u9M7F4pqCHx7CI1EZfBdGNZNA85+As0g6+ReCwwzb2xtEdb2y7QASu2X7cZJdZsuUHBOyOS+gQ1zRSbsc/qwHdXcoT+GPjj9BmVBfVuNfFCs4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 598Lt9EN1728668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 21:55:09 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>
Cc: "'Luca Milanesio'" <luca.milanesio@gmail.com>, <git@vger.kernel.org>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net> <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com> <aN1RFvz7uGPnepxe@nand.local> <04f501dc330a$0ecd3010$2c679030$@nexbridge.com> <aObbWLBCbXsvuajS@nand.local>
In-Reply-To: <aObbWLBCbXsvuajS@nand.local>
Subject: RE: When should we release Git 3.0?
Date: Wed, 8 Oct 2025 17:55:03 -0400
Organization: Nexbridge Inc.
Message-ID: <020a01dc389e$370c3f50$a524bdf0$@nexbridge.com>
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
Thread-Index: AQDc5ElCUINr1BANOCKnX9gjum1mMAHWZFQOAjM1ZSIBrBaUWQIERMz4tnmkACA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 251008-6, 10/8/2025), Outbound message
X-Antivirus-Status: Clean

On October 8, 2025 5:45 PM, Taylor Blau wrote:
>On Wed, Oct 01, 2025 at 03:31:54PM -0400, rsbecker@nexbridge.com wrote:
>> On October 1, 2025 12:05 PM, Taylor Blau wrote:
>> >On Wed, Oct 01, 2025 at 08:13:12AM +0100, Luca Milanesio wrote:
>> >> I am worried that if we rush into Git 3.0 with breaking changes
>> >> that would make other =E2=80=9Cforges=E2=80=9D (e.g. JGit) =
incompatible, we would
>> >> be in a difficult situation with the other Git ecosystem that =
isn=E2=80=99t
>> >> based on the C-Git implementation.
>> >
>> >That's a good point. I am not familiar enough with JGit (or really
>> >any non-standard Git implementations) to know where SHA-256 support
>> >is in those respective implementations.
>>
>> AFAIK, JGit still depends on some core git functions, including gc. =
It
>> also depends on LFS for those functions. Interop it fairly important
>> in that space.
>
>What are "core git functions" here? I'm not at all familiar with JGit, =
but my
>understanding is that it doesn't use the Git binary directly =
whatsoever, so I am not
>sure how the presence of interop support or not would affect JGit or =
LFS.

I tried doing a JGit gc. It delegates to git. There are other functions.

