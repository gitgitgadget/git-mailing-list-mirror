Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E445BE8
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760782; cv=none; b=jTkPMGN7qltF3J/evdtWlGtO8TCq3/qB/Jk/pKFjTNQ1vV4bOx3Px9yqiII55TK8RdOSmyBzpqtK98EcVF0sRSvJyAnONiTV2PebDXoL6Amhp6Fyk8Tf+rzKKZ+u5ObxG3HFs3871xeCHQtzmgR2KF4SU52vuRrfcxBfLpKSg4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760782; c=relaxed/simple;
	bh=zo7p/ghBm/Ky3Ud7YoDMUNOWE8byNfri/pKL0UkALTg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugElvfDKHdpeTzGLBd5+G4dxrQrI2q8FHYNih0McGhHzsHDsR5mJVzQ59tcdTXkRdMqbKOBer7eC+fdgoWKXO5oQEERzcCb4FVG4OLvt7jgZMD0SU0zzvHfirjrzATJLop83S/7ZyEPXCZ3npnk0bCpX/sn/HsvtcOOn2zipvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41CHxaXM3611122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:59:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com>	<xmqqbk8nbvqy.fsf@gitster.g>	<002a01da5c94$a1bc5340$e534f9c0$@nexbridge.com>	<00fa01da5dcd$5b060150$111203f0$@nexbridge.com> <xmqqzfw57hw0.fsf@gitster.g>
In-Reply-To: <xmqqzfw57hw0.fsf@gitster.g>
Subject: RE: [BUG] git 2.44.0-rc0 t0080.1 Breaks on NonStop x86 and ia64
Date: Mon, 12 Feb 2024 12:59:31 -0500
Organization: Nexbridge Inc.
Message-ID: <010601da5ddd$3dec41a0$b9c4c4e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEKhykLt/LB5hLsEaYKWm4eL/p/IgHSi0nNAaWPrR0Cxs1+jwIIq4sYsmRnGqA=
Content-Language: en-ca

On Monday, February 12, 2024 11:43 AM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>This looks like a good plan.
>>
>> This might be trivial, but I cannot tell. The #ifndef should be changed
as
>> follows:
>
>https://lore.kernel.org/git/xmqqttmf9y46.fsf@gitster.g/

I applied this fix but there is no improvement in the result from the last
report. actual just has two lines. expect looks reasonable. I still had to
modify the #ifndef.

I have tried cherry-picking the change (no effect), building on master,
next... am lost.

