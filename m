Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B435AC1E
	for <git@vger.kernel.org>; Sun, 10 May 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420249; cv=none; b=cq8fN6HUAOwIL1Wuwu7348ncAMxgi1oH2KsoKO52Z4WG32dzK0yQ+sME+Yi9qgW+RKtcqJIp58eODghH7jUZk9wjuesJ1sYct0D2TLVx36nES1Ez5QJ+1f3QW9UdaeszqC2fPHkFpqvIg8wjG2xslOO644AwepEQopZt35v13YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420249; c=relaxed/simple;
	bh=5ROuzohquZVGIBQBzSagAi9GfYjGp0ssRVhBbkEh3sQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GJejPnlKckDJiNviqXOqIOuMQ50kcdLSqU4x2ztntQ36HSBkO0X6jE+zTtdAq8IwikBI9nFSs6kd1ZPXfLAlTDfUSyLxxzJEMi6eBBYHzScaZ5jcEsn9imdWoUdi2evcsRREDdF0Ngm2ymRunkA0SdF1f2/9C4H9Dg4HT8S2n2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk5Mk7io; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk5Mk7io"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso31776005e9.3
        for <git@vger.kernel.org>; Sun, 10 May 2026 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778420246; x=1779025046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bM1kWLVirnzNWpWUxDHLiY+nVpBdPINMk3Tk605e/k4=;
        b=fk5Mk7iojWutBEe/zn1/Jb5+oyU4EFx8fNU6nSoYQ5dcgj/KnT3lBl0lk8dP5r30Mr
         2npRzeBeQuCr4xaoXHSxFW7ItFF4rAJT0BnJsjTMxiFndCHw3kuF+rsKApNyIMEf+DNg
         j4gmNpptgqEx7fu01AY2WESg2r6Go2OU0zIyGNmjsGJuW1S3mR1d2+ljB3ZC7NuuXD+2
         xAc7vtY/RClJG/CrRunzjV3euMZnXQEDwM864IGdXJkfmB7q/6dwL+uceDwg4m3BOvv6
         uLA7unbzvB6ohITNOvHBSLTd75JWEQw2kAvvNcZxAO0JYJcHS9zg6hUvDPn/CdJTpPS9
         orWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778420246; x=1779025046;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bM1kWLVirnzNWpWUxDHLiY+nVpBdPINMk3Tk605e/k4=;
        b=VEIsiQKaH62L5qNMyZIJvKTI0HExjmMeFhBScyaw+VdTqq8XMj4A733w6SqazTudbR
         o8q0UiwPBur8fDSJ8FSGPEkPp5fKhGUJzZEl8Fv+/oAgFk8gA3/1i3x0PNiL8L9ffIjQ
         YYeHwj/K/oGlQkQO8etDTyAhUEsWk+nWJp93Y8/bfyTy/8rtarUamFVTzMouzzUYuc3x
         Nll43BoRwVHjpofmT06cAGnq/uUPJAjrrTEdkjleDXRWEs8ggYvfp+c7hBCJhENrXEfM
         8r/NUDLAOSHFuEJH/hp3STP26/Fam7vbYPxZI2XKRlBU+ujq6t1YK6WACh8UhSOXjqEP
         Uksw==
X-Gm-Message-State: AOJu0YyhmcYMbFDeE1zfyqsbpMqs66klZv7CpjBYaXby43hHjORmRB1v
	tENfEBjINMWCqAqTNYlq/hDxn2vrH+gmGGmDAqwgtQIqyak40qkPigPc
X-Gm-Gg: Acq92OEABEGmA34iiippUP+wGhK46/RrbJuFngBJpQQwy90QdrpBiEPQU9ZW9W19ME3
	ic8K4n3IL+duoGodDfqU4/2pG8xiofe1ChuLpDkB7WHxl+QXup4+p6Q819BROFbnTfaJmjo5GSK
	u0MiRhZJxwoBWTHlxkJ5stNFCMszHk2NLr0BhizbhSiDWD1Bx3toC4XZlyYKUDBK3DHIspJrzMg
	d3/rbp7ibd4Rim8PfXPg3KfVc9TdB0EKuMHr5oLdV9XhBTIF0e3oY8M7aDKzsG5CzPApG6a+eCT
	MT9+ikkSmSTSC81JBcjOUKDHxcxX0E+9KzZaAfnJJnBuNxFiF1zNNOw9AFKyjw51J/RrQCPWbMr
	bNC8SSvxqRVnVHBhM6LQrA7PUqqwUG9vfssryDIaOkq63NYN9BxxlE+hnzqx4akA0yAwJ66tGYl
	Lec83aPpzbHfYqe+fdxmwYwB2hIerXj+76s6rIymgCMMWBzVRadBnmdnwiDFWYt7ut0SlpGKJN+
	Les/A==
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr303781195e9.4.1778420246022;
        Sun, 10 May 2026 06:37:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:131c:ee41:99c0:e0a6? ([2a0a:ef40:76d:4c01:131c:ee41:99c0:e0a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db02e6bsm54265955e9.7.2026.05.10.06.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 06:37:25 -0700 (PDT)
Message-ID: <0911df2d-aaa2-456e-a678-345239cefc67@gmail.com>
Date: Sun, 10 May 2026 14:37:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
Reply-To: phillip.wood@dunelm.org.uk
To: Junio C Hamano <gitster@pobox.com>, mail@abhinavg.net
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <20260506023944.90691-1-mail@abhinavg.net>
 <xmqqqznk9ih8.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqqznk9ih8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/05/2026 02:11, Junio C Hamano wrote:
> mail@abhinavg.net writes:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index b7d8dca47f..25bcfc5da0 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -6428,6 +6428,16 @@ static int add_decorations_to_list(const struct commit *commit,
>>   		const char *path;
>>   		size_t base_offset = ctx->buf->len;
>>   
>> +		/*
>> +		 * The global decoration table may contain names loaded by
>> +		 * a previous pretty format such as "%d".
>> +		 * This will result in refs such as "HEAD" being present.
>> +		 */
> 
> Your long topic branch may have local unannotated tags that point
> into the middle of it, marking strategic points in the topic.
> 
> With this change, the command no longer moves them when it rebases
> the entire topic.  Isn't it a regression?

sequencer.c:todo_list_add_update_ref_commands() calls 
load_branch_decorations() so it does not update tags and the patch is 
correct.

Looking at make_script_with_merges() it also calls 
load_branch_decorations() so we should probably add something like the 
diff below. Having said that this patch is a strict improvement so we 
can always fix make_script_with_merges() as a follow up.

Thanks

Phillip

---- 8< ----

diff --git b/sequencer.c b/sequencer.c
--- a/sequencer.c
+++ b/sequencer.c
@@ -5982,6 +5982,15 @@ static int make_script_with_merges(struct 
pretty_print_context *pp,
  			const char *label = label_from_message.buf;
  			const struct name_decoration *decoration =
  				get_name_decoration(&to_merge->item->object);
+
+			/*
+			 * If rebase.instructionFormat includes "%d"
+			 * then we to skip non-local decorations as
+			 * we're only interested in branch names
+			 */
+			while (decoration &&
+			       decoration->type != DECORATION_REF_LOCAL)
+				decoration = decoration->next;

  			if (decoration)
  				skip_prefix(decoration->name, "refs/heads/",

