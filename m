Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904333431F2
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014952; cv=none; b=MaC+79KfDfC4KTe6CqjqzqiTdWSWeQMw2zTnZ7qJhX3uhvj4rsESlJDbuAZfYUDsD2ZdxoqwT+xGzj+F3Oq/dQFNAWuSTJNeqqNMIg9Eb5yOiBIks0rqmBcHV95aKGtM3XvowWii0YAFYliJWHvnJekvM8jVgyp6ot6oJn2du3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014952; c=relaxed/simple;
	bh=RDOFsMQawE3FSyV5q2cx5w2qA2LpDl4532+5JiyIpSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4HlcpVV0fFxtNv+PR4mre6MTmf5BIlMD2Cyzy5GcdqGuL5aOSfy3adhRzJfyO5WUiR+HWyf6/gbBKCzGP1FlANQzgPgCfijaC92bGso4TTmJe47b9nUoW5MxDSzhKwzvIh6Se+sbqS1uCTTRLZjKfcCyokYe5axyIWOzW5Q9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVohlIJ1; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVohlIJ1"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dea72099eso6838985e87.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 02:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772014950; x=1772619750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDOFsMQawE3FSyV5q2cx5w2qA2LpDl4532+5JiyIpSg=;
        b=bVohlIJ1txak7N+pZcrAA46T0HeZzgG1Wc6Cj8BsvbHziJBO11YfkQZP6KLQdVq6N9
         J/ulCa0FVQwfvnJVMpzwl6cueWhCKeNxNtHODJmMyQ1/rHAmo3UE/crBTbrAAwRZpXTG
         7udUXQUVW904izWgRrwwAWA1lNfC3kQRI1GjaglM3OgUZEITax1DsGSIzpTRrx3AnHgy
         RqI+iao4jsqa3iE/tPp7mmKtNBWdIVbffWhlXSyqRL1bO6eUvDr5ly7JcSj0gIrTnrol
         Y182yVyeSIwcjFq//I/PAI4xaR9Kb7QQu1AgcrTmDMEoRjKU8GY3TY0DxYDVaq0Jxd2a
         9wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014950; x=1772619750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDOFsMQawE3FSyV5q2cx5w2qA2LpDl4532+5JiyIpSg=;
        b=vYXoxeSJEbvGJpXmSd5hEkZ2MOvBCMcCGfFf7OJQEXzElzVxfe3JduU3iO+2CnhiD2
         zM8EzDQeEDEUTHsSI9SeA4Gq0y81QYA6iTCmxWyAsXsytkn/cAvdSyzzmXNDggFNnLY7
         uVA8P2XIpc833/3NRfy3k5X+7bsHd2IYYBflhzdcojNIFGm8ylyAuHhrBzygpiSNgCL/
         2IO0NXg5YMHVtipjg1GGJS+oHkrKJgEJxPxwYyXT+L7U5qEJz43JEXNXTlV8VC1DX4yh
         QXFCHYgmPRrqUwyeI2tnCgnvggRrH1StBNF364J9CwD++i9axVkPkiFVaobWKxaXlNgC
         IVyg==
X-Gm-Message-State: AOJu0Yw3WCWxGZRRGPFtSr24ya1lRRu5qeRJCMcRvxSAYKFxEdzB/EbD
	VXYBC/GKTJ9kjTUElao+qiGXoEy0J7MWrvnv7NDZEWazrTJtvNMD0DZXjRjI2w==
X-Gm-Gg: ATEYQzxf0XHkTK3h/OmgEjq/CFsLtCTdyFWpQCwwuDdJMaB3TL1d6QvM1nFG3dqC1Dn
	qISzY2PWlIRQIOc4wvb45oj6g+VKwbvZ0DU+QeByrCEmoet+N/4/S7b6fz5lV71AIY5uOxPH21P
	nEeISwVFsfEV1mqJdNcqXdmacqEaI4zAUor1cBjdiNPuNCjYzSrOg6aKhnVA2XBKt4Fz5OPOysb
	jTRBE82iiZARvbni2nmLeQtdL9Mf7FTmTvepCe3zoskrJzrIlSnOEzKt4JX8KERRFpnkk5id9m9
	qiXocj194cUtf0ngjwhH5ouBsZn/3+NJWJa5Vlo56E0PpWSJTnLC/n4cuTdJMY0a/jpdS8KvSCj
	sz0y/1NFECKcKAqUCLtxo19b9vP8q1TawZbK943iBnuolEDjL9AERMha7aUZwrqo914tZBMvJOa
	+jx3ThTUKmy/1hhmkO38KV2KdyB5LeQS6BOy9PlAYQM2meyFwabuXNNkDW7tQUWIXNSU/ggomhw
	/8lZ6M8U3MwCw==
X-Received: by 2002:a05:6512:2310:b0:59e:249f:81c7 with SMTP id 2adb3069b0e04-5a1026ed1f0mr645992e87.30.1772014949451;
        Wed, 25 Feb 2026 02:22:29 -0800 (PST)
Received: from Mac.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0fb7a89eesm1031214e87.49.2026.02.25.02.22.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 02:22:28 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net
Subject: Re: [PATCH v28 2/2] status: add status.compareBranches config for multiple branch comparisons
Date: Wed, 25 Feb 2026 11:22:28 +0100
Message-ID: <20260225102228.95152-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqms0xeqaq.fsf@gitster.g>
References: <xmqqms0xeqaq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> So what about this. We add a config option that takes a list of items to
>> compare against. But it _only_ supports @{upstream} and @{push} for now,
>> and interprets them as branch@{upstream} and branch@{push} (but probably
>> done manually, not via dwim_ref). That limitation gets documented.
>
> Sounds like a good way forward.

So if I do these changes, are we ready to merge then?

I worked on this feature for 2 months, and then it got marked as stale
instead of being merged. Will this time be different?


Harald
