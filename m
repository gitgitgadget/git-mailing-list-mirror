Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264024;
	b=H3jGTecjxH26SpA1tWpzefuu/r4T8DTH3ZB5iFb2dmMdzI3KSGb0hXKBDZQ6N6rHBnX1
	 jqXbUHomVyr/8NxcucjSLDZcfqkafokMf6V3eI76jNbA3htG87k8w/zJBd8XgknWrxPTS
	 3/ujZjPdfbhE7Gba9etjYIyfAbPWpOZ6t8JLM13Nyo+WbJLoQfG02Uu+ey9gy0JzEghls
	 u0NZExlLWj9WF49TRJ19dVjLViyJY/dXEKS9X8eJgagI6YbR6XgXzYZB/jfyhgNcmtL2S
	 706MkS+8m6kakV533teDX7Px1H8g0xV/GOIiH6zLQ36Ed2Zq3IGU8sOHkfUNggNktlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264024;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=VtDEDKgbRmRLg2zWwJCeQiwrA1h0spEbXYZhjKD7sI0=;
	b=tN8EyqIiML4+qnpS0ds6efOkIDJvLujt/NADYrvUolVBQzE1g8WlxoIYNUiZA80ki+uA
	 0aKpY6Dcg1koQRBow7Blr5BMIlXPdU2UKXukCmMqINfoxn2A+6uKBx0lZ+ayrDsQzEpRX
	 S2tskKetKCDBx/nLHmmga7xn10c8WsbIBgkJrbMKGrctfWFys2AVSbEdmUZCe3udDcmTa
	 rRpNXhNyl06QO7reBuVSxbOYs5Rzgp0xvN+hQM20i8R1i/QEN5ys5a+Knx3gAZGp3o5KP
	 5XKy8cnMUQx/BHeRwcAbjbH3I+226yirH/m+azHPERgD1vlIr/ZFhA2mrNF23lzuEFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=HRpqjUje;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BCRIBGLJ;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461C606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 22:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A461C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=HRpqjUje;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BCRIBGLJ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AC722EC05D7
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 17:40:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 17:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794264022; x=1794350422; bh=VtDEDKgbRm
	RLg2zWwJCeQiwrA1h0spEbXYZhjKD7sI0=; b=HRpqjUjeeZ0YeStif/9w7Oq8Rc
	6mSsJfxfMJkYWGBTstawwHRVp7mbOs5UWYRNomMp+B7VU0xVX/87qsxzooipXpzt
	Hyu0cnspK6UHyx3ZklaBri8wRkjM1kZHcZS4H9AtnnFOWMJBu0kwmAJQ54iSSSrw
	BTmKZKErD/j28rcWHYE2A4TOQBcQLHIhx9XN9r3YUeop3pbQIo+waGEoETVEPrm5
	fxJMc/WOkwa3Cru6xfPb71xpUytK2OVLgxW9pHf1WiC/qEjYF4xhP3ZoS/1gviET
	heZZPrMiCA5BlxOowRxr2/p/s/YwLO3M2wxOoMQ8x7Oz9hyQHMbmES1mGLLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794264022; x=1794350422; bh=VtDEDKgbRmRLg2zWwJCeQiwrA1h0spEbXYZ
	hjKD7sI0=; b=BCRIBGLJMGlP87ZxFN88u8Su/v0g23aQl0krO2tCGGnV+g3/Ht/
	KuGoyoT4W/wzo5rNCjyJwn4R1mL0l46NZvZ3rxyrSsEXl3kTthCkEHOgJRIOlmgX
	/UGgif6tyfb8PACZPyvQDBQ3XlwMEOzgzEzKIexTTiYOMSedc+Z3kB8MJqqNh7Qa
	74HUCUrsSo2m+V8gwOLPxz6V+S6WvdSMHVlEO18SefWXSHYBq1WRegxFYsuLdqnc
	jkV4VWqP3u3tlduA4D1SsrwWmaj+xlEviLPutLTWD4PAKApbh1L5WUkL1Ua5JLIg
	EUE4HpRlvgoh2CpDDUy3NA4mTf5ESu4hODw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794264022; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RMLPjl4Oj2Smjhnuqi+Vr+vK57t5/06xmZxZX+f9alO7v4t
	YC/Gt+R2GuOqjAjcHnG2xFJAkbA2YgZejRRnri3QJXhjZ3r3erTN8H/M5EQ+iKJF
	w3H+FQUCWOJ8YNPCeONIjJa5ZGzfhED3K0JxC9pxCYjccY+TiTHCppYL7c0e1vdV
	YdPBwYNudA0l1J5ExflBp6O2pjT/NL7hmbXPKwArT60MV7E9UJVx9zK+yF4T5AnL
	fgmLHcf0R7jLJ0TR6msP+psNwc7qZPKUPCIkp8O6v6w0cuxue5lnKAyscY5pjiyh
	Dv3aD4EFY5BEEk1EdA/c0bdUKAS2NNuBJfkHh4w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jnqcKsXuIk8WYWLInMwEzKfWZ05dv640QJuw48E4my4=:3SRsb2huEIh7lpBQRI9AAdTuZncJKkeMZNPd4MNRj+g=;
X-ME-Sender: <xms:1kvyagqkqdUGqpUDM62U8E-63TH6O08x7adXeVN5R4S7CA_sYIz1yw>
    <xme:1kvyaqUVRT8aNcoyIIblhFvkDLIY3M5DDvDoXq5PR64Y4e0f9snj6MNC_sV_NfWej
    yfVsgv_B7WdlfF4gawZfIKOmH_g0RyzSW3bfx589gYDuIcEk2jCtBE>
X-ME-Received: <xmr:1kvyavDPu1QrWcisumkJP6Kgf8-Qi4Yyksg6KJhBhmZs9WMcwE9rBjoBKGaet3QNgBB8rkIXEsJTXOjH_o97jtkbVkg-6qyGdEDQ>
X-ME-Proxy-Cause: dmFkZTERHuBvA9jOrt1XDOjFobkXbOKqBQtM8umuEpuGUbon6SVWg0SA93fsuzN47/e+t7
    93xtzGmRAO++3ZU88zbgqUAYJIp3J/cM4PJc9qRrcCFKPhpAaduCmqzoIlqiuSeR0fNijw
    TfPOBlasAi3aLqdU5KhxBrI46ymbSzzo0D/kuO7+nZkifl4tpGAsX0ipxqAm1PpYqX987m
    4gjLhiVxD/N+xLL80zjsCvk7D8uqK02VLywNh1mOgy/NAtg6UsVpfrGKHI6HjeWeNlZDSM
    RldKDt1iR56UW/OjMZMqCL2yolgfIBb6STWe5ZFFycSLPXLBzZketYwsu3hScjDpNjkcuL
    kaCvWHHX8zEmAZXX64v7Sir3QnnsYRJe4ob3mPig7OnTSPRtwYTYraO+nh77THbfBhbcby
    qPMrRl2KylRqtBOvU+NdwLX0wb7kUiQ5rjfBE9TcMwRy4AHC38ETzhXs6GY/zKUoLayB1g
    5nXKB/dju2dqQ6uKD2H5DdTJ+eL5WunzO3to/Ubi9a8ciXT1Bdf2/cLKs08S31uxMfw2YJ
    /BuB43lv8y7RF+kNPGcC2+v2jEfNxjKdi/E/KV+wNQeiPTXjB5MeepGgaNw3wi5JpmF2tU
    HdnoiW52CIZMfVuKp4qa94YrWE9NWvkmxJvDeJ0a/9iQdDlf29JDRELzIH+w
X-ME-Proxy: <xmx:1kvyau2Y9oUM8ih-JvxSPMB0ONjl2SmWZJWeOVDwRUofIcU1Xzewrg>
    <xmx:1kvyah3aVX5dnAmZcom7Lf7pkIuA1HYceZo2hG57XJ4cZb1IM_kHPA>
    <xmx:1kvyajALcLRIeXyeqM-EDJQ1AZHSTTYR1iT2-ZXhB6XUn9FUpYl9iw>
    <xmx:1kvyag5aCnyK4eWGpRAjYgCdEqlX2aaETeyMIbpdzSsbHxcN84Ma2Q>
    <xmx:1kvyamaj7SSzSu0MqmvfigyiwppwlEIcx-40Vm7oy5EYyySlEwVP72MO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 17:40:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <xmqqa4nhwstl.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	09 Nov 2026 14:20:06 -0800")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
	<20261108023730.GA1242909@coredump.intra.peff.net>
	<xmqqa4nhwstl.fsf@gitster.g>
Date: Mon, 09 Nov 2026 14:40:20 -0800
Message-ID: <xmqqo6bxvdbf.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Nov 05, 2026 at 03:40:17PM +0000, Julia Evans via GitGitGadget wrote:
>>
>>> +[[name_only]]
>>>  `--name-only`::
>>>  	Show only the name of each changed file in the post-image tree.
>>>  	The file names are often encoded in UTF-8.
>>>  	For more information see the discussion about encoding in the linkgit:git-log[1]
>>>  	manual page.
>>
>> Sadly this syntax seems to work with Asciidoctor, but not Asciidoc. The
>> latter doesn't create the anchors, and then xmlto complaints that the
>> result doesn't validate.
>>
>> Doing it like this works in both:
>>
>>   `--name-only`[[name_only]]::
>> 	...
>>
>> but...yikes. It's pretty ugly. This of course tempts me in the direction
>> of ditching python asciidoc support, but I'm not sure if you want to
>> hold up your series for that.
>
> In any case, I'll queue another SQUASH??? commit on top of the topic
> until v3 materiazlies to fix these issues we have accumulated so
> far.

And I realized that we need yet another SQUASH to address "isn't it
a value of another option?"  point.

    SQUASH???
    
    it is likely that the annotation was meant to go with --dashed-option

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index bb46fd065b..dbac3b8275 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -417,7 +417,7 @@ endif::git-diff[]
 	Ignore changes in amount of whitespace.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
-`ignore-all-space`[[ignore_all_space]]::
+`ignore-all-space`::
 	Ignore whitespace when comparing lines. This ignores differences
 	even if one line has whitespace where the other line has none.
 `allow-indentation-change`::
@@ -783,7 +783,7 @@ endif::git-format-patch[]
 	more whitespace characters to be equivalent.
 
 `-w`::
-`--ignore-all-space`::
+`--ignore-all-space`[[ignore_all_space]]::
 	Ignore whitespace when comparing lines.  This ignores
 	differences even if one line has whitespace where the other
 	line has none.
