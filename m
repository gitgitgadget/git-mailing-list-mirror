Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479120E703
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602625; cv=none; b=HUbGiVtQhN3LsIKtgy7Za5x/lzFTFAybYtlaA+4zyJQTV0e4Is/VH/PTrTqwSGid2a5+mH5sBsdhV5ssPeEjT/ZdnFWKUYO5Tr0zeLwRwV6xDgsrcqn+M8e+1Ynx1UeH+vDgQVdkMzk6cPaGV+lbyKzNZpjNBLSmtWigLYeDVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602625; c=relaxed/simple;
	bh=T1ImLbY6NpbGCzDB0D5nm51fkPNy5szGy7Fwln8XiFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=AEIO1u+uHpKvYtkPG43J79XcImczu/5PmTv9tgjfLNY20ev5IEn0VJTOpfrT1FQufL9mAQ6cqKyRO44ghQOFvHXRVAF1ybeYn32pa3o4PoIs/+bGM65B5CrbYcmnL+EOzyYFZPOzmYVLyAvSOlC5jojK9c3jbLDYudB8kG/klE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWLoEtzW; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWLoEtzW"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f47ed1f40dso27695847b3.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738602623; x=1739207423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vEeXSd/3U1EIfO/EoyiB6Q4qTz/vDHXt4EKZMGPy7r0=;
        b=NWLoEtzWy17TLnFhoIHNkIO5WMVCe7CQCFpApavcrURimR6aBMz9B9MhjKHQjtBhcc
         RJdLYWABlnM7ytTu2KO7m5rXLqlPDk5CrPjo01qUbn8z2UFi4BgGbCKh86bb+MhqIeRL
         Y9nPK2D+30PdB5w13Sq+m9nYHNBdXNnCdD5Ma7fMsOIFmlvuArDTf2vLPzGbuhFIMs1R
         4snD3eN3tYy9nmeU0ig/A6MVFSvx6zQAn2s74FFYKFDys1AD3Rptj3/CTtaksoUEHN8F
         NGIFm+AFUs37mdFStdmIRc2eaPbZDkuhFZu0AUDPZv4fzU0b7mjYkDwhUJJ+wkrp/HAS
         VUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602623; x=1739207423;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEeXSd/3U1EIfO/EoyiB6Q4qTz/vDHXt4EKZMGPy7r0=;
        b=CupqkTqHRj6fMXmCWVLNLwK6PprrJYaXX/GRLcEvHOqvitydUpYinXKaz+LanWH6hu
         Gi7PfPgSg5OL20xSQSUd14y7Y5NttXSjFNQcO6qjna6GizMTNK8iAKpXT/VzH0UF80ie
         8B44WdOyH17ZZC2YiEkkaBwRwmVxmhWfKRiCsRIDCxVn3kKJ4av43O5IN6lpaYXpxVcN
         SLDI9m/t2hf+DOYRtj04oiaF6yNmF+SN8IeQyF+yg8L2BOB8BH0LTlR13wlaAFJmW1Pu
         46T4fp6a9XOI7Q5pCHbd/b4aM4txuRO4sCztxWMYI7vCoG83KxtiWisSBkU4x0QbqhME
         Ol2g==
X-Forwarded-Encrypted: i=1; AJvYcCXfA0U+oRyu+MdZxzi6X7NtwY3/m65cnL1mbtLsa0/XBKIZ7UgTYlSOsf4exVOFMacv7ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BXiIUxsdG8V7gx7UGMS+Eggdide47E36gIeGkOA4aOaPOTaw
	OKAA6SFG1We2zgltxdiHWXvchTC807aH7eGXgo1BDUP0iD/ZdxoS
X-Gm-Gg: ASbGncvA7f1b4/OnExK8AKA1bjVm4UpwBOkGehH/7oba+XBvG2emNNjbFievwfa0vvR
	n0Z3qxGJhKURWJt27t7nxw35/fWY/qVmNduFawXsv29hWfd9fdlNBUKKc4ZNkgEQDlscL9QgjkD
	jUt7mQ3ngA84dtzERvtICQIRp0DZTocYHGp8c2tOCo0/uavRO25Hv/7je/r7LmTuRHZj6vxyaqN
	NdmGQKZRm+GXkF0ELqGpH+GekW4B+LLXbzivAFzU/74HD8Q9247S4OmVF8GTtVU1rL1CeadKWL6
	YtawMzvc/8+N25l1EJNcRExFeMnKrEbvIolqUwl4KfAoaWqFHTTomp/DnY+S2aLDf8JBW7eOCUq
	Urz4=
X-Google-Smtp-Source: AGHT+IG0Oszfj9JHy88WtkYslireR02pZZrR5WfjhIaXeqaptKCRvCFQP1OhDY4L7XSNJOzVgDS8pg==
X-Received: by 2002:a05:690c:6988:b0:6f5:4304:fbd with SMTP id 00721157ae682-6f7a835bd49mr201338907b3.11.1738602622736;
        Mon, 03 Feb 2025 09:10:22 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2dfe:af96:f238:f6f1? ([2600:1700:60ba:9810:2dfe:af96:f238:f6f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c463dc55sm21740347b3.45.2025.02.03.09.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 09:10:22 -0800 (PST)
Message-ID: <d8661675-1c08-4c7c-9198-be7eabf0ebee@gmail.com>
Date: Mon, 3 Feb 2025 12:10:21 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jan 2025, #09; Fri, 31)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5xlu4bt6.fsf@gitster.g>
Content-Language: en-US
Cc: me@ttaylorr.com, ps@pks.im
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5xlu4bt6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/25 9:51 PM, Junio C Hamano wrote:

> * ds/backfill (2025-01-23) 6 commits
>   - backfill: assume --sparse when sparse-checkout is enabled
>   - backfill: add --sparse option
>   - backfill: add --min-batch-size=<n> option
>   - backfill: basic functionality and tests
>   - backfill: add builtin boilerplate
>   - Merge branch 'ds/path-walk-1' into ds/backfill
> 
>   Lazy-loading missing files in a blobless clone on demand is costly
>   as it tends to be one-blob-at-a-time.  "git backfill" is introduced
>   to help bulk-download necessary files beforehand.
> 
>   Expecting a reroll.
>   cf. <Z4jeQSLmARruE5l3@pks.im>
>   source: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>

I've updated this onto 'master' now that ds/path-walk-1 is merged. v3
is imminent.

It required a few updates that I'm sure you've been making within the
merge in order to keep 'seen' building.

> * ds/name-hash-tweaks (2025-01-27) 7 commits
>   - pack-objects: prevent name hash version change
>   - test-tool: add helper for name-hash values
>   - p5313: add size comparison test
>   - pack-objects: add GIT_TEST_NAME_HASH_VERSION
>   - repack: add --name-hash-version option
>   - pack-objects: add --name-hash-version option
>   - pack-objects: create new name-hash function version
> 
>   "git pack-objects" and its wrapper "git repack" learned an option
>   to use an alternative path-hash function to improve delta-base
>   selection to produce a packfile with deeper history than window
>   size.
> 
>   Will merge to 'next'?
>   source: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
Since this is still marked with a question mark, I'll mention that
the last version seems stable and has Taylor's review.

Now that ds/path-walk-1 is merged to 'master', I can rebase and
update my work for 'git repack --path-walk' on top after this merges,
as the '--path-walk' option has textual conflicts with the
'--name-hash-version' changes. (It also has some deeper discussion to
consider, too, so I don't anticipate a quick review.)

Thanks,
-Stolee

