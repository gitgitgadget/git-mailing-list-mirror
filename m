Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795262820;
	b=zvB33G623cRdcOEWOcQ7H9IS/mG0Wi6sNk6GE5EFNEf5Re2cHiXaJSJyWImSh2g41RGP
	 fLx59X79jk88Yhx2hz5zluen7nbPAUH2wjGt3VPu5VSah5BsRkfzVywYPtXKPy23iK2Jd
	 EpNWLfdWKbbco8sVysFCytOfYXco7On7uJ8+69J71FfVVyVm1leqgZogvqDGltngMQnrH
	 XCOYnDwitHkJI8T58TEcoLQ6Rqrpeg8jH9GD2NwesCgXhGVbC97EACeFZ/RHo0qOYXTdU
	 Md9/R7t73XuJIJXcvvMNMXu0XnR9NUl7sw8vb6M4G02RuFgywh+Ff8vC2o65yCN/63w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 Received:From:In-Reply-To:References:X-Google-Nh-Sender:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=DJFSDKeT76fSqn+HZbthE1hRS//MLVYxmUyqor+NZ5o=;
	b=4sMkEO/b+ZaGowg3g5urNj0YeIwxTW2vsE7HfNADt003gOiZw7L+86C+QlBqTFIv+hYD
	 M118K2KUS8+xrFu0eY5G8AZS/A/0SR3DdVL5Atx+qUgQcHxyrwyn1NYbvolTNk3VR/b8a
	 R/7LbFiUIkiwTZdTtAF9x7rXqNZH2zFAKVNlYuQNLwb7DWXNleFfK6aonMSDh8egtCFvA
	 V4sd++P1X50GcQG+BUo6NRy2ntBds85nUDtdsyTERlzO438dx/ad+5S7MwMRlCvt88Hg3
	 i64je7NQg2bCq+2DMzN4eF97JS5Muu+uBIa1I7PZpZ8OBrXgVb3k+JkQ/qwXffbINbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXY2uMHU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90743606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90743606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXY2uMHU
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3adfc004920so16130541fa.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 04:06:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795262818; cv=none;
        d=google.com; s=arc-20260327;
        b=MYoRdy8Ig2lVv0HIooh6+c9eZgyG1ymo+qmRxWMUTxLMaQoMx7Jfp9jPUB9U5z7ks9
         RyzWcrbmbaBerr6H9kiq8390n8GfuqdB8SpXL/H/kwWdKu1Zii6YhiVomgg6yDzBUiuG
         a4elfK/dP7vtYRKwohFTHKtDG9mYhOkORq+mLzwS1/BvF/ZfkEXPuiiwCw2yuo6DZrst
         LurG8JSA/zA4YWhpxIGrr0iIKhKhjB08ESWEvgdE5SVLqR7vfp2h8ELZ3vhS6tzral7T
         eL8TkulZmncLGrrrl4psyHLy1truZvTl8hV4sOgvtTkg1ZhU79lCEwsTKcrT6t7yngB5
         hcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=DJFSDKeT76fSqn+HZbthE1hRS//MLVYxmUyqor+NZ5o=;
        fh=f95pG/t11hHiGZ7732WMr+SyjoE4KbCfDTfDvCfWipM=;
        b=KiEK9C1azflYk53rP5MO8y8BIAeUnI3tVwVHkSdW3rrMZinN+5SIFBTO+QXBXLA08j
         gHkdlvVbiaflHIJZtmmMmuHh8lESBQjER2svI8BgbiRelqkqyraNjxQPg2IeKOKL+aFj
         KaRFkx8Ledyv3niVeeZK274SAb5rZs4WyyhqhrraCKYqiGcclSsxdnlugzYzOx+AYJCJ
         KDSB4eUCSzcMvS2Wh2PmPUJdQeakDTCcrHccXK3Ugq7j/R9LBDma38/qFJn/vJa+j1Sv
         c3Wlrlow+ZuuSInqa5JCg2Y6grBlpk2Z5i4MPkvZqk8ABoB5dZaZXgbB3UkMYeA8jGPe
         2NnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262818; x=1795867618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DJFSDKeT76fSqn+HZbthE1hRS//MLVYxmUyqor+NZ5o=;
        b=NXY2uMHU9FMDUPfiNUqQVzF+UggK3YhxOb+GJ/neahg1E+/uxdlLnvaSovXc7498O/
         2hLc/fI0fl0CK4tfUO1eJRvJQFgxcpMRJMtAPqvJmRs5YQ8Jg6udLE1TK+6JRSN34uyi
         e41k/CuGZJaN+rSdmVXy5NlcBkhovioGgZD9S1AslHP504lpkVCB2BAZ/BtWTOd0roMt
         VL3Pof1hNIOX5Bg3J2UgyYIDjP4gqQrMuirTV/prfGA/TzPynn3g18xn8jal0bqqsJbS
         gshTdJAlEtwudJsrcby5dq5eiDc4SsXYo8NgrCRoTPR2Ka4xMFWBu7inC4qGMqdD/TjU
         lOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262818; x=1795867618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJFSDKeT76fSqn+HZbthE1hRS//MLVYxmUyqor+NZ5o=;
        b=vwAQnldKsabua1keNZk+BcMJbQDZ/Kswj7N7YQc8oDgDgWtnWjXA4nvGflzuNvSMi6
         Vqgi9LhKJYvXjcd9W7h/WhRp7uaJnFfGhly1S1TkQc6m1GdYTlfIAy3enF8PFK+NXAlm
         nPiFBU57iqRszAX3mDk8UC8kJTvXfrlHODHTNCN+mw/ajWSVPTeoh3vxKM1l9CxtH1/+
         gTxf7AtMtnnudEzw4QxOTyxLfeR2qSuIOW2PZy0lMMHiVem0ofSizWAlgftFFhU4D6/n
         r1P8hGh71uYd69S7Tw4cuoFEkb2R2ZsY481d7TZNPTj4nMmRrLfJfmligLFuLb0gQ9vS
         U8pQ==
X-Gm-Message-State: APuU4Z+wRSeOUv6XxsXBBoX1E5oq6nwqFSRIfOGEUD0TMDbFWXY/s5tJ
	u2GiMxoxSVkYTGl2KBva4WNwM2bFL7mj5sEkUXqVMp/CFibNBQMaJjjUFy5KhV4FcEDA8kys/fe
	CWSroKIh9Aq9QrtugU257xyh2i/j5WQk=
X-Gm-Gg: AZFdTZfSjghMHtJHQCepo4z4abSLsL8Lx4K2wsJRCkf9o2gpRa8jDfaadmf/3K1nPW0
	NgzB0YHHLERUpGv8RKWM7n5ZBtX27DNK/T/fAGK0aM0GmFOVhDUAL51ZkADl3xq7hv2EBegvz+R
	ALfX/RyxAKfNHSKUtAeD9rRXSswBE5Hva+QnkrbaAo9HbaN4xwfRNNIkhi6FP6udxQG0XVXYobr
	h17wRWcqWtYmPyjSjm8S/X0HowuxyNcQrpaGTtnpVk5Su4d+4yyFFaGTfTB7ASpqJrXyDPaus99
	uBBYVuVl5oKrvn6Pw0Ax1nDf+PoDXb+TZfpQxvMFWF2wdX0zOVKk3ePqtUrvucRws656XytQKCl
	CBl23Qd1kwHvGuORvxgpC1hQAS7qtv4aMZmAjvE29VWRCCe4Folrz0VH45SPYkghZwn74mZVkal
	rWBX2GpMtA7ZYsIVoVF6yxJ+AoAp6/xbsKkSdhCRDP2bGHl8tGOhSHoIpJ/p45VcasalnL
X-Received: by 2002:a2e:a815:0:b0:3ae:25fb:b2a1 with SMTP id
 38308e7fff4ca-3ae7fa22e5fmr19371761fa.21.1795262817507; Sat, 21 Nov 2026
 04:06:57 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 21 Nov 2026 07:06:56 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 21 Nov 2026 07:06:36 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Sat, 21 Nov 2026 07:06:00 -0500
From: Tamir Duberstein <tamird@gmail.com>
In-Reply-To: <20261120172420.47728-1-aniketgupta3001@gmail.com>
References: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com>
 <20261023-ls-files-untracked-cache-v3-3-292260e95f53@gmail.com> <20261120172420.47728-1-aniketgupta3001@gmail.com>
X-Google-Nh-Sender: AW_J_UoH4IMh0o9E2WH1X7Fcz8CY58phDmF3RJ7IhkK0bmhmlWwi_C6OGHQkyRHl_36ZorulRTYx-aM58GiWcIGHRUPWyT_U0PzO8LYJEAJdKj-J04NqGzcBVsTwpcnTrmxgIwe02hjRNLSQUZRehesOm5eUlhwmR-wqy0PVmETUf83h1swwe0XoN7lhLVA9IiQldOGvk-babkwG9LHCFIwS9Adu2Z7dJMRYvJFCezShjY-Ya6ElChI8thlozHQxtiBSAmbZsHfkow
Date: Sat, 21 Nov 2026 07:06:56 -0500
X-Gm-Features: Aa3M54pnyR4snKR4wixc2LEmjsYS_jXXSIUdxW5FTQFhS_PVe-gHb5ZqZdb5fLE
Message-ID: <nh-380eecfb-f3df-4a96-ba13-0622899cdda6@google.com>
Subject: Re: [PATCH v3 3/3] ls-files: use and update the untracked cache
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org, Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for pointing this out. Since v3 was sent, 6b6d1d56eb
(=E2=80=9Cread-cache: verify skipHash index by stat data=E2=80=9D) landed o=
n master.
That allows the optional write to detect concurrent index changes even
with index.skipHash enabled, so v4 takes the lock after
fill_directory() using repo_lock_and_update_index_if_able().

I also removed the test=E2=80=99s early-lock assertion and added coverage t=
hat
concurrent index updates succeed and survive ls-files, with skipHash
both enabled and disabled.
