Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457047;
	b=5bFRa/RtoNhM0hAbDVW9ph2MvqHWoaSG0qkpxDRC6KyA8cFmAYJHmNOs0QHUcW9bDZR+
	 10TpHMbJ/WQXoL3mNf3/JvWEf3HNjh+hXUg3Gv9K3Ez7XCuE9YJUV4euIZeE6ZRColCKP
	 3GfpQpZGUV0D+YK1O3bHtj/pZGKI3fnkca/3F664NejTGLC7dA2RTNdz+6PrCCp+V54C+
	 XP9smpbZXN9dpuGLN4strULXTRqgh+RXqpj+ecTP0Mbc22cuDKNbqC6EfpnHb0xNWknrg
	 6ZML10wJhK2kIVJvRehetd/PLwNTRvre2OJBPBwpWvlBgXahffalg4VVMQ7/uTHEC7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457047;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dP+xd0LiErSheGMHHYzgF4xsxBA1SSu1gbc7YvGxj4w=;
	b=uvhWF1mPJYvBudIAzprdK+X4jROZDf+NSf2HT0HJDOBEMXH2WsIfW39/mm872nqwlbux
	 k6391tCBUcieHEEnpnurZ9si6ssnEK+o/9niTuxZwJZN9umetbiaaUqVjxUCVYrrTfgXJ
	 zrq7jt+IdFLjN6/MbpSug8ZbOzfKyjmPNHa/bJP5iGJsgjhSTiM1Pl9vwxznEkRyHGiFG
	 99JtlmdMgEGpn6vWjxXJp9/VAEZ/GzCYTg+uNxGRUuCUD0xi8O+Z81b2uiP1dYV6qcz0D
	 i/G67bSrDjnyp8+4VKKqz/5OQ9s7MF/+XEdGXuR8lMtoOpQuFIgNCbWbtR+rzK3YwSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AA9rbd5F;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZlRmkuTf;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F3606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 18:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 460F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=AA9rbd5F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZlRmkuTf
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 432957A05E1
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 13:04:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 13:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795457044; x=1795543444; bh=dP+xd0LiEr
	SheGMHHYzgF4xsxBA1SSu1gbc7YvGxj4w=; b=AA9rbd5FQqYQTwtmz4ZHqEZGLe
	+JYRhuNf42chWwB6N78vqQs5cYbMwLYfwE0faH8qsAQnqbvgyHEfhPVNpf21ULCB
	CBcO1JpGyPhrBe66avMyxixynoPOrIHR8pmwZh2rDvXBmoJI/gQ9E0IWhHyZ+DIc
	+YB/Nks84Jdq+zun5Fs6jPrZHGHFHTUwmHtCamkkkc2yx8gwm6n+qI2jmTF7l+/g
	Jb4zurWmCR+jw+y5K7uAEJieLGmz11s7IB83F62LHKwYSpVBAzP+zDyAE0HE8Q/v
	bhy0MSNCbch9wS2afQpSRuY176E76Kf9RiECQdIpQXqo34mcjgJ/F4NRTnyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795457044; x=1795543444; bh=dP+xd0LiErSheGMHHYzgF4xsxBA1SSu1gbc
	7YvGxj4w=; b=ZlRmkuTf0z/OoDpQb6aCct/RRPFNiZ5kf/Gyz/Lie0MUNcPE75i
	jZ/kwnbUOFSscA/LpxcCu+neSkqSniGk6mhg/3sr6RV3pysCeLEDeALuADBP3sjJ
	xzfqXCWv6itqKG+6bpYNgy8u6ML3f9uSMNR9VqvY9JrDS9CVbq7r63iqdak3Abql
	hzbldR0eljfzFY+3Mmwj8BDK01HvPXCfr3vpxVPbPzHocPCTJ/qnyjEFhccc4Ucj
	DypARuwsbzBehJhBX0/W//U/5SREs7muDpWwawkz8Pmh+Sb4R11ULm6QzaOCEz1T
	6cC2qRbnZTtRKXgKqljle5UoNrDPrCWjzOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795457044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O45HiqyNAkPhXPtiDX6QvJhV5G72pWOUdjZQo5rK7jI4m1/
	clgSXXb9LpyRk8e6ifPCw/85q69ZqEd5NnMC8cJqWNb37RPZybL6QKl8HSicKxbz
	pCH+hPBKdTGlZ4tP51VocsYKIgGmDH4GLaryffiO2460YuC69ZCIDED7W7SRbyQC
	PeVFOHAkicjkMR4jc/MCUN7IAWKdI8J9f1PB1ZJcIhWxTj0wkaq1Ci71SI0z7aQi
	6MGnoX3tVPUBF4GjkNxVlS3Ku1pywxyuG5HFTSmT4HA4jt/VwNn70c64ncRt702w
	hDkvCEA5eHwRnPbIsR2LCAJz0gF1G4Dt5c4wX/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:grf10bILzdNP2JUrtQpSS77lgzBrynaYi2bcTgE22gM=:aReRRcCSSZk33Vcxnn68r9u4QNJOo592tChN4SSdiHA=;
X-ME-Sender: <xms:FIAEa7-PUnAkkjSz8E-2mXDcJqR5m9i10eO83wIDgZX31-L_mcZxVQ>
    <xme:FIAEa5_SLiV4IFWJEsSRL3sElL9yI0SSEg7ZwJJIYl6nvwMojzydXl1qfW9TYv4yM
    4OMNl0EsycpQpQQOoMToPYnNNIFJxWGMfQ2aJY_v1tWEulvEWV58w>
X-ME-Received: <xmr:FIAEa7RjAt7o-YJ7sTQGAPT7of7TQM52eZquA0qP-gFlEBJLN84WyMjCTr51iQmqr3XeTZha7t_F01KOCV-TE6xYTRbjrngFOzAbr7c>
X-ME-Proxy-Cause: dmFkZTFzitr2Lm378kOxm1D7KnyeNE5bPFVXFdR43hz1nV0903kWXGB+57+rIoXa3NIcpt
    nxjVVIuXAUisfaeDBpa+GjkcJ+87AckiVUjquyPIq7afEGqJh2OuuBhqou9E6Vaj7o9JJZ
    kpad2M0f/NsS0gPv/+LPyGKuhF/ydZGMU2355RJoOlW2QgrkCe5rLGRc8uEhpv/X+UrpPK
    D8ldmgkBgZIr27LwHDcsoqKjjNEueBhSMr+xL5mcn1SGXP7Q4nLnMhdIZonYezCTzob4pe
    USYQNGSyF0iINZmupFEavaY2eiTfpNazikKNQwq/Qznu073/j7qWMreW6KvTO8JkOvUtK2
    MoiIdlchhZPG5RK7elBi/F5A5pK1bgOdYjbAY3JDUphnqVeZyKOlegNrP3jOmLbBRT5mm4
    tZMNY8/9XE8BGaHk9ZtGRkQ8qSAUlmKUa9bOnafJRjv45P1cEeYUh8AKcrP1uvYgI93hvQ
    h9/1c46dKg7HrQsB6o1oWCOp1Ck+p2+n7gvqyCje3yIZHVphUUdRclwA5fJRzqcc/7A3SH
    rx8uifPFXJ58wivCtLfWuhQMX81l5RQdKdk3H2nv6INu3yqIRhgjSBudVixnILwbSPXF0/
    MJeFqrYgmFrtMB0e6xWEPMyaud4ONWZe1+dPw4M285sqYfdM7MssDPjP/d3w
X-ME-Proxy: <xmx:FIAEa9eZNz3FxadI2J3lXIPj-4pDnOoOXcONr8LD8R5M8HUL9lbDBA>
    <xmx:FIAEa_B-zJB__NJOKaRxFsBJdCsvQiKFGm-fLPjsZlWbojWWezvtdw>
    <xmx:FIAEa_kLq9gZb2tBCfeyKf9DiFNq5vFM0W_RU4DJH_QehKM2sg388A>
    <xmx:FIAEa6cq_Fj--8s9r0k4tF9k_nbQ_ule8NCPcoK8kT_AlD4Rtn-zNw>
    <xmx:FIAEa7EC2RTugf-LalHg10xVejfANtp-U7qG91RArrJSKxuLZ5gPqwUB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 13:04:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Adrian Ratiu
 <adrian.ratiu@collabora.com>,  Jacob Keller <jacob.keller@gmail.com>,
  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an
 absolute path
In-Reply-To: <20260929185122.3127574-1-lightofmysoul@gmail.com> (Stanislav
	Aleksandrov's message of "Tue, 29 Sep 2026 18:51:22 +0000")
References: <20260929185122.3127574-1-lightofmysoul@gmail.com>
Date: Mon, 23 Nov 2026 10:04:02 -0800
Message-ID: <xmqqbj7f77cd.fsf@gitster.g>
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

Stanislav Aleksandrov <lightofmysoul@gmail.com> writes:

> A submodule URL like "../../org/lib.git" breaks when the superproject
> is forked to a different depth, e.g. into a GitLab subgroup. An
> absolute URL doesn't break, but it forces one protocol on everyone.
>
> Resolve a URL starting with "^/" against the superproject's remote,
> like "../", but from the root of the server. Protocol, user, host and
> port stay the same. For "^/org/lib.git":
>
>     https://host/me/super.git      ->  https://host/org/lib.git
>     git@host:group/sub/super.git   ->  git@host:org/lib.git

So this thing is designed to handle scp-style URLs.


> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
> index 722d827908..f512625eb8 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -40,8 +40,9 @@ subcommands are available to perform operations on the submodules.
>  	project: the current project is termed the "superproject".
>  +
>  _<repository>_ is the URL of the new submodule's `origin` repository.
> -This may be either an absolute URL, or (if it begins with `./`
> -or `../`), the location relative to the superproject's default remote
> +This may be an absolute URL, (if it begins with `^/`) an absolute path
> +on the server of the superproject's default remote, or (if it begins with
> +`./` or `../`), the location relative to the superproject's default remote
>  repository (Please note that to specify a repository `foo.git`

Calling '^/' an "absolute path" (you have it in the commit title and
also here in the documentation) is a bit misleading for scp-style
URLs, like git@host:group/super.git -> git@host:org/lib.git, which
lack a leading '/'.  These scp-style URLs that lack the leading slash
'/' immediately after ':' are not absolute, and had better be called
by a different term, perhaps "paths relative to the server-root" or
something.

> diff --git a/remote.c b/remote.c
> index fe62068463..05ef35e3ab 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -3095,6 +3095,67 @@ char *relative_url(const char *remote_url, const char *url,
>  	return strbuf_detach(&sb, NULL);
>  }
>  
> +static const char *skip_bracketed_host(const char *host)
> +{
> +	const char *start = strstr(host, "@[");
> +	const char *end;
> +
> +	start = start ? start + 1 : host;
> +	if (*start != '[')
> +		return host;
> +	end = strchr(start + 1, ']');
> +	return end ? end : host;
> +}

The parsing might be a bit too loose against funny local path
components.  Wouldn't both of these

    test_submodule_relative_url \
        "(null)" "host:dir/@[x]/repo.git" "^/org/lib.git" "host:org/lib.git"
    test_submodule_relative_url \
        "(null)" "host:dir/@[x]:y/repo.git" "^/org/lib.git" "host:org/lib.git"

misbehave?

With

    host:dir/@[x]/repo.git

in root_relative_url() below, for such a string, is_url() is 0 which
means scp == true.  We call skip_bracketed_host().  It matches "@[" in
the path and strchr(start + 1, ']') advances past the first ':' to
']'.  'end' points at "/repo.git" and that is what is returned from
this function.

The caller in root_relative_url() then looks for ':' with strchr() and
fails, making end == NULL.  The caller would give a "cannot resolve"
error.

With

    host:dir/@[x]:y/repo.git

skip_bracketed_host() does the same, and advances past ']', making
'end' point at ":y/repo.git", and that is returned to the caller.

The caller in root_relative_url() then looks for ':' with strchr() and
sets 'end' to it ('host' is the original string), and has_host() would
return true.  It would return a corrupt URL "host:dir/@[x]:org/lib.git"
or something like that, instead of "host:org/lib.git" that is desired.

We'd probably need to at least make sure that we do not scan for "@[" or
a colon past the first slash (I didn't think through other details, so
there may be other kinds of care we need to take).

> +static int has_host(const char *start, const char *end)
> +{
> +	const char *p;
> +
> +	for (p = start; p < end; p++)
> +		if (*p == '@')
> +			start = p + 1;
> +	return start < end && *start != ':' && !starts_with(start, "[]");
> +}
> +
> +char *root_relative_url(const char *remote_url, const char *url)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *path, *host, *end;
> +	int scp;
> +
> +	if (!skip_prefix(url, "^/", &path))
> +		BUG("not a root-relative url: '%s'", url);
> +	if (*path == '/' || *path == ':')
> +		die(_("root-relative url '%s' must not start with '^//' or '^/:'"),
> +		    url);
> +
> +	for (end = remote_url; is_urlschemechar(end == remote_url, *end); end++)
> +		;
> +	if (starts_with(end, "::") || starts_with(remote_url, "file://") ||
> +	    url_is_local_not_ssh(remote_url))
> +		return NULL;
> +
> +	scp = !is_url(remote_url);
> +	if (scp) {
> +		host = remote_url;
> +		end = strchr(skip_bracketed_host(remote_url), ':');
> +	} else {
> +		host = strstr(remote_url, "://") + 3;
> +		end = strchrnul(host, '/');
> +	}
> +	if (!end || !has_host(host, end))
> +		return NULL;
> +
> +	strbuf_add(&sb, remote_url, end - remote_url);
> +	strbuf_addch(&sb, scp ? ':' : '/');
> +	if (scp && end[1] == '/')
> +		strbuf_addch(&sb, '/');
> +	strbuf_addstr(&sb, path);
> +	if (ends_with(path, "/"))
> +		strbuf_setlen(&sb, sb.len - 1);
> +	return strbuf_detach(&sb, NULL);
> +}
> +
