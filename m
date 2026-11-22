Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343416;
	b=t09wfv0xEcXBU2Ijuzw8BHDZb+QKbSgLDTEz8N2a+WteQgfoWhybekROa0JyvzhKOzeN
	 ysZzxqYFTmHph8Z8NJRsfffew7URz7f5dA9LW8OaXEN6LyImg2r3Op+xDnig0y88FmIa6
	 NQR8ZLExJZcTqTLc23h+wWcSPvK7yeLPNxpZmjDBscSsnwF3gpjafsvmmX/F0JLkzqQT+
	 icE4xokUdDbYv6GI2tHFkxtjcuQ1vW0JjwpLEmvHSfCeS5DaUezwi358E9MgNFPx+N9mc
	 Tkl6fFGR0aAihJOJgX3LAbyaw9I3rduGH3TD2H8VVbzjhdPR51PzXXorYWFz6K8perQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CJn930ymePmM8dl+ERK+5WEPluL2rWibsu4KDEE2q8g=;
	b=YhbCj+D5EBHxiupaI70hB4RH1NV+1fC7FETcjjhG5iC19Mo+zGy4N5oG273RSZgfwgOk
	 HZ20LxRNkqFSgYF4cWdBQyeE0oAtFkQRgV+GF35Y4hMw39d6J4CKmpR/MTsfeIMhtwt07
	 geN4x1ptt7N3r7r/n/UXc3yb6N906ByyuLjMchi+aHOspZNOy/CjmetIAnRcVUtWNn9/M
	 pFYL5Kt52WgXs3Y1R4664OHcNqH7cNS+wlMVgZLVuRqyC0o4V3lXk4YILgcukM2Gc15Is
	 g1y5ZMHTYF9ENuwoINLUm/NdLJCcExthyCVIkmzjy9tXOG3dol3qJeIPvbBWyMbXqSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtW9ziIL;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A9606A33B
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 10:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 694A9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtW9ziIL
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38190551625so4868492eec.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 02:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795343415; x=1795948215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJn930ymePmM8dl+ERK+5WEPluL2rWibsu4KDEE2q8g=;
        b=wtW9ziILY67Jj7So4pXR8TFLW/c/Mi3+zwGccOrSXLIEH/p1cDnOmW/pXoBPB9SgvW
         kT2VatCtg3nShn/EcMXvprlCOh9V4ax7dsA/NYcIISjMEMipatvJspZfkOUqJkPWKYCH
         xM6NSXGpU99rkOYEZkBRogBr6hssAZ0pBP/S2VbNDrFlkec+ZotrAWtdtqYYDJUrvriR
         yRGDY0NZlonMwOYJQOJng7yIKEXjL8WVNJYm0E6ilKuk4oQGNiYqft/hQehQCBoxiLmc
         nIb9KUEpL1XvIBy3iJ19lFMoSzuAiW8zp0fiorzZSAF2wQMtmJpU/BU6r1qsqzIX13+9
         BmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343415; x=1795948215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJn930ymePmM8dl+ERK+5WEPluL2rWibsu4KDEE2q8g=;
        b=o81N++lLP9FPQSiMBj01O43hfc3SSd1xUALjBgKUOfcMTuOU1vS+BYQctFfw419Hki
         GjrydmQKITQ2rKX9lscFxWjHTmlnHdmPS7x0SYMn2lWBs0sOW8KUeusfaiYCekwZPAxV
         evI58FdjqbplXfHBLnJrLPKI4U8Ple8KcJ0O8X73w4QH3DfSJGEJJTHTu5frE54e+N/m
         ejM6+wq1xuuLT8rsYPc7mqTMf7UYzcozxPliIQaVFgbVs1E1xdqhyDeZHLTTYRAsu0X4
         +IslcJh2zkM7r6Tu5nMVg4x6yMYi3p2TQvIsXxlTUreArMoDcPbVu5s2/LpyXrkw/z/Z
         rYBg==
X-Forwarded-Encrypted: i=1; AL+hErEqM05rCgu5bU+quv0y9SYu/54z8al1Fkqcm7uWBrJHQJOkataJEuFwYOQeOwzqR01aF2s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uSrpdB4cWIzuHN192EcgcOwfRkMm4ROycri/3z+pJa0E6aIFr
	56a7YUUs1dfKfph9h8EVkXsKyXEyfUdK3oInQJSJeMb46jmwqc4ICQUQ
X-Gm-Gg: AZFdTZfFVuvJ3DFDYOrArzfqqKPAvx3KVV2xGV/giQoFqjzpXrXhq2/RD4LeK4Z4OEY
	SUkLMDVF++MCEj3UL6fNlT3JfHxst2Sd7odc707xBZ/JcJDZe24CcqVMmK3Q6RIizxGkZqT/ciJ
	sU/+ZYxPSk+pTl8rhL0RasUyJ6KN3p6uNMirkkc3Ji0TVy4foQGXMM3Kk2/Y52t0TOoMIcOp2G0
	4KugxkH2Tpzak+kj8Kv/Brr14eqDHybIG6iUY1w3H5IKDkDaW8UqxIY3bsEuCWNe8JyCSVx+zfu
	0j8pQ+T+9LTZWYsPcloQ+9G8xPODdYJ5zZS1t4jSo2iRZ3q3HoTQF3I1Cxpmw5mDfVyEX5sVae8
	JqZI156U2LPOuGAO89/naP6tSdZ5YxVYb3nprDZBS8IDAqwSLNQr07qpXqJUrURcePV051Q0Rbq
	UNcT59ZmmxXxrgtupDRGsArWvG2vwQu3UH1x8bwl+8Gs5IZIeEDDlvvU10m1ahK62WJyJV+MTJA
	L+rUPsGtq7T4DnZC4GkVcJvUzqS3K6T9CCXNuGcuiQpFUKSR3If7zR84BedNIc9wkEeJygtOAx1
	DWhM1VBiXVV19CaGGoOB2WhIXtOx900CBzCK6anPxVvVE/h/yHf0SgA=
X-Received: by 2002:a05:7301:a0d:b0:369:fa21:ba0b with SMTP id 5a478bee46e88-38570847a85mr9924814eec.33.1795343415393;
        Sun, 22 Nov 2026 02:30:15 -0800 (PST)
Received: from Anonymous.localdomain ([223.236.97.189])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38577214c2dsm24495521eec.17.2026.11.22.02.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:30:14 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: Fien Dora <fiendora5@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] check-ref-format: use parse-options API
Date: Sun, 22 Nov 2026 10:29:40 +0000
Message-ID: <20261122102940.785-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CACWAS-VFwoO58vbGsjyhsden1oJ2btoSHPcNnqbPWXuuGdU+5A@mail.gmail.com>
References: <CACWAS-VFwoO58vbGsjyhsden1oJ2btoSHPcNnqbPWXuuGdU+5A@mail.gmail.com>
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

Hi Fien,

Thank you, this is useful. Junio's question about the --no-* forms
in the v1 review was the reason I added PARSE_OPT_NONEG, but I did
not add any tests for it. I will run your tests against my branch
locally as well.

On Fri, 20 Nov 2026, Fien Dora wrote:
> Since the conversion is already under review, would these tests be
> useful as a separate preparatory patch, or would it be preferable
> to include them in the existing series?

Since the tests pass with both the original parser and v2, I think
adding them before the conversion would show that the conversion
does not change behavior. But I would like Junio and Karthik to
decide how they want it structured. I am still waiting for their
feedback on v2 before preparing v3, so I will follow what they
prefer.

If the tests are included in the series, I would like Fien to be
credited as the author of that patch, with her Signed-off-by.

Thanks,
Hussain
