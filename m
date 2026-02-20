Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E534575F
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595519; cv=pass; b=ROjVk154euWECeVE8tfL2Y9JsxklebyJqum8/QE9YSt0z0Bt7l5+rU+5ZbCQQX7LA+sMJsVcKT7aLqTbEil6PtLmceYkvZUvk0XTLTwe+m5pUa3UkLkUy7OBjyCGaYGYEVSYateQxgE543TR4Udvl8/AjqPqjpbmlhNsSKLblp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595519; c=relaxed/simple;
	bh=0EAVQ5vWanh9oHNOPkqJeyogG0a2Nep9bxYYNqRbaqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJ90rTiJf4NUQoiin6dRvh4c/Ny57onZ6NQCG1x8TYjRnfXk61g3Awdy+cfUc/gcW5Zya1OjSFPO4a97YxIFkN/Nvn2S4x1iUMoXj0lRVqYJ3nxJhKAydpUCRZ2UO0n48Py4iGopBHXgtilv5K1/8F0iffUvRFxIMHPeBB3s3NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HHfPh9im; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HHfPh9im"
ARC-Seal: i=1; a=rsa-sha256; t=1771595505; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P+MPamPUgKu3M17HmK5RUc0zayqs9sLDpPTcI9C1he0B+4kZv3DeLQ8piqKsCuIypnJeDAWk8Mt+twE2qfHxChkDLSJ/6yOBjKIFZte7UAt81ijcdj2rl43X6klwqVsCte8TR5VtNLvN43rSUKcIpdLnw5C2xCNGZU53YSc449Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771595505; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nzGGD1wMIsAx5a5ZEJ6k9kHLqO3e1I2ABDZwge0JLKM=; 
	b=AaZ0KfGfjchzfJrzH27cHNiGVmVxf10CmFOxyc/Nj2KIYIjvc4ilN5wgg6WAbFVtXhAgtl5ItotDgl5hpABT949uVeKNUQxmIBOPhYoPgUY1U/Mt5jzKCuY8oG0Hl+YwqYwytwAQuwn+tRSCrBLFwGX9p7PByBpZIWRvK2Dcdls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771595505;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=nzGGD1wMIsAx5a5ZEJ6k9kHLqO3e1I2ABDZwge0JLKM=;
	b=HHfPh9im3xeAk5y8buu9hrljoTXVHz5hHhDMmcwwb43waIL/b95qWNWZsKlDFhnh
	p5NsKcn0gaHpxeT4iGxJaEDJwToAiw1iKm3C2e1KyQ21ukqDkdZfTcgrpfnSpbBnJST
	PguOT1+Wf8ZwxHRcn/8QF+jHF78oYl586Z1SKm1s=
Received: by mx.zohomail.com with SMTPS id 1771595503837429.47629851801923;
	Fri, 20 Feb 2026 05:51:43 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/8] hook: run a list of hooks to prepare for
 multihook support
In-Reply-To: <aZhXkDtNvcNpXgpJ@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-3-adrian.ratiu@collabora.com>
 <aZhXkDtNvcNpXgpJ@pks.im>
Date: Fri, 20 Feb 2026 15:51:40 +0200
Message-ID: <87zf53wmj7.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 20 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Feb 19, 2026 at 12:23:46AM +0200, Adrian Ratiu wrote:
>> diff --git a/hook.c b/hook.c
>> index 83ff658866..c008a7232d 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -47,9 +47,97 @@ const char *find_hook(struct repository *r, const char *name)
>>  	return path.buf;
>>  }
>>  
>> +static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
>
> Nit: this should be called `hook_free()` as it also frees the struct
> itself.

Thanks. Junio also told me to prefer the _free() variants for functions
instead of _clear(), so I'll do that in v3.

I'll also carefully look so names match the semantics of the functions
I'm adding.

>> +{
>> +	if (!h)
>> +		return;
>> +
>> +	if (h->kind == HOOK_TRADITIONAL)
>> +		free((void *)h->u.traditional.path);
>> +
>> +	if (cb_data_free)
>> +		cb_data_free(h->feed_pipe_cb_data);
>> +
>> +	free(h);
>> +}
>> +
>> +static void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
>> +{
>> +	struct string_list_item *item;
>> +
>> +	for_each_string_list_item(item, hooks)
>> +		hook_clear(item->util, cb_data_free);
>> +
>> +	string_list_clear(hooks, 0);
>
> We have `string_list_clear_func()` to perform a deep free for you.

Ack, will use it in v3.

>> +}
>> +
>> +/* Helper to detect and add default "traditional" hooks from the hookdir. */
>> +static void list_hooks_add_default(struct repository *r, const char *hookname,
>> +				   struct string_list *hook_list,
>> +				   struct run_hooks_opt *options)
>> +{
>> +	const char *hook_path = find_hook(r, hookname);
>> +	struct hook *h;
>> +
>> +	if (!hook_path)
>> +		return;
>> +
>> +	h = xcalloc(1, sizeof(struct hook));
>
> Better: CALLOC_ARRAY(h, 1);

Ack, will use it in v3.

>> +	/*
>> +	 * If the hook is to run in a specific dir, a relative path can
>> +	 * become invalid in that dir, so convert to an absolute path.
>> +	 */
>> +	if (options && options->dir)
>> +		hook_path = absolute_path(hook_path);
>> +
>> +	/* Setup per-hook internal state cb data */
>> +	if (options && options->feed_pipe_cb_data_alloc)
>> +		h->feed_pipe_cb_data = options->feed_pipe_cb_data_alloc(options->feed_pipe_ctx);
>> +
>> +	h->kind = HOOK_TRADITIONAL;
>> +	h->u.traditional.path = xstrdup(hook_path);
>> +
>> +	string_list_append(hook_list, hook_path)->util = h;
>> +}
>> +
>> +/*
>> + * Provides a list of hook commands to run for the 'hookname' event.
>> + *
>> + * This function consolidates hooks from two sources:
>> + * 1. The config-based hooks (not yet implemented).
>> + * 2. The "traditional" hook found in the repository hooks directory
>> + *    (e.g., .git/hooks/pre-commit).
>> + *
>> + * The list is ordered by execution priority.
>> + *
>> + * The caller is responsible for freeing the memory of the returned list
>> + * using string_list_clear() and free().
>> + */
>> +static struct string_list *list_hooks(struct repository *r, const char *hookname,
>> +			       struct run_hooks_opt *options)
>> +{
>> +	struct string_list *hook_head;
>> +
>> +	if (!hookname)
>> +		BUG("null hookname was provided to hook_list()!");
>> +
>> +	hook_head = xmalloc(sizeof(struct string_list));
>
> CALLOC_ARRAY(hook_head, 1);

Ack, will use it in v3.

>> @@ -85,21 +176,20 @@ static int pick_next_hook(struct child_process *cp,
>>  	cp->trace2_hook_name = hook_cb->hook_name;
>>  	cp->dir = hook_cb->options->dir;
>>  
>> -	strvec_push(&cp->args, hook_path);
>> +	/* Add hook exec paths or commands */
>> +	if (h->kind == HOOK_TRADITIONAL)
>> +		strvec_push(&cp->args, h->u.traditional.path);
>
> Should we be defensive here and have an `else BUG()`?

Yes, good catch. I think in another place where I verified this I
actually added a BUG.

Will add in v3.
