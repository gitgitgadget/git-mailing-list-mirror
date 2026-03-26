Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CAA75801
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529914; cv=none; b=bpsVgtM+mF/iLrh22OFaDAOuFPBsG1sWs7eb+SUL519cKg3CihfrugqaoT9bs1RC1h3nCuWoW1kSjFE8E4AHruXlqc0scS9ME9ilBff3wAx5694viBONcIs5kRH+Yk+krPPTUZ9fBJSyD7higMrMeyZcicdyZfuS6NZgE+jMH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529914; c=relaxed/simple;
	bh=9IFNN6AVDmAikAfmaVkTmSAuOJ2HhV4dQU1VNMyhNHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOeQKLpKvRUv9gRUeomfRX6QrDecyPpK5g2zOCADHEcQIrtqbIZN/OMVzMOPcTJNs7dCob/FqHSnXpog4YW8PvmDKdG4AcaP48aMIzPgCFhnj35/oaokiXHN7+0v0IFlgmsmUXGN59Yn7F9DsceP29JkP7p//Z1MpDyhsb+Q+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHj9a5pj; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHj9a5pj"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50b3488fb31so25968421cf.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774529912; x=1775134712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7Cunh5pOTlAzyMiqysaBmCZmsIgJcrDJ5wlH/yqOUw=;
        b=KHj9a5pjgVMbn4eiah/jTWP74Uxg+Gqx094uxLXpQ2hMowrQF2Emn2Y+cuUKYOvDXI
         wXo8Ezg/wk3R4Qit6y7VSERFnpQDO0o55qZUWWZJ0a8E0fbZIxBAeqAxDKMaKwGRWPzH
         /LctMxij5n7h3z428ZnR/lvAaNWiVjEF4bgcPYxurAVqf4ZAeA6MT2NkQnqoL7ku9d4g
         5+XDumXyJDVCdfLB4HIspLMh3bcSF1XDI7Ju2FJL6L4kBpUBRPiEeiigF51PaNxx51l7
         GcYWqllvXYekAHdeKjZ1taG8FiIyrvgEvh6lJCaXt8OXPT3GxqfY9dCO2d3XMZ7p8S0S
         RJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529912; x=1775134712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7Cunh5pOTlAzyMiqysaBmCZmsIgJcrDJ5wlH/yqOUw=;
        b=qC4k32AAYo92O//QAZUbJUyPZoudkQe64o6Vii8Gn9iJoj4Yr42HKI4/fX4Kq1i3iA
         gts4xgq/35sPZQRiBaL0R44Lzz/a8HN8e339fG4noG2Fb7FWghedgqcnFXL8aON3aKd/
         qUO3vg4+c/u1wqe9KRS9rkWaLMLGLukdL5t6ylX8ykFEo4VuQ39JLnCUvy52qJKNkfEn
         uE3gp1g95KVyejnrkz1C05JP0xq4nOH+lgVWrU+CZsIqJPs0Q3rUphc1sZj6HS/xkesA
         HYcOHIZko11AU6Srr7Aykny72YbUpY6duzvwEuAW2nGbja4BTB9E/bZrZMSI/oslfmH3
         JHxQ==
X-Gm-Message-State: AOJu0YzEG9ujwCUyoCrjxzNY2/FsLylIXChRb1LwVUN4p3EekWIDOuGH
	5uQpKhgDA0Ile3QYwQ0g8ccyxIwK27ZpzqBIpdLK5R8kmJYcQ1okw6Fy
X-Gm-Gg: ATEYQzzRLOrINdfkNMaJ8IJMRDu4YlXORSmN+LG1svplJhhR8cp0XYoKsXHaBEjZrpn
	P6UcqeTPSwDsiUIHeWY8n56ZGr81B/86DdhPCWwDncOq4OSS5OtPEQCX3ae8waE7T+jmp7gUczT
	x+6UaNVMdgOKdAp0KqaC3nBih7jJWQHCmjvtkTmmnNCcCp5nyJ+gZJkpT5jLzczHcWtvaptoypY
	TO9M/pnDf8i9JhPXjKqkxX0nuiniqP9zp2UZeZ2TWNXsOVlrAC3ac1ryCWDdFUEwL7smSpZ3UKo
	VU7K8iomiQ+rsgL1aqcKhaVpaGLGsa42P5gcwqUnusFCe3Kh6xdkmSApy8R2Zrj/pJQUwS336/J
	Bv605Fgx6VwvhWAGGUnYFqKVtP06IWM/gxr4tNTdsievN9lu7LwEvZGVwr8RGaB/zKk9bGYr8J4
	6gVFLuetkkn6Y39pFZTX+aSwWuH/+jyYJA2iMBL/jf9QhXO6Yb+Xxm17Mu6HxGGlt0IpgS+C3op
	2kiBAg9
X-Received: by 2002:a05:622a:ce:b0:509:16fd:ac37 with SMTP id d75a77b69052e-50b9950036fmr14956411cf.29.1774529912188;
        Thu, 26 Mar 2026 05:58:32 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9234d902sm24754551cf.16.2026.03.26.05.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:58:31 -0700 (PDT)
Message-ID: <47cc997a-9a9e-4733-b5a3-ecf9f860a8c7@gmail.com>
Date: Thu, 26 Mar 2026 08:58:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] backfill: work with prefix pathspecs
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 r.siddharth.shrimali@gmail.com
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
 <f8f2c613260458e3c86109888ee1c51313095319.1774266019.git.gitgitgadget@gmail.com>
 <acJEV18rQAh2i2a4@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <acJEV18rQAh2i2a4@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/2026 3:59 AM, Patrick Steinhardt wrote:
> On Mon, Mar 23, 2026 at 11:40:17AM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/path-walk.c b/path-walk.c
>> index 364e4cfa19..0d640e2f24 100644
>> --- a/path-walk.c
>> +++ b/path-walk.c
>> @@ -206,6 +207,34 @@ static int add_tree_entries(struct path_walk_context *ctx,
>>  				 match != MATCHED)
>>  				continue;
>>  		}
>> +		if (ctx->revs->prune_data.nr) {
>> +			struct pathspec *pd = &ctx->revs->prune_data;
>> +			bool found = false;
>> +
>> +			/* remove '/' for these checks. */
>> +			path.buf[path.len - 1] = 0;
> 
> Hm. Is this _always_ safe to do? We add the directory separator a few
> lines further up, but only in the case where `type == OBJ_TREE`. So in
> reverse this may mean that there are cases where we don't have a
> trailing '/'.
> 
> Maybe we should instead:
> 
>     did_strip_suffix = strbuf_strip_suffix(path, "/");
> 
>     ...
> 
>     if (did_strip_suffix)
>         strbuf_addch(path, "/");

This is much cleaner, too! Thanks.

-Stolee
