Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5518EB0
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801044; cv=none; b=kNkUz9TX60I9ncrtSm7H9Mm4KuPpvPntodVr0KkQSHoIA+LM1nKZvfuyKcMHB8OFIpttVO1f3LDHcnKEzkOdp1DG7ZNM6/7GUf6i9mVX/2c/BBRPit2ObN9a5Z2aNkZdcNVhppHTwab3nAzLvvFXqIFAQi15lR8BMIiXhJLUC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801044; c=relaxed/simple;
	bh=sNNLZPqRFM/S89d28lS0OJH7BII5+EOIsGahVZ+iWVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8iWczeh5Y2bTK2XE79bvOnvwzwy4GD1JQTrnzBDFhlv3PhoIIl5CpP9+QFS9pTX9VBNcwwuMKc9AlMXWa14pQw1WwfPbqHejAfI0smaXStJqicDvw4fFCghp1yCgA3kK3Pdc9m34XoTUbdY61Fgms82lAZ12oW8bNXCcCCcH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK6axlTb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK6axlTb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2429f98d0so7334115ad.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801042; x=1775405842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFQ9CdqcMJQrgnlWgW0mmXoyod7NthzagHCFQhgkGHU=;
        b=XK6axlTbT/Uf9s6ZNs/XB25BwsAaphvpinvAoS6DL6wt4LefMYQZBVdr/uKzneRpuC
         rgoRQK40YbzGASvVmpX6abGyoXM+50AWtlO0ny/7NuNTWAZvU/+vSh5YnD3hYUtllY13
         kQsyE6zcakTvhB6UXrAvizPQtjuu5JcZDRGXCJewdxhYgR4s2NJ/+JRy3IIXEVuc/Pnk
         JE3cENLWtS5UoBn5oBYVWViWggQx33T3br6DdWV530Sg9/T4Qa262jKcl6icrnifcwnT
         LIdSnd0ZKng2y6VZyaJHgAuDl4FUGELvOzC3PetJp8UJ+6+YLVx1ziVIC0tCdxD+Si16
         Y+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801042; x=1775405842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFQ9CdqcMJQrgnlWgW0mmXoyod7NthzagHCFQhgkGHU=;
        b=TmQnP9M5d+LO6YfcJTcMpgKOmzL9JJqtxNYNSxMDtEiQsowIktONj9SYhqV8WDLinA
         uJ0Fk8F6GUj6LJmTs29y90vY7caJMNs0oS8JmaS7PNmh51x6GOY5/V1SrEsZ6OiHSYIV
         1d5gh/blDD4o5IHfc295MHkUceGdJYzCBQFdozWJteGmEdb+xmj7Ie8l0G6GBx25tsD5
         JIUZR1KipWyOdfa4dEsOZyIj6V3aQ5F4W3ecOI/iRRhCC9fPha9MY+rw+afvKrzmxGCE
         cc+c6TYKq8EqbdbF3fl74a4t5ndcNkNlTlPN7UpOBSku94WY8xW4rRsUJ3tZRl7kHhJD
         vceQ==
X-Forwarded-Encrypted: i=1; AJvYcCWplfI+gn/BH7d93FNvMvAGkdgeZI5GV015MxcwI2UZUcOjm5fmzvk653txOy9yPkmf2YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB95MgT63a0njujh/h1KlGCU4H60L8efDpWRVEOFQZ+pM8t4aT
	7MkoSau3OcIBpSXrG2jT5IY4EXtqHTLobbc7tsEEw48CZNoOj4NivQt2
X-Gm-Gg: ATEYQzzmsrmHmeTEhO8/JovKIjUAHxFyORHOmzaqJ4GaHE9iXPKjc340+J4JDdSYf3R
	kshh6H3brezYApjXFPVKj9o1Kh9i0scxNK1rADM8NejoKnW0HhpQBOAdSI+jUB+kaYpX1fmOmt0
	OscMncpgiHyx1w/XhsXkUbJ7o96JVZs6CvKTmVHcdQ+xlHZr3d7jfg7/5spCqy+fqe0J983Rb68
	7MJt8qU/A9WbieYqqCSwL4OkmRrt2cl6fP1ttDwXb2pEipikfbmHe4GiFXYLjmfB6FlYexLDOKl
	vZG0PcaVC0GAY/e5HudT8vVuY+tEH3WHY74CFpCj9IupYY02KATeZxl2QNQ0P3VHJIP2W/bMsnz
	f7V3h7U5qUvtTxU3u2utCr3Vn0u1li18imGWCp78i9UVzEnjUnymqSJESibfnNixIXvxG++4m1F
	n5MnfDyfF5az6o+0HL0Rk4EIVDUPhOU5wY1ulQvXI8GE5+CtXEOrQlcEd7mVQqEdjhBoP6HycJf
	0RRBZvBhx4tK2LgIXhh4ZbrAZB159qwuMA=
X-Received: by 2002:a17:902:f70c:b0:2b2:49a7:a5d0 with SMTP id d9443c01a7336-2b249a7a947mr35296735ad.11.1774801042168;
        Sun, 29 Mar 2026 09:17:22 -0700 (PDT)
Received: from ?IPV6:2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b? ([2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24b3a82f8sm24961915ad.63.2026.03.29.09.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 09:17:21 -0700 (PDT)
Message-ID: <6427d088-e41c-47ff-ab6e-4d7679e85d3c@gmail.com>
Date: Sun, 29 Mar 2026 21:47:16 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] replay: add --revert mode to reverse commit
 changes
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, toon@iotcl.com
References: <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-3-siddharthasthana31@gmail.com>
 <05959eb8-4b8a-421e-bf5f-9e6f0b59a313@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <05959eb8-4b8a-421e-bf5f-9e6f0b59a313@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/03/26 10:03, Tian Yuchen wrote:
> Hi Siddharth,
> 
> The patch itself looks pretty good to me, but I have some reservations 
> about its functionality:
> 
> On 3/26/26 04:23, Siddharth Asthana wrote:
>>   static struct commit *create_commit(struct repository *repo,
>>                       struct tree *tree,
>>                       struct commit *based_on,
>> -                    struct commit *parent)
>> +                    struct commit *parent,
>> +                    enum replay_mode mode)
>>   {
> 
> ...
> 
>>       extra = read_commit_extra_headers(based_on, exclude_gpgsig);
> 
> ...
> 
> 
>>       if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, 
>> parents,
>>                    &ret, author, NULL, sign_commit, extra)) {
>> @@ -153,11 +188,35 @@ static void get_ref_information(struct 
>> repository *repo,
>>       }
>>   }
> 
> It seems there isn’t a distinction made here between how 'cherry-pick' 
> and 'revert' handle the `extra` header. But doesn’t the 'revert' 
> operation actually create a *new* commit with the *current time* and 
> *current author*? Is it appropriate to inherit the 'extra' header?


Yeah, you are right that regular git revert doesn't carry over extra 
headers from the original commit. In practice this doesn't bite us today 
since extra headers are mostly mergetag, and replay already rejects 
merge commits. But it's still worth cleaning up. I will send a follow-up 
patch for it rather than rerolling the whole series.


> 
> 
> 
> 
>> +static void set_up_branch_mode(struct repository *repo,
> 
> ...
> 
>> +    *onto = peel_committish(repo, *branch_name, option_name);
>> +    if (rinfo->positive_refexprs > 1)
>> +        die(_("'%s' cannot be used with multiple revision ranges "
>> +              "because the ordering would be ill-defined"),
>> +            option_name);
>> +}
> 
> This is a fail-safe design intended to prevent users from entering 
> commands like:
> 
>      git replay --revert main f1 f2
> 
> This operation is indeed undefined which should be intercepted. However, 
> considering:
> 
>      git replay --revert main HEAD~5..HEAD~3 HEAD~1..HEAD
> 
> Is this operation also intercepted? I think the reason is that the 
> condition 'rinfo->positive_refexprs > 1' is a bit too simplistic.


Yes -- positive_refexprs counts each position tip, so that gives 2 and 
the > 1 check catches it.


> 
> 
> 
> 
>> +    if (repo_dwim_ref(repo, *branch_name, strlen(*branch_name),
>> +              &oid, &fullname, 0) == 1) {
>> +        free(*branch_name);
>> +        *branch_name = fullname;
>> +    } else {
>> +        die(_("argument to %s must be a reference"), option_name);
>> +    }
> 
> I think it would be great if a low-level command supported something like:
> 
>      git replay --revert new-branch HEAD~3..HEAD


Interesting idea. git replay is still experimental so the interface 
could evolve. Worth considering as a follow-up but I would keep it out 
of this series for now.


Thanks for the review!

> 
> Even if it just saves the step of creating a new branch ;)
> 
> 
> 
> 
> These are just my thoughts on the matter. Hope to spark discussion.
> 
> Regards, Yuchen
> 

