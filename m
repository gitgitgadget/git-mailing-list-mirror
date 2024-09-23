Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A117BCC
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118592; cv=none; b=ejd6TWKkIExWLFDRao8YzJIPEEUuOIzFNbw/iObAntVCPxc6M7u8kHnTFBzAu0CAKd0Ei/Lx0cQ1NQ/s3rl6sdB7pLCzPUxCFp23+i8cMYBsBdcz3KyqqGmawF2gAf/bqUWqMKK5Al504pzTGRXHNgDIHjfQ0hPgvz1QJgYmMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118592; c=relaxed/simple;
	bh=zlPrrKfUCn/1k1OpO9MVNvCKYFCTGMQkTp6lOOJNEww=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmUy4GYOcDxzOiVAn7RIMiZEdbBFXxfU/YRQgrRBwOAwMij05g2ZkUf5k+QVudTfob+cKLp+l24VYCfTzwFcp3AkeEGrZmM0TWTA9pHfda5ACyWvT3vr0qD5DzFhhmeH3n30d05Ueqe0fHls+WzUB9cRPPKnvbGcS4dekCitvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 48NJ9RMc992815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 19:09:27 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Andreas Schwab'" <schwab@linux-m68k.org>, <email@mateuszwielgos.com>
Cc: =?utf-8?B?J+mfqeS7sCc=?= <hanyang.tony@bytedance.com>,
        <git@vger.kernel.org>
References: <4B2B1EC7-6B08-4B57-A50F-702C031C2792@mateuszwielgos.com>	<CAG1j3zEg47RLYrVfJQi7WubgcdtbK2RWFBtj5rd8NtkPyXU5Rg@mail.gmail.com>	<0D0BB87D-9BF0-48BA-8F2D-83F8D326ECEC@mateuszwielgos.com> <87r09aus7v.fsf@igel.home>
In-Reply-To: <87r09aus7v.fsf@igel.home>
Subject: RE: [External] Using Git as a Database
Date: Mon, 23 Sep 2024 15:09:22 -0400
Organization: Nexbridge Inc.
Message-ID: <00d001db0dec$1c8fa320$55aee960$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQF96PR6iEXtJ2PpE7SwqUIbuvmrxgDlCwRNAeY3+AEBiIUekbL9Z6PA

On September 23, 2024 2:43 PM, Andreas Schwab wrote:
>On Sep 23 2024, email@mateuszwielgos.com wrote:
>
>> Thank you for your reply, Han. The problem that I have with =
=E2=80=98=E2=80=94allow-empty=E2=80=99 is
>that the resulting commit is not associated with any particular file. I =
tried =E2=80=98git commit
>=E2=80=94allow-empty myfile.txt=E2=80=99 but the file argument is =
effectively ignored. =E2=80=98git log
>myfile.txt=E2=80=99 does not show the empty commit.
>
>Since the git model is snapshot based, there is no way around that, =
apart from
>putting the reference in the commit message which you can search with =
git log --
>grep=3Dmyfile.txt.

One way around this is to inject a date/timestamp in the file. Be =
careful about conflicts
If you every try to merge. This forces a signature change in the =
internal blob on
commit.

I am not recommending this, just suggesting a way to force the issue.

