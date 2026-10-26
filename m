Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016651;
	b=0r5XXxAcT9DyCuwImzk1NRSoSJGnnNXH9A+XxWRqUxFEQZECJy2KjGiWeYgC9TNFphH2
	 OP1mwiGQQKUkniSghdbL4HmCz7Hmf5gAmsfRwzAiNVpFE9PK2RRM4l1OAFFI/fE2hYpfl
	 ZBUjo1fJR90sRY8/+1ayYcvvH+k6Dqz3VZZ+aFhpmRF0Qkg8YrkgI5jdcb1QAWy8ciLfp
	 yegHZedYEXNtlpCkRzArWl2Wn4VX17vJ2tMQNjDmvDMZlYdEm+g7xK2hJC5t7v0FtgOeL
	 GSwKHxL7NF9llJxIMMD4hChhlp0z5HhXroN4YUlU6BI9fRbQADCEg4GeB5CMmSPdiKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016651;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=CLho6H7ajEsl1MPpB61rfq/Xb/MXAq5rQCiPCPrQMPU=;
	b=WQy72Vxs7eouLUFE2IkGIn7dXKueyPTqQhGwT8q0XT1Es29kaxF8gi7EV2GhfFg8hUtl
	 TzpiszoZIeG14VCKDAkdPGuQ5OOxVwY2bTAtt/TpZnFQsqUQ/VGQrxPwEZqfoTVVdH9vZ
	 50nzx0hY0OCeaw5ZLIOzZHyqOdcu5nI42abh3wmcwBKQh0tfxSfvEkpac1/w1ScMAYLBJ
	 4V+XnW9nt3kLbdraLDkKYWrU1K0KHg98gOhvVCmDaqsivQD1/Y7p71W1ZkQBujkcLHr7+
	 4r75AucL/YyGQmhk2MbtCnlLLL0cM8M/D1Zwqf+qacn1cYQM9jJ+jf5pofKn/nosuMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=wBq+0j0Q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xntihKN6;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EE606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D3EE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=wBq+0j0Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xntihKN6
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C76F1400A1C
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:10:50 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 08:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793016650;
	 x=1793103050; bh=CLho6H7ajEsl1MPpB61rfq/Xb/MXAq5rQCiPCPrQMPU=; b=
	wBq+0j0QQUH7PbmWArevbLKiHP62dxOgwcPZSeyP0w5SSjLPaRCNeraPtMCMfPms
	1bxqk0QxZu5X+XdAG9LMYJoQ1z5VkVDCjaAe925kD67ILXJNqzh3REdIfEqiiD+G
	YBcgGW/me1S9Q5gfU5NbEz9nCUDu1epsz/xJpSEJcH1CqAcVM59zJWLR07NWhfYh
	0GYU+kzAugnxjiYGkoh4execx7jPJk8FdDzBUiXBD+F4JSM67N6zFVtZNx6NYmDm
	pjYrLi3ILr24xElb+7JL7ninJU0oJix6TYKll1FTrGYQF7GqF0Cw4zOT4LrviTnC
	ny9fFxQHntfIp8o11Nz8dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793016650; x=
	1793103050; bh=CLho6H7ajEsl1MPpB61rfq/Xb/MXAq5rQCiPCPrQMPU=; b=x
	ntihKN6N+bYN/zEXpcHdi0D4fSJ2j04SWvhjGCuljaVjVMSENR+tB+ULZMtiZV5o
	goP+/Amq2enUC9cj4YeAHQ9i5Un2/h2V8ckHbVEfUVLjzT9kVeOgJoRftPNiM8YV
	AjNtqE4ItkQyQkaoRtOBL5XhS5NdoZRi7yrTniz7AdA33lGHu7Ft/r1tuKfxkyMu
	fxrnn93UEs301Co3BsO4ifSaEhrfD6Djy4iCsDPFqfPx2tIASca9ex/6Br64KYF8
	f6fmtV1BeE7TWDdfQtlyWzA2czvYILrQW9Kz1haxPKMCp4/NOdxjACtrfLRiZttN
	jKgNKkCUBcydqv3C8rHyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793016650; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:e6I1RtD6oG1nNLDStVdiQ/RWIhV9RstCbdQONJc1/gmSRNi
	NeYqkOJiq4j58mh3zvqAB3pr8LG7VU0WTDaK/ltfrBWW4DXVBB71e3LBhASwyydX
	E8I2M+ro9oVFhZUNSZ4CwMotN5Jk/F8m4kxK2f9ZjLmch3dINgVQB/D3hTlGzH+C
	P08WiV3XvjBf/h2R+15BrGWFCaXVQ4Y6AbfpWqBSrVRR+8uQVyRtMGx+lR89mh46
	RgHllXE4tSnLIp3wP7OQDedcgMw597Xg4BwPnjXO/KbVUUBCXVUAizs3Bx8MPf5n
	bff5R3oXk+WwVze4Tr9L10D5e5sY1HzXk0TKSaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5YvIBVaE4RwdVgYlzDqMDHaJRTyE8Wko0eKcMK31wLU=:vlKxeL5Xm8YIv2iF/MNdI2yvxzoxgbgP+v2oYcqBYu8=;
X-ME-Sender: <xms:SkPfalyfzoq_ykpQVEsLtt4gk_BOx0yuvYmgX-kT56bH5_E-HzjXQg>
    <xme:SkPfagFWhUltI9jFKLqxKkXoIKV-xdJ56mQv-eSatsmLM5N2QwAMF9HUX1v_Ku9vc
    YU7wKrp3WoGfjFrTVqUDfhYoE3-CcAw9zyT7WN9ohMdHEOIRfuS-Ff-8w>
X-ME-Proxy-Cause: dmFkZTF45r4azfEe+JjJLGHh4zGFTJslZstEiL3hYEWfeT9YzttrmTrOS6GvCLjSARkgea
    motbjDmqZ1icBySbr5qSJvSwHlBYuBq+dF110392sh68CSwc8XpMJ4GEE7PGhPgmA6QQKi
    7G0MvQHITiIelTqXypLOSw+WLQqC37GcQE0afkYMqgNU2kcHI0Y2bdznQFjjqqVUxzSgqz
    upEY9JMQD9MYtpsA9UN2a6od5yMr1Pq45U3SkyHUt07VOL0qkM83LGCKo0BbPFQ6ZXXENz
    EY8zBSJgG1lYHJvDyDainbkQrgIBDxiErk6GEp0vErcmICxAqfFcPCA0N8t10vXHFdsyn2
    Vuwqn2MvaNdMgA307vV4gOD8maFVlyFGkQSn7uc5/wnd62hs0rJOlnjbkmFQ8F4msJ0M0Y
    IN3QtwMRbO8tNTSsJ5r4LrauOH6mSIxGczgSjBOEf3ZLKRkUCpLIvIImwWE/zvnM+dpPcx
    fn+hZyt3L/jIKBMUxz0IY032mPy6zlPxQK/k8IVRg02tMqtJdjkv+TRKITl1kLYIWO0YMH
    zQr5s8VD1xFusNLoRDELmuHQe0sE5mBhMcAYsFQkkEbfBrQDLa2mZ2POMJGEumC29aT/l4
    l8WrMmWQ7m1J5PXl21DDsvZLG8Jzz2qyhlUvs627q3N5FEoq5fOTIZF3IRJg
X-ME-Proxy: <xmx:SkPfakZ1LENRDoggyHY1JwW8U15W0IQ7zfsw8kbj2eoOLGLlXPUFww>
    <xmx:SkPfatPg8jQsA3fzL2LpOYXLxDSu5NHMQMInhKkFWVujjPxdkEciYw>
    <xmx:SkPfapaBLKtdy8jBx5bEEpYiAMelZHdH7EyGIDNauGP5ocmSXGA8-A>
    <xmx:SkPfar0-PrdtffBj650DvUuV65REsesmpE2LINKVpG4WNHfQfG8uHA>
    <xmx:SkPfatJSJJ2GX2_2D_PpItmwbrn8D90nB13Be8AjXZvEZ20HyAdI9Qu0>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0B086782738; Mon, 26 Oct 2026 08:10:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AqO-TNe5d1d7
Date: Mon, 26 Oct 2026 08:10:29 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Tuomas Ahola" <taahol@utu.fi>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <85254bd4-19a1-4ce5-b61a-dd3057389c36@app.fastmail.com>
In-Reply-To: <20261026110008.Rixj1%taahol@utu.fi>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <20261006055002.M9X9O%taahol@utu.fi>
 <26a10538-525f-4160-8719-b82968c39261@app.fastmail.com>
 <20261026110008.Rixj1%taahol@utu.fi>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Oct 26, 2026, at 7:00 AM, Tuomas Ahola wrote:
> "Julia Evans" <julia@jvns.ca> wrote:
>
>> 
>> > $ git diff je/doc-remove-gittutorial-2@{1} je/doc-remove-gittutorial-2 
>> > -- ':!po/'
>> > diff --git a/command-list.txt b/command-list.txt
>> > index 5c649c882e..63ae2a67c9 100644
>> > --- a/command-list.txt
>> > +++ b/command-list.txt
>> > @@ -244,6 +244,7 @@ gitrepository-layout                    
>> > userinterfaces
>> >  gitrevisions                            userinterfaces
>> >  gitsubmodules                           guide
>> >  gittutorial                             guide
>> > +gittutorial-2                           guide
>> >  gitweb                                  ancillaryinterrogators
>> >  gitworkflows                            guide
>> >  scalar                                  mainporcelain
>> >
>> >
>> > That, as can be guessed, causes git(1) to advertize this "obsolete tutorial".
>> > Perhaps we would like to avoid that.
>> 
>> Agreed that we shouldn't advertise an obsolete tutorial. 
>> I'll remove it from `command-list.txt` on my branch and submit a v3.
>
> Just a friendly *ping*. :-)

Oh, after I wrote that I realized that gittutorial-2 is actually already removed
from. command-list.txt on my branch. 

Or at least that's what I see when I look at the version of this branch in
Junio's repo. So I'm not totally sure what the next step is here.

$ git show junio/je/doc-remove-gittutorial-2:command-list.txt | grep tutorial
gitcore-tutorial                        guide
gittutorial                             guide

> --Tuomas
