Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024442;
	b=lQuy/gHy7jPRnhDswIDCIm+OOhty1oPRMpuK0ya+QIJI9SL7wDi9HW7B+RG5o3sLmjS+
	 n7gjuttHKSaw//l7+RaPQ5NkBOLToG9ns/gbDqShv+pikiL4lO1smzzkcfceqreX+TaF+
	 GJkwhRtDwdC6+ImFVZ7mgxZcNyFwT/u+Mqko6wNXN1Gr+cS73Xgl23b+xhGp6q515ulA+
	 Yv75pQiBn9Hbj7zjFO0Q8K3cs0k102v5SaNFVaXIQ4kCbsXBUuv6qe/f6eDZrJDZmMzK/
	 75BIMBsn6on2GjuV9HljyBWeL6bOr5+h+VrOpRpeVJrzUPB68XVITYE2j7OtJs9eJJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KpFWJwhucE0VXl7MFWYKqgog6T8/me/fMaiCcDoCsAo=;
	b=gqWi0eoZTkzizn1d0hKl5qDJNNDGr4TM25a4Z9eSw1V1dmldvn8/538k8U5YozsdjIdQ
	 QiUfL9LOLvx7hZ5w9EbK8hgdQDTi5Oc0IzSTx2BURwnovI8iTWzajCqDpsod1Jw/3EYVb
	 bEwk0IXQOOpagr5DA36BNkU8sgh3f8cRyGCx5PijK5xEuqSj6hu4ux+BJUkglHkUnVmHV
	 FcA496NW4qijuElRF6HbVhgFNj3K6JiNpx+YEdZgP6yS+pdEmt7Y8mwAulo5/5L2SEiOs
	 +qMwlGacIDq+wYXZCJ9La95SZbm7CBzMLETgACHZc2MugDRVnNlf59Us3zQ23iZ1W/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zu8LVTd1;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF083606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 04:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF083606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zu8LVTd1
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36f8cdd30beso2135259eec.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794024441; x=1794629241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpFWJwhucE0VXl7MFWYKqgog6T8/me/fMaiCcDoCsAo=;
        b=zu8LVTd1tiUqv2baI373zYn5H9ZhVIn1kj3xPVUTrk7JZwvdY/wSDntHh4ZH++A5uA
         thJ8uOu1kR+3piU7ZNTbmh1zTvANi+50mLnfuLZJu6yGj5unVWvKxsOuPuFngqKSk9sP
         CmoB1e83fCx8tTtRWuenyiFbE5vEdKjXvWCWdm59NgoKjtTh1MjMiih07ByNkkbh5OsW
         ArV0KXdieIiMj2SviFzXxn/DPmmGMlAuImIdcuQnXDgtVLVOug3iwqGxjNpaoUGaAeGa
         KWinV9b96edwW+3qfpgwEDRata9K1QaOPMSL649qNYnbMtw8ogGiLKcfnCXj1+Zjw5dA
         d/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794024441; x=1794629241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KpFWJwhucE0VXl7MFWYKqgog6T8/me/fMaiCcDoCsAo=;
        b=V2/EiolGMGkRA7lOj8V5UHNWvforD6m99REfSe5/UBDdMw8Cia2vZVuvGSLZSJ/rmC
         bjIWxrC3Fhu/BSItiJd0+kjKzEGjxZlXxPHvg1QT+xrJWWvXtQzROrg4RpN6D+/rhK8m
         nX3AnwDxnRFZAQHzBn8IpMqyxkHO+sn4OlgDtEinboVEM+l4z0czGbgLAjHZLj4DddKY
         HrE26F30WbpFK96mYBI3ZCcjETC50AtrfRnPSbMmlh3dH+bDI1G51sknfeXBSlB6m/OH
         lYreZ9VAp32ygsA/RcLo0jerNkA7G5wo5CzMuImd0OenGwgDJrA9Pk7Ko7ZFGtUawJvF
         RYXQ==
X-Forwarded-Encrypted: i=1; AL+hErEoC2ypmqqkpZ2p3pIbAU+4rRGvn27nMuDNo0YobZFThEnCJOBsguRN9VCeyzz13oOo8+4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P0VqZ5kR/AAMBRuifbbAJk65d323jzd3eSqs0/AMoCxeA3sQK
	9AL14kE6q/meNeWGobvU+LRQ2cgAU4xFgmHJa2hqOwhCrBVQxBxBk+2L
X-Gm-Gg: AYBFou2Fjc3YaLZI7Gukw3cAYXCFmZaw18RbRz/wY4ITMCPvWIMgyB2Sa0cCY6AaHIf
	KbarufpLYXS0Ok4EHbZKkAkvgKBr53Ed00vSLW7BgTJqfUYaRozvAlPJsCdBGTDxyBv97EpKbEL
	XiaIPVq/B/mvS5obdfxnMJNakpuwAHU3ScX2nAsg/XPy3ISjZ5nS8wRU99sAROB/jZdICApgnS9
	fezUjvFGVXBiePRz/8RgByLgASJZMUCFf5oTdJuaA+gVZCpEmrxBImRXr0Vkwd1urlXpSv0M0t7
	wCHbJDmi/CtuL/OcYFwtsIdntQ1KuIFV/h4Ur7GpekP2rC4EvOswMc1tkoO/tYJbspKmqVNRxAh
	kvL96XLg/8rnIncbPp18fB4ZOdYqk/gbebBtKuKtEJlT7VbILO0EhIkNAKzUvSCcwisRrBw2iZe
	BcEmPrSwVjIROXWTnWZ50Ud9wwGQAVXkSsuiqqSA42x5ZzrRRK+tgrasMbaJM38ucn5PR2Q/GQJ
	RSWPGmjESVL8BzibYx/yV3Tp0+wBO4T/qPaOubdtx0reVIJN6/Gj/x6fHNgHOSJZXdkJUvCai7f
	TQLRtwhkSZeku6DtfGwaR+zz5nCZbvpvECzMTcDNv6OdcQS6U50j7yQ+Ioo5R7AJcjfZnQ5at+U
	=
X-Received: by 2002:a05:693c:8855:b0:36e:f173:a4b7 with SMTP id 5a478bee46e88-36f7398dcf2mr6412133eec.4.1794024440644;
        Fri, 06 Nov 2026 20:07:20 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa5afffasm13380643eec.25.2026.11.06.20.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 20:07:20 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?q?Hannes=20Brandst=C3=A4tter-M=C3=BCller?= <hannes.mueller@gmail.com>,
	git@vger.kernel.org
Subject: Re: [BUG] git apply: pure rename followed by edit fails with core.fileMode=false
Date: Sat,  7 Nov 2026 04:07:15 +0000
Message-ID: <20261107040715.436-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <xmqqwlqpg0js.fsf@gitster.g>
References: <xmqqwlqpg0js.fsf@gitster.g>
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

Hi Junio,

The series in Hannes's report is valid input which is what format-patch
makes for a commit that renames a file followed by one which edits it.
My symlink example was hand made and not valid. I only wanted to
demonstrate that the type check no longer fires. This is a minor point.

I also tried undoing the series with -R (the edit first, then the
rename) for a plain and an exe file. It works the same with and without
the change.

Thanks,
Aniket
