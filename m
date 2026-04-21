Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4D2ED17B
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787421; cv=none; b=Foz8WLEl6/LvpoivFTSYAR/sX5RQBEQ0Ff2rDJjqECArerqFekJMtOdtt7P9qx3iYTumczThiMrKPvO5d1Oe2Gvl38EsduMiBNQFEue6qE7/dxq4wtsflV2nathS3HAU6sD3zz2h2zBkXxitiHzn06oD9Qmn71LJjRYGSL1G+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787421; c=relaxed/simple;
	bh=IBAe/ou6mVd09UUQWsEpPnN/BNJ2D4LMxqx7pS/wmU0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=GXo4ZSWO97UFQbZsN3qEr0ghgG2jK4BHsy+gRjRLg+1+/FZQpkFNhe8+tm1NDv/WKGuld1Tt5/sRQShsW5aLqQ72KSO6OM5sQlkVoDI2Tm9rNzouCUDe8WHjOY0g/Z6Y3VFyY+rFxX8Xo0jj4NrKnq4VJlZyB+qJ9BjOba/t21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5QhZwtn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5QhZwtn"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66f8f556f39so5647627a12.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776787418; x=1777392218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUz4ZXQWlnh/urPm1IBaWAeO3A/i868T2zUlSep50N8=;
        b=Q5QhZwtnQ5pvjc++j5N64QvMygxTbjL9OX1ovgFY1RxOhXQfdqZ5QOKSP5mnXiOIx+
         wLCBHtkRPvfsP4FepoaP+galZnMX77IbPcWLhGEABKmvgwgmfxXGlvjnn10LZtGHhlE3
         PVe5Uay47yhx3tQVs2yuBn8PgQVoF9Pbl1J/lHJdShjYc0SGvCKk049vk2ukqLZB+Car
         Uy4nNJOStgXssaDGJxWoeaMu3yJBLGht0EV2W3vuSQfpzu0zNfs2VPceCRZgIZncSubV
         0EY4qimu0XiHIdT5Gzgbe6zVP2ZMVp2er1ziecNQTEdUlLhskFpZLimxwL/8S0uSSTHa
         iHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776787418; x=1777392218;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUz4ZXQWlnh/urPm1IBaWAeO3A/i868T2zUlSep50N8=;
        b=O6M5BDw6I5b1/koq13WNtTttBUFXTbmYgM/hk643L/ovujm//3mi0tzlpYusLRi02s
         y4KJ+u1j5h9KRFN3cB37NZjKJTcYY7aH9IB+1XmOiI/R7sHU2ygV6hsinmjUlS5SqCUH
         aVCY0yXvHUrA5qiSw3PHccv+q1VnrE83T3WGo119qEeOsqNLA7yxFGogEyIW3Pqu+KaX
         pjGl5ugGBNuBSaTcviyKzqlqLT7wsvZONshLzyDMKZAk5oyzKPuFNCbTKN/NnycDrmWH
         QJ5yybtqjNbHlJvrq5dsbqaniCRVBAG1od6RCqtHp7Ov0gFDoquKbRPHVK3WfZeyVIvU
         mfNw==
X-Forwarded-Encrypted: i=1; AFNElJ8WV9zCBtKvLARxYp9g6aA7vjlLJpciMEmXJVGpCsNgklLFNiWFNiliIViCrQXA3xj7RqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJmvZl9YgBTJzcn5TAJUvgAoF7xBekDTkzF/+B+KzQqMo0HhN
	uOMfVERNrP8Ec41/dm73fvABTuGZhvRWOuGQi4HOlGkYfpV2owwRkhUM
X-Gm-Gg: AeBDieu320FdGbe+7bHBrOXemjkitEhXYUVxQnVs3juIjFl0bGOH/s3vPAFTQPmztSL
	BNyonekgA7VUtFoPmbu15KchgpMO0g5276Gv/JpQC9b8mbtcgfTx3gd6CDZwd7qJp+8uohG4izt
	dbry/jhc9r8NQunpvDiVM6kDXHsXaxQisWlEsWz44t++ypykv2i1T4nHtHRMan4ewg9gmFEfzL2
	asWs1ObjwKYSaGUoQBfAXfncP56qpasUeeQUVmWoO1wY3igbH3iB+kYXjRSrej4BqXtaQrOCQj2
	9+eR9FFko6ByZh8puKFhOizSrH1qkEDcCt0KPeAO6wMMoS7IB2f23+PZ2v4qlAZwC+AuruU6ymC
	kLhIyuMJDHWcXqKuUHNB2lSoPMM5tSdc5itY6rqT8MhJtrcRUFOg78ooCaz7TjsYiMkH7Qsl+tO
	5mD3D0XsBeNRPGFzJhwbrO3qxS87ZBcoxVsS/fh0YOfhVV/4F6uYnf7WRd/ykKX69zXoFiMFjDz
	xDCc7n1ibf/DA==
X-Received: by 2002:a05:6402:3586:b0:676:6eaf:52be with SMTP id 4fb4d7f45d1cf-6766eaf5d05mr3203208a12.13.1776787418032;
        Tue, 21 Apr 2026 09:03:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c480e31bsm2777128a12.11.2026.04.21.09.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 09:03:36 -0700 (PDT)
Message-ID: <9b239518-7b1c-4125-939e-38ebe69ed004@gmail.com>
Date: Tue, 21 Apr 2026 17:03:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] status: improve rebase todo list parsing
To: Tian Yuchen <cat@malon.dev>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 git@vger.kernel.org
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
 <b62a96c5-fab4-4c6d-9768-ade48a8476ca@malon.dev>
Content-Language: en-US
In-Reply-To: <b62a96c5-fab4-4c6d-9768-ade48a8476ca@malon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tian

On 20/04/2026 17:38, Tian Yuchen wrote:
> On 4/20/26 23:04, Phillip Wood wrote:
> 
>> +    if (!starts_with(p, abbrev))
>> +        goto out; /* object name was a refname containing only 
>> xdigits */
>> +    p += strlen(abbrev);
>> +    strbuf_remove(line, p - line->buf, end_of_object_name - p);
>> +    end_of_object_name = p;
> 
> 
>> -    if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
>> -        !repo_get_oid(r, split.items[1].string, &oid)) {
>> -        strbuf_reset(line);
>> -        strbuf_addf(line, "%s ", split.items[0].string);
>> -        strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
>> -        for (size_t i = 2; i < split.nr; i++)
>> -            strbuf_addf(line, " %s", split.items[i].string);
> 
> I noticed that after this patch, refnames shorter than seven characters 
> are no longer standardised to the standard seven-character length, 
> because the 'start_with()' function always returns FALSE. The code jumps 
> directly to 'out', without completing or cutting the refname.

Do you mean object id's rather than refnames? We do not want to alter 
refnames, but we do want to abbreviate object ids. You're right that if 
the todo list contains an object id that is shorter than the default 
abbreviation length it will not be expanded but "git rebase" rewrites 
the todo list to contain full length object ids after the user has 
edited it. If a user may edit the todo list directly without using "git 
rebase --edit-todo" and then run "git status" before "git rebase 
--continue" the todo list could contain shorter object ids but that 
seems pretty unlikely.
> 
> I’m not sure if this was your intention, but I just want to point it out 
> for your information.
> 
> (Also noted that there is a very rare scenario where the OID of a 
> refname longer than 7 characters happens to begin with the refname 
> itself; in this case, 'start_with' returns TRUE and the string is cut 
> incorrectly. However, I think we can safely ignore this.)

Yes, I think that's unlikely to happen in practice.

Thanks

Phillip
> Regards, Yuchen

