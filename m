Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887713;
	b=VKBKMCKOR4E3DeykwIgm8Si9dnu4rxydMud87/vdOELuiu0tqgznCgV97pheCwuolq1f
	 ft911x319lTX/obDilXwZUTW3bLqEr7u29uH6QQ8QGE+pFpAged1UFO0M4gOuDp7c5l2H
	 lGTOnJoSCZCAseDuvzBP8dK5EmHgDkdK6W2DRZGHBqhJxvT4KJ0jXwTaa4XgsyyCwF0cJ
	 ZTLWuUMYmyOZ7j79s9Dg9yTyPDZ1ZbI+SilTZrQEqvLiVUcnb9aORykKb1evsMeg/pC9L
	 xY4cvISOKnTAduobjY2zpZicViePoi4EmYrfK/lvGwIxaR9Lkf9SvRDiOLHXyFvU/Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zXqHaiuScfRJ4vwvXqPtaE3e0t/YUFjd804gG14vF9s=;
	b=w9pmbDXDQTlzOiFG+bvJFK7ZveVPTBXM3no7L+kBWmnUH/kOGOIUxL1q8o9N6pHptP1b
	 hPenclphhfsawesyOWIe8GpIdLk16epnf387Gw8LJNtDwLDu2Lfyk03GclNQ0Kl3kolfm
	 Cp6HJc5Kw7UoDp1IgVavMh9yhZLqLQymgxyllfv9XcJrnPfLOXQKERw6WlDmvRRDzdpeF
	 zpY4SJflR+9q4jXZOiD32LaWZMKu1NU4tgoq+fP3ULLkKSDBmC0X481VsHyVhU6M5OyhI
	 fSWy10jHHSEdZ0I/XatRYzGjy1m0qmKqeWrf6basp5dr7HMtboVNUrFFn8WJJmAwOkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqHBoQ3E;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD6606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CD6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqHBoQ3E
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d06ecaf709so1013898137.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 06:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887712; x=1794492512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXqHaiuScfRJ4vwvXqPtaE3e0t/YUFjd804gG14vF9s=;
        b=qqHBoQ3Esba8PonREwNpOTeCeY/gPfpvmVMtbR5FIVKmn3KiDAtX/KGEhPiKJYE5to
         XWnbe2mhb5BQd45jMjlkQFJ60Q3tVrt7vVNv194mP0abhbgxOyysDwvIOR7ntnWxr8Qu
         ZSDa+b8VtE7XMawZ0ME6dtIIoYW/H1F5BUr86YLxEvoyF2BByCdyFxtpTXcphrP+IDtz
         SuA4slaztBJzJMuTM9w+zeh94CTAU3YxFhHhiOlnv4JRgh35O6qDoQ+LaB9+wWIAucZs
         S7MOoIHAzP89EQ8C+49fquNiVtJb/DZ8FxGmGa8kaiwcmxPDFwVm2DoA454dQrwO1Mf/
         gMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887712; x=1794492512;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zXqHaiuScfRJ4vwvXqPtaE3e0t/YUFjd804gG14vF9s=;
        b=l2G0x0jJ2FOUfe6pGV9636gDwf+ltYHkwZ6F5E+4JF3Qs0UmuiCXs5HkpDN4N4jT5W
         5jGINc1vqh/Lkf/EnapAUF/rhi7+yTIMOEdOgApvPVE1CQs4AOCMo3LCFnp8EiXc1GI8
         PI/fdfc7WNnzZ8tTGiLfuB8TB0hK7UQnJ0g5zaXpctQZpG4lqmLfEM+yUf8oFDxAqrP7
         GCf+voMmfgM/mUooGdRVOj+0985DLluYPtLC/y2iKgTJ0j4nh5LZVwt4MVheCP48IMNc
         TRjoT2ioC6oWN4Ndm1JDF17t7J/nTptoMIEggPT4TxuDlBW4v08I6Npfo44xQYQy2/YT
         8J2A==
X-Gm-Message-State: APuU4Z84RTgRI/1mDdux03JkwQKQM5ugxLoppb1LEhLVavN4gkOdeVbN
	bFUDUUj4NMbVop3jOPil3z/1w3A3wvaQeEe1IsCyG/2yA8ZaSBQwb9x65NUsmg==
X-Gm-Gg: AYBFou1PyzE9aIK/L85+kOYGgnfpFj18GUI0d2pikPNzXriHlnrALgmtSyATw3DXS2c
	rpUgfo9yoXPgbmVn6VE94zE/3cz0azZSp+PdItep6qGovmWR5cvOqGuoK4CK39r3b/vUAZdkxFl
	1DBnI42spbp8PfcSuEC2kJ2Ja95oavecJfTRr6CS2wn911IRMEuloTCKzc0NQ9o4n9BrJXQgbaV
	dBBJmcPMWrm0R7/L4t0ucseR/hf1Ek8bvnutwovsr1ryrI8p6anbeD+CCdSSv/937QW6Obbm7rm
	GpQzG8bjIG0l+0u6156M1yhCknHR2hlyJz/UXtKB1aZHUBCYF69d9P6o007rLz0FMNLvE74R2gV
	F0XQe//jhSRIcV4gHSqZ0qBbK1PmN0K0+jGiCeRVPUQFHYao1icOtRiupdlHzKSAcGPNQEXknny
	0Y084zplV5jYiQ7OhS2XO2Sv6NSCgRB2+q7t1TNuNYF8SWfeD7XD85Xcjb2tdLoS1TRgkj/Bpbw
	qWDfXj9WQIguRQZF/4yWj+JFeA+BA2Ic9F7S1dmakyNCgChLntcaRCLlYAZ5A/c3Zmm0iL1YQ5i
	KANdqNYZVLzpyTCbxETezR9LrcBs7sU3213MWk24cDNJ/qgBECmHPCwfyVUkcJtXegpaRYeLIrC
	961WsM2pDQcInG+gWCw4xUBwK8UnOpr3hlJ6UM4Udgy2pzci4g34yu9TySfZjOGcuWWrDJMpe64
	EW0BhSd45HlQOzdy9aFkdY7p6AOjW8n9R4YFI7aPbcTM73xh0RtkJc
X-Received: by 2002:a05:6102:30c6:10b0:7d2:8dd0:2ed with SMTP id ada2fe7eead31-7d28dd0052dmr1392351137.10.1793887712299;
        Thu, 05 Nov 2026 06:08:32 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d296415719sm849998137.8.2026.11.05.06.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 06:08:31 -0800 (PST)
Message-ID: <3d62a579-5bf1-4431-8bfc-757c3c873d80@gmail.com>
Date: Thu, 5 Nov 2026 09:08:30 -0500
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
Subject: Re: [PATCH] fsmonitor: invalidate untracked cache after losing
 history
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, ki.stfu@gmail.com
References: <pull.2295.git.1793806679163.gitgitgadget@gmail.com>
 <xmqqmrroyztr.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqmrroyztr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 5:52 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>>     A user of an internal monorepo reported this behavior, including an
>>     AI-assisted powershell script to prove how it worked. I used an agent to
>>     assist in porting that to a Git test script and a code fix, but then
>>     applied significant human editing and validation on top to get it up to
>>     my standards.
>>     
>>     Thanks, -Stolee
> 
> Would this be a viable replacement for ik/fsmonitor-untracked-cache-trivial-response
> 
>   https://lore.kernel.org/git/pull.2247.git.1791127155614.gitgitgadget@gmail.com/
> 
> that has been left unreviewed for a month?

Thank you for pointing me at this. I didn't realize there was already a
patch working on a fix for this issue.

Ilia's patch has the stronger approach of trying to preserve as much of
the untracked cache as possible, which has some performance improvements
over my change (in the "rare" case of the fsmonitor failing).

Let me first see if we can take that patch instead of mine. I'll start
some review over there.

Thanks,
-Stolee

