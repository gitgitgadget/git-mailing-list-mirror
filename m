Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478043;
	b=ybZMsxEBwOMWIsKc8TdDuH8c82wNBJbfvOPtHtzD/QxRJEmxNIl7kvEyazIoPaXK6VAa
	 FfR9zOZVTNu5zzK1c8U7ovWp9i+F5/gF3HVcLJVwIEhcnxlmsW04mqo55c2qk9Z+v6Wxd
	 RrYmz3eFrm9ghIz3O/gV3gM/2NsTE9MJUuyoMYaOsL7totAa7nwdW+tCSyiQfNVVOcA2A
	 Q7B87418+MGFlT9EYMfJNLYK17R2NnSHszcdTTOprk64MpWAfqIgcLDYgQ7D84nc6qbia
	 pA31LEW6LvKyk48TGD8z1U3/w1t5LRK8C4ypA3QdJDNlSC4TiEOg6hI1nfQaYB5i2zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xGLKAHanzPfOkPgQ+TY42ICyP3FOTABQKBW1sW1+RqM=;
	b=cczOOqO9hD3w7MnzrhxcDAIraLERdpvbhtB9a+Y4V9W2y3mV/xIT5ncYm0IIt0USY6Nu
	 e/UIdf+3v0xX2mWT8ojcS8jaXAAGrIsCZoRVRAdiKw4CLpgX67ZNQcsKOdm7i5b5fiWTS
	 W4uI7MJDkg1AgibsjcDcESC6LjvGO7KCd9v50eG6m9sMTW/yezsrSo0wLS6a0Hisq2Wze
	 E80xQmFAOzmqaK0RwBCp3d6Stsn5lbF04aLp+9D8GFGgfAAwkJe92cFzTrsAsx0wdrv0W
	 Q5Jb8Th1WaeEgyCuz6SK1beQQwGRGEt3TSxM8GFwQe2+l6HR33y6AFtKhSas2UZEJvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="J5hb/l8d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD635606A321
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD635606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J5hb/l8d
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e4edb98adso15019285a.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 23:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792478042; cv=none;
        d=google.com; s=arc-20260327;
        b=eJlhNxyiNVjwnHlLVvWbBZwK6iYAEgDfYUWvR2CaCDFECF0ZEKTxn5xCNMhsBsINmc
         6te9m/HqZtsiFQLeDltOKJge1wtyNWkL/409zLkRwIqV8hDAtkI7CzB3w4Xd91hqeCbE
         DEYvWoNK1Jc/ACvidO6ReYtT1cisRomfTbBYAfzByh0YeO9ucdbIQ8zL18/QJRKR975s
         vvrvqj3jhhXdxbgJnk+DI1RFxQX5l+y/xHS8Ash/bRoQ9WYS3irak35kwHRVkRlFYoL9
         uoNgL9OKwDvkSsR+FUxzldGaBWMtYsPeG4U3P3BqyMt4Fr0Z+xFcOHqg4MyquU/0zBA3
         RMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xGLKAHanzPfOkPgQ+TY42ICyP3FOTABQKBW1sW1+RqM=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=hRHhXYUMi4SKmuXbzMLFT2NWHLixpEc9QHWNCqbSO36hrxIV8PQ6WK6ADy65FKqQBt
         hl9zaVM+VHVB8Vp1NtRVP6ICBSMv0z0VaXrRwYvFYYy1d0mRhZglXAC3MJZyy99ojKAr
         lcvkKTAMwDzM9PbrQJJGi1Bx3JyDOfLUvcwWJxblOLUlSnzCrqSlWWBd5basRQjWrSZZ
         r//Cxxt/iFIlt7MZ7LCb6T/lDPKdoN47GjfZ7S5xBl6zwGmttPLyS4qQoQvahgdHImk3
         PvkJc9TrGCMqtlQcvyVgAXvHP0f1tink8NGfiLub3la3d+eExs0dbBAc4ZBnqGuDaJqt
         UJ1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478042; x=1793082842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xGLKAHanzPfOkPgQ+TY42ICyP3FOTABQKBW1sW1+RqM=;
        b=J5hb/l8dPAtc3aaL7zMBc4Ekqxva98uo7swA7cm9D3yU+nu/wsYCLw1odcFCZHsoU5
         XiiZOLRKVdkDSzeqWdPERYLEt29dvMhF0VvK2eNjwh9+OHML1+e0+F5FA/IZwxV9Fcoj
         +yn1I9KraCo0pAmETtvDo4qXeA7Rka4KLJxgOZwaqG0R7oszwHPV0sGj1VZQYktdimyL
         aJZI4lezedsbSwlAdx7I3aea1pHHSBmwz09ashoJZnzV/iJm4jhBONwl8fnn0jMOZMNc
         ARHA2d9+eIyf5zf7eI5P2kZxA2tqHQJUeEnev9451xm1p8mP+uDa/jCJo1qxufren90q
         kDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478042; x=1793082842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGLKAHanzPfOkPgQ+TY42ICyP3FOTABQKBW1sW1+RqM=;
        b=hv/lGSUWDjjH+fXckrXeLObJXlPulKcLdbRtg80G3rtDSooJXypf7Pq+65NGWXS3aP
         +ns1DMDZDXkKDIct1xeB0n1qGZXjX8li+8ho0XfAYtGpRFYgOanHxvHPcX5xQCJQZxel
         X/Ui6qQdgFjKgZODiSKV9Xj1gPHuuvx0g645N11zMxS9lXN93RinQshTF+ec/EwaQwgV
         KOkMakTQxlq9V29z3Q41dJ9px/pnQ3otKmfuOtClftHdvMHLvgOROhX9SRhz/9GNpGs/
         qgwocWCBmPhlq9FU6hHaH/ktcqK9q0Uiij7W3g/IjSfAbwiVmiTQclEjT2WavjqEJBBW
         LLuQ==
X-Gm-Message-State: AFq9FYI0EALswWW9y4wyO2VfOigV6R0sgvSWuZI4CYRGRb4j7GG2bPc8
	g6QSLZ8gTiO3pXQ5axHwtjAjUO9bDSPfgkvMPz1RBKUTjFGXoF3RyafD5qUcgLqtupOGSgqYP/7
	D+CMjGXJi72rb2kmyLlwJWTm7JCVk3eo=
X-Gm-Gg: AYBFou3zjOm8TDbFTGG/EAJ+nWr3Dxr7f2KTWEPikmh0tR6yvZ7f2rHDtvbl0ClrVqa
	12g1PmPI1blMkRa96x6JUe8ZRjqpI6CVqckpJG/CqBcRxsKZPscE29lZRNnCOqvIYxbY4XL91bT
	lV+WeEL4IPM6dIO4EVIQxCXLzd/ln/D6LB34uaFgXkVWFdxk6ZdP9WRnTu+nW4UDy53rl1po/PJ
	jF3UEz1T2VoBMCnW7tqIJgHNT8HkE9OVpD5V0S4u5ByufDOgyOjyVgwHWoWRmqXOhGjWoleIPaW
	CMKX5Mf2CYsSk8JAas8xPAEJXDV4jZzvoCGeqAO23nC3LFbcwZjzMQ==
X-Received: by 2002:a05:620a:2704:b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-93f29ba28admr1916965885a.1.1792478041760; Mon, 19 Oct 2026
 23:34:01 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
 <xmqq8q3typsg.fsf@gitster.g>
In-Reply-To: <xmqq8q3typsg.fsf@gitster.g>
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Tue, 20 Oct 2026 15:33:51 +0900
X-Gm-Features: AclHuK93W6GNsIBuGc0OawEx_lSwHO4RTStRdVilJIDwfvOKSdpy-qSV8revLEA
Message-ID: <CAP8tz2JNxfOZC1W4gvGSJ-=AzY7iBADj_KtzWb4sawyqjQ0hHw@mail.gmail.com>
Subject: Re: switch/checkout stops halfway when it fails to write tracking config
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the reply.

I agree with your point. However, implementing full atomicity now would
be a large change, for two reasons:

- push -u, clone and fetch continue even when writing the tracking config
  fails, but setup_tracking() calls exit() and aborts the process.
- For full atomicity, we would need to undo the worktree, the ref and the
  config. We would also need to handle the die() calls in checkout.

So I propose to make setup_tracking() return an error instead of calling
exit(), so that switch and checkout can behave like the other callers,
and to leave full atomicity as a separate topic.

2026=E5=B9=B410=E6=9C=8820=E6=97=A5(=E7=81=AB) 13:11 Junio C Hamano <gitste=
r@pobox.com>:
>
> =E4=BA=95=E4=B8=8A=E5=8F=B8 <inoue.tsukasa.4@gmail.com> writes:
>
> > 7. Next steps
> > I would like to work on a fix. Should checkout finish the switch and on=
ly
> > report the tracking error, or should it fail before touching the worktr=
ee?
>
> Either would be an improvement over the reported behaviour, but if
> we can make it atomic "all-or-none" matter, that would be more
> preferrable than switching without setting up the tracking.
