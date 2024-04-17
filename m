Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DE184D
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334487; cv=none; b=Yj8dWRtF4pGexy+G/84MlgPtOhsYi13AlRdXT5FEieUF5zTCKNOANtvocMYW61smgXBNsMB+sqKz0OuMPgfpEcFXDoS+4+3eJtxa97gD2dRGOfFgu35piRfdFR/kEkthfMFW/IYVY6QsP5DZn3DJPjXOP7CfaX4d5PH/LHMGYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334487; c=relaxed/simple;
	bh=pnW+tbQdgGI4eO1rLAB5hU2GLDecFuJcNwit901+NP0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GRPcwINE4dXinn0RUeeP6bl1MauHdHMfWiwDlhLjtbt0BbgyPnoq8a+PfLQnFzo7xpz65aXtVd1xxtbo6lxqe+J5pI6KLQ1Hk02A+qAIW1TvSSqlwVVzYxvNax+pFY/YLK6JueIRqlxR2kLFfNFXuo+uZ+qFsLDyva40BmkUE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=qLAyHirT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIgYKPw0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="qLAyHirT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIgYKPw0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E0D2E114010F;
	Wed, 17 Apr 2024 02:14:43 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 17 Apr 2024 02:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1713334483; x=1713420883; bh=X0b/g9NjcrgEFVkRCP7OI1/LFzC0nrhK
	ZpFLzekQqF8=; b=qLAyHirTE2u1qfVh+GVnwQ5uas/oIhMj9jz5wpIHd2FVSjOy
	hWCv4uXPa0VMEErd/khOWnrtw2fC+zugWXZOK3lbppYR9b9KbgABJeHWpbz4U1Gq
	/E1j67c1i53AwY4fZ5Dk29gJgzhGQtM7NoLiYP00AwrmLkFVMmAoo09vVtm6gln0
	lxU+yi4U/QTLuVop23yw6MeO4UDSUEzMz7qz/LGL6Eh/Nw7C7bV8mbptsEF0JRim
	omfSrFFQfUG4IzW8nj/rfzw1JWAmprbN0hJgCa+gA4z4NuPxWI0/K1xXzm8JmnNb
	52kpJeIWhLQaVgrXlyuQDWh4VWGMyGT/O0+kKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713334483; x=
	1713420883; bh=X0b/g9NjcrgEFVkRCP7OI1/LFzC0nrhKZpFLzekQqF8=; b=E
	IgYKPw03Wk9+zNYO/DhsSE5JQH32noeLvEnojut3yrBewJd/dJXCTJX1nJfKcyVO
	GX94T23UE40HOX1MdEK24opgZt6VWoRwn0ZMSxuh3ySaOfS7UFS4q7TjpA6zXQmF
	D0FkbH20U90bMBle95pLJ1DW+W9SPfpbYt49e/e9WnQbT87qHb88Tp2KHd047Mp0
	t9QWUEeKsJHvc66zitbFUSnp7somRQJfGeFXy8zUULB1Ps8xY32lkCdwldcNNGvG
	lxS4MZMGu2K8aWdtqWqAHQCEXWW712yXJs0m30ytet+KYZ7Vw7Ps9FjS/Wkc5Cke
	D6Ui4uOQE56SkwD9RoEGg==
X-ME-Sender: <xms:02gfZi9QvFR5XFG-V4VJH1kzBuF4JcFguDyflWij0tUpZwlFhPxGNpA>
    <xme:02gfZit6gjlPi7vY7sTCIwnJT9o8TATo5ajMgDauqQWCRfzws41BrW1MSQNoeDVkL
    Js49KBrbznOe9EnJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:02gfZoD-VJfOKDFdmtCk84vVAKHsI0-cB-jL67xDbTcI7F82HHnXGA>
    <xmx:02gfZqfIuq7uB9sRN4icK5i1tFvoPp35TQcrxJwv2GIx1Hb2fFayZw>
    <xmx:02gfZnM9BT4sjC467HmYRPk0h2dBmyRwAxQYLPN7YyJyEFxFeYhloQ>
    <xmx:02gfZkkYW_75D0p-EqWQQPaD0vyKIWBf8kMd7r8B0fTBVuO3_7pSEQ>
    <xmx:02gfZt2hLV3NkWCuX4o2MVrW24T7zK8kY90rejBz_3er43y7LQ61TwmE>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8E6AF15A0092; Wed, 17 Apr 2024 02:14:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <556d4baa-14f9-485a-8db3-0c9a966351a7@app.fastmail.com>
In-Reply-To: 
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
Date: Wed, 17 Apr 2024 08:14:12 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND" to patch
 subjects
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024, at 05:32, Dragan Simic wrote:
> Add --resend as the new command-line option for "git format-patch" tha=
t adds
> "RESEND" as a (sub)suffix to the patch subject prefix, eventually prod=
ucing
> "[PATCH RESEND]" as the default patch subject prefix.

I think this paragraph is a bit *long*. How about

  =E2=80=9C --resend adds "RESEND" to the subject prefix (producing "PAT=
CH
    RESEND" by default).

(I took this from description of `--rfc`.)

Probably modified to fit in with the other paragraphs.

> Of course, add the description of the new --resend command-line option=
 to
> the documentation for "git format-patch".

This paragraph can be dropped. ;) Adding documentation along with a new
feature doesn=E2=80=99t need to be called out.
