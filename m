Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D334CFC5
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086230; cv=none; b=h5E+Y781AgoKJeg/mil4CkQJE9ZgSBsp9Hdnt/GjxL6+zKk/BOWA1TM1Nz9j/S7qo7R58K6h/3vtzNk1UkTY/FEtr6uRI2jWozu2tOJd78L6Z3XpK6yWYyJt11TlU2UvkQPXeXWywtuKFMLFo+uYq/YXy0WMiSkfBRJGVtI31Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086230; c=relaxed/simple;
	bh=EasrLLHDnVzMC1C7ZKN2dr3MG1ETwJTmN4SD7Z52l70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKS7NtoKIJ09woVWIFzw93lOVvGB1tHjbUQRPHn4XAl5R6REDyQDHJIMcGbh+L1TEuWrfGz28ZG0bAsItgB7KuSI5U1/kk0cyMKFpiZ2VnwShBdadqyzSgY26F8hGSlNed7cPoxm2K9stT5shomAoiddgldT1IYnGuZUtqRI5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GezOHoMT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WmMKOjp5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GezOHoMT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WmMKOjp5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 279D1EC01AE;
	Fri,  7 Aug 2026 03:03:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 03:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786086228; x=1786172628; bh=htFE1PIu0K
	0Bb2uGcSzZqkyRdNo0u6AwzQ6s3Q85VCU=; b=GezOHoMTGzwtJ/B7Nt/4bcr57y
	dtyHgExiP7aKZEFD7Wisuo4B9xUyR05gI8L8shhdUc7UBqjrpy31XFd5l7wscgkO
	W7Vd9n6Msq3EjTvySqnU8k3JqvN7QW776N78TULfHAEJyEor8M9pYZOX4TW/M1Hb
	rx5BznlWFzGtS27vEzER7i98Sm7gtK9cUDsfiiR0wOmtf75B8b80e9ZL94lmvkT4
	h44zkeU6aW1oobtTv0GgXDA1fXMATRePWhrCKdKvg5Ola3/2iy2v/cp4uAHLHMs4
	brRTwzYom3ScHh/hLvdLJM0aS6YUaUCiZkiXQ9/ISOiKCsTUdAjHHLwzfqJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786086228; x=1786172628; bh=htFE1PIu0K0Bb2uGcSzZqkyRdNo0u6AwzQ6
	s3Q85VCU=; b=WmMKOjp5i0eIu007Nbx80yaT1U5RJ9KREjzbDpx6Yk1oQlahCAt
	mUCMaGMFvPZ/AveazNP3nHnxYD0jz2Z2QJi4jW9NQT1Z+GoDR1vpb/bXt8YGUDWC
	FCuzYWalht+0BoO28gOf1YjdJ0PGnKcD7dYOfDbJfL3Vq6/Xxuk9hRksS+OcewSS
	6iyVx6YNAASjXcM38DN2sokiJkDkcXeHz1eQuR6N6lcAI6csV7hLEJfz0ux0Ma1P
	wiDfz6o3wxjpSL2kJnm3gkRPTXO+bH3JypMX6FabP75LlZA5pAQtRgR3Ry48IGrm
	8KbMuA12hkUDimqwuT8bW973sr4YnpZpTbQ==
X-ME-Sender: <xms:VIN1ajW3pHRoECGUtrAGvX_CQUDEvEBTaVbpMX7cTrgbMWxR242zyA>
    <xme:VIN1ahk_K1qzoL45JUaSwiEdc_aDrVTMBs4KwpIuWn6CCaGuMmP9QpFpNNUi8M0RK
    E0gAi8-zegKLNPRc7gZHyW5rkARR0WrH7cE8nVqaNYx_kMGXWmS120>
X-ME-Received: <xmr:VIN1atBJb0xkrtWdthcBnzed5oWj2SCAJd7TnR-Qtgesd2HnXVlxkU73XpQJho17X0Pf-cXgIDKN_JNk4mxsAnXr2tCdveKW8NM8iTD99LqKpQ>
X-ME-Proxy-Cause: dmFkZTE26y9njCNpXPcmZxYe4ifaNpV+sYlC5mYRUIr+ln+pB38Sh4kjo5WX0zU5LY8sit
    +oeUUeuwuVDmjatud2iyJtMdnBGrHtsLnRGmbTcsfv4XslNEpw1gmYRc4vkyxvvkVzb6bZ
    FW+Hc4Ewp0bN9yMqVLHrPU0VZXSxvfa2uONHO4C1LZMZN/4xo/SlyjWqoa1PpzuveaGMel
    tb8CZN49JwAhjMMI8vzeUDPe9GRJE1Pij+NlRwONiI8W2cbrpyJAIUbCY4UmewvnRVelNo
    mmLmZkIFSOfTf9/ExxwJZ9KjT4RrzlQa8TreUzcLYfr16STGdtDWK6anYTN5DZxvjKF6HU
    U1Rll8Gteb8+knp3b5g6+xa9dqby2Rwa4C1ZfOQ5PXYlh4vBNTYza63j0C5Hyt4cxpolfw
    qAZcVdcEO4F8MPiXrn2FuZCHVptzw7S9/0l+Dzy6L9m4Plg8+FJtUOvBVL6mbAmNCpqN4Y
    nAlIrC5KDa3euPsJkQamtrgC1KFrrlb6dSTmJCo/oubr3p7TWR4QnLrao4BBsJ9ylN6BeZ
    R9OQXsj+Ebm4MgDoLWCDxYtKlmkiKGDwqvfvRUIIk9GYy3SL5va65yfGAWO5n5/2ojhY0E
    OSdSJI+Ug5ZZsYhI4wvrBmiDskBSn17U64rtDj6gEzUOvkcjE3F70TPHLeWA
X-ME-Proxy: <xmx:VIN1apeWTRsDjFXrva7mOEbCh8z9CCAY6yxyCk48FlS7dj6ga6EkfA>
    <xmx:VIN1agJGTwSl8HlbRX53fhDYIdwb53wKkLoP_JTPU4MGXaFWuunCxw>
    <xmx:VIN1akeGFvLliyBn-lnkVUN9YTqn_cD_Eg1mo6liXFKEsClXQaVF2Q>
    <xmx:VIN1av2oQ4dKzEMPRgYsnlDzLJA0tljSZUqnw1Trn9sbkYizty19Xw>
    <xmx:VIN1aoFdKX3KbI1_v74G32_8SYinxVTk8VDQMbLWn1SJOxViVDJw_CPI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 03:03:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f88bc9a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 07:03:46 +0000 (UTC)
Date: Fri, 7 Aug 2026 09:03:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] builtin/receive-pack: report unpack errors via strbuf
Message-ID: <anWDTwCwMn5wEdIQ@pks.im>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806213859.816157-5-jltobler@gmail.com>

On Thu, Aug 06, 2026 at 04:38:57PM -0500, Justin Tobler wrote:
> When writing packfiles via `unpack()`, error messages are returned
> directly by the function. In preparation for `unpack()` logic being
> moved behind a generic ODB transaction interface, update the function to
> instead write any error messages to a caller provided strbuf and return
> a negative value on error. Call sites are updated to use the error
> strbuf accordingly.

If only Git had a structured error type, than we wouldn't have to have
such ugly workarounds. Anyway, this is a deeper issue and nothing we can
blame on this patch series.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 8c2d6e5789..7635b82bd3 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2344,8 +2344,8 @@ struct unpack_opts {
>  	int quiet;
>  };
>  
> -static const char *unpack(struct odb_transaction *transaction,
> -			  const struct unpack_opts *opts)
> +static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
> +		  const struct unpack_opts *opts)
>  {
>  	struct pack_header hdr;
>  	const char *hdr_err;

While I'm not a huge fan of error message parameters like this, this
change does make the calling convention more straight-forward. A reader
probably wouldn't have known beforehand what to do with the return value
without reading through docs.

Also, we cannot just return the equivalent of `return error("msg")`, as
we do want to use and munge the error message as part of the status
report we send to the client.

> @@ -2551,13 +2559,13 @@ static void update_shallow_info(struct command *commands,
>  	free(ref_status);
>  }
>  
> -static void report(struct command *commands, const char *unpack_status)
> +static void report(struct command *commands, struct strbuf *unpack_status)

Should we mark this parameter as `const`?

> @@ -2575,14 +2583,14 @@ static void report(struct command *commands, const char *unpack_status)
>  	strbuf_release(&buf);
>  }
>  
> -static void report_v2(struct command *commands, const char *unpack_status)
> +static void report_v2(struct command *commands, struct strbuf *unpack_status)

And here, as well?

> @@ -2711,8 +2719,8 @@ int cmd_receive_pack(int argc,
>  			   PACKET_READ_DIE_ON_ERR_PACKET);
>  
>  	if ((commands = read_head_info(&reader, &shallow))) {
> -		const char *unpack_status = NULL;
>  		struct string_list push_options = STRING_LIST_INIT_DUP;
> +		struct strbuf unpack_status = STRBUF_INIT;

Can't we reuse this buffer and reset it on every run to save some memory
allocations?

Patrick
