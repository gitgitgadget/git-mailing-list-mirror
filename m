Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376027;
	b=P5qOAX6kmnUW4EyS4HeJOifvQrwPJc8cPVsOdsojV2uV1FWcWJjowyi9hkzpyAtkeSVz
	 31IFb6IiE/ZD3E0VcLZtxj5QjriUKdbrIELfD+MS6001Umis/1z674xGB92GZxAE+/B3W
	 L8wUaRFuE05f899TJsz3SAAJ2sA8X99TNAhSuFbTF9cZFqOI2P08QtzzMsilfUi7+9Sr2
	 sPlUwlhVw1aBDBtN06QMr/sTegKlQjpIGntj9ampZPw7UspYCGdK4YGEh1RZgvZR8qgwr
	 fc/Q5Hd68jrKp1rand5vjTy690YwTxoIwA+H366WjDV9R021IhIzB7ww7E1S1AgSPBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376027;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+M0Rf40lD90J6NLVEvBx8Eti6gHqZT9qX2E1VYO/828=;
	b=jAgSFuZpnBG+usC7ERdOF7ACcIVsdkMZ2w1eHZEhrfnf0g3qaS1p6VfYMM4HiWr/ISBP
	 1OU22mnevpokzmfzQF5Ke2PfWYgAS7Ak7IIIRginAElpYq9iLPYFLpyFKko4Y0wBO9g4u
	 58vh3QuP5QuT69YCSxQxiCCLMCAbHCpzpl030oB489hKo+xGoTYTyyiEelK8YjPN+SCbL
	 RAs/AjSrXnw2VqEkUxPloqnuapRC8osDzqObGlnXgmycJ9YCYtQvrp4s8C9vEg7bxl2aA
	 hOWHAvijnqavsEodjkRuerzSvOcv3gyJ/oO1xQtW0nhNxu04R9YyExSeQieA+5UUV6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SfzqZSgP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MAjZ4UPC;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9B606A31D
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 19:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D9B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SfzqZSgP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MAjZ4UPC
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E4FF14001F8
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:33:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 22 Nov 2026 14:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795376026; x=1795462426; bh=+M0Rf40lD9
	0J6NLVEvBx8Eti6gHqZT9qX2E1VYO/828=; b=SfzqZSgPuoEnZAZwQ65xlqLCK6
	9YgxVSs2ET8iBgavznQ3XnUps3hBW4reTD3smj8Jvnj3hPw2YyNGzeN2SRKnpv4M
	32phC3CpXWeQkQmLdxPdeW6hn6FNi/lgwKxYd9Dt0b7FPAY0tpwmiltgyCUSK2Ud
	mSI75Ea6OzTVdc1IpckAB6BsifD8Y81PldSlRjTStSQGr1ArBU4wYQVbG/u9rTIp
	9hLPa2msMO5aaG2GuJVC+qKZugF3Zf7KNzk45UOWFAGPiVN1KbXZLSEuS/eUg1tA
	PtfBB8Um+UBFQyPNafxjKnCILeCak9X6WcQJ7QGsDjLnyDo0MoBBu8/Wxscw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795376026; x=1795462426; bh=+M0Rf40lD90J6NLVEvBx8Eti6gHqZT9qX2E
	1VYO/828=; b=MAjZ4UPCSDa9Ed0TbDsjXKKQqakHgarmPShcSp/RHnfE5gepLR7
	ii79wSKq5GcToZbSPI0EUJ6gd/6fRFGK6HdXFV+uIfGP3mPn+Ffru9IxQVzj4a1n
	hFUDonT1tNdyuvqwhXKHBopE3ZuOrMMv8UR+y96ClssR1gdBTjvqRkS5KtKB/FbI
	EWQ5pYxYmUDOuimTGUbo5IrwsBoRT7WSC5pd+OPN3eP0V1Y32Zw8X9wiRv3zstg1
	LcucAQut0c2qCHKqBFJIOaX1HsgEsqwHQnaV9FxY0BF+jud3q+u1Fknw0lYeiLzi
	wqGuQ8tjBq7cpKhqTzETQZhdvoLyOTNH/cQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795376026; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EK29e72ZH5MLv9lzr6yR5RChHYbPzzO7Vl5Va+UtZQ/sWbW
	4gnwyGTp7/ZZMbUCKo/Pwf0RvJEVckT71QHqZIBO1ppt0b5Fkmz95RukO/POqXdH
	0MvByUCck3jpU+sOJyfC8PiUjRR5f97D6ZBlsG/WQp3CWKwtUk/11+AIB9P6j4h6
	qGByGGCEvXozS8Zgv5oHSPJIbOOG4wQEybiSMZ9PrFNRreF/cA0l/gLwmoHbUqBf
	sCLW1tFKTqRAddoAjvBqaT+o1Gbchj1Xjf3hc6d8BRGa8WIgaxjymYBv9saG1Mz7
	BbbnL6QHvYk5+MdSdErkH9pa5hXa+NIWoIDX3Bg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:p5sd277ynbmYGPN1uNFr7r+gjnZS4i8J+loVrIqEdr0=:rDRcQ2wKjgQCAc+2TMWV9+5v8gnvAIPWNozsBbmKEzU=;
X-ME-Sender: <xms:mkMDa3fxClGD4Bd0qMvSI7GCF7FJwYUJESNdmWkr_tNerwP2LQ_U9w>
    <xme:mkMDa0Ggej2zwbtnT7Xk-1ndD17iH16UP8B2UPugKstHsM9Pd4LexSLOUH616jDaI
    4bFWu_NVoivBESupzsBV-rk8kt21igBZ7ebs4rka1Sj_NzJOxKlecY>
X-ME-Received: <xmr:mkMDa400LxbEqSwurLAP97gAsiHajPAiZavYV_p0Jhxyom1jxiT5pT9VVKfUDjO3N-N-2aWtoj6VhVsHE8hUOwAaQRLqb3YZjYRz29I>
X-ME-Proxy-Cause: dmFkZTGpc1fBq1tGEhxqdhMadp7N6EemzmqVkGEY/I/hngJqYzQJ0kJWfgY/6piVCPLhT0
    NYSg4ksvz6JQtXWE2s65sNbQjQt+Qv8FNlhmt0+85Bi70TBF35DYlHK/n5UyPhPMbRgL8W
    GN5FhXPBS7dYmSDJ+GkKravRYaxL9GQMhwt9BvDUCPP4Z2yYuZqbhe7gD9gNCAJN2iYJTA
    /OeQ17S8dWpv7VhKG6Kp2OjCBH0CZASgqD5FazwIW6G4d40ckW+lcH2phB5OrXIGoybdei
    A5Ilzn8pzRwpcvBSXnjw3/bDH400OFPHtG+3xBhe1JR9T1ZIvR4UcoXJH60Eb4NK3YujXJ
    AEpVrJoFdQAdju3ShvlQPVho8ERzCnx6UyvOhf2JKSQPKUZqGonjeJmYH70/kaBvh4KQP9
    d3hGCEv9dbhcGBOmp2tQwWmV/dGX7AWkxzOlGjCvxDDp+zzPWX0rt+EWssMzR/xKaWw8xd
    LYo3BdOeHI9Ek+MDQq/7eJnaqL3KBO88UfqfpekLqFhRz9V8LS2rTeU2NkSRoLGUOLAYhR
    z22MiV9Ea2fx8fqWKJm/MDX9bU4bE1QdC1R5UgBTXCDC7EcDeCsocRIF18ok8Hl0Q4SqaP
    EvdSh2sZZjvuJzeNcKckvEZJwQY/bLbds12hXDRf1vk/9ydV+9HB4C7NrGKw
X-ME-Proxy: <xmx:mkMDa0k47Rh9AOeGt665gQRfwyA_JUB039qWRqCJn2QnKJlJ4yDDCQ>
    <xmx:mkMDaw9K9CNK__Ujq8KONKnXXBrjDE5aYQ5nlAHK_NCMOTz0XGG-Nw>
    <xmx:mkMDaxpcXRUg3gK3XbrrJfw5dAd_mJARb6UmzeahIObiLk6mW76pOA>
    <xmx:mkMDaxnbsMPI2HrfJCumCfbWYQsasuaiv0I_EbJ2ykzXmlXFrut6Cw>
    <xmx:mkMDay9sVIsUCKkP7P-4iEn5YM-YrSfa871lR_Y-Q986YUq3bCvS5k8t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 14:33:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ophir Bleicher <ophirble@gmail.com>
Subject: Re: [PATCH] lazyload: fix typo in comment
In-Reply-To: <97cb053a-07a2-c840-c8c6-d1455b282580@gmx.de> (Johannes
	Schindelin's message of "Sat, 21 Nov 2026 17:04:10 +0100 (CET)")
References: <pull.2497.git.git.1795275842564.gitgitgadget@gmail.com>
	<97cb053a-07a2-c840-c8c6-d1455b282580@gmx.de>
Date: Sun, 22 Nov 2026 11:33:44 -0800
Message-ID: <xmqqmrr0k6ef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> parentheses:
>> 
>> return error("Could not find CreateHardLinkW() function";
>> 
>> There isn't any closing ')'.
>
> Yes, this was incorrect, and your fix is much appreciated.
>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Looks good.

Will pick-up, and mark the topic as ready for 'next'.
Thanks for writing and reviewing, both of you.
