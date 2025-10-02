Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CFC13AF2
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386885; cv=none; b=GaP5ceHEntxZTbz/zdE9txPQGn8Mj6Svf3raTb+9sHqJanuF8cJarzBT/fmUsiJH0gCb5JQUy/p2wiaWu1ypYPd4dzrF4VGfO2fR7DJALo87g9ly7c54KvkHOFzFsEePpApg1/9T5NvgMJbVxqV6k6FvWWc+xI/AclmyH4i+MMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386885; c=relaxed/simple;
	bh=Fzi2f2gapiqTJPOTu3Rxio3fhALZ9ff2nQXDVM5yFUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyg6vJ7W+NDDSIeSbGtulHERQ8AnMFBtbonpqZUD1c4GhKNmYD//ZDpRzf5cA5uGRZLkNS2T40teyWopaGnhuQszQPP0b+LYLi7kSLt+YGbSZY+qP4plUdPE16bVwKThb9BoLO2fkEx2SSZjs3PoOBDPif1IboiJfoB7zcNa44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YbQtndmM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IeazIjR/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YbQtndmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IeazIjR/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 517FD1D001C8;
	Thu,  2 Oct 2025 02:34:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Oct 2025 02:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759386882; x=1759473282; bh=khAN/faz6t
	8TktFivFBm6uWvO07UOubEYpXR9T/woto=; b=YbQtndmMWbczTb3JgWIica2esh
	Q4hFhBvoWuojGboX/7tq+VXE12ivW+KSx+L4CikaFJBO+VD7BRTVWVnfxq3lx9wl
	Od+oyIri7dUcO4cdINO5KKe5DSKtXHmcwJQOYx3I60Xva7FcNJvLqY46BWowb3Y6
	zeupOn4wsfeVZc0nhXmtAQPfsFW7Nh4OkDII2jfDq+YKjSSiMLpyM9d4HZVu4YWL
	2ah6dER4w/aT2lxkkbQJuqxnGrIQ2LkFGGP3Q8dMBDHpJxV41bJOG2XTvPP5l1Su
	AyyNEUz91GlGvvp/OTWoOhl6v3DAew9VQY9/y06sR+GKPpwtDa5p7wsV7Wfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759386882; x=1759473282; bh=khAN/faz6t8TktFivFBm6uWvO07UOubEYpX
	R9T/woto=; b=IeazIjR/fm6GzIgJPYECePzyes8VWM1qvoTY/PKpf8SA2Cr3frI
	Q8J3n0TMQ6C7u2QIYiQ5RAwZEELb8J0Ru72JtJl0aOq+CTt8oHqxXSK8//qIUyqU
	LE2CG8gQQCUW3gHAKmSWcHy0IfOCKL2IKP/eThsaCQW08Jk/fvgPvTG3O10KZwwv
	q3BYBMQYsI/jYYTFbtHxOOqL+wbTvVDTcF351mFNsoVvmNM6fiviuAS6kTXzkYGW
	RnxmeJd/jztCBS4PgPmx9kGyhPTLY4CmVslj3OryiH9Rf5wJ1XERuYbRC8/2nOLo
	Yq/ducG99FqaT3VWyKLIBbXBv1podrULosQ==
X-ME-Sender: <xms:Ah3eaMVTO6k98Tq5a89U6SiWr8nLXAoOI8r4QNu9ke0ivsOowK2szQ>
    <xme:Ah3eaC2t72mG9mzaKdbQUt4hcyvlZ0MfKlhSofnwN8qAtlUDVpg_yXEn5dS7Hv3i3
    2ibtqAl9-Lj95M98yfwV6oUzx7cZ2FhOcUX50QtEdO8vUc3bhTG8g>
X-ME-Received: <xmr:Ah3eaCoGYweKM5Zt9A_OtRKNW2Xtu9er9f9Hw__2pu3BadDDwMeTnVeC-ftvxkOfVKBoRsi-jHx7aV2TP-9kSFBw5EY7Y-lxTd5y2WlVjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomh
    dprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffh
    gvrhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Ah3eaBXKGsaXtDhm1DOzjjIDrckQe8yOTomF_Z9d6yumsX3GNOo86Q>
    <xmx:Ah3eaFa9BzTRkS7rW87EVa_iDZ-xQqmr0d48xA5zqAkmBY_SPDX4ZA>
    <xmx:Ah3eaGdB_IxM5w9cO6U5R2_EN4XNefVlzm0JLBdiNxgzoDXODcpBDQ>
    <xmx:Ah3eaH2--Lpg7-ERv8qrnJG7e0xY-kBAOJO_EMZCaoxrviG9VG8bvg>
    <xmx:Ah3eaGFY6eNnnBpTrE5TIHU2uXbhpm7YqIUZMZIuwZCxG5sd-IoYM-jT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 02:34:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9e04f87 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 06:34:39 +0000 (UTC)
Date: Thu, 2 Oct 2025 08:34:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 05/10] reference-transaction: use hook.h to run hooks
Message-ID: <aN4c_DWtqBBScKEh@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-6-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925125352.1728840-6-adrian.ratiu@collabora.com>

On Thu, Sep 25, 2025 at 03:53:48PM +0300, Adrian Ratiu wrote:
> diff --git a/refs.c b/refs.c
> index 4ff55cf24f..5a2b6ad1fc 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2377,31 +2377,16 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
>  	return 0;
>  }
>  
> -static int run_transaction_hook(struct ref_transaction *transaction,
> -				const char *state)
> +static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
>  {
> -	struct child_process proc = CHILD_PROCESS_INIT;
> +	struct hook_cb_data *hook_cb = pp_cb;
> +	struct run_hooks_opt *opt = hook_cb->options;
> +	struct ref_transaction *transaction = opt->feed_pipe_ctx;
>  	struct strbuf buf = STRBUF_INIT;
> -	const char *hook;
> -	int ret = 0, i;
> -
> -	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
> -	if (!hook)
> -		return ret;
> -
> -	strvec_pushl(&proc.args, hook, state, NULL);
> -	proc.in = -1;
> -	proc.stdout_to_stderr = 1;
> -	proc.trace2_hook_name = "reference-transaction";
> -
> -	ret = start_command(&proc);
> -	if (ret)
> -		return ret;
> -
> -	sigchain_push(SIGPIPE, SIG_IGN);
>  
> -	for (i = 0; i < transaction->nr; i++) {
> +	for (int i = 0; i < transaction->nr; i++) {
>  		struct ref_update *update = transaction->updates[i];
> +		int ret;
>  
>  		if (update->flags & REF_LOG_ONLY)
>  			continue;

Hm. In the "pre-push" hook you converted the callback to process one ref
per invocation. Why don't we do the same over here, with one transaction
per invocation?

Not saying that either one of these is better, but it left me puzzled
why we use two different patterns now.

Patrick
