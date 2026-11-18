Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043142;
	b=2KRoLs3w4p45qnKOmuM9xVvYHtaI5tAdf3MMXkRTMKSJS5n9iRVE3fvA2IStPUNza7HK
	 F0dht65glAaHbm/875eU4+ZGEikPumMsp/GS7C0O3d5P+ADslAD5OxKAkmoANzZSDpGyw
	 Trwmi9KxtN9D3ByT7hKmy/HYnPPhQtbx0lzrR1XGs/FMglD1Ob1ynpvgUkQz4iG1vQroo
	 g7Eykl0cgZ/NHF+8LG/5CaMWj2VnzxLVgsbEttEAWy/3s/u+Jr22by2dvKKk9x4V/Pva3
	 r/476r2MOu8T3rsHk41KV3Er8aj9jt/Sj8eX9x2m5PnfWVGSn13qLyCHsZEgMgHRdKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043142;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=uIODOHDjjXpc5r2rqgl7Re0mwJa/xj8EyQTnXjtXSJU=;
	b=pWmng6/+yngHdlyL65h+fnhRPnYx0tRDATB4tCLS7Ozb55KW2GeOU9EhW63M9ihWRJ9i
	 u51GNFBYcUHrlNFtmDpXmpxvPaGA4JnGy0N8HCx9Vxq/G/QBH8q2agdB1AZhgHkoe/4zs
	 TY1Q+NI02ZkNitulRd6FET5KpVLmMX3qnlSVXabIFS6dcq6aMoQEDnd8sbh+LeLd7+n5M
	 febyr0U/bBRT9NamtayRBai6QmL8KepRSNOWIhce2Pm8oGSutad7pkNYha5fRIr7tHXD4
	 RHK6MaUHn9Qk8tgt7EklYBD8gvXlGIXk90otK4nyjvcOUAy7h17vnW1LYbdYI30/ynQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NKvf19s0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sXGaiAZs;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503A606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 23:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3503A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NKvf19s0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sXGaiAZs
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 622481400138
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 18:05:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 18:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795043140; x=1795129540; bh=uIODOHDjjX
	pc5r2rqgl7Re0mwJa/xj8EyQTnXjtXSJU=; b=NKvf19s0Ks9hqfkHAaxYGGTJ/U
	wZfUdIc6qTRcG2YQ1Isb25C40mBYmWAin7Eifjgyqu3MgweRKukkpEwpXp0/R0/t
	5+sXx4PC+VKr7hOp4EuetrDB3E/Tyy5jkmo7/RMpSeQst0rhxZOdB4L26l84KwxZ
	aEfO1RhESkepHad5xW60geBYkCE+f+Fpmu9sBESsbqX3juBTeN0lJKJxmL+Bz18y
	iuqB1gK0e1K4dnYbPCNdWECjkebOQCw+ivGsa6VrgJTDI0aKgCk9CvWbZAaP3g7E
	k15wZPT6mBTON5kCHddu0EpqwrVgywffL3d1gKIy6WEJbrzsH8t5qdFKnbXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795043140; x=1795129540; bh=uIODOHDjjXpc5r2rqgl7Re0mwJa/xj8EyQT
	nXjtXSJU=; b=sXGaiAZsn3zEHnBuDRnuuScSMlkJOco0jtiRRoGlNAPIgM2Uqwm
	u/Zw2lr1HAwT2myJ8fazwBwmL4dEMIMKzCUCS+eECNPzRTOKtAGe/+MAhvbee/zj
	S9vzt01oOk+Zc6vMuqPgJgVFAzNEBXJ1w+ome0HJtqlINPr+ZoEyfWffD7Eiilry
	466ZINu8ZEIH/5gCDvhsPQ3lRKLaLro4Bt7/d89nF8k2FlFyI9bviqzVA8kmy82R
	19WB64G22OeMNOEzQYL845wQE3SB/Llk9B6uRqNyFF97ZUM2hViRl1RB+icieaSC
	XnqIM1fVhnZzeTugTIRv+V20zoIqeB4eweQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795043140; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UWmVvgvZpy4+/izpYMNKGGCtOkSRYQq9Yf+SCbB9OeurHs7
	O5rKLQdsrWTWMAeOtyoWQA6gRqOS8yLtZ6rffdb/gwgc3vgOfeu9aEzYSQhsBvGn
	kGdffgk/33vDtrT0SEdts3nvoFbiBd9jhpi3dWEZw77UxgMw4gpQj15HSlg7t7Zw
	mMzVgHKVFjFztuNW9iT/LGdxgD5/NslW7vE8QMFNFiTByQxWL+Z/vStroZEMO+6D
	kS4U/2XdJ56D5Sh2XsuHj+XC3aXTUo6vFtdqx+4wF4J2oS6MlJWzLlF/e1tRMYt3
	XCZWsgs1881GFlsjbCFtnqWca5uWAMz23XEjesA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:LjqkT+56/mQ+vRZCOlF9OWBuOK9t9prg2EuWIH9xWSs=:/aFy+CW7RGcIg747reetTXPyusypJFYyKKBgB7PXXFk=;
X-ME-Sender: <xms:Qy_-aibKtogMruIjpvO8h7NDCU3kasya6Q8N3r7gaCyWgpPOClpq_A>
    <xme:Qy_-an8WLvG1mbBcW9s2jMoDmWtBbCkeBfFqxy_p1GE606jrfo7K8wT8DVcsXmJ5m
    y5K2rlwmlmfnnzvaZs3G0VzWvKerXlG1UKBeRPb-VjlO4eCMKpW6oY>
X-ME-Received: <xmr:Qy_-agmDB3_nqvsgMhf9xk5Gt2KKHDOGHGlazOIsLYokCIdjnOrWTSbF-M8XWh10NR3wOEIXzF-Yl1DH0SjO2P9dNHqCkyG98q8Z>
X-ME-Proxy-Cause: dmFkZTFNWw9MfQUT1m3aTmBLnD918d3gV1WvL4k2k+edr1OQyHlEcN+IFU3p7C39pTcFyp
    Xc7DGQrWeodsx4SlQ+kPwrRgRia75cN3DKxVAgLFC2XW+HksYUINQ4ieJv2/KoErSJhLT4
    bE6R7fviHqJctk7yIub9xhdKE6XituYkhGxdTohOKLnyy6vrMRLmsZ8Yg+vDimyrUkjdzg
    PMtMQ4J8hnw2Uu5zRkwQCbS5F3+kiFuXZyoPocOo1oHKkZeMnTpl5h7EL4JxlfUXNQRnq+
    iUHOvrTORsE0KJvFUKr2ArnfTnOxUSlqvx1egIzhJHJzI9Fg8MaEN8IXykQsTwobZxjPmM
    rATFm/yiND1sAgnr4U5e/EFUIGSiPYue5Q/ky0vl0Fn369QAGpzCJCo1vxN7stM4AeiO4A
    wZBh9xjVjL2eKOKvweLiaGWegTG9M3tDZBbYlS1gaGjwiTXiAKrRF263qpRbq5cnpYXmlB
    /8z7va96T4JybEbhZ7YJp2o+tauEz/zez0QYBHjX6CsrOyjIridVhiTjOFgcIkYH5vWWZf
    RjkJx+kqZw/seBSXvzBcT+BJMNx5mkzrbucIHUdBOtLmbdgxu0Mce8pLuxc2JuFkihdcu4
    9EMqWZ6q9OjK3gPz5tFJhJGaQ+ZVvIJYLVj7i44EhvAZBviSH6qpP1/xXfeQ
X-ME-Proxy: <xmx:Qy_-akyWxX0m09fRA81QLPYQlZVhRsKM-N6yXZRVBW4e2EaclGS1mA>
    <xmx:Qy_-ai52uQkwuTPyG_QS0gY3fYqJDH1o_71bSykZKv_wspq6RjG7Ow>
    <xmx:Qy_-asVbLqxnWARkgk0vDg7Y_mkjHsn0tfD6DUCgHM9v8C_Wqx9zAA>
    <xmx:Qy_-aiIN0y7TekOMQCcHFRvcVxe7lxvRoG824SMxBuU_fHDDbxesHQ>
    <xmx:RC_-apNEY3cR7qFYS0euizKcNNSKTZx515eXD9QwsH4-NU2Gje4DSFkL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 18:05:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8 4/4] branch: let --delete-integrated find branches
 merged onto changed files
In-Reply-To: <22658105edeacf296a18373400e7b35141e053ef.1794921876.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 17 Nov 2026
	13:24:36 +0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v8.git.git.1794921876.gitgitgadget@gmail.com>
	<22658105edeacf296a18373400e7b35141e053ef.1794921876.git.gitgitgadget@gmail.com>
Date: Wed, 18 Nov 2026 15:05:38 -0800
Message-ID: <xmqqik1t2119.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -888,6 +897,8 @@ static void collect_branch_changes(struct landing_search *search,
>  			   search->changes_alloc);
>  		change = &search->changes[search->changes_nr++];
>  		change->path = xstrdup(p->two->path);
> +		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
> +		       &p->one->oid : null_oid(the_hash_algo));
>  		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
>  		       &p->two->oid : null_oid(the_hash_algo));
>  		change->branch_mode = p->two->mode;

Mental note.  We are recording the mode in the "branch", but never
record the mode of the path in the base here.

> @@ -895,25 +906,65 @@ static void collect_branch_changes(struct landing_search *search,
>  	diff_flush(&diffopt);
>  }
>  
> +static int merge_keeps_upstream(const struct branch_change *change)
> +{
> +	mmfile_t base, upstream, branch;
> +	mmfile_t result = { 0 };
> +	int ret;
> +
> +	read_mmblob(&base, the_repository->objects, &change->base_oid);
> +	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
> +	read_mmblob(&branch, the_repository->objects, &change->branch_oid);

Imagine that a path that originally was a gitlink has been replaced
with different regular files on our branch and the upstream.  If
this function ever gets called on such a path from changes_landed(),
the base_oid would record the submodule's commit object name, and
read_mmblob() would probably crash.

> +	ret = ll_merge(&result, change->path, &base, "base",
> +		       &upstream, "upstream", &branch, "branch",
> +		       the_repository->index, NULL) == LL_MERGE_OK &&
> +	      result.size == upstream.size &&
> +	      !memcmp(result.ptr, upstream.ptr, upstream.size);
> +
> +	free(base.ptr);
> +	free(upstream.ptr);
> +	free(branch.ptr);
> +	free(result.ptr);
> +	return ret;
> +}
> +
> +static enum change_state change_state_at(struct branch_change *change,
> +					 struct commit *commit)
>  {
>  	unsigned short mode;
>  
>  	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
> +			   change->path, &change->upstream_oid, &mode))
> +		return is_null_oid(&change->branch_oid) ?
> +			CHANGE_LANDED : CHANGE_MISSING;
> +	if (oideq(&change->upstream_oid, &change->branch_oid))
> +		return mode == change->branch_mode ?
> +			CHANGE_LANDED : CHANGE_MISSING;
>
> +	if (is_null_oid(&change->base_oid) ||
> +	    is_null_oid(&change->branch_oid) ||
> +	    oideq(&change->upstream_oid, &change->base_oid) ||
> +	    mode != change->branch_mode || !S_ISREG(mode))
> +		return CHANGE_MISSING;
> +	return CHANGE_NEEDS_MERGE;
>  }

Now, if a gitlink was turned into different regular files, as object
names in upstream/branch/base are all different, none of them is
null_oid, and as we saw earlier, branch_mode is from p->two->mode
found in collect_branch_changes(), and mode would also be for the
regular file.  As the mode is the same, we end up returning
CHANGE_NEEDS_NERGE from here.  Which would cause ...

>  static int changes_landed(struct landing_search *search,
>  			  struct commit *commit)
>  {
> -	for (size_t i = 0; i < search->changes_nr; i++)
> -		if (!change_landed(&search->changes[i], commit))
> +	for (size_t i = 0; i < search->changes_nr; i++) {
> +		struct branch_change *change = &search->changes[i];
> +
> +		change->state = change_state_at(change, commit);
> +		if (change->state == CHANGE_MISSING)
>  			return 0;
> +	}
> +	for (size_t i = 0; i < search->changes_nr; i++) {
> +		struct branch_change *change = &search->changes[i];
> +
> +		if (change->state == CHANGE_NEEDS_MERGE &&
> +		    !merge_keeps_upstream(change))
> +			return 0;
> +	}

... this code to call merge_keeps_upstream(), causing read_mmfile()
on the gitlink commit from submodule object database, leading to a
crash, no?

Or am I misreading the code flow?

>  	return 1;
>  }
