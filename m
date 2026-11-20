Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201412;
	b=2RkxW+QJUbjOGKeappcqbqtcM2nElE4LzEonXFIuUOYip/pJc76acbF3junmq8sy/8Du
	 m/6DUhVa3QlzP6sMs8Vx8JcjlR1PusHEs+Ec09O7S2KegxOqWshkgXPc2XOQgyOsC3m8e
	 /MOkU7XsXGrzNR5tbzV+Xgb8tK4lTjjnDb3+khtFA5c1ESBlYvWIGXDi06h9gPQZf5t8s
	 WgP/+DX4rPTC/FIRSnS6v8Zrt6/R59X4BnDtEQ1P7JUd4fMAOwdRuzuPtft2EEZlEndOZ
	 HcLBWbwGVtLRGHpuSSNawczU0kFa/bfqiPg4tYBl2GexdMfGN3cIOBpsaNuq5ig2F3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201412;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+/K+qBNGhU8h9dl/eQvbNXBQzxuc8IQ4nCyZsRUgAkM=;
	b=zmVdwImNnIZwOydvJ0ehE3gxeDYFKSA5S+9hX5V1x+PChSVNZ6tX0bZi+j3XDjDftu5f
	 NXB4jBe6BEmO+q4YCLF+8NLk0FPx778Efghn4tk+hf++i3Z4d4M1gKpiZr9N469auzxPT
	 m/cTbs84OlZiWf3YDthyt0LTAKbDniZ2PsKi95X1+YRq74RjxYeIDEr/vDAKEn7LCfRpX
	 MYnysytRFO8L5Z4ScOFnp+PpDk9L14EKbSpGIQGkDnzOohmIJlpZ+BOiPQ4ddEsIkioyF
	 +G4akBHafrnP3wJKwQl8QcpzbHqgJ/7cMu6iIQadh9HfU2J7pCt7p9hN6lnERceWmVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Fwx9CUqB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="DIGbL3/3";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16347606A338
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16347606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Fwx9CUqB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DIGbL3/3
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A9F41400106
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:03:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 14:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795201411; x=1795287811; bh=+/K+qBNGhU
	8h9dl/eQvbNXBQzxuc8IQ4nCyZsRUgAkM=; b=Fwx9CUqBWnUBFlZqZ+0+/s8A+f
	PDVCg4PVoscewvwairrUFirc2tKF9/gKiSbR8b1VTP8EMU7bgzgYsaTXuPpGY+gl
	kOKKC+2HJ2m92hkQnrvZabPL7PkVfDLuoqUuaj5vnwLQQ51Mf5sQsRzlfn/j4SMn
	Fjwc+t6brBIIUzJxnhWSEp61e1ZnbS4uQLDEJDMe/eUa51Bv0zy0xmBbKMk3wDlD
	6KvvXGL8nbx2i1QLealnWbHc79X43QehL6y80VaY1ai5+aQxAJZLc1nkOuXKAHyg
	fINjHRo2SF1t5wAU78ShFqTSTxT8n/ySdUOVsjw6ZEXNoNg+3NlsSw2IKO4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795201411; x=1795287811; bh=+/K+qBNGhU8h9dl/eQvbNXBQzxuc8IQ4nCy
	ZsRUgAkM=; b=DIGbL3/3o+8aw1+QfGlwu05PQyY6AzfdDaVODbf/IfK3ho8BZQ2
	Im5apW8I88snbDB23MeCn1O8gaVRDXYVpjdJjRyVcfLDEaITHSqW/s09myo8rU++
	u1UiWCZfoGwL0tNfSwx4Pm2xBtUBIoYi1fJjmWYVm7ybJFv7n/mf2TyOQJSdBqcT
	dWJ96gDaDb4L0UGVrG8bR4VNGmjNDsRUvTnSLdJG/pobbGRYy5p2MZyUEOJUdAc3
	HgFJcyvLjsE9geMc5uXkzTcerak4AUeu8oBYcgtkiHL4fubifJdSUwTihMjEDg82
	Hk5mxaGFj5Jfm4ez3C57dStN/5ME84aJfGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795201411; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cp9OgCX5vdh2jJGD9jrzPcoOVlU0tiXhjYWyA4/JwJE9Bto
	Xd8u7/A6hiF0YnSc19BWiltwFj0jiQ6FaEhFss+3oV2cqlCmGjl/u5+47lXVnO3L
	wEe+5CNxINBbXX+YBfHTxb2rPriMt32TxfnWbbbuCkqSfCfZwhJp7sHm9YTysNq+
	Jl1FQUJIPCrb0FxbHb/Dj2VD3bMfaRyPl2gfaXVq8oImhEHpPBrZ6O7d/2bsRMsx
	ykfLtjPPtleK7QhFJkS9Bkil55MwDxGBHwqjEVCv5LihXBcgGBzqqrQSFIn7rGkF
	IRwbblarnifZ61ui9DnHqH5P5SsXiLLIHPhRbNQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jGDkKJEqWJ0vejTKVq485K8Ahuj+V3O0ISmS2NK+vGk=:cg6nFBHogp/t8xGgquv4nBxe2VYD9sNu4hdBm0+J0nA=;
X-ME-Sender: <xms:gpkAa7LXwan_nGNbcW8tdXAqUXKm4dCzHGCSLEO4gpFycXrYc_VZMA>
    <xme:gpkAa2KDmQYLJaMrQ5iuJgEwMeo4AG_VkP27QuGBCmVjlM1JckoW9fOvUwVJKwIVw
    83I3x9_XWItzNVjcZWRNYGQUnAWEL5teLT2RTqqZJGDZfZvLrb4c-g>
X-ME-Received: <xmr:gpkAa4sKqUNzSw5QR98yKN8uFt5ADS4-a5EOCDGyfiaZWReIzkKzJMRjMyIWt5YYySE1sH62H0XjIjpV5reeyE3T0jmV6kAsMRqO>
X-ME-Proxy-Cause: dmFkZTGjVQHlsMfpDn18KIeM0XIeoAMj5JUU8KAukCBBtQ64Kd9ijo/fy2kOTqWKXInuhX
    eXNmeHFmfbYM24AMEMU3T9FyGbLr5Cs6Bs/yCZMzNvaQoL+1YiYQfrz7dkhb9BUayfgqdg
    eh3X845GTdPz3T4Fgnob++OBFgRTBfx1ZGSGVQlKRnPhnw4sjTesrDKpJ4CKVM2dQkvzg8
    Jo48ocI4LbeRc+FE9fLUiqF0jHchw/vzhXNa3UbsqJHPEHxhG3B7mM8r7ViwvcMsN8B5td
    Y18ZbcT/fidtM7sERmfqt3aHxecFlSxvc3S/t3jpJh3/OQKIuyHyKbd9Mk14YcWn0yf3LP
    b9D5eyiorDtqEt1ItPYvwb37hMxk4GsJECMYRy+w4hrjEGP+YqfHHEIqaWMsFJItAxDFHZ
    rzmURxNyXGUKB2m9ebAd1bqGR3pFKqxTgJ79oPhiBThgLABRk7Lj6TSufJ7sMlH75rOtcN
    O49WQldZNNrJVu6YDb3weH94ax9QTq1POZmlm5t09++1kJpRrLZGQebRABXav4bOp9/JND
    AGuXPpAEGOdXkq9izz9Bw1qGlXsbBs+fB+CB9r7XSmXy9O8t6byYaAUxYDMDoUIdS623xT
    A4mnnzSsGIFOkyGbUSczT3Q82TC7KucqCZ6QyNa4YELlOXNX7jS23OtImX8Q
X-ME-Proxy: <xmx:gpkAazRttskBTsglcbfs0hIhF2lY0w0V2OoaJeTG18om8I5BBRk57g>
    <xmx:g5kAa-Ns-jkeSYoF01wzoWOLhYhqlceDs8jt2RdEupCp1F0iM0qNPg>
    <xmx:g5kAa4acTjd5dQlDbiZE120JYdskWMyOfWzxfTIw_JLl9I1uzxjNRg>
    <xmx:g5kAa4wcjDQV50UXqoOqf-KW9TR0HOaXiCC1DKlv2nk0klnnaCv_IQ>
    <xmx:g5kAa4Oso5DW-9wOSIr9XECh1GiKIbr-mAWWc87KHmX38YVmr26-8G-W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 14:03:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ophir Bleicher <ophirble@gmail.com>
Subject: Re: [PATCH v2] doc: fix AsciiDoc syntax
In-Reply-To: <pull.2496.v2.git.git.1795199746309.gitgitgadget@gmail.com>
	(Ophir Bleicher via GitGitGadget's message of "Fri, 20 Nov 2026
	18:35:46 +0000")
References: <pull.2496.git.git.1795194752259.gitgitgadget@gmail.com>
	<pull.2496.v2.git.git.1795199746309.gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 11:03:29 -0800
Message-ID: <xmqqtslbpbpa.fsf@gitster.g>
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

"Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ophir Bleicher <ophirble@gmail.com>
>
> The Documentation/MyFirstContribution.adoc file accidentally used
> Markdown syntax for a link:
>
> [here](https://gitgitgadget.github.io/#...)
>
> Fixed it to use AsciiDoc:
>
> https://gitgitgadget.github.io/#...[here]
>
> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
> ---

The exact same tense and mood suggestion applies to this commit
message, too.  "uses" and "Fix".  I can locally tweak them while
queuing, so no need to resend if you are OK with it.

>     doc: fix AsciiDoc syntax
>     
>     Difference from v1:
>     
>      * Change link text
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2496%2FOphirBleicher%2Fpatch-3-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2496/OphirBleicher/patch-3-v2
> Pull-Request: https://github.com/git/git/pull/2496
>
> Range-diff vs v1:
>
>  1:  748ac69283 ! 1:  cf26060e59 doc: fix AsciiDoc syntax
>      @@ Documentation/MyFirstContribution.adoc: either with the "New pull request" butto
>        
>        The differences between using `gitgitgadget/git` and `git/git` as your base can
>       -be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
>      -+be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[here]
>      ++be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[on GitGitGadget's official documentation.]
>        
>        Review the PR's title and description, as they're used by GitGitGadget
>        respectively as the subject and body of the cover letter for your change. Refer
>
>
>  Documentation/MyFirstContribution.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index c58253fd54..73dab5f7c9 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -931,7 +931,7 @@ either with the "New pull request" button or the convenient "Compare & pull
>  request" button that may appear with the name of your newly pushed branch.
>  
>  The differences between using `gitgitgadget/git` and `git/git` as your base can
> -be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
> +be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[on GitGitGadget's official documentation.]
>  
>  Review the PR's title and description, as they're used by GitGitGadget
>  respectively as the subject and body of the cover letter for your change. Refer
>
> base-commit: f7de81456940dd6f3274e461149bba12965de609
