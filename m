Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814636;
	b=uveEd6S1sC+RjmurFAyfl1FsZvMPdSw+hbWr8CIHGlarRi8v0zjsB2x6bPZrBC6Dfi1u
	 eIW+Ng/4MnNkJFZIK9RbDc8zQizpa/GJbArCd1CXuu11fYMbinGzn79kKXqf8uw4Zkt0y
	 Nrt51AiVtIem+fM5Jbt3XEMk6936dR1NnVSlwGXu/9UGePR1+wWYsph8m3EhX5k1QkPck
	 FxgMVh5cpY+4eRK6WnODtsvZH1iPDzi3W6I5XDwBF2iYzqac5pk8j09AXUsz4rrcWjAUx
	 aSyB+l8lGZhSe3J3LoTomSj+d7Mt2xQ/61Mf7JADsm8Y9Et+It1FntUe70JRWUYj22A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814636;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1Z3dPMS/hsPw4bMXLplisxOpVVRXvlt6GFhiAZBYdwQ=;
	b=ssTaXcIMyG7iBbreqeErIyR7DCLe3y4i1CiGGCWg5LbRBYIA6fGfQqYiZcOHjE83hGs5
	 yArC2bp62MXg+GuuJNbcYSi6I3LhWYp3mYzmvzcG4ueuGFCXvQ23/k0LjUnJBoAqGFCtv
	 lR/4speI9s7qwkgJFOmAIfeLRa8kN/n4TwAWzrkFLiTT+5bS13RbxAb6CD1n58wNXUtDK
	 uuytSUwu8CPa0znU5Orf4ZIYlKm9RCyl/mQzhyH0MrmPaXuwxx4P54/3zHCd0WayzWFby
	 ATkPI4Q6aEg9RhJ476KiIgR6CRWtZIkrtvpsOfxru1qNlnkWS3FrGNCjLD+WEaLNwdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wP9HC3RP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d6cjX1hd;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E586606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E586606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wP9HC3RP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d6cjX1hd
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E80A7A0186
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 02:37:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Nov 2026 02:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794814635; x=1794901035; bh=1Z3dPMS/hs
	Pw4bMXLplisxOpVVRXvlt6GFhiAZBYdwQ=; b=wP9HC3RPiJC7Tt2v9+XhnWunGb
	nw4AqzPkYkWSgMykO+bg85wDxhf5yf5cgn8YOaNLSqTXg9tji4WLDkQ6yYTCXpks
	+4ah12yldJJh+I6j8VFD5QbkABNXSg94OQ7C1K69qu49Iv4j9pxjmbQdKKbirLuK
	MjO69R3khBN4lwWc0UAj1FI4qQEw0Exc/0OQPGvts6soOK0/PZyN/Kz4vnAp89Vp
	NTcxfGHKp1L/8Y6reGsIOtSVot1a8WRZMl+Eqi6BmKf9w60LobUdZgiv764S49rn
	ozzfzz5a9miu+oVhLjhc//V/KrNrL1I/4bjVU1GOBOQ67HShQd+cxOCA27Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794814635; x=1794901035; bh=1Z3dPMS/hsPw4bMXLplisxOpVVRXvlt6GFh
	iAZBYdwQ=; b=d6cjX1hdLGWOh9FD3lZ7Ec18SZL6UTlXG9+rc5lDImad2RUWKs+
	xTFbD0E/Wc+FJlUe0quxoi4Rml57qdfDjSTw/BEN99d8DZkv5qn/yRIQkcBeRzBk
	BWpW06PP4eSPiJSH747E95/O1SEuV//BI/N0sAEA8/dd5jqGz8bni4IlVpcSrfNo
	cijjOHeqpRVvqcOWpoLlD/y3J9tZWu32BX84BMFPIhEHqA1wcTu5hvqb7AGlyeNB
	t46COex4ghBVdy8hgAjWnkgxK6JRh25QGpRrlmN20CE18geL+muiYQmiOPlPPqeS
	OM4i8KIgSzx0Udib2/CmglxRW9sVSkqEd0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794814635; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fEff/AhyMQY0LEVAFk1d2+LT1PpmDxtvkzwE6SEGmKYg/YF
	BDieF6hKbv5S3lroFvlPC9li3bGPGeO2wJRvY1iOMyACDFpStP0oyJqZyET4RvVS
	FpAUU3Pm45RX6CoIULB7uNzu9sVGACZNA0EA/ZFLZ8mUXRkKB0wn36At9ZhVDhtb
	3y92tDZhUzI4GkUMtIJ3U8aXkxlPwbJtEsTDmczVfarikzEbWhdy8Hd4lIskAr/o
	sN4uQXdBtLzITjxJvYtLS3LP6OMdqhgIkIKY+uCe8DCX6UCtPXnN9/45vlNRPHfY
	4ohTL0udRPDilgvraKBY4rpffkRYnAZSQKGakQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3RJFSaL4lwn9ZsNB1lrmAzcM0Mypa1DLdEgbi40LNc8=:WEcWUao8miCl0scO61tb4Qt9qX9jBIkvJvgSmZn8BhQ=;
X-ME-Sender: <xms:qrL6aiaeHNK_AD3VPqti6xMaU_NhpVgmgz8C8Kb01Q5n25Dq2zKxkA>
    <xme:qrL6akd1tnnT7-iP2gFBplrdZ7bF2lzS7LB7QQhwJtDX3BJ33sbFUZVSTrPyMzP1H
    hujn_z4plZvt5LzCTTJ8rXYCCk-ePoyIl3CNEslZvZFk1_PtdxACA>
X-ME-Received: <xmr:qrL6ajJ3DgMfrgLWaOYySybcZxwx7I0-BBhWKxwS7Nnc7IC8P9I_Xqiol-F1MdD_lS-83jw>
X-ME-Proxy-Cause: dmFkZTGxawTxS6AY+dE4dZzX6HA56QCmoE+NURT4gc3D7huksKt4HRthq3lHTMwm/x7QGr
    /Q8R65FYbF41gwWk/LZm6+J1/0Tyt4GXeijMYAbZ921ATwbFX+nhyScURhb+vO266FV9GN
    GwzNaSQpT/cmub58Jdn1iLTakdp9/CHp6cUl+oF2rexOOj+Ec21O9Rf2lwtZh7TAB/F5cG
    qUR7MqdfKuHLVd8Okze/hWFfB+yQvimivDfTwZIMzm+9pfD2umdZpTF7AsGpPx0uBdtIVQ
    qBJq4DsiS2Sh/GcEWe1P9W7K6xCF1kmUtCotrhUeAuaFlBEBV9xkqfXPvf4c088OrXXero
    2Dg2gVTVO1neABghfhVInId6umBsT41+biAEVI9xHikQxsOW7J9uM1EwHOF1+TMeJZ3EOy
    2VViIzQ9gSjouuMLYFWrcdG9NsokevXS9AOVVVw2SXSboLFbLAPBB79LIegjZYTldcnaZT
    hE2FESRP4OAq7Fq0NYVPsoB/vfkROJb7pu7wBSjxxI4H2q//RjaKU/vaQDFpQd1r1jNFjW
    n9yFyHPGcdMPdTzA7Ms5ptrFWqQcMeVSSsK+d3XbiD7pNsuLa+sf1astah9i5kF8M+bhdp
    mHPYMGx1OEdBNQ7TvWR59PZODur037MBmbCwgJdNAIGk8N20ueVl2POeStCQ
X-ME-Proxy: <xmx:qrL6ahLKQP9OQ95_6ZJXihsvSfgWjN_JEDbNTZOvVbm4bkqM3iY9Pw>
    <xmx:qrL6aiXE-PAdZgTmUhFFAMXjuWuXJbXaZHe8asMCBSM2VxW86M0WRg>
    <xmx:qrL6aqm_-OLxIoVFkYzI_Y9JyEA3n8Ko0fc5DGr_JmUeLZ7C1AaQTw>
    <xmx:qrL6aonBquAvlLmvbQ6MJgYoj5VPvkp9-u0rjPCi-fp5Zt-IhMgXAQ>
    <xmx:q7L6ai2axL6dfKNYFjUXnG2NQlQ8n1nrFPS2hQjWRGn06g1AklXDhMoz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 02:37:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 465c3bd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 07:37:12 +0000 (UTC)
Date: Mon, 16 Nov 2026 08:37:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 3/3] object-file-convert: copy unknown commit headers
 unchanged
Message-ID: <avqypRLPLZZFNqRs@pks.im>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <20261112195740.2834341-4-adrian.ratiu@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112195740.2834341-4-adrian.ratiu@collabora.com>

On Thu, Nov 12, 2026 at 09:57:40PM +0200, Adrian Ratiu wrote:
> In a repo with extensions.compatObjectFormat, Git converts commits
> to the compat format in two places which disagree about headers they
> don't know:
> 
> 1. When a commit is created with commit_tree_extended(), as
>    "git commit" does, convert_commit_extra_headers() copies unknown
>    headers unchanged.
> 
> 2. When an existing commit object is converted (git hash-object -w)
>    or when it's read by its compat id, convert_commit_object() fails
>    on them instead.
> 
> So git hash-object refuses such a commit, while git commit --amend

s/git hash-object/git-hash-object(1)/

> records a compat id for it that can't be read back:

s/compat id/compat ID/

>    "Failed to convert object from sha256 to sha1".
> 
> The rejection was added in 08a45903cb (object-file-convert: convert
> commits that embed signed tags, 2023-10-01). Git can't know what an
> unknown header holds. It might hold an object id that needs

s/object id/object ID/

> converting, so convert_commit_object() rejects all of them.
> 
> Some tools rely on such headers though. Jujutsu, for example, writes
> a "change-id" header in every commit, so none of its commits can be
> converted.
> 
> Make convert_commit_object() copy unknown headers and their
> continuation lines unchanged, just like convert_commit_extra_headers()
> so both give the same compat object.
> 
> The author, committer, encoding and gpgsig headers were already copied
> the same, so their separate cases are no longer needed.
> 
> A "tree", "parent" or "mergetag" line with nothing after the keyword
> used to be rejected as unknown and is now copied as well. Such a
> commit is malformed in both formats anyway.

Hmm. I guess this here might raise some eyebrows. I guess it makes the
code simpler, but I wonder what the benefit is of converting an object
that is so obviously corrupt...

... yeah, after reading the code we'd have to introduce a bunch of extra
logic to make this work as expected. As far as I can see though we _do_
reject "tree " without trailing data, but we wouldn't reject "tree"
without the trailing space.

We could fix that by introducing a generic format check:

  - The line must have at least a single space separating key and value
    of the header.

  - The key must only contain characters of a specific set.

Otherwise we might be too lenient and also accept data that doesn't even
look close to an object header.

But whether that's all worth it is a different question, as said. It's a
corrupt commit anyway, and we cannot address the root cause of that
corruption here anyway.

> Alternatives considered:
> 
>  - Reject unknown headers in convert_commit_extra_headers() too.
>    Both paths would then agree, but commits from tools that add
>    their own headers could not be used in a compat repo.

Yeah, that's certainly a direction we shouldn't go. There's way too many
tools nowadays with widespread usage that write such unknown headers.

>  - Copy only headers known to hold no object ids. Every tool would
>    first need to get its headers added to that list.

Agreed, that doesn't seem sensible, either. We don't want to be the
gatekeeper of who is or who isn't allowed to have their own custom
header.

A third alternative could have been to try and recognize commit IDs
automatically. E.g. if you see a 40-character hex string then we treat
it as a commit ID. But I don't think that's sensible, either, as we
shouldn't interpret what we don't know.

A bit of a side note, but I have been wondering multiple times already
whether we should fix this gap by introducing a well-known object header
prefix that tells us that the value of that header is indeed an object
ID, for example something like "x-obj-foobar <oid>". That would make our
commit graph extensible by third-party-tools without us having to
understand what that tool even intends to do with that, and we would
know to treat such object IDs as reachable.

But that's of course a topic that is well outside the scope of this
patch series.

> diff --git a/object-file-convert.c b/object-file-convert.c
> index 63ee18630b..1a0f98c9ff 100644
> --- a/object-file-convert.c
> +++ b/object-file-convert.c
> @@ -223,17 +223,18 @@ static int convert_commit_object(struct repository *repo,
>  			strbuf_release(&tag);
>  			strbuf_release(&new_tag);
>  		}
> -		else if (((bufptr + 7) < tail) && !memcmp(bufptr, "author ", 7))
> -			strbuf_add(out, bufptr, (eol - bufptr) + 1);
> -		else if (((bufptr + 10) < tail) && !memcmp(bufptr, "committer ", 10))
> -			strbuf_add(out, bufptr, (eol - bufptr) + 1);
> -		else if (((bufptr + 9) < tail) && !memcmp(bufptr, "encoding ", 9))
> -			strbuf_add(out, bufptr, (eol - bufptr) + 1);
> -		else if (((bufptr + 6) < tail) && !memcmp(bufptr, "gpgsig", 6))
> -			strbuf_add(out, bufptr, (eol - bufptr) + 1);
>  		else {
> -			/* Unknown line fail it might embed an oid */
> -			return -1;
> +			/*
> +			 * Copy all other headers unchanged. author, committer, encoding and gpgsig
> +			 * hold no object ids. For unknown headers we can't tell, so copy them too,

s/object ids/object IDs/

> +			 * like convert_commit_extra_headers() does when the commit is written. Both
> +			 * must give the same compat object.
> +			 *
> +			 * This means that a header holding object ids is copied without converting

Likewise.

> +			 * them. Any such header added to Git needs its own case above, like parent
> +			 * or mergetag, and the same conversion in convert_commit_extra_headers().
> +			 */
> +			strbuf_add(out, bufptr, (eol - bufptr) + 1);
>  		}
>  		/* Consume any trailing continuation lines */
>  		bufptr = eol + 1;
> diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
> index 9cafcee509..fde092a017 100755
> --- a/t/t1016-compatObjectFormat.sh
> +++ b/t/t1016-compatObjectFormat.sh
> @@ -187,6 +187,22 @@ do
>  		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
>  		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
>  	'

Let's have an empty line between tests.

> +	test_expect_success "create a $hash commit with an unknown header" '
> +		git cat-file commit $(commit2_oid $hash) >../${hash}_commit2 &&
> +		awk "{ print } /^committer / { print \"x-unknown one\"; print \" two\" }" \
> +			<../${hash}_commit2 >../${hash}_unknownheader &&
> +		oid=$(git hash-object -t commit -w ../${hash}_unknownheader) &&
> +		eval unknownheader_${hash}_oid=$oid &&
> +		git branch unknownheader $oid
> +	'
> +	test_expect_success "amend a $hash commit with an unknown header" '
> +		git checkout unknownheader &&
> +		git commit --amend -m "Amend a commit with an unknown header" &&
> +		git cat-file commit HEAD >actual &&
> +		test_grep "^x-unknown one$" actual &&
> +		oid=$(git rev-parse HEAD) &&
> +		eval unknownheader2_${hash}_oid=$oid
> +	'
>  
>  	test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
>  		for repo in alt borrow

Thanks!

Patrick
