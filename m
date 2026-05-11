Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5273F7889
	for <git@vger.kernel.org>; Mon, 11 May 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507929; cv=none; b=ZPRBoLP7EfxQmdiB6rGUUcgFRXdwhZEMQsp2Yo5FvFoHqR/kx3mhMgdG1tc/J8gbjXRJzxpN/QXIbm/rNbGwhQjUpj90lQOu35h/cIcYQJN04oZMYHSd4uNllAM8fK4wAQACLTP089XVkaew+7KYEAN/DyuqmI2qRM1Qgxgn8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507929; c=relaxed/simple;
	bh=e5VL4KenPBHzfhzzLLT4c2OG5SPjBCmzUVwZQBk+0vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQswl0iETKBletCG2AatFCJyovp+DnqDXmbryZJ9y8SjZS4EG77rPs+Kd6oqAfS0mxwdH3V2j2FZZ+lQutpT92LTObyi0xUqsu7v0CQHUp12s7cdJZlZ0mpfZinZ0ptTfr7hm7zdAliuyA7G2CD3rSbj9gjZYH8GjiGeTkI9Nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGS+JNCn; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGS+JNCn"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b4298d271fso76042376d6.3
        for <git@vger.kernel.org>; Mon, 11 May 2026 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507927; x=1779112727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+pPI+a3ks1BHX/rkowPa8PYp3Dulj/qexJ5qIebATo=;
        b=TGS+JNCnkUmYmOZtkgM1Wkoacn8hOPY+t+1/htU2OFkRZmoONz8m0pwD7amdMcX08/
         XbbunNB8Zz06F+hNz/fkYszx38DcZgnIDIbTJWzcHIVW25I2KLhmf5B50M4X3l0lo3iu
         IO5Vv7eM4MhW4qDikiREjL/aLo9dSmPNWnvdxo6cc3MeIKuPvRA6nt6qMJFMYskfjFEB
         5hgcJTQ0D2WXaUeEppt/3b/xk5sPcWJxPozz8DH2HSnOh/D3e9gzy3nKhJ6/m4rcYFyU
         A5pMDEYCgVDMhFUP6re9eUSarWWcI1Uohs+2uS3nzKAHbUZuZYJ59GBEl90eaR8v58c7
         o+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507927; x=1779112727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+pPI+a3ks1BHX/rkowPa8PYp3Dulj/qexJ5qIebATo=;
        b=r/otrT+5/eH8ZQrw+Nf1ZSjZhT38QK23cE3gkqVhPJR1pidfjr96j6J3l6R0PLa8Ht
         0gf0VPzy5ZioWfP9xye4DYD53xeyzZDEkVsLaTA9js2RhFCgAh3vGMdvrnbaL+pm0R0n
         ZNC821lEOKmdRZtUEtXrFcgtIWVmi9OLWKNSYSpm+/30hELGZuMwzt+aM7m93xfyS9ak
         4u9cO5BNMpYj1JjhthB7S6W7IpYJlwq5Jz2KYtQuPs6Om1SuO2uxUwg4X42d6vez4zla
         um/wbtccLfju9p49OLWPkzRr0oYkS/o1C2KnzrkMM2WaKU7Y4o6LwHUe/TH8YSdkZ6fe
         eGkA==
X-Forwarded-Encrypted: i=1; AFNElJ8guygjOWQCyn9eSMjRXzHF/EtZcWDGSOkPgiaDBfuh1BO8fQT+SOkzIQIDunqCB5MgwDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFP26EixOjVzRkNNMOwlDWz1TsUjYaJqho8nyvQLEQFuyi/2B7
	PJZ1oTjIUwm3gzN96q570wEiKZzH3sb2TeBgNSLWge62Tce8FwojtduY
X-Gm-Gg: Acq92OHg8eiyl2kBesSF9d/G5CTUsxOmZqw6TccDiJm7eaHAlcgpw+58CoIyvNccDDl
	9r6PxIFgmBbb1zEKSmw7hhfwUeAjRuakhliveZ+7X0SWibfoT7TqEIzrlPzzbTp44k3gjz9iFME
	SMjGldEktjSMTDiiLSmjlmVsxDs2mjMJxvDlPFuXoFYO98MauHjGJoMwBVVSZfLIcdhe/K9GLTJ
	1ANV2dZ8N/RtjsUO2gIg5hr8S/Caazx197TkJ/LN5XglQSKTtQPZlJkcp66Rivpe5Ag9CC7IUWG
	R9WycdyJ2jKtldbVM5tjyif2ZQkiFoK68mE7PQ7chbaVJYr/2VCbs2UxPhH4Hur45qQAPjhKNr/
	Eqcji1CZnR2xhj1y/vrTIemJ1LbTX247Si9KtqGZ5KWJ4J9J7GA+i+vWFusjW0RmlvYepwYSphe
	A+q+pb9y00McIRJ24vQkaL+ks5uTH7KMi9cOCTkSL+CselUw3eRK7TYofrGCVOmb1fHxkQVA==
X-Received: by 2002:a05:6214:2f0f:b0:8bd:de6d:c340 with SMTP id 6a1803df08f44-8bdde6dc6b9mr297652286d6.26.1778507926356;
        Mon, 11 May 2026 06:58:46 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c370095a14sm46602186d6.12.2026.05.11.06.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:58:45 -0700 (PDT)
Message-ID: <f16da7bb-0aaa-4cf7-b10e-1fa334b235b4@gmail.com>
Date: Mon, 11 May 2026 09:58:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] pack-objects: integrate --path-walk and some
 --filter options
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, christian.couder@gmail.com, johannes.schindelin@gmx.de,
 johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
 <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <f5d8d4aa-2453-45ef-bc96-2b94bdf55c7e@gmail.com>
 <afo+mEITFBSLevqV@nand.local>
 <07b36bd8-376b-4a98-a735-0c0f75452c24@gmail.com> <xmqq8q9qtzly.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq8q9qtzly.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/2026 11:05 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 5/5/2026 3:01 PM, Taylor Blau wrote:
>>> On Tue, May 05, 2026 at 12:18:28PM -0400, Derrick Stolee wrote:
>>> ...
>>> I think this is a consequence of us not sending directly-referenced
>>> blobs with `--filter=blob:none` when running the filters through
>>> `--path-walk`. Something like:
>>> ...
>> Thanks for this suggestion. I got pulled away from my investigation, so
>> wasn't to this point yet.
>>> fixes t5310 for me. I haven't looked into any of the other failures yet
>>> since you mentioned that you're looking into them, but let me know if
>>> you want to tag-team any of these.
>>>
>>> (As a related side-note, I noticed that GIT_TEST_PACK_PATH_WALK=1 is not
>>> currently in the TEST-vars CI build.  I'm not sure if there are
>>> historical reasons for leaving it out, but if not I think it would be
>>> worthwhile to add it.)
>> I think the initial idea was that the feature was too niche to add it to
>> the CI builds right away. Your series is going to make it a lot more
>> important, so adding this to CI builds may be valuable.
> 
> Should I expect a new [v3] iteration anytime soon?  Not getting
> antsy, but just going through the "What's cooking" report to see if
> there are things I should immediately advance.

I hope to have a new version today. It was a more substantial change
getting things working correctly and in the right points in time. Lots
of rebases and rewrites have been happening.

Thanks,
-Stolee
