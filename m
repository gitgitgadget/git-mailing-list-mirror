Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D9242925
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855602; cv=none; b=s4HKHeaDaZIUYgBqUKdF2R2e9i4slyocXW8FHoh8HBesSomEN0gnkCJywRq/3pUebtKffl9bZSBH8oNql5lDlhbri63QsjiN6G73WWdGss9ENmFyBuBpf848y7nxMgSWqu67xRGP5OqA2ajCZA4VAyS1JhwDyFQ2SpNBbSqmq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855602; c=relaxed/simple;
	bh=ioHkew/AV39e3EyyNhpmgOZUe3u0MqgXszguo0ZzbX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZSMYU+enW0c1xsLVIs/hrLYvEhwLqm7DyPEj3pnsiu1SWzEcufXpgKAh60IwLC1yYO3I0n1THFEtmA7JZ1hggF+bV5cQ04IymcfmpxF0BH0zCn11z9OrQeAQU1tatsRlQCGOhe7QJSM6fo0uAbK9/g71fs1UIMtnJuXIC+7RXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T3BvkOfC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GEmDdWhe; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T3BvkOfC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GEmDdWhe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1063A7A0170
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:40:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 Oct 2026 21:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791855599; x=1791941999; bh=F1nPfDxc1Q
	kPun+un6i3eLk72v3qVm/X2UMQGHZbL1M=; b=T3BvkOfCTSO6mtLUELpgfEYjp5
	HS9BMadQApgtITjHQZqOnAwmxwi9C+XYxt3hDwmmqwBVvej9F8/rL6+8PKPnKXrg
	DoJkFWFgbb089E1R1JZezQteaGAbhD6EB89lt/fKEiBq647vdhCpxo6iwnsJ+Cb2
	wE+TQB5ZG7lg9Fp3ck2ofsTWsak01LfiqtoGJoqJuFonZdQh0nTgOsLDjrxdKn5F
	hmMee3sTxHdlSE5SWC7j9oIm5DccaYWPRQK/OzfgSEsxB8sl+1a8oBddqKVPoCOg
	nyP3UYHjsS/IZeIOJ9wRwO5cMJV2/eGeY/Jtw8StgEvz/jbYsmIXVGGesKhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791855599; x=1791941999; bh=F1nPfDxc1QkPun+un6i3eLk72v3qVm/X2UM
	QGHZbL1M=; b=GEmDdWheHLqNdULRHqm8rAFKUiQNnV2yiE5TCdBj3oRuGnGLB2B
	UZr59G7pF+CY9mV9C9iOJhXhkdJzCiHAbPLMx0b9an4Se5ZxupGRjgyM9pkJP1Pv
	8bcw82Q/G3EWCsjzKIH6LLljd6ra/6gIwDkwlFnleN+wB0YzwcrJBnJnFtzG6rPD
	nRJa3WC02pwxZmGSogPQxytlPaWmx4HCxeq4HBxMf1bQRRvOEKfKoslapIoOSIHw
	kyZGPseutcXiR0fNTka1Cr5LV+jJmrj/5E01fczNlhyDRB6a8ZFVugmfXeELwwv+
	zYy9Hkd0zWnObt/vMirPWhfZGNs1LfBOYMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791855599; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZY2dRuVmJujUFV8cDumpF8eCNMWOtAFsPKdX8wFXWglt6fX
	nKVk9ZU5AKjS7kxNnH8/vyyo0dQ+XNzY3DAktwe+7hc2yhUmOy1MIsIKygGZ7Xc0
	Z3BO7Zrxx6GPaed2gN+g+dkpAM+wdS3eJ2Ds3YstwPvJB2Lw+K9NL+53AORcnCGX
	updjLrbu6EQLFGdgOGYzFydb93jOChvkctyZvbxZsqt5LKeDhiqTAmrjOseExofa
	YRi8oZeks9+DWbtDs8AfIcfC1s2ykUk0tBR/rTmBF8AXIrpXeAoI12ew6l0zz7II
	qJ0iIzr7jq5sBcTTx4RqvgYJZNCFkSnRp6idRJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:E84AxlCrCqzIjDT5ndxUaa0eYtQho1/kpFB3lrpmvGw=:ioHkew/AV39e3EyyNhpmgOZUe3u0MqgXszguo0ZzbX4=;
X-ME-Sender: <xms:74vNauk8WA2nBL1ZXBufJA1RdVB-iMs2_ZxN3Sxv3EWe12QBBEb02w>
    <xme:74vNassrREX5lWUT_E4DYeUuckUGGt86i4HdYdNP4TBNB6TJhwyAx-H53NKKsZIs8
    6KZPHc3Nr4MPq11MfUFkEdmAGpeOfWlNk2Y6wQ7NGecplwh0YDHEbQ>
X-ME-Received: <xmr:74vNak-alckScbzKEHikk9mX3-LVb97E-Am-Bdm2u1SfN8OguWMSXh7S35pUL4vPlznboxZdR1qmAuQs-_E3ykpKeny1Vrlq9mYw>
X-ME-Proxy-Cause: dmFkZTGtHIW5YAFD0OQjVmM1ao9miv+nPelWS5C7FmwdWLb9eE6WU+PsutiUMvzD5TzNmu
    Dyqf/Ec3BBAKak6NLT4xzTh+IF1qeKznlnRZejqN68os1MsdHcap+9v/U5ItsjHyamowF7
    rrO6Vg8c32KF299lG1mitGNdSL8us0gFO+YsT1g+lW/Mo0NsjLpdQu7cOgrh/NYoih7xJ/
    EfjI5lBIpZKjB2X9fTsqbJWlKtHOcgDQJpquCC5tRBHP234yz2HE0sJWMugC3gB1qYTPZy
    iLZ0FyMmoBxmhkCGHLmArd1AEp5TWI4gmoNQCiMHnmyhXpFaYgOf6AHfJK5kx0f43nMDnh
    4I7jjxIAr0Dli9+sQR6lGJxAozq17dmLnzUE4W4UO9vTAO/EKkoRTZcpN3iN8YyWkm8Sjy
    V/hs+vwJ2sIVHmufVdCEctFco0EToLP0NYqLlplqhHfz57F7/yUS9TV3PsPELWk4ZMKBrJ
    1oDoejVy7yKuOxzX/E5bUUX81NvUlVZZJ9WhngiTZ/J7V9ZmttYt9qI7znTOTICXdehhP8
    32YivgdKSUzm4qIX3yGb3Y12SzKJtnNebTcASxW0HP/QWjCZ5BIPQCvc+wQV9UtT1pVSVd
    7pI10Qtpz8IQShLzBaA3Go28ocYrnFRCnYw3QT4BdtLeW/AEgapPVjy0MUxQ
X-ME-Proxy: <xmx:74vNauPXyoU_Iq_WsfKgp0-EKporAA3zFpQu16luQXWlNovlJTo4VA>
    <xmx:74vNaqGarUkN-xJIYKUPDFFgsnnOz1lieo-xuvdQm-dmGVw1YK3nvA>
    <xmx:74vNakTWP4Zpf3gzL7meKWHhg8Z0tJrtiaNoMxIOIAKrqBYMciJ70Q>
    <xmx:74vNavuamFjs3llj6HVKeHHOrt9dA8hSD5FxGuVvxraoFCw5nyI1sw>
    <xmx:74vNaskKq9eXF8TxMym9YjdoUW2R6cnVL-OOmC88MEHg8chQxCHMkMPT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 21:39:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Aniket Gupta <aniketgupta3001@gmail.com>,  Marc
 Becker <becm@gmx.de>
Subject: Re: [PATCH v2] fast-import: fix lookup for new commits and tags
In-Reply-To: <pull.2252.v2.git.1791845420568.gitgitgadget@gmail.com> (Marc
	Becker via GitGitGadget's message of "Mon, 12 Oct 2026 22:50:20
	+0000")
References: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
	<pull.2252.v2.git.1791845420568.gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 18:39:58 -0700
Message-ID: <xmqqik362xap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Marc Becker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index d9de2ef0d8..1f52be2c2c 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3938,4 +3938,72 @@ test_expect_success 'Y: rewrite submodules' '
>  	)
>  '
>  
> +cat >Y-reference-pending-sha256 <<\Y_INPUT_END
> +commit refs/heads/main
> +committer A U Thor <author@example.com> 1712563200 +0000
> +data 14
> +commit message
> +M 644 inline test file
> +data 14
> +dummy content
> +
> +tag newtag
> +from 17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
> +tagger A U Thor <author@example.com> 1712563300 +0000
> +data 11
> +tag message
> +# no emty line after tag data!
> +reset refs/heads/other
> +from 85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
> +
> +commit refs/heads/further
> +committer A U Thor <author@example.com> 1712563400 +0000
> +data 21
> +what about 2nd commit
> +from 17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
> +M 644 inline other test file
> +data 19
> +more dummy content
> +
> +done
> +Y_INPUT_END
> +
> +cat >Y-reference-pending-sha1 <<\Y_INPUT_END
> +commit refs/heads/main
> +committer A U Thor <author@example.com> 1712563200 +0000
> +data 14
> +commit message
> +M 644 inline test file
> +data 14
> +dummy content
> +
> +tag newtag
> +from 85b46dd918355ff17b4109ec738723d42f235a04
> +tagger A U Thor <author@example.com> 1712563300 +0000
> +data 11
> +tag message
> +# no emty line after tag data!
> +reset refs/heads/other
> +from ec6c4db71feb5f66615214dad2324ce030e777a7
> +
> +commit refs/heads/further
> +committer A U Thor <author@example.com> 1712563400 +0000
> +data 21
> +what about 2nd commit
> +from 85b46dd918355ff17b4109ec738723d42f235a04
> +M 644 inline other test file
> +data 19
> +more dummy content
> +
> +done
> +Y_INPUT_END

The above duplicates a rather simple test, and only differences
between them are the embedded object names.  Can't you use the
test_oid_cache & test_oid mechanism to reduce the repetition to
make the tests easier to maintain?  It may look something like this:

test_expect_success 'Y: reference pending tag or commit' '
	test_oid_cache <<-EOF &&
	pending_commit sha1:86b46d....5a04
	pending_commit sha256:17e65...ed3d
	pending_tag sha1:ec6c6d...77a7
	pending_tag sha256:85edc5...1f46
	EOF

	git init reference-pending &&
	(
		cd reference-pending &&
                git fast-import <<-EOF &&
                commit refs/heads/main
                committer A U Thor <author@example.com> 1712563200 +0000
                ...
                dummy content

                tag newtag
                from $(test_oid pending_commit)
                tagger A U Thor <author@example.com> 1712563300 +0000
     		...
		data 19
		more dummy content

		done
		EOF
	)
'
