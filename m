Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471E27380A
	for <git@vger.kernel.org>; Tue,  5 May 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997913; cv=none; b=hws4YF4DjV12nmsIPXrwVQQLhDXOX9jF6zsd8t4KvouXRanZgO0z9ZaOCR1yv9AgoW3x8OZCiovVIVCWUMYBcBemIIzSbSgXvo0QiePvOlOavV/E1+5F0eu4NjlBGC+puHOveyKPRMGkB0O4KsMr+GYzxwnZXdUcUrv4jHTYURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997913; c=relaxed/simple;
	bh=Yzj6IyVDwT6CxRuZDLGnDyK4aLyiDDaRePc9sVPseRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0cqzxll8+OsJZ8ref9p4ihkvhcmtEeFYyk7LI9qtcimTxkHaRfeWT8wsf6jH6Tqm6bb9krLIJ1N8HOhA4gYcQR+Hv3wzveimtydWZSrNDUi51fTfTOAGGpppl2iVUAI9Dt3e/RNZ+h8S+K9Bw46EYkOX1YKiV0cF+V+E6Lbq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhXC/0E8; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhXC/0E8"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbcb467f2bso4968356a34.3
        for <git@vger.kernel.org>; Tue, 05 May 2026 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777997911; x=1778602711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdvZbxoG3PM5OxBBMus/440okVvC1FewTKyiXETQ3xQ=;
        b=GhXC/0E8Wy48zS9qhnbnOiK5SpcxBP/3rX9kOTS141cDBjbnxD/Iqbtz7SAPtRxZQF
         9nIKD52Pjsmlv1OpAGGnu3FMWEIDDtnsp6i3ROiCY1c7lbCjMl4aYpcV+qtO8x8WgoBT
         c9F/69hQF1qW0sAvGDcZJKuGuoB7k4M1HdzyS9FHPpegudotI0TYJ1nhyDls4kIJzEru
         hmPDNigxZFhMBPzBulL/CZ8NlSk47KDccmAgbln6YG5lsgWqqDztqlofdYvwO+Uz52JP
         F2c/qB/DOcOBBYv40oAhz7fnjClwGVWAjutGf3hQyVP7X52JAPP8nfDqs/m/ed1vt8FX
         M5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997911; x=1778602711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdvZbxoG3PM5OxBBMus/440okVvC1FewTKyiXETQ3xQ=;
        b=bNtXI1h1jRuRdZzgdnwM9ZVMO7Bn50VRmA4ZOgUGwzBcz80Fyh9QCpSDEBdqY4mmmp
         Gooovy0pDb62UWgZQehce+Ap0MpFrT6+sC4FB7A5WaCG7jnVS1MOx8J68vj7zx+IOP0c
         xG/ueDzXAI+Src/YvF1bTzK2dqmeY31bU48Vv6YZw1ffOQwlprS4bRLEZvaXcWNs3xHF
         Xu+3aMg+rpU/n/fuQLJAsJlaNCQBBERS+q67YY/a2ysoEwnayReg2xHGhNd2rhrZGHI1
         BISmwSwN4/jtOnqu1rnbKn45P3eI7hfJZCUGgynKWiWNb4unocdU09oSB7ZpXmmyqmxu
         TUAg==
X-Forwarded-Encrypted: i=1; AFNElJ9oYIsv1tSQDNWgQ1HPAW5olk3hyO2V36s7CG7/5+3EDLoQcM0ZV9wHHKA7EQlYoIGeenw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Rl1Vs2dmsluJmpqJLXmdlGujhDX0/gTIU4O3D1khzhNpWZx6
	bnk8/ufljp4MwCMLWqYCPlz0lAc5ifMWWhhlGxbCtuXFnohqoxgZjLUS
X-Gm-Gg: AeBDievtuzSA071Z/Ii0VatCn7qlL5uw9AGc7NZPraViX+3liPTJoFFmVa5wMfGT5Pn
	aV5knyRnI9pNXaiypI6Gap+7HIOj4HrBd73GIZ7DYQ+ofv4+SJyU86tebbiipvTO4f4Aka2mcrH
	wsNZML5oAV06XV7c+/q3hhV6Ca8TQJt+fIHw1jqH0O+mqSzACaDH4aM19aTlis3wHfzqRS5+F37
	lh4sb1XRE7VotiqZwFnvytmAWWV04Vzf4MEnK0cqRrwp+i+sHeNGyu0JnhA1noaDE550Gm8F41T
	/2qLHfb9bg44K1pS7m+V5JFdKH/xjFdjx9fBHhyCebHb/YWh7UozISBqrAusy+vJMXdlC6B8vz9
	e5yBfKd4fVdaEdcxAA1n/mWu21pR872DB9+lk66Cz38H5G0obzW0nkWxf2TU/I3wG9j8q0bxkU6
	eeGpjBwGKLfb1gK4quCQ1sjLcIe/okuwgzzTES9GLparRlV9aReAB4DSZnUAVCp4BLG/rnD6h8n
	T7uVcH8TVfhw2O2umg=
X-Received: by 2002:a05:6830:2b1f:b0:7dc:c7aa:22bd with SMTP id 46e09a7af769-7e1749a9dd5mr2393725a34.6.1777997911111;
        Tue, 05 May 2026 09:18:31 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca7a9036sm9914987a34.4.2026.05.05.09.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:18:29 -0700 (PDT)
Message-ID: <f5d8d4aa-2453-45ef-bc96-2b94bdf55c7e@gmail.com>
Date: Tue, 5 May 2026 12:18:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] pack-objects: integrate --path-walk and some
 --filter options
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
 <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/2026 4:21 PM, Derrick Stolee via GitGitGadget wrote:
> NOTE: This series is based on en/backfill-fixes-and-edges.
> 
> The 'git pack-objects' command has a '--path-walk' option that uses the
> path-walk API instead of a typical revision walk to group objects into
> chunks by path name instead of relying solely on name-hashes to group
> similar files together. (It also does a second compression pass looking for
> better deltas after the first pass that is focused within chunks per path.)
> 
> The '--path-walk' feature was not previously integrated with the '--filter'
> feature, so a warning would appear and disable the path-walk API when a
> filter is given. This patch series integrates these together in the
> following ways:
> 
>  * --filter=blob:none updates the path-walk API options to skip blobs.
>  * --filter=blob:limit=<size> adds a scan to a list of blob objects to
>    remove objects that are too large.
>  * --filter=sparse:<oid> adds a scan to the chunks to validate that the
>    paths match the sparse-checkout patterns.

(I need to update this cover letter to include the new filters.)

One thing I discovered when testing Taylor's series is that this series
introduces new test failures when run with GIT_TEST_PACK_PATH_WALK=1.
It's probably due to new cases that are fragile to the difference
between delta compression algorithms, but are now exposed after the
filters are no longer disabling --path-walk even with that test var.

I'll make sure these are fixed in the next version.

Thanks,
-Stolee

