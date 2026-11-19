Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120110;
	b=GTBNuCCMGl8EueZNbnenyQbrnGcrbnYZ9YsQIbXARcYRzjsWJCubhhaZ8YFqyJd5GMUJ
	 l6ZNbvupysrQV9nOAZ8q9OU6rF5v4npvDROer20sHcm83WzwdzIL4yXMklEMXDZqEWnu8
	 gLEmn1lnUdY/a8UwlKCxoSgtGzZTukzXSHipjEia4Gjm17pAZgt7ManC6nB3pXeoUso4/
	 R4nuUe0jqAiUkvRDY2tTawhihkxczWmwm8mhnEFdulIgKvYYHUbiI3L21v86Suzd4wakP
	 KQOw2M9Aa5zsLuEfcPNehqA0kKqFv9ffyF02sddxYq9yXLW5+Xdh5eDn0zNpd/bdu9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120110;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=FlUo1iOhyEtgckbAS9emBrl8piySYnoGHHrky4weu4U=;
	b=X51la7DwDECRD0KQa3j0QmMHy6cfzCRtMjHiH4pJ3i2T1zOwC7Oz/HkMCIK/dtxNvIyz
	 r7jZY5T3t4IW0DWaUpY7NHdbFiaSaKOr826nNUcuFlCns68hYTYGrmRY/XQkIb0b4WIUL
	 2t9p4CCl0maHGGKTPJSoZdMmEqDa+pkHl4jVeJEZM5qWL2mCd1ciZ3lJWswJhlVNDIGl8
	 h3PEMqvdCFuw+Ix8cnTHM+43TourZwuZJQCcZYOanJHvbTUChxs0OGWpS0kfAoe//BqnH
	 ib8RP0t794QAYIs3nqZMQvLvzTZRjdeAF1r6EQT7tiukpqv4DG4vpNtRxUlPU6aTcTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QSTA53GU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=q+mjuc+j;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721F606A334
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 20:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A721F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QSTA53GU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=q+mjuc+j
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 089877A0341
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:28:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 15:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795120108; x=1795206508; bh=FlUo1iOhyE
	tgckbAS9emBrl8piySYnoGHHrky4weu4U=; b=QSTA53GUI8Kmn2M5wf6jj26jlx
	JV1VJMN0u01MrhwXEWUs1OJDqs5hFEfoWPphsetngCK/eP7RYzENa/AsrgxksGly
	hOWtehML7RhUYatCZdFn1AxjZuLlhRPqtrqAXDMbYQAKSqYJNT6KgKcEE8fO5qiD
	P/2w8cJDKvvg/Q+B1Rkjj+d/7GQswBI5DM5WN1OJoUNSAYQFgKCKtgujcFOjVZ32
	aU1wInPLLXSVRpK7fmLhJaB0gNyHkgv2C1zJwqIFfFCXZz6RW/tTNH4CErPgj1it
	/Xhsu3NUVm65ZUHmdVLrA8OmMmc1tVh+8OQbeXHM0sHIn3sWoJaVD3/rnQgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795120108; x=1795206508; bh=FlUo1iOhyEtgckbAS9emBrl8piySYnoGHHr
	ky4weu4U=; b=q+mjuc+jHQSgR0byMinr+y0BfZxWD9bxwZ56OrKctKhaa4KASKE
	WI/9cGvUqBYhfztpkYLZROGfgA39R+OpmmBv4S2gN+ow7gW5oxvauV3ZXN4homX0
	JyZ8EhIEM9nGvnO5ctuupZOPdz/rzR+tC0a9ctFRs6EnLCUegp/+YpWa3oKzmeir
	5oP12v6VOIT/5m5u/JEU3lRn69RfLs2M/wBuBZQwBd3cH+anx/qtC8I7OE23fJhk
	dllO/LPR1EJqayiRR3yFtosW0BKZMWiziJK126fw0bofPMRjVSToCXL8VXaPKFIE
	eqZx+YjT0700HHP9D7sWut+sUh0frLTk9Dg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795120108; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:neZ37nlaPcHE3tYg22ZPl2W1CN40svKuAkUyN1Aw+D9j5VC
	+grPTBFKRORkGNWJlVbgm3HoiItyDFyEkXcp3gK31Kht0xnDCdyxCTNu4vLsOEq2
	X0vw8PnCUGUNw6gLf6ol1eHB2Gqo1oTujQIeP7Azuf8hpsy/rYa/nA2/evVO+lHr
	Gn/q6GY8Ady7EIZtuq9WY/U86T1Pn+PqIxVNgX8a5d9m+ZcyW/pbKW5C5XU6TdE/
	Un3vlKxx1lfiSOjQNNg99RF6xMXexfoSEHnpzNHwbuB5bcF7/A1f/WCge1dasGp5
	y17cvduqXWhcxWajUl7szEA5IS5Y6qXQuE0qHrQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:fnUUz3RJTMkJbH1CJXnXYCuoSt9ag06BGI+7M3a0Al4=:wJswkxQkR5YssmX2nb6hoQ/L4Cf54ssi4UXbw2Hbgp4=;
X-ME-Sender: <xms:7Fv_atGAwtoVylJtvfU1bZGySN_2DVrHP-CW2XEqZbFQhvRuJXB__Q>
    <xme:7Fv_anRUxfDrCTw0LpjANjmbptTQhmK9QWWQoeZrYJhGOe0R8Cjsfv9xZp_yI7HpZ
    n1QlvTfQ9l8I0qD_sAeHaIl9kwper7hwJe3UKqScFgMsWxkWl2M97U>
X-ME-Received: <xmr:7Fv_ajZdVcJdjG0Ma-Grk0dMqSSymVylNSYGE9z6fAa97r-iHDSkqGCsPZisIIxAXc_iZMKLPbdeiadjqB1Buy76gtCUq9EpHoO2>
X-ME-Proxy-Cause: dmFkZTFxGhXE03qtSYufJJf9gLbDGc/woXBtu5hVUy2rqTjpxqBvzUkZBCyVtGVMVjCnjy
    KAwVu3MIPN/+Z87Sq6xZ/CfrLCj1MS49XN9T4E5dc62kKTzbGIruUGU1nElArdW8Ny4+h7
    lgaRBfvSS6rHh5RnTIKohPpGft7LXWGToyv6r/kYjkuC3lLP+IWMZ/qbRomZKmKn6WD1OH
    IkKlU8xBWEf+75dunIf9qKbji6GzU1N8a1Vh/gjPf2OfupHIq2gDmKR1a75SbpnyU8PmLF
    jxJfO4CCppHu1xSJODckmExuu6RUh9ZjoZXDpsPe1xUh4g9PB2DnGYMlQ2pMjY32CWsCnY
    cZIZW6bu2jRjMHcLm4zO04d8hMM8uEJ4nrJCJlA/DCp56sTYnroOsp2EuDXfTVg5kzJIA3
    shkw+/rahYmSnBCKLwjG6bldj8wtPa0sOFwgzlNT1ujzS5jJj2n6WBHBbYtVXbxS4Z4Wua
    5/mtSS4lUWa6qztLwnNxurTYLLwK/qfEBednDrBNU4rix1e/8WJBJb3UDAu/sKC8AY87z7
    Woi2t//CUBauHjKESjIjNTW1GLiyY9lIkYDztH55tdQfC+tGIUq/4K5LN7oghkBy0zqu/g
    vKRISR1LsJ59r+jAO6yEKx3ocmxByGzI3xo3cGDf4ErjCkUh8vAP0hSMenjQ
X-ME-Proxy: <xmx:7Fv_ai3qgENh9kGrZlpVF8ttBPUi3JUE1Mb5LdKfg7AfeJulkMgKDA>
    <xmx:7Fv_amofy0Ce4JF3hT8_uqmMVT9LcqQLOogSUD-IiaF0FLTuWU9VUQ>
    <xmx:7Fv_ahODOW7n9ZNNUMt86cIQCI7dYSlNl99I2JaaajuUX5czk7mYiQ>
    <xmx:7Fv_avoZal3Vl1ej9LLrcX-Ad820MVreEy2k4iNicolQUJviDT6Uag>
    <xmx:7Fv_ao5L_VlccUFFeAKCdmHUN4ccEGHCnIT9I2ai-iqbiJARigF3_q9o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 15:28:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  siddharthasthana31@gmail.com,
  phillip.wood@dunelm.org.uk,  jackrawlings2011@gmail.com,
  christian.couder@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [Outreachy PATCH v3 1/3] apply: free the old def_name in
 parse_git_diff_header()
In-Reply-To: <CAKrRMNoB-4==1EPLAAXE4M1J6bUwuWj=p32CedDvOTi3tzO7=A@mail.gmail.com>
	(Tanga Joris's message of "Thu, 19 Nov 2026 02:32:26 +0300")
References: <20261114012055.127905-1-tangajoris@gmail.com>
	<20261117004348.806694-1-tangajoris@gmail.com>
	<20261117004348.806694-2-tangajoris@gmail.com>
	<xmqqh5hd50e2.fsf@gitster.g>
	<CAKrRMNoB-4==1EPLAAXE4M1J6bUwuWj=p32CedDvOTi3tzO7=A@mail.gmail.com>
Date: Thu, 19 Nov 2026 12:28:26 -0800
Message-ID: <xmqq5wxswoph.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

>> I do not think we should ignore such a bogus "diff --git" line;
>> shouldn't we diagnose it as a corrupt patch input?  I do not think
>> we are there yet without making find_header() do more work when
>> punting, though.
>
> I agree. I think find_header() should just stop and report it as a
> corrupt patch when a "diff --git" line has nothing after it, instead
> of going on to the next line. That would make 1/3 unnecessary, and
> 2/3 a lot simpler.

A line "diff --git a/f b/f" would not be followed by another "diff
--git" line immediately after, I think.  Patches without any ---/+++
lines are very much possible (e.g., 100% rename or mode change without
any other change), but even in those cases there are extended header
lines like "rename from ..." and "old mode ...".

> As far as I can tell, Git doesn't write such a line anymore.

Have we ever produced such a patch?  That is what "anymore" implies,
and I am curious, as that may indicate that our above assumption is
incorrect.

> I tried
> a few things like "git diff -w" on a whitespace-only change, renames
> and merges, and every "diff --git" line had header lines after it.
> The apply and am tests also still pass with the change, apart from
> my own test in 1/3.
>
> Is that what you had in mind? If so, I'll send v4 with it.

We should be strict in detecting a malformed "diff --git" in our
input.  Silently ignoring them is simply wrong.  We do ignore
non-patch material after a patch to one path ends and before another
patch to another path begins, so that authors can add commentary to
e-mails they send their patches in, though.  We shouldn't be
tightening the parser rules on them after the fact.

Patches that begin with "diff" that is not "diff --git" are a
different story.  They are parsed in different code paths, and I
would prefer to keep parsing of these third-party diff outputs as is,
to let the sleeping dog lie peacefully and silently.
