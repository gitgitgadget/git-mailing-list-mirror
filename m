Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244F30648A
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771733; cv=none; b=lnoC47mjcj/NJ+ib0Ib/L/DGBh6pErY5VG0p+Cw7OqQSfXgSMA/uJc1RWJk8Qd46SPmd9kNviozd+iSBW1ACoKGwI6a28p7dgWmvB4MD3Pf3ktYm2FziYgsKg1UQIcAQqBb3jEIFvjIYJLXG3c868LdRVbYCiKIKts2h9hfdl0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771733; c=relaxed/simple;
	bh=a3FhSC6tgVSG7LXaZTjq1on/u8b0t790OFIUCOvu8aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Caz9MF6erFlxolgEPHvXQVER/DbYviVzyeVkYFkVhYXV4jmf+nxtCTQ6AAPp1wFHlZFUEjgGOenW1Qe/rvC3GAzvX1T0chdB+Yv8JXgr3TpZTSvR9/1Fr1VYUmvpNxHOtHAFEHega/5hCd6vCTfrSu81ibtACHTw9TV0MD5Tcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScN9V2ch; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScN9V2ch"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso71822065e9.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778771731; x=1779376531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=om/H2lUXc8VN1SO2EBkCxced5+N6rh/+j6pj2XnaN6M=;
        b=ScN9V2chJzRSyBRteA+Udr5maBPyhb6xH6ozQ6Kk43dARHWFFtYLAQsH1lceoMgK7q
         rNzOIsETkxaXViQO1QAlkcI/YYW49eXcHeUqDLJr/mMossZzFre7McKh3rHb9clbqAZA
         jueceBp9tXpoPti75YB7x28BpZMxgiyU09+PL/OokrrmcIALrbI5o8yUDL83jdQ6hgVy
         SqMOztvKmG5lKZFB87zHkBEtD7r3ZRKGDIqY1F3pq+hzPF3F8Fo7NXT8WLIV6t2kHKhc
         THK6Eij3WRa0M5DwY7Bu++VhSXnkCVcP5sFcxIPfnyt9cL41QhmtM4dW9kYtEdgEp9Ys
         JGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771731; x=1779376531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om/H2lUXc8VN1SO2EBkCxced5+N6rh/+j6pj2XnaN6M=;
        b=hR70eS9u6fAbl6o+uj6XdAPjTZkfEb/RoJoNEmcLG3N8ovWBt1syzA3pPgmiQwgDAl
         hjZjT1wUOXPZLZfKwakOEzvhVp/9pfirSpc5OuNX3X8KSYr5UG2jborZIIgJ4d8bk6uN
         xLCC1NgTgUjZ7flUE9v8zmJu5Lvi+90hQ78lb8NvEXLcYKLpuXSzie6+IyeryyMxaEhQ
         zZ9LNvP8D2O4CHTmgSt1zw+BiJulisT9VUuz0I3iuqyKO5iYiWxwHfc6I2/hLL935RMl
         w7m2JEnL6jGQJvtXCwz45FbfWR744qbAPcfAC2k8l5A7YvGCrFPCmaxLTeD61g1OxS2b
         IEvw==
X-Forwarded-Encrypted: i=1; AFNElJ8bKYFIcU4rzdgBvLcdkzJYB46DtPaaRJxOR5tIgor/VjXG6O6FpJK98pyiZ9nD/qZCDas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLT7LJzIKTD8tUx/JZsLPZDW2XvwmquA9im8XSoTG5xKpb95Le
	jNZuP+ApgD9GT2BcpN1+sAy8e9/p2NwsMCPB2ytErR4LoDb9gKUUllTY
X-Gm-Gg: Acq92OEW8on+72K1dONONl1eB56pMhFHVktjMjR6bbbSxvI2If/wnGBLhwKWGEQ91iV
	/54FegLi2WfO5cKdfc0Z6eyckd5d6yPdh/50Hq1dW1FU54WS1NO8eJsokEb+nOXWs81ThpvgvLR
	UK8FEqdXTDsn1tcxdb5Qk/Om5HWooSKFm7P244XDsnrMNp4U/2rj1EVuxs1Ec8LpDbSqXr/zYz8
	mMM0U/y4Mi4HFoKCjWdpYX6VMRkz8boK2gwth2GopzMaC2tEKF/BH6oWFLtQs+3toocKuwe6aik
	7DZTgyZZpMPG0haxXJULcOUrSfbPkTR7RiNJR5mc4V5bjJqT9nPtE21brooaI2TnzUK4+aoacy4
	PDvA/RLYWmBQsn/kbfBJgd7xw8sipkr3z6kXOacq79HEOEqbHPzM54T+8b9Z9duE/QpILjCIM+E
	mG/4WqLcuKCZUpRNqJhYhNc3yQ7nNX2pmoVPGD3R57EuZpL2eWdZuQLS5idry54NpH2BsE38S1/
	DeEUg==
X-Received: by 2002:a05:600c:468f:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48fc9a028bemr116344005e9.3.1778771730489;
        Thu, 14 May 2026 08:15:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7? ([2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdafc6741sm37259165e9.2.2026.05.14.08.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 08:15:29 -0700 (PDT)
Message-ID: <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com>
Date: Thu, 14 May 2026 16:15:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 chandrapratap3519@gmail.com
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Pablo

On 02/04/2026 22:17, Pablo Sabater wrote:
> When having a history with multiple root commits and drawing the history
> near the roots, the graphing engine renders the commit one below the other,
> seeming that they are related, which makes the graph confusing.
> 
> This issue was reported by Junio at:
>    https://lore.kernel.org/git/xmqqikaawrpx.fsf@gitster.g/
> 
> e.g.:
> 
>    * root-B
>    * child-A2
>    * child-A1
>    * root-A
> 
> [...]
 >
>    * root-B
>      * child-A2
>     /
>    * child-A1
>    * root-A

I'm rather late to the party here, but personally I find the indentation 
a bit confusing, it would be clearer to me if we had a blank line after 
a root commit

     * root-B

     * child-A2
     * child-A1
     * root-A

It takes the same amount of vertical space but keeps the children of 
root-A together.

Thanks

Phillip

> This is done by adding a is_placeholder flag to the columns, the root commit
> is actually there but marked as a placeholder
> 
> e.g.:
> 
>     * root-B
>    (B) * child-A2
>      /
>     * child-A1
>     * root-A
> 
> (B) would be root-B column with the placeholder flag active.
> 
> Then teaching the rendering function to print a padding ' ' when meeting a
> placeholder column outputs the second example.
> 
> There could also be the case where there are multiple roots
> 
> without the patch:
> 
>    * A root
>    * B root
>    * C root
>    * D1 child
>    * D root
> 
> with the patch, the indentation cascades:
> 
>    * A root
>      * B root
>        * C root
>          * D1 child
>       _ /
>      /
>     /
>    * D root
> 
> the _ / might look weird but that's how the collapsing rendering does it
> for big gaps, this case being from the 4th column to the 0th column.
> Another patch could change the collapsing rendering for placeholders ?
> I haven't done it to keep it minimal, but a follow up could make it
> to be straight '/'. This would make it bigger but easier for the eye to follow.
> IMO is not worth it, but opinions are welcome.
> 
> The patch also adds tests for different cases like a root preceding multiple
> parents merges and the examples above.
> 
> There could be some edge cases still so any testing is very welcome.
> 
> Pablo Sabater (1):
>    graph: add indentation for commits preceded by a root
> 
>   graph.c                      |  68 ++++++++++++++++--
>   t/t4215-log-skewed-merges.sh | 136 +++++++++++++++++++++++++++++++++++
>   2 files changed, 198 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 256554692df0685b45e60778b08802b720880c50

