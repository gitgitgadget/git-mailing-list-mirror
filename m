Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950882;
	b=AbcvKrQd5eYXDFqRVnm8RtSLqhZ1sbOecCiLkqJTGLSlnVvIuICoKoqf9mHRpEBqo5QZ
	 Ow2fmoCLXHryd5zX7h2vipNnRi7j2wIfe8SxpKMz0T85ELYYgL9Dbxgim5Ef6pmnGTkxe
	 2ByPo2npxYPutrViG9SzU8hMEu8gNn38hxu+DJjMyDiJKC5mREfVsa60WmXvAtFsSvYhZ
	 H9+r8CJcJwEcj8HVNxo71Q8wv7Yk1jUlIqEylWZJ+xAiGP67Y8ZhPm1ERadVYlDjiZu0p
	 kMY/SuCB2QYOY1dqm/AU7IXrM9/ST2w/iHshDPBeRNsYKHtxVkth7/kHIUKUph1igEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0mGHsnLN7tnMnmU3AGUApcnr+aHPXxlV5r9PVpnjTfE=;
	b=1HmZOdEddrMwkRg57JJ8rfapd7XGiIdriaFHBGc83M6cchkCtpXEXb1rn5FpLyEX3zi3
	 ogjoXpLBsxLilhR+EOGXeprv6812idpZW2Ky30QDALe678Ytjxm8mg8JX7gzDGr67X92s
	 /u6zVOI069ftqmNJVbnQjmR82UtnJMBTPMLpIbmANSCDWFOQPcVd3CT940InUNj6fLvC1
	 3rFZZX9zC1iN636pvpQEgE4V5GzoFeiza1Vg49V1SjrOborKXU+uBa9frzyW/2zsmqUA4
	 8WbbNJuf6Jcgla9DE7t10iUwL4CrOfgQkZgi+sgcundilwInR8Ndwl6YtAZvJboCEXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5q4gpmq;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6A606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 21:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B5q4gpmq
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso178569f8f.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 13:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794950880; x=1795555680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mGHsnLN7tnMnmU3AGUApcnr+aHPXxlV5r9PVpnjTfE=;
        b=B5q4gpmqj220EkjcsVlp+vtdD+EVuRJ4xPuoz5YUteyq71+OaxH1XP9EJ9NmRDjn5n
         QWm2GAkXAfJWTcuIQRzlUOwhn3irodKxYGGi8P8QTDeO+s+3dAmrD9n/nMeSJXBlmJhn
         Bc6Wk8x/lIX5vM0ct18znQIgFWa8Bndc1rBvj+V2gzAEDpZi7lWnGN5ntL6Y9WDdjfjx
         LnBpamOg5JX3mKRpmKMsYB018Fna99jBkmxRlojUWoztJRrkBUbUjXMC+jvC8N3EB6uh
         FO6HaIDPLf3Ru6wuEF46ppULd4AmdYNZV87aG//uA7nInqBr+2cyI6nxIqc2sVJbcdCQ
         BAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950880; x=1795555680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0mGHsnLN7tnMnmU3AGUApcnr+aHPXxlV5r9PVpnjTfE=;
        b=bs5G5aC5de3tDoJh/ZCtqZ2Ry52uMmC7B3c8VDPH/wSgQ432SdkE59mIvq4qs6ZXpm
         /ESNSkkjhmB1td6tu4YmRt/3Ns+47bZMk13bjVubF6zq6ASCViQfxUDf6pNRdcLINK8B
         wQh6cgwFTnwXT8BWBzsoMChoCbcil1VkACZzVZMF2eZe33zW2nmtKX6IBn8xyzAi3N6H
         14Fg57hJIE2APjC/ya11IXl/B0dm8DLzp83gPW6uFO2HI+RGNTNycBRpUYLgKVabCp/z
         ktWRODxvDL6C2IocPE5O4DoQQdA3o1o2fTP2xWKRAJ2Yp1Xv4R4ogu5xdxl5P7eYYxoB
         tXxg==
X-Gm-Message-State: APuU4Z9bYxwKOlYYFa/KOQ7C+gwUU125D2CE8jI2+Msz4ifzmbBqurUw
	E6VV64prSxefCwP9B2t3yMAwWjXr558J3aC6UJWTCC881XFF/XFpSHwAfwS2dA==
X-Gm-Gg: AZFdTZdHHjPuqJqUEtAEh6QT4UUCsGW4tDEtVLK6dASZJOaScbFRFH/+uoK9axRbMef
	LFf8wzuRHWgYBPoT6yDzx4Zh4Kv1YxfIg3xUzY83O+hFww9Wcl3sjNBmQ5CHczsvuLLdWFGBXrS
	PYk/bQXv8nEPDlRwjSD9ppCKw4ZP1hTt1nZdhPRSrr7WkyC1YHjSWt8AVSKaZQ3jH0SSDaNmMPl
	b2y+3NCe8Y/K63ALYSfEdTVDPXH6XkPHyjfynawDBO/24YvhLToh2NMFLqDW7wPIanvixq29jfD
	aRLvs8RHtn88rg6gU6CHLxaTurFNQPczKQWaxvJ50N8fFnkYVLneKig1ZKWS+CuMk18QVGSPvIN
	0CVMA4EPo9PzHJvRRpb7GgTY5IoJVSMKGNQpTIcH3sOehO/67mht8F2x0m3CZNlV1Ravq5isiSJ
	0qjesk+HxYvxJkyf7CgeJGX02aeo1aMhUYJewJbzvsvqItRFjbeBwUJRxWVcjG+rfYb5y27DbQA
	+nmN/iQK78nR0goafezGDI2LKF0XoOrKY/w/ie/rX2AII9Chf65ws6TGie+LaP0jFzqNRqH5Tox
	Dnspr8RgqUnQUUqIARCDCITb4DcAjzP0rL9JIhNxYV3MEEi3z6AAaEvMiJ2VRBAt
X-Received: by 2002:a5d:5e87:0:b0:4a5:33ad:8724 with SMTP id ffacd0b85a97d-4a62d6d698amr1654705f8f.0.1794950879749;
        Tue, 17 Nov 2026 13:27:59 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65560911fsm941325f8f.26.2026.11.17.13.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 13:27:58 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	haraldnordgren@gmail.com,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH v2] status: reword message for a missing upstream branch
Date: Tue, 17 Nov 2026 22:27:56 +0100
Message-ID: <20261117212756.716005-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030090545.9744-1-gitter.spiros@gmail.com>
References: <20261019175722.5223-1-gitter.spiros@gmail.com> <20261021072137.258934-1-gitter.spiros@gmail.com> <20261030090545.9744-1-gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Harald, Junio,

A gentle ping on this v2. It has been queued in 'seen' as
ep/status-missing-upstream, and "What's cooking" has listed it as
"Needs review" for a while. It still merges cleanly with both master
(e1ec09b23c) and 'seen'.

As far as I can tell, v2 addresses the comments Junio made on v1 (the
shorter "missing" he suggested for "[gone]" will come as a separate
patch, as I said in my reply), so what it is missing is a review, but
please tell me if I overlooked something.

Harald, you found the idea sensible when you looked at the RFC; would
you have time to look at v2? (v1 was a resend of the RFC, not a
duplicate, as noted below its "---".)

If something needs to change for this to move forward, I will be happy
to send a v3. If nobody finds the change worth having, that is fine
too: just say so and I will withdraw it, so that it does not linger in
'seen'.

Thanks,
Elia
