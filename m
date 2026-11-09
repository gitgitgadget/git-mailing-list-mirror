Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794265467;
	b=XStcfJ7WAuY1AQ12Fh/scWanMdwsCRAm2pTMLMMJFX/pn2LnuRbzourTL1AZA6Nj2jsv
	 FipjYkljjC+YqFhjFykYGo5sySf+cnxjS93EPzI7bXjQodLa7dpTTigEvof6Sy8Xcyryc
	 NkDPnenAKz/RjmU+RevuBBpbnyMKgxzmIFazrfjCVfhRQaLh44kmYGidv2PnIrp3mF3gV
	 RQ2EZV/Te/wJ+GFhG+Ww4Ec75kgB6/sz4idsF7yRcRd+RBV0/lJ1z1QRED3DxN/DKTtiv
	 w3ZKmPFCuAUmU3tX5Mgtki90Gy0KArpKu6kgdCKYZKrbXgBKRJ/WFyRPiIt4U1njDsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hPbhY1LXRock2L9aOr7a52x6zENxbDUgXC9TNwBqcqE=;
	b=4fRfRgqPgS/HvgSrL96hFobOKq1zT7vL4RzrtSuiF1QgWhmcz9ww3BHXrYQItwHjkGD2
	 nowkSWOe5k28J6s2fbom69PM9F26pI7MoTvV86AvOYCdTeKvwOWWG9ey74F6g+wTuN9+Y
	 esi2aKHMZU8VRdipVeHmEYRN+wRQWbvxWzvxaSDx6IJDGNH2sGIFpyGDxpI6LJHwsIu8p
	 jsf/jzGig9BsIy35K4FZG7zl3KDEPwfzRGgY5UIiEBGhWvUU+7+1K2LTP+NKuv6OJUru3
	 Vg888SKx7RLLw0mMApPsR22Wl2FeXOgNvQ1pIFpNGGf+hArnvI/UYT/+g+pi9Xb7Umw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBGNcpRM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2963606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 23:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2963606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBGNcpRM
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8446af403b5so788946a34.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 15:04:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794265466; cv=none;
        d=google.com; s=arc-20260327;
        b=qor22Nt3pdaxIvQMcKR5GFX8hMMwfFOkp7IOp4NxZp3slTtCn1Xvhppmbkq1ZbgGSY
         MZycWIsrsO+2NlQXb1JR0M0mD0amD5clR0eFDexzzmtdMZebj5sj+QIeBfSDgffLr9On
         WXDRXCk1TNZW5GGk2NEOr4bPVgiO5VsDGZtJHL0SEoSm3ALPMmV4FBzKefjIPiGrIIqO
         bSIssUo8W7vY0ZswQZHVThWIFdNqxUMOjs5ZzBbrbFCG/dcUY13hZ86GCCjxVdELmAOp
         BnUStAFw1fozpdPt4KMu1GyFkdUKCkdMBH294xTBubakpwoLAKJw6eo5g+81oZXZQoLH
         mb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hPbhY1LXRock2L9aOr7a52x6zENxbDUgXC9TNwBqcqE=;
        fh=V9vrvdaj82ynGTCWtfClt4rGmBVh3BLMFuj55aTDstY=;
        b=QOnHcsYjd1L7wLsDAFXN2pwZ0EKnNyfa4CSmst2DbltIi9y8zyF1TDl9D3fXXI68EF
         D3CTNYfDSiKqONdNipYg04XnCua1atq9M2e0FNKahMpL1VMkIbCTTCN4JCO+qtrfMduB
         q2TH7O+wrpH2S6SSoyhOI9ocniwWBlmhvjD9vbmqmererQgt2bpF68yApp6v9A9ve2iN
         Qx+uHUfTfIntLAqb0ioxvbLRS1R0vrWLLrTsrWDsZifPufwtr+vXB4K4ITfr25qqxwe6
         Pqenk8AfzHTFlzNOSvyEGPAl4Rn06eA7oGueEX8Q3sIGePt+hBdothx4DTuyA+87pOb3
         notg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794265466; x=1794870266; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPbhY1LXRock2L9aOr7a52x6zENxbDUgXC9TNwBqcqE=;
        b=SBGNcpRMZawXp9yKRzqJYYrQMDEfPMXNzVHg8+STIbYLoBYLHNVVceiqZCydHwcvBj
         vTDUSytl1xFNf8zqFc1cEnPxBKk4BrG5zNxz8ZqTlFs3hlU55obUwIDPOsBJ3XgZUkK4
         WA0j5wQGJiZLGM+ctSMBXZRh9CztCZu7NZ0y4qpY0k5RJ/sIVm4lFRKWsjzcRWjGMB2q
         +IET35EkfyBv6ZmJqLxIQykypLW2NuEfOhKwT/COayc9smgimw/VyQxWS9ZrVqm0ybhZ
         /PSepwKfwqJUTRWIg4wPTlwmLw+iFjPoPmLuig7M18tE15CAN6zVILkB0xOmWE3+tYkJ
         HNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794265466; x=1794870266;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hPbhY1LXRock2L9aOr7a52x6zENxbDUgXC9TNwBqcqE=;
        b=1CbbMe5ryipBBEiQWS3A/AwhgC6XJdXt3tGZ+lMxpc6vgV1x2L7eZVRK+Lo78G8sWm
         Tak9HVRe6EE6KYu5sS0gY4agy8uJc8SlTHjpZYG+8V9WTrQ9vVY4XMMHQJcaiMuEiU2e
         lubOcWd8amBkAUMzgll59PqmeXVRlLAMebYef/s9P2UUgMv2QX8n9xtgLbISoueC+p27
         vu3o1zvXAqojXAu0hJCSemFMtEmBc+sIl3MGF3nHNcW3wfAHdqPcHy0X49CAED25praq
         ZuTSWau9e5KVXOZ3VDbOVhK0SRWPS8fTouyipyw0rt+tMkxWLVs8sm7nHj+WaercEyGG
         sBkw==
X-Forwarded-Encrypted: i=1; AL+hErEFJpjnoq8L4aYkM2en/DPvP/aTlSe8rd2GLyEeH/Qx8zlmq9c3blBhttdGjQ957DgNdJA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YOC7hiUi2TF/ojALFDHM0oRjGO6GmhhPbk2MrKhdHhJBojmu7
	vN9d5TxwESwhA9aoxD0um5n4snihvn4rfYrbsdpP5izbckJM4cD5Lq2vb1hB4sBZKjkWlaPRdMy
	WB82MAzIONZrkyblc4iKxA9L05ikrlVc=
X-Gm-Gg: AYBFou1HQLexFrZLjAgLeApm6hP88PiJf7lQodAyeMG/AxJkwJ50g60GNOH6jxl9lA/
	PV8Xry3mj7WzrWUuZNmGvyoBhoLow8WSEc3dNGbxY6JnStVYNC2cjLXwAcrSHH8LbKIGEFjc5ZG
	Mxl8u6yUyFiXKezN+vfl6qqRpead8HJwFvSyPDBztSlys6dLyUi/Vg8dtuK9yYtOEg+nh5ld8EM
	Xh4kdewH5r+y4LseaPRyUULnGICIYGXtyTC/fXmge2ztUt3kBXiPOXEJwgkLLXTbvJC0hKq2qfD
	V411KgPzzrvM5rxjGioMMJ+qYPWsOpFUGj9KVYJeFs4Ke8pguYYp92yraCw6qaaDxriAgrDcTEz
	o/Slq9O9hMOKojJmDy1FLAvPcrA2YyBEm0Z3gq9b4Qbz2ET7tVFqhYzP0+RIgzmP+BqJ4HMOz0n
	Kyx0zcwq80Rn9KGBqjWwxj+R29NkCHyBXD9Y7yRvyVO/UfwjDvy8pPyg==
X-Received: by 2002:a05:6830:680f:b0:85f:49ec:c974 with SMTP id
 46e09a7af769-860dc72ba68mr649611a34.14.1794265465706; Mon, 09 Nov 2026
 15:04:25 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
 <20261107195429.96842-1-tangajoris@gmail.com> <7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com>
 <CAKrRMNr5VJmvws0asHgmDxCNxo19ctGTpM2eoTMT3iQ5v2cagQ@mail.gmail.com>
 <d5bb8fe0-7706-4e3d-b471-ad004411a9ed@gmail.com> <CAKrRMNrwEgv6JsWcd+UorLrKcsBgHV=UUvfH316hedM2TYGWqA@mail.gmail.com>
 <xmqq4idpyasg.fsf@gitster.g>
In-Reply-To: <xmqq4idpyasg.fsf@gitster.g>
From: Tanga Joris <tangajoris@gmail.com>
Date: Tue, 10 Nov 2026 02:03:48 +0300
X-Gm-Features: AclHuK8Ee82rsjzuPlCIkvP3IA07bjOnrsb2F49H1roe7-73PnDm2tRvB2FAcYY
Message-ID: <CAKrRMNpZ5vUwdOtrmb_kON_c4x8eL-2PekcQn5f_TxpegwsC_A@mail.gmail.com>
Subject: Re: [Outreachy PATCH 1/2] apply: do not keep names from an unused
 "diff --git" line
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	jackrawlings2011@gmail.com, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Junio,

On Tue, 10 Nov 2026 at 00:06, Junio C Hamano <gitster@pobox.com> wrote:
> A garbage in the commit log message does not count as coming from
> "git diff".  It may take some effort to teach "git am" to avoid
> feeding such a false "diff --git" line down to "git apply", but an
> important thing to keep in mind is that it is NOT "git apply"'s job
> to worry about such a garbage input.

That makes sense. I had thought of it as something "git format-patch"
produces, but it is only the log message passing through. I will
leave it out, and the next version will only reject the corrupt
headers.

Thanks,
Tanga
