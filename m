Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679941;
	b=nV3BA4ulOaVlIvbQ7FGmtQsdFUAmjeR9zeiy3WaC28aXnKI6BoyMxPqOikI/kDXuxbKs
	 3twwRwB0ER237JP48cd031m+1s7pZ/VFTPfchdS7bW5UziPJ56MHtXGmTFxDMbWjuKSPL
	 ks6QDHx/SvBAQmis4hvmnrbNcJvAvQ1sOP4MvM2MnITC4oh50WJmkVp2w+DDjbvFMtvfp
	 9wkhVLcIY2gho7t5+s4SE8ntzno77fdw9HFQJSDf3m+0gu4DmsuG5gQgqsRGHYFoyPSyW
	 LOjkffufEk3wnaBGF+EsBzug8XPSj58Zr96glxhdH6MGyqq+6wuHpxwCZGmKtqBbg/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=yr5YS/n/l2VB4ybMfHEId3kBXgzBQnSpHwdcFZ8P9Xw=;
	b=xOAz13KR2fC9NaR8suZeyzP4qan46Vko3MxM9bQOXIyYpv11a2mwSKJgt8TQJJvtE3pv
	 1KxhNLimMdw5l45TQitWBFFAWHxm2btA0v1lNerQcAOngZqAYIgjquQZQraMFTODE1JRR
	 oMddXbTFycSSdVOHNceVUuv6C+bfxkxrFWHdJJhtiQHTAlVrML06WCcfqRMu7nlk/ca0M
	 no5iRw3zIby4fg/zi1DzvMwQn+Zc+szu+oovS57/UibSxm557fgZcNLdjdWDd6AzFDUJt
	 E5oYT2jGma/igrqdAT8EE6qaWyXRmd9ZhddBWJrMflSB1FRLccCfm+Bcppcus6+taSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MiypuHW0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19C606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B19C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MiypuHW0
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so2951301a12.2
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792679940; cv=none;
        d=google.com; s=arc-20260327;
        b=SkT9GxIgZb3/yGgwzBjzm4lxHIOaALRrBKpp6a77rP7htAW80aHL24D9v+d+oubGgr
         qNIJkQp+8ui7+vvNq8cGnx3sYkfhXs3h4mCdDvyLshWPcnGU/s8f52/hOiLBsu9BGnlm
         OrH+07U9fd5OdhgBJPN0d2rKOlu5E9Ewdwi2KLxobLMt1UQnfXxvaDt1ks20bNWvfnsU
         DsFQIyZW7wFkqflxDHoIdZtFXd1VFRWV/0TblBZz8nuutXIyuF7i+i2W9WhXsADKb7fm
         z8NW0A6V35qVHPxUGj90vgVJ7+Wp+MUXexwSNliohZPc7IWIibGC20D9jcQ/Ee6q06PG
         PtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yr5YS/n/l2VB4ybMfHEId3kBXgzBQnSpHwdcFZ8P9Xw=;
        fh=JYHz8iyw82BOp4WvEKAmDuSPYPBlYB5Rk8wNwxgPW04=;
        b=bHxna96GpcSJLlz6Q/4cfoPQwgEH3KJLrDZzhK4QLBE5z//4UWbonV+qXd1iZGK6gC
         sixzmtahPWh9svwHpTy9J0eF/JFHsu7e9ftECLMFru64K7FKeDQDkwHdtj6RixzuTXs1
         GXbVjmjkhNM2+Ops6iIsAQ8/B67hGRpk7Hlczp+9ucLaifcLv8xyAsJ9SBpXl1pFRKmL
         dlwLxuXJ0JV4qw7VYgkLtIR8Jt1Mf5C3PSw4WvugJeNmz7yBECdEirB289SSXhxfJg8S
         pK7nwb4PQJnbT7OB+Jzw9aqYDuzP2aiaulSQesNjKwwLnOdoQzr4OZvdkHviwWlpM0t6
         +qgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679940; x=1793284740; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yr5YS/n/l2VB4ybMfHEId3kBXgzBQnSpHwdcFZ8P9Xw=;
        b=MiypuHW0U9eBy8Wja0mlJzIo2untT8XNp+qNgn2WJtEKth1SbPqzIqhGJECQ6FHFSH
         So7GvWHsKXTCrHFG9zqSUdq/KstFUaUitzSvrDIfBLJlM3c0vbCaF4X+KJ6MPny3ikJe
         E/rkLFR4tCddc+Y91PD8pIBlYJwOXbvvqkkBxNg5kA6qcNRyFyblIrm9U7B4H/1oJ0FW
         DZQxmw2uZdeBZfMk3ob2cPO3XfXvIcoPf0oWfa5kvzKnFBTSO4JJtNRVC9hagvsdphaw
         1FOtmM/S5bLKFsc554paba2im3mQuZoXyzEuftyz9iwKsvTQIQ7X1NWP1VnkW8J3pWAy
         aNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679940; x=1793284740;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yr5YS/n/l2VB4ybMfHEId3kBXgzBQnSpHwdcFZ8P9Xw=;
        b=FxSX/sOypl/JtkPLDLrgrjIsbCmTffyifiqMgvTd9SVp6MS4vVpCdkndkbCDJvlWNE
         OwXzQiMusk8ylp2S4sXjbCHD8AuOJAcg6kmgUUi7QoucbJ9164nExoxDuY1XYZ2zg6Xb
         aqvp75fqzcvO9r1ghR4HsOZ6KGMbCq7VHPhwWX2sTVKxSMHfgzjtBAM2w92qD2MQOutn
         IXmPqgRlIRf8ANkCko+U/STfrEkUHEtnzyijuz895RNQFYtOIMGCStRvSGYTWrcKDv6D
         oBhPjG4CkgVicYNzL+7fUzxr8wvIqTfiZ1s8u+CTPDpWAkqhZqNvPd2d1Dcuc7gu3tE8
         VYow==
X-Forwarded-Encrypted: i=1; AKwUvBw4lTxUU1ALEeZsPhS5LMsPdsQ1M6azIkM9H06RsaalUa6DtHnaWPy19WGLUYR50puyeV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKj6l6jz90cJ7hDIQ7eB4/mN2MpZz8dncgF+DX3GSC9dGcawKKk
	BKT6zCh4k4ZRoBUB/AQuOu9KEMhBoySpYsSv1D9IekdWdrWLavUdrM+Aj/6wiWKDFEADDw2ctKP
	8v5gi6D/Ed2vs3OG6lat5t7Va/rK8hu42LWWn
X-Gm-Gg: AYBFou0SAK8mUKp/+qCPmwp98cTSVmd/3az2q5mz0DjPNvAnA0VkDodJr3VD0165vIN
	KBlPiXiR1hN43nne0EgRl/2+KekhoZ1YZSDVJpJ9HQg5U3HvDnmuNa/pmo659kwfdXhvKrDHpvG
	6hRyRzcPo3KyoTzKeYuSIpdalu8tKj+FmSSry5Jqhi0SkW3lHPjKcNeFFZTv7+8YIM5kxSfnNpr
	1tDiozGXr+TdNtxPqgF4YxV0PjtuS4QeGLMUZkFRyzf7Jku4gvbdOPdu2zcOrSWLjMp7nxyleKe
	/9ieiymQ1UEg/qkXYJTDmvd5c+iGlnylVg6F6t+qKX+mLoVGFrIEAc3AhKUKjrTcarssngU9rip
	wceWTVSkwcPBRgEK8P9SMkW5CAS4aKXdQZC9d
X-Received: by 2002:a05:6402:5d5:b0:6b3:cd39:cbf with SMTP id
 4fb4d7f45d1cf-6b408f04c17mr5675072a12.41.1792679939788; Thu, 22 Oct 2026
 07:38:59 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a8561fb7c2da446e7f7acc7e2a443991@donquinleone.com> <CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=NK8=TA@mail.gmail.com>
In-Reply-To: <CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=NK8=TA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 16:38:22 +0200
X-Gm-Features: AclHuK8KD9uv64ZNbq-3pbRo33UOqoKSzervIQ0XnLpuzbowVk7zCkGMdRdbqyg
Message-ID: <CAHwyqnU-BEtOPdVbBXtuEYtFYuL3MqC9nUQeP_Puvq5bsoWEAQ@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> I would much rather see more --option=value,value,value syntaxes, like
>
>      git branch --delete-merged='origin/*,into:origin/master'

This feels completely chaotic to me and becomes a kitchen sink :)


Harald
