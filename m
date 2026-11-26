Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689461;
	b=w71dm4OAKZqQX4+gDjep+c+1XHqtg6sIfnTDqBLYguzQGBV8OTKfFYBGmld8ma0NJPmc
	 waLa3TEzJBslXuV23kzmllMyYak3BbYpaAe4ZM1Srhpw3kQJSVOH4CdAuWBLbq/4vnTaW
	 8mT+z1ip014mzok6DFJtf48pNnl93+QAXKcQKc6hqyETZmhVHOvYFKX+ySdym+En38kXU
	 x8PmvMZuIi73Jq9m2EcjheiEsW1OLXm+hzGdM+yD1vpH5x0I/v8Im5pK+McBwMy66kB55
	 jxd6EZE0cjMT9Mywb+l/CGWyi9S2YqZGO76i6EPrzsqngIXErQJPMAPsGVuqSPncNig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689461;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=GWN57/6iqUxNf01ehhtuguPHAHzYGXyJFg/uUi2sxj4=;
	b=HV4nR3Aj8UfLv0U3MNH6aodQIKfoYbmSY4PtfDkzs9u5wWfui8zXBe4g9okEv3dFTh92
	 he/twc0WEDdCwtzdiUzA3riWU6yzBwKcwCjxHRnSuadbqOtjYSiFN3tqc1lg7jDxRLjH8
	 hSHV+54kdHUJr5alW/BGNZdOi2QGlYkjTjIK7BiuUUO//cEZhKGkkjrvEvo45Ro5a7rhm
	 Kus4uBtZ3qO8l6o2k09yOU75bWsZSS6ch8Y8vy/C0DiAX77PW8EzE1tcaJj512KvMx5cc
	 bPWVpYTa7MRGWlo+5JwaWu5EN0H07Vb28QV6q2DIwuY72KcL7Me5lz6KvR4jD2tCTSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=iArAFAaS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uI8nXKVO;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD411606A323
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 10:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD411606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=iArAFAaS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uI8nXKVO
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E790BEC05A1
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 05:37:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Nov 2026 05:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795689459; x=1795775859; bh=GWN57/6iqU
	xNf01ehhtuguPHAHzYGXyJFg/uUi2sxj4=; b=iArAFAaSXFLSibECDOfWJVUb9F
	Zrw+j6kJFVGKds97XbARJf6813ClJKtBmmU4VCs64mo3p/+Bc5dEaTfQ/4A4K+cp
	SUN71qxaVhoy63F3AMzYUc1z5CHB2vPH5NHT5DdwTfvmfxevMIMKoewIXiTfi+mV
	wHHciGusmQx1BHL5u2kLVUR/SkYpc1Cds7rVgMYAItZkSww/kAPlOKy5uQbrPV9o
	e67JqpeAHKXrGlrZNPjh1m7KgrVzy20+riMS8T2qRVnnzNhCdCqBA9lGWOllxa6P
	6nhTNdWh72ApuI/Bbbgb6OG3pKeZ0aV33MIqANBUnkhoCs5xpmj7m8cre/zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795689459; x=1795775859; bh=GWN57/6iqUxNf01ehhtuguPHAHzYGXyJFg/
	uUi2sxj4=; b=uI8nXKVOCgmRf7vsugNTbCcv1hakC7fGAy4SQfbyf1WQFe7Kg96
	Ra7edv/dHmXl/o+GIdtDd60QO9D6u7/fK3WXXWF2lQpu2/RVIuynVlZ8xDW4VXmv
	NxDSA0vtYyFkg3Z4uGOmCdL0ATnJTKAh9X6b7mrcJyxdY+xrPVeprvq7k3Bsd5Fk
	yAWUqOOEk+Y361uImBQn1Bc3TuxkFE1w8ezffqisf/fqSpzkSArsbp+1UJRhYlFz
	jPOYKHHkKfft2A1l9FtaUPA0T8PYPuTmZoHBPLffwFE/enMzOg3Bcpz0MO3ALJ1/
	aGEd4Gerfe7x5sfEkjezWEmyVtCD232AcEw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795689459; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fs+vMNevhacGo7Tr1KS1+TJySyp0HFjpkSroXRDfcmjvvjd
	hhgVNPb7gHTblj2deeZ+Iz6TqIUD8clqjjkJyh/MApCH+exI5oG6f11IUsGP4oEo
	hePmcb/27TEaBxAdbcj8m+pSxucy7SLxEIQ6rkZRMVQwT3Z4J6Vd06PMGRFIX9Sg
	hYGslJpRckidSeNaTzCvuRSjBlRQDKURpnCkOTzRvZOO8vg/FZxxjisoex7zwTcK
	DNsHWc5HjHT9PHaJLFrSBZylqTdKAedWMIxqcWm/gEnxQJhdsgAO4Yidf6Y4GoKu
	I/k2Im//4YDgfOR4FlcH/Hujq78q3iNFOZ9dPww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lDG2m0JeWjbxMtPdhL62U9YLes4u4+3kV++55OewUW0=:kWozLmhu3fuoaxkjFAETSMmwSG8ZMrvxUw0U/ymv72k=;
X-ME-Sender: <xms:8wsIa6bB1tOw50q1PU6dv5HDJAQb1oRzETeJyxqSkiA1LT9aS_X5Dg>
    <xme:8wsIa-7BFCPve5YGAEkxttb19ufeHSzo1DCZSV-nsNjve-pu_uux7Tb_e2KIxvcIC
    Nd4ycIA77zcpIeGYxxmtZJCwSNT55o3AUmICMhaEJxGqimtBYc3UD8>
X-ME-Received: <xmr:8wsIa1AjkPYdCSRAfBSmm6Z4ZqfUxIfhLnT8VqM17WmM2yTGiu3-Qa1UiZQsE2c_WIqxPVRVenJ-Nmz3dCTsBCJBq2HA4k8lp-tJtqU>
X-ME-Proxy-Cause: dmFkZTFZhgdK3yTSjoEnba4KPsiuQtztOoLqDfovWRuVQ90+oeASYdzRVJqOHY6TEGeXh1
    ET4jXW0tfpjTN6VPJyTCzDoB9N2WLjwbebCv3VeZyQOhVhKzlTAGCyvNRlqqBd8tmjsJ+h
    Ul3T4gNjsKMCWpngc0BFuV1LtUTgAx0j2w73Bd77xc2VJEUHbcN7FZMB2tlynCj8G2qRwD
    JYndV8g0HrtWXO7UP5YKnlrQpEmOLLfqSITFQgAJbYSMFo8JezROBxpMvHX0l23yrxh531
    32F8j64fH9McMPzU5iGSDD6SiNPEIQYaH1fnU5VgB69Fbm102mug3CbTmZROv0jo3uyDO1
    Q9zHxbEJqdVHNgDJfqxeGH9f4CoH4Hb1o9lQXIHnJS2qNPJRqxQR/xuZLFDcXfbp4El9+p
    Zzd56j1NtP0CLTAZ12sJXlqWX2zvC0bVyP46EtHJX6c41GQeneTKpeRxuc2guOvttrCbtd
    Gwf+GZ3Qvn0PPSEYYxK79AIg2oxa3FJl7OUGF7NsM8RvMzUnIR0gedyWqr5cE4nzOav5UH
    UTwfTbhyBtYtKeZDgSSdosw/xuSr0JCs/pHrALyg6XtGr/Gjs2KV7X8QoCKXxZi1w5OejM
    8VkCQG8i+/dQxHq+5ccd25V1W3goQTnMGsfIP/95ozR3URZm84modqiOiDDQ
X-ME-Proxy: <xmx:8wsIa8dC1WyXsy3O0ZtCNoIjdvGO7qJ3UeL3pkfx8cP5jHzy9yvicg>
    <xmx:8wsIa8KAeWjgwHcjXaTWVIf9HbzzdrsYadPixz92zOYDbSmjwjiIPA>
    <xmx:8wsIa_1fs4v7iRWla82XjsVN1Tj4m-dzY9AFg3-1YsIcPnTRgJD9yQ>
    <xmx:8wsIa2iHnM81Eih1-GABXYRF-SHS4V3xLbsIDgPRO4Q8791IJLtP-g>
    <xmx:8wsIayMxAMKvlZeiLTos5xpvVngBfx6Qlc-CXrhTeNPIIc3rZMaLM_vu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 05:37:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  dmnk+artist@google.com
Subject: Re: [PATCH v2] config: skip continued lines when matching section
In-Reply-To: <20261124180556.69724-1-dmnk@google.com> (Dominik Maier's message
	of "Tue, 24 Nov 2026 18:05:56 +0000")
References: <20261119192307.2683812-1-dmnk@google.com>
	<20261124180556.69724-1-dmnk@google.com>
Date: Thu, 26 Nov 2026 02:37:38 -0800
Message-ID: <xmqqtsl3op3h.fsf@gitster.g>
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

Dominik Maier <dmnk@google.com> writes:

> repo_config_copy_or_rename_section_in_file() scans the config file line
> by line and treats any line whose first non-whitespace character is '['
> as the start of a new section, without tracking backslash-continued
> values across lines, unlike git_parse_source().

That sums up the mismatch cleanly.  Because git_parse_source() already
treats a trailing backslash on a value line as continuing onto the next
line, keeping repo_config_copy_or_rename_section_in_file() in sync fixes
a real corruption bug for remove, rename, and copy operations without
changing how config files are read.

> diff --git a/config.c b/config.c
> index 275e709f06..cbdf3431f3 100644
> --- a/config.c
> +++ b/config.c
> @@ -3428,6 +3428,140 @@ static int section_name_is_ok(const char *name)
>  
>  #define GIT_CONFIG_MAX_LINE_LEN (512 * 1024)
>  
> +static int is_config_eol(const char *p, const char *end)
> +{
> +	return p >= end || *p == '\n' ||
> +	       (*p == '\r' && p + 1 < end && p[1] == '\n');
> +}

This matches get_next_char() in config.c, which only collapses a '\r'
followed by '\n' into '\n' and otherwise passes bare '\r' through as
part of a subsection name or value.

Using p < end in the caller when setting *continued also avoids falsely
continuing when a file ends with a trailing backslash and no newline.

> +static const char *skip_section_header(const char *p, const char *end)
> +{
> +	const char *start;
> +
> +	if (is_config_eol(p, end) || *p != '[')
> +		return NULL;

We return when at the end of line, or not at '['.  Otherwise we go to
the next loop.  Wait...why check eol?  '\r' or '\n' are certainly not
'[' so wouldn't it be the same as "if (end <= p || *p != '[')"?  Wnat am
I missing?

Anyway, we saw '[' and come here.  We keep scanning ...

> +	for (start = ++p; !is_config_eol(p, end); p++) {
> +		if (*p == ']')
> +			return p > start ? p + 1 : NULL;

... and eventually find ']' before we see the end of line that had the
'[' on it.  Initialization is (start = ++p) so in the first iteration
we have (p == start), in which case we return NULL (i.e., we reject
"[]").  Otherwise we return the pointer past that closing ']'.

The proposed commit log message does not make it clear why we want to
reject an empty "[]".  Or what should happen to say "[ ]" for that
matter.

> +		if (isspace(*p)) {
> +			while (!is_config_eol(p, end) && isspace(*p))
> +				p++;

We allow whitespaces after the opening "[".  Then

> +			if (is_config_eol(p, end) || *p != '"')
> +				return NULL;

We want a double quote.  Wait, why double quote?

	[core] username = ...
	[remote "origin"] fetch = ...

We do not allow whitespace before 'core' or 'remote' in the above
example.  We see after this block we reject letters that are not key
letters or dot but otherwise keep looping.  So 'core' and 'remote' in
the above example are simply skipped over while this loop spins.  OK.
And after skipping over 'remote', we skip whitespaces, and then yes, we
expect double-quote at the beginning of 'origin'.

    Side note.  I recall we also support

	[remote.origin] fetch = ...

    as a less expressive (because you can only have keychars there)
    deprecated synonym.  They are treated just like [core] is treated by
    this code, I suppose.

> +			for (p++; !is_config_eol(p, end); p++) {

And we keep reading inside the double quotes.

> +				if (*p == '\\') {
> +					p++;
> +					if (is_config_eol(p, end))
> +						return NULL;
> +					continue;
> +				}

We allow a backslash to escape any single letter, and this can be used
to escape a double quote that is a part of the second level variable
name.  But we reject

	[foo "bar\
	... anything here ...

i.e., backslash and then end of line.

> +				if (*p == '"') {
> +					p++;
> +					return (!is_config_eol(p, end) &&
> +						*p == ']') ? p + 1 : NULL;
> +				}

After we see a closing double quote, if we are not yet at the end of
line, we may be ']' in which case we are happy and return the pointer to
the byte after that closing bracket; otherwise we reject and return NULL.

If we do not have ']' immediately after double quote we reject, which
matches what get_extended_base_var() does.

And all other letters are simply skipped in this loop.

> +			}
> +			return NULL;

If we exited the loop while looking for the closing ']', we reject.

> +		}
> +		if (!iskeychar(*p) && *p != '.')
> +			return NULL;
> +	}
> +	return NULL;
> +}

OK.  So we find [section "header"] that is syntactically valid?

> +	for (; !is_config_eol(p, end); p++) {
> +		if (!*in_quote && (*p == '#' || *p == ';')) {
> +			*continued = 0;
> +			return;
> +		}
> +		if (*p == '"') {
> +			*in_quote = !*in_quote;
> +			continue;
> +		}
> +		if (*p == '\\') {
> +			p++;
> +			if (is_config_eol(p, end)) {
> +				*continued = (p < end);
> +				if (!*continued)
> +					*in_quote = 0;
> +				return;
> +			}

Tracking *in_quote across continued lines makes sure '#' and ';' inside
a quoted multi-line value do not prematurely clear *continued, while an
invalid escape or a bare '\r' after '\' resets both flags just as
parse_value() rejects them.  Tricky.

> @@ -3550,6 +3686,10 @@ static int repo_config_copy_or_rename_section_in_file(
>  				} else {
>  					strbuf_release(&copystr);
>  					copystr = store_create_section(new_name, &store);
> +					if (output[offset + i]) {
> +						strbuf_addch(&copystr, '\t');
> +						strbuf_addstr(&copystr, output + offset + i);
> +					}
>  				}

For context, section_name_match() gobbles every trailing isspace()
character after ']', including '\r' and '\n', via

    i++;
    for (; buf[i] && isspace(buf[i]); i++)
            ; /* do nothing */
    return i;

So output[offset + i] is NUL on a plain "[section]\n" or "[section]\r\n"
line, and non-empty only when an inline entry or comment follows ']',
matching the existing rename branch.
