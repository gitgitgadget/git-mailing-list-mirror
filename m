Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31DE2EE262
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806715; cv=none; b=IKuwxLTxAEkKftVewQZiDd/dm6ACiy/PY6+tvbnzkCpAZcq87lJwmENHCPixeyCV7Odr+UjExdVrlAkyTk4szgr5tzAVIZL95412jSdCT0MY6QHN3LwJWnzRDlvohpnH4CX+TY5Ww2F+08t3QFJAu2bNWWWqZp7hgn2sUJhU/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806715; c=relaxed/simple;
	bh=RroEcu73/re29li1fJS/ZWTcigUrRbSvTC3ope7zbOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAAraGvKTB+04/ErAv/sBKV4+cKH7GOBwtPN1es3g3HJ6EwPO0rA0NERWcQ5wg1PhNsVrETJ83Uy7Af4MWPG1PigtdO8JfChOEeMeAdT9MU9b9RXn1iqlGRO3/YRwdpgMinfs2AyZ+GXeUmYiKtlyDRxTgqrxg1tAphp7/oVIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvchZr9r; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvchZr9r"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59ddb31ddcaso2719831e87.2
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769806712; x=1770411512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RroEcu73/re29li1fJS/ZWTcigUrRbSvTC3ope7zbOA=;
        b=TvchZr9rXjUNqQuegZSpv0vmKfo/xHj6cKfKpezSa5TUE/iJv59ZcsEPrad+EXSMp/
         DdKMgcmtUsc7ajLmwxBlv+PUK3CiabZXKaACd7Us59fXAGvHXrWnMXaTt8QOQlDy7RSI
         Dn6mFau0D0A3p8d1hZ34XPh4qNAWAzrkFIA12Ju1IeWX8B1AcoZ9ZLcLHSFQ3z7rHjYT
         mwWTxyN2zuVs8hI4TiPcqFh0HV2XxhWwsOGET3YGlibAtkJwBcqMvUQ46wfA7wXXl+dt
         ldsa8Yvn9bgC3oUCUVfv127LwEZMeOf6U33CM09N5XF59lVWzXjLUOzlx5U1J0TLNVzc
         9ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806712; x=1770411512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RroEcu73/re29li1fJS/ZWTcigUrRbSvTC3ope7zbOA=;
        b=Ndax3IV6bl5nlx/lua7BF9zhlSBmPivgUXBB3zK6Z2uwH3MY0Hq66ViCf90FfQwxWH
         MOlsx6GGVUEr9RNfe+8kPCfQ6QRJsii/4wM/cNrL8Fymk68c5m95pGSLgHU6R+OJIxUl
         /2Dww6SF/epQ0G2uGYtr0aQ9g3tKzmOXYcHec1gwGjQE8R1P2wuJgOrjsfQzNk19DrcJ
         XSCmYBkssECo75MLxICTDhVF614ZECQ4c5t0zXwLSKu0pizU1Bn9PE3vs96dPbLDcK6/
         xffsw1sQvwJM0dvfkdC871bp2N2YiDog2cNEKxKHnw26c8nw8210APaHxgVHFBrrijiy
         MiQw==
X-Gm-Message-State: AOJu0YwBhEzQ97SdGyX+NIpahSgdF/H5M6YZUZ/XWW684mHM9oUSURJB
	VsGXewP9Mkku4dB+tXtfpH2rP7lnRZp9GjqE/1sLRZ7jEEUdrKgt0Pin
X-Gm-Gg: AZuq6aLarNqV0Qvo/7tWOGn0OJsy70hm8r2aFYr5RUS6NhGkZz/RXtfdjktLtN9THyi
	U+T7rpCsIppq5a2ySjqjU77KZN6vbukuWebt4AarlfjgvnMaGN3783Yxub5gv8p8wEWERTfPuKY
	R4IHIm9b/WSEF4vbsJD9/j74zez62FQlY9FITsVqO3A2sl+JahiVvLTxD2A2cyOegS4Do+yV7CP
	WVWx6/2oxIaWQzWnPmz9RyFsli8QJVyWwTXDNEak7JXCbT7wGobFZ2TaRLoNUyJ08QTz/RZJSJL
	I0uDUR3MCMJgpJ8AS69fQUKCYsc9Rs5wTPY+OhSehzfJip0Hz6vWAXWuO+Hg+4nFngJ/aMbDdke
	4+4h4bx4dRqOwSVCWqCoYEWIVueLJsDWYstd3QvbLNR/99HdxuDytbOcy4iCbnX0eKJMCExr9fn
	7VQBAgxfKMfnMA+xe3Ly+hTG9GcK1nPVBi8b45C2j9XHlmWSUJBV218zVsqKa586ww9F7ih8NvD
	IdZBIHXIA==
X-Received: by 2002:a05:6512:32c5:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59e163f5785mr1507168e87.11.1769806711768;
        Fri, 30 Jan 2026 12:58:31 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074819c0sm1926370e87.7.2026.01.30.12.58.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Jan 2026 12:58:31 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Fri, 30 Jan 2026 21:58:30 +0100
Message-ID: <20260130205830.45806-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq4io3831o.fsf@gitster.g>
References: <xmqq4io3831o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I pushed a WIP with some of these ideas now, not intended as the final
thing.


Harald
