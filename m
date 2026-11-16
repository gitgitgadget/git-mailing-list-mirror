Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810933;
	b=i8erQB9kbg7++WFQ05xdH8wpijltkeYSsi3XC5Xd+ObnSqC8YW38n1scz9wAB8yLkEGM
	 n7sshGJvp5OzsvQRn48k1ur40/v1k5jk2wtqQx7FmhCTjbtFkKy2G3GHukhhgtF5vBGrp
	 Jz3oZV8P3TiKZyo4Q2/CvQauED4n9YTeWxz+UCiDDdLnLYuoxAe5Hvr4nrHbvjU2jFSib
	 KUlgeNwGaDsxk6NiSXfQYFsouHaTTNk0DuA900dc5n1mCP2KlFIRAl0TEI7iZIeNRbWGr
	 Vd5sSiQ9vEzIQfS4Pdl4VnGBmTkZWtyx3aaOCxja13bzSId5mT+ytHgZISoLt9gkA6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810933;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Adpe2qRG8xLTkd9q2OedAAx5MOkKKimxYAnLhHGGf4k=;
	b=yxDEojl25uMT6BgzbqdBrVpu4zgXU9l1f5KO5A1qlwpT4vwh/6Ef8OVdN2VIiw3Ppbct
	 zyk22dJvAd5XmNtsaL6jOt6Q/6bdJ8sHmrc9KL9PPgTvpYGFB6itFKmqoNxBfOAQZxfRA
	 XCxO16p6vYGW6YUeZED7iZgJmPlqHfvFG46X1n9v2e3EL+G3KaabaIqjr2Kziarzlpfo+
	 Wa3+pxEcFQBcNgk7KZhNpBtMQ6bApB0ZVx0amdKtPHHkYkGes79M4pMZTuJjAXKWXAHyq
	 YoO4vSJF0xitGhtYIf7bRXtWsyXNeKEqM49Dx55dSoiqOZHJbFeO8zck0uwfuxNVibQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Fnx0zeo2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="l/gVfGYw";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B539606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 06:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B539606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Fnx0zeo2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l/gVfGYw
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A46B57A00F7
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 01:35:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 01:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794810932; x=1794897332; bh=Adpe2qRG8x
	LTkd9q2OedAAx5MOkKKimxYAnLhHGGf4k=; b=Fnx0zeo2rroZesceHV2Uxr7V0g
	P8JSNRX1DLjt8YOf9n+A0dY3XSUEeXlSy+UO2WzuvZ+Ne+q5WKh8/5niK5xYyX+g
	PusLdvJx0cttVTyD77zhAsiSwhGZCABgAMV44j3UVIQ2wbYWhvV71xb0uTok8rUO
	nl3EN+cgLPt989taMLY8YCo4vQk+8xO5az0vdGt75Hqjox2qe3DAsetBTsh6qAXS
	0qAvY3jyN3VmL8lXocP+0sKEqpJCJTRZUHmshn07Ri5pdoA7HBIOxn4vCY05UhsI
	1Yo+tw5CuhiZ14X5k604OqeyAkblAQSbYdqmiyja7FSfT6lSYrB3VY12+kLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794810932; x=1794897332; bh=Adpe2qRG8xLTkd9q2OedAAx5MOkKKimxYAn
	LhHGGf4k=; b=l/gVfGYw3w8WvXDCJhTcom16KRftXRuxU8qb6rIPDgNtDR4gkaJ
	MuHcBGUYuQF7A+7RHNy5XKS34YIJgGrQZRClqW7A2qEHZZZKKdKzDuGvOD02RQgf
	IhOkFKIK0jLzIeGuGzzAQ3Zn6jmoaYnz9MA72VQ3MrGD0Hz20tcxIQAYDtB6nmF4
	DvBVhCpGCPqLZ150k9jHeqU+6sXNcVWR+0y2q6ZRMvsBR2xokQbIGkTRWk3Z3Z4V
	jTL/+Hy5rrxxK5xueZ8ekq2gwlV8KdyqhwlnD90lqMroQbdH+2WvWhqrQmdcWhe9
	o/Qg0KuYdeQwD6Yc45Wk/2iOuq5A8TkeDaw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794810932; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:gL9rOpCOp0PaJqZSzOPNsf/zP7Rk15RjHgJnG0QawdF3DXM
	5p14VE/jOiVcXIBfzmTqihJRvH8O3nYVsitrkolKdyKRrdx+i5C/Ccjvypg8u3VI
	xUhb7/+EBn6tFxMmYv+8m3nx8/6WO8nIjc4DTL0irIAG8+s2V65sM11wRI1F5itQ
	DuawKQTKpy15QdwLWTNyUrJ8y6d4mLLDwPpmo+Fj3AJ+kpRAKD+AJZYHj6ErV1TQ
	ZFbfmtrwkHNaV11L0JiWlaAt+5T486rqirnqZtWy4nKuJ+VgxQzmVFzBR68QLo4E
	63wIcruG3pLTJ7LvcN1RAR9QzIWaIlrdgMZpXDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:70aNxF5X7gioIEW8P0GDRiyd1tpkj2Rg2Z63U+yTTv4=:ku4z+pGNruER/0e5D+rw1Su8gLm6B+StJ596n8U/vL4=;
X-ME-Sender: <xms:NKT6auD-h8zy9N0wAiz72sFNv_REsRf-CotVF_kvqIAv0LAXdYY31Q>
    <xme:NKT6av-8Ni0cr5drEt1-vYeMpKOciHBfuTmGojMf50DLaigg0EJQVw5S_jAluW123
    fc0mER8CqhlDqaGyyIwF6-6fubleCUsHWGNieacdRwZ6f9h7t17sA>
X-ME-Received: <xmr:NKT6au-arf8csEpDFxBEKRa3Ob6fJNCJ8MEApcXySfHrotbDi69u4svZ88UVs_e6LK9UHDU>
X-ME-Proxy-Cause: dmFkZTEWd2DAugSAo/XXdjrivzobrJ3yJ1Kq5B+nap3NBbQCKOgsXm5Cbph3tJezarBKNf
    Mvnnv6GPJix7ahhqIGuFPUf8iUkluFdyKhGUZdQxaUmVsj9vOmxSLB3axDWm3lSEGfZEXm
    4fRbbkuBQ8iqBvb9fRWMS45o25g6Knri8qAWb9sWUXl+Ng9zLb/BWkMCPa3QuTwZCqjyVR
    WrF69SmA8xkAqMMiR+lRhbwpeAcJB+xlUjqaBHV3YkTbWogg/yms/ctTi+blhQdisIUXmP
    eeUAa0NVyheTmUdTJ7yXFNBmcSbToYyGSZ/X3UCsuybG1aCRHgmeYq+3TlGs7OkT+6vaai
    TPThM8f60L8c+RnswrZLwZKPLJN3teqoHOFKVg0Qd6bUEZ/21PZAcoBPZge34et25J+tFp
    IuAoTY5O1So9DMwIDY7a+uJGU5Nt8jDw+QfMq6NmyS3seeKtjOUZYnkPYhSP/Uf1W04Pt7
    1UNeo/7OhWIYzeHxBNBKXqS2+ZGUVab9CE6AHEut8hei+ki6xBgTX6Q3+g5eEOZfuM3zje
    AybZLjyNj4v76MWK/7nGJXM65wzl/4mNZwzM4OTAuesooHC6GJTkmNeYvAmqDsCXCJ+trR
    i5LQUTkp6xWO5jliyG9d8NTn3sdS7n6q455Rwd1o85UKpmNhbA6rl7Q0VOAQ
X-ME-Proxy: <xmx:NKT6amc1PNUh9XQtlwpqDZtHjV99lf8zh-DtuSaA3cxofFETqW7ltQ>
    <xmx:NKT6anHC8tkFBZ1NUUWcz-CccYLkrJzUpDN7tQ4rWEgNw1L8SCVgRA>
    <xmx:NKT6akfRyy-A1g6nDOQTEjxDoZhFLMRh6wuutFO3sMPbkTZcoKKt8A>
    <xmx:NKT6ahHvFGUHVadPLK63dAk2W4RVDuq3DD8AMGYRAbdvO7M1bh9khQ>
    <xmx:NKT6av_786Wf53J6375EDU4xic9hLMT47DS__FFUWWwTh8iHSAodgm6R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 01:35:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09903478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 06:35:30 +0000 (UTC)
Date: Mon, 16 Nov 2026 07:35:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] promisor-remote: fix crash without a repository
Message-ID: <avqkLnnMwBNeWWtK@pks.im>
References: <20261113000600.202744-2-christian.couder@gmail.com>
 <xmqq33t4bjrc.fsf@gitster.g>
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
In-Reply-To: <xmqq33t4bjrc.fsf@gitster.g>

On Fri, Nov 13, 2026 at 11:42:47AM -0800, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> > When `git ls-remote` is run outside a repo with some promisor remote
> > related config options that make it write to its config, namely:
> >
> >   - "promisor.acceptFromServerUrl", which makes it auto-create a
> >     remote, or
> >   - "promisor.acceptFromServer" with "promisor.storeFields", which
> >     makes it store fields,
> >
> > it crashes in configure_auto_promisor_remote() or store_one_field(), as
> > the `repo` argument passed to these functions has its `gitdir` member
> > set to NULL.
> 
> It is tricky that "ls-remote" wants to work outside a repository.
> 
> > This has been happening since 3e20258d11 (promisor-remote: allow a
> > client to store fields, 2026-02-16) for the `storeFields` case, and
> > since 7a56394fc6 (promisor-remote: auto-configure unknown remotes,
> > 2026-05-27) for the auto-creation case.
> >
> > Let's fix that by checking if `repo->gitdir` is NULL at the beginning
> > of filter_promisor_remote() and returning from it right away in that
> > case. It doesn't make sense to further process the promisor remote
> > advertisement as `git ls-remote` currently has no use for promisor
> > remotes anyway.
> 
> Another possibility is to nip this higher in the callchain.  If we
> know, as you said, "ls-remote" has no need to talk about promisors,
> turning promisor_remote_reply() into a NOOP outside a repository
> might be better, but the function does not take a repository
> parameter to be able to tell if we have a repository in the first
> place---perhaps we should add one?  An illustration patch below.
> The callers (there are only two) should of course be updated.

I was wondering myself whether a better fix would be to start passing
down the repository and then detect this case by checking for `!repo`
instead. From my point of view it's nowadays a bit of a code smell to
check whether the passed repository itself is actually an initialized
one or not: if we aren't operating inside a repository, then the caller
shouldn't pass one.

That may be a bigger refactoring though, so depending on its scope I'm
happy to live with the easier fix for now.

> diff --git c/promisor-remote.c w/promisor-remote.c
> index 316d9950aa..702c53c2c4 100644
> --- c/promisor-remote.c
> +++ w/promisor-remote.c
> @@ -1373,11 +1373,20 @@ static void filter_promisor_remote(struct repository *repo,
>  	}
>  }
>  
> -void promisor_remote_reply(const char *info, char **accepted_out)
> +void promisor_remote_reply(struct repository *repo, const char *info, char **accepted_out)
>  {
>  	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
>  
> -	filter_promisor_remote(the_repository, &accepted_remotes, info);
> +	/* 
> +	 * "ls-remote" has no business talking about promisors, and worse yet,
> +	 * it can be run outside a repository.
> +	 */
> +	if (!repo->gitdir) {
> +		if (accepted_out)
> +			*accepted_out = NULL;
> +		return;
> +	}

But in any case, we should also detect the case where `!repo`, I'd say.
Otherwise we'll have to adapt this code again once this funciton's call
chains get rid of `the_repository`.

Thanks!

Patrick
