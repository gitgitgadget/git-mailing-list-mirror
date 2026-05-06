Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271A480345
	for <git@vger.kernel.org>; Wed,  6 May 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075997; cv=none; b=BZq86ftrFSebOOHJj7Kn9VFrugCZEywLgYH9SjNUSdvhU9BJAuq4gzJls/Ngp8CKwgl391JowqTiHnvfh8EB2sCH8+Tebj66oNuykKn+lEPfJMcM/trgKiV1bBBGM4oFY8M1ZCRbPpFNh8RynvAWjT3RQXmKjgb2q/HfDurD/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075997; c=relaxed/simple;
	bh=Kdjj1UQiNUmkS2qjlkl1q1fWr05N7LL7nBce2V/+85w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecObqvVdtJDesQYAEPg7hdW62uZKoiCxxyfhu5mG2HveMLdsI5nHKvh1P8baJG+aR20o6IyWqJVn5yMI5rKYEK9KJ0krA4EU7WJPZwD551z7CeHWt5kNXBpoL8G/AmRQyqeB/RvLeoY8U7KcHa77Q05tOtYDi7z32zjkKtqvDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGrg2Qay; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGrg2Qay"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ee9ec26edaso680939085a.2
        for <git@vger.kernel.org>; Wed, 06 May 2026 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778075995; x=1778680795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ll7ilSXtJKbiopyRghcR27zjWKM0ti+TeQ5+0OB9Fys=;
        b=VGrg2QayH6o8M8tVEcRnI8oLsktT9JoKNcKGeb9qXIZVm6fgeZeTeHAbkEOEAcEw1X
         6qc6GxW/kLw5RzQ4i6qLe74+hu01ZBVJ6O2DOVjrzVUjpE+SeF1On/6GPYW+lBZAnYpt
         w19O73Xuuwta1H7A1mhLmmogMDTzqx+za9zk58eGJas/cU4BWlrUrIP0leIy+Ajmz2Yx
         FGPvN812ebG3edFgX1iDHSgZ1IFbtV2Nh6wDI0Dh4SgqcJlfRm3+qtTL5v7cpWBx1Cl5
         U8VYwp214hvFjZE0iY5UIXYkTI34Avp3P2RFXo1u5tde6H6gfa720d+GOBM98rEJ/sDq
         q5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075995; x=1778680795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ll7ilSXtJKbiopyRghcR27zjWKM0ti+TeQ5+0OB9Fys=;
        b=Vv7WhEnFo9Y4aumCE1KPqflBk0jA/ODM3bASH2YG0qg7aObuap5BqOKc4HPrVZViz4
         PGTBjHeQ3WHFjcxEhA3Egj8JH+ezfZvXo1VxWSCoGkvoAcIpuu7nw9vYWQMVI3f1zuSl
         AS6tfCE/EmwRfmQNdKS/sMnApa/GhpezUVelYejGCBPXKAvKwffQ0po3/+ng+xZmDwc3
         sGAu7MFT8afqXtcFvAjiRlbLHHRGw6qdSv1pkdBa/qcZp7ApPW2R6C7fkOLg9aYwV3c3
         OS4ySdCN5o/TtmpjYuZBH8vVblEqnyb0vNjh0iuAWJ41zHOLBHiCDIBKcUaZdhk/6pcn
         hdmg==
X-Forwarded-Encrypted: i=1; AFNElJ+/hPj+JIT2v8DBNGesSxwpD7KMPDksu1zreJ+YW2T/ZV5lw+1WfshmlGNAJxXd9O6ygaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiH9YaShABYx5L9EgIbVVeY6xrIp8Gc3WYFzOodXxBW5RLdQx
	7P5+aQODBgPR50cr63vzPk1tnkTFaqySKIkre/eYSCsNWSVTHblArV1J0uytVc3A
X-Gm-Gg: AeBDieuRrrxgbGq6lzmJmz6+AtvQ0+32ZUvP7UaR2M8UapldUpGmZumVGsMKfP6zAkX
	suvsIlxsHIF2gMXdKxO2EVyybjpPQlup3pgHMy09+s4fzekYG9JDDyl7XgSgy3LrUeTdr55sdP5
	+lFIMIdZQSxrykhBeeNnUVE63Nb/E/AS2zJrNsW2wKycM3Kw4Mm8bwnz1Y/YXkkoKqST3HuDhmC
	E1olipPDcf+gunWg2T0PxJnfr3G3HxqVFLahiGBD2oZs3qwDt1SBUPSH2SbKX9vAGPBQcEaOR8M
	WvRUqKrQOS7gofok/HIgJnNjikEK1FLF0zAxOecGpvw5Z8EsM07Jxe3TdN5AasdJXf+2VTP0dRy
	ODY/L+9IKyB/hhf+JQiFhM0wWTsk2EH5vCFYJiotgpJ0pSkklW53mB/Of9CohEPAGhvsaOQ3eFL
	WFkbJJ6MlAD0fcn+cW+IZdxKmecW8Wz/FmucfaRLPZ/Mmjzo0aDgXRhSGiXrcH45pBAXbYxbM7L
	aRQL1bt
X-Received: by 2002:a05:620a:410d:b0:8ee:630e:351d with SMTP id af79cd13be357-904d4391609mr522727985a.12.1778075994623;
        Wed, 06 May 2026 06:59:54 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm1691427785a.39.2026.05.06.06.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 06:59:53 -0700 (PDT)
Message-ID: <5f9f4998-4538-4bc1-a245-4248e18c4e86@gmail.com>
Date: Wed, 6 May 2026 09:59:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add caveat about turning off commit-graph
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <caveat_commit-graph.671@msgid.xyz>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <caveat_commit-graph.671@msgid.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/2026 4:45 PM, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> The doc `technical/commit-graph.adoc` says that replace objects and
> commit grafts turn off commit-graph:
> 
>     Commit grafts and replace objects can change the shape of the commit
>     history. The latter can also be enabled/disabled on the fly using
>     `--no-replace-objects`. This leads to difficulty storing both possible
>     interpretations of a commit id, especially when computing generation
>     numbers. The commit-graph will not be read or written when
>     replace-objects or grafts are present.
> 
> But this isn’t mentioned in the user-facing doc. Let’s mention it on
> git-replace(1) and git-commit-graph(1).

I like your initiative to present this incompatibility in the
user-facing docs.

> +CAVEATS
> +-------
> +
> +The existence of replace objects or commit grafts turns off reading or
> +writing to the commit-graph. See linkgit:git-replace[1].
> +
This does seem a little weak. It doesn't really say how this will
impact the user. Perhaps we could add something about how performance
will likely degrade in this mode?

  The existence of replace objects or commit grafts turns off reading or
  writing to the commit-graph, which can cause performance issues. See
  linkgit:git-replace[1].

Thanks,
-Stolee
