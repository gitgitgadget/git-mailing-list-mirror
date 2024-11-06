Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEF1DE3B3
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891093; cv=none; b=HwiOyiFmRvPdDPrlSO4D6+ghRsTqqiO3ETSeGktURZJTiQrkp+O1Yj+ouYJYO0Yf2owOHLiUw/Tmdo4WdMYJWs6swzAQZ08bfMsLABZDB3qWtBLMfdL0MjEkItkWh6sp+gC5ey9tQsuqv1lWCBf5aliRlDoMdNGX/nKPmk03Lf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891093; c=relaxed/simple;
	bh=FNdKtjS9d6w9bnBYkX6xq/0zdT3nn4yCGT2P9CRfUgY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IqZMuqteDIzzG29ReTPmixq7rLekRS7dnI0ldOcrZRtRt2FWwr+MgWG7Qp7p6H8Al2ad/7R5wxfXQ54NSTbiBCjqmtIRJYy/BGcXw8fgZIDxTwZDXVbzUYHa18ejllhId+6jAAmykz63teAmMfmGTI0JgejFNb/6p4avZesqP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cyego6x5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyego6x5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431695fa98bso51361475e9.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 03:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730891090; x=1731495890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVfnJwL7xKDjp7r3r056t3q2KUq3GrAftpPTKesR9rE=;
        b=Cyego6x5GfapXQAEVDAj005lmwWJvMI3iGqMf7InmD0DQerJsD0j6V/TPUIfhier8R
         Kn+x84KEtrZM6rakqBCqA/cMn4+TWcYhlQRhxpq6gUGdt8E2lsCiDN0QESjXUm00PkM+
         TpHU9GGXbdNFmPxYeYGxI/Ipm06Ixufre4dJywhlqtvIUtW74W6JWWYSksibyo68K7Df
         42oErk9xoLBJgJiom8ocGGdeYhpMVDqU1Vs7YELNPqb2uPEVKX06IDC64hfUMnOqiBWv
         I45lRO95h1JUdo22n5/fZvGwwWcNegnM8gomFVCAXLzogj/dL9U/4TcC9XloO6c+5l9C
         X5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730891090; x=1731495890;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVfnJwL7xKDjp7r3r056t3q2KUq3GrAftpPTKesR9rE=;
        b=NiYru9aa1At2Cd4MJEZAQOzzoIf/qgs8IsejTYzcGnl47YZPdxAl9sERSaxs4BlPq5
         6Uept4kpdSQUiL8I1sQGkWHGWzob0kUhpnLCF/mKLh0HZ73LDv4MEW4bDM/WUMob+KeD
         AXesXHdemVnPZFrzl7Uz5rd6wHquJrTOq+rky8RN4uv7GWVnDMiOkPcXPD3o+7sGfoMn
         2H/SNuevkrmLgfq4K7lWmud6xoXopxKGtkh6AZzcqeDRued6yyvXzboJvJO7jMeR0n3d
         EjeQJ9o9f3yNdebGehDgof5pXg4vsgULJScf4dlq+AsAIK0AsFd18Vp5jlrwFASzcxWx
         uGQw==
X-Forwarded-Encrypted: i=1; AJvYcCVhH3BcdMktOSiQuGPxMvPRbSjWOiyADYTU76lOIV44RoOwwDCDCigKTgxvrcME1vuCYvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPS+t2eAAnHYMjqb4RHOE8FcMw/fMerlDlZSw6yp3am2Wzh08m
	//MFPZzqpFMhNB+YSoLSOwQ22BNcMssD6E7mm0B7/9TI/z/IGbte
X-Google-Smtp-Source: AGHT+IFvP22gijk1tQWQMF7U4h4bo/aXsN85Okbh9EaQiIUAfV8ANikR19t8xcDFVGr5mQ9A9/bUPA==
X-Received: by 2002:a05:600c:3b1f:b0:42f:310f:de9 with SMTP id 5b1f17b1804b1-4319acac7fdmr318113095e9.15.1730891090236;
        Wed, 06 Nov 2024 03:04:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158? ([2a0a:ef40:6b0:6601:5a4c:6f5b:4f15:3158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4392sm18793726f8f.36.2024.11.06.03.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 03:04:49 -0800 (PST)
Message-ID: <43dd8960-4438-402e-ad45-973565a6860e@gmail.com>
Date: Wed, 6 Nov 2024 11:04:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
To: Patrick Steinhardt <ps@pks.im>,
 Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee <stolee@gmail.com>
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
 <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
 <Zym--GVNJt_lsQEz@pks.im> <b548c532-e54a-4edc-94aa-f3c2925602e6@gmail.com>
 <CAG=Um+3D3iGPRv4t4DcCP=Bh7gbAQ6cSJ79jmg2h-qbSiQRkUA@mail.gmail.com>
 <ZysQvUyxgdRqjvj2@pks.im>
Content-Language: en-US
In-Reply-To: <ZysQvUyxgdRqjvj2@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2024 06:46, Patrick Steinhardt wrote:
> On Tue, Nov 05, 2024 at 09:56:52PM +0530, Shubham Kanodia wrote:
>>
>> Let me add context here based on a few things that have already been discussed
>> as a part of this thread or an earlier discussion on
>> https://lore.kernel.org/git/CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com/
>>
>>> I'm coming rather late to the party and simply want to review this so
>>> that the thread gets revived. So my context may be lacking, please
>>> forgive me if I am reopening things that were already discussed.
>>
>> I don't have a particular preference here, and this was discussed in
>> an earlier thread
>> where Junio opined (https://lore.kernel.org/git/xmqq5xrcn2k1.fsf@gitster.g/—
> 
> Fair enough, thanks for the pointer! The reason stated by Junio is that
> having a space-separated list of refspecs makes it easier to reset the
> refspec again, as we can simply use a "last-one-wins" pattern. And while
> I understand that, I would claim that we already have a properly
> established way to reset multi-valued lists by first assigning an empty
> value:
> 
>      [remote "origin"]
>          prefetchref = refs/heads/*
>          prefetchref = refs/tags/*
>          prefetchref =
>          prefetchref = refs/heads/*
> 
> The final value would be only "refs/heads/*" due to the reset.
> 
> So overall I'm still leaning into the direction of making this a
> multi-valued list for the sake of consistency with other refspec
> configs. @Junio Let me know in case you disagree though.

It is also easier to manipulate the list with "git config" when it is 
multivalued as one can add values and "git config --add" and remove 
specific entries with "git config --unset <key> <pattern>". With a 
single entry to append a new value one has to resort to something like

	git config <key> "$(echo $(git config <key>) <new-value>)"

which is not very user friendly. Deleting a value is even less friendly.

Best Wishes

Phillip

