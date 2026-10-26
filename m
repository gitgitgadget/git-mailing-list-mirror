Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.145.225.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049845;
	b=lZm6KV6Fz2ZTLgLDJtyj0hPgUAS5REwjyvGfuG4RkOhHSMA3B35tU0srIYGptO3iGGDh
	 ilUfeCfj60CL/qvDbtPHbUPNqAnSNDT5ySRVyBUrRkX9OnsYYdNgsfywcE8GhRUWrdEAO
	 JI6TjsyiMp63Hc8mqIE++5RhRQSJu/OOsnBYz/2XstfprNt4ktYfKkXPAgI0HD1fehyUY
	 bwXmTtGFfnuS+p+JQVgs2qrp/sBOLr83zJ5l3pmaFvnNZq98KetYLNSxYdpKr947BBeN0
	 L5+A0JG6dvXR/s3rTyxBXVG0jPVgNW0lMVQPUfq8ySLLVqVpPnHqDcIy1j3W7zqPpmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049845;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GZegSgh9HtJOXFZwCmt+RPW/6ZDaKbj0JIEf5+RPcW0=;
	b=j2JlEeVyy1akg6qhClzIzsOLXAprNDFEIdt4zl3mbEpXaeCBByUmqwWASS+rGIfKTfDt
	 ET0O8Mrfe0VTLubRTNCKkzZIwOzlUGl/OcW9bC21vtAZy+8XEVaYdkdDgsB0rpJ6uz0cO
	 PxyR1vypPCU9Hg6oaadxFQA4OMWppFXvd3tuil+EhI0+Vrv6IGzINpNc0h+A/TQe3og5d
	 C+ir7pKuWvdVhl5OWC4uJ2qc+Sto5nA0CrspRWs6evoW5+/S4srlt1psUqC0pgtbSz4Sg
	 QIA2BFfhawPRjeNYMhDWi9xnEKrGA6deEUsxYI0t8RjU454DJd6C/V1XhOaCuyA52iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=syntevo.com;
	spf=pass smtp.mailfrom=syntevo.com;
	dkim=pass header.d=syntevo.com header.i=@syntevo.com header.a=rsa-sha256 header.s=dkim header.b=IjH6SCd3;
	arc=none smtp.remote-ip=213.145.225.180
Received: from host45.ssl-net.net (host45.ssl-net.net [213.145.225.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FEA606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8FEA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syntevo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syntevo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=syntevo.com header.i=@syntevo.com header.a=rsa-sha256 header.s=dkim header.b=IjH6SCd3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=syntevo.com; s=dkim; h=Message-ID:Date:MIME-Version:User-Agent:
	Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	Content-Type:Content-Transfer-Encoding; bh=GZegSgh9HtJOXFZwCmt+R
	PW/6ZDaKbj0JIEf5+RPcW0=; b=IjH6SCd3z5Ot0meYoe2OphKl11BTxUlP+V3+r
	xia38n7lQAokg6/swmN7oGORkk09nc4+9Et1eV0h4CLd1eOPWzchrTfDnDY8EEo9
	C8A0+mU7t75k5BhahNg+iQpJSIHHki7xaklb0J8u9dUkvqtwwarxLDqRZgCf3Uw8
	ueZ62Lv4XhutchDSigERYo+r3LnkzRRsz7K9foPI03AduJrcqnXNt98yrOmI6LUY
	aWe5yGSGzv7JwYup6cUmRlSH7Gliu+SRAZ382Lho28M04+REfVSZBfdTkxtdBGRs
	phpj5B15EjGvT+pBnOh92bcpDqBv43Y59skxIdtB+8vbqL5Pg==
Received: (qmail 2465920 invoked by uid 7799); 26 Oct 2026 22:23:55 +0100
Received: by simscan 1.4.0 ppid: 2465802, pid: 2465898, t: 0.5662s
         scanners: clamav: 1.4.3/m:63/d:28165
Received: from unknown (HELO ?192.168.92.21?) (marc.strapetz@syntevo.com@91.113.179.170) by host45.ssl-net.net with SMTP [57076]; 26 Oct 2026 22:23:55 +0100
Message-ID: <729930b3-1be6-4612-823c-55cb20d555b8@syntevo.com>
Date: Mon, 26 Oct 2026 22:23:46 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] send-pack: avoid resending unchanged objects after
 rebasing
To: Junio C Hamano <gitster@pobox.com>,
 Marc Strapetz via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
 <xmqq1p9cs79b.fsf@gitster.g>
From: Marc Strapetz <marc.strapetz@syntevo.com>
Content-Language: en-US
In-Reply-To: <xmqq1p9cs79b.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2026 18:26, Junio C Hamano wrote:
> This sounds like the exact problem push negotiation was designed to
> address.

Thanks for pointing this out. This series aims to optimize Git's default
packing for forced non-fast-forward updates, without adding a
negotiation phase. I should have explained that scope more clearly in
the cover letter:

    `pack-objects` can resend unchanged objects from an advertised old
    branch tip even though `send-pack` already supplies that tip as an
    exclusion. This series improves default packing for forced updates
    by applying the existing sparse tree marking to selected old tips.
    It targets this inefficiency without the additional negotiation
    exchanges of `push.negotiate` or the broader recursive tree marking
    of `--objects-edge-aggressive`. Neither is enabled by default for
    ordinary pushes from non-shallow repositories. This series targets
    a narrower opportunity within that default behavior.

    A divergent old tip can lie outside the boundary reached by the
    ordinary revision walk. Passing it to `pack-objects` as
    `--inspect-have` lets us compare its root tree with the outgoing
    trees, pruning identical and receiver-only subtrees. The additional
    inspection is limited to forced non-fast-forward updates of
    existing branches with locally available old tips. Large blobs
    retained across a rebase are a particularly costly example of the
    redundant transfer this avoids.

I would also add the following section at the end to explain how this
relates to the existing optimizations:

    `push.negotiate` discovers additional common commits through a
    separate fetch negotiation, potentially requiring multiple protocol
    round trips. This can reduce the pack when ref advertisement alone
    is insufficient, but adds latency even when the advertised tips
    already suffice. For small pushes that latency can outweigh the
    transfer savings. Even if negotiation achieves the same pack-size
    reduction, improving the default packing path avoids the need to
    pay that additional protocol cost.

    `--objects-edge-aggressive` already considers excluded tips beyond
    the ordinary walk's boundary, but recursively marks their trees.
    The decision to enable it automatically only for shallow pushes was
    made for performance reasons: the 2014 series [1] records a
    regression from 4.785 to 23.322 seconds with 22,400 refs [2], and
    keeps non-shallow repositories on `--objects-edge` for better
    performance in the general case [3]. This series instead limits
    inspection to the old tips of branches being forcibly updated and
    uses sparse comparison to prune identical and receiver-only
    subtrees.

    The additional inspection requires no protocol exchange or walk of
    the old tip's commit history. Ordinary fast-forward pushes keep
    their existing path, including those made with `--force`. No server
    or wire-protocol change is needed.

    [1]
https://lore.kernel.org/git/1419462340-769147-3-git-send-email-sandals@crustytoothpaste.net/T/
    [2]
https://github.com/git/git/commit/1684c1b219e02c91655ad929f752f4f864c72faf
    [3]
https://github.com/git/git/commit/2dacf26d0985521c0f30e535963a45257b63ea21

