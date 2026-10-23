Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738242;
	b=YsRoLLiBU0VAu0eMqkVnH0R4uVJLzcP1du2/YFtDY4YvWdJhnc2aTKDEUq+7PA9FJgaF
	 i1Ebdm7lgAmx42Bd7gpBqSKuMZxr/w/uizu37zripKMsyc7w+Q8vmzuX/oUj80jyPBKEj
	 +Hs2O0XbF5gCInBoJ0IcTfBdP89ElLEYpcam8TFiKiPEtsKBsQ/tihqgWRKO0svhgdvuj
	 9WVMUYFfCjVdFWkrWuSkkbnGP8MQlqy5Yp4cLV+r1TTTvvs9NPpQQ5W5N/hiQnMwXQfVY
	 IE1PuC4k7CASLRFd+/U3f4QLvY+ogKUj0MeOTleGUHXfYyZV4QhdxkFzrw7gzKdW5Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738242;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lCO1TXXSULrLUqvgcX8h9G1DCxUh7B5UVdfqFWTALu0=;
	b=KVNpu1qP/J7eBW4UZEXpUoi+TWN8NEPvnR6fSa1P2yV7eyNWz6WkBZioXmMxOSnxJx7L
	 8W6gtHLfh3Yzyin7FIze94KqJlaQT29Q991AnIRSTdX+W0P5DjPJcqLSDiWJ3Ob3z3njM
	 wyqduGk/lX8qe0QDgljs54/RFWdhoyMbczEsBVTUIiU/Yw9LqENu+AxLZ3Tj98iiyHMwP
	 eosWptsck0SbID3MYS1d4v7Ft5Gu+HLz4/RzDnGAhelu4+B6pOGa6n49ZCXBQgLdEi0DQ
	 LOqhOAPfAitzLtUDxyAiiLmVcDiweZfH6jVXPep7c0w0V+9NyCBAQqDSjnNvKuHcYcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="cY/8VMEc";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fgnTzLgD;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47D606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F47D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cY/8VMEc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fgnTzLgD
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id CF681EC011D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 02:50:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 23 Oct 2026 02:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792738240; x=1792824640; bh=lCO1TXXSUL
	rLUqvgcX8h9G1DCxUh7B5UVdfqFWTALu0=; b=cY/8VMEcq8AmX8hLZWKo78ThO1
	bl4fJ9FsOwRf/smXLWcKc1i+BRrRX7uM57dF5HQkcNDcXar/48l8erYJWaG1MNMs
	cgCKCIgVF2/vlIpf2mny+0cQZ8BYrwDtclmQH9qEfjFlUGac6Jr6lP5EholUXlwT
	TQe678nFIACBE+oz1vxt2YRbCBO7Z0GoxMuYhCHATHoOaRtu9fEsojz7hOWrrrxN
	GxBMMhexEeIWzIUrWpDZM9pnRKU05YvSWcKj0L/jWvHGpLU0pvcCNWtn/AA+3sOz
	DmoT7K4mScK0kOk4jzY07FLOvsvASTStQdaYUGsBKACdKvR9hi6N6E8nwhjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792738240; x=1792824640; bh=lCO1TXXSULrLUqvgcX8h9G1DCxUh7B5UVdf
	qFWTALu0=; b=fgnTzLgDBnFrWx+vOa7snzEeEwaRPcU4z+pfkKS4RToQLSZP01g
	VGgRzGTvDxNdkFsjgY1c0ZwByR/IKERVI5P7kkrRXwAXyl3piv1o3ZC3WJ4LmMty
	gi7Cd6C7FapuB2LtGRqUEx2i85KcXLt+896+l1yo6FyPq9vgB7DwMST2cXLAzm4k
	hRIiFEkYT2BaW0klqbR+jg55m3g7tauxRqQqmCiqXkRBwIy/+OZAkjx+f+jejAfy
	qUjtU+Fihte15eeiwIThDE/gqcnazrcYnFLSI6pNhMAkPR5Yq6ARTTumbfIewyPZ
	xNMCxRhDDbpV0xwWPt0HUfWCAEQOlnL9nig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792738240; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ucm0MXURYZy/L46OBEU5UEAChdartfNrq8LfPgiubuvmElu
	FRqZWzy5zQZt+tEZm8g73LGClG4yxGHqG9XXhTGS71hh0vDmCyVdVehgrlsBt+nf
	t4R5pBdEZ0a27nEosU12AnOTzOceT3doDsThT30m9msTuQo2nk1X3M76QjOke4mv
	FRhwRz4189iCRTWgOuXWtfBvysleTDVEBTVN045VEnDw0usTyF90jipPumZObhTQ
	DTOv8OBGN7MtPxzt9h83cwT+nC4pSw0IZqMj1gG8RZkGenlRrZ8Je8vExOTmXowM
	SSHDRUb2K9sjG/dZnUqGqzr/pMRfKwEHe15iM2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:imHHSR06yqWJhKGsIksgQnl6k3DJ2D4Lx2p5CDH4ssE=:0XQfJtFy8LmOyjTGOnqt0566XzTDyotvx1x+S1b8ZqM=;
X-ME-Sender: <xms:wAPbaqqIS2j3eYexO8HxauWhqk9CbH-zNdvrYG2ZhJBz7Yq0gTNiQw>
    <xme:wAPbauqLPYb4zkdalLM-kzIXk4eflHDRIRYha4Nz2eizLr8PdOkqN9LeZnU3wbiij
    4zC3gUKPbg0CtNcpzQ2bAJCxPuObBIpfCdD8VX67mxqTIR_oOLVaoA>
X-ME-Received: <xmr:wAPbas3E6Y8R85RNQteojcJtpCKXOyqf39iTgqE3tr7MSDKnh-bfhoXSubv-jZa6oEH_EQ>
X-ME-Proxy-Cause: dmFkZTFw+A1ZNZszEgivYi5SCvDcUWMk9fuScCqdYAcWETZohX4cScdIurNmR0QKcK2yQw
    MiZJlxmb+heRmFvV3vlI6S+xX89GZuwYD7wC5NpgAkNDr3xck76//7NaE0mzYQfrX9JWJ2
    BYFSybdLpvgfS8HedAjaxB0uesUkeTdICEOcmHJII7w5tL0oMVSyuUBHhoZjVBRCLG7Czc
    YssU7fLXNs92DryyrtQ4tH9JOb9v7/W4Hmbv20JWaB3kAQ8F2w7Xf7/YN3opYqBkk4hNOP
    b3yqoksfmJQpAkjmAzlwJ4s4UE4KMNUEnl9eSYN00XjBxv2HzE7KE0+bHkzw1w+rXu2LKH
    kfgQJ5K/cU1G+phPcKHQBi7x/k0Ol+bzj9tDo3n4G2XRGDvRK5TupjhDJNAQa2SMozScgN
    rphMd1zwi3vo303bzNpnPXKJH5l7+gzV3PZZGR+jxTRg+7f9c/S6ZMEVkFHVhcm1XpwT0Y
    bRdrU/9qjAXp0hieX78oX0YK7D7laIG4WVGDQDCnVZJPmRbqoiwYUXMQpmDmmpdH9BXlA7
    lFsZYBNFUkQKBkDFHYW+kMIXoV1Lov8TXa7bTsOtfTOh1nZrysvyAuEzKKPym4B5ahD6Jw
    KaqTy87qm4efqzAitDI13r3YH/7zQlb+BGJtF+4gjY+Nbz1P5cbtFfAuKuZA
X-ME-Proxy: <xmx:wAPbalBCL6jhiUFllSY2T-T_MxDpmUmaJ26K0EHlHGbBfO2Lp4lozg>
    <xmx:wAPbaseZOX07bNKW-Q1m8LDkmw3a37nXqPRa4nHreMam7MgocWZbjQ>
    <xmx:wAPbaigvuwR1VJq5NR0BFsoJp1_Jx-vmb4bAeUj85PuhSfoh5S-81Q>
    <xmx:wAPbasq2hTS_t1fZSPlfbYu-svsKGo6EBaKSNoRwYrzHC7E7IjWKfQ>
    <xmx:wAPbakZ-ZQli9Ew8ywnoY9NoIW5ZjuhjFgQZu6gZHH12zNU9xkdM_esb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 02:50:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62507485 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 06:50:39 +0000 (UTC)
Date: Fri, 23 Oct 2026 08:50:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] unit-tests: ignore --long-tests
Message-ID: <atsDvfHx3_EkrI6Z@pks.im>
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
 <20261022-ks-unit-tests-ignore-long-tests-v1-2-554a590d418b@gmail.com>
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
In-Reply-To: <20261022-ks-unit-tests-ignore-long-tests-v1-2-554a590d418b@gmail.com>

On Thu, Oct 22, 2026 at 04:31:58PM +0530, Kaartic Sivaraam wrote:
> In the same spirit as 9faf3963b6 (t: introduce compatibility options to
> clar-based tests, 2024-12-13), we should ignore -l / --long-tests passed
> to our clar tests. It may be passed along while manually running tests
> via a command as follows:
> 
>   $ meson test -v --test-args='-ilx'
> 
> So, ignore -l / --long-tests in our clar tests.

TIL, I didn't even know we had this switch to run long tests. That makes
me wonder whether we should have an "--features-testbed" switch to make
it easy to run tests same as our CI job that sets all those test
variables, and then adapt CI to use it. It's always a pain to specify
all of these environment variables.

That's of course outside of the scope of this patch series, but I've got
a pending series where I may be able to squeeze this into.

> This does not show up as a problem while running our CI as we enable
> the expensive prerequiiste via the GIT_TEST_LONG env variable.

s/prerequiiste/prerequisite/

> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index d066c8a4c8..06ffd0f5bb 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -28,6 +28,7 @@ int cmd_main(int argc, const char **argv)
>  		 */
>  		OPT_NOOP_NOARG('d', "debug"),
>  		OPT_NOOP_NOARG(0, "github-workflow-markup"),
> +		OPT_NOOP_NOARG('l', "long-tests"),
>  		OPT_NOOP_NOARG(0, "no-bin-wrappers"),
>  		OPT_NOOP_ARG(0, "no-chain-lint"),
>  		OPT_NOOP_ARG(0, "root"),

Looks obviously good to me, thanks!

Patrick
