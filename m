Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554646;
	b=XVJeweK+XmK8+tkEqbvWD0j3RMe3KnZ8XGmgRwG3GKFEkhYuxjl2lRIrTGL9aLw8eyXC
	 Ovqe8CtFOIi+YCkWMMvc/4qORR9cF84QbR6StbjZtbghyL5drkN4rjfeGPcIkHB80hB6d
	 nZ6NgvFomMA0+n7fQyJOU+ZI/EIMfTfgE0QIDRTEG7SF4yUz/EP+skLw1FrlUpEgoxmwF
	 aOc5V8w4kdSTUnU3purzWHhBLYqr0k8d128vpiRJM7w9AM/fCUryYOh2kcUlQLorqwQ/p
	 vVQkRSSITha1zwpRuret2fyfpdYN8cqRJKIDrIem9A3u+kcCb1ikfV0gnuSvucb5auw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554646;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vobyzRcLh89B44QNsbtIywo0bjO6nrjBpYFss4l1cTw=;
	b=XaPt6NG859bAJp99SVWQlmXQru5IZReGX2vXNFkaRgTTN7/oA1rVM2raOqWTEFQTVHux
	 jgX7/PGAtVAlyy13bkloLDWWlzF+wFcuyYsH4eQrhoTg/uJ1BB+feDssnzt1uMsmWfCnW
	 CVRVcY6cZOWX/w33tSvhDNgjfSd1Kb2dEHEjWlaP0nhUd6Q9bqt4HQNkt4r1z6x0BMCR3
	 dwEL3a17JNCfDSSa4QWXcGDstgr3Fwp4/we8wnrAzbsLSJ1WEyiwt3slDdfJGXdgWUzhI
	 NYonI5PotfXzxPDSSPC7CLDTpK85yKk0FT/waAlh4ezlrjNqnhBBhSEDMih766N/hjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CFBtr8Xc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dz4bBCR1;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3683606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 21:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3683606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CFBtr8Xc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dz4bBCR1
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E25521400303
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 16:10:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 16:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795554644; x=1795641044; bh=vobyzRcLh8
	9B44QNsbtIywo0bjO6nrjBpYFss4l1cTw=; b=CFBtr8Xcfduc58ONyQh8L9ST4A
	9Rpmx8NzE7tU1P5ikPpN1/KAFu6P/SB9KCswCFlSg9JvPP1OR5jz/beAK5ciyBnn
	GuFc8/fSG7SyhtcQ/wSG/oYrZOQGuY07GkZTqsskjGXK2ZCqNP4Pa4OgnLjCOisg
	dxOGrkixo4CvCaX3pO00UzebTI2wcfsBDoAt17+0mF8V86fjEBSA5ZMsks92Kgdv
	N3Gr4MwKswoQU0/Uc0I1s6s4npHHT2r6yXx+M6YNXcgnTvoIzVLn8V3YoTH5Y04J
	gZMvCvZD+f1LcZrD7lLdcAic9EXBlUtlQKql1ugjs9S6cfPH+wYoBsKsR68Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795554644; x=1795641044; bh=vobyzRcLh89B44QNsbtIywo0bjO6nrjBpYF
	ss4l1cTw=; b=dz4bBCR16tYiK7sx+18Zdf8kA9HbgX9wWL8twJTQe3ZMzi2QHBu
	v4o00j5F2TlhYLnRekWyZXRoU2RdcGW9yQ0wzmMAtihPWR/b03oXMwNZqkDi5Hcz
	YW7xhH3M2A2HhxRlIgwfF8D+fgBZoU1hScyrZ0BlujBnt2uz6+iRqvYbp71B9tNC
	vvYmCvLJqKmyI1utK9LT3yT/aETkA1hYOn16hgLSr0VnE1zu69cg2Vl3xv9sW8i7
	uIhAya3GPm+GWzpolGgutgc08NHEo+7RID0206joj3VtQk2oEDgQeeIxafzju3wk
	N9ljYSikO4yLPsfV4ZQO5gqDT5MeKxxegJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795554644; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Rn0F03LVLg+n5TGh8DCCnbkzxcxcA6a5Rbrk5N0ucMoe/9j
	xjRZd771QF6sGWc1AJLXb+ToSk0uFkOujW+IStDL0BYuh6axV1Oxkn/o75Mc2QA3
	xV4u5ah5URwqFzSv0nVCmSjYiz0N004eziR4Ngs7UCuGtqBaorRgrVXTYxOD/Lcn
	sDl9Z8JE93VLdNBj1/pURGxwfVewebxM3a3F3uSV6Vxfkhw1F+EqGbuhUyo7XYRP
	na3GFGw2o5z17w5k7IwohnjCKOIKMTegZ2lJXPpGCNPxHhC5FaYcIiZPk0pBl+Sn
	DMgGCym4/Bz8l9OvfZWxclyFd0W/3Q3nhQfI6oQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:i21L+5fDHs54dxT/yIyBQ6iGjxbS6C/UZdfyKfODtgA=:mZNPWqVUl9VqJs9GN2fpMLsoPeXPZnK27s3R+YyE/4U=;
X-ME-Sender: <xms:VP0Fayofu6sEOwV7UGL-saP1EV1uLMVnHtS3KiDZqUCk6rSxH137mQ>
    <xme:VP0Fa3jnkH7yd7OoJi-_6Vdd7CSHJhntdgIZhydQjwIiNbg_I4b20yF2ujLdwiZ4c
    FCNaheq9LCJRMngaQsHEJeDzjWPE5k9CkPctrrgguZU0x9FlonFRRo>
X-ME-Received: <xmr:VP0Fa_jwWimpKtAZgvYv5PUhc7EiclgNBYsPXqfSxAmGPwczpla77T7VTsE6dtReH8H27KmLSJUJgz_WGbbG64jY6VisoUInyAgnFjc>
X-ME-Proxy-Cause: dmFkZTGHiDPZgyVYt8dJUqbhIpCBPs1kUBVY9B49fAa3fdGLXP+s2/10bXUN34dNqD3WkU
    4vcDTw2TxC/S84u3iIwXx+wHJSuL/kYuxjQKe5LXhEuWwrfDM+w7ZIIjfhAHQYXa11I7Yx
    zlZ4Z9jr/mrm7Zl7wbaidZtsIUIs3qBbSzrBL2L9ej3G1HoWB9Zy/dYHXnBYw84tJBkQUd
    Lf0sViZ0ooiMF1oWL7dcHthHsBW0PRjPgIqoUWKMyjyb1c6rBHweGuLXDqimO4pwexBpKl
    R95neVv7At7n/ecN5DyaUdQyZDTrvBI2O2omZXPhKZ2ZDaW5sttVYifvPl0Akte7GeIJY8
    dohYDXY0ZT/U+gDhrNBlzV0OTa7Jk8KQFmkBLgkX0b0LcCPxfBaHnc3Y86QGvSbINyb/x8
    Dd/ij8OliBrS0e7SatfgDTYDBoYhYrk3bVvFpdUZn7pL148HiqgEIfZJMGFRCtL97/d1lN
    RKmGyq0PVzsPtWvTpva9T5o+rb+TmHT961ZbtRYBJ/lr0dMSehl+jzScSyqW37q+RPFbXj
    8rkeVzxfY5jYCA4IU5Qrcuxy0jVBrWEZHA/6kb2wsAgi+x5tTzHN0G5KpdUMG3zcC4sQCn
    Hp2ukvzs2F9Ayc3s5lSCAu0vT+q27omxV/5B20s8kIRzPH+J/e9Dq3904z9w
X-ME-Proxy: <xmx:VP0Fa9iTeAq0G_U9S1a8rXyyo8yrw-ilphIHL0D3lz4m86khbndQSQ>
    <xmx:VP0Fa_K_YJrGbddoN4GCgFv8u49N0BLRrR5gHXJo8h_WQPHtv2TfRg>
    <xmx:VP0Fa8F_uXp_RDE7CjdiCw1SWK4i2cj-T0duz-vm7nwN-_5tLUAh7w>
    <xmx:VP0FazQT6GOEKwe4u0IxdNbQeshbeGziHq6-lIpDbg7vs5cVreXITw>
    <xmx:VP0Faw9azA7yaWLIBulWTXxYUH9ktFaZvAYcGs5KrnE6lFcIdRC4doZa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 16:10:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>
Subject: Re: [PATCH] pretty: add %(body:trailers=<bool>)
In-Reply-To: <4e6e2c256ef7d13dfc31cf0235f6163cc1509fca.1795153464.git.andy.koppe@gmail.com>
	(Andy Koppe's message of "Fri, 20 Nov 2026 06:09:30 +0000")
References: <4e6e2c256ef7d13dfc31cf0235f6163cc1509fca.1795153464.git.andy.koppe@gmail.com>
Date: Tue, 24 Nov 2026 13:10:43 -0800
Message-ID: <xmqqse0qlyuk.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> Add a "%(body)" placeholder that is equivalent to "%b", with a boolean
> "trailers" option. With "trailers=no", the trailer block as found by
> "%(trailers)" is omitted.

Having a counterpart to %(trailers) that strips the trailer block
without needing external post-processing makes "%w" rewrapping and
separate coloring much cleaner.  Modeling the syntax after %(trailers)
and %(describe) also fits the existing placeholders well.

> The blank line separating the trailer block from the text before it is
> dropped too. Content after the trailer block that "%(trailers)" ignores,
> such as comment lines or an old-style "Conflicts:" section, is kept.
> When there are no trailers, "%(body:trailers=no)" is the same as "%b".
>
> The placeholder name matches the "%(contents:body)" field of
> git-for-each-ref, which also excludes the subject, and the option syntax
> follows the options of "%(trailers)" and "%(describe)".
>
> As an example, "%w(72)%(body:trailers=no)%w()%C(dim)%+(trailers)%Creset"
> reflows the message body but not the trailers, which are dimmed.
>
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
> Coloring the trailers separately as mentioned in the use cases would
> greatly benefit from the "pretty: fix lost and leaked colors at line
> breaks" patch [1], which in fact was motivated by it. I think the two
> patches are independently useful though, which is why I didn't make
> them a series.
>
> [1] https://lore.kernel.org/git/e9f88b533dfbd10528c9151e2e87207419d0253d.1794905511.git.andy.koppe@gmail.com
>
>  Documentation/pretty-formats.adoc |  3 ++
>  pretty.c                          | 58 +++++++++++++++++++++++++++++++
>  t/t4205-log-pretty-formats.sh     | 55 +++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
>
> diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
> index 2ae0eb11a9..39d66d9f73 100644
> --- a/Documentation/pretty-formats.adoc
> +++ b/Documentation/pretty-formats.adoc
> @@ -301,6 +301,9 @@ tags are added or removed at the same time.
>  +%f+:: sanitized subject line, suitable for a filename
>  +%b+:: body
>  +%B+:: raw body (unwrapped subject and body)
> +++%(body++`[:trailers[=<bool>]]`++)++:: body, like `%b`. With
> +	`trailers=no`, the trailer block (see `%(trailers)` below) and the
> +	blank line before it are omitted.
>  ifndef::git-rev-list[]
>  +%N+:: commit notes
>  endif::git-rev-list[]
> diff --git a/pretty.c b/pretty.c
> index d8a9f370f6..c67c9160c7 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -997,6 +997,36 @@ const char *format_subject(struct strbuf *sb, const char *msg,
>  	return msg;
>  }
>  
> +static void format_body_without_trailers(struct strbuf *sb, const char *msg,
> +					 const char *body)
> +{
> +	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +	struct trailer_block *trailer_block;
> +	const char *trailer_start, *trailer_end;
> +	LIST_HEAD(trailers);
> +
> +	opts.no_divider = 1;
> +	trailer_block = parse_trailers(&opts, msg, &trailers);
> +	trailer_start = msg + trailer_block_start(trailer_block);
> +	trailer_end = msg + trailer_block_end(trailer_block);
> +	trailer_block_release(trailer_block);
> +	free_trailers(&trailers);

Calling parse_trailers() with '.no_divider' set to 1 at the subject
offset mirrors format_commit_one()'s %(trailers) branch, so both agree
on where the trailer block starts and ends.  It does populate and
immediately free the trailer list, which looks a bit curious.  I guess
this is because trailer_block_get() is file-local to trailer.c, which is
not available to us here.  We could expose it as a helper function if we
wanted to, but the trade off there is unclear.  I'd say we can leave it
as-is at least for now.

> +	if (trailer_start == trailer_end) {
> +		strbuf_addstr(sb, body);
> +		return;
> +	}
> +
> +	if (trailer_start > body) {
> +		/* Include the preceding blank line in the chunk to cut. */
> +		while (--trailer_start > body && trailer_start[-1] != '\n')
> +			; /* back to the start of the line */
> +	}

Do we need an "else" clause here, IOW, can trailer_start be less than
body at this point?

The caller in format_commit_one() does

> +			format_body_without_trailers(sb, msg + c->subject_off,
> +						     msg + c->body_off);

where msg+c->subject_off is "msg" and msg+c->body_off is "body" for us.
IOW, "msg" is the first line of the first paragraph in the commit object
body (which is taken as "commit subject"), and "body" is the first line
of the second paragraph, with each paragraph separated by blank lines.

trailer.c:find_trailer_block_start() clearly says that the first
paragraph cannot be trailers and skips it, so we should be safe.  There
is no need for an "else" clause there.

> @@ -1251,6 +1281,14 @@ static int match_placeholder_bool_arg(const char *to_parse, const char *candidat
>  	return 1;
>  }
>  
> +static int parse_body_options(const char **p, int *trailers)
> +{
> +	while (**p != ')')
> +		if (!match_placeholder_bool_arg(*p, "trailers", p, trailers))
> +			return -1;
> +	return 0;
> +}

Use of match_placeholder_bool_arg() here is nice.  This handles bare
"trailers", "trailers=<bool>", repeated options (last wins), and
unclosed placeholders cleanly, since the function returns 0 at NUL.

> +test_expect_success '%(body:trailers=no) ignores Conflicts: section' '
> +	test_when_finished "git reset --hard HEAD^" &&

This is not quite right way to set up test_when_finished.  You are
assuming that at least up to your "git commit" things will not break and
you will successfully create one commit, hence HEAD^ is the right place
to go back to.  If you fail before managing to create the commit, then
the following tests will run in a repository with one commit before
where this test started.

Perhaps remember where you are and prepare to go back exactly to that
commit, i.e.,

	go_back_to=$(git rev-parse --verify HEAD) &&
	test_when_finished "git reset --hard $go_back_to) &&

would be safer?

> +	printf "subject\n\nConflicts:\n\tfile.c\n" |
> +	git commit --allow-empty --cleanup=verbatim -F - &&
> +	git log --no-walk --pretty="%(body:trailers=no)" >actual &&
> +	git log --no-walk --pretty="%b" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '%(body:trailers=no) keeps text after trailers' '
> +	test_when_finished "git reset --hard HEAD^" &&
> +	printf "subject\n\nbody\n\nA: b\n\nConflicts:\n\tfile.c\n" |
> +	git commit --allow-empty --cleanup=verbatim -F - &&
> +	git log --no-walk --pretty="%(body:trailers=no)" >actual &&
> +	printf "body\n\nConflicts:\n\tfile.c\n\n" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '%(body:trailers=no) is empty with only trailers' '
> +	test_when_finished "git reset --hard HEAD^" &&
> +	printf "subject\n\nA: b\n" |
> +	git commit --allow-empty --cleanup=verbatim -F - &&
> +	git log --no-walk --pretty="%(body:trailers=no)" >actual &&
> +	echo >expect &&
> +	test_cmp expect actual
> +'

It might also be nice to exercise "trailers=no,trailers=yes" and an
invalid boolean value such as "%(body:trailers=bogus)".

Overall this looks nicely done, except for these minor nits in the
tests.

Thanks.
