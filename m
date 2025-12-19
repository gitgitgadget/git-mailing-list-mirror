Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713F2E65D
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766186649; cv=none; b=PkiNuMyKP0+A2rc13kIsHgE6Hx7OhVoHvz6zkYIZRGBG/cpqTV/wFKQiw8+dXZeKkymWcPpqP2POgLeX64zn8+q7okPFW7cgc8tFUo/jdpq2j5tQyAIlh/Y6XHJirPjJhV0R+SwH//W0mn7AkxZyHdRTe1Ycw8Sb74JwDma3g9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766186649; c=relaxed/simple;
	bh=LOzdHCod8itQue2TlIQy7G1+6wxHBt9wUOuR2RRrY4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSqHxwLHvKEm+KD+kOb4PJtkZbZfcyF3PTZ1AluUoVppoPLyBGeLPS5+rCV345W477A2qUXfPlUhVwszf+Vl2OXKWo9tHoyqLNcNsF1CrpbQUC+4HCm6+xE5ZPFSNB08CttDdZdQBTyu61zoI3VFdjOVszRCL3VI+gtjeeuYMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cXX/xkBT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cXX/xkBT"
Received: (qmail 400006 invoked by uid 109); 19 Dec 2025 23:23:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LOzdHCod8itQue2TlIQy7G1+6wxHBt9wUOuR2RRrY4E=; b=cXX/xkBTEx3sWnVYhyOxFwpyarz06D9rjpNbPp343bnryigh+EZ8oQU5utRGOyBWDcPgNKIEZHrdrY58T8NuskvcV2PjHFYkNIa3cpW7geja2VXmilNsoX1Gfo4gHc4FubOoSwo7Cp2X0rMxvCHAnprsc+BwOsTAPTw3IRQzHIzr7Qvo9lUvmeM88weQlb5eP7Bkva7Xdl/NQoEzfHaRptITHiMh8SGK8O7fN180rC+3ciQE33m9ibnpruEVitHVYuGXvCjcGfHAqomBHf0AVeckZz+xkxbvZfelleL183EfxBYq20YGzG5JQmvF/lxYQ5aGpmoVGliFJYJhNhemfw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Dec 2025 23:23:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 540286 invoked by uid 111); 19 Dec 2025 23:24:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Dec 2025 18:24:00 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Dec 2025 18:23:57 -0500
From: Jeff King <peff@peff.net>
To: Daniel Stenberg <daniel@haxx.se>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 0/3] test-suite fixes for upcoming curl 8.18.0
Message-ID: <20251219232357.GA3960837@coredump.intra.peff.net>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
 <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>
 <sn7p46s1-4o20-q05n-173r-s6716s8145q6@unkk.fr>
 <20251219080409.GC3784564@coredump.intra.peff.net>
 <0s72r344-865q-2n3q-o9q9-p701087s0n04@unkk.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0s72r344-865q-2n3q-o9q9-p701087s0n04@unkk.fr>

On Fri, Dec 19, 2025 at 09:47:37AM +0100, Daniel Stenberg wrote:

> On Fri, 19 Dec 2025, Jeff King wrote:
> 
> > > [1] = https://github.com/curl/curl/commit/9941e7c95bf26f00fd87888a
> > 
> > and it fixes the first of Git's failing tests. But if we swap out the
> > space for a tab like this:
> 
> Sorry, that was just sloppy of me to not add a test and proper handling for
> that condition. Allow me to fix that in my end. A leading tab in the folding
> part should be replaced by a space.

Thanks! I ran Git's test suite against a build using your 6c7bc9871f
(http: fix for unfolding line starting with TAB, 2025-12-19) and it
works without the whitespace-relaxing in my third patch.

I also double-checked against the current tip of curl's master, which
includes 3388afd2b6 (http: more unfold fixing, 2025-12-19), and
everything remains fine. Thanks for a prompt fix.


Junio: I think we could just drop the third patch here, if we don't mind
test failures against an unreleased version of curl. It's in debian
unstable now, but presumably they'll move to the released 8.18.0 once
it's out.

-Peff
