Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423614E56F3
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452203; cv=none; b=VPJ7wsQ8aTuMk/c+7jzZrcuyrIVpSkL4Fre3KAfOD7/kN6uyzvcBky72qltr0mi9J5xx2PYFreabRNk3xyf4CSe0Qi0lQoEOesZm5a8/V3OdY3JvJgKbvICG0XXhIDPRHN+IjvZAZ6suVMJDAO+vlj5Z2KVZX91Xnox9GemQgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452203; c=relaxed/simple;
	bh=/94fDBBSD/y+R13Q9fkHQSXjwbggj6vDy6wn3LckrU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hzd3K8UnyyxFMHMGN+HkEjZtWIoJUbRJNovMSnCV4BQdXmeLmaFFEatB2qRs9jG2/hlis2FeEyz3UMPF+MEwsG8K/TadzPa+cnVR/TCIoPSfMfmvszKrF3cWvuNLXo2qHr4z1qwJSJ1CNMWfQAyJAKnWUW905h9CQtQXj2krxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JR4MuOSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V05kIBUR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JR4MuOSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V05kIBUR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 75A4B1D00027;
	Thu,  3 Sep 2026 12:16:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 03 Sep 2026 12:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788452201; x=1788538601; bh=9wDGyLwO6O
	B6H7lY02m4RGggk4cPp15G8XjsTrOLrOk=; b=JR4MuOSBzXSebQWm0mhfB2acw/
	pbTInHU56NN7LJvjjPvX0xSP8mSg5+abFbhN8pj5+rgflobSuKZlloaJV5CUuNtR
	cvJxZvWthjEinCoJcFxx3+M5nu22MmU9Jus9VFLfqxi1FtIfsae+5hW5Y+jPf1Vq
	2HCyy4s0I8v9f/o4BEv7NkpOstd3hEq0rxc6KbHF3mdeg0Mztt+T8y8HI/hPpCOH
	mKs3/j8KD4iIaTQVtFGiZ3iU/Egv/G5I9a2yCkVsRi5hPiAXO4sSriDTF/oTkr3e
	/ITEnCKSbB2wd3Xs1AJu1c6NEdd4dFm7IiPfEMwnqLmUreiBxMX0EEGYNhCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788452201; x=1788538601; bh=9wDGyLwO6OB6H7lY02m4RGggk4cPp15G8Xj
	sTrOLrOk=; b=V05kIBUR4OqIQVTlmaSBVGJnPS4wtJKFSJ5PHF/o6/lNOf8izs2
	z1fsHgRtuxLCaagXKD9krJRaJ7UmA0LxfGAacx9ZmKTRX9PlXc8VvEVk9gs60Coc
	SLjCEFbVhIyQJ0eiXu7SYgEML4PiRc6oFNrDDEXDHxleEs7ZHZA8A6buOVfypZgj
	UpcGoZp0giHFRDoX7yri6kw4QbCDhKVVFtYIkMg8V6XPJNHIL0MAsEW06MwOmlD+
	opt8qDsevtTYppu35wpzFaxRzuevG9evZEwvQToS9QwPVxKHpxKRzSqdVUmeDpSp
	kFpewTmux82aUnkT06ZZ/jB83LRMnnh/x9w==
X-ME-Sender: <xms:aZ2ZalOJ-5AmYcVJBqlnDRpUKZNEWFZXeIiWWOCq6ngPVGXaX8Mtvw>
    <xme:aZ2Zau3wKmYA5mRXF4Ds3hzQyZtP6KTosOtybHI0i2vEpOqEQd3UpU8TirhM8xj8C
    yuGhf8EW4_dhJfFGM3lpR8BzOa1eKPZAI6I1XFNkvdQLY2c_p-U6w>
X-ME-Received: <xmr:aZ2ZaskVTFi9bDcfkoQ6HVFzPLhmqT0VMCG6Y8gwNyDr-2rTxeFCdJ_7H0JGdoOkyktdOFicwY9tDR1X8OKuhMQwHjmgvRED2g>
X-ME-Proxy-Cause: dmFkZTEQTRIEaaoekEmJrQiehIvZMBJFCpYsDEKhAs99P3uFZGxp38s/S3sbdj/g0rHmHR
    PNoUMMNnXX+HJhBHhFCkIalOiVuCBXnSuyhkW+44S/pQj4ZeL8d4ISj5u1U4xXghRGpuzq
    g4AGxm/2WFvAvQ/1K0YfbbFgSJrV4OHsL0FCsQlT2BiGHNDt7zp2t02jJotkANQHq2LRPk
    25e7fzGpyuj/NKMfey9u0TmyBSVZU03yDMH1yAH8m8dx49dxXj/SjhHMwDwQB0YARBhiKE
    IxtP3tlN7o4a2Gbm1fXRlYnpHDHZp5637w7Xc549FZgFhFFrCv9Q2YyAKx5r23bFI6bjVU
    7ROwmdaWg9BHRN9nsdCZu7gGHZ96EyjYnOpe94ZZ7/bvSJci5vVOaTyqdlalpQ50L5rgOP
    7MHzsbRfK42j7ss3r5LKTtUH8j+GSFiS4bdjkE2CYvm8oOI+US3cdh4tPmdtgFUVJABPze
    VCNI98+RAMh7MplvF9tnxBRj9/CmHmGsHrK2wQLdHo8/afkS9KgoCfiYUXZJzNkWef26G5
    u16lAOW0zpb28Mg0nu7ktV3WsJqMWiK0THev9ioey29gkEGwPZQtI3GLyUXIINjDoXOplW
    XmD1TgzN/magbysZy7UEaPMdjFZjnCbdHblgL5Isoz3I4p+J4V26yaKTQLEA
X-ME-Proxy: <xmx:aZ2ZatUG5dyvPMRjy677VCCJGPKRBJwlMYKp8pNwpTYmnm4iMKLNVA>
    <xmx:aZ2ZaqsDGQldDaOietK4YYAwpzExDJce4BcBXLkigHn3ugVq2WS10Q>
    <xmx:aZ2ZaoaLkggjprsc5qI1Fgl9xzLf73wdHb79AaGwrex1w_W22Gcc2A>
    <xmx:aZ2ZahUUgXlcXwV47PDilz7m9WPPh6pyq22bM3ZL0G3_T1kc04j8rA>
    <xmx:aZ2Zat-QgXwlFgdqZSLVRrbwrBURdd3Lw8PqRJKaqqAa0hbfYuaUffJg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 12:16:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org,  Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref
 has no reflog
In-Reply-To: <20260903010547.85469-1-f@lex.la> (Aleksei Sviridkin's message of
	"Thu, 3 Sep 2026 04:05:47 +0300")
References: <20260903010547.85469-1-f@lex.la>
Date: Thu, 03 Sep 2026 09:16:38 -0700
Message-ID: <xmqq5x0mfgyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksei Sviridkin <f@lex.la> writes:

> Since 99a1f9ae10 (push: add reflog check for "--force-if-includes",
> 2020-10-03), is_reachable_in_reflog() stops walking the reflog of the
> local branch at entries older than the newest reflog entry of the
> remote-tracking ref. That timestamp is read by a callback of
> refs_for_each_reflog_ent_reverse() into a variable that is never
> initialized, so when the remote-tracking ref has no reflog the walk
> is cut off at whatever happens to be on the stack.
>
> With the files backend a remote-tracking ref created by "git clone"
> has no reflog and does not get one until it moves. On my machine the
> leftover value exceeds any real timestamp: the walk stops at the very
> first entry, never reaches the "Created from" entry that "checkout
> --track" wrote, and the push is rejected with "remote ref updated
> since checkout" although nothing on the remote has changed.
>
> Initialize the timestamp to zero, so that a remote-tracking ref
> without reflog makes the walk cover the whole reflog of the local
> branch, as documented.
>
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> Assisted-by: LLM

The last line adds no useful information, though.  Besides, you are
fully responsible for whatever LLM emitted and contributed into this
patch, so your sign-off must be the last line in the trailers.

> ---
> The new test fails without the fix on my machine (macOS, arm64). As
> the value read is uninitialized, other platforms may pass it by luck.

The code change looks good.

It is a bit surprising to see the fallout from a change 6 years ago
to be addressed now, and makes me wonder what else changed recently.
Certainly year 2026 is not the first year in which macOS on arm64
started becoming widely used, or you are not the only user of Git on
that platform.

>  remote.c            |  2 +-
>  t/t5533-push-cas.sh | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index 00723b3..6d30169 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2751,7 +2751,7 @@ static int check_and_collect_until(const char *refname UNUSED,
>   */
>  static int is_reachable_in_reflog(const char *local, const struct ref *remote)
>  {
> -	timestamp_t date;
> +	timestamp_t date = 0;
>  	struct commit *commit;
>  	struct commit **chunk;
>  	struct check_and_collect_until_cb_data cb;
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index cba26a8..77f46f3 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -396,4 +396,22 @@ test_expect_success '"--force-if-includes" should allow deletes' '
>  	)
>  '
>  
> +test_expect_success '"--force-if-includes" should allow forced update when remote-tracking ref has no reflog' '
> +	rm -fr dst src &&
> +	git init --bare dst &&
> +	git push dst main main:branch &&
> +	git clone --no-local dst src &&
> +	test_when_finished "rm -fr dst src" &&

You'd want to move "test_when_finished" immediately before "git init
--bare dst", no?  That way, you can clean things up after any or the
"init", "push", "clone" fails (as well as the main part of the test
that is done in the subdirectory).

> +	(
> +		cd src &&
> +		# a clone leaves the remote-tracking refs without reflog
> +		# entries with the files backend, but not with reftable
> +		git reflog expire --all --expire=all &&
> +		git switch -c branch --track origin/branch &&
> +		git reset --hard HEAD^ &&
> +		test_commit D &&
> +		git push --force-if-includes --force-with-lease="branch"
> +	)
> +'
> +
>  test_done
>
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
