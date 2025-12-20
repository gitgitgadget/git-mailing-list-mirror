Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997B8287E
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766227240; cv=pass; b=MUv86PXogaG6+UKIZEVPRqC+MP+UAfIQkifjSSueEFxcUaJMQsCN0UewZmYt2KHN+YTLzAEY1DnHo0NYXDSlQVGCe5EW0n7oyyV0unCHvmUZfMcliwKqKeTeH90GAWyEnUyPHDZvhGCkPscdw1BItRtqdc5/27tqVdACQ9znhR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766227240; c=relaxed/simple;
	bh=4ROPc1V9DJUvbYDpuat8ur2R8BZ1k3SUg8fr7IXPaMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jerPQ/ixgWMot5h0R+73Uf0lHoQbYu38zVeMvN7ES9PifAiryJ1mo1+pRY9Vh2/2Uk9sDi9vhDscXS9r3rhSb2BJd5oS4EZnNluvaeyQakf3Whsy5aEOk4HZJmj7m30ObSuZmRKwYVrw5vlucfDxwq360zsBlqRwircNDL+x7U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XBRWBqBw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XBRWBqBw"
ARC-Seal: i=1; a=rsa-sha256; t=1766227227; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PObiLO95limdCPAkiHysV6Ea26BbhQ90TFgqyan+iBtptCy8Vd7qvqFwRIZSnf0Edw1SJttERAoAqHLh2Se17gmOw14PIPQZhQrvBwGW/jaKnLCqXWA3y0Jo3/TNWR+y65gv0g9bFIkgKh07BMuY9OLjBQw43vXLzFO0kB2vjfo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766227227; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fDqP7ges7Yk2dkPXAxnNKlYlCIp2iSeBcpO+m3BpH4M=; 
	b=cHOgeOAhirWAskF2DtY1rDrPxIjSF2xZEiticH9iusDT1GQMxNtBIMHGng2Dba76yzjzd92eMz6gmbH2yN9ttHOa9hi/y2BtVfDn+Ya+3KCulr1e5ZBUpvAFOgvJmg/8M/ikCwBi+vh8GFtjRBQE7D8G6crd7xHcU7ZPMkUkh24=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766227227;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=fDqP7ges7Yk2dkPXAxnNKlYlCIp2iSeBcpO+m3BpH4M=;
	b=XBRWBqBwTBVxLKYFnEaeFNJylDRd63/yeFjcd5uZeKLXU4bkoFv+xEhqmVPArGSo
	UPEo24bp6TEtt2NxbO5CFHcucyuBeesALxDMuTKEqXslovfdmjr1CaRBU7PZbEQ8HGO
	5K0ENW2eYqQmIsiHT2pwikON/8iLbrOU2U31/Nzs=
Received: by mx.zohomail.com with SMTPS id 176622722532351.08976396358639;
	Sat, 20 Dec 2025 02:40:25 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 11/11] receive-pack: convert receive hooks to hook API
In-Reply-To: <aUVHVMNTFWWn2xjZ@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251218171126.588066-1-adrian.ratiu@collabora.com>
 <20251218171126.588066-12-adrian.ratiu@collabora.com>
 <aUVHVMNTFWWn2xjZ@pks.im>
Date: Sat, 20 Dec 2025 12:40:19 +0200
Message-ID: <87h5tl4ess.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 19 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Dec 18, 2025 at 07:11:25PM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index d1c40a768d..f22d975879 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -933,20 +878,51 @@ static int run_receive_hook(struct command *commands,
>>  			    int skip_broken,
>>  			    const struct string_list *push_options)
>>  {
>> -	struct receive_hook_feed_state state;
>> -	int status;
>> -
>> -	strbuf_init(&state.buf, 0);
>> -	state.cmd = commands;
>> -	state.skip_broken = skip_broken;
>> -	state.report = NULL;
>> -	if (feed_receive_hook(&state, NULL, NULL))
>> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>> +	struct command *iter = commands;
>> +	struct receive_hook_feed_state *feed_state;
>> +	int ret;
>> +
>> +	/* if there are no valid commands, don't invoke the hook at all. */
>> +	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
>> +		iter = iter->next;
>> +	if (!iter)
>>  		return 0;
>> -	state.cmd = commands;
>> -	state.push_options = push_options;
>> -	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
>> -	strbuf_release(&state.buf);
>> -	return status;
>> +
>> +	if (push_options) {
>> +		int i;
>
> Nit: this variable could be declared in the loop.
>
>> +		for (i = 0; i < push_options->nr; i++)
>> +			strvec_pushf(&opt.env, "GIT_PUSH_OPTION_%d=%s", i,
>> +				     push_options->items[i].string);
>> +		strvec_pushf(&opt.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
>> +					     (uintmax_t)push_options->nr);
>> +	} else
>> +		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
>
> Nit: this should also use curly braces according to our modern coding
> guidelines:
>
> 	- When there are multiple arms to a conditional and some of them
> 	  require braces, enclose even a single line block in braces for
> 	  consistency.
>
>> +	if (tmp_objdir)
>> +		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
>> +
>> +	prepare_push_cert_sha1(&opt);
>> +
>> +	/* set up sideband printer */
>> +	if (use_sideband)
>> +		opt.consume_output = hook_output_to_sideband;
>> +
>> +	/* set up stdin callback */
>> +	feed_state = xmalloc(sizeof(struct receive_hook_feed_state));
>
> It feels somewhat unnecessary to allocate this structure as it could
> have just as well be allocated on the stack.
>
>> +	feed_state->cmd = commands;
>> +	feed_state->skip_broken = skip_broken;
>> +	feed_state->report = NULL;
>> +	strbuf_init(&feed_state->buf, 0);
>> +	opt.feed_pipe_cb_data = feed_state;
>> +	opt.feed_pipe = feed_receive_hook_cb;
>> +
>> +	ret = run_hooks_opt(the_repository, hook_name, &opt);
>> +
>> +	strbuf_release(&feed_state->buf);
>> +	FREE_AND_NULL(opt.feed_pipe_cb_data);
>> +
>> +	return ret;
>>  }
>
> All of these are nits, and the remaining patches all look good to me.
> I'll leave it to you to decide whether you want to do one more (and
> hopefully last) reroll.

Thanks for the review, much appreciated as always.

Sure, I can do one more reroll to fix these latest nits.

Will give it about a week in case it gathers more feedback.
