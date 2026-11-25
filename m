Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795619614;
	b=J5z2doWX8tj4g+tVdtHb/VN14lIW7u9XsYcj2gXHtLH9qdC1XyI3qGaWYnLf26XHkWox
	 5Q0slK9dgOAQ1zexCHj7v7+10ZlggV4TrUXy6bhCjMfWoKTABXST/UaPfSflxB//TDV1j
	 3urxSPo3Zr38VLOVvH2YqgEcEP/hyf4cyhubiIygHG3DqkotN2NIHtp/z1+lRCTuVabcP
	 zP0w+tXbnh2sOmrjW9wEFcgRNtHs3TBLdsr6GY3fm6p+OdWF5W+24z02sMT1Bh+R/nLnO
	 s+99LYNfvj+mQfJJOyxHEsVq0bCwgX9gpPkzjcNAf4fg91y9rIKjHxaoF3Yh6exVawg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:In-Reply-To:References:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=E8fYilJcGMrZ/G9XmqgEPl1QJl3yMEBNvxeKNRhC7qQ=;
	b=Rj7wqXs7Qnubovq4CcuLdq/VblvBBHS5nADx4PPoCB5DA9wNVr7yIAN4/4zzfquwahdD
	 cMd7CJY/fb4A7MI1HmtzrOFy6JC8aOdH8LX5n0lsbTHFSi2KZPresXc2BbMDq/61mPDsp
	 D1d0mbUlvUN9RliqvPXwuorVV17ngFBSaebVhkB/9s/Xw1eICiWQZba272KcdJkbFyUN9
	 dsnZDwI+ilBRDN64MGVX+/Izoi6udbi41wg+viwmsuUukLTYDQ0vL34fNSt7ftvB9DeeS
	 TrojPWFnNW6n9C3GMYMXjV/RmTSq/d9yzZg68uHKNaZZp6DMbWSiiC86eAO6cvBvQ9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VpF+0CH8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70321606A332
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70321606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VpF+0CH8
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so52719a12.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 07:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619613; cv=none;
        d=google.com; s=arc-20260327;
        b=g8SKiw56ZXv0/l9n2lAG8LGNgUzIecw4LHWjJ0vYXCLg5tR2XbfHi7GHjGgvkj9XsX
         N9XIQ8o+rDk9G9HRw75k4xJ/IyTraZOaPZ1dqk79JFlGkl27ctBnKM4qr5ppIa5HChGq
         /WfSCcQ2Hrhd+71qFMsIRbRw8pdLD0LDOmG3uy1e8cNgPVD+fzyBdvkhxZKLe69Vl+4U
         qbXbfzaCj9pgnNwCs9SOfcO7m6+NwD+SNGaGonDP4ghH1FuaOyuh5IOWTdskucsrEVTS
         212hCzxSE8zdFed63LkWJe1JrM8TL0DMnZKSJlVx6V92j4oqPV9m3ZrzeuqTadVvMtFL
         7l7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=E8fYilJcGMrZ/G9XmqgEPl1QJl3yMEBNvxeKNRhC7qQ=;
        fh=YkC1o8BhKLEX/2gF2JnmcaCV6Pt0EAOAIz81VezVYjw=;
        b=EZqh8iiyFYuK/zj+O9gR4M3T4UCRrEKSpw+jkC5wP+MNWLccZW7J48XG2CuKcvFiui
         iNDZ7lUgnkRP8+c/EpZZuyTq5002+oll5xXMgfX9HHxKf0wUcphs7f4fopPIQURrvviR
         kwgfR0l/pYJ4wPd40wyLpA9jR8ZzXv599G9xABvvizCccpGIiT4+tvY3qJTCEWq4X+pE
         rmyUfgIztenVyECzV2YH6/ZKHz2DQBJF5iZ6QbNyqntBWhbiNAdgUKiecXsN+kdFOnfM
         uinRVaI0URycCIH8fYMklxNczDwyK6DWCpx8aT7VPyYrH7H1AYXTisNLhzDDKTCbgwwH
         zsVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795619613; x=1796224413; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8fYilJcGMrZ/G9XmqgEPl1QJl3yMEBNvxeKNRhC7qQ=;
        b=VpF+0CH8kDXFUWLP420ii2DcVpgKhqb5k9/zLV6SChRV8go/oHXz9Ad6UKcR/rcZtR
         H4OYS1mAdHpoHIvqVGPoBp8YmJ9rEOGJlF6CKT6H/qw0rruR3x+eGWtTq07r63Ksvx8O
         QCQBxnJt9FHwB4SiwsUb5n2WSJK/4VbBR3B7eFb+/wHDpsmGjQHp14HR1NyJJ6JMIakG
         XxDUYcHV8x5cJseOcfF25f66M5kt2SBpempLEupMtUkWwb/oA3sW+HIXdT6E7udtuUhP
         FATJ/fH5wBkitqzxcVjvGcr+GmoWON3lbdLtLxp2HsCr1rnrxEndediH88Vp1zwjkPmC
         Z8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619613; x=1796224413;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E8fYilJcGMrZ/G9XmqgEPl1QJl3yMEBNvxeKNRhC7qQ=;
        b=REdE8QH323RYdX8ZAPwFgD8ARlc/7AdgWSzwCxQ/tl+ZXP3bpJXfJV+kGbsCbhCFhH
         lLB7gcncTkp3K5LOEueOON1Z09x6d51DFOjJ/ZrxXbQ77hwaMBR4qE7wM3JFTRzwIt7K
         DpwzbeQUWrGPMNt8ZwKgeRdKR8v4elZ0UT88e90anOAnMk+msmJlTqG9XJK480Y+RSvP
         7gWh7FEYhXuv9webTdSMgC9d1p1cu/YTspzPFOCyPQK+BffFaNJ9B4uIFbpJMAbfuBIT
         OelKKMxuWJBPc0t5JV74ZB/oUQJ0Tst3qq+d7hzOP1QD00t+rJV37Uvt3/O3qocrspEr
         KpLg==
X-Gm-Message-State: APuU4Z8zjvkLnSYHuLFR4pwDELhshlwiLtsYcQ2ndeMerKZE5+P1Xz4o
	UenDl32WGOMQlCuVLjzuTYo5DknN7VbbToyH1dVgPuWwdiMue9M+BeOMQKN1xO92cjIXLDtZtax
	fR9ArBO19ZWBvfCa2pcY2fNxVOQ0Rps6OTZFraOwnS9Viieq64nqz6w==
X-Gm-Gg: AZFdTZf31+SO2MwP2ySboKT6ee0qcyDAX2aV0lz52gDoWyAQpYK9+jxNUOhvAlYisCA
	EYSFwqgnjJkRUSAOYtu8/cBqzlMIUwp3XVeBoyYi2LzAJPMgvCJaBpHEZqMBFyBTR2vKCM3AH4A
	deQYRfdteemR8PIyXgXWOLKwS9A0lLHaVxqhCwgoN2cJGI3GAU6gx/4rx08D/Anrt1GfxaXnfuT
	kBwF8W1ASX8kVlpd+1LwyRoIGB6ffRXrxCdJwv3mIIvOH1pyrt1BNd7dsdgCMv+oSlZzgsh/F2R
	u+nRI9AxWl3FjXuYVgJMz1BzHgCxfy4m5Ow+PzJeivHb7needOhGguT944CXj1lzdcCHvGNM19A
	DLk6zGTkBeHxiefSAOecux3mHApMgD6+BsSM8s+SxQ2C7lOVOLiV5I/ZQeizlEkUxUNG8zg1abI
	gWwL9UgKKSXA==
X-Received: by 2002:a05:6402:a545:10b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6ba6ed88c52mr190385a12.10.1795619612078; Wed, 25 Nov 2026
 07:13:32 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 07:13:31 -0800
In-Reply-To: <xmqq4id5kf19.fsf@gitster.g>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v4.git.1795103883.gitgitgadget@gmail.com> <ca247f390c8ecd2df20f7054f3357bf8da86bee2.1795103883.git.gitgitgadget@gmail.com>
 <xmqq4id5kf19.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Wed, 25 Nov 2026 07:13:31 -0800
X-Gm-Features: Aa3M54qsjXXOOQcpUEy-o85LII0qzxLSq4FvmHzaYnrFtZJq6OyPPQcNtjaUUag
Message-ID: <CAF+mdicWKt5WWAJufz68wOH9vsvM83HfTz0XdHfJF8vZBM+dhQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] remote-curl: retry transient HTTP errors in post_rpc()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> The variable result is initialized at the beginning of the function just
> once, but is not reset before we retry.  Would it cause issues if
> run_one_slot() returns early due to start_active_slot() failing (which I
> presume would not cause finish_active_slot() to be called on it to
> update slot's results)?  Just wondering if we need to somehow clear to
> give a fresh results object to run_one_slot() here.

Oh, good point. When start_active_slot() fails, run_one_slot() returns
HTTP_START_FAILED without calling finish_active_slot(), so results
still holds the http_code and curl_result of the previous attempt.

It does not change what we do next, since HTTP_START_FAILED is never
retried, but report_rpc_error() would print those stale values.

I will clear results before each run_one_slot() call in post_rpc() and
probe_rpc() in v5.

Thanks!
