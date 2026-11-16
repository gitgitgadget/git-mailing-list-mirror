Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845761;
	b=ROCt74Sman1TOPho+zwt17/SF2TP3UpxrhI3+SYszQCt5jynaAUHhiiI/tea5RLtaZ28
	 rSgA1c0XF6BjCIMD6AtjwF5XZbuOGJ3nJrSjAvpwCDP0tRZqHmNxqTJzjhL/KJFEz+Ynb
	 XC0M5qV7iPK9SQthru23XnvwY+MkuUIQMM4pIjQZKOhTr10njHYOT6wu++J2dtAUeDBok
	 3a24pSTh1PSMVKbsRL7JHJR5IEiW9ef/q8jVPXqZBL3rqm8Z5XwfcsoZytW5nZ0WeGZz/
	 jHgltJqNqvWZMqhTzlxoDKRr7NNWP77luDxz2MzwYB+nl2nozfT5z8DsRLEgjIGftJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Yc1H39fSAeXAXK0T2+12s5KBmAgIiQzTXOatzWYOPuk=;
	b=HjPSkcSVWx4wiTBYts97xFQ2A/OlpGuLzBhxe5jk80aot6gj42WJ2glOttmrmZ6/iBhO
	 UEAuMgcHEu3du7e3sm5OE1zHZBiiK0KYej1FoP3qtxUjDRcnjSmT7TBcXvtzGVarrAjD1
	 G0HB2lLbr6GgV/MMbtCR9uyZzbxH8n3FWmUurQtqBUpckvbAcaApa3zmqIkIOvfljoobA
	 NnEbjgnCgMssUg/SRLX5Sr/FDFsNvRQI8webA/KJ/NJM3qm4LHXzjza1cBbGaFlCwtTn9
	 6m5SpLLtewfYi7Hs2YPNyBEf0PpCVRiJzCrf3MMip4m8yPmsK8dKGm/REWUfFF0r5Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=DvIbk8QY;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8975D606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8975D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=DvIbk8QY
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-833e671ee9fso4743741a34.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794845760; x=1795450560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yc1H39fSAeXAXK0T2+12s5KBmAgIiQzTXOatzWYOPuk=;
        b=DvIbk8QYP0Us/lXReorYsYGC5oA8x9Rq6hSrNhXGxorCeWgvQq5IEBGxV+2i4P8CcE
         T2TIjE8boChnG0keRrbqzPjKLYZuM3ARgpkJtCTK6QixfAJHD5/zNF3q1FdE5SlbvlaF
         xjDk5PZGmjAiphuZq0CzXmYG7TJQHTbJUlCGF6WLC/I2aIydNGuDsA0sTIxG7/pGRzBS
         4wyXg/PG9Byc+PTpEKTu+vyKfFyv2Amp6suwni638F76Z/WdnfJgGF8kPiYPtkjd00pk
         rtSm5+LVVieiqG5aL7Fkmj5wXjvH3nKEk5w0fDqky7rxwHq5zqVlcPs2UX1X4RlR8F8a
         1PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845760; x=1795450560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yc1H39fSAeXAXK0T2+12s5KBmAgIiQzTXOatzWYOPuk=;
        b=j005IJT1pDto/QiDBMpWYL2Dbs5PgMI+X9zDTQQDSgcj3NZ4pIHgW2zgHq6KVAd3tJ
         yI/n8Nj6AMtbddjb0lqdX+Nx1un6+woIIOHWQdChJfd3uGscI+vUH6oEYtRIB6Lfz74y
         M1yclg1PAP6S5v33CXrNOuGD9/9ByvuCIpgmThatrrGiqg56mD7BmYZbEePME5Tew8cd
         mcHVVsALVVMWKxVMd/0jPZlmpymYjMi1Hn2Q/qduruPazynuGVPVMF7nmGxImWFtDbCZ
         rdELpGmoQ1bsfkvlSMFlU039Qrjx2f1ZGN680xg4f4fLEu4hHfJx/evvvBQSLhHPPt9M
         bWFA==
X-Forwarded-Encrypted: i=1; AL+hErGijs6QjxdN74qsPiJUcdAub0lLLxQwQ/fGuXH6ytbemjRQLsLT8HFFdukPyUJdYO+aHH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CcMBtSdTPqHjslXaFLny+l6GuOEm2xv0qZcIxPaCBdYxMT4E5
	m32NhopB1eZcORckdJRfEGJRYp3fF8SQI4qTL/4mNGRtqmFi/6Chz6KDsVP5wcc6isVKErZHyUZ
	7WUMFGOCxc/eVz0rfyP8y0XdUP5gkYtdEjKew3jujLoRI/O3kg/ljboFo820b3E2R1mmcLj+ro2
	mpfA7Rv74R1Gsm0VO2JWQkYTqfh3mNxo0=
X-Gm-Gg: AYBFou0aBBEnW4NujBfERm/5p/LwhJYlvxEb4xHvn83DY2ypuRC2Xw70D0Vh2LOz4jb
	8B4ysQ7AZhdjAzKE1tfS6HoRH0EW9ayUtcijF7QiZhihXmMFY+EKhcne5B4iyn3t3R0YqAq5QYF
	7IFFTB9nDNXXsppsHMjoYKHQ8Q4A5J27K9Vloay53raPc+VuQu0KhpRYTi37odlBeMJax+YJAta
	OGeeQgPTGYOIn1KMZYrDHeeDRrDifc5RCkim1QL/Yd4s2B1SQkZ6jg1Rjz9ev2IZCTVf5Gl8/nP
	hIid5gsr6W8K4SxeiPgDGzLYTa+2+eWG47HLlFFjFNbHG0asgJhzkReBy7I+xTvZi2/6SqKKneZ
	KBCRehTjVDpAyD9Mlax8+FdXGQjJssiP7Z8y02pK3WE/Aj1wvOlj6UvrNYrtoqIMQvIBqm5t/Xa
	xdzhOAT7t/wpM8OdHHYz+pEgsWP3hsjp6uGl3vaSeKPTufM9bdcD2OGN8nrX1hW7mMICe0dvgRF
	f3IbUHWne/I6TGgfxcL9w1ZwArm7HS7f8VLrsoyEW9Uvzo5oAsaagmeaZ+MLpUpkEpzouQgZwB3
	kTo4CtlerQ85hlZUIOO7pdGPtBhqUcgnZ7qX831kxe1J/RxJEkRfD0WDI/aDh//k5WqMhqKPP+M
	WlwzzJV3FyN9FqAkwvK0Bs0TtdP+zAadbjnewN+I7vAgEuOYo3MokJjLfiUFEXHVXkPfonJR0A1
	kuh2izXN5ZL46LN5iPnfQvKrJDyPr/kQ64b8Fk+BzqORmXGc2AsNvBEiuFJAEg84RKU2On4v2pW
	t/5dKS483aJjNhRSezpZbBNf3SlJ9VIEx3+EuKmnnSviWj2UyWY
X-Received: by 2002:a05:6830:91e:b0:862:cc8d:abae with SMTP id 46e09a7af769-862cc8db12cmr2927535a34.13.1794845760365;
        Mon, 16 Nov 2026 08:16:00 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862d68aac75sm1048634a34.23.2026.11.16.08.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:15:58 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: gitster@pobox.com,
	git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	--cc=sunshine@sunshineco.com,
	--cc=kristofferhaugsbakk@fastmail.com,
	--cc=ben.knoble@gmail.com,
	--cc=haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v5 5/5] branch: do not mark the branch the current worktree is rebasing
Date: Mon, 16 Nov 2026 11:15:53 -0500
Message-ID: <20261116161553.56756-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqq8q2wd0cq.fsf@gitster.g>
References: <xmqq8q2wd0cq.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> that I would appreciate the branch currently being bisected marked
> as such in the list, together with any other branches being bisected
> in other worktrees.
>
> So, unless I am missing a use case this change is trying to cater
> to, I am a bit negative on this change.  If the [4/5] were solely to
> support this step, then stopping the series at [3/5] might be
> sufficient.

You are not missing a use case. The only reason for this step was
that the branch shows up twice in the worktree that rebases it, and
with a long list your point wins: the "+" line is the one you see
next to the other branches.

[4/5] exists only to support this step, so please drop both and stop
the series at [3/5]. Your comments on [1/5] and [2/5] do not ask for
a change in this series, so I do not plan to send a v6 unless you
want one.

Thanks
Jasper
