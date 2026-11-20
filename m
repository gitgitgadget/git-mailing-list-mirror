Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196178;
	b=3MyKczB9jsz1g7NUGxVReQ64pKrmx6L7V50ciLkiZi1mqy5tZU8UcXkEw7vXqDLXxNEi
	 464P7KBEoP9NDWWBpEoCl6I7qfqFNtL/+3RCSdVfPZnSSVDFWFFF451flWWb/pdhiPrwz
	 AZGET8+Ulg+/pmefHdmkvfQEiSMov66w4djxeDyUmdyhTxx0v+bK2TYjqCiX92fUYKSBq
	 8E0y1hQN0rJnrDaA01k8E6uOgBYOzi0RyP7MS5Zrl160MM9FDnbu/pyGzg1zsyTimydjc
	 HxSYtIX6vd4gRhrFng2LTbbX9LS+h/NOWuEOf2rjhX5uGRt0ly4s0x7qn4LHn99PX+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EtgMY0YtPW4NFv3gEt1UzqIUZI1kI3TNJ5xpD2eQBDI=;
	b=cUS/P8lNCOgBYEAlWM2l8mVwOaVzqhCPBfdqmi5SXZpZpP66si4kIx7dY2C3M2DOUU8B
	 VK2fpuFVsK+c132/vbuE/rqHiF7bizmGGVe5sFyg0rs3HaWRgxws8ATBoaK2t4ECyBTQ2
	 denRBgrV5jh3rl62EWkv/Hy5M/WSLPqJBjq4K4tV2JskMuwhG9iPY4KbFbzKQTIzf65Zr
	 uiOaIfmDzHTiAu3nGM78wXkRiaHJFE75bSUAtqvJV35xZ7wDMBp48fTXE65YafbONEEpI
	 jdQGQzfzgdpQFC1W/UBMkkldsAOP9oV766IBWnXjiXvWqQQ7mG2PtoZsQzwFoZq92yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=N9wNZGDX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3lfzKkq6;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420E60A2610
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2420E60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=N9wNZGDX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3lfzKkq6
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B1AC140026D
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:36:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 20 Nov 2026 12:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795196167; x=1795282567; bh=EtgMY0YtPW
	4NFv3gEt1UzqIUZI1kI3TNJ5xpD2eQBDI=; b=N9wNZGDXHqDi9VwUSCau+0xO6s
	PKW4X2LMptM/olJcylG7lv+YUUKylmvzJMgov/SAcZRbSmwYdP6m/BnbZFLEDzur
	fMR//6Osg4OPFAkZmphYGew5LqQtnzjFkFyqI9MZMvzmZMxBgY41e2/cSclICM2D
	ZnBL09dsdWiYls6VFSpraunyzWEbK/5Qvk+e7Y+YYsPp2/HlB5TebXDtw4D7LxHI
	DWs6o9iAExIWEoXOxd2S/HqV2UTa7UIxdZy7eJdfXrBLvqvE3w03/awGpOiwsRZA
	h7hDwns2cgPSpj1Iu61O4if7b/gi8NkFqDAaZ4/YcnIj+z2Yht6nD08uY2cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795196167; x=1795282567; bh=EtgMY0YtPW4NFv3gEt1UzqIUZI1kI3TNJ5x
	pD2eQBDI=; b=3lfzKkq6lez4OvDfn0aFGBPLrq1+9NfWnog2iCyVZ2M/b+FyAOv
	OVbtdPIWxDCqNrdRC++epYzH8CGebuQhlLKAkZTHF0j5htqvLzulJj7M2WtU9AJ4
	HGx0P98kiKB0kazzN145O3WtEikL5+NAcGT91BFHr1YLSgoDS2rMkRPdYBgbB1BA
	KDGoXHQsmZwfIBal7SW+8yeEQ1s8TkZpgOe4hBcXjQJZXU1jdUdg9gkq4lN8mP/g
	B3oYfG+rkMMe9eIr3RTumunXVnjp0GsZuFu3KTnEcAiWhxhhM7fZZiMpZIxICX3x
	5GTLGDWnHSnbDXsUuEjjp9l0rdevvpGicmw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795196167; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fbz5S0aq100qGVQ/s1Y4d2xTOlP6t2FKOkTP/kdkZxQuyeJ
	EzGGaq4zq9A1eqRu9rdGrwzihrvArACYFaHHmi0L4sBLQcahJlbFwfdOnqNs19VH
	Wu+LKavlbBXhm2TUqSBb33dwGgHOPx13HMia6zmTI+iohzK7XNcQafBiZOJdX4X8
	bxYm1bix3RIzIQSDtK1PcHyGkJgzHNhV0Dh7wwFC7V6KxIt2+25TKIB8EfXJic6c
	OYK7BREKKB/P7Fz7mJIPcCMwRTpH7mAa29cfzD5SYuOZAcUXjB9slJZQUf8gaV7n
	3c3M9rSvE5YJ4Np91gFrBybVYgMYNmPydgKQ2aw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0W01R/A8FJiYYe24dg6LnlniT0S9tU6vGXX1lvCt+3o=:9Ucgnm0hmKtzsL/0m4Y7lyThrUHqfLDMxBL83OEoPe0=;
X-ME-Sender: <xms:B4UAa7PL4r1fg1pjJnSJtLVELKuTntiOO71cE0z6UNC1pbBM1ngr5w>
    <xme:B4UAa9aEaVHDM59h8fQlJP_-k1zBxb0BC8OGcnCWAa-j0W7aVKIixQPyHhhBYK03l
    36hpD0dHTEjowMCr-RfT9MOtn6yIoEsHOGmuHOgaX3TpQK2pzfz>
X-ME-Received: <xmr:B4UAa3rbC7UoIuv0mxnX3avXLdzl4Lt9KPJ5t1iMEUlUyROyXHF9K3CMPFEorWtkQoj53hHzkhZBMqwYC7x9d-A4y91i6yFjxONr>
X-ME-Proxy-Cause: dmFkZTEndoov6wyiPffawvXVj/wkT3LpjqUqxvryLGtT0dzhUVheqs+xZQh6UPU+sTAi9z
    eKZ/pr4uWjAK6n46G5f3wMpKWEuX9hG+Ib1L3mkHUsSKRO9mPtVuI3FOw9AiyGQhNwY6aC
    m0eXRT8yNOx5nSuyssbEH935vM131ipLAd5dg6uTg1Ug/ohcixQQwJkikcYEdXQinulH/q
    Q3vGtwxgJNNeu6f59Am7n/XgI+8oEdCoZ2Lc76HV916v0HL6BOlQvvzIt8WK1X2BmzZ2pe
    BB7zm0yR9WNNF7o1Pa6kUdZtorWJck6OT3MVdYEkAxdKKNFfVZcuiP8lq8j7dF5UDCBAeX
    9Y8Z/YNn4BLk8NzjG0QuSO5rw9rOwUEZnVrWHmQK9MyEon/pyw6ASGnI/IIvjmkFNorfkO
    VRnkb91XAS+Hp6DlX0Tt5nfTMOAANm7nMc2LdHhxRLb76LV0nO5TNV2o//TtSXcNLklXvs
    cPxfA+dpKs/u2TCAli9mFBV06H0MQtewySMH4EXZITn8kCqoBZ1huGp+exJmMaeYP8uZe9
    oHTiXcVsMV9pS/YsTW+byKObtuwwPtYLZRpzy/4HinbzRPynLbajPev+4scQnIrOUIkeYY
    a/OLalkxgstnblHPnqH0VPSgqV81q+x+HO8LdDvVPtqgkmZmQZcAoUFLdYPw
X-ME-Proxy: <xmx:B4UAa5aSfsa-1z3-lZ4aP8hXsDMrJrkZwV7OogxFVZ4AwZo2QzcxVg>
    <xmx:B4UAa3SpQNzwrbmEW0avuVJJvQ6M-kqyiKTAmmYeWMLa8hJnFuNGPg>
    <xmx:B4UAa47fR7kWXX5L2CMXzzF4Zk6Fj5ZaETlTm7UZzmcckWP4u49mfA>
    <xmx:B4UAa0zNLh_0MJ93O2klsPB55R_WpnXKnj-I-1le5BnXlBYMFTLb7A>
    <xmx:B4UAa5ZWR_6UfZIHKhJNTISA7xWj0bYQh9UmSHBNaxcnk7BAud3xKX-M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 12:36:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "=?UTF-8?q?Andrei=20=C8=98ova?=" <andreisva2023@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/clone: fix --revision with SHA-256 commits
In-Reply-To: <87mrr486sg.fsf@gmail.com> (UTF's message of "Thu, 19 Nov 2026
	21:00:52 -0700")
References: <87mrr486sg.fsf@gmail.com>
Date: Fri, 20 Nov 2026 09:36:04 -0800
Message-ID: <xmqqv75rqubf.fsf@gitster.g>
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

"=?UTF-8?q?Andrei=20=C8=98ova?=" <andreisva2023@gmail.com> writes:

> The refspec item is created before the destination repository's hash algorithm
> is set up, so when cloning repositories using the SHA-256 object format
> parse_refspec incorrectly parses the hash.

A few improvements would make this much clearer for git log readers.

 * Clearly state what fails for the user when cloning with
   "--revision=<sha256-oid>" while defaulting to SHA-1.  Along the
   lines of

     "git clone" fails with such and such error message (when
     talking to a server over protocol v2, it dies with this other
     message with protocol v0/v1).

 * The issue triggers in the opposite direction too.  I.e., when the
   default hash algorithm differs from the remote repository's hash
   algorithm discovered during the handshake, so the title can use
   some polishing ("with SHA-256" -> "when cloning from repo with
   different hash", or somesuch).  parse_refspec() fails when the
   length does not exactly match (i.e., it won't be happy when it
   sees a SHA-1 object name even though it is shorter than the
   pre-handshake SHA-256 default, as it requires the exact length).

 * Explain why if (refs) had to change.  The log message does not
   mention the second hunk's guard change (if (refs || (option_rev
   && ...))), which is needed because ...?

Structure & line wrapping: Wrap lines to ~72 columns and end with an
imperative command to tell somebody to "make the code like so".

Having said all that, if the problem is "the refspec item is created
before we know what algorithm to use", wouldn't that suggest that
the right conclusion from the observation should be more like "so,
swap the sequence of initialization, keep the command line argument
as an array of strings, do the handshake with the other side first
and *then* finally create the refspec"?

Undoing what was done in an earlier step and recomputing may have
been possible without losing information in this particular case,
but that does not look like a good design, just sheer chance.

> diff --git a/t/t5621-clone-revision.sh b/t/t5621-clone-revision.sh
> index 54789423f8..1afac8abaa 100755
> --- a/t/t5621-clone-revision.sh
> +++ b/t/t5621-clone-revision.sh
> @@ -78,6 +78,21 @@ test_expect_success 'clone with --revision being a raw commit hash' '
>  	test_must_fail git -C dst config remote.origin.fetch
>  '
>  
> +test_expect_success 'clone with --revision being a raw SHA-256 commit hash' '
> +	test_when_finished "rm -rf src256 dst256" &&

Clean-up preparation.

> +	git init --object-format=sha256 src256 &&
> +	test_commit -C src256 --no-tag "initial commit" &&
> +	oid=$(git -C src256 rev-parse HEAD) &&

Test set-up.

> +	GIT_DEFAULT_HASH=sha1 git clone --no-local --revision=$oid src256 dst256 &&

The command to be tested.  You expect this not to fail.

After a group of commands that makes one logical test, it would help
readers to have a blank line here.  A truly tricky expectation may
even want a comment in addition to such a paragraph break, but I
think this one and the various expectations we see below may be
reasonably easy to guess without comments.

> +	echo $oid >expect &&
> +	git -C dst256 rev-parse HEAD >actual &&
> +	test_must_fail git -C dst256 symbolic-ref -q HEAD >/dev/null &&
> +	test_cmp expect actual &&

This is an additional follow-up test.  You want not just the clone
to succeed, but HEAD to record the specified object name.  Remove
the third command that makes sure the HEAD is detached, so that
setting up the expect and the actual files and their use come as a
three-tuple.  "The HEAD must be detached because we gave an exact
object name" is a seprate fact that you want to verify.

> +	git -C dst256 for-each-ref refs >actual &&
> +	test_must_be_empty actual &&

So is "there should be no branches copied from them".  For this test
to be truly effective, wouldn't you want to have a few unrelted refs
in the source repository (e.g., you can omit --no-tag when creating
an initial commit)?

> +	test_must_fail git -C dst256 config remote.origin.fetch
> +'
> +
>  test_expect_success 'clone with --revision and --bare' '
>  	test_when_finished "rm -rf dst" &&
>  	git clone --revision=refs/heads/main --bare . dst &&

Thanks.
