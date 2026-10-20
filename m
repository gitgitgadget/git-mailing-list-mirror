Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516310;
	b=NGF1d6YTWiM0RSQ+vZp+A84cetN43cnwojKAp892mNlcSInRUpHg4e1XGV5YHXhrhaQl
	 K8QELyNlKRXKZhaBmzaI3UL6NHnsDtsFEN0sYwrWufBOAt+aQCrez9qet5E2o4WgCZIzc
	 kT3hlbAfJ4P/rGSV2AMQjp6cuCIIV8HPcq+pk6nqCHSSpi/RmSO7uC4Dls85u6a/Bq9Ox
	 8ZqofQW1xi5WStOcSa10cFlh8LNRvwt3+vHBPUV+xVaXXkoo4JGJE45hJ5cEG6cdEabHN
	 RKVQYjrcb1nA3ZGIhd7mCPJo/LlmnUXfJ6bz4DOXqzD6HyijzPX7S1x0HNG8E/RIOtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516310;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=y5/a4kxtP8B8oO9chVLhJI+HSxp+tYyhB/DyWP5q0NU=;
	b=bc6sww7T/hUsZJIyl2jSh8/vlMYHW6ly+UunnJMLvuzqExdi1lc0zbnDwk/f072FeNKV
	 ++9/HA382qO3vLrJZKMjGh6cN4Knn56iUT5zatgTlikmEuJblpsDfEKbR3G7ryXRUNOfv
	 7r6HgZOl4EgPU+EHWobulgj9wn4B2jfMckkQoIhJvbNsUYErJazZkyqXr5UWdAYoN0qkF
	 Lgf3hAxPzGPh8uuwcof7a1Oe4R/5m38AkIC3HEvWsFR6gbFQEnCYqwczzQbSiJRK86xzx
	 JJZYHOQZ6qxqRzHZ+saL6vH+tx67z4wbdOkorA0dWQ7Ed+aS9O3JEGNxoOrAdklbQAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=F6QuQMfo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="VtuwQ/yO";
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8460A2602
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 17:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18F8460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=F6QuQMfo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VtuwQ/yO
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5924B14000B0
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:11:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 13:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792516309; x=1792602709; bh=y5/a4kxtP8
	B8oO9chVLhJI+HSxp+tYyhB/DyWP5q0NU=; b=F6QuQMfo1HamNKfn6YeIIc5XCH
	2rs3req8+6lElwFOZdEUICuttXUXtDAa87CXd+NWSq366txH+Yffl6NOPjt9rPCV
	hmo4ZVAAoWyb7sGZ6NyS8hjMPawDnwLl36hYvT/hOvGZ556CZPe3prLef+6m5Sr2
	Z45vFEhhP6T1mIPVdp4c9NcXXwqHgXudYKAIde5+BkSkxWmhL89ucFxWzHNEsmRW
	ccFnCnXxL1v5/9VsIknULfr4yhck7tnc05mo8IggER/5BjVxf7XLP0AHYvZI42rl
	zmhy9mol+IH8ZNzwML5oVj5hFzFmrqxl2A5nFebZYrHcQj2bzojA0L4ftPww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792516309; x=1792602709; bh=y5/a4kxtP8B8oO9chVLhJI+HSxp+tYyhB/D
	yWP5q0NU=; b=VtuwQ/yOF2MumAXH4K+Hl1cQ1QUu0rg4CthXojktUcHv8UJat5t
	eHfcHA0jncM+3neeFRlDHW0hwBW+ok4MNDwE0O04YLbxBFWEtOI3h7UwNagZkCaF
	BQLCcUwHmXMOYaEBgD7uL8Y4cNMhke+kvtNkw+BPMd9nLvFWMOazN+urDTJPBV+g
	QZHes3Qk94aSV7ZdyaaDwTAnEZQIfUiuk67OXp3WN/gKAIMv2kuEEsb4U6igVkG1
	4+XXxtF39g9681ROhVGNRFsJ7JGvvOm+Z0ov5gJtcPIL091Rq7DozjeSsNjSbFol
	Fi0aj5w4vCOodGbgGV0cD9xXEfNpP5j84Mg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792516309; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:e5Ytj3XIvq6GBa2YoIOwTHmAX9g8CBhhRnMxWs/pA2/2ydz
	t+fhlHxa023twWKHntWKoNaSSzAFjjv2CklgxPcJLl6NSxrhlWQp9PfLu8iCjgDt
	E4q7mJ/gAu6W6ERyXYVCyR3SaCpmThuHptiMZisOfAgXLfKzvsSYhBapO9YZi58D
	UhFh76nrTj5WFnAYJGghniy+1vi62G7BE5D+vUXb6Zt/0ft8JqiRhCxYDgmgCEmK
	SvZDShQgu/lc2ACzESDFB0wZ72vkzixEt60IWTPpd/opIBuf4nX0XfHylFFQYLiu
	FQvQXkFV+qgaeop0kDh+HVdSIHwJpoYzBsZBnIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:An+QZZ4uZVY2MV4iygwsPzlB8z9M1yXtCzW4EznioUM=:lxTY2eaBO9oQa4Lp+bRnbFzjTXMtMr71lmQBLMFGk8Q=;
X-ME-Sender: <xms:1aDXan6rHdJKottuHJPEfXvVIBkA05CpVakDmiei2iH_u22L0R4XhQ>
    <xme:1aDXaj75C955ef-ALMncYbMQmdmiS6unXaSTFoQ-eC_A3DxsoxtNtQj753G52utZ9
    EX5_WjryxcibDzm_NzkMl4ZeljQVfsLAK2FlvQQ-CnLT5iTHO_fyM_w>
X-ME-Received: <xmr:1aDXajfhGESGoLkemfeZybz4rSPFZ4EkaYxm_Guh5R-8Ugn5A7y_B0adW-FVQhXVvFO8phZKEp3jM9WtV8SdM6my5e17Q6zoVfJq>
X-ME-Proxy-Cause: dmFkZTElFVQl3JSfWxU1xybzKR5j9sv6OPQBHBW9NvUxX21wiGdNRA39Fj/mqCGetNO90q
    qRbDndUXkUD4JSjrFVdmSF0BCBKiukby3n4jfSpOiu23e5Ktve+TBk7cgXqn32P/PEIQP4
    gkTm7MUCjtFJFARMrsj4DJlEYQgLmUdqup26QIOZG3Fpb7VPBF/qpEz44qZB5rC9amW4Ga
    h6G9R/Yle3eEEZSRUMjJO0uRwx9sznAnhVtCgKSS1YrwbNYP0Fj2EF62+KJFQYO1V8WPrt
    yNJBrQXWCTNA5Dn1UvtStYl0hhY+cs/2EohAkt32m/XevHRu6p697MbXcrEuGj5jVXypZM
    L1NTJ1d69iV97Msn+3IfbyjprmdEWEk0Nc38do+sdLX5ORIrvpmxcP7cbcb4NR/4BIFqXb
    4hlmnH6cgvvtoSUChmsO7dO7RUnKBsFCU0sYUOgmCoh9nXtVmF0uS/JAGbiVqHwLoSwt4x
    bz0515KQ5NwoFlGzxUeQZg0wCzbLsA/ddweFKN/USh4OIBeLwqFzlVhNyBDY0tNX1SER4z
    qEp0gxc+k3q5VIBokqx7yc+bzx3jvdA0AWf1+aixm63+7yltkG9AoOHM/OWrwJywfQhAW1
    33u2lpaylvleK1h7AGfMHv3EafhTzZitbV1HOBkMUSJqLB3aq4+pp5DQRsLQ
X-ME-Proxy: <xmx:1aDXanBcw4IzIzIoYLeSBtS8aWOBqpUtj477YVOubxHEsc41t3OhTw>
    <xmx:1aDXam8xvDZFxdM9qO6_bukm5WcFkVF9VmEi9FjlB0BsbndEBo4imQ>
    <xmx:1aDXaiIUdYXfVYb02l56LqzZ6Em_uBY7SHB0TzXadyB10DqUJHk6-Q>
    <xmx:1aDXavgxM5bcxSWeI8w-PwK-F2FobVVxIE-9-mcP4I6K53ag38WjKQ>
    <xmx:1aDXai8SlrCl61mMw3ozB0xj9F6JSw_9UGg64obT49owf_QC_YM4YzdK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 13:11:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 06 Oct 2026 19:37:02
	+0000")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 10:11:47 -0700
Message-ID: <xmqqzew8wb3g.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> This tutorial covers:
>
> 1. Creating an empty repo with `git init`
> 2. Making commits with `git add`, `git commit`, `git diff`, and
>    `git status`
> 3. Pushing to code to a Git host on the internet, including creating an
>    SSH key
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---

The goal is well described, and overall the tutorial is well-paced
and avoids common beginner traps.  Since Ben has covered the text
fairly well, the remainder of this message has just some leftover
nitpicks.

> +Step 10: Create an SSH key (if needed)
> +-------------------------------------

Even though AsciiDoc implementations are somewhat lenient to allow
difference by a char or two, but the number of hyphens there must
match the number of chars on the previous line, so add one '-'.

> +For Git to upload changes to another Git repository, it needs a way to
> +login to that repository. One of the most popular ways to do this is
> +with an SSH key.
> +
> +If you don't already have an SSH key, you'll need to create one. On Mac
> +or Linux, you can check if you already have an SSH key by running:
> +
> +-------------------------------------------
> +$ ls ~/.ssh/*.pub
> +-------------------------------------------
> +
> +If you don't already have an SSH key, run:
> +
> +-------------------------------------------
> +$ ssh-keygen
> +-------------------------------------------

It may depend on the system settings, but doesn't this by default
still create id_rsa.pub?  I wonder if we want

$ ssh-keygen -t ed25519

so that it will match what the users will find in the next "Step 11".

> +Step 11: Tell the Git host your SSH public key
> +----------------------------------------------
> +
> +First, find your SSH key like this (on Mac or Linux):
> +
> +-------------------------------------------
> +$ ls ~/.ssh/*.pub
> +-------------------------------------------
> +
> +That will output something like
> +
> +-------------------------------------------
> +/home/alice/.ssh/id_ed25519.pub
> +-------------------------------------------
> +
> +Copy the contents of that file to your clipboard. It's important that
> +the filename ends in `.pub` ("pub" stands for "public").

OK.  I hope users won't paste the ls output above instead by
mistake, but perhaps giving a command like "cat ~/.ssh/id_ed25519.pub"
may make this step harder to make mistakes?

> +Then login to your account on the Git host you chose and paste the SSH
> +key into the appropriate place. Depending on the Git host, it's likely
> +under "SSH keys" in your settings. If it asks you what type of SSH key,
> +look for something like "Authentication Key".
> +
> +Once you've done this, you're done! Git will automatically use your SSH
> +key to try to connect.

> +Step 14: push your changes
> +--------------------------

Upcase "Push your changes" to match other steps.
