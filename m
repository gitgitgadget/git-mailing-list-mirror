Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173189;
	b=wnKoMEZV0zouOIMTaIAAKc7QsZVN7j/Lmj9/CEmQqN3+IhBOL66rNhytnPORD9NVL8Y0
	 aUz9FIPSQr5lA9Sx9559m7VLV9JcAhimZHVt12sj37QyYiUdgI02Bh8xmBftTCRopbbSb
	 kZZsxJ+9uqTveGuUCA6rGDgHNQwIMIcQb0fJ4ik7/r8NfABt1DLYOdiUgtAXR1HGBISUX
	 qZL+XeW+HAAo6LfcuAG/X0zedYfFT3N3Jf/E1icl6rSkAiUSmKWUoY7GzlQuhgvCDPi/D
	 5e9Zlg79P2FIxpDW5l0bKewZcfloGIeKBbfrwyvoQyqhe/18Za96c8B8+iJstub9/AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173189;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lCmfxxLqpSlZQWBtbfAUx274FJ9/0SWfqA/1hRx+dEA=;
	b=tCt93oX92+e5UW7VOH/2SDNnH500XDHn9JV8YqKxSJY3BZ7mCNFqZjqQdK66qP3g2FL7
	 Jh82Qu/pKsFk+xuMOuyiw5IJ3KeMqH4rZsV5i6/vLs2ZpljkTC1zn69WixfBnAYf6bLTH
	 FU12P9llZ627EMlVOZezWQZoS9/xSZgO7hIPEQyWcZqHiRoU2Mt/60v9QfEVSAmeVZMzq
	 PnuYk2tcUMLqizh5+ZMsluCrgDItwsCYIIsdmYQh6Om0PSi7KToHQWgZB1mgkRdqBn9G9
	 OpTN1RzUdqwL5rMLUyXnHezzy3N0JQxtzyp2PXnjpzYTzPAl3IxPsuCaHgPnLhJPdoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OROLEukE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="nqhw/3Uz";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8A606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80E8A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OROLEukE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nqhw/3Uz
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BD3E91D001B7
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:39:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 28 Oct 2026 03:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793173187; x=1793259587; bh=lCmfxxLqpS
	lZQWBtbfAUx274FJ9/0SWfqA/1hRx+dEA=; b=OROLEukEeIz3dZWxJDpD9RJe2b
	JzmWUWvuh9ba/YamHkdeUyUEphNemWNYiqg5oXfPeJDkmSiZorXa+Cxf8qrI1rjx
	h+IQ8vRz8l2JDBEa/zLqiTehe/rBcqavWlC0CnKjWDoT02iVhWRkOMlWmgLWRwPW
	SBromrmlg3FWywrBBcIcc8aFAhSKpPyy6GEiHkVcHo2gJd8EU6uKMIlzoA3uPLyl
	oUtobSb/haCbH41Sgj7gY0MrXcLL/593QYXi6Ith6O8SsBM8FtTPiN74HKlbpUTc
	YSfjlfW0foE8OitzwddBzUk393+Mbr41OH3yjxvOHjB/Pd26pCrQT5TrAg9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793173187; x=1793259587; bh=lCmfxxLqpSlZQWBtbfAUx274FJ9/0SWfqA/
	1hRx+dEA=; b=nqhw/3UzKQs93qgsDYvlwSE7UptmzNgZNB2K6Y7HxCWWu3Kcj7V
	UQNjMjY782Q0Nxq88G3Ilh8hHWV+i0k10SBi3L7TtTBAVqjKh6OyXQxaRKzbnEvJ
	qGl6SwivCkB0FxPsvzTsgruXZefkI8u3VoH7PLiZdMVanHbMfiQci4Hktz//H6PG
	NNyiTb6vir2Dxef75DWde7HnS2Fq9QW1ibqCYbHgJmem9mmj4brxBbrOqPnms77I
	6ns0anPnl35pBf4lAfsdOx23XrECy53USvvNehbVUAkTz/5PTIL5Dr1Xt2FEGo+Y
	jSOYKDAJW9o8QRRyvxSOXdU3OPtyBVYoQWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793173187; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nYAh6a3ZWn/D0WGAFQcL9eUX6sJzWfBzE+VQkyTtTXf/k6h
	0Lk7IeCLTgrOb8dtHfA/Isi5eRTekent3CsS7a77l9YB3Lyp1D/7xELQcQTNqpXp
	GAxDvCPTPp0gQ4+uGHLNty/Xm9Sp7UaXxIuFM6Mk8u4GCWZAMAWntGaSI/JpBWYX
	SG4qOeCUNvXLEHeOYm9x0vuF4VT/QcesIChDxv83Fd5Mz/0T6LK97iOyTOId7p4G
	sxna3YVql20n5KDrcaSVoW55AWuB1Ib1PtyIp28clZncId26xZ6CbZvd/Q/J2Xxg
	dFapbvzMQ8RVbQ4dNcUNTlqcNgqoIfPeWAylUUw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qrs7SHlQItNxqGavbQ+lNPVOMnrfyjfc29MxMIdSn+k=:hRHzXWSEwauDJWVqyK381JjrIKTIet1xjwkOibczRnE=;
X-ME-Sender: <xms:w6bhasASGlFOs8gA869zg-m4M3I5qfbcMXVWSppSvWM_5jmVFIXgIA>
    <xme:w6bhalg8ISF8MtewX-YNJABpKLgqwKaX11CA_gLwJvzxf52ajfMgxB8WoOmwJ5uJf
    otxjP315bz6WxbKsgbavOJrqE4-Lbyp0dmxK_HoRA8V7FhvBWCva1U>
X-ME-Received: <xmr:w6bhaknPZ1ZC_N8suIOsRTEA4ay-fYyUzG54Hi0zn0BX1btsjfZh5Q>
X-ME-Proxy-Cause: dmFkZTFVGQfHR+syN53u+F3U4e5WX0VyyHZyCtWT0X0EP2K26zQZ1h/sxXIbSwpt2wjfva
    nGF37sxUX3MsKTkerUsMgqaZlemjjeRYq3ZjnQMevK9hJ7kPMk5tFOqS3MF9rp/I9KceKh
    ZPy744i+wJ7GHePF9s/FwmczuQFTItm5ge8+B0ww/XQHHeO8ZbRyURhUXItT7QszXzvxwW
    G/a6T2IpZ4oXI0ncpibsy2uld8lP6EBJ4GZ6NoazsEcYJ6gKF2tuuI9HIvAbRx7hu+tzdZ
    j36nSRQJBdFVGQCKHcQIrFGtVq2czrueK3ch0xPySXQ3B8OMUfjm7UBo7a9nykITcrgoJw
    ln3wp6guMIDr1zJTPFjaUtbn6KxxCoRAms+msptr4vwR8SCcEbB4LmfgOxvWOcyLYYxa4j
    /bjOxn0k5dVO5xtQCwODnVNtVKA0HWGvlrAlzq+TAA2vkgOXkNeHSFPwnMzqGyvnN+ZUzu
    tJ+ajuZvCxrpbea0G/mGrgWX/QIWP3V4UxDp7SVT6+eqiyWI0u7H6bugTYwb22ZoRXpHhd
    oJt2eIl3E+VLJO7R1fgfvPRmxWj0XfNlfTwNf7lNwf0PTPqkWbmZBNd6AbEItl9wCvq5Us
    e7VSiw5N+kYvOe53c5rqWtRaLxYeCC2NhnZ/u8FTRoFPHyMaPLQKrfWWHTyg
X-ME-Proxy: <xmx:w6bhahrm2kwTC16djQY-VX2U4OsZjMEdOb_FtOs2Rg3TQvTLiT8ziQ>
    <xmx:w6bhatGKKL2yUPOnft1UwoTBxy4b0FW-FFqTddeIjH2gqmuWaDfoxw>
    <xmx:w6bhatwuPXyWoh-8ZcwylzyX3WA0oHdez2kuvZk8Ic1rQn6JX9UwXA>
    <xmx:w6bhaiqv4WCtYj4MlnRZoHCdm1E0DYEd2vvQYJRAGdCJPY_mqkmY2w>
    <xmx:w6bhaugzBRNVMiU0aJ2vKQXNYP8mRhX66EXpDI2RxGMkZjyQxNTC7dhp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:39:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 890a9189 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:39:45 +0000 (UTC)
Date: Wed, 28 Oct 2026 08:39:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
Message-ID: <auGmvTuD1NcFIw37@pks.im>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
 <20261027212349.GA774120@coredump.intra.peff.net>
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
In-Reply-To: <20261027212349.GA774120@coredump.intra.peff.net>

On Tue, Oct 27, 2026 at 05:23:49PM -0400, Jeff King wrote:
> On Tue, Oct 27, 2026 at 09:18:28AM +0100, Patrick Steinhardt wrote:
> 
> > Due to the job being special it has a higher potential of failing even
> > though a local test run succeeds. But running these tests locally with
> > the same environment is somewhat painful, as the developer has to
> > manually set all of these environment variables.
> 
> OK. I've usually just cut-and-paste them, as my first step is figuring
> out which is the culprit anyway. My biggest question was: what if the
> culprit is a build flag, and indeed, we leave the one build flag here:
> 
> >  linux-feature-testbed)
> >  	export OPENSSL_SHA1_UNSAFE=YesPlease
> > -	export GIT_TEST_SPLIT_INDEX=yes
> > -	export GIT_TEST_FULL_IN_PACK_ARRAY=true
> > -	export GIT_TEST_OE_SIZE=10
> > -	export GIT_TEST_OE_DELTA_SIZE=5
> > -	export GIT_TEST_COMMIT_GRAPH=1
> > -	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
> > -	export GIT_TEST_MULTI_PACK_INDEX=1
> > -	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
> > -	export GIT_TEST_NO_WRITE_REV_INDEX=1
> > -	export GIT_TEST_CHECKOUT_WORKERS=2
> > -	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
> > +	GIT_TEST_OPTS="$GIT_TEST_OPTS --feature-testbed"
> 
> which makes this feature only half-work (well, 11/12 if we want to be
> pedantic).
> 
> IMHO this whole thing isn't really worth the complexity, but if we are
> going to do it, should it be "make FEATURE_TESTBED=1", and then that
> enables the right build knobs, and test-lib.sh respects that variable
> coming from BUILD-OPTIONS rather than the command line?

I dunno. Until now I've never had the case myself where the issue is
because of the above build flag, test errors were only ever caused by
one of the GIT_TEST variables. So what I typically want is to toggle
between GIT_TEST- and non-GIT_TEST test runs, and ideally without having
to recompile everything. And more often than not I want to only do this
for a single test file, only.

So I'm not much of a fan of moving this into our BUILD-OPTIONS, as it
would kind of defeat my own use case for it. I'm thus inclined to either
leave this as-is, or drop the patch altogether. I don't terribly mind
either of those outcomes.

Patrick
