Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680535;
	b=Vopb+Accb+55BLaWHtm3+pY++Vhq2kM82UahCVCkWgFHxTG7tmfkA3lscdrCA+yOdNW/
	 jrnxXNyjs26h5oBM5DzxcPkFDzt0bzGhMbi/9mSistfY6K9KGl8Vmp8lXFDqzQ2cisUTc
	 lKOTVsJH57c2MZIWhjuM3kwFFmIcXNRKS5pvSPaJiepmu2Ptg/jHuAUq0MUKqWkGcMf08
	 bHxAsrllTUKz5P98T9QogPAIsVq2ara4aFavkUe1n0wQOU0j/8MNcmTGLPmhCUG6HqUf3
	 nBsWnqgWw8LpyTvZQs+QKfQy0Sn1MWy+PTCWrmccooIGvUZClE1b10be6m6zRYPKvgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680535;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NnoP/ZLeJrFKO3wj3hI6+TiVzRJ9w92PfYdUEwJBqJI=;
	b=Gxz784Y4f8FdvJ5Ytb9E0BxupQGWAs2H9cicCHYhtiK17Uww7oVpXpmvqb2sqdUoWgkw
	 xLIm+c6lzzcC5nBOBLgb811B5BmjEp4QC3BXQCA3xITcmNAbfsbFl2xfcFYYvH/MIdGyM
	 75rWe1Hl+jq2Q7ymntXSWabiLOD/khmCyhOwecMzQeVRcUIfP8Srz0sMnxxnEv/lFlUKW
	 pciDUYXhTGTxSldPa4YXlidywex5bHQMmqpD3zON+f8n9sZiDIeNt6MsUGCr3ni+wCC8c
	 B+snkQHnUqccAxQ5YwW/Xgt84mgivYzS4ycroqL2r6oviTm299ssXrQgP2EOFsDQb4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="G/YoxP5I";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RdD4HRBD;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3C60A263B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B3C60A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=G/YoxP5I;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RdD4HRBD
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8373A7A015E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:48:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 10:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792680534;
	 x=1792766934; bh=NnoP/ZLeJrFKO3wj3hI6+TiVzRJ9w92PfYdUEwJBqJI=; b=
	G/YoxP5ISk9A0KIX1QJgltczshPBvYmVkn7cuezzD4ZJrbEi8LIGk6R9Bfq1+Aqm
	1Ijg3ZXaT9rWFu7ukOeCoi/5e0B50BhDtXcqG/o+2D/EO8ZoG5ZBxSTVidkNozJo
	7ZCngEs7cW7jWPhDrQPyYatAnajYYdHJ72ZuVwbSc8y7YtOqR0hwA1+fW/K2VsP0
	Q8/rJYaIUAKpeMpoq/KLKCj48dwy3LvvibeBC5v/XeOYQHjDWTgvSEbdaEJiSKe+
	qMpldM/dC4Dt2qQ2duxCyw+6Jv2cZlmboTiYUoBGt+tKnNYR1Tw9QC5b9PjZWMVB
	98FkJZeJpsEz2gPKaZHkuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792680534; x=
	1792766934; bh=NnoP/ZLeJrFKO3wj3hI6+TiVzRJ9w92PfYdUEwJBqJI=; b=R
	dD4HRBDwcip2hJboWpISt7aHwZb7oSaf93TrDkZwV77JHM2IC3RZGcAE76G08QT/
	PnhBdy2O0nGJeJbXdBhoJBR6sG7Wa2G1NuubdkeFej7tCjEIz3/aInTioeryU5ca
	NYP6nLO5MzEcgb1h7LeHd5UXecJnmOwPDphMdmcwBKcQNB5f7ZYxWwPew866Hm9s
	JwM6yO+3Xo2qwuPinL0Qo3K59LrgbixyzLMVsDEav/FIGhuIZz1fq4OJa1LBrL4y
	nPmuINrdAZWQ8285YlGNoywdKeER2GTCVrVtAHK2zXzUCXDAQ++v19/uBZ8fSk6/
	sBCZm/GEbAWccrL7A8r0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792680534; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:BugosTrMsV20XAcAlqfXzCAMqG8MwQkZAnLKfSDQD+HT2Wh
	yAr0prsFaV9CsKIax3i34WwPF7ZHPqf9DnKjcXtGkjZS3G0tVvYD9B2/4jdbawe8
	2V1PzR7dY2Id3LYoy/+DvgtLT1hUrWLw2SkPTQqoTTfrlBP5t0OrnK5NaKsjQjl6
	5ifz7J1pok77REVvO6F+iUo2tDC+Qn5yzWXvpPI8BOY71gtAEwxlRM1JHyKSS9Zt
	BPHtELmMe8nkvxqCcmXXSTcT2HGIKYG63Znc0xW4L2mGoQhl5ezoiD14o+ao81io
	G3SjtDsFbK8VjcefrlCbs9NJYiUbR8+GG0xtKGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:CyHOoVAq7CFRy0/G3GbUJK/88ROzLHtsf44LqzVXnto=:YSTj0yQFORk/w+nWtWayKAK2i454BRBqp9R6K+mOjHw=;
X-ME-Sender: <xms:ViLaaiXAu3dKS5zvpFBJnbuzZ0fiPLD5KIf1eXJY_M4mQBRnYrsL8Q>
    <xme:ViLaaiRPH9m6JKobGzvduL69JQ_ynDnzpV5MmnAcwqQBStOonYHBIXaBMucWhAtF0
    j8i4lpypfp7FId8P4KxJGfTU1iY_Frd9v_Ve41rsBwMOFSUmYix228>
X-ME-Received: <xmr:ViLaagNlYgn7j5C5c5mTeGgbk4tqmEu1vlo57CHLtLr6hgYazez0VGhgMaQRw1wLDi6gz2RbFOmTee3HRAfyzErsIuiXQOmUHIC_>
X-ME-Proxy-Cause: dmFkZTGouA1E/rjuF+h/dpX5Dvw3JkuASouIIk8MOzuk/rlAZH8E886X0DyvFfYRpgNo+q
    7UDWF9xIHHcKsMTWJnjt3AqkE4Fig9sLSYElOp3cg3yEzqsuEV2Q/z/lrugHfUUy4ibmhN
    QhjqYvnl+/RDDPWg+2FRW2eMdK7AbpWt/iy1Kho0NpOT20DhFKlu0JTH2fQzbpBTzoUOZm
    4fc/wPt251ovwnsHOwiPCkTCvZALWfPXxK3WTidyjBx2OzvphMEiTFQaVsIlOl9L9HOSQ9
    25ryv/DB6JsK6ZhB8s4N6BuOCQpKMRKP2nEiMzZG7sjMVdOb0q1xpJau720xGrOdqOeOsD
    lIMmqJv9t3xUn+69PhmcjdqFjrV56mv9xYCJe9KbzkuG+Zma9+bGr+NdyPzlPkWiUBKboM
    P58rYJwkf/o0xRV+XigyElGXvEbteXgFidYnnsdNFhgYJ9ahFmpCopzfOf/mwfOtQQDqY2
    xUlhZFnZiV4L4uXwueSDYUcIBW5bJ59uVL5EE7tCyWGHfJoL98IZuecA2PT3YAhsA3fLl6
    ynMYgJOrHCuhbNULr35GzfSO0Flg0IQgZfOY1oNzqEtaVkLtGafZPdjlEbXu39vZb8sim8
    JEyltKFxokGsl7VLYPFtgyOfcJrn7Xk1zdTI/T2e2ghDhcwfCIcERzw30E+A
X-ME-Proxy: <xmx:ViLaagQkVwI7F5qzz9s967EWppIrprXy86-Xz3pLaVDXWrC4xFn5tQ>
    <xmx:ViLaaui8m1tMV9KFD6eKD6YFHwemTVlDqm1qxzDrDsEfy93Wjxw-ag>
    <xmx:ViLaap_9F9LqOwBzKFRJkAv722AtwB6c2fppRa4kw6Ne_d9IZcmVcQ>
    <xmx:ViLaalFNsMAK54vvYCXG2kqtA-JgnHRPL1c7EPKXUFxxmuUafeDrOw>
    <xmx:ViLaag6Ts6MT-qTP2PjlvLaaw-uvZTSaDyi1lWQ8K4zW7Za3ASD4Gq5T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 10:48:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Joy via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Christian Couder>" <christian.couder@gmail.com>,  Joy Gundu
 <soniqjjj@gmail.com>
Subject: Re: [PATCH] t3429: use test_path_is_file helper
In-Reply-To: <CAPSxiM9SuRiRA6Xixp_zx=fFf_a6S8Mp327FP82Pg7mJdzQ3Kw@mail.gmail.com>
	(Usman Akinyemi's message of "Thu, 22 Oct 2026 11:07:54 +0100")
References: <pull.2274.git.1792582249420.gitgitgadget@gmail.com>
	<CAPSxiM9SuRiRA6Xixp_zx=fFf_a6S8Mp327FP82Pg7mJdzQ3Kw@mail.gmail.com>
Date: Thu, 22 Oct 2026 07:48:52 -0700
Message-ID: <xmqqzew5iyej.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> On Wed, Oct 21, 2026 at 12:30 PM Joy via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Joy Gundu <soniqjjj@gmail.com>
>>
>> Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
>> ---
>>     t3429: use test_path_is_file helper
>>
>>     Replace test -e F with test_path_is_file F in t3429-rebase-edit-todo.sh
>>     to use Git's semantic test helper and provide better diagnostics on
> Why is the commit message down after the dashes, isn't is supposed to
> be at the top?

(tip: leave a blank line between what they write and what you write,
both before and after)

It is a common mistake of GGG users.  When they write an empty
commit message and then elaborate in the pull request message, we
see something like what we are looking at.

>>         todo=.git/rebase-merge/git-rebase-todo &&
>>         git rebase HEAD~1 -x "echo exec touch F >>$todo" &&
>> -       test -e F
>> +       test_path_is_file F
> This is wrong, the initial patch is testing whether "F" exists, not whether
> it is a file. The appropriate function to use here is test_patch_exists.
>>  '
>>
>>  test_expect_success 'rebase exec with an empty list does not exec anything' '
>>
>> base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
>> --
>> gitgitgadget
