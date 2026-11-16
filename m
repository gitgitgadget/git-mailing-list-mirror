Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850429;
	b=hODCZcPNzGpjBvcjnhJtZnUlGlrUob642N/X2V74yRQumxXHPxHxxHM+GKAhDiA8XZb/
	 aKg+77BhgbIbQlzcYMaftsl+AmnZp/sMpt2n2YCtWQcfbn9b1OlmTInJ0fCy0KbxJrUD+
	 gukN04SgBVQ5bVQUxt4JdEw8bJaHKq2w3oLzh9MEekJRHRuGidspoAd6JFBgjoS5q8yc8
	 tgOwKUPdrfbLVkf/H5A9jY9Ii1CYV4YVmvQeWzftq5FR49chb1kcTuxvpCTorKtXptuNB
	 liu2DMbMglkh6CzKHyxIZnNMZ7FewHP0TjF0qEzerC54Dkgdy4DdcR19BVku2kkXI0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=ENZCl6bSU7qSRrVYHO4yhuDjJ58GtEmt1/GG2CtAecQ=;
	b=qCi9ZGZuQZ8LpPKTUrA247pAaG33L5ru/t5+t7jNzHC3VQ9ZaFfIj0T7gQAQtKwJ2GnG
	 yXKC30KHbZ8fH3/3gVCWi1SvatrerCBg238aVjNqw6Y+XFEMM5Zd5/FOGqu5r1UxSd2O7
	 F+wiWyC4VUFun0yLg5AO2h2+4e17ZOTRqwhiezhabuD9C2MUxPGVip9WQQ3qSb55aAZVl
	 DaAp+6OA4vRrIamKKatAnAwl+qIbRFEvtAp1ar0rutyOogTcM3SvcwgRBm7Vahz3azyrL
	 N2BuT66jfhyOIH9eQukcpDxOBh5FYUiZabTxpxv+MjhbWQCXkZcsKfO+tQMjn5xGn2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYjzjAWz;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0350606A339
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0350606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYjzjAWz
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37071c0f42aso5499539eec.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850428; x=1795455228; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ENZCl6bSU7qSRrVYHO4yhuDjJ58GtEmt1/GG2CtAecQ=;
        b=sYjzjAWzWzuDjaTVIUz38yPZ+yATE4MZ2hn4R/O6Gd/f3PeLcIcJtsScM07uWc8xcr
         gCm+t360tiYgvUOxfUkpY+AF1X/jvBbTGJSrVd8YPeGxkq6bSNIzJbsbWCjvQpjPJaBU
         vOUWDvWHSLPnhjnd8xSSGArEIMazkW6nM0Ayusd/wyhRKxqLcx21cO1nlNLGygR/Rh6U
         Xvr80ag4YrKYSrqCOEFTRYyaq16xomErUT66iXiHzOCK2nKVeyj+6JB6OQBny3cN4fcN
         DpqH4OuSAPZWXWdXIvqG7JTBCDYkqWDjfAVjj+UmOuDhSYvypsii9Dh2nHkLBLDflR92
         lQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850428; x=1795455228;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENZCl6bSU7qSRrVYHO4yhuDjJ58GtEmt1/GG2CtAecQ=;
        b=0zdQqt9TefB90hkfvnejkGHcsHAhF61TOEa2od7wINtcne6xuo18nQjDjuaq1fBjiT
         ZGASY1o7Ybfhj2YkytYlfIOfy+6t4ATzWe1Ha7i5WlRf0CGiq0RcLJJtOAMeDMIr7iIh
         U3RAU3jWodh/WKkXtUDNNhG7eU77uD/dRNb2AXww5iMRhtaKWy8qwzziQB/7g5H5M5r+
         pSxrGy3GRUX2fIqoXdyureo4njUpb8v+SKEDYcURD9uDT9Bh8nDOH3PbayMetk71tsoU
         /9aKUpEAMEjrHcIcjwpe9ds2Rgh3dIp1JIDQhGmMt5yp5AwLfP7opteK5ZsA2G0RdkVm
         /f2Q==
X-Gm-Message-State: APuU4Z+3AnU5FvfcTV9bdBGZrld2WcleXdJoX15yiLdPXXJkRk7Nibgq
	pShPKqfxhoiVUJNfcD3dTJOH0E3oapY4KR7JvwpYVag1yBlGtx4/k02a
X-Gm-Gg: AZFdTZcQMddIJjvQ36TUOb2I9tS44l4PEKjefCA6PHH+jZVmgOovphnAG0ROi+cDPr/
	wXbMx/H+6x9mHOHSHG8ROgYpsTezgJgjngxKUIfQ5IYIHVnxh0iRLttIbKe5+Z2SlEWg2ECLYfL
	YGXi4YCstWlrUl0IWy2xummkiWb04/eBWwj2ESHl+6ftJdmfd/CT9bMZfLPBbIOARxEKIBuiYDV
	kB1hkGigZF8g+Pa0PVO6FO7DiV/8SaTla6yqcKzcu/Xe1OVnVIM80uUrPSz4N1ozCTh+SbIkSmj
	6tQoUjJ+sfUmAL8bd/iC3jxQGBqrq5DRxHeByDfyUm2+hWkzZLc6StYkYXwIXKGRZx45+TeiKbX
	h058F1K6tdE+5GN1I+Wyoi7GeumHP4OpheUJsrxN52eEehFGs5v1IJHEgCaXRudImgfSSmomx0o
	puewZdpKVigMbhMTBEJDiZ+4WTcRxcP8aheWrkl9OmdJMUH6vl13aXE/pljPiw3XNuLJN4rBizs
	K12InPdp4BqaX+pHqWqiFmqJVTJHJu/aAh0L5q+prcJbXdODVMQX0+7pwkI4+csXu0KbGa4YBgT
	nADzOJ1eZdFhVvlXKcnSkbUb
X-Received: by 2002:a05:7301:6185:20b0:379:3c04:2cdd with SMTP id 5a478bee46e88-379686a7f3amr10722123eec.31.1794850427939;
        Mon, 16 Nov 2026 09:33:47 -0800 (PST)
Received: from localhost ([220.158.183.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm70492190eec.20.2026.11.16.09.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 09:33:47 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 23:03:43 +0530
Message-Id: <DMWTDHJGGUD8.2ZZHA8YHM7EU4@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] t: use test_must_fail instead of NOT operator
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Hardik Kumar"
 <hardikxk@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261115-t-tmf-refactor-v1-1-d7a95cdeaedd@gmail.com>
 <xmqqcxs4n4k0.fsf@gitster.g>
In-Reply-To: <xmqqcxs4n4k0.fsf@gitster.g>

On Mon Nov 16, 2026 at 9:37 PM IST, Junio C Hamano wrote:
> All of them look sensible, but I am curious why you chose only
> these, among 14 hits in
>
>     $ git grep -l '^[ 	]*! git ' t/
>
> I suspect that it is because these are ...
>
>> -	! git clone -c http.proxy=3Dlocalhost/path https://example.com/repo.gi=
t 2>err && {
>> -	! git clone -c http.proxy=3Dsocks4://127.0.0.1/path https://example.co=
m/repo.git 2>err && {
>> -	! git bisect run ./fail.sh 2>err &&
>> -	! git bisect run ./fail.sh 2>err &&
>
> ... simple cases in which the use of leading ! negation is the only
> issue with them, and if that is the reasoning, I think that is
> sensible.  Contrasting these, many of the hits in t2206 (one among
> 14 hits in the above grep), for example, look like this:
>
>   ! git status --porcelain | grep "^.*$" &&
>
> which violates "do not hide exit status of git behind a pipe" rule,
> in addition to have a strange looking leading ! negation.

Yes, I should've mentioned the reason for not replacing the other
instances in the patch reply. I just trying keeping the patch to these
specific cases as they were the obvious standouts.

Thanks.
