Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BB4594A
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490879; cv=none; b=A1ASc/9GtMrL/F96cQZCDcvSHRd+V2fF1t/WSBor1uWbt6hLJGskVS3PSvSm/TsGhIb5z6S0vWg9gElKgKvjRpwhLz2iNaf4lxJq18kFiTBwYuaCMWy/4t16/Cpc3an6jUfn/Y7AhPHfoGN576Y4fg3Um9KSYscjtMy7gwBFpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490879; c=relaxed/simple;
	bh=BivF/ROLic4EzFr5sHYgukabm/WvDWpjAwfrwNW85LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVD0oLeAueGT6SdiT7hq0fCcLv1kf2UzO+bATz7ylALivYkWbVFAQ5e7VENi2YaDbS3L2ZhiiJpw1gWlts4tTJ2aTMqhXDRXKHTTly/wOPkLfwBDIG3GX4iO9/Ytu88wZuMy6qy4WjZRnnXiiQILjLjWeEz22oKymP8nrvy3FvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEKRuBCn; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEKRuBCn"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e479e529ebcso8526460276.3
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 12:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737490877; x=1738095677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skoFd0vMXuWaj5qcfbM1e0frGfXcPQmggLVPBbjaJ98=;
        b=XEKRuBCn1kOvhKm6GT+JI2LTjhYx1Kad/L/p5U+hhDzXJDiIdeXv4BBmfgmhJ14265
         PxmgJQCt/PXlAcdzRS63RT9lqrRWnMVLB2weQDnHtL2fhTUTiYLp64zepWr2dRt3QFzX
         SVtCdq821nen22BMEwmSsSPdyEtzPm66K3lkfFKlAkAUiVWW0hyj8EJmWStwNqvCo4AN
         b9u+nLy2WyHWOsj6dXPs2b23C6unXL3yQXv+1EXRKzlSB03eqsBvMBmYG8sL76C7P9wU
         fUBRVeRWCwmjd4NTbFrHjHouM4v4ZF1n8HrV0YfIsgl+ZdU443fiuoCq0ePcgkMyQG67
         tklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737490877; x=1738095677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skoFd0vMXuWaj5qcfbM1e0frGfXcPQmggLVPBbjaJ98=;
        b=tCF+ByBE3wG7UmB0jkMgC1HCh5Z2hEt4fcUKz7rJpyQy/j3Ks0TfMRz0rezsJLVZQ0
         Yfxn4AxxXZU33K0/FFO1QzN6uZHYtxHCx/lyF94Qg83HjpERJ6D/9LSlsN0SaVgKwRrR
         RfVpbTmKcMjkHCHAhIYbkkjf25fEEebdoH5/tRQX+P0Xb5qNA8PcQkyVEvWtNdhdnh2w
         J9eWxEjhokk6XmXq6ThPLBsi9uT0zfkYGnRyS1VYmIK0rwZd3UFMLQ4tvkU1cGz6uH2l
         KP9i7Q2IV/JIhsq84ZpTDQPVdMMyEZkiZ7u9Y5ZWZzUId8YLG6PkH9EZl2ZlPXiHTqW3
         +M6A==
X-Forwarded-Encrypted: i=1; AJvYcCVa9SzSCNE3jyQ3uQ8i09C1pQ2Rp55/fuxCzbKn9yeCung7I+HPOcI5neckz89H8yZTo/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXcZSidL6XXd47ICS/FxldQmUciFojmBgAWfa5Bn61K7OPKnY
	FQe0a8d5bJ+nj+Kq5poAZs4q2VV2d4dOqZTtBq08Dlr6WFQ5c3cL
X-Gm-Gg: ASbGnctUnHPTjBLhJNAI3nwhTTcCCDABBYvNRv6Jiz/EysBVqjCgPk2mofRYxt4E9wp
	TwX8iOT1pZMXgSGXPB2E4Np4T9j5j7ckNhldQmRunu0NfpA4Ke0ZB9btoM9nGojEVLTDqgEOyER
	WK2thixb+00Azn7PrrnSmwapX3ALeLw3vQu2U56mU3nqaPf20C7/T6n2MLeKsXEdiX7+9iWXUQg
	juYm65rT3nIm1PA2DigsL2YqFO/J4G/Ij95M5P0zk7j1iZyHrZaJmaQFOTYg99ayrpHxjoGygWO
	BkJx7KvvoS3aWNq6mDJnpYsJtRgumvbFLiksxTi7HuTVdptGy2q85kYJ2Q==
X-Google-Smtp-Source: AGHT+IE8A5C2kiSl0CgFs7QbJInP2t7hPzcRUsjCXI0M7/WGamVR0f7ZBmWrJHeFQYdy8/2JqlRmaw==
X-Received: by 2002:a05:690c:3383:b0:6f6:8b81:4c90 with SMTP id 00721157ae682-6f6eb92218amr153633487b3.30.1737490877153;
        Tue, 21 Jan 2025 12:21:17 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:c52c:1d3e:3dc2:a210? ([2600:1700:60ba:9810:c52c:1d3e:3dc2:a210])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63a96d2sm18708657b3.24.2025.01.21.12.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 12:21:16 -0800 (PST)
Message-ID: <35026c72-f9b4-40a3-b528-1c28b1238972@gmail.com>
Date: Tue, 21 Jan 2025 15:21:15 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] pack-objects: Create an alternative name hash
 algorithm (recreated)
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im,
 me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
 <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/20/24 12:19 PM, Derrick Stolee via GitGitGadget wrote:
> This is a recreation of the topic in [1] that was closed. (I force-pushed my
> branch and GitHub won't let me reopen the PR for GitGitGadget to create this
> as v3.)
> 
> [1]
> https://lore.kernel.org/git/pull.1785.v2.git.1726692381.gitgitgadget@gmail.com/
> 
> I've been focused recently on understanding and mitigating the growth of a
> few internal repositories. Some of these are growing much larger than
> expected for the number of contributors, and there are multiple aspects to
> why this growth is so large.

> The main issue plaguing these repositories is that deltas are not being
> computed against objects that appear at the same path. While the size of
> these files at tip is one aspect of growth that would prevent this issue,
> the changes to these files are reasonable and should result in good delta
> compression. However, Git is not discovering the connections across
> different versions of the same file.

> This series creates a mechanism to select alternative name hashes using a
> new --name-hash-version=<n> option. The versions are:
> 
>   1. Version 1 is the default name hash that already exists. This option
>      focuses on the final bytes of the path to maximize locality for
>      cross-path deltas.
> 
>   2. Version 2 is the new path-component hash function suggested by Jonathan
>      Tan in the previous version (with some modifications). This hash
>      function essentially computes the v1 name hash of each path component
>      and then overlays those hashes with a shift to make the parent
>      directories contribute less to the final hash, but enough to break many
>      collisions that exist in v1.
> 
>   3. Version 3 is the hash function that I submitted under the
>      --full-name-hash feature in the previous versions. This uses a
>      pseudorandom hash procedure to minimize collisions but at the expense of
>      losing on locality. This version is implemented in the final patch of
>      the series mostly for comparison purposes, as it is unlikely to be
>      selected as a valuable hash function over v2. The final patch could be
>      omitted from the merged version.
This series has been at this version for a while. I'm pretty sure that this
is the most promising direction we have at the moment for improving delta
compression for many users.

The only decision point I think remains is whether or not to include the last
patch (--name-hash-version=3) which I would be happy either way.

Thanks,
-Stolee
