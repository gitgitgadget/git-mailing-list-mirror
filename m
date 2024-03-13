Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56A4CB41
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361137; cv=none; b=sFdrPxLUZKQ12i56pVoNfBOTrzcjrQUfDLCzG3HYrtyfvzWhh0yx8z6bsmHQNXNbknT7pJ9Np9ZPyKlD9j47HjXR3BmYO9oOVSW4+tf9SwbS+OAyldNFdap/WlJfVrT5im+aE+YMLTUMrD8SOG+jo4QVIjlRRiBxTi4NVKdIDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361137; c=relaxed/simple;
	bh=AbNZbO78SyAyWWKbuklh9aZQIF4w1g3kYp3p6dffPHk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tH+pjc9tHmpca1EsAsjtdOD9W+BzNR75LwdLXui4RjZ7dIsRz02SAUfT7ADAx+5O8alfWwx7xk2wJm9D/CEiHFMiCWRgbB1vBDLWqW8yitq+lU9AxWoQ+GaVcFxhWVf9w313Jn9DHeK5EPCl3Joe+FeZxM9ENmJOwYjM2OBgqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=sA58eT3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtcDA7pN; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="sA58eT3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtcDA7pN"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0C839180008F;
	Wed, 13 Mar 2024 16:18:54 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 13 Mar 2024 16:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1710361134; x=
	1710447534; bh=6EGNaPNMccaBjV1Nf2lIBDUrhUtx/uOljbqnEvYmybU=; b=s
	A58eT3g00ooG3vrUMiGR/dYMJyHKEjxtPofi19KbA5QxXqiW4V5DWCGKuBmEBxMg
	nvTr0+Rl5trwUD3tkZQx46rX0zSF7xWF+zICdqndHsoTGju4/Ju7CwEq2m+rHRBV
	Zfu8+fcG3T1cTXaFdjM0dxASh/c55bEt3sYX28spoZMdYfz82Fd10CorGbXQ58Ku
	DNmRGSMtrJh6msIy0IdZlNRKAbxH61Oi+1IHcNDVio9pKJrqPyZWPM+x61S1Pzyh
	8VDHocEn7kysUZpu46X9lERXwGunklkyQ+asomu0IirO61SvRd7Kab3HXYgDmNyF
	Fva5oo3USTC7G2i6CFn+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710361134; x=1710447534; bh=6EGNaPNMccaBjV1Nf2lIBDUrhUtx
	/uOljbqnEvYmybU=; b=FtcDA7pNrRnsjl3CA9SasNmRM5Jkl4cMm8TtLbJIbOw9
	7o35IZNMzd06cBy4Bq609pSTTvdwP3OPf6QKsDmTY72wG77Gi8QoS3630SaTetKA
	gcD8xIhoB4qpI+NWoSXccjZ+zOwdtRZtohHMHs8rb0q0VySI/xjw+cwU/dwbM1Lo
	4Y5hkpaivqeA0lkdQ4XZd2MvS1BUHDNVih1eNvG9PoRlMDtuZiQiUQs/WnHje6q4
	hdMkZy4obHKJPROpWlcBg3E7C0T7HQzoqbZq9wiIl5BjzN/EU4o9uzJmOCVFbBOF
	R/i8KZSqbyw71T9MPRBBdp+MjcqYoW74mW/lI5Yyow==
X-ME-Sender: <xms:LgryZWjr4ogz8Pn1fT9ZBXyig732hrktIcC1tApJhAtOQaoCSLYRYlc>
    <xme:LgryZXDH86PFN1zfa15IxRIfbOmphQloM4caBKQzVojVNEBNqaBUjjwSNLv-gBp9A
    xCQOeRAkTt8H8Demg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:LgryZeHimsbKT1Ik2MrftbiXJJH7cq5Sv93AkN_26p2RuT8v4twouQ>
    <xmx:LgryZfQrGEIA9DveSR6alszdsK28ecZS7pNOlW2Ia_jUAnPGO0YNPA>
    <xmx:LgryZTyz-zQEKwiGj7xX69S6r8VacfKTbVZueBnY2EjaKAkbRzrFSw>
    <xmx:LgryZd7UaXY4aY5dzkuVljj-TzoFSdZ_Sm0XCS7jJD5cth0YJqC_5g>
    <xmx:LgryZe9rOxFP4SohjCCXotHw90kawdcdc9K4fvxaI0at5ufJtlda73QhIG8>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 53FAB15A0092; Wed, 13 Mar 2024 16:18:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c24d304e-adc7-4f29-8ca5-77d8263108cc@app.fastmail.com>
In-Reply-To: <20240313173214.962532-3-gitster@pobox.com>
References: <20240313173214.962532-1-gitster@pobox.com>
 <20240313173214.962532-3-gitster@pobox.com>
Date: Wed, 13 Mar 2024 21:17:41 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] status: allow --untracked=false and friends
Content-Type: text/plain

On Wed, Mar 13, 2024, at 18:32, Junio C Hamano wrote:
> It is natural to expect that the "--untracked" option and the
> status.showuntrackedFiles configuration variable to take a Boolean
> value ("do you want me to show untracked files?"), but the current
> code takes nothing but "no" as "no, please do not show any".
>
> Allow the usual Boolean values to be given, and treat 'true' as
> "normal", and 'false' as "no".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Maybe:

    Reported-by: Jonas Wunderlich <git@03j.de>

-- 
Kristoffer Haugsbakk

