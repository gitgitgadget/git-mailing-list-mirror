Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C346434E5F
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781613; cv=none; b=JC40Gj3MgBiQBTIRu2R43uIU4nKqi+2MOZpVRuCkgsKc/d3jLNh5b7Vk0LCJ7v/9Lf1SvNzjRB1ikeLa/XsjUWRqi3vOHyxgEtV6Rt9oFNJJGt2yOd1escbhUMroQDxKtT1/nRGpcu3qNJ9rtXajNbILS06mfVEeGbGFiOCec2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781613; c=relaxed/simple;
	bh=q68RCTLvVbAEzMF8BWsiDAp/FBRFRdG7EVdzzJj4tZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7vBN9xNHY7pNo6oy95U/lGiS8ESXzSK8BrFBdoXB50e1wrbq33JxaCGj8nfOJajlUP0xnxSLbiHdkpFfT2NFzEypU35do8vEhiMhUxOuAdMvr6ciHJKPi3xsSMudB4PJCoRnt1yUgCxNzcLoRqh/4kuwvlAgIaYv5LDiVUHVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk08LuV5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk08LuV5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d9b60c652aso41030595ad.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788781609; x=1789386409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V8UqM4cdR45WAoAoOr+fAq0cKgPHyenmqx+OkhVOoMw=;
        b=Gk08LuV5MhztBDU49S/o9Us04Q+OuYQEXAh0hTWr+DRBWBmMcbEh3n+GaNhS4vxKJ7
         /MF9IlOOMTK+RuvAELIbGT1Ayje2XUbP+SLyFmc8WDvNRAT3cW8ibGC7K1ys4PdJkXXV
         XsXP+T+zS8tJNGS1Y7njoskGBM4kwjlP9o18ywKYNk7J1kenvJ5/btLb8X3A2/qf05/O
         rUtJjMbBzeEe1OzQSEDKY1VuYQ2XihJQPhJcx+KLBpiEKITnbXtaBQFxJkIx6tZ7oiDE
         fSRKh9STtLQN45i+ecFJpCJoQl2m/6htg455SAXi13g/8SICOWRDvAWnuZ69rdsYXSxH
         TX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781609; x=1789386409;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8UqM4cdR45WAoAoOr+fAq0cKgPHyenmqx+OkhVOoMw=;
        b=M5vWbz9OM1s1DKdhWOpPDT+jI6CnnBy1lfclGSfUyQdI5MsbR3eKa1YSOMfjV32NgR
         I1Q0b11MOPS/XufaaSCQ2kAfEcawBVCz+cQIADhjIRIpNVu4HRs8jPTfExMohSQvLRuy
         X5XQ0gD/Vhvs8Q+BJxlEYl/xs2GGfEwZ6KzXDBpESeUSmr1+i4ohmC3GXWuFQ+F/StvW
         1JN+93JFyK4SI7qTvBc3wMtDR4O3ta140z/U5ei0E2m3lwk7Hlai0YUqrEb1PT5rAxyW
         Sl28PCJW6J1K2IdjWVKeo/FRoLB6JxxA3kyr1NkXZxjVYsYPPDrsx9megwHhC37EIqfk
         wy6Q==
X-Gm-Message-State: AFuF++lZ4i3aUH1h5rWNG5T4h9gG1kVCShZMHzMMcTQAQhjHpFKAwxEU
	ZVdaVoeoCzl9uR0XsP0Z9lJN0lUd9rw87q+XgrZIiqwyOEaNwSbC3SUM
X-Gm-Gg: AYBFou2s8wB9hjnq2mKSmPk/cC3fWzBgfkV4E12+sAFIIBv5XYB5hwJ71McyL43usdn
	QxWDRETs0Ddf+O1CC8mH0vlLVcsgLFLvNstvcULg2LjFYd4iXgf9cAsQ08sMRISWN43IUtDYuNq
	4Pppq/xmIvEFsf42Qkz8PnQoX0+4SxNyYSakoZuvOMNCvCih1bC3KQApggxdWhqVdmQy0YZB5JI
	2LnlxzHpqU58AhtnACv5pImloXkHmxxBFga9MI/0jGdqMOAm7piBH7NI0QfRGmFy52xCuLDq9+l
	Auj2JvJDPH9ySi8WusUbEEZH2QqFjXVMpez/QDMiOIXDz3UFBsooRORAMDmCi4ZxbyxsbfdP0G7
	C6hakJM7tsXOjRuHoxaJL5Iij2OEOP5KmRevRoiIUMrtItaseuVyfkruWiPtnJ875JxcZUYLIyx
	Wp01hdEdarTuO8OUeXfQzvNyH/JrvASM8Com/QaycDF/wm36cquuJTosVTGmaf9MLZ5axNi5OHN
	2rmhUqh1c6vZV7s7qBhP40s9ozn9wiRa0znrUscb2WS
X-Received: by 2002:a17:902:d48b:b0:2d8:d4cc:be62 with SMTP id d9443c01a7336-2db12840380mr329188405ad.15.1788781609442;
        Mon, 07 Sep 2026 04:46:49 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:d4db:6da0:b92c:666b? ([2406:7400:12b:61a6:d4db:6da0:b92c:666b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b9f68e4sm29056865eec.24.2026.09.07.04.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 04:46:49 -0700 (PDT)
Message-ID: <c12fe123-bf10-46f1-b369-b582a623ce19@gmail.com>
Date: Mon, 7 Sep 2026 17:16:44 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: history: 'reword HEAD' surfaces a memory leak
To: Patrick Steinhardt <ps@pks.im>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
References: <04faa984-5b56-406b-baa9-dbb4b5eab259@app.fastmail.com>
 <ap6cU2elXvmlLgb8@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <ap6cU2elXvmlLgb8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:43, Patrick Steinhardt wrote:
> 
> This feels familiar, even though it doesn't reproduce on my machine. Do
> you have "i18n.commitencoding" set? In any case, I think the following
> patch should fix it:
> 
> diff --git a/builtin/history.c b/builtin/history.c
> index 000155ad9c..bca95b9d05 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -158,6 +158,7 @@ static int commit_tree_ext(struct repository *repo,
>   	*out = lookup_commit_or_die(&rewritten_commit_oid, "rewritten commit");
>   
>   out:
> +	repo_unuse_commit_buffer(repo, commit_with_message, original_message);
>   	free_commit_extra_headers(original_extra_headers);
>   	strbuf_release(&commit_message);
>   	free(original_author);
> 
> I know that we've already been discussing this memory leak on the
> mailing list at one point in time, and we've already had a patch similar
> to the above. So why wasn't this merged...?
>

My bad, I suppose. There was a suggestion by Peff that the commit 
message was misleading. Per [2], the leak only happens when we get a 
commit that isn't cached in the commit slab. I was trying to identify 
the specific case in which we get a commit that's not cached in the slab 
but eventually got busy with other work. I will get around to it soon 
and send a long pending re-roll.

[[ References ]]

[2]: 
https://lore.kernel.org/git/94b0bed5-c86a-4291-b958-52f09faebd29@gmail.com/

--
Sivaraam

