Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120644;
	b=4Q1aWizNUjWt6UmdlrnE8ecdIGsZBloA8H9ygdGJUEvsbVAR7hgCIS9rf1z7SEkWxPVD
	 vdD+aOgqKiNwJmAP0lKDbjyCBL6SsdY0bQVljQZawxyXfm5ZiqWOCtUJxzrX5rOsj4lwR
	 r/KbXjQ3J8Ax+ACNQr7p4AHfktmvx56u/ADvNYsG4+gDH2FMssip7jviKzf02yJq9vOUx
	 sfH0H6Sb0eFqPFV2PZY3BR1QQU9Q4+0r9wvhDaY3/fbqfFq+9RMXv58jl3Gk1/iLXEN86
	 /R9wl7ypqohpYLa60qWjWrqXj0exAPCPgDV/dOgC7DNju8cggkzpYX8Ceti8DgLfpbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YrTzPmNqyt6IweGNEu/L+0zcb8xIDxRml9KuUQa2JX0=;
	b=UWWv1OcH/BVXISUOraCX/Rg226uyv7POFlOYWdx5K2vf5LAFOPGyyUuR3Itb5yQOhbsY
	 FI2y+pFeYPYg0I5xW4u+bPxcUBJBUJwH/2fqVpADqvT5pKpdx7yjkipwG7pHdD3HIKTxC
	 /B4IOGsMi2zat3RqpQCCCCg1HLSgz/4ykETwzgKiU7/SMC/ezIbli/uw5ncsIztwEXMDe
	 D/0XGnwNAhesI2/jcMwKXzKrV4R7KEZG7GpgzZEg0fnZKJmPcNHWytfa0Je6G5CYiSZd3
	 tc5Fpd6lyB/+Z6zHZWW9cxy8mvsRC0IgL9iBF9NI9Vufog/oakDXDAFYuj6vDvPfk2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SoF4sHB1;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5642606A32E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5642606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SoF4sHB1
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so725255e9.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120642; x=1793725442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YrTzPmNqyt6IweGNEu/L+0zcb8xIDxRml9KuUQa2JX0=;
        b=SoF4sHB1ifeYTG/58GAmQ90409Gz9QcMR5RXsvHF9GtTf6DPbhddnZgy2djGp5Lad2
         /PNt6Ldj3LxqtXlZdYy5u34gtFaxgO4LXRQmhlDOFyNF2Ju8XR5KKhT+L7JMN50zuRcy
         j+b1VBwhXBaYOVFP1TpEgm/DxilH9x8lw0/S+mrX2Y9Java8D3grwNvbUbXzxVL+igWU
         VqVNT0jTPY95dn937bXNhCWMjDITDNkiLx3xC1Z+axPf/plpMWw7j2Fe2unyguzIVyNR
         iBbQO7IIy8tx1hH1gIq/bZ+iXe7y5m6jefw6ywEuwiKXKcoYOrWhpotWZfseSwmhmsE/
         VScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120642; x=1793725442;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YrTzPmNqyt6IweGNEu/L+0zcb8xIDxRml9KuUQa2JX0=;
        b=wARmuQQdQtfvz6KKPCbxB47iI6mk3mqx5ZHifOYLMRoS1Vwfcj/udLrDv3gR5ySSB6
         jAR5UNG4aVzJA5Lw2twHL/o+QIgCOgFXqiR9PE3VEOU4u/9JXMyLkkQLd2nxPDE9IMed
         ZlFNa5iearEKYAhEdjRuRE9FNs0qR2eKXt08xvDzz/F+X6nM9gsQSL3/ZNGeXzIBgFi9
         +v9eO/KJ6ZJrplobTjSz7mvPdxOioqaKG6Qz2Uzjx31GqiXoezPt2oKJL7HwZdNE3Xmt
         03Jm95iyk8P9Dl6yKyqpUHePOhOvcr6U6D9cTuzLoT/nprRUFiTm4ko9F0rCJi00dhzT
         1yXg==
X-Gm-Message-State: AFq9FYI6/3FFngr9IYIXAlq1ZQioUP+7Puk6fgDacs9zIfaCo9n1MVik
	aKXzxgmdPQ7Fopw7OZCcqDYpSC8ZSgR7X984QI//RkclGjR6BylPAQFk0PwNxA==
X-Gm-Gg: AYBFou0qR9c+ZIhmAv/CKJ8y/udglfer7B0CZewcWWugvI89GA1NaL45Pe4KUnes/D5
	A5QDV9OpC0x7IDs94MAyCO4BqsTo+dIKGDoPn+/CzoX4t03APCi91dE4a3sMW0pLW6ZDhbzxDH9
	XAOeEO/Fwp5TJeS7mnzMwwSsuj8oWJJg7iCzhLhH7c4NI6dXXzgEGRXXIJuBUw2XyulHM6v9UCC
	I298GKjRhVmUp+ws5w+Ciu7C5H6PwJ9RYiYwNX9iff8JWc7yk1T6djW1Y/KJHnRN+5y/yanFbdx
	UvtgwGy5WzCoWySRlSzu/aTGaIpx54LyedoF5ge0Dl1WfluKqQJoDvOYR/2u3z4TvNCOOOlTf20
	1mz6PxcmXMS8aOZeYeMi6XfiINuYdtLG/XsnVrYFORCeBlJM+vOLWxjc50vlLwk1agpPEx3/GkM
	XGloEyg7Z5KST8PwbHy7N3sbiP79h5x+hR5Ya4weOOQVXlXa/cPbZ95BNmcCUfQM2n+F2vgDjNp
	aHGN8K3kWG38D10uYPWEGijUG7550AVYtQi9SeWd1eDOozASQSTwWVtgsFVGA4z62iOL5OAtssS
	d11+y5Zk8ToC1sffEL+4i+dOa1w+TRqyVoA/2WfQ2xCvkuEbFdmmCks=
X-Received: by 2002:a05:600c:4f89:b0:4a2:150f:160f with SMTP id 5b1f17b1804b1-4a35aca4e43mr204830785e9.25.1793120641807;
        Tue, 27 Oct 2026 10:04:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92d182e40sm3124075e9.1.2026.10.27.10.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 10:04:01 -0700 (PDT)
Message-ID: <48e21b4b-6762-4e76-a817-1be6bb31bbb7@gmail.com>
Date: Tue, 27 Oct 2026 17:04:00 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 0/5] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
 <xmqqcxt02eoa.fsf@gitster.g> <101723fc-d392-4000-b224-345c610b2aaa@gmail.com>
 <xmqqh5i8tqjx.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh5i8tqjx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2026 15:44, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> When I wrote the refmap feature (without configuration variable)
> long time ago, one of the goals was to allow me to say
> 
>      $ git fetch cabal \
>          --refmap="+refs/heads/*:refs/remotes/cabal/*" \
> 	maint master next
> 
> That is, "here is the place I grab from there are stored" and
> "maint master next are the things I grab from there" are specified
> separately.  With the configuration variable added in this series,
> 
>      $ git config set remote.cabal.refmap "+refs/heads/*:refs/remotes/cabal/*"
>      $ git fetch cabal master next seen
> 
> should become possible with the same behaviour.

That makes sense

>> That
>> setting could accept something like "*@{upstream}" to "mean fetch the
>> upstream branches of my local branches that live on this remote" which
>> would cover what this series wants. I think it would be useful to
>> support "+" and "^" prefixes on the refs to fetch as well, so that the
>> refmap config controls the mapping and the "what to fetch" config
>> handles negation and forced updates on a per-ref basis.
> 
> The reasoning here is slightly wrong.  "^" (not) may be good thing
> to consider as it is to decide what to fetch, but "+" (overwrite)
> should be on the refmap side, i.e., where to store.  If you are not
> storing, then "overwrite what I have with non-fast-forward" becomes
> a nonsense request, and that is why it does not belong to "what to
> fetch".

I see what you're saying. It is unfortunate though that we then need 
separate refspecs if want to reject non fast-forward updates of some 
branches but map the refs in the same way for the fast-forward and 
non-fast-forward cases.

Thanks

Phillip
