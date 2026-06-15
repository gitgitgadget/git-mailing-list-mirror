Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FE2CCC5
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488913; cv=none; b=K15zz4e11SHERCeY1O3/TeslDua151eJFQwr9ylxS4/eYF9inFNkd+7LeN+hzIpOSj+cGQdcJ3kXMqxne1mnE1Z0/ECVvDotfWa0tPhnR+cCzoYk3zQpTsHX/5iNoNx3mN55cehkcO72F2dk0hXWYl1Db07/qjGBXn97URYM5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488913; c=relaxed/simple;
	bh=Ou6pq6+UeVvgO2/Ud/zb5yU9Hf3dBmbeupM677+tQFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EhfupOHBlrFhCrYHx/SxA6r1sISHEXffdec3tOvjx9GkSuV7pEQLWkb7OSQGhgO5wT5nKCds8jG8tHeXLlVxRFZewZiXZ6P4wa8t4oDm1JsmVlr+pN7aL6zZ+fPMSxxLOfBqlbkSvK3PskFSLdSpD3LrGLZfmBnMP+UoSMl897g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iuMxpThB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVEyjp8C; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iuMxpThB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVEyjp8C"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AA2D8EC0072;
	Sun, 14 Jun 2026 22:01:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 14 Jun 2026 22:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781488910; x=1781575310; bh=xDjqhUYVUd
	sEIz383h+56jFSTsHVTKugmJ6p/R5IMzU=; b=iuMxpThBjrO6Ip5h5B39g4xK1V
	2UzSMEr9LG5mQ5L3lZk5fjmJHpS8oIMGwabIDLv7LUKmRSK77jbBjs7G8fhBtQxO
	WnROkVnevHHF3uY0tdMv03RPdUTEYj9OVslZdxH8M3TUNXCYUs/ZZ7GKb8RFUuFZ
	Grc4WvyFZjJqNfG1a1VWjIKsxfQyhsPuCcVWUJDXq7xKZMTuESkQNAVP+1KbK+AM
	Qc02TTb5Zbw1wU2CAilPN/6f8WACX8oCw//1+plkzan8AcyzeTngxtGZJ9JV8+qQ
	7XpjyfPPaFNB3HerqpGDHv2fN+xuLfwELjX7p6TWm4j/qBoTI89/AFn6Htjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781488910; x=1781575310; bh=xDjqhUYVUdsEIz383h+56jFSTsHVTKugmJ6
	p/R5IMzU=; b=GVEyjp8CF5Vfps0jS6JDithc2pzPooLigzlUmf7jijopzrWAj/I
	uW7iotokOvIR2GrUhQNpHwfPZ/x2PXzstVRNmNUYzHZ9WJNdWHV7OCQUbX8Ar2WI
	ZcXF8/GRBygZE/ZtahC7z4Yh6dFc/h7yDCB3b4LVTdf/yMWrEHf/bLKAAaKmaSj3
	k9CUqQlqQI+hvtREJYu8nnWN8UcoCRfI22n/n0EWm+zmZQJJmr94t6qsc5aAdeGC
	Fc2OnRju/Nb3FG4/l5/8gDu1Qykf9PemPvuV8+PszLQWMPHBKsHDW5YM2SvQeVoI
	m/lRAR/vCSI4Zm1621K8gEBaZhjalZUx9hw==
X-ME-Sender: <xms:Dl0valYmk8LAWaYGHnaIU-PgVWoZJjCMTUQdG4r7Dc8DtyBy9s82jw>
    <xme:Dl0vajZXj1u-SIclQPmXjrU3zZ4ftaQbnKLncvuEOt_eELefmlCOYSWrJMFaupJtX
    n2a4pmqSKG-ZzJrh6ZVYSW28vXd9lRgDKaIoN7YuA3eDyiCssS5>
X-ME-Received: <xmr:Dl0vas-zFGy-BtghIHuHLbr7oQnLhk4j92tV5EFjw4MdcLIL4qwWSQDHQRIIhcciuKMbewQyrPZIRosuXOYjShhOV03WwHG4V180>
X-ME-Proxy-Cause: dmFkZTEo79P9wgep4LkZFmoT9T5w/2VzrwYb8UJiNqz6mZUwKxSG+TWtNkGGoopgCjFB+q
    YWDUS9+yyfqzpI/SbN7ZhkWCQKhC3jYXhqVIz5Ah9jqEJnnian6duG/u1YnUR6bNCaqKb8
    oTnjPCXdatUuf4IFBFve7rlkbEmxKkkMOHAXaG2gvI6ycaA6s8mY0QE5i+kVZhJtxJC8uN
    Vgr6Jdu0vKB0e5OZ9aHjKmVymx8MRAgwxM7usNLDOXVsDa1Z9Sr/ET7g0ZaEdL2cdLFEmp
    WEPfK4teLGzwArTJw7Pemu5A+Vg7TU0ZakBFQOkGOhIe72zCRRRqiXMbtJBD1Yfift1mZd
    es9O42EEbRBTDPjcuqFJqDtWwOx7gGStIfmGUpUqvfR31vodXNiOTY4oGVX55AyZPWvzRL
    /PyHtrquFcxVw7GnCTyVVJnCFqv22grybhXLgK85zuxfizL2TLeebZUbfoHG6PIbWMbfqQ
    wf2zh6mgAeWx9kNDQXV67hP1n6sLGoCT1vT7RujBP4lAC31Q/XfNueYSCvtBDlK7nfsPAg
    mBRS3Kc/ZCImH4RMmShh+ykIBMBLlYb6/okQVoaiYMxWwNKSeqg90GNiN3E1Y5VdDHjDh/
    vymkyIfHQjmcu8EOoHrGluEZMAkhV9w7AfNF+OrTbWJ4zhCAOWttV1kV7SqQ
X-ME-Proxy: <xmx:Dl0vaiiXULyYi3rI4KMrFWtwzsG2Te1Hf0TR8UuF7wWlEtP9QQG11A>
    <xmx:Dl0vaseBP0zHIgpEWfE1KwAzfVEQcM2YgOTAnJ6q74BvNpG7-LmYuQ>
    <xmx:Dl0vappZrQlpjKXS1-e8qlW_NvUxB60lPZMZGZUbZg2M2s886W2UsQ>
    <xmx:Dl0vahCWMovJ6Tq15pVtgffvSu5Vvjq6qgpTVtiDjeF_l10a1Xpt-Q>
    <xmx:Dl0vascSApmIemLMffNauTXXz4pn5t-2DwDj9YvETc24PlybWjQWaJwU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jun 2026 22:01:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 0/2] rebase: add --fixup to fold a range into its oldest
 commit
In-Reply-To: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 14 Jun 2026 19:25:39
	+0000")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 19:01:48 -0700
Message-ID: <xmqqqzm8d0j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Adds git rebase --autosquash --fixup [<upstream>] to fold a range of commits
> into its oldest one, reusing that commit's message.

[2/2] seems to add "--fixup-all" but I agree with the "related idea"
that naming it and modelling it after "merge --squash" would be
easier to understand.

> Related idea: https://github.com/gitgitgadget/git/issues/1135

I also wonder if we can do something like this without adding any
new option or command.  E.g., if you have four patch series, where
the initial implementation HEAD~3 is followed by "oops it was still
wrong" fix-up HEAD~2, HEAD~1 and HEAD, then

    git reset --soft HEAD~3 && git commit --amend --no-edit

is what the user wants to do, no?


