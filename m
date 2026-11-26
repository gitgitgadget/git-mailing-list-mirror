Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719864;
	b=NHLJFryVdxnkDJVGXmUuoszpIONR5WYQafMhXXpNA0rJt7tNFPLUzqCnxCG8tBg37seM
	 nWvP9VM5y09NzQ7lZYJ9wUEpuD6b38Yve/opCmYkITmZ3jRKR1rxvCFgWl3HdpMO8Q9kB
	 6prBg202bUJkgSMoRzG4lbDvZsL8zDMcWvLLUsWkh841Bi9IA+lcGtLoh+BXWM2iZQG35
	 blpXO8Nwon+Tyu0H46bRIU11A/2VuPP3/2QI7Fu1f9HZkCzRkOIDs7qCDh4sKySPE8lF7
	 EUzsGfbtvV8Iz6mNLJMlKWKSa4Oob7Ha2P9OM+8sYJlzVHw3ENdIq73dbtBZkzj0eMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719864;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wCv6GvHFTJz3QNydNNx8oD5HtWEYfN8XxNn47lWduiE=;
	b=EzOtndNcWFXzCcuACwkO2+STEJaY4DS2csP/qd3KGsVP/TCHb7G2f2K6BlrU6fZzZceK
	 hg8UfeZ3R3c6D/v1EelrMqVgggE+POkL1Z9+1tNrCgCWhlU+7i3DtbbECwknjqNdOm/HX
	 IfiDquTG1RwsY0HJfM7vZ+Ejgfw3BA19TnvSAbtxPLZ1Z+QVpUOYGcix+Jglhw+23FNNL
	 LNobv5CL9sRFAbfWcvroQRaN3l4W7U2xQ15aLKZXp+ZjosaTersTd1H5i/y3T3iygcR8Z
	 MIokbAJDuWejTEKHtwnbzyJD9xsSwWKhjmgb67Ywk+uu/lapnM4HSN2Nsw/juv5TC5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=S4CpfRi4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="pqLYdS/K";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAD606A326
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 19:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6FAD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=S4CpfRi4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pqLYdS/K
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 094447A02F4
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:04:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Nov 2026 14:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795719862; x=1795806262; bh=wCv6GvHFTJ
	z3QNydNNx8oD5HtWEYfN8XxNn47lWduiE=; b=S4CpfRi4f9o9kbdciGywy+YzaC
	cIpY93PQXnENxKqieKaqRqaIJIzdsZHC8kn9bm4aoxzQXoIqVTV2pVBh1lum+ZQ/
	BOQLAGcF4hv5wW3Ldmln7REWwUcRyJNmNVefZ/DxUh4SajZO7FBPwXf7kbVa7sna
	3K6KyT0UhywafqtsOJZEv+mLqWxcQG6sbZWMTyvwx4nZ0L3St+IOWGEeGUusg8Sy
	D3sMxohusNkNEr5EX0xlALlBG++A5+hcmvqzr0LY3jPvn4oQaP5UMqZgco212cmn
	0fbapja94V/BQavVwuduAhwz/j87Z0tM1J6Z/Dt0ddD29FwHsO42pMuXL7HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795719862; x=1795806262; bh=wCv6GvHFTJz3QNydNNx8oD5HtWEYfN8XxNn
	47lWduiE=; b=pqLYdS/KRidKIXGH+YhI4NsG+/g8VKryc/CWkXZljMBpsiKcWV3
	H3L4ZeIS96eqwMPkdchiqsnkpj2G9OC7hg+pZ5+mS//kp2V6aoDjraATkq/P6mNE
	kp2P/aJFGmQLgXOZRMUZxJVdTdr0G8wut+X0y4ZfSxQsEgXmx7pkj3B96RrK2UlR
	1uYT8xwJVT3alYJjCF+adlQ9GucdJcs/dUA2HBa+AcKW9o/6bYe13RDmT+P/CBz+
	1M+F8cEEOlKBet/HlKvQWTt8ow83y4KG+J8xUs2xePiL1b58Ffi5kz1oe31qvZVz
	WqemLo6GUHWsaEgMTFqFreJFmmovK1EcH2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795719862; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hRGDVBRgi1Vy2p+0RwXtIdkYv4GLOq2RKf2t/Ec0fu9ZBO2
	S59kglAz2QSH/86eP0Qd3H75+PRJvxOQF19mFcOVMnA+k9+EbbaWMIYvcDV89Xw3
	MdksqaqIXcjg0CjSekDiiFe0WEu2FHUHgyFKFUsBZygjDsF4L/yESCNz7Ynfllny
	KsAoMfu2S2BI6wKV4L63kyLHRquMJ+/h09mzkCk/4rFzgdJccsY0+OSOCsNJz3/W
	TTf5Rro5FdoVhUUTd3ni9XznhA2N9PD7srfZuamRl6QLIQ5ek2EC7gaEmjbNpgLM
	IXrm1HhOYbowCRYNmLa+3AG4k92qvaMEr6ysXwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:yh0PI08enY84JWed5DdfG6phaApan+B8Ol+Jeh9LB1s=:NeIlYAAbjeAU//LW2oeMondYTjboK8Bvws4R3MISBkA=;
X-ME-Sender: <xms:toIIa6gwFW_WSRqmYt4fWyNGSyu0Liz-PNE16UvGiYDpgNm2VAGVvQ>
    <xme:toIIayBoy0M90wBpvCD51FTwmA47MuNKbKbe6VynbrdTgYloYXdS3NKt6tUwH5wSm
    fkuvUFwtuefmTIUCt4wqy00-NmFBApOQIneXx6_H5GX6ICswR_0bNs>
X-ME-Received: <xmr:toIIa3Ejksh0AO8-2IeBYfAFeQSyKmVRxl981utanDyySevvlTYxgtzBdtIILApfVl8c31q4K9qoanRF1hN9EiTIxy0TEiMkOJUwWzo>
X-ME-Proxy-Cause: dmFkZTFuIiwltpVA3K8+3+YpVXZ9Dl36LiGYvi2qTLl6duEs4K616iwGqYajzlsUPGxwAK
    Ik7iPN+Zz/TyN29g7LB01jpJ/xV+3qWcGOm4YpH29xphLkyOhbwNILIwL3nj0peRoqIebe
    Xpo0AjKYqbOQEc4FQsUiBwajVuYCASEVqHtLRVYIMphupR8QoSBkjX/5HB8WdW0v95N7YQ
    7+Fh4QBGyL8BvbsWhjSVoYi6u1BVzTVoTHnWKU18EtFBbi9DtZoKVT7k5tUaBY0WA84pjM
    vRFTxsK5F835FOSR53od9/WdQd4VNVyyDefrPp5ohKCR4uk4XUugWhMYtgopO11cG1O6hP
    eCeFoMECNPiU+RLWbkVY/RnyQ8LLuMUFdabJs11Zy0xavBUfNMfPQwklHulW2XLQCXjTBD
    I7X6t3LALkiT1WVOPzNQMg9ZN0zS9YG5htA3o6pkaeJSZe0/TukXhCb0eYdmSIKK/LRddG
    lbZtjtpV+mqDr+KHB+xNLblOSnk+x/fnqnLKFy3hK8pSI3Cf+eGN9F70NnO7T7u08JoDCx
    x2hj3vVBExMpzvtQTajKSLmjQDWN16aNvxY5WDa/TWGIQiBAoz1wlPZoDASRIGSKnHnB4p
    btf5qhIFQR6neMbf5I0OTAwN73OulhyrfMeTDRx5QIfz0mp7c1vsZiO7MCoQ
X-ME-Proxy: <xmx:toIIayKrXDW5MenkarUd_nN_MkzgAF4LLE_13xSqmO6Qw1HPpv46FA>
    <xmx:toIIazmfzuZL1jdaYR508mWdf4CD3xXlH8lTot7BImhCJYi317gGvA>
    <xmx:toIIayRPKW40dcjrKeXWR5t11SWmTcUlb2w0mbq8k9AktVi9c6QI1Q>
    <xmx:toIIa9IdzLnEd2Eti9S-1UXxVpB3hYLku07hwz5lXm1JnrBfvF7eKg>
    <xmx:toIIa-mg6DWSJdwNOMsm8QmwDRbxWc2ok563a0TuA9KpJ8xUQX4CyirZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 14:04:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Nahid Hasan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Nahid Hasan <nahidhasan141400@gmail.com>
Subject: Re: [PATCH] push: shell-quote names in suggested push commands
In-Reply-To: <pull.2336.git.1795686173178.gitgitgadget@gmail.com> (Nahid Hasan
	via GitGitGadget's message of "Thu, 26 Nov 2026 09:42:53 +0000")
References: <pull.2336.git.1795686173178.gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 11:04:21 -0800
Message-ID: <xmqq7bhzl8i2.fsf@gitster.g>
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
> bare, and add tests for each hint.

Drop ", and add tests for each hint" from the proposed log message, as
tests are expected with a fix like this.  Reviewers will notice and
nudge you to add the tests if you don't anyway ;-)

Quoting suggested commands for copy-paste into a POSIX shell is a nice
improvement, and sq_quote_buf_pretty() is the right helper for it so
ordinary names stay uncluttered.

> diff --git a/builtin/push.c b/builtin/push.c
> index 2377b5af55..a28138fcba 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> ...
> +	/*
> +	 * Quote for copy-paste into a POSIX shell. Ordinary names stay
> +	 * bare; metacharacters are wrapped in single quotes. die() does
> +	 * not return, so these buffers are intentionally not released.
> +	 */
> +	sq_quote_buf_pretty(&quoted_remote, remote->name);
> +	sq_quote_buf_pretty(&quoted_upstream, short_upstream);

In die_push_simple(), the first suggested command formats the refspec as
"HEAD:%s", and you are feeding short_upstream to the '%s'.

When short_upstream contains metacharacters, sq_quote_buf_pretty() wraps
it in single quotes, yielding e.g. [1], but it is just as ugly as [2].
Wouldn't you rather want to see [3]?

        [1]	HEAD:'upstream&name'
	[2]	HEAD:upstream\&name
	[3]	'HEAD:upstream&name'

All of them would be parsed by POSIX shells as a single argument, so it
is not wrong per se, but since you are not using the basic sq_quote()
and instead chose to use the _pretty variant for prettiness, you may
care.

> @@ -211,14 +225,21 @@ static const char *get_upstream_ref(int flags, struct branch *branch, const char
>  					   "upstream, see 'push.autoSetupRemote' "
>  					   "in 'git help config'.\n");
>  		}
> +		/*
> +		 * The prose keeps the raw branch name. Only the
> +		 * copy-pasteable command is shell-quoted. die() does
> +		 * not return, so these buffers are not released.
> +		 */

Good reasoning.  Common to the previous hunk, I do not think "die() does
not return, ..." should be here.  We are not writing a programming
tutorial for Git developers here.

Move the suggestion ("you can leave resources used to call die()
unreleased, and that is not a leak.") somewhere in the Documentation/
hierarchy, perhaps in MyFirstContribution?

There is one more suggested "git push" command in builtin/push.c that
this patch missed.  The message_detached_head_die[] template is used in
setup_default_push_refspecs(), which reads like this:

    static const char message_detached_head_die[] =
            N_("You are not currently on a branch.\n"
               ...
               "    git push %s HEAD:<name-of-remote-branch>\n");
            ...
            branch = branch_get(NULL);
            if (!branch)
                    die(_(message_detached_head_die), remote->name);

If a user is on a detached HEAD and pushes to a "weird&remote",
remote->name needs quoting.  The user of course needs to be careful to
replace <name-of-remote-branch> with an appropriate name themselves, but
it is quite plausible that they will cut and paste up to the colon that
appears after "HEAD" and then type the name themselves.

> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> index 22d3e1162c..484565d7cb 100755
> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -134,4 +134,12 @@ test_expect_success TTY 'quiet push -u' '
>  	test_must_be_empty output
>  '
>  
> +test_expect_success 'no-upstream advice quotes a branch name with metacharacters' '
> +	test_when_finished "git checkout main" &&
> +	git checkout -b "branch&name" &&

Two when_finished handlers running "checkout main" (above and below
here) look somewhat strange.  You of course want the handler defined
before running this checkout, and ...

> +	test_when_finished "git checkout main && git branch -D \"branch&name\"" &&
> +	test_must_fail git push upstream 2>stderr &&
> +	test_grep "git push --set-upstream upstream ${SQ}branch&name${SQ}" stderr
> +'

... you want to get rid of that funnily named branch before you complete
this test, and in order to get rid of the funnily named branch, you have
to be on a branch other than that, so it is understandable that it gets
tempting to write "git checkout main &&" in front, but what happens if
that checkout fails for some reason?  You'll leave the funnily named
branch behind.

> diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
> index 5f8aa1ed19..8f4705cae6 100755
> --- a/t/t5529-push-errors.sh
> +++ b/t/t5529-push-errors.sh
> @@ -67,6 +67,11 @@ test_expect_success 'suggest <remote> <branch> when the branch has slashes' '
>  	test_grep "hint: Did you mean to use: git push origin feature/x?" stderr
>  '
>  
> +test_expect_success 'suggest quoted branch when the slipped name needs shell quoting' '
> +	test_must_fail git push "origin/branch&name" 2>stderr &&
> +	test_grep "hint: Did you mean to use: git push origin ${SQ}branch&name${SQ}?" stderr
> +'
> +

Isn't this fully covered later in the same file by the new 'slash-slip
advice quotes remote and ref metacharacters' test, which checks both
remote and ref quoting along with shell_split()?  Perhaps drop this one?

> +test_expect_success 'slash-slip advice quotes remote and ref metacharacters' '
> +	git remote add "weird&remote" remote.git &&
> +	test_when_finished "git remote remove \"weird&remote\"" &&
> + ...
> +	test_must_fail git push "origin/feat;id" 2>stderr &&
> +	test_grep -F "hint: Did you mean to use: git push origin ${SQ}feat;id${SQ}?" stderr &&
