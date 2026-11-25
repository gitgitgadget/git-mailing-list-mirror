Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795583231;
	b=MosGsdTZjdqSrxfPwL4Z4PEungn3HjCd8JmW2abFNlJLWvPjdyzQ78By2kLP6UsOMV8E
	 avAtPtspGKoX280soSv2HuPLz6ruXT1fBke7zuemCI1rNWNPyrNqqidt1VDFlA63gmkfU
	 VJomz6AKF9aXWtoGNa0fI1MVOabfjRL5jDjgxyvv0ZBZm/v+VyzuHViDzh2g/8s8g+Hxg
	 x4RRocntcJxXeEYvEuDElUrWrXpgoJYXVEQcCNbi8+sRn1L4UcEpgnsCiLTqT4Ldq1IrC
	 mMEIFTJVhLkYUHA7fWXXENwyukmVGPJKkGJfZo/6kvWav1hrfCnHwjCA1QHNtUtaPkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583231;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pCjAqtyuxrBmJR6vx8u0c3bs1pPVVjWMLoZZvRwNjEw=;
	b=X9KhEa+l/Sw4UrSiuLu1OuJhOw8uFKIwRnd5/z0dyFVn18iU64LFmcAl6ARTYCnN9mqB
	 vROBZxKwH97EuJjapnzzdCFlL/T54kpM/i5XM+dxq/EbYEkXsl087Z7XT10lJBwm0M8Bk
	 vw9A1CDh8m7B+P95hOjpF20lUCj9nBqHoor+QlH7fRhaxNzHxnkl3lN7RGYWCqz3HQTwB
	 1i1iz29A+hwkHS4ftJWfWgFtVw8etxvmLc9uOqR6quU4z9N8Tija7SBkWbaSFjoE3wtk4
	 xFkwS2Wj8TUQbqJ8rBIqfjTU16s1Qw2frOTOxFZesAp22XV1hsTNGK3TX8OOjLsgBBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=n8zmdAwv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mejiPX5t;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C67606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 05:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74C67606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=n8zmdAwv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mejiPX5t
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A801A7A05B1
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:07:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 25 Nov 2026 00:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795583229;
	 x=1795669629; bh=pCjAqtyuxrBmJR6vx8u0c3bs1pPVVjWMLoZZvRwNjEw=; b=
	n8zmdAwvpaTHalGpaN+wqyz+HKv9PTBz9rVuA1vqUeOOt1QlTZ4Fk9eWI7FBchSF
	rhSEeTu8kXq9Xs47SxYn4vFI4iyPChRNPCuK8JlJOjVVcTRQwYWzc72BpUgFNbbI
	haoISm/hQEPgmj6YP9ZZ3AVBkmsWyo2uotb5lxCXCDxDogQBLlPJffbysD9D2k+K
	0eMfikU6KCWBEdmU289qfjN9aSR9r627ceY5+K5ACN9MSGFLqnPm4tX9tsvxp10G
	0D1dhuqILIZsf7XYx3OzZDlKQSrPvGIiMnP3gN+GbZX6DfLG7nIH6NkhTzfKHmwF
	bOe0kbvq+m4p9tjgjG9lzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795583229; x=
	1795669629; bh=pCjAqtyuxrBmJR6vx8u0c3bs1pPVVjWMLoZZvRwNjEw=; b=m
	ejiPX5tyZHq0UbvQZX9V3aUVbVn+Ynk6kINm3mn9ccFO4orBAYjbTES6Vp+74JBc
	ZyWCg7J/+R9muvpOb9oaAzjWvwuwxPls6wITh29iF73VENf19wFhHbum1JBz04iJ
	6ZDUxjzbwL+JFrqwIcQhSDoh0QQjsjrpokV2npnkq6gJ7rH8S0GD2lnKCEgdXURU
	1/2/MrRUIx1PCUSaYN7sGyLTtEA6aTDj4jTmAPhlRuDYp6N1kjbNuyUT+2mexBzW
	RvqE8jL3a8UCbOeuieqr5p739fAwgySWBnhFl03pm9m43dZDpmW4SWqMzjhFByDX
	EhEv/Y+BbDyA4AB4k+GTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795583229; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:InTxhpgxqvqWyngB5vN6sm++Z6/6qjjByI6LcIt+KlfhsAh
	eN9vhGlNKMSUJgS8TSY76c0Yq3CLBqYChu/dipHtEkMYoaFpsdRFHH06Gw49U1lB
	grdi5BmKXihH5jlSnDTaQlbRVDMaJM1VS5DgTCyZKEG8kWqUzxzeb4i7eJ9icvHg
	KXCXNyBCGjb3M195ZF2zgi5GX2lCcJ/84l1dyyIESWicUkAw2KTnNWGHIhfShkbB
	iUGuDZzGKqXwHvFCVapUQN/3xlu0wVV/lCCYnFidN9/t9M8rdaGCA2mTqvP85vlG
	eNwzxTtLn4bMW+BvYB2I4GzTKlbSEhIngv9SN4A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:ejTPX4q4jDkfNVztG5jcNjV2dkymGXC/W7nAnZ0sj7s=:qcK3+Vxo9MYGugTKRs/9qdSHUWSAXEbUHTGn88BcC1s=;
X-ME-Sender: <xms:_WwGa2EzTFq2umYQBaswvPmYSiUNC7pQ8EBIu_lXCMwXHh02EU3Mtg>
    <xme:_WwGa-XGNccTGk83rlFHipBChyP9jpUdEz36ftIcnhnb3iElK_ZgvQWqw6yrmTquo
    tjJfXnI2UD86ojVx4qj3TAqtuaIA-gfP0hWZ4cBjBeLf8GXRhxZxOk>
X-ME-Received: <xmr:_WwGa1J7nYGl3GhYLl_8dqdFjHWSKlpCdgEcb2CuH7mezD7ZnQICOSscJZ0CG6s6cANs28mCe3anTsGESqjKOH1kL0IeX9cLAXG877I>
X-ME-Proxy-Cause: dmFkZTFCiRFD8d9phPvqybUQEGs7bqpFcBkI25jPIdjSAABBtOMgZvng6sF4PknGKq/Ani
    1dHs9aMg1uVLexYrgCLFzrsDQEXrxCWMCP0NFUq7bEx+0qUvwZMs9Gm//icbH1gB4EpisB
    5ESxDdfCO6WXPWXpecQSnzRKgDWCiIsYsKHosaJYJ34e7Brmvfm0WZt1jHuiXr5AurLxop
    0Te88eO4+rwuSkfNXv6LOOBNFOBv1tA2RweYzsLQtH8ygoG0fPFVgXnz3iiWLziuqxBdB4
    s+/62zUS+XvaXDRmmIXdMcKNqxBaXlFCQsGPuZ0Cf5QqibjTGL98UkZPWT2fpFvtDX8bWG
    1PYl0tYgI3jrJBRZUBaFJf7lPRCy08/jJ40qyGSeEiOJ58GPoqsfVjNEyGLd9Rjcavs0bw
    YIrtcUeWeW1GqEbQl1aET4BBu2QQFlYKiaFRC0FJphv4c6Ye4/xgqK12NNCV2jCF7rBUsN
    /JLTHa2C+Ft2jZ9hfGq3+PaYQT/ISqiNmixKGZ6lLRz0cgPXkotOXXZf9vwejbmIeLOBQe
    iHnrKxvdx5JflcdLUx9ow3jHkJwi/aZeDrblryctfjqREZE4ahJIx8FAfRJuveWKGVhZre
    ihjXJU863p+B1cjKN29VbRBy9wMmcbXA1s1yPrh5hf7iitW1neoTEpgR+irQ
X-ME-Proxy: <xmx:_WwGa-87kVHPImmNVOahM-rca6DxOTs5bh52jDlMP6LT3sl_jGvGNg>
    <xmx:_WwGa4J0RGYzXCAFpxA9D_z-VVvru3C7fFjKxAIHkq44e-MEFP1G6g>
    <xmx:_WwGazm1QH56L_E8nZmCtm8H0UJLYCpNfskAjkyaiDSaIJ8WikqA2A>
    <xmx:_WwGa8Ny1ertuwloFhr6gccDcJ875hWvxZv9AAUOMiK2VCHsAI9TLQ>
    <xmx:_WwGa_Jzfhdg97N_MRuj1FhkAOdikxtrY2A2Ow3drvk_zR6n_n3ug493>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 00:07:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 4/4] doc: convert git-fast-export.adoc to synopsis style
In-Reply-To: <814dfdddf691445cc2d982854cd4e7ddcfbd8875.1795556940.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Tue,
 24 Nov 2026
	21:49:00 +0000")
References: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
	<814dfdddf691445cc2d982854cd4e7ddcfbd8875.1795556940.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 24 Nov 2026 21:07:07 -0800
Message-ID: <xmqqbj7dcxdw.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
>
>  * convert synopsis section
>  * convert options to `` style
>  * convert _<placeholder>_ style
>  * convert inline list of values to sub definition lists
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/git-fast-export.adoc | 193 +++++++++++++++--------------
>  1 file changed, 98 insertions(+), 95 deletions(-)

> +[synopsis]
>  gpgsig <git-hash-algo> <signature-format>

Using [synopsis] on the gpgsig <git-hash-algo> <signature-format> line
looks very clean.

> ---mark-tags::
> -	In addition to labelling blobs and commits with mark ids, also
> -	label tags.  This is useful in conjunction with
> +`--mark-tags`::
> +	Label tags  with mark ids in addition of blobs and commits.
> +	This is useful in conjunction with

Two typos crept into the rewritten sentence: a double space (which,
admittedly, is harmless, but some of us do read the source) after
"tags", and "in addition of" instead of "in addition to".

> +`--reference-excluded-parents`::
> +	Have the stream refer to commits in the excluded range of history by their SHA-1 object
> +	name instead of rewriting their parent references. By default, running
> +	a command such as `git fast-export master~5..master` will not include the
> +	commit `master~5`
> +	and will make `master~4` no longer have `master~5` as
> +	a parent (though both the old `master~4` and new
> +	`master~4` will have all the same files). Note that the resulting stream
> +	can only be used by a repository which 	  already contains the necessary parent

There is a stray tab between "which" and "already" here (which,
admittedly is harmless when rendered, but some of us do read the
source).

> ---reencode=(yes|no|abort)::
> +`--reencode=(yes|no|abort)`::
>  	Specify how to handle `encoding` header in commit objects.  When
> -	asking to 'abort' (which is the default), this program will die
> -	when encountering such a commit object.  With 'yes', the commit
> -	message will be re-encoded into UTF-8.  With 'no', the original
> -	encoding will be preserved.
> +	asking to one of the following values:

"When asking to one of the following values:" reads like an incomplete
edit of "When asking to 'abort'...".  Replacing it with "The possible
values are:" or ending the first sentence with a colon ("Specify how to
handle the `encoding` header in commit objects:") would read more
cleanly, perhaps?

> ++
> +`abort`;; Die when encountering a commit object with an `encoding` header.
> +This is the default.
> +`yes`;; Re-encode the commit message into UTF-8.
> +`no`;; Preserve the original encoding.

> -[<git-rev-list-args>...]::
> +`<git-rev-list-args>...`::
>  	A list of arguments, acceptable to 'git rev-parse' and
>  	'git rev-list', that specifies the specific objects and references
>  	to export.  For example, `master~10..master` causes the

Shouldn't 'git rev-parse' and 'git rev-list' here be converted to
backticks e.g., `git rev-parse`, too?

Thanks.

