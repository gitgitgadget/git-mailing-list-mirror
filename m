Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E113D503
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326988; cv=none; b=S33Z713bW0pSR9NnY4ps+JFXKJ2KepJ7+3/mIKfts0AknThxaw5BtXbfpe0ijCpU7vqhkbxtQBtix5nBbJ090UTx6cokvbwRAtkLwydRHnsjaZnUwRahb8HpesEUYTuN94KT6E6NSx10SHrx3S3RskQu+84OuS/FUEC8LUnF6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326988; c=relaxed/simple;
	bh=vWPjEzglbETwPk8K50kXkqVJP4Y7lAByEIVcYh1SW5Q=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=awMNBrPtzFft742ISBk631IMkPg38ELNnRQTEAbKCBxdM8JOl5KuzfGzo2l7fNxGiRBbt01QG9p6k097X/tRrnNGe/I2Ef1fvfTTEEvrKSZaiXbR4yjttcGzhf3iMDY+jD6TWqh9YK1YPEYstvsk9R90Zf75Aw2MhyGFrHgp9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=fIqJMc6B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnM4w0+L; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="fIqJMc6B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnM4w0+L"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E1D7B1D000AB;
	Wed, 27 Aug 2025 16:36:24 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 27 Aug 2025 16:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756326984;
	 x=1756413384; bh=XtysiFbqYs1sXjQQNXSn62CQdsYwIAa8pdJujN6Ttbo=; b=
	fIqJMc6Blp4YZg7HXt2ts7D7oTXPwVJIwVKhMhyRw2TZFdifr+cSiPLRXU33IXhm
	OmO4a5D4q8+vwgMtU0fEHMnKGTEeIvsAsOOVN+pncaqgEkBFGXztsP6MJL2ue/ax
	n+JlzSq3/P+MB7iIh/IK25JxbCqsf9Jxjsb7oh/jH7stECE77R3UUcKCO7YTYlky
	bvtjrAImkhb0MbsDt7gsToh3M6hDrNDq00sBmdZfGIyKgduwjGppIemKEI3hT6Ay
	jSeTlBffJina7tH+BAmxbq7CQBE/yONnKyXhmn44DJCjmBBXOkvn01Gvb94Rwxoh
	+4u4dy4VzOpjdpZgHdfxWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756326984; x=1756413384; bh=X
	tysiFbqYs1sXjQQNXSn62CQdsYwIAa8pdJujN6Ttbo=; b=XnM4w0+LPpBUHtnkw
	CIPRRS6Ke4Qa0zfcofa7qwZPdYEeRfWk4rdBgE3uPhF3g4c1f6svdkOZ/9nqfG0M
	nOmFMSAaCkhQnNG3JXMMLBZceepon62DM8ldM2/MZAM3YV57S3Oi5UPnwo5BfuAL
	vwX/4tb1UU5/x4fqbO7OwS4NQYuQVmvH2MkDhmD/RGSddchJ/Kf0HflavzTjX7/r
	E4jqrVrb5CfI1/fGOPASAADLovoisq2jvEpHyRr4wI8MXooQkhQ8LCaqYhuG5enQ
	h/T2B9tmnXSKq/o6YN7YgNM9XoR5/Ns4MIWbN1UTWnln7uWim/lbpa8OEamtWdza
	yL9lg==
X-ME-Sender: <xms:SGyvaFTS5GGhWolSBP6Qf70TFhwN2zUqwZXcycwyMcVh0LAPYnXF1Bc>
    <xme:SGyvaOwhy0jxKOqeQh6k2rHlnhAH8-K0MQEirt0ptkwhhrZBS7W7YIuN5aetRf_Vw
    YVtVvcZtx28i32Tjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepkeevff
    etgfevkeekvddutdekteeuuddtleegffehiedttedtgeejudefhefhudejnecuffhomhgr
    ihhnpehgihhtqdhstghmrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SGyvaJV0Ox6g9O6i5COfGTAjH8AniGiowO1u1zR_mXwnc_bTwt6AAw>
    <xmx:SGyvaCj_MOMxB30J8zhestWyEo875IrR-aLIWGO8fvV6JAobtRWvzQ>
    <xmx:SGyvaHV_kkdZoX9uQiKgZrdlSvLi7ybAZ4Efyz-oKKEzv42d_L72EQ>
    <xmx:SGyvaJMVVOlbGsz45DAcJQR60L6ZSKPVlKZzHLkXPVl4WIKAGFzOdA>
    <xmx:SGyvaLFx1hwVcmcZkJH4lRSQSLUk7zho_ZKEqtAhpWK3TmT0qQyecIpl>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 658DD1EA0066; Wed, 27 Aug 2025 16:36:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMHZM2JIZMZV
Date: Wed, 27 Aug 2025 22:36:04 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
In-Reply-To: 
 <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> usage: help the user help themselves

I think I=E2=80=99ll change the area to the more pointed:

    you-still-use-that??:

On Wed, Aug 27, 2025, at 18:29, kristofferhaugsbakk@fastmail.com wrote:
> @@ -377,12 +378,22 @@ void bug_fl(const char *file, int line, const ch=
ar *fmt, ...)
>
>  NORETURN void you_still_use_that(const char *command_name)
>  {
> +	struct strbuf percent_encoded =3D STRBUF_INIT;
> +	strbuf_add_percentencode(&percent_encoded,
> +				 command_name,
> +				 STRBUF_ENCODE_SLASH);
> +
>  	fprintf(stderr,
>  		_("'%s' is nominated for removal.\n"
> -		  "If you still use this command, please add an extra\n"
> -		  "option, '--i-still-use-this', on the command line\n"
> -		  "and let us know you still use it by sending an e-mail\n"
> -		  "to <git@vger.kernel.org>.  Thanks.\n"),
> -		command_name);
> +		  "If you still use this command, here's what you can do:\n"
> +		  "\n"
> +		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
> +		  "- check if anyone has discussed this on the mailing\n"
> +		  "  list and if they came up with something that can\n"
> +		  "  help you: https://lore.kernel.org/git/?q=3D%s\n"
> +		  "- send an email to <git@vger.kernel.org>\n"

Maybe (thinking out loud) this should retain some part of the =E2=80=9Cl=
et us
know you still use this=E2=80=9D spirit:

    - send an email to <git@vger.kernel.org> and let us know
      that you still use this command

> +		  "\n"),
> +		command_name, percent_encoded.buf);
> +	strbuf_release(&percent_encoded);
>  	die(_("refusing to run without --i-still-use-this"));
>  }
> --
> 2.51.0.11.g23cedd8a747
