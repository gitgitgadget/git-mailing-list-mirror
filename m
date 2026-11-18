Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017087;
	b=Bj+DP21ka07cv+yzfz49WrcjIL1V5fi+rVqsd3T972SMMNo641rcHsjQkbjPT3p2tZBv
	 Im9kfN064b5DhjNFshUQwW4Hp82QYluHcV46u1WJGwuyZmXMw/694omj09dR6a0c3udvg
	 trr4y4ss4JB9txqwtkIAWebEkPCcRs+AX1kUOmq16w/N86FR5ryak9vT55xwJaHeaWgtv
	 NmoA3/aDFr7/m+I24NcEqY2vg3lTbEZIzRm+o0qXDUeYHZARcOBTy+jgtsOKaPcVDfKJe
	 YSuTT0OYYS9hKNdc9CGBLNjv2Bh4D5yGCXVOynsbOpOHSeqX5tHzTVPrU0kiYikemIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017087;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=CH2zHCC8Umu7VREUQ754Zl1ueY9KhCMsBXG7kRSIHOU=;
	b=OjBoaLtKlqsQMItwd3Dl7ZVjbiWUxgxdiwy9J4Z/1IEFlJbwNFztPVQKCDb8u90RpS1G
	 Z4IrOlptXljA00oUSIM/ExATAvmyI4W1joF694Ze/FPYHDHYSOhMZhK+LOOZVOuP25SdP
	 rpDlQ3Q/hjv/Arboy1ZQ6d91cl3DNzDqJmpLzm6VLNQsym7j9u1O7dinpW/lmXVEMhylF
	 0YnbNDo/Z3EPEjy47Bv2c9+kifB5jrvk4V+7YVmPK6Adpv3zGTXMKXyHtIcCFYO/EROGn
	 976YUhg2BnpWe0oZXY/ZWnaAZFZT7rDUf25ajntFL9pJJ4Xdr24+i0e3+HqGi2ypVFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=J6S4dRCy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TVoZANlC;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF10606A333
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AF10606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=J6S4dRCy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TVoZANlC
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8BF59EC0B68
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 10:51:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 10:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795017085; x=1795103485; bh=CH2zHCC8Um
	u7VREUQ754Zl1ueY9KhCMsBXG7kRSIHOU=; b=J6S4dRCy3CeK0f4rpPmL3fXAB6
	dureE3zI4bQglmGUoQyV8ke+Y/V9H+i/J3tbq1hNUeqH2s14Q0+yoIYCnLwAVXO4
	LUahrIICNjsSQAoAmTfZYtbk7QVicSx7StM61eM2CXYtkIvqLplexO5ubVvbXCTV
	5e+VdHPAZ4WEMlIliskekAkAUpRVh0obevscoL85c5SI9Bkmp5q9bsoinfz3EWkA
	TpkhyNIM0A31E6lL+/khyWa+Oc0l3RcIP5r907liE4bScA+rcTvpNEwGsSokrqOI
	3lvaF3CB3RuIjwS6Z4y36FF/3jGbdBR2mzVUmSC+jEb8EdVblV0qRGZ68nvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795017085; x=1795103485; bh=CH2zHCC8Umu7VREUQ754Zl1ueY9KhCMsBXG
	7kRSIHOU=; b=TVoZANlC+AQfBm0R8nRJt/JyTcp6fpWdLbg2R4RH0E+J4jcudJy
	MFHedn73kj1IN97XpMAvcSkpPT2mLKEsMJwRVLYuKSIB1JEQciD0oXp8qPpxHKdH
	HytlcSYXE0CDVB8Rublv7lExWKCJ+VBHVy0f4vP0542oyuyWL5uONRQ9zHv5wObC
	KCJF2YAmTwwiJpIoRKSZQhMVduLY745DPSBGlWjKbA8JNHiwAdk6bGJwiyWkP121
	tPSbksAUOfQxKTChDjd9N9E+FfD0tLmturMBqnWIVxhRZnNoPoqlwKYvJxWAIR8p
	7vc9+gxPPLdYtdBBDg5NC/OKq0Q6pdtqeTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795017085; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZuUq0uvNwAj7UcRTf5wGtdR7ZGC4Sanz+nj+JjS10LGRYdq
	P/HFSw7zhcBBtKOMpZM8//OUgoU9kloUtyOixX45ev+jCv1GdYe6EI+K96c9sf9x
	YluMzq0QBoVV4DnPaSpbXCyp0rejqnA9OE3ixtfZ7z/xCYFpae99sHucgqAq0D6t
	HL64FYUI9khahSwdeswJy9zYWTyBTziC9UQ9XTf5gOTWyhRKrhFCsS3+0VWCKcXo
	BNqS6Bj7EWec1ujKDuPMjy7nEhx6e+moQuXA9nKV27ri7nDWqU1XUAFwE9i4ui0w
	0l1EORZNZG8R+JJkhEHmSDM8EOi3a/cDfA8G8Kg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rq1QRg5YtbgDK1DHXyxq9O7vUGELzQT+aGmoK61z9uE=:uVG6Zn+hmSaM5kanyJTbtnHY4n0jHUIb6Ao4DHCrWY8=;
X-ME-Sender: <xms:fcn9ao-ISC5X9vajAdUzGDVnibRy81o6Cg99Wq6kiK7ke8lh9mppWw>
    <xme:fcn9anmFk-DFqQQ_ElqmBpd54-H6dX40VaBRtp--xZy3VnYxB5VFQ8-BR7nBpljmi
    eQ4SEZyT6mRPCmomqO-hxnB7Hkqmb5VUeFSXfMAT9pnKcGc5XAkUw>
X-ME-Received: <xmr:fcn9amUdWcUcDBsMwH-RTD6EAPYw2vPUVIrrgC5TWI82E9yg6qZTEkpIGlbEJofLy3Z6HR8ZYWStiZvwG-LRiZauWZr01P-mM_Ls>
X-ME-Proxy-Cause: dmFkZTF2YALvUwRk+WrfRO3yq0b+9+ZR3Qd4nATSB3PZ608GOJBIXGBT//ZH7NtFePsG1j
    1LFkl8R/Z9Vj+Q88pOcdw3M+o1L2KxrTYM5QQLEMR3KsLN7+env6J2OS77pqhuW6aVp6W4
    kn0ss6KZvu4pJ525qx2cPt7m/bDUCp+HpGUkgbnQIz1rhwpK3jEEXa62rjrtKc0/sArWk0
    zppEnehn0JJWiHWRgP6L7DqUcF9jfxY8+lanr3KroHAGDwTbq/zpyswDhU/HApNI7xQvKW
    jbW1E7VpuA0gzc8X6FUHyX79mvNX3CDqPuS/xQnqeTBKgTzd93EyZe70b7e+OY6sg5Nmsn
    PYeHZQ7xzSYdcERQicA8z5bz6WL90ccVuJNjaKrrpF+ccBdmdoiytvfJs8/LNi/NobBNGS
    5fPNf5NruticQbeWADAggJrwPm3XrlBJozS+dvMDA91yvIUIATYCDHN8Qs15Nk0YI6mNeu
    AaPMfCvVjwEXPfhAMXPPTNSvZsOFnc5MnwrsxTUUEwvYOFGxtVUpIY/HjsD710i7pLAB8F
    3vlYKUEycQbdCyWM+DPOR7dumr3jo1ayZ+/FyZFdbyJpYdcP7lGSbZsgWjxpMUykYnO6xs
    2aozgVsjGqglMKWXSqqT2mT9/fTv77IxrmifxJPPlr8QxTaR72Ioxtw8qZ+A
X-ME-Proxy: <xmx:fcn9akFsF0yLtKO93aHImhgdYtTPIhY8ySZriyZnDQ5iBYg1MJ2Jpg>
    <xmx:fcn9aqc6PdBYtyPuX5Xbi9m8V9FqkOofvUy0lqMVLHbEJjZiU5Xw0w>
    <xmx:fcn9atJctJRZ4XS6KPTwfsJSv95Jaquypgxnnu9bFOx5FpBaWUOZ6g>
    <xmx:fcn9anF5AWDsVfx5PlUY7upchwRtZdCgJTDcNF8995zFE1oq8AGtHw>
    <xmx:fcn9arVJPk-NqkANnJOeb84HFdD_KJQAXYFVK3RISTyaCngnq-3-Kg8D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:51:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  haraldnordgren@gmail.com,  =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v2] status: reword message for a missing upstream branch
In-Reply-To: <20261021072137.258934-1-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Wed, 21 Oct 2026 09:21:37 +0200")
References: <20261019175722.5223-1-gitter.spiros@gmail.com>
	<20261021072137.258934-1-gitter.spiros@gmail.com>
Date: Wed, 18 Nov 2026 07:51:23 -0800
Message-ID: <xmqq5wxu87es.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> Clone an empty repository, make a commit and run "git status":
>
>     $ git init --bare empty.git
>     $ git clone empty.git work && cd work
>     $ git commit --allow-empty -m initial
>     $ git status
>     On branch master
>     Your branch is based on 'origin/master', but the upstream is gone.
>       (use "git branch --unset-upstream" to fixup)
> ...
>
>     Your branch is set up to track 'origin/master', which does not exist.
>       (use "git push" to create it)
>       (use "git branch --unset-upstream" to stop tracking it)
>
> Only suggest "git push" when it would actually create the upstream,
> that is when the push destination of the branch (what "@{push}"
> resolves to) is the upstream itself. This is not the case, for
> example, with push.default set to "nothing", or when pushing to a
> different remote (branch.<name>.pushRemote or remote.pushDefault).
> It is also not the case with push.default set to "matching": it
> only pushes branches that already exist on the remote, so it would
> not create the missing upstream. In all these cases only suggest
> "git branch --unset-upstream".

The earlier discussion has been entirely paged out of my brain, so I
might repeat the same question that you have already answered, or I
may say contradicting things, but please bear with me.

> diff --git a/remote.c b/remote.c
> index 49ee2ea318..5f703b40a9 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2449,6 +2449,39 @@ static void format_branch_comparison(struct strbuf *sb,
> ...
> +static bool push_creates(struct branch *branch, const char *push_ref,
> +			 const char *upstream)
> +{
> +	struct remote *remote;
> +
> +	if (!push_ref || strcmp(push_ref, upstream))
> +		return false;
> +	remote = pushremote_get(pushremote_for_branch(branch, NULL));
> +	if (remote && (remote->push.nr || remote->mirror))
> +		return true;

Using --mirror means the local branch we are interested in (e.g.,
'master' in your example) would be sent to their 'master'.  Do we
need to check if their 'master' is what our 'master' is based on,
though?  Can our 'master' be tracking their 'main', for example?

We are content if there exists one or more "push" refspecs for the
remote, regardless of what the value is, but is that really
sufficient?  What if our push refspec is deliberately narrow to
publish only selected branches, such as:

           [remote "origin"]
		push = next
		push = seen

and the current branch in question is not among them?

> +	return repo_config_values(the_repository)->push_default !=
> +	       PUSH_DEFAULT_MATCHING;

You mentioned "nothing" in the log message; shouldn't that also be
special cased?

> +}
> +
> +static void format_missing_upstream(struct strbuf *sb, const char *name,
> +				    bool suggest_push)
> +{
> +	strbuf_addf(sb, _("Your branch is set up to track '%s', "
> +			  "which does not exist.\n"), name);
> +	if (!advice_enabled(ADVICE_STATUS_HINTS))
> +		return;
> +	if (suggest_push)
> +		strbuf_addstr(sb, _("  (use \"git push\" to create it)\n"));
> +	strbuf_addstr(sb, _("  (use \"git branch --unset-upstream\" "
> +			    "to stop tracking it)\n"));
> +}

We see value of suggest_push is only used when the advice is enabled.

> @@ -2510,12 +2543,12 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  
>  		if (cmp < 0) {
>  			if (is_upstream) {
> -				strbuf_addf(sb,
> -					_("Your branch is based on '%s', but the upstream is gone.\n"),
> -					short_ref);
> -				if (advice_enabled(ADVICE_STATUS_HINTS))
> -					strbuf_addstr(sb,
> -						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
> +				bool suggest_push = push_creates(branch,
> +								 push_ref,
> +								 full_ref);

But we call push_creates() to compute suggest_push whether we have
advice enabled or declined.  I wonder if it makes the logic flow
cleaner to give a few more arguments to format_missing_upstream()
and move push_creates() call there, not here?

> +				format_missing_upstream(sb, short_ref,
> +							suggest_push);
>  				reported = 1;
>  			}
>  			free(full_ref);
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index e95d420972..7804c84aaf 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -96,7 +96,7 @@ test_expect_success 'checkout (upstream is gone)' '
>  		cd test &&
>  		git checkout b5
>  	) >actual &&
> -	test_grep "is based on .*, but the upstream is gone." actual
> +	test_grep "set up to track .*, which does not exist." actual
>  '
>  
>  test_expect_success 'checkout (up-to-date with upstream)' '
> @@ -123,7 +123,138 @@ test_expect_success 'status (upstream is gone)' '
>  		# reports nothing to commit
>  		test_must_fail git commit --dry-run
>  	) >actual &&
> -	test_grep "is based on .*, but the upstream is gone." actual
> +	test_grep "set up to track .*, which does not exist." actual
> +'
> +
> +test_expect_success 'setup clone of an empty repository' '
> +	git init --bare empty.git &&
> +	git clone empty.git empty-clone &&
> +	git -C empty-clone commit --allow-empty -m initial
> +'
> +
> +test_expect_success 'status (upstream not yet pushed after empty clone)' '
> +	cat >expect <<-EOF &&
> +	On branch main
> +	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
> +	  (use "git push" to create it)
> +	  (use "git branch --unset-upstream" to stop tracking it)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	git -C empty-clone status >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'checkout (upstream not yet pushed after empty clone)' '
> +	test_when_finished "git -C empty-clone branch -D tmp" &&
> +	cat >expect <<-EOF &&
> +	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
> +	  (use "git push" to create it)
> +	  (use "git branch --unset-upstream" to stop tracking it)
> +	EOF
> +	git -C empty-clone checkout -b tmp &&
> +	git -C empty-clone checkout main >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status -s -b (upstream not yet pushed after empty clone)' '
> +	echo "## main...origin/main [gone]" >expect &&
> +	git -C empty-clone status -s -b >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup expected output without "git push" advice' '
> +	cat >expect-no-push <<-EOF
> +	On branch main
> +	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
> +	  (use "git branch --unset-upstream" to stop tracking it)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +'
> +
> +test_expect_success 'status (missing upstream, push.default=nothing)' '
> +	git -C empty-clone -c push.default=nothing status >actual &&
> +	test_cmp expect-no-push actual
> +'
> +
> +# "matching" only updates branches that already exist on the remote
> +test_expect_success 'status (missing upstream, push.default=matching)' '
> +	git -C empty-clone -c push.default=matching status >actual &&
> +	test_cmp expect-no-push actual
> +'
> +
> +# but push.default is not used with a push refspec or a mirror
> +test_expect_success 'status (missing upstream, matching with push refspec)' '
> +	git -C empty-clone -c push.default=matching \
> +		-c remote.origin.push=refs/heads/main:refs/heads/main \
> +		status >actual &&
> +	test_grep "use \"git push\" to create it" actual
> +'
> +
> +test_expect_success 'status (missing upstream, matching with mirror remote)' '
> +	git -C empty-clone -c push.default=matching \
> +		-c remote.origin.mirror=true \
> +		status >actual &&
> +	test_grep "use \"git push\" to create it" actual
> +'
> +
> +test_expect_success 'status (missing upstream, pushRemote is another remote)' '
> +	git init --bare fork.git &&
> +	git -C empty-clone remote add fork ../fork.git &&
> +	git -C empty-clone -c branch.main.pushRemote=fork status >actual &&
> +	test_cmp expect-no-push actual
> +'
> +
> +test_expect_success 'status (missing upstream, advice.statusHints=false)' '
> +	cat >expect <<-EOF &&
> +	On branch main
> +	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	git -C empty-clone -c advice.statusHints=false status >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup upstream deleted on the remote and pruned' '
> +	git init --bare pruned.git &&
> +	git clone pruned.git pruned-clone &&
> +	(
> +		cd pruned-clone &&
> +		git commit --allow-empty -m initial &&
> +		git push origin main &&
> +		git checkout -b topic &&
> +		git push -u origin topic
> +	) &&
> +	git -C pruned.git branch -D topic &&
> +	git -C pruned-clone fetch --prune
> +'
> +
> +test_expect_success 'status (upstream deleted on the remote and pruned)' '
> +	cat >expect <<-EOF &&
> +	On branch topic
> +	Your branch is set up to track ${SQ}origin/topic${SQ}, which does not exist.
> +	  (use "git push" to create it)
> +	  (use "git branch --unset-upstream" to stop tracking it)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	git -C pruned-clone status >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'short formats still show "gone" for a deleted upstream' '
> +	echo "## topic...origin/topic [gone]" >expect &&
> +	git -C pruned-clone status -s -b >actual &&
> +	test_cmp expect actual &&
> +	git -C pruned-clone branch -vv >actual &&
> +	test_grep "^\* topic .* \[origin/topic: gone\] initial$" actual &&
> +	echo "topic [gone]" >expect &&
> +	git -C pruned-clone for-each-ref \
> +		--format="%(refname:short) %(upstream:track)" \
> +		refs/heads/topic >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'status (up-to-date with upstream)' '
