Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262809;
	b=WYPec2UQfQ6TDLo06Th3Hf3YxlULez0Y6T2Te33mMCm7Ly4dCnsC02z0nR4HOcnUf7Vh
	 ZqEUVs19jCbrLpFRdo/F+T9ujRqdgrLWl2nJtlqhPg4DBAQhk6vKQtTlMRV+rvk6dg379
	 OdnhAeBzWlOaiqH5/0vujWngFaC3y8vGm55RhZsKF/8LL6d3b4c59DtsCnYZN2dHWRyAc
	 L0UQagUQ7rgFSBgNK2mgpHkbT6hNHpTjf3XkGBg1xVSfoqR24TYLE7qyEE01Rm+SuS8MU
	 I8kjPxcAczNQuZ7hkNW+mq1MqTzrDJ8lqDb38zcy4iLb5Tqpvqd/m9v2ES6DBUTlEAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262809;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=72crIYnrSYnCTsw5umskQ/ZX7ZMlYnbBhMHNqiUMwQs=;
	b=zHUh62vCteou1L6cr4sMsStQMg2Ax9wPMRM7zgURvTf+hJb4jEHOjm3GYUKJx0Rtoa4N
	 35/BlEBd2+TiT55T6KutKK4qm/u/e0RKqHdmFOwvjCivU+9rcP5+0lD2kupuSvppzpsa3
	 CZ7qn/RFh9/NhY+4IfSMJM0yedVAODBPcKBu9Wt1zddAe5ad+3MiD/fJUw7WTWJaTPUq4
	 MztYwHflAn4YBQFhIJyMfhv1L2nAP18F659mm5yLApwxACaUsake2L4URVbhs3YsQeALF
	 bT70f+ORUlUMti6JfBkhVmjrKCtTVt7KzpyVONjp4XaZGbGTZLnBCm8XbSjBDsk8ZcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QQzuwYlw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hc0z25Nk;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593C606A332
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 22:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A593C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QQzuwYlw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hc0z25Nk
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0288E14001E1
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 17:20:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 09 Nov 2026 17:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794262807; x=1794349207; bh=72crIYnrSY
	nCTsw5umskQ/ZX7ZMlYnbBhMHNqiUMwQs=; b=QQzuwYlw+8Rrn2t3d/YlNKZmIK
	VHthd+YiPfM+4ftBGBxPmpsDqktqxq+8MOXCB/+BnoMCyyPBaCbiamVf3Hl52Jga
	c6zpdjTiQ7Io+tYoCLZp1lpcnxagpQWKcQjnQ/i5jmT7Mg+XoXPVvU+YWTYWKMs/
	PxJPJS6TLKRjB0MuQUsIorPI+ZgS18uXFqIJU4e5U7TUiwCE9Z/8h42R7wP1Uc+l
	nUm1WXH6psSTJE/dzblPRf1SBcsFLScqjCGrqDsYu/Zj0YqtGKU4MP2tRObaCgFV
	RekOxGbDEAyGhD/TVIhuToOMIs8fw9Wja4pZFJJbEHEkme1LeBS6c4olbyHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794262807; x=1794349207; bh=72crIYnrSYnCTsw5umskQ/ZX7ZMlYnbBhMH
	NqiUMwQs=; b=hc0z25NkzxyUn3bxwb98Fh+0Ysnd2eQKbc+YR11tD2Q/cbaTG7y
	iA2rCdp4utab1g8YKGVMiSLQSc91dBRMhAXOk5/LaBAKrgY9+5ENh87XQ6njVcEN
	38hOl6RgU1cfOC8i9iicGrO3i3gM5/rc//WZel+Z2Pc/v5FBR8xlL3zJ3oDQFond
	O+WQsF8V0ivJf+ARujb6y3TfPOZdNi7i/EgSDLZw4u8ExLl8rVti1JQ0x6rmcLI9
	ERyI9gkIVl6NgmgXuBBU3wbmThbY01yGxxBFzZ1XpLo7zSnLo8p8hnBQU1oVX2Jm
	yNIB3bAf9JbFANP7cZKufU8FzI5a2Ilr4Ig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794262807; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OcXCe3PdtJDhYsB8SG8/hZNzcDOBF4mgLqZ9zK0FEmaCPzx
	1P9KmzSd66tUBUSy0PwfLH719GnM0/2tnlgBuZfWlP7fPkJB3xrxvtcxhZtAiTiU
	HAdp0Ueg9yF8U3YHJlEB1M8e8LSZpXCdpP/w5tDaUFfo9BgL2ugftr1lrWmxAKO5
	r/pHvrTWZUuToJT6fmoIksfOjCMZrL5P3FCLINZFvED6Q9f6dhI+Gmf+N9yHtgoA
	B5994dBiafP7tFJzmHoDkK9neUxcN64+BWirSKYMSIxbORZt9R4KBeAbLhWF6f3e
	IgjP5h+2JO0nqbS1jiLgBlZBnLNyVj1nkH4Vb8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5G/n6Oc+CbWlsPkRIFgZWRvvSbMX6oSim/+8tKYS698=:vlkekslM4yArclMU4GBkoXHF/73kIhqvcaVhHM+Jsjg=;
X-ME-Sender: <xms:F0fyamtFGxRXNm2Ib9F5Fkg-G1SPAIXA0LbhY6sV2R57U7roX4lsTg>
    <xme:F0fyavLxD9Dor7OXadl9t-AQocSy7t_bQecooMyk7SjUCZL0kFOFOOxf2mat7PIGI
    y7jhVk8MTt6d1wkbJ7elTeNba-zu70Hp7j5q9prP8dOrQ8ZS58DhQ>
X-ME-Received: <xmr:F0fyarnKBBq738PgqLxK65kEjV6S3XnRGQI8uviyJeRxN3BjpjI9-QyR0rldB46p_iisO4RLZ6uzXBdotxkaa7d2TJcd8s92pXX5>
X-ME-Proxy-Cause: dmFkZTF3zYUrIdxxRZtt9x8k0GGLkTE0Gu7n8835t5+IX4HKwr/W/tk+cc8H1+P8APkp7v
    ZWVLoltXrDoJfnC/9ifNhI9eqfn7/7Ou7ZSM2V1a8MejGrs2iQkowZ149i59GIPyO0Kb/m
    hxzgVQMQ4PqjM7s+TLqWDcZhL/Qcd3Zfrd0NuXMsJExAdosZnZZkSwpBrEU+g2lGXVSdjJ
    JDVqJeN67Kb7qATbv23iSQ037xA68u9QQOAyjASDhKtsyTui8yFhFBwtl9a3aznmYi9B2A
    2EtYAjrEAW6CbTjSu+6EN2K0P3Cl/3mbn8P9V8UJfLy6UDaATcC/fE6B68HB9S20K9U7Re
    dVLCT7k4mt+kXU0XZphZbqt/xXNpY0E9TaQqXnjhWTGwuEvqr3pUmlyPq1EGeRtWWo/6IU
    L2Vq9WcXpIZTWkOsyxav9hiU+MYVlneRmEHvwMfnh+AKHWh71mZRLPJetk0eNKm4BtYzNy
    sei1bI+O+wnJT/FpAyAMgSUvv0d416ccU371y6Y80XRfSpjMmJu0nmG7ty2aWI6QhjTwrN
    Ee0ynNrTrkGXI2nfXhJMcdGxUV5/izOw9Y6AGnrFeCj4obdiAj43sz0ndA81CXbRhWY0ex
    AOsld9lzMhcyLQOVulnuO2JKtNCjC0ZXVwOcNdMxTEtCNqWU0MpLsy+2JtGA
X-ME-Proxy: <xmx:F0fyaoL2pZYgI7hfThpjbE3YSn3EhRTDFDSWV0sTtelz-S2PDZAp_Q>
    <xmx:F0fyao6QcKINw8ySSrFVNIhEDBhq_ZapxzjIxL07cj0gkOYzQB584w>
    <xmx:F0fyak0_5UGlLaH1bMuHFQ-J2_JUEVPav5SAXjrDQkVu9qUwkTlydw>
    <xmx:F0fyameYfzQE1hSIb_4HRmTz2gGaRD1-CiMxN1n-Ei8DqB31yNSQ0Q>
    <xmx:F0fyajcW4fwUREpBuSh0xsLorh77oJmcttg9uloyu5I_sdzBQGtt1J-k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 17:20:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <20261108023730.GA1242909@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 7 Nov 2026 21:37:30 -0500")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
	<20261108023730.GA1242909@coredump.intra.peff.net>
Date: Mon, 09 Nov 2026 14:20:06 -0800
Message-ID: <xmqqa4nhwstl.fsf@gitster.g>
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

Jeff King <peff@peff.net> writes:

> On Thu, Nov 05, 2026 at 03:40:17PM +0000, Julia Evans via GitGitGadget wrote:
>
>> +[[name_only]]
>>  `--name-only`::
>>  	Show only the name of each changed file in the post-image tree.
>>  	The file names are often encoded in UTF-8.
>>  	For more information see the discussion about encoding in the linkgit:git-log[1]
>>  	manual page.
>
> Sadly this syntax seems to work with Asciidoctor, but not Asciidoc. The
> latter doesn't create the anchors, and then xmlto complaints that the
> result doesn't validate.
>
> Doing it like this works in both:
>
>   `--name-only`[[name_only]]::
> 	...
>
> but...yikes. It's pretty ugly. This of course tempts me in the direction
> of ditching python asciidoc support, but I'm not sure if you want to
> hold up your series for that.

In any case, I'll queue another SQUASH??? commit on top of the topic
until v3 materiazlies to fix these issues we have accumulated so
far.



diff --git c/Documentation/diff-options.adoc w/Documentation/diff-options.adoc
index 2dc54fa00e..bb46fd065b 100644
--- c/Documentation/diff-options.adoc
+++ w/Documentation/diff-options.adoc
@@ -201,8 +201,7 @@ diff" algorithm internally.
 
 include::diff-algorithm-option.adoc[]
 
-[[stat]]
-`--stat[=<width>[,<name-width>[,<count>]]]`::
+`--stat[=<width>[,<name-width>[,<count>]]]`[[stat]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
 	part. Maximum width defaults to terminal width, or 80 columns
@@ -319,15 +318,13 @@ Without this option, pathnames with "unusual" characters are quoted as
 explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
-[[name_only]]
-`--name-only`::
+`--name-only`[[name_only]]::
 	Show only the name of each changed file in the post-image tree.
 	The file names are often encoded in UTF-8.
 	For more information see the discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
-[[name_status]]
-`--name-status`::
+`--name-status`[[name_status]]::
 	Show only the name(s) and status of each changed file. See the description
 	of the `--diff-filter` option on what the status letters mean.
 	Just like `--name-only` the file names are often encoded in UTF-8.
@@ -420,8 +417,7 @@ endif::git-diff[]
 	Ignore changes in amount of whitespace.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
-[[ignore_all_space]]
-`ignore-all-space`::
+`ignore-all-space`[[ignore_all_space]]::
 	Ignore whitespace when comparing lines. This ignores differences
 	even if one line has whitespace where the other line has none.
 `allow-indentation-change`::
@@ -436,8 +432,7 @@ endif::git-diff[]
 	used to override configuration settings. It is the same as
 	`--color-moved-ws=no`.
 
-[[word_diff]]
-`--word-diff[=<mode>]`::
+`--word-diff[=<mode>]`[[word_diff]]::
 	By default, words are delimited by whitespace; see
 	`--word-diff-regex` below.  The _<mode>_ defaults to `plain`, and
 	must be one of:
