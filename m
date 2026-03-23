Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B314186284
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774226865; cv=none; b=h2luftFPCyfrbcGybLNVAavwkHRWKxXaJlnpToQXXFvyDDPGHWlf4R4JTuk/1HYPvy6pNu9SDX94SL0mKR5mBTv3EwqFpAmoBpQ/ngt41O9fbObZjT9SgfOAd3kFDBnHQHMp/RJY9Lwf7GCL8/AEzgvmHLCKaQd1JH6C1fLu2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774226865; c=relaxed/simple;
	bh=izMyJgjZSBlbsIUhdzDHo+yTg9qoWYWX3Zx3YRnM1Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8ZZ2x8OrINUcHXhMwBQ1DGsXfdKZUQvAXS4qwoZdkOa6S0MF0OPyDmG5r9LvliRn44FqJBITvlFZbe0S5kWDHgRh3ImVuvgsNfq14Y4Kd7OLxYxDRLIUJjBm7BEiq2WRsOf4L+JHtwjq5PLJVrpvclkQf9yrka1wgcAcfGQQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwx8rlEJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwx8rlEJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50b2ebca625so30916231cf.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774226863; x=1774831663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRyn+aiXDNaT1h4bF0lieTnTMdTR7yQ2SlvgcsfgRXw=;
        b=gwx8rlEJNBTied35cH7NbWDIs99TXMDyX6dpL8C9t5yqD43LfrcRnqeHelFa5ZvegD
         75NB3okrTxAiS+XRMeqvIw+MNwI1aE/Buo0nc4VMzPrBHe3QHMatPZ1wOo2TCxda5Z60
         zaGrRI4CqKBwLEMt0/oINdyNeSQnVhex7UyOCiuAxIfsBFB4G5JE8t/8gr81B+S+8ZVk
         nbLbQJXD1qRy02/mcPvL+U9eTh/EusmqVA6iKTz3zYISJSbtuVyYEB+nBRPyjtTzjAFn
         mAkVFI3nmtDGPj8FQUHdgTRWffQsaQwMjhr9KjefJilLXGUXCJ54wLxAqHBAXvE6mDjx
         IQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774226863; x=1774831663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRyn+aiXDNaT1h4bF0lieTnTMdTR7yQ2SlvgcsfgRXw=;
        b=tQhWKzsPXAkBVTz68cwMSTlz8+6W0yVFXMEOwRLKBwRH9X94IHpxh9rHuH3HC/VGyC
         b6dhdVGkfgisMWEz+kWNYyBjZp9H+3PFGP1M/FNBSHHeQWYYPgX7VJsu7RN7Vqizubby
         YVNsjS+eBeRhm2HewehzBqiaGHWBj+j8PejsWTAWU1AKi0VaECz7aUoBAarZliVb71jv
         /q4XTTRAGTCOswp/7ODw26d3l+eALyJAZGMrh22GEat3RX2tdPUWFuK26EQt5qECGJxb
         Wokr6S0k9QBYMGYjyKAzmK0nxcS/iB8uSjVPfHilRQ3cle68mykoB4z9n5Eli+u8Hbl5
         cOKA==
X-Gm-Message-State: AOJu0YxqYpFBB+unrVDlB6+OQzHMaySa0sDFSKfIbAfNVmfUlOhZ9avf
	sUJIeUfCXONJgqFnDDhMVrSDGNxcToGhPbk1pv1N/dr82zn+raT14a4x
X-Gm-Gg: ATEYQzxQMw0t6prq7Q9QyJ9m0CWs+4aFh3TAPDmGbiMxe6LDdKmw2FRR016CgQDlUCs
	f/mS/x8HsioGFOvrkDknfxWB6v6T7QRXP0tkkZKvyJItAMXu8LwQ0CrarHlfFoC6aBZsUC7aNZj
	Zirg3O6zV3Wlay6Hw+6rUxWjcsXt/yFyRMENUw63PiMJEdDo4aritDFIUR715JPlteCCqDnyUyz
	sW2iha2gK3k4C6gos6/U71irB7TWbgs0tHJ7SSUEd72s9WMpUaVUlKc6gyDEleKKff+x429ZyI9
	K07EOX4w+fuUwp24UH4BJ9pEEd4Xv/powkYfce10aomDOxE0NZheTmNqYs8K2I7oZf7JDi4buOb
	/vW+Ef7NOuDz7rzBkoTLHk4tI1HgeXf9P6Y7lJUe8vSpH6N9xOwF3AatMjEh9cWnjgku7iijRJn
	Pu/V+6bmE8pOBBBKi3KzeLjW6wgDIEAZyrsmtCRy2X2D8B7NdAr8wfQESF5UFPEoSaXS5Ij6I34
	sd18SU54Dstg50FT/DmmoytI5ocVxNlh94zcmFyLVerGAdTzq0=
X-Received: by 2002:ac8:7dcb:0:b0:506:baf9:5dd9 with SMTP id d75a77b69052e-50b2461b5c6mr211370181cf.17.1774226863494;
        Sun, 22 Mar 2026 17:47:43 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c? ([2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36e352f7sm70812831cf.16.2026.03.22.17.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 17:47:42 -0700 (PDT)
Message-ID: <90210abe-8e98-469a-aa15-fe379d2eb3e6@gmail.com>
Date: Sun, 22 Mar 2026 20:47:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] backfill: work with prefix pathspecs
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>
 <abvMwBr_03_Z0nMX@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <abvMwBr_03_Z0nMX@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/26 6:15 AM, Patrick Steinhardt wrote:
> Ah, one more thing: we could expose `dir_prefix()` from "path.c" and
> reuse it here.

Good idea. This becomes

			/*
			 * Continue if either is a directory prefix
			 * of the other.
			 */
			if (dir_prefix(path.buf, item->match) ||
			    dir_prefix(item->match, path.buf)) {
				found = true;
				break;
			}

With the idea that we need to walk the parents of each prefix in
addition to walking all of their children.

Thanks,
-Stolee


