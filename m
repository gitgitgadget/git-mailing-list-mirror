Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F72F56
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382204; cv=none; b=OEyvb1NhxhuulV1zzZY75B3cm7z69eHXCQsM+LWnXctc5+nbjCDUzGZjeZSLwb7zE1hh/5FEFcmK+0mkskrPhqjrySOFb/Roov/vgkASQ/Ksx6bdSzfeIhBqbGY0fMCIlHD9cvld+ZXFnAs75PNqvt0FnDMBRg1GIOekD9cdzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382204; c=relaxed/simple;
	bh=kizQpilwN+l3aMOV0hXPCyO4SizvdijTixLQ6xFbB6k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiuarruHgG9RiwO3W6LNBLBRe1PPmQq7o3jlPZgA/2uszvbtAT/w2boF83z7eEFsnczzrZB0XAsHeldMl0lDxMfyphVqTfXRH58SxJ9gAIv07eIJbR0O0ktbTow5bxXVDL7BOdnCdRIa9fF/RjFIs38cg7DzDZ2kPHDNsfgUQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc; spf=pass smtp.mailfrom=calamity.inc; dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b=UDU8amCy; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calamity.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b="UDU8amCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calamity.inc;
	s=protonmail; t=1733382185; x=1733641385;
	bh=kizQpilwN+l3aMOV0hXPCyO4SizvdijTixLQ6xFbB6k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UDU8amCyo1GjyqTp/3pWYbdTnl8orrg7Y9EMnizXMdRKPlfZc2gh24OsQDrj3o8FI
	 jZIbEHz5uVIgmb0oFRQIDR7o1opVZJ9Z9bQUg4PK4eqEsxh/sHBBFt1LWLTXYhpINU
	 eq4Xfe70idU9Td8BiwZoUEPmVOIIcNJRzt+d5QyqIuRoM5W6F45ngewoOMPDfhmtjf
	 f65RBNVLiYxddsH8N/XEkmDFfmk2qCNeZ2WwO4YaugzWJzW37k4JqMypB69X4PQsl6
	 iduu/BdZV+5bUCEDCS/ebT2wMQ235cxQnovaFhjz9pOE8oXTuGl8YEbu9/C2MmDlbH
	 TJsbKqHFpnGGw==
Date: Thu, 05 Dec 2024 07:03:03 +0000
To: Justin Tobler <jltobler@gmail.com>
From: Sainan <sainan@calamity.inc>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Some feedback on 'git clone create'
Message-ID: <oEOA5yj-xh-iOJdB-TSYMB2RpjLqNmu-jqrQekiII-mTEYSXfC2Fqz71iRyriWaUiED-r4KyDOypwu47cu0v0ZGxoVHBexKkMMMFalfP7IQ=@calamity.inc>
In-Reply-To: <pgz37cgfssouykfqxvmjt6pc2lycta6tmyjkovsceqwibww4fw@424usnt3dlh2>
References: <AfLIcOv4X1AxLOaODNS89HA-bMeI7bj0xUGsLD-6xmVAS_a_2xOzy2uX-wXxpNA7kCpKYudELCEKv73roW_-HTd83Fcz3FZ_yJQOswQHW48=@calamity.inc> <pgz37cgfssouykfqxvmjt6pc2lycta6tmyjkovsceqwibww4fw@424usnt3dlh2>
Feedback-ID: 116374642:user:proton
X-Pm-Message-ID: 8a46d196c0fa0ad1217f02f59db62660fd747daf
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> You can create an incremental bundle covering a specified range.

Yeah, I know that you can bundle a delta, but I mean an analogue to a shall=
ow clone, which is kind of like traversing the tree in a different directio=
n.

(Sorry for double-send, forgot to CC git@vger.kernel.org on the reply.)

-- Sainan
