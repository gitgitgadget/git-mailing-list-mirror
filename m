Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C55FEEA
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706985947; cv=none; b=bMnncX2abNh4M/S1jycptBLR1XDK+LYaNqgm5Cp5LdrqSBhtcVSL5l1vgEepLEjHW4Y7KR4syMEgl1szS9IpoZxbH5Zyg5RpfoxAsdFOBNiOB4R0L9RN0ppHFLweCms/yQ+x2XrdX/J/QpXxtaU2OTbooNppPi2HgO4u3QJ1Yjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706985947; c=relaxed/simple;
	bh=Q481W5qqwiNCU64YMJsZ8AeR07K5JI3ocxymJ3boJX4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=R621baTB9HSY2GOke1d1DNgyRRFZwqClkdhF30TRr9BTKwa0yIJ7uLCz7dQSF5gMavfjcsLKmgfNlhSbFT/DLFEDJoKmd8dWuebrr1OnC495UrxV64ejfSgf+AmSXdRMsNceTfVm2sb1t3rpFC8y27+IA7XxYvauwVHdfHWKNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=PsyXdxcx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+y7zjVa; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="PsyXdxcx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+y7zjVa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 12D8D180006B;
	Sat,  3 Feb 2024 13:45:34 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 03 Feb 2024 13:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706985934; x=1707072334; bh=we+jrRalOMNEq5e8MeKVMXgE3MfqsM8K
	k4qm3Jqu3cs=; b=PsyXdxcx7k851vBfb0orOn6mKcC3Oc0OEFLvENEzYGAh11Lg
	8rLIz0bBuUUwaf/cZ/jh6MqQqgp0CU54m/uMMdlclZBhiDDjFAg+uMSjcVm8Cc34
	s9rFnigzQrmquhKir65NDjojAIwa/YKgaKR0m1CR4fvBkhewIXiQrL/03Y1V5PVh
	vDZKITg8raviaDm80SoL2XWsV91r/0ax6jc4N7sdItyDKNDFRPog50PwANmY/Jww
	f18I8F+RB1OMxGEHual09RFFnaNtoelfUgzO4z5bzLVQ319zSpEJh3TKMlODyFBg
	OZuxj0qHGw4z+AOADCZgn5NEv0mxHNaPjAsMsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706985934; x=
	1707072334; bh=we+jrRalOMNEq5e8MeKVMXgE3MfqsM8Kk4qm3Jqu3cs=; b=C
	+y7zjVaABz+r8oCbDcG+Gcz/CPAatNcjOkXkCAd3ugxAGpV02fpZOfMsKaePGaxp
	g/kVGwAA6vOdKSi5ezF5ZrDMAaUxZKIwqRR3Uo/l0KjAWWWpRfDYafPh2/qN1znU
	9FasoZ+1yIXLVkcWj5nbluc1ghXCWNQF55PEClPFUVAtz6EdQefLhnQDphBC4ELh
	Y/Wg4LzoiOAW1TMo46bfe13EUpQVyE1CLTU1GQYXly7Zo+ItqoQGcqK6hih7FJbx
	iIReLE0yHrYuxZB3sJ/2Ev+37zoTqUCOtkoIwX9MqNl08N2iPItiRb8nSLv79thf
	UMkINEyVPgw9IkWyrP/Mg==
X-ME-Sender: <xms:zom-ZY8M3_0cugpYjaNsZ4a9DnnZ9KsoH7LjM7nphNUV9dSE0iiRgqk>
    <xme:zom-ZQvvClvyGqMmol84rVpndYIjrvL5oCgCdy1Eaqci9IaTH2A8N5LSGzUymg_ia
    hlIruMQWPvoITLqZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduiedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgf
    esthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghk
    khdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrh
    hnpedvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:zom-ZeAB8HX0LF0X-o5SOCu6bJseO3fxOl3n2K0A-4u5NlDkN_1_tA>
    <xmx:zom-ZYd4QxgCV6oib3Sxk6rUf0CcPt2x8HHB6B02CLfs0XDX0itq1w>
    <xmx:zom-ZdNfu11FWVr3LtR6XpAaDC5ykzmqBhQWSEyTNyYZ2fbiMs80xg>
    <xmx:zom-Zb1taGhPdrPIZ17wNrGREwFhFIoLYjw-ORChDnj_DvSn431d-QyAmWU>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 530CF15A0092; Sat,  3 Feb 2024 13:45:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <06931285-71cc-4c71-9f74-1a675b9186ae@app.fastmail.com>
In-Reply-To: <xmqqbk8xsba8.fsf@gitster.g>
References: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
 <xmqqbk8xsba8.fsf@gitster.g>
Date: Sat, 03 Feb 2024 19:45:14 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: git-users: email list has become spam-drowned
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024, at 18:33, Junio C Hamano wrote:
> to find out who the owners are and how many members there are.  I
> expect the UI redacts the e-mail addresses of them, but there should
> be a "Contact owners and managers" link, from which you can contact
> them, to let them know about the situation.

I tried that now. Turns out my Gmail account was already a member. I was
able to find the owner. But when sending the message it said something
like =E2=80=9Ccouldn=E2=80=99t send message=E2=80=9D.

--=20
Kristoffer Haugsbakk

