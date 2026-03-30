Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041D2FE566
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873916; cv=none; b=LBzZL/BNVsTQvvBKrHheUQ6TNiPS6F4xCC6LKlG4WsWsHyTHK2l1sZjwI3GXOhvhvqsrBjb2LkcEg8aPn0OHEbRyoLqwWxg40RtROHobb0zzW8/Kgf5eYrg2BQ3ePQ+G9Vft9w6BdIE9K6XSfJ5JwL/zTOIw+LSMJ+iThv+1dWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873916; c=relaxed/simple;
	bh=/8eTcoocGO+C8USiiqOk3/n/gipk8ycZRk4RoikX+FE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHLpzlMV386WmZ8TR1rAVlVSZxZ0yAPlQ8V4jFyJuIb1WC52Y+xNv6lKDqklsi6rFv32/zeZNyu5nZjxeEhv/hHKjVAG222X/TYr6ZS2QfS0BukimBE9DVAEWKAN9XV+WowadOzeg69IdcEcdMAdKXf/hL5K7O9+SxpLk/3Vo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI6vGgw6; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI6vGgw6"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-650158138d9so1959536d50.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774873914; x=1775478714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8eTcoocGO+C8USiiqOk3/n/gipk8ycZRk4RoikX+FE=;
        b=iI6vGgw6fuW7PM2gOp8Bxz8WYurNKpb8Fuj4j/thi7FotIgeDrwXSXeGm1SV+z3mCh
         4F3pVJnMJlI3t6fCI0Rv0reWkmo2p3RrOIqIF9aKRwG42MdYBw3VeLNOvh/3k8ZByogE
         4Ln/5eYYb5wm13xB8qvHXsxAsUdgq/dyplZ+mTBaurYo0Vy6aIWqtlIk8nLe5JkyYQ5k
         YLrz0DoOV7iB+KyGBNQOLrwQY/ES0uahqKd4NtWzWyWkx8BXi9SMC4r6obNIELvi9I/N
         k4A4xSgjCIBi7aT/Rjkisef99vnQWR/DnMPj034l2vWbIszxTX4e+RqmKgUC2CN5EDNH
         SSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873914; x=1775478714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/8eTcoocGO+C8USiiqOk3/n/gipk8ycZRk4RoikX+FE=;
        b=af6zUZrJV8kJ9ZqS1sWNsj49993j+2lSFaEoPsHT5kQlyqSbIeaJMtVENSvevxM8nu
         ra7RKtGT6SB8LDmEKX0RO6fPvPTrySVvfQ078g+Kn2sVtUlcBFa/WGWciR5Obsa2yYuy
         zOzs9DJaXyhBmAWbPlqtWj3MLDJTsDTPFuh/hQ1prxBC1w8EZznUh0EMRuJFn10KOdNz
         K9qt0qrG+tc2grGFtl7a5K6VTLDqePwdF6Oo5I99hjxiXhiOTOT9SX+huV44Wnz15ESe
         Tl3hXCxKYfP6toNy/SxnC8qT9LX72KfQCoqspjixnUsMngAMy40eb0LuNJi8wSi2so6e
         Uo8A==
X-Gm-Message-State: AOJu0YyLRzoYxFHeCuN+M/tLwJrlii1aYIeDM9Q1Y4cnl99T6QDQnkxx
	/Sd3dtBnm4z96dqcvTTouPS5OBHxIdzT/3an3biDUbSSKY2XZ0O4s8AdDoShPh2IehOuUA==
X-Gm-Gg: ATEYQzxsK2AdgVJy72bfXZDVfx8rWvCuU8mL+RYdPIzOUtQDHIixGwsnUF6JloKHwm4
	jMWcadR5F8ira2fbJPc9er2tUhgSKx6hk0/e+ip98Pv86Yn+IQS6cOlN8aJ8Zm/ed7mdszs+LY6
	EqbLZkTDVPMo6KEIyZAI+yjoMz7Eq1SVDKqDfooRMA+8XGjpAXzgGS3x0m+vprwSEeV2PG2bXiU
	Dv0crVmmCbCdX4FP7o+Rcec4Pp4256KSdOQhGGRPSoqT2Vf/w9rT5qrl9moc1NvBTMoAxwF5fUj
	3tUTAp5nil+Yzh8bawnS5pQ+Avaegujpg6z90fNOvpfHxxCPpYScsP1IaNcwdW2kytXtyvt3Umb
	j42+85nerYqjek5RGQPJCBU7us4/1xEGiKoqlQNs2+Sc0VuOPvJyXisGj/N+KDFd9lzyC0e26Ai
	56Rl4tOsxnx2BfYzx0mDoR1NonqFm2c4Zv4hQEA6Kuf/69os7EOzAk2Ji47X50jRfSRzHL2IPlV
	tT+csFYjtmHiJEUD9G6lsrw/9FPQQ==
X-Received: by 2002:a05:690c:84:b0:79a:b824:ccb0 with SMTP id 00721157ae682-79bde0f57e3mr110255377b3.46.1774873910205;
        Mon, 30 Mar 2026 05:31:50 -0700 (PDT)
Received: from alibaba.. ([98.97.79.160])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7135bd2sm34198867b3.2.2026.03.30.05.31.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:31:49 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org
Subject: Re: [GSoC][PATCH v3] t2000: modernise overall structure
Date: Mon, 30 Mar 2026 13:31:29 +0100
Message-ID: <20260330123130.40959-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327234019.95591-1-zakariyahali100@gmail.com>
References: <20260327234019.95591-1-zakariyahali100@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

Just a gentle reminder on this v3 patch. I would be looking forward for your review.

Thanks,
Zakariyah
