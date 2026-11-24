Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532046;
	b=xWztjUzLao1Plh4hOMZ/8y4OnNG2xezsoml5RmUfI/dSVxA847Kqp+zuTnN3sUS8fW5r
	 oAQLCFewWeDSW7LiyN+/duOqJpeGoRuzGOMM6L7MncIMCnOrKggp2gtfFZNccAYXK7Y0Y
	 Xn1loxVITbiR06iuXZf5dyM0QEE+yaAjU0vB+/BX3CAifHk8Acy4pSnhb37e3/sbsORr9
	 cqRgNz8y3Jr77e7J7BFxAeVxxaCeDoQUl/coszfKZf+bZxVjmsFXia0PZQxcrIepwrCv3
	 cJ6hQ7pKUuI8JAByc73olleSnlC85+AhDxOsPiAA6IR4qZWluPll9k9aXvmfyiqKs9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532046;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=N71SIE9mO+LsFoIZzp9im/biwFiSQK+RANGV6khL+1c=;
	b=2upfUaFg+YbbqN4MNkQ0ncTB2mrBUmEPS2K6QzJHn6dRAX6G4UdTqrqQKzlOJTPLMs9J
	 z/q/SftwzUsY1Oj1pNaN864aPBQgcdYDwmSg0SVzaJRBww8FNMPlI2rhmnOkoGkPhI3GN
	 /x0sJVdsqy6NaaGQLHmfJdpVJxaOkIK7lBbKcbC59jzBIux0G0gEOqHyAiYHTwXam6PZ5
	 3HDiGKCAmabGceGW70zWjaVyjBGORv6B55E3MJ6PCryVKOAQZI5FagMplVwmF5iDTgZMN
	 BOc56RH0r7sM3Tn9kE8nxwxqKs+UcF5eXHmKH20BwCY5N3NyMiVlBwDfb43dzvl+0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=P7syKGDL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cfx7oC14;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6E7606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F6E7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=P7syKGDL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cfx7oC14
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 373BFEC097E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:54:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 09:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795532045; x=1795618445; bh=N71SIE9mO+
	LsFoIZzp9im/biwFiSQK+RANGV6khL+1c=; b=P7syKGDLpUjnwARqVLilTovr3H
	A14b3cRzTXvD08WC19A9DAKS0aGVqTIT1TZ2dvtjhlHumOiXHRWCddoretFGaUUV
	mkX83OVQenGsWiIq6cx7UXyVwSYXmH+bQgPhCdDpzd7JyMNujNwqLzYjcB27yMNr
	BCZSBQDzn/cSZo8EnUwvx5807nMFNaf2T7owjrjj5YtjY0X97bqoCr0bnmUvz7qs
	vpUYEMlQfHKQSnGm7EnXDOlCoF+UQKByvtY56tbJfq40vrFRAZU1EvuLXWWaVbVC
	JvCeY8mqJFpJ8JR3F3CGiuXd9g1m0i2Oru1CdeiMAuUadjWVVQh5hRIF13Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795532045; x=1795618445; bh=N71SIE9mO+LsFoIZzp9im/biwFiSQK+RANG
	V6khL+1c=; b=cfx7oC14E0d+14GL2IvYGjpTG8MVYrSOnINAadlzksPj3DGcm/K
	6FOGL+4eCApd533JcD44+fzBu1XDgE+yuPl5dFOzXMXuqUVEMfErEVKAhQML5tuk
	yRmN8z03GYzddstdGE+k7f3YryrRB626f7siDhedNH2Yeh3/vYx2xk6vu5WU1zww
	4bOZN2rKxDbQgvcHeVqH6MpQmOBZLT7Kow3PqRay1p/a3XeWvuAhIO3cHGSbPJ3u
	DvZrhFKtT/55W1OTBfiIolrZq66NMp+JjNJ7nq5bx8y5N+QOfm5m5yWan3xtYYPg
	BcaJ5z/s1RDE+eryBAO/oiPiHRueqH1UweA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795532045; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F1eDTeOwl74dZGLfC9zjtcJH+B52ShZBfvzcPsA0cJC0xsT
	3OiBqBGTyR1ym/K/Ta5KBCcvLwy6zWCdn3L0g3PvKujP3R5Dr0tDj6tiCTXqcmr2
	FJ0HsZonf0iTgSXgXI0gZSkYttYzLDFXvzoPutJuxmVTNBDiaYOldVALkuK7A9+1
	9DPag3vUs9jLQDQjyuC29a8EYUlBiNtr5MM3YqQNN5PmIsjcdi/Wn6clx9reRDnX
	YE6gsNx6d42rvY2qg1E3dRhzmHcTdFthnZidQMB4oJ3OeViGpiFD6968O3FzIhXR
	eJqm0DIfu2Z9Ro+8YBiyvim+nKsezJlFlu39JrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UIb9u0B39xAO67bnnkl+PEw2+nvao7BiwNvBKbD/wms=:i2gVszpxW9MYaiVCdq7JOPkboH44IniYbGZUuKm3nkw=;
X-ME-Sender: <xms:DKUFa1-vIDl0yiF0W1D5iVQNa3OTuAW4VPa1RAdeJn45rYPbNRBALQ>
    <xme:DKUFa7Mvr0P1YdByGZ8g2GbAATlxJkHWi1C2HaHCkUa1PW9KiUvw-zYSWHyLrwSEZ
    RpG7mFW_0PeWrrdvDyVfTU_W7ZHvWRJzVkM27PY5IIU8TZiZtO2bwk>
X-ME-Received: <xmr:DKUFazHei57pD1_KhdnZqsA7aPxqMRx__SbMon2VJGLERyRaNATwwOp2xLXg_SlpR9JSWFmHWiFqNoBaFxEPRotQIrvdVrnS9B9IcsY>
X-ME-Proxy-Cause: dmFkZTFnlqRvzqAK8toxIOdYsC4T8U6DSW+Yohkv9YwpXaSDg2twvwxyK3/1oJAnHR6EuN
    hN9tb7wQ6z1K7WaCDlwUAwvOfAa8ext6KK1H9yaPz+FlvFkGa7lZGjjmZLy/5J/cmvqMhb
    jGGv95GxEKXea/R75IYLN3L968Rv7AJTrlUFCizPnTvaREUYJSgjfpwvw6//hS2g1YhuXW
    wy40+koae1DmE872QM/T3hbSB38UTpR2N7x22L8G/KPF2L8mWBr6AFX3Cs1LpijgcFr2ry
    Pik/mrWqRAchl4fJDy9Qw/oSKVeKj8oZVjqvCuHaVjjaYrkirTdTlUOstqs65mUaAXwveg
    /ykNM3/4uFzK3V/so1PqjNkVKempco1xN+dQFKydkXx4Wts1nej7jyV0VUXh9aXLftlFco
    VpDsVohnKlUJD5MNSGzAm+pbglv0Tk95WFkzxJYqMvT+NwSxnZqYL0x444viiDxsQhIvN/
    V7o7a3WzEfh78fJzqzn+KkIyWZvPNTM1qe0HuwSsINWRujYKcHq8GD0zc9+6WPhPeCKzXX
    F/Gb0xq8UxPT1qSZB+l+KkU1qWKeWTR30LRIwQN+9r7XJEnGjoUbBwVEyCWZIbKkmTB2Jo
    MLLZYTTBde1NxYCZafOoHqCYEAgDL8M4LxN/X8FGDcBWE1vHV+qGYYXIXywA
X-ME-Proxy: <xmx:DKUFa5T6VYJnqNdrxS1YEFdD4acTDrIfZoasBcVrOV4OVoGad0UUnQ>
    <xmx:DKUFawvxZWz1ClLLaCwl5_1yLzKfBJ3ZXToGoUa7b-FnaEPg6aGnyg>
    <xmx:DKUFaxLFjHWnK_sClFye_3EwIREB5pQADsQxwVuyh6iggrlCLCXzKA>
    <xmx:DKUFa1lvWRe5dXMYb3Geyem_uo2Ew747GaRP0hemuzFRaxXJLCMrNg>
    <xmx:DaUFa7rro4vrm0VPs0gbtn5-DUvEbyTRpjS-BF8L30fYn95D41k_PGLB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 09:54:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Wonseok Oh <wonseok_oh@korea.ac.kr>,  Wonseok Oh
 <marinelay7@gmail.com>
Subject: Re: [PATCH] sequencer: reset saved HEAD OID when picking onto an
 unborn branch
In-Reply-To: <pull.2317.git.1795242633923.gitgitgadget@gmail.com> (Wonseok Oh
	via GitGitGadget's message of "Sat, 21 Nov 2026 06:30:33 +0000")
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 06:54:02 -0800
Message-ID: <xmqqh5h6wa9h.fsf@gitster.g>
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

"Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Wonseok Oh <marinelay7@gmail.com>
>
> When picking multiple commits, "git cherry-pick" stores the current HEAD
> in .git/sequencer/head for "--abort" to return to. If the branch is
> unborn, repo_get_oid() fails and leaves the object ID uninitialized,
> but sequencer_pick_revisions() saves it anyway instead of clearing it
> to the null OID that sequencer_rollback() checks for to report
> "cannot abort from a branch yet to be born".
>
> As a result, "--abort" errors out with "Could not parse object" in my
> master build, while in Debian's 2.47.3 build the uninitialized memory
> happened to hold the last picked commit's OID and moved the new branch
> there.
>
> Clear the object ID to the null OID when HEAD cannot be resolved, and
> add a test.

As Phillip mentioned, the commit message can use some clarification.  In
addition to tightening the first paragraph so the relationship between
oidclr() and sequencer_rollback() reads clearly, the second paragraph
frames the symptoms around anecdotal builds ("in my master build" and
"in Debian's 2.47.3 build") instead of describing the general
undefined-behavior failure modes.  And the final ", and add a test" is
filler that does not add much value.

> +test_expect_success 'cannot abort a cherry-pick sequence on a new history' '
> +	pristine_detach initial &&
> +	git checkout --orphan new_disconnected_seq &&
> +	git reset --hard &&
> +	test_must_fail git cherry-pick base..anotherpick &&

This cherry-pick will fail at the very first step.  HEAD stays unborn
and the abort-safety file would be empty.  Even without the code fix, if
the variables on the stack happened to be zero-initialized, doesn't this
test pass by coincidence, or fail in rollback_is_safe() with "could not
parse abort-safety" rather than "could not parse object"?  Perhaps it is
a good idea to check how the command fails and with what error message,
not just having test_must_fail to make sure that the command dies a
controlled death, plus validating that the sequencer/head file stores
$ZERO_OID, to harden the test?

> +	test_must_fail git cherry-pick --abort 2>advice &&
> +	test_grep "cannot abort from a branch yet to be born" advice &&
> +	test_must_fail git rev-parse --verify HEAD
> +'
> +
>  test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
>  	test_when_finished "rm unrelated" &&
>  	pristine_detach initial &&
>
> base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
