Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575396;
	b=yoRLRI0MfLlXSEqXAIx8LrTD7NsHZ5TyaR1N+/kFubkHQ6anwQD5BgY8iv94+OtAgay+
	 /Q81UAZS+tmGkU2+CiV49AR2U5jYGQCMwkiEkevN8m35OxFMvhTEzIJrHZm4GOhIV/G85
	 QkNxSIOuRf+Xnp5yIBywcXr54N5Xdfdy9v63O5sLXMpuiBEOEMtJydwXqIuqn3cQEt1mb
	 IQaQmPpNvvqDVNpdacf4Tz9R2MvZvrR1LZr10Vkr4QenKi0ixu+Sc0H2Xvi8N5596Gulw
	 YpKJvtiz9Cd8zzCBGT2Swq1FNyuEOpllk0FLcgv0l4J+po9A0xsFCPM8/PiR+4zKBtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575396;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cc67zbMQvCgydRZ2d9hKkq+s2phxWAgxHBJm9ktikv0=;
	b=WUNOpLcl7hCZR+9j1ezozkCkskhyySrkafzBBaojlnJhE5CAXW5l20TXN2+yjYdJ+fsP
	 r4QT1IRXVrls8Uyskn8B30OWB0a+OM4HZy0JDlE7VmLYe1J7+5F99rSBEUu1rgF5oUl8x
	 vr6BXelaYjijbH753o1XpkVPaohyfZaWEGP3BkS+Nx4+WA+CuUcu2WEqT0XsjR8G30dPN
	 q6Kbxf71MvB9RbAwz0LNujrajWbZK4TnyDKcIx+ezqVFNbVCY6CW18mOffU/lr52FJ5jW
	 jC+A2/xXuQpmMpJ9Qa0bR04Ew0gmtJ9Yx8+C6l0stYEX8Ko962ghFAP3526SWRoGHZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=PN9vdKde;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qj3IzQsF;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08141606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 09:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08141606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=PN9vdKde;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qj3IzQsF
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 59D3E1D00138
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:36:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 05:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792575395; x=1792661795; bh=cc67zbMQvC
	gydRZ2d9hKkq+s2phxWAgxHBJm9ktikv0=; b=PN9vdKde0bOVxz7Ql3E7HZ6Hc9
	7qvCYuDP1WvXo23JoMDMdy4nzCUU/TAeY1HskBpy8MpOq4pQfa6pcIwWEdU7vLMr
	mX6TSHQGYeiu8JF7srmz3h4h8vwlCVnd4n7sz9toNlHaHy7pN9kfyE3bKyk64/J2
	u5erqXawRwOrHFUP+8udCMZbc0yPjsvSZdqAMy1isnsWY53ID31li9AKP/EY+nnN
	/S03cvEUR/15fcdLVAwIbhC0G9BRNVe7VrSM3Wb2iX1VlLTRdozcAXmnWav6fseP
	+XZbYngx8hFXZcGBjydmbqIKCPH8l8p1yRcurivvKF0GGgwLIBbLb5fqSHuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792575395; x=1792661795; bh=cc67zbMQvCgydRZ2d9hKkq+s2phxWAgxHBJ
	m9ktikv0=; b=qj3IzQsFvgDLr+zLwhFQNAsXaCD81BV8cmj0edx2D4/1dSHv4oA
	6mD58REgimq3LZt8dXiKXNlRwgJ6NCXRnHBwbrBsd9UwsJz/BwxEyN3XYVEk7u/0
	fSyUvXSDewHqUKYP1nxJNOeYRePR7idVxeSNeR1/CJI0YeMHrkdhwmSXTNlaxehq
	ljateXeqDDJP43G7lRD4G9jq5GXUhF1AFd0ckK1rtFfuYeK8eGrHRj1vSlg4nMrL
	b6J8oVET0rlQjUAmSGJvnW3laYytOt4Ef58iyI9CL5EK68V5MYk6pTrmGPl6tu/x
	M5w2TNZjbucJ4JCV/HaXPHhK6iS8a7YzVTg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792575395; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MTgDIyvT+tmf+w4Btz/hSo4NhnUBYp4Fcpfa8iRDrO7yrfs
	e9aZEWxgHS71T1x2LoC0uELq0QdXQOA/WsBmDpiU2cBiYHplENcgeNcN+R1tQeKT
	Wni8I0hn0Zb7nmhA1NLryU45OXibzEAAXXlgjdqVQhw15YvXkZCkr5q7dkEklYmN
	AxL/iERCr1VUc8446hV69N2kwFW8T9GxMR73PXY+YkLAlEq4oOMWsCUIFdg/6o8Y
	GLm3rzRNZEjIz6q7PJnFWFVcamod8mQJKZ5ugtGvujH2t/nI5lLlJvZBjomofV/X
	G2BPXwjhHrNOIqlIof+LRp5DJQ316PRZtY9PZCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VfLwTm7ljC+I8e0Na/Rh3GxojNrER2D2OYQkg4ZUvsU=:hAHDPFIcHP9XStoPeNcIodHfiANrHLxKjz5HAURYUGM=;
X-ME-Sender: <xms:o4fYaoNXANvCbPYXL96l5rdKc6soJMN0UWMyD23XaAM7wpHG6sxXjg>
    <xme:o4fYambsWoZc3HFt0gxCFuSaEQ_uEUHkngJaGObjUwy8L321Eb6zxUjH1n-MRfiw_
    tFB5DKosCQPve_hwzvS50198YNtSfqXvqRtJN53peihswzQNE-93is>
X-ME-Received: <xmr:o4fYaspToHsXhvnR0BD08hlGSExWOnCR8fS4edEW2hyuxO-8xYE6kA>
X-ME-Proxy-Cause: dmFkZTGrcKuFuknrOI9MqTaoJK+M6Kw7dRaBR/GCEvkzZCTOgezONfcLFeQZmfj11WUorH
    PjQEhuik0UnHAB77YkbS3+c5pcXhGDDGLeqCO0lcGTVGiVRdgkWQ/irgXe48xdmn5QjmG7
    3R5sdyxQxa9X9ECpI7AUOXnZXsCLBF/KwCBwnGBwq7BoSmePxJgbbuDmEKDvfLbNHopOIU
    rB8YlWy//OK69RAcgv2dQWxXCvYfLqwm2Lh+y/B84bvORx9vdphLwfvGDfAPAuPpIrv/KH
    1Qs1+O4Ye+5tHyE3EJcPOzDO5eKRY32bGU2MwJIQpT1E/oKPFnnGVUUzM/SWsZHuo5EZmg
    SNwvkIyT8bbmu6TCVgIlo1nvCz16rJqpbxRr0YgVKbtDcFM17R8sEUnhSp5mv6G5W/WLNl
    xIkB5cnc2qGT88MTh5TVnHETT0Jy5g75WtpvIGC8NpMLE12aJDAVr+3ktF16jUUgalvava
    fPn6FCGEaKMMTu5XQ+wG2/QBSd5CuOXXWMdF5QO6zOwQ8NWyApyiPGPtcZRn65Qe7Rhw6E
    g41WDWgm4IVmL9kbTnxxzuZev3OEndcgISeF951Z98APIRx2cFc8Yq6VpcJ5vqAv2/5SOw
    qA3RtZ0vxyUB2l2Xp+JZ3HFg4/1E2OlsBRD6OCbRtIwOivBxPFlMMGtwNMZQ
X-ME-Proxy: <xmx:o4fYaqasjQGSFnZ6dCNpGw8p-QVxDDWrznAw_Fii9qTHRNzNjXBCwA>
    <xmx:o4fYakQi2XnSZv83JBaClaIAXzP4WyKrmI7NC4WDawc1fkJ7Ee2arg>
    <xmx:o4fYah4wfo_Mq_pzcrxWR_7BZ93bwMyq7ub5Sb4uRra892VgM9o0Vg>
    <xmx:o4fYapx6cEUhuqspl8bhBLN2U1JcGoXs0W9OHNjrrplLgNmO0YHR3Q>
    <xmx:o4fYag2bjKrCyvY51sq-sLQsEaOFl_TAoWDUu1QncLmLcw67bi8iquR1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 05:36:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba98a352 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 09:36:32 +0000 (UTC)
Date: Wed, 21 Oct 2026 11:36:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] imap-send: accept messages with Subject before
 Date
Message-ID: <atiHnUoDf-_h50V2@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com>
 <c42827a1225e49db2e0855638e4e76a06f7d9eba.1792566469.git.gitgitgadget@gmail.com>
 <ath23vYy0n8UFLUB@pks.im>
 <CAHwyqnUwbq3XkLajsurk=X_=s3a8Z85Ai2raVmpsxK8HavfwZw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHwyqnUwbq3XkLajsurk=X_=s3a8Z85Ai2raVmpsxK8HavfwZw@mail.gmail.com>

On Wed, Oct 21, 2026 at 10:45:42AM +0200, Harald Nordgren wrote:
> > > @@ -2863,4 +2863,39 @@ test_expect_success $PREREQ '--compose handles to headers' '
> > >       test_cmp expect msgtxt2.to
> > >  '
> > >
> > > +test_expect_success $PREREQ 'imap-send accepts a sent patch from the list archive' '
> >
> > Quite weird that every single test carries this prerequisite. Makes me
> > wonder why we don't just skip all tests at once.
> 
> What do you mean here, do you want to remove the tests?

No, I rather think that we should have this at the beginning of the test
file:

        if ! test_have_prereq PERL
        then
        	skip_all='skipping send-email tests; Perl not available'
        	test_done
        fi

Then we can drop the $PREREQ from all tests. But I just spotted that we
do some more gymanstics with another prereq that we optionally add
later, so this doesn't quite work as-is.

Overall though this is fine, we don't have to fix it as part of this
patch series.

Patrick
