Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.231.85.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208982;
	b=Cwur8iZRETwMy5CXEesS6Ur21nPFrMVk2ekIECW3VOcL3I9WsOkTiLojC5zlrZIiyrqX
	 UZUQ4r7Yo+kfTNSIWCbrQxLBpkrgB9u9bJ77gbRUNlC95ZdBsAh+C6CLzxEB7aRPbbSbS
	 IbaLjzzB56ZiYmV/vnqqADJAVn4ZPhIpCyunFsVXiGDDlRrMHKweANVewkzu0qrOZ9Mu3
	 T226/WVi402a7zP1Dfr49o1nFLMD9yogP2FSbSappSn0kmzY969Ivr1SkMeYMiq8Dm+Su
	 aGpv9LHTYRNq4z7JZieBzYPU6J/94zYeKBJAm92Gfj0HNuZWAIl8e7mOOitNn7YO6Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208982;
	h=DMARC-Filter:Date:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Bar;
	bh=DzvJCuZDxhK4GnGt9KvjgUEEWVRWbmH0AYVhvVTH/Xo=;
	b=ggXIx1+AeSOH6xX9tTqbjRmBLPB/lCcYIF0GxCoo+tw2M7J+bKlPHUnGjRnufE2WOF16
	 KKP9l7ufLDk+TcWRctFROrYRMhNNvlbX+0CdghD0bfgKQ06YjXXTF/JCKRP0NKgew/FW8
	 SKARDZ5FUp4Z47THCr2KWxTbTFMSjM3KN7iCSKcM8LwV0mSSTw9BonApmsiX7qiGiqM82
	 hDBTDfMUda8V32fnrBLdIgXuJuvXPVZT9in64VHmHFnX6QZO0yBzRc8UMOe199ClDRWhc
	 ADiPe0R8o1h7HdMyyG+OxVjwndpzk+rQhO74LIxi6bhO+HYKZH1BisWn+AglKFREIKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=delayed.space;
	spf=pass smtp.mailfrom=delayed.space;
	dkim=pass header.d=delayed.space header.i=@delayed.space header.a=rsa-sha256 header.s=dkim header.b=eMKLCiAg;
	arc=none smtp.remote-ip=195.231.85.169
Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5D606A692
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 21:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2F5D606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=delayed.space header.i=@delayed.space header.a=rsa-sha256 header.s=dkim header.b=eMKLCiAg
Date: Fri, 20 Nov 2026 22:09:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1795208973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DzvJCuZDxhK4GnGt9KvjgUEEWVRWbmH0AYVhvVTH/Xo=;
	b=eMKLCiAge737Sgh5f57bLt0QTsLicpMofxeDbJ9qtGAR1AcnALhTJEcvjFcy6Rc40vzdBu
	vomtK+PXx66Y70ZaY3gXdqpISSOGEQGiAP4MOfsWLmoncDfriJt9KzXSJC79gxbn7TufBR
	QZlzHBT0XobGAfHKASPkE7+n7VC3or9dWl31vSEg22YpeDuSSnwGC8C/E6LkhwzGP1OMCX
	Eh54+3PY14NwPuRZtBaBjt/ffavf2ml9/zJBVQVvm9EoXmxuu3CjC6Wf2xEVALK4TAv6Pc
	CdK5Wp1rfHEjppmmQH09yVo1UX5vJwHIqDgtUEg2XbcPETah1D7yq1bhH5n9PQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: Prevent git reset --hard from losing data
Message-ID: <awC0MJDYS88yEtgm@exploit>
References: <20261120145444.13061eb7@gandalf.local.home>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120145444.13061eb7@gandalf.local.home>
X-Spamd-Bar: --

On Fri, Nov 20, 2026 at 02:54:44PM -0500, Steven Rostedt wrote:
> Too many times I do a "git reset --hard" in the wrong directory and end up
> losing uncommitted changes. Is there a way to add a configuration to have
> that command check if there's any uncommitted changes and ask if you really
> want to do the reset?

You could just reset without the --hard option and restore what you
don't want to keep. Otherwise there's the --keep option that aborts the
reset if there's local changes, but you'd have to remember to type it
out every time.

Maybe a configuration variable that makes the --keep behaviour the
default could be added with a --force flag to override it.
