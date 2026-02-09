Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C932701C4
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661609; cv=pass; b=BguSReiU0hZAq46BU7D0DKp4WnjIKqBwNCE41gpqu2SZyHESk4mD0NxvDkAzuhsqmNTMnzUuTD5a0apuHGAP9nUt6DF/rRleB+++TGZ3z7E3iaBRJk56GvrU/PqMOUsb97QHdzOv5wgD6SI/q33ox79H1Q1gBjNhZXXcvwvQLcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661609; c=relaxed/simple;
	bh=nZSitt5IOJg1xFC7e9GfHfpFqXtNaaQ4G3AARCUPvtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k8EvlMF6p/cUKmBYNo5IqMEbHxxXXXaoYQE/cgePkrwIc0pQD6HUws0IxSkhjOYTdcCJkwS26VgqSpf64l1mcezZzJGUeWewoug4RHw7gfQ+1QDKBbaFKeml9gpltFID6NuGYpmPioBar4pGGC4943n4fmhiv+BAXAbCM6pO6EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=UnfXCHwq; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="UnfXCHwq"
ARC-Seal: i=1; a=rsa-sha256; t=1770661597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=boddCofJ+eN5xgPys7yUrW0qyr5OExu2S49bY8phWclFrM3+8FH77UQ3wEagQRRxzL6RTBMM3xVWa9Hro/IkjyWpQEfJp6g8RRPE7cRFWMG+TEl6z2/hlQOdYNpzTQbZxWTUSPFD+bIXGW4dYgwbM5ButfZrOpGVv2gbW8Ar5Ps=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770661597; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S1b13MOZXTOfW4JWooEy6cwq3ytiQEJUM/3rmCO0je8=; 
	b=lflbDnwM/iG/GTjT3cJDsc6iaCgDkvaPBXXdqZsvX1ZKx/Sp8597KBZunzHtt7cN7SI3iQYeaW/a28MXsJjvPmNTmgZdAOoZCxhZoxAKMKpSmdze/7K1E+J8P3VnG/kSnHiMO3vBuqe9HvM8Es7Y98wn1dVSVZCn5i3pQNqA94c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770661597;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=S1b13MOZXTOfW4JWooEy6cwq3ytiQEJUM/3rmCO0je8=;
	b=UnfXCHwqStDsMjfVhCBTUC4E/uE2Vd3e/xNBwRP8J5JBl2x+8ufGNeO06rC4Udi9
	SEta5QaZOEu8zFupV4Zb43IHeH5gcbI1QZ/p1GKiJROMIHJ5SnafgxNhKMHYeLBj4g1
	93DXN9r/GyVsy5sk4SR6S7iek+5Pbj9bsIlXAA3s=
Received: by mx.zohomail.com with SMTPS id 1770661594462947.4595751937574;
	Mon, 9 Feb 2026 10:26:34 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 2/4] hook: introduce "git hook list"
In-Reply-To: <aYnu8ltBUUflVgm2@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260204165126.1548805-3-adrian.ratiu@collabora.com>
 <aYnu8ltBUUflVgm2@pks.im>
Date: Mon, 09 Feb 2026 20:26:30 +0200
Message-ID: <875x8522p5.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 09 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Feb 04, 2026 at 06:51:24PM +0200, Adrian Ratiu wrote:
>> From: Emily Shaffer <emilyshaffer@google.com>
>> 
>> If more than one hook will be run, it may be useful to see a list of
>> which hooks should be run. At very least, it will be useful for us to
>> test the semantics of multihooks ourselves.
>> 
>> For now, only list the hooks which will run in the order they will run
>> in; later, it might be useful to include more information like where the
>> hooks were configured and whether or not they will run.
>
> I think the commit message could be adapted a bit again to first explain
> the problem we're about to solve.

Ack, will fix in v2.

>> diff --git a/builtin/hook.c b/builtin/hook.c
>> index 7afec380d2..4cc6dac45a 100644
>> --- a/builtin/hook.c
>> +++ b/builtin/hook.c
>> @@ -20,6 +24,54 @@ static const char * const builtin_hook_run_usage[] = {
>>  	NULL
>>  };
>>  
>> +static const char *const builtin_hook_list_usage[] = {
>> +	BUILTIN_HOOK_LIST_USAGE,
>> +	NULL
>> +};
>> +
>
> This constant can be declared inside `list()`.

Ack, will fix in v2.

>> +static int list(int argc, const char **argv, const char *prefix,
>> +		 struct repository *repo UNUSED)
>> +{
>> +	struct string_list *head;
>> +	struct string_list_item *item;
>> +	const char *hookname = NULL;
>> +	int ret = 0;
>> +
>> +	struct option list_options[] = {
>> +		OPT_END(),
>> +	};
>> +
>> +	argc = parse_options(argc, argv, prefix, list_options,
>> +			     builtin_hook_list_usage, 0);
>> +
>> +	/*
>> +	 * The only unnamed argument provided should be the hook-name; if we add
>> +	 * arguments later they probably should be caught by parse_options.
>> +	 */
>> +	if (argc != 1)
>> +		usage_msg_opt(_("You must specify a hook event name to list."),
>> +			      builtin_hook_list_usage, list_options);
>> +
>> +	hookname = argv[0];
>> +
>> +	head = list_hooks(the_repository, hookname);
>
> We can use the `repo` parameter instead. The git-hook(1) command is
> declared with `RUN_SETUP`, so it will always be set.

Indeed, it should be possible to avoid using the_repository here. Will
do for v2 or document why it can't be done.

>> +	if (!head->nr) {
>> +		ret = 1; /* no hooks found */
>> +		goto cleanup;
>> +	}
>
> Do we want to print an error message in this case?

Good idea. Will do.

>> +	for_each_string_list_item(item, head) {
>> +		printf("%s\n", *item->string ? item->string
>> +			     : _("hook from hookdir"));
>> +	}
>
> This is another case where we could avoid special-casing if the string
> list contained the hook paths.

Yes, I'll very likely do this in v2, certainly I will replace the
reliance on the empty hook name.

>
> I also wonder whether we should add a "-z" mode to NUL-terminate the
> output. In theory, hooks may be configured with a newline in their path.
> Probably not all that common, but somehow special cases like this always
> end up being encountered eventually.

I can do this, certainly.

>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
>> index ed28a2fadb..d2d4a8760c 100755
>> --- a/t/t1800-hook.sh
>> +++ b/t/t1800-hook.sh
>> @@ -10,6 +10,8 @@ test_expect_success 'git hook usage' '
>>  	test_expect_code 129 git hook run &&
>>  	test_expect_code 129 git hook run -h &&
>>  	test_expect_code 129 git hook run --unknown 2>err &&
>> +	test_expect_code 129 git hook list &&
>> +	test_expect_code 129 git hook list -h &&
>>  	grep "unknown option" err
>>  '
>
> Shouldn't we also have some tests that show that this is working as
> expected with a configured hook in ".git/hooks"?

Good idea. Will do.
