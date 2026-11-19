Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089545;
	b=agq7afHod4IFvVgE9wjBgjeTwUXWHUS+HgG/KJ63bJUqfrmNNYXFFnojGqkBzv6FTAJ3
	 3NOdy954A/XXOYsVCEDF0iupAN4KjmJVkNC4qR0g1KMcGxr6zmGfHde2aEwN4GDmRfPpO
	 9mFtVKs052VvZD2DuOJW4hj1y/TVwvE+6Z6gL1gJmFoHsmRsb9bg6qusHM4qce++C8R4w
	 ODxpdZFiDEAsSi7dHUYl+7n994U7UcZuTF+6X7Tbh43m5dUpCo2CuYh5lmCdejeR3CquM
	 vCYIksKY5LaO+IuurKQRbTBAu9xGJwMlSm3Yza3JRGyvYBktokPG2WiTxvHW5pfm12A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089545;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bmW8yMhO1wcz57uIg0yp8lQbM7OQ2YK5KbCdjm66U4E=;
	b=ocRAjAD8s15IIZF3N3mywGhn7D/dmxrGGGlx2N6I0mFhJ8VTHV4bZh0CejA0hb4U7Hcj
	 DWeEUeITr5lPHyK2akAOhkQSgAOU/hCd5GYsRyCU/EiPSD3v/sYeSZAtJRA1zM/sjuQp1
	 7seLy6Wl/wrxxMFQ9JaiRKVlLIdS5ozf+77VulgLMSrRCFO7qjatQMo0DU3Xw9IRl/qDB
	 KQ/KbRnJnGvgX/fgSrvgjQxFkxgIW2AOrT7OI0I7A6ovgXFQYt2p3meI3OnYerSBlHFgx
	 IeSgc3Zw1iDLnKAoHpF+qQ1K/JJz6PvduU5Q0cuL4hW/4QIT4Mt14YBCRQ9Akir0yIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GILVMz7i;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TnNUr7Hl;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6847606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6847606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GILVMz7i;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TnNUr7Hl
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BD81EC05CC
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:59:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 19 Nov 2026 06:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795089544; x=1795175944; bh=bmW8yMhO1w
	cz57uIg0yp8lQbM7OQ2YK5KbCdjm66U4E=; b=GILVMz7irh6FhB/dYUYc5LkMcV
	BHHPzBtnHZrN4STY9ybl/k9eAE6/PcGU2mSr99kPG4tsuWCqrCw75NMUP8md21zt
	nRb2JIsKoARayZU1kFQDBavT3TjQMYpdZjRfXZ1ja3dPULAqipsRsOm9Ho4Yxzzb
	pMsnLpwfuPIEOc5dHrjxNDELVkYqyifUAGgw4GDgqBfct1bJGZjdjQcI4zAt3F5z
	MwzZyI79XoVWQMUFIsfQ4E3cyALfdUh0PUULBoNUloUH4cJ6Mcb1aaMQWQZ+NImw
	g07LF6oS9cKmXypqhYCPnUZ8c53qeOnM64WDuVNWjcmLXg7kmo/GqCix9/Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795089544; x=1795175944; bh=bmW8yMhO1wcz57uIg0yp8lQbM7OQ2YK5KbC
	djm66U4E=; b=TnNUr7Hlvx7k1WaLkiBlZiqWP+fufmlGXKykndPGTtGzNdlHi5w
	nz3ym4LDytNX/i5HT4NvU/UhmYH/ZpGoRkjBzIVPxhA/UxV53NHeP/MiyeiZpPF1
	nJSxNN6CiZFGBiiw932kiAN9X+iLCn9077SRPD3msPriF91IisEp9lwowog3CI5T
	4mKx7pHrMltR+CtdVXAJys1A4XbUMxSHaQKTwpLmDolWrdyfD6alyEwgVQGQ7Cy0
	P0OTIDaPCuVSnSliQKsJSAvWIkFgYwbzSBEr+po4xfI+Me0QcJYwAnJ8KF4zeX7U
	xoaeUwL5qSwSp3zfhInOncJcm22H7yXq0+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795089544; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:bUKtPUfl9VtSb/+szlz5g0wUNdsq20YMsneO++uyZBORxke
	nimXGwBTx2i8v4iPV69gaQOwKP9lv+8InalkrhIv3mh+2HfBv6lQZk2LHYMVXILF
	tTUelvycUVa+AJUPZz+pUZHmt5ovhw2gIH64sGJrXRpcwB8gbnKy8qqmKWFL4C3G
	nkat/io4Do0sbbRyUBCgGki2hKpfMOALQ6oDETdJE97+1Bcq53vkenFDvEqPY7oO
	klIs8UQMETUnNqrjvsjIiRciUDuFecAGOlaI5eDfW//Q6MdsQl9Px7uYRCJBUlpE
	9+C5VTZpEkAF8rdzEp9L1mwpETGIAq8FwWLv5hA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sXLrN4HPb93J/BHeOmAElRAmnVKsYo3qhHk9Vv6kK1c=:20x7BT+0QRm+AFCsCM4rcs1ZqR5OfyDBrcToTOORQQ0=;
X-ME-Sender: <xms:h-T-ahp_iNnMJitPltFdM6oV5XsfArHdbnmEw5fXWhC9pQwz8H_H0Q>
    <xme:h-T-apoZ29ENCVrBvPUH96NGgclLcgyyNMmvcCPHZPlPiSU6pEmfjcfx_TU_MvGK_
    ugEpoerSpH6KGSqkz-n9yBoMVZUrwgIQKbxYAa3iOr0BLAKdaWrlhj1>
X-ME-Received: <xmr:h-T-ar04i41OFbUlm5tTOA4FaeUYwHjVpdH6vGtcRRprEYnBGoBMpu5q63xk093hCjC85_A>
X-ME-Proxy-Cause: dmFkZTEPx46tMsaVGo5r5XgnYuNn9SHMsXiwPiLzvZFILKKTLPxunFuVZk2syZKrZwH/Zr
    k2yG4t0TRfqmyxflb5oErFcKAvTDqsDe1CRVrvwtYgTW9YNB33XiG6ZZ0nPvuR7GM+vRAE
    vGbydeat8+tN3Ukj9vMDIhOIfIZv7Z+K0FR7QpugT2eGttsMWXn1GFKLER5Jh02vsP2e2Z
    bbVl+qewSaURf4coCgEkFR9KW9V+9Yri42uXJTGT/uyju9CKacT+39WCjd+W+9I5qyZ4DO
    kjhoScqUc4Qsgw0IEc4aWJRWAwn8eQmnVcqdxSQ62NmPt+ab53LdhaZb85FbVO0BCKkjKr
    av3SsTgAWJfibbOb8XPoGuGXGOntOcJNUgVfxJKtgh9zSmONInhdSTiTLdb7qlSym+ZJfj
    s1OOEzMGlowiD/vSnu2SSy7jjp5HfJbmiBu7maPJCG8EHxxgXl/wCpK591zCoBh0NaN5HP
    6UIAGeJnNWUhqDgqN8e2TZzw+JBPcEKLWO8WQgtkYP1M0NdtsYGKeqWB2o6QEaSFv+Z2A7
    4fSGWNs/D9qmBNwGJN/MyZ60/9JcqjRDmIzi/JHh1IyYBrPyrgGbaIUhxHg2ONd424t7p9
    OSBvux/8diehbhTwWIUC6Qx2j+J/PbzPUN/VFMN5MkL+VuE4u4b/ZWhkfCDg
X-ME-Proxy: <xmx:h-T-aoA_V7Xd7PO_rlblB1vGQ_qjFrLKMpsBXr4xuSHi8Wmyzg0Bfg>
    <xmx:h-T-ajeH-Qz_WlbwnM8AaWF7j_XqLg8IgUpZ45nJrytiJEvw8hZHAQ>
    <xmx:h-T-atjnBaxiygTCEL-dvReTstm2d0M3hACtfqfQ5psxnqLPaqGO8A>
    <xmx:h-T-arp5hHMs241iHLHYbn11VGULXy6DHHefvsR5cMuss8NzeTwrwQ>
    <xmx:iOT-alAiHR29uL5jO-b2nTKQ8-WbsCTMc_JNadJJpDa6fsp5qXSkkQIG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:59:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3cae9a18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:59:01 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:58:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Improve performance of reflog expiration
Message-ID: <av7kgOuPOugFsCbr@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <87bj7mjfp2.fsf@dev.null.iotcl.com.invalid>
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
In-Reply-To: <87bj7mjfp2.fsf@dev.null.iotcl.com.invalid>

On Wed, Nov 18, 2026 at 04:56:57PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > I recently noticed that a bunch of commands started hanging for almost a
> > second after they're essentially done already. As it turns out, this was
> > caused by auto-maintenance, which was blocking in the foreground for
> > ~800ms.
> >
> > The root cause of this is that the auto-condition of "reflog-expire"
> > doesn't properly evaluate reachability of reflog entries, so it instead
> > considered every single reflog entry to point to an unreachable commit.
> > Hence, all entries were evaluated against "gc.reflogExpireUnreachable"
> > instead of "gc.reflogExpire", and thus the auto-condition significantly
> > overcounts the number of entries that we'd prune. So every single run of
> > git-maintenance(1) ultimately ended up spawning `git reflog expire`.
> >
> > This is fixed by the last patch in this series.
> 
> Well, the last one is a doc change, but I get what you mean.

Oops, true, this one is stale. I only added that last commit after
having written the cover letter.

Patrick
