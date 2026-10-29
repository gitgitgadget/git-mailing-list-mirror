Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289806;
	b=i2mKfCoLT7+hhUf6+zEs8lYLY61z1H/PulN9rX1p5qp779HfZ8ntx4oIBQ51XM2iYfva
	 ammhsXtZ+6Noy7Iyx4G7sD2xyPs/v2iWLKzqZvLTUGk0ngdcKFuYC+zBZd13PVMRQ4D1Z
	 fix0M1uB2XoyMJvHouh8IjmNEC2nVobXt9YLAyO3SSdM+9lJ1PZNetS39CvqRSCH/PS4Z
	 IBwrW6soGd99cI3hOTRWzp8hpS+Gzbws7CLFxsGkihk4ewrUTaNnmhEYCOzrG9v1DseCG
	 V8+z0NFrgrLg5dUZxU4RJ8kmKdL7lfOcI6jn1YenEBK9g8ZaLDYbzwbW2lsn7POz8Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Oom0mE31DJXU4/oXZqEenFZg2rlBMiSblP6aRlcMJQ4=;
	b=F8lodm1qA7A+xjJYQLTT5dBl4PiEIgiDZE8eOjmHX3+r/aTC5bO49uI8jO4VXs6DMO0G
	 87SanAJ83+64mAFOWR2bHhuulhB0jhKRBqoE/ZsTD6++mbNNzPBPT0/VRUIgbCGjpB7I2
	 cC8jCGcD8GWo1ga16rNPA0OfUn5/5lCc4NlVUXoCMKFoNW53FGspJ6Euy6aNo20HTPBMM
	 uVs8oouxVwA/xLk54jZ9isHaMhEVy/f5zqguaF7pcZ4v7iKx/ybUxFedaLf8IpYTiSA2I
	 EIHEYr8n3NJ+4hixkYCV3atIyJ3NCdhXpfaHoVAlh53aEm3AnCBxzrmX4Ij7Rm/LJIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ni2LRiEV;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1169606A31E
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1169606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ni2LRiEV
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214af2076so19634355e9.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793289804; x=1793894604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oom0mE31DJXU4/oXZqEenFZg2rlBMiSblP6aRlcMJQ4=;
        b=Ni2LRiEVEciu42yy5DNEJyNdeqczvZP9ItB5tQ0OMqr6xMXGppZhCpP6WSos4/55qK
         m9G2y8LqtYKatZmm8+NLqdP9gDabxTkrblEuW4e4BomV2eGGaAWZBrQcTPWw/LWWHLdt
         ZunSov2c0y1GW4DaSp2mi20914z1yNpwn06rC0JBTvo8C3XPly+wEfnZpnTqV5wEzHXJ
         iSXrxWtoaXU41nT3lRC9JtWDv4rgLuqHrbzSZ0TzNMWaKHas21nF9uHXxXjWI1jbuhlg
         FPJvMw9UFzGG7Md9rtLK3WHqWA1gGicoa5kIJ9l/ctc6pd1aXOKr9Ahz2I/9brbiyBg5
         tBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289804; x=1793894604;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oom0mE31DJXU4/oXZqEenFZg2rlBMiSblP6aRlcMJQ4=;
        b=gmwn3MmaWDEPfCZ64H9omqD+V+8MNmwbP73myfpwVxPr0R/56fLY59UGkg92CoMU0C
         WOWnahYh95gS6PPxU8GJoaWXCT6ekmEpY6f7cVZs+IJ5UMXo+rGtJoEKfmThmPfa6fRH
         Oi7+V3xEiKvPYPT2BJYVojlntrvAFGn00Oz469rhD/Rf7NTq7m0/lQa3Fd/G6K0BeKww
         1R7ElJxjwBs6jCzIkjHL4JOL1OZncQ611M2zoZswg1luRG5Ox3BG+X5m7cA4NEgAUpq+
         3rmDswnVc7MOO8HiOgjaTLWl3q0eveABfo8PmoQXOpUoyxOHedJkPyvw/IhhW6PGW4xi
         06yA==
X-Gm-Message-State: AFq9FYI/faESIgNNxqMOx+PcFdlrpHywLATxJX9p9I7eXzCFKWaFa0u0
	gjPpQ8ePsIvZjUIJzdavHl6Bd55BCTHnZulvLpXUDFiPHE474BBGrKtJ
X-Gm-Gg: AYBFou3noSsOqYTvaI+fhRM3XOAR/7EErPkDug4URSHP2IHWNU8yMSftt2GIRz6hJB9
	q2ksXpFeiQ3RyadI4U79oHWUJLOnr53IgiS7ZeTr/Gao21KQi64KuY1AeJnlUm68pgm9AqKmhDf
	ljn/H3l/8d5AqEkXTg7a46/+R2JiXokDOhRhW50kZJ5gr2Mxr2ER/7YSQuMARwOA1lf/VHlqe4v
	LqxlnaH2sjOk5z3eBRsCYA/QkYkEmLu07vCGAPbdWJcsHklNg5La+z57JBuc4YkhiCi1cgDxXrN
	ZjfgtT6Aaxm6b0XrnSt+Vq2DLwx8avZ9tkVreS7ciaVBMNRoYprmBl+o7nno0Tf1vUQs2pDVkFK
	qlvasbVI55i8jPvSMHUrYduwkAssdKRhLorXPtj3oRBI5iKHPnYMiu8lnia56B86A5n4n5pYmZA
	imNvpF8Sf4Jd+XLQvJ0q3+curHuQZxoRxdg0PzGXmZd728h0PEiu+oZkuHGRO0NTUtYh8HjnXOM
	ADvpxroCcgKUe39lrPKmue8N9MXuuR+BztPcBOLnxEAWQXjcd5N64sMniKVVRFwQiSE7ji/DjGV
	DnAacbhQrCkSscLbMLZsEFikcZE30Jdg8RLBXCspt1pwOCXpIcDR/0EUQakAsdLXzxkHxCxo4Mc
	nN2fGp/0=
X-Received: by 2002:a05:600c:6206:b0:4a2:59:f568 with SMTP id 5b1f17b1804b1-4a9661ab56dmr123971415e9.14.1793289804015;
        Thu, 29 Oct 2026 09:03:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a96a8f28a1sm86256355e9.4.2026.10.29.09.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:03:22 -0700 (PDT)
Message-ID: <4c2728ca-5511-4c30-a2ef-6c32fe7a3e9e@gmail.com>
Date: Thu, 29 Oct 2026 16:03:18 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same
 signal
To: ian4hu <hu2008yinxiang@163.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
 phillip.wood@dunelm.org.uk
References: <20261029141521.164544-1-hu2008yinxiang@163.com>
Content-Language: en-US
In-Reply-To: <20261029141521.164544-1-hu2008yinxiang@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2026 14:15, ian4hu wrote:
 >
> I left SIGPIPE out precisely to keep the "upstream of a pipe
> dies of SIGPIPE" behaviour that common-init.c restores.  The set I
> plan to block is SIGINT, SIGHUP, SIGTERM and SIGQUIT.  If you
> think SIGPIPE belongs in it too, I will add it.

I think we want to block all signals when we create a thread, so that 
all signals are handled by the main (initial) thread.

Everything else sounds good

Thanks

Phillip
> On the blocking pattern: agreed.  I will block once around the
> spawn loop and restore before the join loop, rather than around
> each pthread_create(), via a small guard pair
> 
>      struct signal_mask_guard guard;
> 
>      block_sigchain_signals(&guard);
>      for (i = 0; i < nr_threads; i++)
>          pthread_create(&t[i], NULL, fn, &data[i]);
>      restore_sigchain_signals(&guard);
> 
> plus a git_pthread_create() wrapper on top for the single-thread
> call sites.  The loops I have in mind are preload_index(),
> index-pack, pack-objects, grep, name-hash and the read-cache entry
> loader; the fsmonitor--daemon and simple-ipc threads I would leave
> alone for now, as they have their own lifecycle and signal
> handling.
> 
> On sigaction: agreed as well.  The handled signal is deferred by
> default, so the remaining hole is a handler being interrupted by
> one of the other common signals that share the same handler.  I
> will set sa_mask to sigfillset() and save/restore the whole
> struct sigaction, so pop() does not clobber the caller's
> sa_flags/sa_mask.
> 
> The one gap I cannot close is a thread created by library code
> rather than by us.  libcurl's threaded resolver is the case I am
> aware of, depending on how libcurl is built; I do not know of an
> in-tree instance, and I will mention it in the cover letter rather
> than claim it is covered.
> 
> So I will drop this patch and build the series along those lines.
> As you suggested, I will wait a few days for Peff and Junio to
> comment before spending much time on it; if nobody objects I will
> send the replacement as v2.
> 
> Thanks,
> ian4hu

