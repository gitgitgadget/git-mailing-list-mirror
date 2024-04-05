Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA023759
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299946; cv=none; b=jb7ON3uG0H8m1KWZIEAaP9RVcZk2aXO4k3+B+CrI8EOhTlt3xlvbZqtGjpTCEXK47N7oXMfSq8fkvw16BxEylo20kVudzsPX/vhM8mbqD5aa/q4RZ22Hz4x9vNR8oHStlV/QoGcDHvw/LJCrRN5IdnAYFp/xUG0hUFl9RPzy0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299946; c=relaxed/simple;
	bh=l5zQwIPX8LyWBRYekyQ92ShIigT/P4S+y0FbyV+0oDk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=eJpE2Fq+l+t+OuftbExZYPV2H6PtyDtbXpxg5H21Z+4RT9zbyPWskFNcNlepLmUDTNmnpoZZSVGn0JcE8JRjncEaJEdimcRsaeMN8QsA1tMwb7lI3jWEzzxFrOHsDzDx1ndSEAW4NzH1d8smEp84WMoqaO8je8Ai98G2icGXviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=gG+fSOdB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tPQ+Mzfw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="gG+fSOdB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tPQ+Mzfw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EE2C711400FD;
	Fri,  5 Apr 2024 02:52:22 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 05 Apr 2024 02:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1712299942; x=1712386342; bh=px6rWCJAXQjwuvS1q1Pq4Xrb78VgKuPR
	XRAXuoGu1DA=; b=gG+fSOdBF9phzoHc4/rapMAVxOocSoAQzmK5i/g5zXWGHoGw
	oXhM5Kuou/k41RzU6oCeVLOx+vEs6p+OTyI2GUTQkUdQd0YFhDsbOpDRn5SEp6pB
	h0xhaJ/UouFnEyoapHjjKlK/65TgKylueOwuFocCefptQTWd7AXOQXHBq6/lRGHY
	mydkgm0/5KZZQy9EQOr9lCuqEazzztt4Z/WMWy5Em89wyNdZ9uI7q0Fpf+m1GUjf
	YBGzZb6NvXHQ0tbmR+PN5dF+kZybEKML27q9/1pDNDAbSp6CS6fSWuW+Hx9+mJxh
	drz47ymHDoc555FlPTtua0CtVoNHy06TDFy3zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712299942; x=
	1712386342; bh=px6rWCJAXQjwuvS1q1Pq4Xrb78VgKuPRXRAXuoGu1DA=; b=t
	PQ+MzfwwXdDT72IQU8Af3CGU8pMzyppkxdTO8FtxVHotZ5pEL0IV0k1UnJHSWqq6
	y31BCyxmkxdAesSKGWQu4hA2Uk93iUFj6/RtsPTc4x0BpGYAZOQtbscfsAwIudgh
	AWHYXfbK79UyCHzgSG/dekoEtsEE4zVlBAq7MaNSVkL9DZ//cB1a72OyJgDQZPg9
	X0RnnhXoKxZGBOLrTYIxHqNOx1UrlzU+/qXSHCtkWyDBBz48Y7rwroV8JW4r2lwR
	KKpq36LwUfhm8ma9Dj/JqUGn18NvposxtnN/hbBm0qvClY2txSFBf2t2Lc/ktWFL
	zrM9y1Qz5gKMQOdaVzurg==
X-ME-Sender: <xms:pp8PZhPe9d91-BQ_L0RMrxCzkHYshrKemgArmete1lXsJYVIlLys0fE>
    <xme:pp8PZj-8rrxRFlTQVpTUaCmhQ2QwVZzbLuFTN6DPiiomJntrAb0RUGQEvcSRDvXSh
    yOvoSC_J0wHuof1WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:pp8PZgQZ-3Y-wCXfoGFWWgiWNxgpnkmjkDKfDYbHJ7GhVjL7l2gBfA>
    <xmx:pp8PZtuq9g0vU5cImhecBS_3yGc3vp9V9Pr0cSt6kZeet3IxLtRSZg>
    <xmx:pp8PZpdFrzdj9GKZ_83bcj_IDdU-6Dmw3GAkrF4A322LmRk2FxeBSg>
    <xmx:pp8PZp3nQMguNiN9Ad38GuQt9X01dkH7AaEuD-Lpz-76edTGUa4hKw>
    <xmx:pp8PZt7DkQLn9CnK5wd0vF_Tjo2VupOpuXbjT9i5OzspaoM2qlIyWimx>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 79FBA15A0092; Fri,  5 Apr 2024 02:52:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70c97d51-b26a-43f3-9856-af405f396576@app.fastmail.com>
In-Reply-To: 
 <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
References: 
 <0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org>
Date: Fri, 05 Apr 2024 08:52:02 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: make it easy to discern the messages for each patch
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Apr 4, 2024, at 22:34, Dragan Simic wrote:
> may be seen as redundant.  Though, it doesn't look too bad, and making=
 that
> last newline not displayed would make the code much more complex, whic=
h would
> not be worth neither the time and effort now, nor the additional maint=
enance
> burden in the future.

=E2=80=9CNot worth neither=E2=80=9D looks like a double negative. A doub=
le negative in
mainstream English leads to cancellation, unlike in some regional
dialects where it acts as an intensifier of sorts.
