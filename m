Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547944;
	b=yMBrLLo5EB7EWJl2ejy3NsIlYjkrdCGRZYLqovGSkFkKLsu9+pOz2IKBhzwkb2w2zyab
	 G1vTdgr7lrQgXbWpITGr8XgpwvSt5bZitEIvPAqNH/3MOjNmw+tFQOg2DLlQ2kSzwSdC/
	 9I0g9Wsx9JdDQJFr4HkSEGnFoKGCzeC01G8LRgbtcKCtqZnanRhG0AkZGcJTNn8Hz5Kz2
	 CYAO7SW73btSLwYKLCjJXq/CjCIEui5kvBToIE/IipUdDSIVmI36/nqY9l4MOmNnkCM+d
	 UJLnPtabrtrWYbA+2oJ2ZWlo9QXJXzEkTpofmxaEPOBG5DCPbySBM8mN4nj/gDdVbyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547944;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=s+OH9lhBgZRjrCE8Hc70RM7unRszPH9TIAt0k84DVCA=;
	b=ndejWlXWI6vJmBkWQehaPfa+pXaq8lNY+InEGVeO/FZ5Neolb6GBeXha4Rt6eKx/Pv+5
	 hYbaTYkBu0xAZ8p/n4/wf7T5dGsOXqraGXF3ZXhjBPYdp9LktIzJoQ8pOnPAV1IKc0wmZ
	 gArZhqSaANtnzTem55LrLVjhT0aBBXk7BSPKZDLMMj7zAFZZKmoccJZuQvNVRhu6mHyxq
	 WbOTgeIhjTS0kZEB7iZ3fsjmgafn+JEyNpMW/E1RYCXY/AQK0xGyvi9VNKoE/6DqYtgU4
	 GObxUavXnk8upMrfTmXGAC4yZcBBIMTuxWQmMS62RMwEQ9+pwPFiA5mIhPWqZKKn24Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nwaDFkDd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ey3JgZvx;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF891606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF891606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nwaDFkDd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ey3JgZvx
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EAAE7EC01DF
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:19:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 14:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795547942; x=1795634342; bh=s+OH9lhBgZ
	RjrCE8Hc70RM7unRszPH9TIAt0k84DVCA=; b=nwaDFkDdcE1l2c7kgNshqPWYCi
	gsSm7NfPhN7DsZZHhIqS5HGD8nq+3d54sI8pW5RcTa6ZAD3YOhn4st3z/K3fRYDH
	+HC+1KnxGQtTKvAL58ySHavffNdD7t7/Q3pSaUfS2j3CHpoXBH+eA+MnXhbDKXHA
	a7vaAgkDI194hVhsD8SG9ikp71aT7LxLE83sv+oirApYy4/iKzoDkRV5G/l7i+GG
	jupOAEIKr01Z0+ilW5sqrSC2uym7H+Id9jctXoOh8n65nYGA6Hn7yZd26wC0vVbA
	8nfUkdUl1yNb8uCJiE0C8sZT0ajeHVPx2d/moS6qdCIZXJskglb0+FDkVUCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795547942; x=1795634342; bh=s+OH9lhBgZRjrCE8Hc70RM7unRszPH9TIAt
	0k84DVCA=; b=ey3JgZvxmkLTGl4yEvgmN1WXJGjBErwAIM40RFVX/BWU/hCLzIx
	FZi4Q3n10kbiaf3ENGRyni0qcsRf0EFjX2XC8TwAVBZdxaiROrDTKZ5goBdmGnvr
	dd7pcc2Z8E+OAQzASs0kWkvr0cn+QDiQVzeLdZ2N8kHqCgG7P0+3VPprytpGqp2v
	vTFWvyGgIAgspy7biHLXWBOpoRRyjwzpZAWyhfQHuS4tQWc1aa98taVkV3s+kdhs
	glKNMyOZo0XOgwkb63wMbKzDqHo6tWhUaYDVNnBltyOSL7ZdUT4kfWGQ7oGIE9B0
	WWMLYwtfvLfX2j0Rh+45oZB8XcT2ON8RCxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795547942; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Xii05r0ElPjJ/bc7UuOdSNagx4a4VhvYn8N8P1OQVMzLgZa
	j7FZ+cNL8ds5L10W+0+3mhmYWE5YnapnRti536otK4x89X9JkkCINerGBKiyorAS
	C1QhbZtwFijV17cC8PTovyZvgqbpUjIfEBQG9Sm0JZ70528oLwBtDkiHiDWgbpLA
	Cws9W3KBIuqRkT4izN/GYZVxHrgbskxrnPj7rctkwSCzlcOFNai3pBjg5muVUfuo
	RVuac4wSrwgOkC+yCoI+OUf9kAFWBxuMzZQO9J+7jy1mi1tzOdDJ/SM7RVVHGEPa
	5q0aCwEaTwO7ICiEuh0nQ2hwBEvxHt0P86mW/RA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XsSun9O7rf4cHSknKtJptWSHz1kqsWaRVOsSpQM+Ee0=:sXozPXZiEbiU7n7xLYJYh49tDuoukzXpJ2NpgcsmcRw=;
X-ME-Sender: <xms:JuMFa06q0l_6cr6No3x_G0Ib_iRiRvDHcyRViDqeskTsts7bz9eXBA>
    <xme:JuMFa4KbarScvmwQ7ENKbejxELhJSBhxMdNYyXh5XTPr3jHRWBD91veGeP1ZkM0LL
    fOGYYB6ohiIKbw6dJpJWSwIsEwBDv46ZzNgUPaBiDIjTev3CQgUyg>
X-ME-Received: <xmr:JuMFa1veNpwW2eBkY-m7I3O8M17uwZ8Xde5P0PSDz_YlK8TE1uPc8KrPASBqEUKS3NcBK9IUEobV-XOIW7bA8vsCErNUBnw36yEMNMU>
X-ME-Proxy-Cause: dmFkZTFt5vGUNwjmFcl5UiG0wmKUZa4Op222tSpalS9NLStpWVZcNmLrsVbN51DYPa3uzG
    6Ffwxr43TDFoavimOOAiSJpAiT1trBzzdmI1VragIRav3IFzoUSrgyS6qA7M5HCFNqW7p+
    6y8JJg4YfgXGAyAJ7tWMiC1jPdRbo6fh6bcG6pKJPVybw62EgtZVo6xlEk+2bY+/g9lLAV
    CwpmsxjbVaS3LxyuyVNTikO9CA9h1PXp5/PkbU26upmKuZwc6LdBfi9SA8+45K+8BCkS7F
    BTdxpI+Tezbdd4az9oIOZ1euh98NP0jf9YV8cypNvzrbxJ9jrGKaR3l0BIFfnA5lcDyEFK
    UXQSw3uFZk22S/ki9ThRxlIWyccfOofQlKFnJdHo2XriuublYd/7i1kXsWGxEXbHJl7XiX
    LSmT7ACbcQY83wKSgYPUSlsJjuR9rkr/PCoK2oj9KezqxQI4DdqHTYtpp6dT7lR1edNbWw
    Ao8uBcmA6zpJ+zJznX0YBSw+DYIPtTm/1MnDYf7K29oU11RcO9YC0Ucvn68QI5hkER7Mry
    Qnk7rcXJweMf9ILcehKR1B+EYtZYwAf8Gq3sxsgQKIoSyizXoUgr4lHpUFQRWbp3c4UKyG
    yVAeJUaEyt40yUvhyl0E+ir0Q7XWg1JID1cfD8dJAMGEDcE337v2hPvgvM3A
X-ME-Proxy: <xmx:JuMFa_LctUMf8eTVrDY6GLf_2ZzU8KmC2aonK3C26cPkaHzRKvdrWQ>
    <xmx:JuMFa29TvQs353n_7BcWBLuaQV7fUcClTuKgMRqtjiQifWHUBE0Rpg>
    <xmx:JuMFawygM5cPfr0WyqfrDZMtTESt_BVd8AKlGgsnV-FHo2gzloqzFQ>
    <xmx:JuMFa75IsClATPfAR8dRCp_OoJQ5aZErgvI6FOnRWurF4YwLSoOzAA>
    <xmx:JuMFayBcM4vwtkkJCMj8hxwmgzCUD-QTYWOjUKrGa8ZYPJcULMX4SzDJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 14:19:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org,  Grant Moyer <dev@grantmoyer.com>,  Michele Locati
 <michele@locati.it>,  Patrick Steinhardt <ps@pks.im>,
  dmnk+artist@google.com
Subject: Re: [PATCH] filter-branch: check hex oids in state-branch map
In-Reply-To: <20261119192316.2688525-1-dmnk@google.com> (Dominik Maier's
	message of "Thu, 19 Nov 2026 20:23:16 +0100")
References: <20261119192316.2688525-1-dmnk@google.com>
Date: Tue, 24 Nov 2026 11:19:00 -0800
Message-ID: <xmqqmrqyqbq3.fsf@gitster.g>
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

Dominik Maier <dmnk@google.com> writes:

> When "--state-branch" loads an existing "filter.map" blob,
> git-filter-branch splits each "from:to" line (restored to "from:to"
> order in 4811dabed7 (filter-branch: fix commit map init from state
> branch, 2026-10-02)) and writes "../map/$from_commit" without checking
> that "$from_commit" or "$to_commit" contains valid hexadecimal object
> IDs.
>
> A malformed or untrusted state branch whose "filter.map" contains empty
> keys, slashes, backslashes, or ".." segments writes outside
> "$tempdir/map" instead of failing cleanly.

Nice catch.  With an empty key like ":foo", redirection to "../map/"
fails with an "Is a directory" error inside the loop without calling
die(), and keys containing "../" can escape "$tempdir/map" into the
surrounding working tree.

> Read lines with "IFS= read -r line", and require "$from_commit" to be
> non-empty lowercase hex and "$to_commit" to contain only lowercase hex
> digits and spaces (allowing empty "$to_commit" for pruned commits)
> before writing "../map/$from_commit".

Mentioning that $to_commit can be empty and the reason why is good.  It
might help future readers to briefly mention why spaces are allowed in
$to_commit as well.  I presume that it is because a single 'from' can be
mapped to more than one commits, and the map() function that dumps the
contents of ../map/$from_commit file is expected to be used like

    for reparent in $(map "$parent"); do ... use each $reparent ...; done

without dq around $(map) call, to replace $parent (a from commit) with
these commits in the $to_commit SP delimited list?

Looks good.  Thanks.
