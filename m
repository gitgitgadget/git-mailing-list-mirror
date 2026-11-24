Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552168;
	b=guvgjxRf5tlt79WpScCdhgQ6OyH9Ktv0EK5vSwRU1StA5deH0Oy6aaewIEzQ0Fn+wGKx
	 W/0Cp9dt6Mn2ZDO/QKYuxkllFlASpwg4xz76voejClq6fRYclSw4VhGKMEu+kmvLP9zv+
	 UCG0quAa+W8QGxNGHmPARwFOu6DtQsMdDgQiX334VrPIb/Dkz8vN2RZPNrWJwsbO4KVGX
	 wIWjbmvSNw6lXzAOmkg7848dqqWJLZ5jlAik0hqI85v7O/A2jos474rki1uRXu8dgEgRO
	 CepvfbLjvl40G5N6cUrWMReAZfJPMoGrEv9Ob5ytT37EqjuyBUFOGi05ohX5uaCD13g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552168;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IfRX1L2DSAydGxxQ2fJPVnBOosx5h+4hqDL+ztu6R/4=;
	b=fjeuu6mFt95NqsaidLsHZMn5eEg+sHjJFJBwCgS4ee2yGN5roBSJasS0x3m0GTBRlpJj
	 U8Fs+ao6ONfBAE4OmcvK6PH96jAP2vCvIPY5IIwx+YJbRrhgJUUUqaH/Jt2e94Q0lXayk
	 WznlAb9nSPOuVdmtcsnlzNrYrqOAqCzSmpdRbKKbyDXMNOWgQy1ZYZO24MuzYekhkFITg
	 A16pcwWRRoB3sBZARM4gZmE9jGkNahGniB0HBwHTsCSzBgQV7lLE+kJ8ME+6t4uvERMHE
	 YL4l5weCvEAiGLhY9qaMOp/GmrMu8T3xhuud3bslDj+48fichDe+pGLzhlGbLP/1g7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jmhYQGDr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=R8n8hJD5;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E5606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 288E5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jmhYQGDr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=R8n8hJD5
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5AB5E140030E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:29:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 15:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795552167;
	 x=1795638567; bh=IfRX1L2DSAydGxxQ2fJPVnBOosx5h+4hqDL+ztu6R/4=; b=
	jmhYQGDrjaSGz98WLP+iSmfoDR5gaj1ngcsyaT2BOlvYDF7rELXgJTO0BlNdWx2J
	E7+DX/zEugzpGOIRvC/a7sbbFbdYXqa19tRjNzhTiRrtk9m+Oegsrw6c8EZaD69T
	qWTxx+XirukSkbu2Z3bJ8XHfidALX0arwvybL+CB6wZMnp1pyrv9u4ZLfos990X2
	dI63S9Vh1GzG/CMr11Jcm/aBDg3bj1LTB0CgxAmKg7HLMKGEPb5ZWjUH8j81mazR
	GgN0CHDs1DKr+yiVTHm0I6Vu9zxAKTTokI14dFW4gcKLctJIWW9xXqucPaSCXcTE
	TxDARG3+r1vzcDmiX/Xt5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795552167; x=
	1795638567; bh=IfRX1L2DSAydGxxQ2fJPVnBOosx5h+4hqDL+ztu6R/4=; b=R
	8n8hJD53yfFjlN+VHew67lxU8tCYk4LoeClmC6qf03nkiLupjKRvqOPw6qHDVkaT
	iOoieawfTdMwg5Ifs2C0zBcMNu+u+0ZRdBWaEY2c/l35tQ1qxOs4EkU6plpzZuPj
	GUmt5Ykn9Z4fyiQD52p1pCsl5jCOfkI/3nUFQ/VI2AkK4MgkxZDKtmY7D+YzctgA
	MC/cyY26ba/U2cqeJ8JSvGoldc+H115empJeIuYuipUz0D3faQ36Ak/Fla879Xkq
	uTR8bll/C06RVpnmpAH063x+ZTuaCyDof1OYkF0Dt+3KOKa3zVWgJiY9YG8+lUN8
	F/qP109aIq3nZKSKVr0/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795552167; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KPZ4ghUOL4kre3nsA6HoUFX+irZWpRI+801/m2/iifaINgO
	SJMsZZDLBIUuC5oB0e34mcRcxAtIqz5pPJoW1uwv181QVqEJwk60U2Wlethue+JT
	vFIrveex8QESMx60Djk/MkR1rOUN92xxlQSQbZF12OMiUkNVfQj8GnyHRdMhedlM
	W6c0rGyMjQJUWsN5k6eq8EKIdJDfXqTqUhBrhiNuYi+Ushg0c5f4DQz9KpxppkKf
	4btGaVoqwLD36v3xhDd2ydOkZCVqNxe58SEAghdGPRE7guvUY2vCJvhOlgW/9tLM
	c996Fgh5lZdtOr8zG46iRpxuc3JRrNqmdLeN49Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:lOVCQqd72k0Gr3aHbir6rrL/pb4ocjwsoyqg5KXgP/w=:Hk267I/a4k3K06AwWLoxpnrAj+2wKBBFPwgKfkK2jWM=;
X-ME-Sender: <xms:p_MFazVTBO2vqkijZAWADCLnodXFDaqOpOj0Wr9LnrVZb8G_YRHENA>
    <xme:p_MFazADRyosj6zVlnRc6Q1K0rZokIjsGu5vyTY0Xe9B24U2GDG0TPALqlkrkac40
    q-UH6w8roGuVrTxMnOPQn-ycSHtPUb_q9cyffvuZmS4e3R6yDY-i5o9>
X-ME-Received: <xmr:p_MFa8yD15HRMlhMoutlztrPK-XxcxjZMxDT5DiRQB4euHQcyhhqWzFXAUlySAiFSOfsg7jRGujQu3dbg-Xcrq0PtUTCFMn_csJ0eTo>
X-ME-Proxy-Cause: dmFkZTElXT4Dsftyq0MeVHK6EDQiOeTNniCV5tpkxqtvhBFPQE/XErquMM0iscv4ElFRYs
    ssUCXJmv5FYKEzxaC9/KvpPlAWC3qlslOY6wPb7lrIPLz7uzCcoKOt6M2/gwV6bqDTAeof
    GPePHcCu300yzPgf8jqz3Xlf4HqqbJ3s4lhfa5nLYmgz3fS0KdloN8WHAfDxGeVm78II3k
    N89IV/47xL5nBVJcd+l9Ui1jL9KfSv+A/FF+APhvZe35d0y5X95AqTXcvCADmaDWsmygyh
    d6HuJvUoZV7s2BuXsyIyT7zCRjRak5uZll4ugdRY4LVp56Ok6ANTtcc/m7vKnMe5AVM5OT
    2Q6cp7DNNGNd3zbCd1nRnSNH95tv8mXP5tEFAEMk6bHchR7Q3A0Lu/NRftShaYYnxt2LNj
    MmRTCSavUosoLqPJvgoO1lh1DkRAl4l9fxKbwHBxPi6MFMjSCOy1LILumUeNJRoYr0z/G4
    VfBCtABAsTPCTmUX5d15DBo2mX/gUfEJ4UvXHASgB2d47xaiyerY4gMeiebeE8ITgaaQq/
    6Mb/sz482LC2QQgItdWPBOSIO0zDarSbgLx+oN9t+grYQAOYzW7BFRLLi2hIgKOb+5J3wF
    hfmGY90lv3jnl1yEUmo06R5vqSNL3YF9SyIgoCbXSorZ1s9n4Sy0zRsZKGkg
X-ME-Proxy: <xmx:p_MFa4DpBgqwnD6UQ5L0WJa0LfHwWK2cJsiq0tTkroTQWJsVNHEWCw>
    <xmx:p_MFaxbnGydjEn1ja-lHSTXO9S28LFe-ZFpuKgoPesDRlx_R1hU3Vg>
    <xmx:p_MFa4ipWN8cdfryJLduMS81Pt4B4XcJrAnCI9MUKlOVewTS0SUA9g>
    <xmx:p_MFa75oQ2iJyYAbgB1ShB0WKJeNbI3cwvFXiBCdVCTUilK-9ruy1w>
    <xmx:p_MFawrarU2f4dCcH6MF3gZD6zJHUQfQ5sFs0De8p8gjEadZWj8KD-zi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 15:29:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] t1501: don't reassign EMPTY_BLOB and EMPTY_TREE
In-Reply-To: <0e64c973-4ad1-4eaa-938e-f9d60418562a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 24 Nov 2026 10:15:49 +0100")
References: <0e64c973-4ad1-4eaa-938e-f9d60418562a@web.de>
Date: Tue, 24 Nov 2026 12:29:25 -0800
Message-ID: <xmqqcxruotwa.fsf@gitster.g>
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

René Scharfe <l.s.r@web.de> writes:

> The variables EMPTY_BLOB AND EMPTY_TREE are already set by test-lib.sh,
> so just use them.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  t/t1501-work-tree.sh | 2 --
>  1 file changed, 2 deletions(-)

Nice spotting.  Even though the version in test-lib.sh has a certain
"Yuck" factor by relying on hardcoded values in oid-info/hash-info file,
we already rely on them everywhere, so there is no good excuse not to
use them.

Will queue.  Thanks.

> diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
> index 8c94ac2e70..e6f43b0fb8 100755
> --- a/t/t1501-work-tree.sh
> +++ b/t/t1501-work-tree.sh
> @@ -5,8 +5,6 @@ test_description='test separate work tree'
>  . ./test-lib.sh
>  
>  test_expect_success 'setup' '
> -	EMPTY_TREE=$(git write-tree) &&
> -	EMPTY_BLOB=$(git hash-object -t blob --stdin </dev/null) &&
>  	CHANGED_BLOB=$(echo changed | git hash-object -t blob --stdin) &&
>  	EMPTY_BLOB7=$(echo $EMPTY_BLOB | sed "s/\(.......\).*/\1/") &&
>  	CHANGED_BLOB7=$(echo $CHANGED_BLOB | sed "s/\(.......\).*/\1/") &&
