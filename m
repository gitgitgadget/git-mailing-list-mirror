Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5071B2D
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354279; cv=none; b=cBXe5EKG/9LhVUQKiUgrZEBsJUdk8V4IWXCmxrCY7smD1mg4LrOViZHzPzf53pPrAu/z1rY4UMEvdDh6Lpomja59Lz1SO2HggoAaSvsf54neeltwmDK+84XSGVoe+ibzUuTbo8onnebZanEvjMCUyvu0JobXqJcnL32oKtzhpFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354279; c=relaxed/simple;
	bh=OcAe9U1fFsJoXQBugZkaXR9Vx99RKIQkGOGF7DVpWos=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Vbsj44JD16HMN86e76l6dqG/wWvkvE/KlWNOXzCmIWl29HY5P92eiDI8sOCl84SYmCjlFgiPW4KXZ2mYYDApzdocdi1/3lnG1gT09Y0grljxTdIrFTq7hYXubZFb/5lB9czFCpY6qhvGPZcOHKpZzRTd96OVHRaIGBOk4jN7h+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=r8QRkDkk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puthwJgG; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="r8QRkDkk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puthwJgG"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 38CD01800087;
	Wed, 13 Mar 2024 14:24:36 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 13 Mar 2024 14:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710354275; x=1710440675; bh=Ybjg3QLrF8Win1GcT6vEOd64GGvfEv8T
	zPAbME8yNlc=; b=r8QRkDkky+5+B0LKaO34HHxG6P33f9GrrjCUJau1tgTAxg7s
	7rgImIgMFkNacok1D5OCg2R/qi6lLbmVkgeI1zGYfB2O8YB3LGpG9plpSyp+FOBi
	DuzfhO6VOjGyg1yhc8TkQrPfWG0K3OF6ZLBGvbtg/qkgstkrAcFzBDzMN5NWOMiu
	+DTd9VcBDbfacON9LEFArzcbn3u0x9taR3aL6OlzKrac9XO66HTDLyM+0HUe0Uo0
	LrbJXZw1CX+I1/UXlkbl+UBtu01vj4MZDYaAe2tvgSGhan/JZDYqu1utcYDVvJOb
	oPfeoMvMrhi4HjwZcgjxuXYT98YM0VkrxrquXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710354275; x=
	1710440675; bh=Ybjg3QLrF8Win1GcT6vEOd64GGvfEv8TzPAbME8yNlc=; b=p
	uthwJgGiovRenqInZP5avGpDhCfYWT4Td/Wr+oBVjY44M8kxICH+hdviMOjwL7vg
	BB2l+28jGBmTGbIbvkvM+fsIuVcldwbfpWm4VpsXk0kv6oLkULBfeHDrJ6HMBxrC
	QCEbf3eYIrvfOeVFdJ/9/aTleduihJweRV2sVDo/pzM4b+KDYs6b9BoPizJfW4EO
	Ck3GMjKl7o29+kwbwLmTJCFCZE8NpzUZ1DkRw9KWVAaF7GpH8aDOd04RCvUDzHZL
	OQhU4s34ZjaamBdtmA0LMdBKSDjX0dN/1037MBwYDoOaMOlyHFsqaY9xoNDYK1YM
	wALDOubP+UlRITdR/+2vQ==
X-ME-Sender: <xms:Yu_xZcFSZpsr5EzyKyK1Jmenf-8Hg7QX6ow-n-iUr2K2szX7V_zCPR4>
    <xme:Yu_xZVW-zAiMhktfm2AWF0Y4mstK9J6wtO9Xhdpcv6J7UESgClcFDi5wk7sDNr4gz
    QqX9p2HFUgzHYXepA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Y-_xZWLA6dUD5mA8HDs4k_i---lUyiWSCAhz1L9ASdgCvkNr9ABzfg>
    <xmx:Y-_xZeFhmrJhpovUWavvZgXEGnpM-7zyfbkuaQLg8DaWngrboMIb6A>
    <xmx:Y-_xZSWXW1XN--lVXQGX5RaMXxLJMpc86ov06FmGwdujNNWwcaUM1w>
    <xmx:Y-_xZRM1zY7wAV5FzWWt7D1Yjm-pKj0h10SZgHwPegr0yVcnej9uGg>
    <xmx:Y-_xZdGHZuYgz2KnmxCFS0I59II8Y_TFH_2QG6rjCFGEB7glMc1jV5Gvr0E>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E2D8215A0092; Wed, 13 Mar 2024 14:24:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
In-Reply-To: <20240312091750.GP95609@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
Date: Wed, 13 Mar 2024 19:23:25 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Dragan Simic" <dsimic@manjaro.org>,
 "Manlio Perillo" <manlio.perillo@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for your work on this. Now I can use dingbats as my comment char.

On Tue, Mar 12, 2024, at 10:17, Jeff King wrote:
> diff --git a/Documentation/config/core.txt
> b/Documentation/config/core.txt
> index 0e8c2832bf..c86b8c8408 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -523,7 +523,9 @@ core.commentChar::
>  	Commands such as `commit` and `tag` that let you edit
>  	messages consider a line that begins with this character
>  	commented, and removes them after the editor returns
> -	(default '#').
> +	(default '#'). Note that this option can take values larger than
> +	a byte (whether a single multi-byte character, or you
> +	could even go wild with a multi-character sequence).

I don=E2=80=99t know if this expanded description focuses a bit much on =
the
history of the change[1] or if it is intentionally indirect about this
char-is-really-a-string behavior as a sort of easter egg.[2]

Maybe it could be more directly stated like:

  =E2=80=9C Note that this variable can in fact be a string like `foo`; =
it
    doesn=E2=80=99t have to be a single character.

(Hopefully UTF-8 is implied by =E2=80=9Cfoo=E2=80=9D. Or else =E2=80=9Cf=
=C3=B8=C3=B8=E2=80=9D.)

Terms like =E2=80=9Ca byte=E2=80=9D and =E2=80=9Cmulti-byte characters=E2=
=80=9D seem a bit too technical
in this context when you can just say =E2=80=9Cstring=E2=80=9D.

=E2=80=A0 1: (1) What=E2=80=99s a =E2=80=9Cchar=E2=80=9D, is it ASCII? (=
2) It=E2=80=99s ASCII but could in
    principle be made multi-byte (3) And also a multi-byte *string*,
    right? (4) =E2=80=A6
=E2=80=A0 2: In five years: (1) How come this Git tutorial=E2=80=99s com=
mit message
    template has `(commit)` as the ignore-these-lines marker? How did he
    abuse =E2=80=9Ccomment char=E2=80=9D to make a long string? (2) Actu=
ally=E2=80=A6

=E2=9D=A6 Please enter the email reply. Lines starting with '=E2=9D=A6' =
will be ignored,
=E2=9D=A6 and an empty message aborts the sendout.

--=20
Kristoffer Haugsbakk
