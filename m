Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C232D452
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473193; cv=none; b=bUHCEuM0HdZh8hNVuYM1y9NRpnfkZj54E599qsNzusM4AJTbBEqtFEIYjd/aSuq6MXt8vkpmO0aB3R3ENiN0KmanUjWsV6Ip52OUZVOtfFzoTDzVO+z1YaRdnFWl9waa5En0XOWSre74cLm3eXU6UFAIpoaJc96hmnsyWXH7w+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473193; c=relaxed/simple;
	bh=Kj/wmEAPqD9qct9xZzhehSpNucD+kT9Q8G/AuGPnelc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctqYzY4B0Z6hktEAx1QyB70ITKw4+k28L3VwTtI/i2m9AvIPwncTUZcSH2vLarnLqSK4uTePFU2guHuVZULUFVKr3aGFs5S54Ea5DDG5EeWAsQnmVxTEW2eooyoE3QbAKPl5OO+MKphfX02zNmDgzygbLCmiKlSY23Dd4/Cu38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTlmrF0H; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTlmrF0H"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so186311a91.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473192; x=1775077992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4jb2W3FxtnhVkeIykNqYXjEwDpma6gJfdZjSlZG4qw=;
        b=qTlmrF0HBDMJP4tEri8uVkVsOJM6YtFu18+BUkFbnXfvHxCM7wLrzsKnbubH61sxkv
         SNYpnGLV/DdRvEpkuu3zH6RN+PcYsjesXwk6ijHCNbPazC6iN7OfvicBaGVJcamp2xUQ
         Sx5GTBtaq8vstCvZq1Ar9vMART7vElTN1tKdfZRlimkdr3Z/LzQlGflhKrJfyVys8Mg4
         zxxlkK+imVLr32Ze6BE9C2tCAopPNhckfj7jrScdGWf1wHUiSokaN/KuJPfRSEuobJ7w
         Se1nf/fjMCENki6u4aWj/ww825zkLAdKHBEO+pmEI0hLVQH7hzrqSNiOSd2k+cGhAT44
         0TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473192; x=1775077992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4jb2W3FxtnhVkeIykNqYXjEwDpma6gJfdZjSlZG4qw=;
        b=Wjw04KmXsw7cUegh0HUKLC+BUwo/G0XBE7o2p8kTihpOr7it6I9UfEIFxTKBwwcAWz
         xiPOkL+2QTGWj+ledmCixG9gcT7dT4+l9yUTsdAn6SVqZh+POEf4EHdSjl4/DF1M3+5J
         PsVMuBcj0PVa18PNvxkTa/Ytvfaz7cSJYEXDEoUuy/gFDw0+4WAdxUN8GheNl1ybegK/
         vSTgV76htuqimPGbN/5cEXMIRgYRrk/aCwBRLtxEAe/vbv+pWhjGqe8YgOj4KVjVpm7q
         6g6/I+39qGQVM8rncvPgw+fbkuDMUricLJrEny5U1jEj59laVnfqECRWaHy1ah2aopDY
         rJ7A==
X-Gm-Message-State: AOJu0Yw5mqrrDZca9t3UTaNsPCPIM52hK7ZdYYwQUAs6lyR0n5EjGyiN
	Vs04MfdCERJUsiOgN462OayHtNOyUF+abqiqOk6qEAdaO2q6oaOEFmoNXJZkcA==
X-Gm-Gg: ATEYQzwYfGWLM+1mgTQGNBTSsVbTYo3/a/OuUY3C9TKdh3oHDCww97AtEaUF0LH9qN8
	75/73TaNgpv203d4Ru+ZkGOVNXydrCSGyjJDLJ8VqXvhgnaluKdQtbJvz5RDrGuN5c5nWHaN9z2
	n8a2iBVrChzXrMxJm5+M41E4vuz8Z1zUvIzoe+yeWHHtbAkk63Ntya3RYCk5c+BGfrABbt6QmCi
	OjwvOcgFo78EOZQRTn/tcHT3mbzqMI/zfBLUgipdf4Q0UOZxP5ysOA2WsjnaikUmcNnmU1KkZdb
	bVKmjbomC111lG6p9f1zECSXTT404vZAvVVr8Lr0/W/y4VLUpANlIIjg9aohWwmjp+23BtkrFK3
	pBa33va3HoQEQ3PydH1ibnob1TiQQVSNGqNXMfxo8MHEpIfc1Qixu3Tj4ut3QuDjhqeYTwprDIP
	PplwYMqOmuvRYOMKL79jmJXI7cqUTBsuI/b/eFsdEZe5A=
X-Received: by 2002:a17:90b:4f8c:b0:35b:982a:28c8 with SMTP id 98e67ed59e1d1-35c0dc8f9femr4807808a91.7.1774473191676;
        Wed, 25 Mar 2026 14:13:11 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6f26:76cd:bafb:15d6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c1df87c14sm207723a91.13.2026.03.25.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:13:11 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: xmqq1ph7u1sm.fsf@gitster.g
Subject: Re: What's cooking in git.git (Mar 2026, #10)
Date: Thu, 26 Mar 2026 02:41:30 +0530
Message-ID: <20260325211240.1260690-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
> >> * sp/add-patch-with-fewer-the-repository (2026-03-17) 1 commit
> >>  - add-patch: use repository instance from add_i_state instead of the_repository
> >>
> >>  Reduce dependency on `the_repository` in add-patch.c file.
> >>
> >>  Needs review.
> >>  source: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>
> >
> > I think this was considered ready in the previous 'What's cooking in git.git',
> > so the status can be changed now.
>
> This was listed in the new topics section in issue #07 (Mar 19) but
> I do not recall updating its status in any later issue.  The only
> change was in issue #08 (Mar 21) in which the topic was moved from
> new to cooking without changing any status.
>
> The only comment the patch got was from me about interaction with
> other topics in flight, and there was no discussion or comments on
> what the patch wants to do makes sense, or if the way how the patch
> does so is correct, which should be the real review.
>
> And I do not consider my single reading alone a sufficient review
> most of the time.

Thanks for clarifying.
I might have misunderstood your earlier comment [1] as indicating that the
patch was good to go and had already reviewed.

[1]- https://lore.kernel.org/git/xmqqpl4v92eb.fsf@gitster.g/

Best,
Shreyansh
