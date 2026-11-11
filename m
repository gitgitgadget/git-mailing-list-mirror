Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794385723;
	b=P0DKGb0wr1Lpetfe/eMqe/v88ENO90ocpTDgeAwsBtVqRRNQ3YB+EH3BLbJ0hoDUK9eN
	 iFhXntVMQ69Wu2V/+Qt7fUN7iS1Z4F9TWPQI9OUWTKAeKSrtOc6FS/JAMxDS+iMjekESG
	 nl1dMoXJEQn1IBvtvtmyt5Qm0aeHmNo+6x1Yn8Dw8x772S1VWsLxJPdP8sDhNNssL/o24
	 lZ3pwEybktDaxvmJJ83kMvyLC9u7kY/iokf1XgetWK7pUIj1YXV87W98AMrZHeRwBqF77
	 D9s2eMa7P/6hxyZJnBamgXFooZ64eNoU3EQxTTxek1s8oQpgyBLU8YEai4Mwfs2sLhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/levvzvr/oMQuaAct7+PopiHfkT6/UW7otKjGq5AlHw=;
	b=v02/oSOJh9p9iYKVeETEfXRcbWOuSi+aRmFyMUjbNaB1BfoC5hew36FoPqYicYPtOOHJ
	 8zW07b/6AzCrIrInyoO/xI/lr8ExaH3ng3b9+/nSZutSK1Uw+zBtqj8d2j/VdltmRDPhx
	 5N+oJdbp8dK9bLcn3s2ttLAqSNIUg4WQoUzUNKV49JoQJ1KVC/OlEDgWafJI1FD/uMTUd
	 89wcHMJQ9kW9PfPgilt8I9yT7WbAxi7LlsHNVKxF75PYI9m5p+UwN9lvLHvp52887yD9Y
	 CHHz181rIFTT+mW49eTJN80fCFNFdTkOTtqENlEkJ8YZafR5dvTrlNgVN626CGmTPPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=taSzCMCD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E7606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C9E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=taSzCMCD
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c247f6687dcso480723166b.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 00:28:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794385722; cv=none;
        d=google.com; s=arc-20260327;
        b=luRTb+YWc99vJr5dj5NTsGTl70a62nY8G90d8tgdCcbDRz6BPDu7jBXt0gNPbJuFg3
         C96aF0RYd0tD6WFYYDYk0eP+7ZwOAitMKKN0PX6quMWmNwM1X8A+OaL0SPwyNxVpZGrc
         b/azRhQsYARksOq1WW69yphaBk69TLooJndQXFnNubuY2iIkdOrkKovUxHo/wUU3uBGj
         E1E6MMcnOvS1a67mbZ5YZp6TfWtp0JCJRzFmompImNEQQfCWdQ3BmE9RRtctJgvPK4It
         /8rkliNpb8OoMFib+u3jog1Rkb3GA6hTn7KJGuiRVgDnNGPSGzGxumdOwSe5CYnXBz6Y
         h9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/levvzvr/oMQuaAct7+PopiHfkT6/UW7otKjGq5AlHw=;
        fh=4taht92dzazhQDOjq8CsAaKR4Bsqe7vCuOP5jjEO90Y=;
        b=OsBeD/h73QEhAfjdxthRNYpC4U1JDdNgM+48Lg0bpKZ72TGDy6HhgXOo4TtGzYvpHf
         YWBts8CKFREoEC6GuG9F78MCPg4u0RH73upGRebzMBEARGSv+8KB7vo8zQMAuP7nDv6y
         SZsnvKMkkAY8ZephPY8B4DGJXAg2Si+M39AeGu51in/BMVCFz2HrjGlyL2QvoYUrTAgK
         t/3k+YrVY/XYSNToWMpZ/ZRgMQiAWci+okBEvMrqzm4vP8p4uOvf915XZYvbmfDMvFUY
         iF9OnXYizn/jfBsXpvYvTmfSqfP+Sthbk+iBTxFBQi5w0iHH711WXO7PnO74Hwe/3uSe
         JPbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794385722; x=1794990522; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/levvzvr/oMQuaAct7+PopiHfkT6/UW7otKjGq5AlHw=;
        b=taSzCMCDGpwxmjbxxA6nRbeP+UOXo5EVo6BNB021TTL/uiFpEWExUawtFeAo3nVes7
         s2qxwmXKiGOhnv3neJ2+CMcNghbOedYXAH8VOmGey2ViWO9pgH3Sg9apH9l1GNXwPHJD
         BkJ3KDxEsv9LtrqOi7cdphp5wogqz1+8NHTrOaJ2lmvvkLwSCnteisyppFoThtTdCSAu
         HoVyV2QDPn9luN2HDr3VxEDHxvEseFRj6hJ4f/yQtzr51voC/+HRTIoSEMLw8alwmkLL
         OiHYn36MjdckRoKy4EwKXkdCloSbell2hcdbQZciYn7cjzlFWISZdIHM9Fj/V2t8JD8B
         C0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385722; x=1794990522;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/levvzvr/oMQuaAct7+PopiHfkT6/UW7otKjGq5AlHw=;
        b=XhF+NzmMshAy0h4MSqiLpDK4R6/xbO9mymb2TI+FFnMtXc1J0e13IZLpQN/iDIBD+G
         I/IfPIbcQZpUwvLaC3tWP2hLDNoYbBwFdTn4eFnFSemPjtVO0FN7W4KqXkf6YO/xh3LQ
         cBzU83naojPBl9JCCKPo9C20uxZSXU/YkPrn9q1LZnXarMNbURXw7uYhTL8el6NUiSRx
         x+bkIrWRuA/igqzbZoMr3NTZg5/8wY+/C09B5Vk2qfUALpkiinomthG8Xv3r8PE1ArlO
         SmHNB1IBBF8qg3TGTf3WuHbDsdI+cTi8muksrD6Tb/OPeL02zlRUlAn1IZROT++EQhZ2
         KPWg==
X-Gm-Message-State: APuU4Z9kJtbOElOD7wzv/VmgLgMJUw2blMxbw7d+da+j1PuOfvO9SzQd
	3ukcIqeEixQtDhNOzyrvBiD7r2al09eth5j49dp4yNRRsm8+7WNwa4zzVjl65IQmMf5ttduEcxc
	ilL3QLev1MvMteBdJycAGJQNuqe3+bZA=
X-Gm-Gg: AYBFou3tW5nbdfpJMv8ewIoGFdPBPDAMhXScyOPGPdoFp4lsVmJg2fw9ndWvgCoE/2j
	1N/T+9lLVdl4Ppp8zTR8s0xkm6esQhA/m7OyLuJEjFRjIzvw3TJ3oeuJKKZ8vU0tZHnkGqYrkO0
	GplVPjlrbt0x0XarVgRIShF3Suq8WY/65FSDRI/Hz//qbY+DaBioCRvKNYn1QY+Gua+evPCuOqB
	fTKTbltQ8TpmBFjpAJaNELYzbpH8ETxJ7MQGSR0FUgzTQHluX3UflcVwW21H9fgXVOCIh3m6GgE
	5ylafvAIKUTkTUAdrMQg1xlzkm3qBjZ7M+CWFAqALu0u78Qt4fXxjw7jD1w2ewBStS+TW9Akrsj
	0yo7Ndylb1nH18+o3ws7CH9o3l/QPBYuiEEOG
X-Received: by 2002:a17:907:2d07:b0:c1f:983f:d8a with SMTP id
 a640c23a62f3a-c5066afe5a8mr114908266b.24.1794385721595; Wed, 11 Nov 2026
 00:28:41 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2455.git.git.1792275106640.gitgitgadget@gmail.com> <pull.2455.v2.git.git.1792503631364.gitgitgadget@gmail.com>
In-Reply-To: <pull.2455.v2.git.git.1792503631364.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 11 Nov 2026 09:28:03 +0100
X-Gm-Features: AclHuK8l1k0RdIZBp90vZU1kDm-NfrGSReg9oKovU5rvYwR32OnEc5481PhJ5TQ
Message-ID: <CAHwyqnWZMb4DYf5yxS3CxiRs0ZnZwy-z8-k9JmxGgV5edtmh9g@mail.gmail.com>
Subject: Re: [PATCH v2] upload-pack: fix slow fetches from a shallow repository
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Junio!

Would you have time to take another look here?


Harald
