Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606636;
	b=2k3mYrwjLT/sm6R5heyLo2xkY/TqgUakoqfYYulXdoMbbxPVnqDsa8C9y5ujmUbQ0OGz
	 aL575Vn+lQAR5XbY6pZwvd5gG3v3MFYAAN+B8jfv8Us9Mpr88yQekO20n+NzXZG0Nja46
	 Eg/01EG3QRiyxfFIPwuo4MUPREiPEoUPghEn/an7mKWn/+SY9AURFgS+eIxEsMeSyJXR+
	 7gAcqzV/CVEmbIJF3Os8tXUVS5VpM/cwtLQguC0BIOYOE5E1tejqXJIlsOuL5+pNSlzss
	 vgvlnAziwCxp68OvK7aObKnebQAVzXQnpwf45egQaLvHHg51qV2WgV6/kk1po6xbR8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606636;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5amngqqdlpfuuEPw41zSD7O6r7ZOsnwGlyMIhR3tQxM=;
	b=wAco7+UHKG3W7WD0J4Mm0BiZB6WQd3Ny8CwAd/cL5gzNqgysmZOwYy0OUjiq5ltVb4cw
	 aSQvhWaYCX2nDlUNA3bjm75XqeSr5rGH5hpd5T1ZsjDNglQDZByPNaKsDN/AwyRtg+Huo
	 /YamuKINmlK8WDP+qG9Qc99/cWyCfMUF6x/mg5IAsAIK2BfhS57jRQJ/oq4u4suEe7J3g
	 dZtv9ocyJcJKn/Zo/ZuEKyRaEesWggO8VMsNYSKqwOYfjDYKdsFWygi8Zb73wxwEdNvcY
	 AmnjOSSmUSgyuRA8oLQeNclgcW6cHLSKjO0UPGNP2XPIEkmg1a67TixUS+E1GjJm/ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=iEGoEsQ0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=x1RRO9ID;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04041606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04041606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=iEGoEsQ0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=x1RRO9ID
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1BDAD1D00089
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:17:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 14:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792606634; x=1792693034; bh=5amngqqdlp
	fuuEPw41zSD7O6r7ZOsnwGlyMIhR3tQxM=; b=iEGoEsQ0QYGRM+NYo0fm6I+FOn
	GhNoJVfNYdJowQlSWct26qBhzTPnS9Digdom39hLXt+/8RqwUK4aF/5od53EuAn1
	WnxBHIRCY5sigZanYFRp5+ely1hzCTo2GWBj6RvyQGvajXWTdgOdqXiEDXPb/IAM
	vkNJ/p3M2A/Mbdwixx5gMe9hBBYOpShB2AzX/gX1+Sx3ZJG3Zbo4zzmtdqmxxF/x
	0lOL6+rG6nbro4gJCAcju8J7Ks3/k1t7A2tTauWKa8e6jIR99UL1EJhhIz70yNZl
	EJE9bfNkSGXgsdsMpvj4LV5pn4U6q8/ardw62F673VmuksOBAnUl3bd0yW6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792606634; x=1792693034; bh=5amngqqdlpfuuEPw41zSD7O6r7ZOsnwGlyM
	IhR3tQxM=; b=x1RRO9IDR2BboOo9khgmYb/GfSl3/4c0N4rCwsLLu4lY/RI5ejY
	cke031o2cpwRibFqszZn09csqmiaIXauHjRnYHPfm9iJM7IwyB0dTvyn1TOH9T/z
	ghx7s49T5s+8NU2BhTPDBK5Vi59YehvJFBXqGF9uvS9sk8dqxsP/HYsVSUZFlnF3
	nYes7a9NIBgGCWC83ZaGNJPzAk/FQauLHMCQQV4EnsPVvUUx74+qQXJoZzAcLVsa
	KSLhmqRdDt/JvXQYzn5aLS7If3oGqxvdgQWmcTzvc5fzlToGheogJjnMn5szGvCr
	I/rVQMN1wDRucFnC46yK2nhhLPDuGYA6IPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792606634; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:g9Pp5T/OHzh7h+hS8OkAstrWicSNQZY7/dLQZYpTydTILV2
	IV0Cw6nGqID/jIoNJrBtPdWlbn/BMNRw4VCkCClP52qQ7Zs62xbB5NAVs7KBxRnQ
	lgkEYZHK8UOLMcWuxWYtE59XqI1NLNubLa1ATOVkK4jRfdwyYnCpUJFRkpnypOZG
	e2AjT00brVFYyqpcfH2nx6zh9mreuaW6uzXUK5jr8xo5X9BqZkB6Qquuw678qmT3
	s2edfO04PwH9L3AQWe8mOQeZcplNAjUz5yO8OVx+rcE50FspImR9Pbqsi+LQHKZV
	kbcUokfqU92G61rtSTOJc2EBE9+hkelb4vfKJHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bZBEhdue/I+lY9gEesxgdpaRfG5QJMJsUAXlz/sEGw8=:CzHXLJPdkSyuFcMCz/Yt1zvkPoXQhESw1JqOdir9rkI=;
X-ME-Sender: <xms:qgHZamwIXgZFUD5PEY2PKJuGKdV34xRkh5cKjv5u4kKBEdm_hYOfGA>
    <xme:qgHZapuV_E7cIImZdXpy6EVtZYa_JnBOKmxR6S4_mw3EwcCZneCZ8l4iDsOcq2uhk
    dXK0X2q8p3Cy3m9kJyGcizyT4Cdx7STOCiEOmziwP10MFLShNNHBg>
X-ME-Received: <xmr:qgHZalv9VhkR3tlWieVr9rChFG2AInqT3fm4vfvjx5YWAICzR2iP2q0lG3BXe8kJflFG5nD5fS6Ccmb6LnVrCasPLCfFfa8KP6VF>
X-ME-Proxy-Cause: dmFkZTGllSBWHJGO6So2kmKHW5o2/Ea6/DBjDmkKhq2miE+VxAXgWX2S8hwSe+e49Sx4jg
    S+5qvc611XgaN/il36D0zBranspEMyfXwuw7Z9Z4heGkwnXuy8fRtuW0/GSpejvs3TdlMO
    RzJPJqXQYgXCvmqmSADvUJamKHgXWq6YDMs9f43ebOzNmNLExBPgnJ3DgugPGQloYecrH8
    v5dhVeHLVDo6eD+OHlnaoZjpligAp0fOkzHnar/VI34EyoaODewRCJNxughHe6uI8iizoc
    YgPrl0tvgEWVhxF8Lmq2nLaTQEecvFnlrTScF9saLryJhcxCm2inFcTfp5xoyFjcOA4zpA
    X/K20fB7PpB45Q9roN5d+9dci1Fq5rWOPBEdk9r5JBRJnupnwKVrBXfeJmphwwy/STZ4b4
    rX6DaJyPL0/9Gy6w3tUzOOSITUQlgAy7Vk3+lUWVfX5MNZwIP1K4MajLUSQE9w56kNeShg
    FbOXNPAx0zkfp9m9p3jaZXgElSSp6jDymQHeAEDBMtYJA2z3Yxb+eTLYn9ffUgrJ0tfYrU
    a/R43C8hXyjG/cEuOGi9Sn9+RnwYBBprUodEnxJAX2fH+CWfebj6+N9T1GE1AnbnBbLz40
    HT6qDWgaYOJ9UxapRj07Vr/Ys2Gil864jJesBQJJQOMy5JhI/lat1B/BEHwg
X-ME-Proxy: <xmx:qgHZamMlWFSTolXVWfO6Cgh5x5YjuLSNrvCsf_o84XLAmcnCwiBcvA>
    <xmx:qgHZar1YxNZpqMLaP04RERQchcxXtVxV5PKqMt1Gf4rhYWYaUb4g0w>
    <xmx:qgHZaqMXIZhDDJu6pHSNqrGC5rocuvO1YKitshdlRv7xKOO3REwDzA>
    <xmx:qgHZaj2MahNoaYs3jmIej3A7uwYW0UO9enPjconHHScUA6FSkbrX4w>
    <xmx:qgHZah3tsftQo5v-hgKTfLtJXtiMsUpPKCbcS9XnqL96TDm8xK068iuC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 14:17:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5] github-ci: update macos jobs to macos-15
In-Reply-To: <athwcntchANgnJxD@pks.im> (Patrick Steinhardt's message of "Wed,
	21 Oct 2026 09:57:38 +0200")
References: <xmqqfqy5clgz.fsf@gitster.g> <xmqqa4o7sp0j.fsf@gitster.g>
	<athwcntchANgnJxD@pks.im>
Date: Wed, 21 Oct 2026 11:17:12 -0700
Message-ID: <xmqqmrs6or4n.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 20, 2026 at 08:37:00PM -0700, Junio C Hamano wrote:
>> GitHub from <no-reply@github.com> address keeps sending
>> 
>>   Subject: [Action Required] macOS 14 hosted runner image is closing down
>> 
>> and suggests to update to either macos-latest (macos-26) or
>> macos-15.  Use macos-15 for two of the four osx-* jobs, and
>> macos-26 for the other two jobs.  Use explicit version number
>> "26" instead of "latest" so that we can more easily tell the
>> differences and similarities between github-ci and gitlab-ci
>> and compare their outcome on the same commit when needed.
>
> Thanks, this version looks good to me.

Thanks.  I'll retitle "jobs from macos-14" instead as we update some
to 15 and others to 26.
