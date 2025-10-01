Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503B1553A3
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347131; cv=none; b=PnCzLtRajAUyPg0Hm57v3luMjksggyRQJUtro6v318shrRvUiA8tlQgWWHbttXiRot0uh5oWKKxv++1IRC7Jski3ShPLeqfOfmSSWTofC+rBuTTQzaHf1mYfxCohf98RutVA7FHckUiPrcGf8xSJhoqvvm6dm9gKWx52oMR+QNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347131; c=relaxed/simple;
	bh=8BfDrgqXofHBrkKoTDO8G1VZ0chApNSnnbnZsQh/HwA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fqAC1jqcLfoIXkM+BkJaQZ02B0fJNqHI9B0wukMChCILz/CU+jiehAUmOpwrm98A7/3yz6OyZiC3rnBrZpUPzkFdRoY5mEn6WbaOdUQCOpFMCt1fig6bHyiMPjEwRrhwe0lwvib/pS/4P/nb76xTrPHMYJM9VpOmDSJmrKgEbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 591JW0Zb009659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 Oct 2025 19:32:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>,
        "'Luca Milanesio'" <luca.milanesio@gmail.com>
Cc: <git@vger.kernel.org>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net> <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com> <aN1RFvz7uGPnepxe@nand.local>
In-Reply-To: <aN1RFvz7uGPnepxe@nand.local>
Subject: RE: When should we release Git 3.0?
Date: Wed, 1 Oct 2025 15:31:54 -0400
Organization: Nexbridge Inc.
Message-ID: <04f501dc330a$0ecd3010$2c679030$@nexbridge.com>
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
Thread-Index: AQDc5ElCUINr1BANOCKnX9gjum1mMAHWZFQOAjM1ZSK2i/4v0A==
Content-Language: en-ca
X-Antivirus: Norton (VPS 251001-10, 10/1/2025), Outbound message
X-Antivirus-Status: Clean

On October 1, 2025 12:05 PM, Taylor Blau wrote:
>On Wed, Oct 01, 2025 at 08:13:12AM +0100, Luca Milanesio wrote:
>> I am worried that if we rush into Git 3.0 with breaking changes that
>> would make other =E2=80=9Cforges=E2=80=9D (e.g. JGit) incompatible, =
we would be in a
>> difficult situation with the other Git ecosystem that isn=E2=80=99t =
based on
>> the C-Git implementation.
>
>That's a good point. I am not familiar enough with JGit (or really any =
non-standard
>Git implementations) to know where SHA-256 support is in those =
respective
>implementations.

AFAIK, JGit still depends on some core git functions, including gc. It =
also depends on
LFS for those functions. Interop it fairly important in that space.

>But regardless of whether we're talking about a forge that is based on =
git.git or
>some other implementation, there is very likely lots of other work to =
be done to
>support SHA-256 outside of flipping the hash function within Git.
>
>(I'm thinking here about database migrations for columns that may store =
40-
>character SHA-1 hashes, for example, which can take a potentially =
significant
>amount of time to migrate depending on the size of the database, etc.)
>
>So my feeling here is that we should take into account not just the =
readiness of the
>underlying Git implementation used by hosting providers in the Git =
ecosystem, but
>also the readiness of the hosting providers themselves to do the work =
necessary to
>facilitate that transition outside of their Git implementation.

Regards,
Randall

