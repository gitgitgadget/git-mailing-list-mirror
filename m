Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794174328;
	b=tFZWQtoFHim6yx0PUvf+wbs3PZiFqTuCTMQfmn1y4xxKL2Fci4pBhNdZQxrKUh8wYM83
	 T/ZoJMzJha4uamuT9FkaiqKcmIvze4vmyFBVfY5CukPY8Yo78HbImt/tQf9OI58Mcvfd5
	 f1EXOgFNc93nmpe2QZvmvEOYOd1x9YzFBZStfGV6o8z4DCqrlccRW5mkU9AAv4KLEX+Ol
	 VY/DwJqFEokGmTmrPQEcqnUd60WPpbojwHVmgek9T3wRDhzxhFG6RIBlzJ44k6zkfysdt
	 I+cjHrISF3btcwv3RyI76O6e8VS+dm2Yn7jhpBzX8EkcYozHBMXvkjEs07NYhRbFDvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/tB4aJkN44ffppZbx8RR2I0Gji5t0eQCpo3CtQaX/24=;
	b=kvQI7Xf50ju5p1hJNuaPwqQMGozBbN/VSCywroS9dijit0wgjvBbma014/d1f3d1sKii
	 5Mi7yeMBx8bkDHajg1ajucnDoFO1QtfT3Qr9cchsRcoGAj37IKU6QdIHg/s4VcSSWN+Aw
	 xm1iXv1h2g65tyu2TsPwprLS8XR3aXJNrHjvDZQLiZsGYJ6VilQkSX4/TBmlbzHkL1rYw
	 L1pPUWD3gPmBqjrBfHuXXZA17d0r2BgFghdd0AUj07kg1/zwPhJbB8O8f6BOEz4UP7Dni
	 cI96oubzkAzZ9qdHkneE8PeBT3d9Z8Z57jbPM9yUxWZE+ZZEAcDQhsdg6DFC6CsKhbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHrCcUw6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4A606D81F
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 21:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42F4A606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHrCcUw6
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0d63f60bcso3718307b3.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 13:45:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794174327; cv=none;
        d=google.com; s=arc-20260327;
        b=NweJhoN9fwRF6qhK85rqRosGOVlvaNbmNV4uw4iVnTmM22JAwLjUJqT3Vrmv3IYl3p
         R8xJYUkhISFna0wHWi9Up8crseC8jFD6ciY3NUQuDchUSgtqoTWp/63XxzZUImp7j+sn
         5G6H7CyoPNdTJ/wDOen1PzpLTAezBnsygh0u0g3gCCbY3Ec3wxuUNOCdPc8SYNCg9vq7
         xkhwimKlKlvwj74ErlNoWvkskEJvLLa5iimKHX3z5mIf4lK3A3GGlGDbIyxhQxVFtQvS
         SWg/GPGKrT9lU1dE7vPhrEC7Tyh2mskBWOe0kk/lBdA0yqg2G48Hvaecc/6wKmNYDJmZ
         DaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/tB4aJkN44ffppZbx8RR2I0Gji5t0eQCpo3CtQaX/24=;
        fh=aYyYqfXN/U/3wmOLZBiqGoGjg4mYSlmnxuQTIc/mWR4=;
        b=TgmOEenfGYCDaKOzRGIivzbnd2nXO1WfpcMXhCPMDFdBi899dQZsd26DXWxvq4VFfF
         lQB1qdg9eRbv2qNGrKSlcHRjuNrSi/0KQhlF3M0pUnAdHNVSoW9gKechrvKu3NZICnJp
         wr3ssPMsogxihKp9uZbnBjgu8WkMJDtfvQHzzwWWSDTlXAUdl/KhBNnmSOwsP6Sjtilc
         MfoZqAtxThilQnZMapUHsUpy6JcVEqWVPEj8UVFv53GCK8BUHqk+eYbisUHPFxhPRe4F
         bxe5xO6OrgVm/966bBL0onSTKmCWfb50MZrWp0xfxbrBLEi6Xm4cGyyBVS9H6wxV7kbp
         m+Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794174327; x=1794779127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/tB4aJkN44ffppZbx8RR2I0Gji5t0eQCpo3CtQaX/24=;
        b=JHrCcUw6ioWuh3VJKTKnzuM0Z+VKPPByOCSAh0ZsPy1xJTGYWvKQGJa1LOovL/YsHj
         gcWOgCo6gt0pRTrnU4Vhm/sYN3wK8cwKbcjc7rIougEI2mKoacDhOzRfAU34WkGaFSFB
         z1wlY1fGgsVhdM9HsiY8thmfOuHxxBgmoTq7/p874B/x8+ALFs+7+99fjVscwjdU414A
         q4HUzFr0co3bUdTzZjCeTZnaCjWyGfz+XOZveTcuga72qIVFgYJYk55oxst8yaaHPAR6
         KDyPzAXbmnY8IdN71Xnf9gc4e5eW/t9EwgG8wtbnz0JIfidO3p3E9CJejIdzThcqZkxd
         3zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794174327; x=1794779127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/tB4aJkN44ffppZbx8RR2I0Gji5t0eQCpo3CtQaX/24=;
        b=eSkbTeV3czafRdWtFehuJEenNlto7rbku9SpTXjZZ1+SAKPLBPn9Oz3jS/LkbRDgG4
         qzERMvTmq5TXnF5OE1/nxXuN34tVEX35Fp78r0D1OooBl7DziKIcdgtrSH9od6lZxgUZ
         ZrM3fK8Yotf3qbl1yfkHgCDDksX68VXVeOVs3mkkWrAyt5WJxTpOHov/4US1uxvPZTmD
         w+UwC0HZbmQqUbhqVsrvUnCyPViaUdxBeNcqY/OzLQR+VRgnUUjUsI03fek2wOCrJ2pJ
         w9VgUdEikp/OdNewRl1OBQpQ3fD9Lx7zcZrpSQLP+IFbGLjdp5bdjZxdWzh89XDLWSNY
         FLsA==
X-Forwarded-Encrypted: i=1; AL+hErHwpTnqojL9lET8tYFz8kEZsVDUuMNDcRylDB0HEreDj+v1jRWesnYu3oQNA2wObOdpT6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Typ/qjJ1bFNRvn3AV/p9Mps3G1GM9nnzUWbc0RPypuxAGLi+9
	/PnGd1hDBFhjSO/ENf66Ts55KoJBnG/FlUt7P9aryRKUu4EPyvINOKS2gcxaZO7uhNoKfYO16lG
	ulFqJKRfO3/c+KbENeQf1Bw0Ppi+/kiiSOOh/
X-Gm-Gg: AYBFou2ZponxgEjMObxZqEblLVmmJHRLRgCPSzZKsRFn1fIcy+m1jojo8zc/klqWQsz
	Qrw1zqMRRz0690lAH/D7s+4x9Dr4+jXp/HKhJDQ6YhrKO/Yj8+dmEhuUFRkvvksDtJlRVbR1aGA
	sRrhuJruo7ggyxx6JA00hYRCbnNduKvTiGEk4cX3+/ae9JTXYMa9vp48JqPGCUQBZ3W0sZSCmHA
	GP1Y1oAajQ4QA7C+7Xnp0tuEHoQA3SS8n5rYioGT/G+Pior3hb201DGDq2uOfkCfqeFfH0yCJed
	bw8P7Bt/zt6k0o1kt7McERs3ndUrVb2GsUmk0B6Keu82izNOhvnHZRHP/KYWasUghE7GJu4WCBp
	RI1BfmFvtpqXaZQnDhdVEj/AtG1KjReQpbjToK48CDCTxR0uYOoGfeyOJmyKAK0QvyOkyrg==
X-Received: by 2002:a05:690c:e650:10b0:8ac:46ff:d376 with SMTP id
 00721157ae682-8b36ca0cb6fmr9572847b3.28.1794174327093; Sun, 08 Nov 2026
 13:45:27 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018235508.848-1-colinlewishinton@gmail.com>
 <20261023185007.21642-1-colinlewishinton@gmail.com> <xmqqecdezfr1.fsf@gitster.g>
 <CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
 <xmqqmrrxdhox.fsf@gitster.g> <DMHZCS9LOW3N.ZJ3947HUCXZ8@lfurio.us>
 <xmqq33tnz0hb.fsf@gitster.g> <DMJFKJCI5DLL.12R7AMFO4DK2Y@lfurio.us>
 <xmqqjymqobc3.fsf@gitster.g> <DMO0XC1PL4MP.1J5830XZ4GCS5@lfurio.us> <xmqq1p8ylywh.fsf@gitster.g>
In-Reply-To: <xmqq1p8ylywh.fsf@gitster.g>
From: Colin Hinton <colinlewishinton@gmail.com>
Date: Sun, 8 Nov 2026 13:45:16 -0800
X-Gm-Features: AclHuK8bhCAwqKXiuodFfR9MlGTf5PdkwLsaybIU-aSJtjJmxWByJ2lJKKFMfR8
Message-ID: <CAHeTm9M5maWM=yrJPNzCibv_rewH3-yBK8J5-MDyDvPzfihe4A@mail.gmail.com>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD validation
To: Junio C Hamano <gitster@pobox.com>
Cc: Matt Hunter <m@lfurio.us>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I prefer Matt's approach as I agree it's cleaner and simpler by
removing the setup at the call site. I'll adopt it into my next
version and will give credit to Matt for his contribution.

I am still holding on to the re-roll until hn/fetch-refmap is accepted
into 'next', so that I can rebase and resolve any conflicts myself.
Junio, if you think there is a better branch for me to base this off
of so that I can begin the conflict resolution now please let me know.

-Colin Hinton

On Fri, Nov 6, 2026 at 8:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Matt Hunter" <m@lfurio.us> writes:
>
> > On Thu Nov 5, 2026 at 11:03 PM EST, Junio C Hamano wrote:
> >>
> >> Hmph, interesting.  Can you rewrite Colin's patch using this, and
> >> then merge the result into 'seen' (after reverting Colin's topic
> >> ch/remote-defer-follow-remote-head-validation from 'seen' first) to
> >> see how badly it crashes with other topics in flight?
> >
> > I still have the commit sitting around.  I tried this and a replay of
> > the current topic to compare -- the conflict is the same in both
> > cases.  eg: Nothing else in flight is touching the
> > get_follow_remote_head() function.
>
> Thanks for investigating.
>
> Your approach of passing more context into get_follow_remote_head()
> and have _it_ do the (lazy) conversion from string to value makes it
> much easier for callers to make calls from multiple branches to the
> function, because the need to "set-up" to make the call disappears.
>
> Very cleanly done.
>
> Colin, what's your preference?  Can we move this topic past the
> finish line?
>
> Thanks.
