Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB02E2DFB
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130250; cv=none; b=gC/bj7d9A841ynTDO+DoBL4Fc1Or5zxyGsJShVJz7k0aUL+GLrBo/7YXDDaD1hIP6UD3tTcnPC7tBmgXuDISyvzwrb6KWhUyyGXzCYF0aK6vsaGdSoszhvaiB4aQwhSALbDi7mdb4ft5raRDCVc7kVwrD8wYsoWqBYkUcXb/Vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130250; c=relaxed/simple;
	bh=HvAfzAeAbeqmXPZmvXp+jg/CQ4zbRSHWG/xaeADCIJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JJWBuxI96xlg0lO3M9FBy94dTDGprqAw6q2SHVpBJ2Qw7LGY9Z6haF6pCnKY2EspW+BoK5ZKKbuiKjd25hdLSvOzSsuM3g5GjlEDK+u9L46/MiPJVZchZwjvbuzn2BfERMhwUkdIL4AkNyk19+I3P3B43buB6aGTUVF6ffEIF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VTGc5mBn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WEMXK8um; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VTGc5mBn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WEMXK8um"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8AACA1400050;
	Wed, 10 Jun 2026 18:24:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 18:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781130248; x=1781216648; bh=1AVOJqCnBo
	UQoV1oG/O2XXCqlTYBf4MI2+l28QUiYKs=; b=VTGc5mBnsorP8TIfuJX+Uuc7DR
	GFNjgG83MPyPxRhyjQKGYLAZlftIULUfXLSKvh2TIYJtXuA26dTBJwF/dMlcKl5U
	hdY15cxEKhaKaoAD9WaFM+Ukl/zQr3f3j1QKroHWHDJzcDxwxgcZfDsuOsZx5ckT
	UltRI1SQ+pxR0VTDTxzu0I0wBpEZqSqmfWPDfZhd5a18GlCTj6pwb7C76ZdqeDay
	yBvm701P3G5O1f+GCq4BDlwPGJ8yWz6FXCPYTdd04SHfsBhM7Ip2+424mLoovEyy
	QbHrrEwHntT3Q4gj99/XEZM7vYx66gpcC0PkGFuxnEaX9FDWimoepG7FP7kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781130248; x=1781216648; bh=1AVOJqCnBoUQoV1oG/O2XXCqlTYBf4MI2+l
	28QUiYKs=; b=WEMXK8umh6PTcmrWJouumYTIT2ijjUXco00XSSNEiXRwbLOVbSm
	Sg869bLx//0RxzqDlGh8XV+jIEQuSo6hnE9vv4wxW04ZkhrQbFTZ9ORnunimgd2w
	pSxQTc3Tl1GghSwyJ/fkStXQtKqCXjBtx5niLWZ8esNVpQl6j4Ih4ivvEm/OdnL6
	62dcR3hMg7fZ99ZQVGUL0TyVCYoSujRcJlzIXsFtkb+bcDC/jK+fEdSY9RO+N1xa
	J2lOkVVMtQrIjSm/xr/sKZZ5CppQm6QebLMSJCPbj6/4gutq0eL4t9Ajy/YDG28J
	ZzLUNb5DTen+xz9vNSfHI3UcgGDAZ6QNp2g==
X-ME-Sender: <xms:COQpap_jyjytzCoE77tWx9bwsIcQqh06VD-V28d82xAx-wRyhjqbJw>
    <xme:COQpasy_4HGO7P4-LEUl6abEV8eCy4fCRpwK05IqYFBmbLwMCMOEHOzue9w9Zny55
    zY8nvL-xJTc3ILRrjxykRrWPk3tNa2AVHnmfF4UfczHsr4vQhwtVJA>
X-ME-Received: <xmr:COQpatOvn7SZGW2SgjwwN23JlhH3TO1fPgvYknnIFhabbopZs-nLsr-CWUvIH5u7RkGASnHtHSGym6FaLHO1EMlszh2MEkB_0SAl>
X-ME-Proxy-Cause: dmFkZTF+Ozwr26Nle3iWorBLlfJeatsphLxRhUsKVg3SkJkyTFuMpyC3dRGL5ZAzQhCFhr
    E0/q7B9hxUbLMSqLZzerKkueUncX7lWpOBP30D5ujeVyBwHmbIIdx6ga5SJuf3eJFmaEC9
    84WKgKMR7Zicsy438VI7VtIaaUAnEdWiz6HweUGltwZ3yuE+5fdmpQDxo8UVNullaw3hyT
    uMmawHbVJzP1WVSifB11F7/Yu9aJP72JVUZxdTjRMrV3GWhL8OcX2Q+J3/CLwBfb7Gu4zY
    o75buhlaNPXKnJmkpUsvdourE2bG8dZTlu1mbOT58QTPWFcvR69MO+gFeo+CDNPTjk76rH
    /+nVgKGgyr+fM4+nfHJ0ansXR1D8ANEu3i0FGYUAZyWqLCJeDwZlGyZA6Qbk3Q4viIbqtI
    qjN5al5PGrRxO2jBVoB9xtsmKrjaj4NZqQvS8ptAR5b8bTyMKICs1eg4NwIj8pvcS7qd7Q
    LtZIN7Br6d41MTfhc0saa87nCDyaRLws0/m7906AcP+rIm+UgfKbgGUi353r5k7yEf/gZu
    FV093Pc1mL3nPXm5d5VWE0uNBkXiQeKfJ3Y7mzm2jul0u408TGmXh2QbLJwG591SkYi78v
    K/A4TkLRSHlkd72gukS4SpLY5JXALKygjaZKF+fL5HiOj9UtOpY9lAo4OccA
X-ME-Proxy: <xmx:COQpap-MYuWnUMSfalZpiyv32xJqaqaUKvmNCY_v5CTRRH6wOpJwug>
    <xmx:COQpai5IH-L2FUoFNVUnHGGBxhjRRF8i8NZVmcAvBJut2tz7sCngzw>
    <xmx:COQpan4NS7FgYRApiqOzcQpnspByeSfqaTXDFwvjIG7P8sCcLtWHOA>
    <xmx:COQpajpD_yF0NUTwnk4apa1Tr5v77wrxQ2H93qaWQWELj0vs76te9A>
    <xmx:COQpagoUFqxFALVUIYW0vvGPjRzaNXMCXVk0M5reXn9w_Bn1FmnlFYnW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:24:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  christian.couder@gmail.com,  jackmanb@google.com,  Linus Arver
 <linus@ucla.edu>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 00/11] doc: interpret-trailers: explain key format
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 10 Jun 2026
	23:21:18 +0200")
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
	<V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
Date: Wed, 10 Jun 2026 15:24:06 -0700
Message-ID: <xmqqcxxyt4op.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> Interdiff against v2:
> diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
> index b42f957d666..d5e856f5d68 100644
> --- a/Documentation/git-interpret-trailers.adoc
> +++ b/Documentation/git-interpret-trailers.adoc
> @@ -60,12 +60,20 @@ are applied to each input and the way any existing trailer in
>  the input is changed. They also make it possible to
>  automatically add some trailers.
>  
> -By default, a `<key>=<value>` or `<key>:<value>` argument given
> -using `--trailer` will be appended after the existing trailers only if
> -the last trailer has a different (_<key>_, _<value>_) pair (or if there
> -is no existing trailer). The _<key>_ and _<value>_ parts will be trimmed
> -to remove starting and trailing whitespace, and the resulting trimmed
> -_<key>_ and _<value>_ will appear in the output like this:
> +Let's consider new trailers added with `--trailer`.
> +By default, the new trailer will appear at the end of the trailer block.
> +Also by default, this new trailer will only be added
> +if the last trailer is different to it.

The new text is more succinct here.

> +A trailer block will be created with only that trailer if a trailer
> +block does not already exist. Recall that a trailer block needs to be
> +preceded by a blank line, so a blank line (specifically an empty line)
> +will be inserted before the new trailer block in that case.

If you want to stress that a line with only whitespaces on it does
not count as a blank line for the purpose of this paragraph, you can
consistently say "an empty line" withotu saying "a blank line", and
you do not need to have "(specifically an empty lline)" there.

> +More concretely, this is how the new trailer is added: a `<key>=<value>`
> +or `<key>:<value>` argument given using `--trailer` will be appended
> +after the existing trailers. The _<key>_ and _<value>_ parts will be
> +trimmed to remove starting and trailing whitespace, and the resulting
> +trimmed _<key>_ and _<value>_ will appear in the output like this:

"More concretely" here feels a bit out of place, as the three paragraphs
we saw so far aren't really progression of the same thing.  First we
saw when a new trailer line is added, second we learned that an
extra empty line may be added in addition to the new trailer line.
What we are about to mention is orthogonal: how each trailer line
would look like.  There is no more or less concrete about it.

>  ------------------------------------------------
>  key: value
> @@ -74,6 +82,16 @@ key: value
>  This means that the trimmed _<key>_ and _<value>_ will be separated by
>  "`:`{nbsp}" (one colon followed by one space).
>  
> +Existing trailers are extracted from the input by looking for the
> +trailer block. Concretely, that is a group of one or more lines that (i)

"Concretely, that is a" -> "A trailer block is a".

> +is all trailers, or (ii) contains at least one Git-generated or
> +user-configured trailer and consists of at
> +least 25% trailers.

Hmph, isn't (i) a narrow subset of (ii)?

> +The trailer block is by definition at the end the the message. The end
> +of the message in turn is either (i) at the end of the input, or (ii)

"at the end the the message" -> "at the end of the commit log
message", and "the input" -> "the message", probably.

The latter is because not everybody is "parsing" the message to futz
with trailers, using the message as "input", and some are "writing
out" the message, using it as "output".

> +the last non-whitespace lines before a line that starts with `---`
> +(followed by a space or the end of the line).

OK.
