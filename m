Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71E3DAABD
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583820; cv=none; b=s77zZdVR1tEpdEq4bYFvmtxQSSLRLhxer0nK653Akj4BdBrjw/5fOlXk1Z13N94amYh57FG+JA/mpf7fSCr76t5WT5pJG4HNjk5NGRyOhj2UGR1xf8s2YO73ZYURa3yVP5eK/1jOSISGQvyjGTkFW1HzcpIWkCEb8MQsheNJhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583820; c=relaxed/simple;
	bh=gJ0D9gEXxlHGAekbMII0uztgb1FPcigBRDYh0GtgoTs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=BsBTHsvK1sn1KzSBoo6sWjCcmVPu4qr9VwuTaojB9RqvbRTcpSLRqe/UIpIpfsm/CLvHPcXR4LkXEoUeOnkiOY3CdruF/UHII7G40GiF15T3PebIA51e3h2f6k67YCjp9r8LIazVOHDDr6QVOnXeuDzknBLpdAlcPhGppuowoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZB5bnhx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZB5bnhx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5339381b46eso1804941cf.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791583818; x=1792188618; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m21QT9A5CNwDPFpIUR/2VsccC1KEBbj88r+Mbwe+sAQ=;
        b=lZB5bnhxSHrBtc5sUogWuf+AAyBpoLGRZigUmvmDCMjqyh69TgQ2BLQ3ndRZi+kHA3
         hvrqkO9KWvXcVYaAf/H8QAo32rM9wFuNWrVZgPxfRYFrBrV+H4XUdVAkUr5p0hGemOYH
         SnPtAdcUlmWFF46jjRgIp/0nyGe6kU1YFwifrps5fyuXyiLRohY9A6rrqA7uadPndWyj
         BECl/7sNVEh7qTf4ECiVCra8gfSv20AxRswo4etza3NKzYPlMNHmjXiHQQChDHZG4Xol
         EtJBbDP7Ga1OhUFXiu0CpMHdfsgs9J6kac0HFa1T8L5h6UVBbL99xjZtgiOKZ5VMvdwG
         SJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791583818; x=1792188618;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m21QT9A5CNwDPFpIUR/2VsccC1KEBbj88r+Mbwe+sAQ=;
        b=U1FX7ud5FR8Wqh/f++6OlxoUMwEQbebsplH4CXkDFWoQW2gRq09WuSH3ZgoP4buoG1
         85QKJfTEetvLd7jWH6yyH5OUukfO1lF1DIUpocG5lSl88U78GxB2ZD31mhlasohgG4Z1
         AHX7BjPkUzniM1lgBH0DQfaElFeH8ywrRfrPQqCSdJU9pANV/kWXEVfqqTjb1KTqn1Oy
         e57g82Qdo95IJlCDQklftyV2YT7XFBI0x78rPc9DEXCVHmW0TRoVJ/Fs+wWJKiuaM/d1
         2jssOHBRr7VvD3jXmwExNkll/g452TJX+e0/J+b7q8zhJhu8SqXLbz7jtD9x377zbg6B
         Lv0A==
X-Forwarded-Encrypted: i=1; AKwUvBz6hof7anzOIztau/6UFRs8pzl1i/nuznKm/HEqcX4K1ZF+vQONlboaiu+RlVc6QRiVA1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGKvpIovcL19IBLl5JT8nn5lZKUZxzcITLshhBKAIlzzxi8aOm
	o5KGDiRGJEC9gqMKqKSJCjxtjbTXdcK6/tB1o9xOEJIrTUXZbf4TLlem
X-Gm-Gg: AYBFou1Q9Va9B0OofcBUvqS6uVXcg5GUgnalCjA/Tf+mlfdv/RRU8BGg1iKy99+U/E0
	6hwJmPYFuzeUYDN4kKRE7vpBZ67Ihtigihhp0PoIvmTvTie+1Rq8SJ2LqdjHHSQLHHUtq88N8jo
	Z9FYgA1Etjw3lds7oUEpXQnOOJ3uLmqnhnPw9/E5KMVsnsrsOhDSh8NpCOhddDitO198V9wBaLu
	iPky8GPPvCDIjQeWLXbpuS0PncJFsh2i+ZgB6VznupWSEx3njcTtExvrtnhWJatgCmmZVZX3SNR
	hVxo7fC3vpdF3pqT0l3TGFB2PwUwAPOe8hp2PLRZ26+SAB2u/t6QzYwYfY1oYWSexsGjQnlwHDA
	jLIiaecYR5I2sd3upAiZ754dvxa91CC73hQCPpNkB7zBXtY9pvzn/b+EF97XP3huI4ZB6yPA5Ku
	v705Uogm8eJbIYBQiu7FNO439gO6fRHBZuhsBzXNXUjLYqsjGhvstmWOgcQwsFxUWUu3v4CUyL1
	sTZL1jLP3H5N6tHV7Ot/WaN0sxlx/cXiG3qI3hanZBmIwu6GmipUKxyyOSAUfTiKVhD1lPnpKck
	m/7qS/LJbwym/EU2dlMVA+teSnvjUhKuEOtK676aPXAGfBWw+S2M4FHtCSZG
X-Received: by 2002:ac8:610b:0:b0:535:1b18:20f with SMTP id d75a77b69052e-5359fb287e9mr50326931cf.29.1791583817797;
        Fri, 09 Oct 2026 15:10:17 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b03a:5519:e4dd:bcda:db98:5ebd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fa0f9sm27600511cf.8.2026.10.09.15.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:10:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/6] [doc] Add new page on merge conflicts
Date: Fri, 9 Oct 2026 18:10:05 -0400
Message-Id: <E227CF3E-65FA-447E-936B-BF23DE5A2649@gmail.com>
References: <xmqqse2evq2k.fsf@gitster.g>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, ps@pks.im, Jeff King <peff@peff.net>,
 Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqse2evq2k.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 9 oct. 2026 =C3=A0 11:41, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> > =EF=BB=BF"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:=

>=20
> For example, you added Ben and Patrick to the trailer of patch #1.
>=20
>> Range-diff vs v1:
>>=20
>> 1:  ad4853dc36 ! 1:  ab0344f947 [doc] Add new gitmergeconflicts man page
>>     @@ Metadata
>>      Author: Julia Evans <julia@jvns.ca>
>>=20
>>       ## Commit message ##
>>     -    [doc] Add new gitmergeconflicts man page
>>     +    doc: add new gitmergeconflicts man page
>> ...
>>          Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanag=
an.com>
>>     +    Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>>     +    Reviewed-by: Patrick Steinhardt <ps@pks.im>
>>          Signed-off-by: Julia Evans <julia@jvns.ca>

PS I think I just use my non-suffixed email on this project;=20
see our .mailmap :)=
