Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794283113;
	b=bsCvEeUhwqHudArYakmCt18byfTeXBONV1zxuK1F2odkYiRRDEiV2reGZLZDqI8ECDkc
	 4HlfYS5qj9gvWo6YA0Ev5A5RZqioclFUHYYeJWYXy63xKIoPRpBCHHaOMXGqa76XMYka7
	 1+/WU3W8dD8rbU1nmaQ2KqBHtFsCkSuNKmSJWe32+F746jLtH552mMZNap8XH1nCgcoNU
	 QYZ803wdfaYgLRhURW1fkKGn/25z/As5eveU3iRVewtSUf88saBB5i/6hN7aMAoi5pMYc
	 r0vWU4b9Bi4eZJBNuzWe/HnIZoGEjuFVBypUpsZ7Tjv9zwGXIafgmhM08oU17Zz+SmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=OxV0SimhmhReHgC4eTwl93r/jvAWe8utVYyKwcYD2AM=;
	b=VKOb0V+fRjRcdPQAlpqxS8yAirRe1hO07/UjtjH2fJ/lY1rIDgCidRp+Vsm12hnrzBgs
	 Xky1K71WDWn2kM17QSU+bUDfxrfbY84ZyxFzGngATwW3JfJYl4uctDPRxtd99KeWAiTIJ
	 geKiw1+EunVpsRwuqWx6DqaAhYbEVMuBvnCsmA/RRFx5WFKej8bKOEg2n7VSw//O82hGd
	 RGBZdSKW1w+FXA8WK0HmY4NXQIMaNqXTiklepHf2/bjo0JniF7jeSnAXQ2EfV81OuVuyG
	 mqIIgfFOYaIoPwoNuf2JsANioNqzbW/o2kzu+rwB340CEKzKftUI2mD4GZbf7E2WZtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G1L8prQZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59E606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD59E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G1L8prQZ
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so4234a12.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 19:58:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794283111; cv=none;
        d=google.com; s=arc-20260327;
        b=bWaIwa3gyUKmgJicS3j73vwsXn1kJmB/0LUU9gxiytRfpIA8BtlEaMqtzz78PJFWTr
         NQQxwg0lvKYHkZCIEuJXQqf4VHKJ9AwDIr5ZuCQm2jgaCDAmeSt7zm69qvdrUXsrpU+n
         I88IDIJZrWINlWUfvZInW+dGLkHDSJHCNkWT0eE0QBzncOGX+uqEHzoObDkzP4hh3Vt0
         P0xeL97uOP6JTcGUFa4J/c0n6mYTmRORpYWfGj+4EfYCbMSyjhnWTq8+ZfkhZEAWdT6p
         NiI6B6If1IbUYcPAddrQ7ZGVlLN29pcGmwwKIQ8c0lpenHVXYLnVFn8zCLoJQ9l6Ox1j
         k7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=OxV0SimhmhReHgC4eTwl93r/jvAWe8utVYyKwcYD2AM=;
        fh=+rHjWezOva6hWxdz7pXoZHUTeCwBe3guXNNSn/ox1Ls=;
        b=hCQFmVEVoBMETct7WHsZWbTku1YQC9t9rSisTHxNy612OFHslCAH0d0jkXAIxLpz+5
         Voa/0Mxxb80ffglaidTJDEjT/7QCHvHsnU5JyABESVp2kjDOm9LrfSsWKJ0D1MoTwLCn
         Sswhl4xENfh0alp2vCggCaHUOt4WvABcip+8K5SWLJlQE2o/9JlW+bAWsZeYwkydDWfC
         RHwu0fLA7Rh+NdKHtjuzgHzUodSsMMgLElmSqOzL8T7nUmXQXvJM6zj4yDb4LxNjb6tP
         yZsNZNTsZ4dDLyPEukzM+gDWJaM9sqAJjvi678cIsmwWbUofY9jJ4Na6krIiI5hnWMHj
         4mxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283111; x=1794887911; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OxV0SimhmhReHgC4eTwl93r/jvAWe8utVYyKwcYD2AM=;
        b=G1L8prQZG6n8HpDgO7/QgkBXn3UmHUOtvcIJaXBCh0VKF50s+1zxcxAXcN2NcjfYwH
         7/ai5AP/986H2N+HXhRzuvud939gl/5f0Q8mFOE9zgokSdkkdJFjMqts3+sbn3vft/3T
         hn/YC052EnajoI54zzk5EoEI9SHKU9GErXT1kR1SNDdUjp8vm9Co0bJQ30gofEhwiEAl
         Fg9v22ssPEOYlcR2vDUZoSO+/gtkDMpAggP6/UM25FHASXtNVDAFs3sisg75KmuBzvQJ
         MUW3F2tU+JtGrMlkVZ6if3GN9MOmlp4j+y3QUTLUGzGww18P46yrjNyF1pd5nzAwsIGg
         1v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283111; x=1794887911;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OxV0SimhmhReHgC4eTwl93r/jvAWe8utVYyKwcYD2AM=;
        b=rQhm+nle6JNwLkRrlEJXA+lFkXPmOS5M9lFfOQY3Dpq5P8SKHZuo3pgIz/aLAWUczA
         mMI3Litw6K8gaM3M1bnfq9Ez8yip+aM+eD6q/7JJ4gBCNYblsJNUdwbPj/zUfQVtcls2
         WRHiFeawDMrpn20d+hrAUF8A2WcWyPDHRTAosa4kTTvP7WEks5frgjkLuKc/2K64LB/6
         31gMMdT+08ZafRloTv8fMMLBU2dcfIX2eh65tih1y1DsNhJC/00E7XzTAWwfDBxktbgx
         U9sf8xWRiF3r2T5Ev41kHmJeAVEaC5pXagEZg7m7jeTBqlQpWnqaxCPtohbN9ZfcKa5x
         Ru0w==
X-Forwarded-Encrypted: i=1; AL+hErFFyaeYBVMFOLrwOaUETk9+a1F2X4PdIhvZpt85af6YytrDCZjTb8kqMPFYHn3YfM/NkwY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qvt16/Ml5jO2FgBzZSAm1GqEf0P0thchsY2so1VdMUrDA6LaY
	SbhASCSD8X25hZKhOlgS7gbVbL/Jeh3Jg87+G+yire6IoRCYIjaUbDMIFumOh600mdwtNJYzCSV
	1IjCUHPRmoM/6lloJql5RFb+c6W5Fys0GhODNotbj
X-Gm-Gg: AYBFou1E0JfLaGyz3Whg+4rxBo3zEIbEiVZZYrNRYJEL0Snw1Xee3MGQ/kbRWZMOJyp
	P1LDlp2IhOAZqYBSGu9JEpTD700L3Q8AtAyBK5eu6NMTD3Et1GxKaMCC9PiAd8Tg1Po/c2BekO8
	xB9CWYFudu0GQf2GlW9zGThED2xbPsa2KFgY+67hYxfUgDeABb/4NknGLxmBebbSnwl5crX3/zz
	fUG4WZj4Dqt2jBBOdbdVLU2dULBMJRRV19vlNEALfjEoVZqrQ8agYJk9KBqTxoSof9/oZLLGvPj
	s+wQFUn7Rg7Qabe5NRRe9iaUPuhu0vWwvAScpNOGCDIRoQIE3aVz5F5ou/DCXp8uNxjbJJIhYGO
	Kfgs/9hlyhMjVmFMpUxnRH2NcCp/n2UyK7piV14G1MfLe3f+VbT55K+ISbjCp+iF9e5SGD3udyi
	On/C5Cax8Hig==
X-Received: by 2002:aa7:df12:0:b0:6b3:b648:314d with SMTP id
 4fb4d7f45d1cf-6b757845f4dmr38915a12.6.1794283110477; Mon, 09 Nov 2026
 19:58:30 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 19:58:29 -0800
In-Reply-To: <xmqqse1d9ryw.fsf@gitster.g>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com> <xmqqse1d9ryw.fsf@gitster.g>
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
Date: Mon, 9 Nov 2026 19:58:29 -0800
X-Gm-Features: AclHuK87BdE2_FlzMxmfBkZt2YRxH3WG37lyy_16jpAQVksm1CROto_sA7cyXFk
Message-ID: <CAF+mdifT3HAw-EvSqUxQ2si6a8j+Cmj0Sri6Z1t+SWPMBXe1wA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] http: exponential backoff, configurable status
 codes, and post_rpc() retries
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> We usually do not structure our topics this way, to first implement
> one decision (i.e., "waiting 0 is the right thing to do") and then
> change the decision in the middle of the topic (i.e., "no, hammering
> the server immediately is a mistake, so let's give it the initial
> wait of 10 seconds").
>
> This might make it easier to later switch it to 30 seconds if we
> wanted to, by identifying exact places that needs to be updated?
>
> I dunno.  brian, what do you think?

I kept 5/5 separate to isolate changing the existing 0s default from
640657ffd0. Happy to go either way:

- Leave v3 as is (with 5/5 as a separate commit).
- Fold 5/5 into Patch 2 in a v4.

Thanks!
