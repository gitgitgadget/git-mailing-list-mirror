Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795758828;
	b=rAhGYMBOy5cjIDccwA8HmVXTE2cvaG5LJWKSDRqjYxiDZG6Dh/BiTq9FPa1aIN0jDqUS
	 BZP11FgjGL58eNwUhLEkfvbB0L3weHeNLSLEXPnGaxtgJ1Z4PnHDqIK9FDHGn2+JSsnpm
	 783StohjEwSMMT/OH1pFS0YDrwLSNn29nkH9RNwi1oEpEQipeLEC+iUtt5egnlv8dOIM3
	 9FsYNPepnaFv34ptWnToku47SNQgYBqHuais52UK3hCY4LT5C24QvYgUugmm1TWrJOU1J
	 g9xFLjpZtSo+ets/RiPFTmM6fUPJGHZoH7TbCa0TxzPF1nPj/tpuyUyC0R/v2VXq+Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758828;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=AAYYHy7nJ4onHa0uH8QJbeyuzFvQtFkC+mAYklrm/oA=;
	b=YbqHz8dMMZCEiIv+ZJdNIDCV5T8bf740z7uGkBAXdkFgAph/7uq8Idf3hUjbgoHmNP5b
	 P1EwNxLw++EUdDK2sAW3PHbnos/V7FhrrUakeDC+AQPbq+HIsClD9Pu5g1fzw+Zd0yPgu
	 zGtIDoxNzt5ckELsdBGxMeTw0Kd8WQ9mreggzcz5gHu2cVtO7quuASPMckKwCFAn40UKI
	 qUNk0pla9CrUpHgWlzJ5hpRFicpF4mdyIu08ZKyxNnIdN5jZckGK8oS7NGqcysOWArgUT
	 MS5ryWaU2F1x44Yr41SuG4L3tJJy+pdU9CTMhfbxfZQ8K+j8yl+2HTTKJ9BO3LZSa9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="nl6Hxl/t";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=40gXm3Fz;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5B606A31E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE5B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nl6Hxl/t;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=40gXm3Fz
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F4F8EC08AE
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 00:53:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 27 Nov 2026 00:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795758826; x=1795845226; bh=AAYYHy7nJ4
	onHa0uH8QJbeyuzFvQtFkC+mAYklrm/oA=; b=nl6Hxl/tR80poM8LLNqB5yjMJt
	3U/cQ4VUPHZWLgG5I6roEipxwg3P+LoTv2LfGQ0HjaTSAuxp9FwYGjndcm2jRy6y
	dBr4mVKe7j141gvRqSmiyizMmdvf2/OYqoHhOCSR1pqdu6lhHr5+BN4CSJ9NZIyK
	mJff+yxMs/82u80+HuGrA+qPv9sMyCfewBhyFC/MFBn6yDFx0jiJLwfsnQQcQwVz
	xo2My5/wmKB+4jTyRGhKZtbuhs3y7OzUy7E2r0ZUj3fX/EKZJDdIhhbj2LkeJXym
	kNE/6YMN/Wn+h+FF44lVfmTM/G1KsGInHO5fPsftpOkyYZD/laJng1IcUcAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795758826; x=1795845226; bh=AAYYHy7nJ4onHa0uH8QJbeyuzFvQtFkC+mA
	Yklrm/oA=; b=40gXm3FzlLv1s4Tqcu4qmHqFgsx2wgEd0sXTZ2ZJcAHAi521Etb
	AIFXahcrPLTPFwQ1eS9QWCFqfAFOwYjB6t6URmIO3AYi7Jk9lVIrAKIrqUjGe9JM
	7lUyDOQpKc0HzqWm7U2ojxp64oJcVP9NX2bsyUG5lY8DwTGWA1vzkO8JpgyLQM99
	1rbOAxh6kCJ4YiVJIyy0V+6lcK+GHUZ7JVGHE45i5uPkPX+7y/Uav/sTpCwQQZSe
	5rPudlnM7uyFNvaPa394G4lu8jp5Fmff7k8Nks1KF+KAfWcrQnT2AUNH5VDmwR0C
	xw/aQ0h4EyeIG3JVphVEfjC78qVhR9EzyJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795758826; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nthdt9gKoGof5sEBL6JMHUN957vajuvnsyet1XA0ByRQHB8
	qK6MyOJE5N77JlVvtaAcvqUrC5pHlZ7icXGSwsRs57/fo3g0yXVtC+Yj51l7fCFz
	Z7k6qW7nceKyYZ0AefxVnibjncwlW++xLGX3Pg3bHaa+BttbQWVwloTyDEys2NnJ
	Mptdbi5Uv5dCmeVTHLPMMcrytxHs5I0W4ivCI02sBSbxIEHkfxRxFk4wYVjSAM5p
	2elMEV+bgtjlQjokVTaCoaXw3+h7EHTbBRk+akygRnfezRmdirxyGzZvifBkuSh+
	hg6a4NRq9RHbFdW9VpKXGnBp8Pk341+EMN+1e1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WzhPE1e1S1XCvt8+RiY00MVejrAYZOwP+6O0i2yobRQ=:r1QOYZ0YyDhXPe1e8nccEUoQ+uc+Bzh7cHiflJxWOsE=;
X-ME-Sender: <xms:6hoJa71TguLlojPQYjCSRGjDUisbhrbVXev5mE4aGbhVa1E-f_zHdA>
    <xme:6hoJaxE2JATLc0xdUamiE9Zsr-W421O4kZw7CzQ28ZNzl5jbiQXH-LvWVtVNUSjkV
    JVofN7VihlVTW6ojv2zeRdD8XT3a3Gl5MpscxZSA9Lzk_7N-4O1_z4>
X-ME-Received: <xmr:6hoJaw5ZlE_bCa_Lj0RIdJpK41AgXLlwuO1En0b4_NDK9dDrMfmDJ70qF6YOBwAD71uSRmbElwrsBHQdCl-Nm_HD_LlY1ZWncinQl4M>
X-ME-Proxy-Cause: dmFkZTFYkalCSy+n8GGERunDy3VcQijcq0LUknWAeMH+AV+NkUXDVo5e6v5m6T//sU4TS5
    zjTliR+wGhu5PIeEzWyqpqeriGVYQPumSQDjCxJVfy9+VUOZn/xLAiRXVQFGxBhqc7TCU/
    zC9b5+hF47BHoFOafcXAdwZn2JGXntUVMsgxacJVVozGySXHyX/lbVCWdkDNN7c0P23qPg
    M3Vg9iX2whr254HfRAM5VxyFBrnxUGofe/RuvlsKTAV2dNyMD4VWUISDv1gsy+i/Dnstrv
    buiGTVt85KUawCBfZxEdRvDE/pHyUgabS/t5lISfxesz6AKNLh0YZ4DQgToOyens610DcK
    ioeesGdtHNPPAk2nSvgx2ObmwiIDsS8yKGAGmIQuBMtSWHN5Sspb49uOiPUnRSlU1LBwvQ
    nfPdZ6vXRcnJUYeW3hIu+3rYnsSuavhhbIpsMhJldvSiiobbIRaShvwqqRBkxudAf8THsl
    tmRJSAHWR9rxG3Efllcmyad/lxhO0tFwbjrhXHCrm6SVIqlzErpIIllWYmvlobmQqY1Y6B
    lCEr6dg8ZDOWJwPlcSC8xctlIcPqCAKqnFc/qFmURAWxPNUrebPt1Bo8UPE1PWDSZO8Z43
    w86dR80Wc1rRYKqCwsMWJDyu12nV3ggjqhjzZC6QNRCRdlGKVuzp4HAIpAQQ
X-ME-Proxy: <xmx:6hoJa_uMNEBmxvd5KKkV3LM67Yl3MbY6TM3yC8sq8Jw9akGnNBL2XQ>
    <xmx:6hoJa56-rtsHznbibf7hpIYtO8pMk5_2k8tLciIRx4Sgrrm80Wu4eA>
    <xmx:6hoJayVr55QL_Kj6sBvL_KEBUMP9fWghfhNVFnK7d6nvGCUzUs1l0g>
    <xmx:6hoJaz_w0rSozkr6RbW8Q7GHHBYZNLysSOm53xgYBFzP0dN295c_qA>
    <xmx:6hoJa8Yc7u8pS2LlkXPO91x9ziDZcn6xvFPYbEHtHF-CHU1jqWNJnZin>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 00:53:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Nahid Hasan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Nahid Hasan <nahidhasan141400@gmail.com>
Subject: Re: [PATCH v2] push: shell-quote names in suggested push commands
In-Reply-To: <pull.2336.v2.git.1795747717319.gitgitgadget@gmail.com> (Nahid
	Hasan via GitGitGadget's message of "Fri, 27 Nov 2026 02:48:37 +0000")
References: <pull.2336.git.1795686173178.gitgitgadget@gmail.com>
	<pull.2336.v2.git.1795747717319.gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 21:53:44 -0800
Message-ID: <xmqq7bhyes5z.fsf@gitster.g>
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

"Nahid Hasan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Format the remote, branch, and ref names in the suggested `git push`
> commands in `builtin/push.c` with `sq_quote_buf_pretty()` so names
> that need quoting are wrapped in single quotes while plain names stay
> bare. A HEAD:<dst> refspec is quoted as one shell word, and the
> detached-HEAD hint in setup_default_push_refspecs() quotes the remote
> name as well.

This iteration cleanly addresses the points raised on v1.  A tiny
formatting nit in the proposed log message is the mix of backticked
tokens like `sq_quote_buf_pretty()` alongside bare ones like HEAD:<dst>
and setup_default_push_refspecs().  We prefer a basic single quotes, as
nobody passes the commit log messages through AsciiDoc or Markdown
processor.  These are plain text.

>  builtin/push.c           | 48 +++++++++++++++----
>  t/t5523-push-upstream.sh |  8 ++++
>  t/t5528-push-default.sh  | 17 +++++++
>  t/t5529-push-errors.sh   | 99 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 164 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 2377b5af55..3908f5f532 100644
> ...
> @@ -173,18 +177,26 @@ static NORETURN void die_push_simple(struct branch *branch,
>  				 "won't match the local branch, see option "
>  				 "'simple' of branch.autoSetupMerge\n"
>  				 "in 'git help config'.\n");
> +
> +	/*
> +	 * Quote for copy-paste into a POSIX shell. Ordinary names stay
> +	 * bare; metacharacters are wrapped in single quotes.
> +	 */
> +	strbuf_addf(&refspec, "HEAD:%s", short_upstream);
> +	sq_quote_buf_pretty(&quoted_remote, remote->name);
> +	sq_quote_buf_pretty(&quoted_refspec, refspec.buf);
>  	die(_("The upstream branch of your current branch does not match\n"
>  	      "the name of your current branch.  To push to the upstream branch\n"
>  	      "on the remote, use\n"
>  	      "\n"
> -	      "    git push %s HEAD:%s\n"
> +	      "    git push %s %s\n"

Before this change, die_push_simple() interpolated short_upstream
directly into "HEAD:%s", so metacharacters in either the remote name or
the upstream branch name broke copy-pasted commands.  Quoting the whole
"HEAD:%s" string with sq_quote_buf_pretty() keeps plain refspecs like
HEAD:other-name bare (since ':' is in ok_punct[] inside quote.c) while
turning metacharacter cases into a single shell word such as
'HEAD:upstream&name'.

> @@ -249,8 +270,12 @@ static void setup_default_push_refspecs(int *flags, struct remote *remote)
>  	}
>  
>  	branch = branch_get(NULL);
> -	if (!branch)
> -		die(_(message_detached_head_die), remote->name);
> +	if (!branch) {
> +		struct strbuf quoted_remote = STRBUF_INIT;
> +
> +		sq_quote_buf_pretty(&quoted_remote, remote->name);
> +		die(_(message_detached_head_die), quoted_remote.buf);
> +	}

Covering the detached HEAD advice alongside get_upstream_ref() and
die_if_repo_looks_like_ref() catches all four places in builtin/push.c
where a suggested "git push" command formats a remote, branch, or ref
name.

> +test_expect_success 'no-upstream advice quotes a branch name with metacharacters' '
> +	test_when_finished "git branch -D \"branch&name\"" &&
> +	test_when_finished "git checkout main" &&
> +	git checkout -b "branch&name" &&
> +	test_must_fail git push upstream 2>stderr &&
> +	test_grep "git push --set-upstream upstream ${SQ}branch&name${SQ}" stderr
> +'

test_when_finished handlers stack and are run in LIFO order, so we try
going back to 'main' first and then remove the funnily named branch,
which makes sense.

The new tests in t5523, t5528, and t5529 exercise both ordinary and
metacharacter names across all four paths and check POSIX word
splitting with shell_split().

Looking good.
