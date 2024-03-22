Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB68679ED
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711146694; cv=none; b=LI3b3F2aL4Agbw+5BiJbPSw/l1Gw2xGU+TE4hedGZH2+cARMff4jrAZrxQ8eAfRFBpWKq6Nk/pO2YszMckyJs/ROUziDZ3q1Vf+oOWNf9Vr0B6h1X8R9ELSk4bGkvALYJf7J2D915PfbhDMVx5fCM3ERKzDLpgZq5NmMYh+uDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711146694; c=relaxed/simple;
	bh=W0eI4r9AMvg+7chfmIF5djQaAdBdjbRkPLcvbBUCUlg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=P+7SsMD967tQbIE7VDEaGhjvPFCuuAiVJMvutPrQVHqIHgCCQWdx0PxsCaUQQFi1u8qOLzYAk6bXBCPzaaxtXtfGuSHOU6dK1kBPSxvzZpkTlJ6S1GZ7Vzsn3Ah/FKjQLV255702EVNGfaVZaqnYlIAMsGI6+C3cCsVaxISw+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=KCvmwqMl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rkeeg3mU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="KCvmwqMl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rkeeg3mU"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7400713800F8;
	Fri, 22 Mar 2024 18:31:30 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 18:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1711146690; x=1711233090; bh=HtTKha3sSg9j11zn1qqmuBzAL3h6clqi
	TM22+JRGNdc=; b=KCvmwqMlngPVmi6Wfc6QwgKdptSmVR7DhW1RoPAvsctwlKKw
	GwSJGF5P3RIbYo3WWCP+kuCONRRy1u9ZNG8mMrmOwBXhBQqCiAb7ZkDeZs0R2fPh
	Iw3zrAqNwvaN/qiYMdTgdNpaczqL7cXO/SSjt/4c5dIACg6guaLMUdQaMczCkSD3
	ilHI13fCnwNgQ9WMjGkNjg7CsSbB/S5CSUcrZnzK6kl70TSZ7tI+jdJzFJnoNpw9
	lX4/XiHUVkVldVCGPXYGag7Jc2ba8LbFQXDDbdtyn00aM7f1IjGLDykw7NfeNkVU
	XGAkmxceWMMgXBOtJir8qxwL2kcOD87AkbYBSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711146690; x=
	1711233090; bh=HtTKha3sSg9j11zn1qqmuBzAL3h6clqiTM22+JRGNdc=; b=r
	keeg3mUxMrfQ1zT54PWAxjc5GCo/kHzBChhqRbpBiO4lLpyln4Fe7axl7ZaS6YtX
	te75xeVg4X7uofz5ZlQj5mXU7xb4hBkovBtO1yFgL7EW+ss8kpqZMf1Wyc/tzIAA
	vheKrTSGqNt4yVaHHkRfRMBeWXKUvhHhqvmejGnBeFnxsQwLZYXFKOtjaPsT3uV7
	Runy4iWsIw5eyI/mqOOZ0/PX5Z25FRbWElfbV8GDuseufOIjtGMDFL5pd89uOzjL
	lgb+puPYppFoM0/Tf1jnFwMIvBULbYvGV/kIwBDqSS6eBeUh7/2Gts5dAn23U+po
	otCUWMMPVNJQk/5AN82mw==
X-ME-Sender: <xms:wgb-ZSoLla3iQ_IvL95uFmpti8UnJ9LC1Kg26QFmFsoNSbher9O0nac>
    <xme:wgb-ZQqZK8-XovQiA5sC-vyKFxWsdMkgr3bdXxBrtyIY8iSxiOMMISMm0XHWRh6Q1
    veRaEGNY8sNu-n2CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvve
    ehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:wgb-ZXN9pxln_6TD6cMKnFC8QYjgIqf7kKzyY36Py4F1M_mbkYXMwQ>
    <xmx:wgb-ZR4o7QsBtEPnWJu4JhDRV1U1NeC8QZCb_0hd228pwm7LQce1og>
    <xmx:wgb-ZR7N8GFrNS-NaWxkJmrQO4KuSEfpehOfZ3y0dyB4ZRrji8cK9Q>
    <xmx:wgb-ZRjmXqidjzTvh0Pan1jhsZTpgq40cEg-cNvEALtmSr7_0eUyUA>
    <xmx:wgb-ZREgkTONZIMnRnGdpSg0H74vun9F2qoG6vvkBSvq4Fl6ADn8Nw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 338D915A0092; Fri, 22 Mar 2024 18:31:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a459091e-b570-4d5b-9b12-3e4ed7f70615@app.fastmail.com>
In-Reply-To: <20240320004314.GA907161@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <cover.1710873210.git.code@khaugsbakk.name>
 <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
 <20240319212940.GE1159535@coredump.intra.peff.net>
 <20240320002555.GB903718@coredump.intra.peff.net>
 <20240320004314.GA907161@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 23:31:08 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] revision: add a per-email field to rev-info
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024, at 01:43, Jeff King wrote:
> On Tue, Mar 19, 2024 at 08:25:55PM -0400, Jeff King wrote:
>
>> Having now stared at this code for a bit, I do think there's another,
>> much simpler option for your series: keep the same ugly static-strbuf
>> allocation pattern in log_write_email_headers(), but extend it furthe=
r.
>> I'll show that in a moment, too.
>
> So something like this:
>
> diff --git a/log-tree.c b/log-tree.c
> index e5438b029d..ae0f4fc502 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -474,12 +474,21 @@ void log_write_email_headers(struct rev_info
> *opt, struct commit *commit,
>  			     int *need_8bit_cte_p,
>  			     int maybe_multipart)
>  {
> -	const char *extra_headers =3D opt->extra_headers;
> +	static struct strbuf headers =3D STRBUF_INIT;
>  	const char *name =3D oid_to_hex(opt->zero_commit ?
>  				      null_oid() : &commit->object.oid);
>
>  	*need_8bit_cte_p =3D 0; /* unknown */
>
> +	strbuf_reset(&headers);
> +	if (opt->extra_headers)
> +		strbuf_addstr(&headers, opt->extra_headers);
> +	/*
> +	 * here's where you'd do your pe_headers; I wonder if you could even
> +	 * just run the header command directly here and not need to shove t=
he
> +	 * string into rev_info?
> +	 */
> +

Hmm. I=E2=80=99ll look into that. This seems like a nicer place to do it
compared to `log.c`.

>  	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n",
> name);
>  	graph_show_oneline(opt->graph);
>  	if (opt->message_id) {
> @@ -496,16 +505,13 @@ void log_write_email_headers(struct rev_info
> *opt, struct commit *commit,
>  		graph_show_oneline(opt->graph);
>  	}
>  	if (opt->mime_boundary && maybe_multipart) {
> -		static struct strbuf subject_buffer =3D STRBUF_INIT;
>  		static struct strbuf buffer =3D STRBUF_INIT;
>  		struct strbuf filename =3D  STRBUF_INIT;
>  		*need_8bit_cte_p =3D -1; /* NEVER */
>
> -		strbuf_reset(&subject_buffer);
>  		strbuf_reset(&buffer);
>
> -		strbuf_addf(&subject_buffer,
> -			 "%s"
> +		strbuf_addf(&headers,
>  			 "MIME-Version: 1.0\n"
>  			 "Content-Type: multipart/mixed;"
>  			 " boundary=3D\"%s%s\"\n"
> @@ -516,10 +522,8 @@ void log_write_email_headers(struct rev_info *opt,
> struct commit *commit,
>  			 "Content-Type: text/plain; "
>  			 "charset=3DUTF-8; format=3Dfixed\n"
>  			 "Content-Transfer-Encoding: 8bit\n\n",
> -			 extra_headers ? extra_headers : "",
>  			 mime_boundary_leader, opt->mime_boundary,
>  			 mime_boundary_leader, opt->mime_boundary);
> -		extra_headers =3D subject_buffer.buf;
>
>  		if (opt->numbered_files)
>  			strbuf_addf(&filename, "%d", opt->nr);
> @@ -539,7 +543,7 @@ void log_write_email_headers(struct rev_info *opt,
> struct commit *commit,
>  		opt->diffopt.stat_sep =3D buffer.buf;
>  		strbuf_release(&filename);
>  	}
> -	*extra_headers_p =3D extra_headers;
> +	*extra_headers_p =3D headers.len ? headers.buf : NULL;
>  }
>
>  static void show_sig_lines(struct rev_info *opt, int status, const ch=
ar *bol)
>
> And then the callers can continue not caring about how or when to free
> the returned pointer. I think in the long run the cleanups I showed are
> a nicer place to end up, but I'd just worry that your feature work will
> be held hostage by my desire to clean. ;)

Hah! Definitely don=E2=80=99t worry about that, this has been very helpf=
ul.

> If you did it this way (probably as a separate preparatory patch minus
> the pe_headers comment), then either I could do my cleanups on top, or
> they could even graduate independently (though obviously there will be=
 a
> little bit of tricky merging at the end).
>
> -Peff

I think your series should take precedence. I=E2=80=99ll put my series o=
n the
backburner for a while. There=E2=80=99s no rush with that one. These cha=
nges of
yours will make extending the header logic easier overall.

Then when yours is merged I=E2=80=99ll have an even easier time.

Thanks again

Kristoffer
