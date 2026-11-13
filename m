Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598970;
	b=kRyoV0sWFLpVOBXYYGALyBmFkr60kAYgegiTLDCjj1d1aVPhvlIxo6WZqVfKSXHZc8u5
	 kYt+xb4SuomT89qxsL3ne3lOVpRiQ+8leASRITYomX5cFbCrZozgVJGSrwtu6BZ+KSQh9
	 tP7yO6/igupS05Ci7loTcahycajMlvtm0nhxqSfhWDHzR63UkkOuFx8pbuq5eFs1wqjyj
	 l4EktR9k4fqSImRB90ottYOroCDHSvy4Nin5k8Pp2IoRCm9NuCX0cZZ2nVxgm6T9i5lte
	 xk8uy82Nrven6ilp8ult5ZwyU/mg/zhDafUK7V/eMoiYbdrFf42z8txG3sY5KwTPUAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598970;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=PIsLwNmXv4qWPouOew5ZAumGCyJKFrctUmP0URToJY8=;
	b=Dj7WJ+TpNAuakS41x+3OKEkiCiQA486UtdR2p92JZszc5bbmjgiTYnrzQtzhMWL3mMeq
	 pBnMbTYMTC7AAMzB9iq82JQyOHeiEjTAhrUPKCU1exR7H+lDhw9spJqxVBiheepMziiKj
	 yOGmnYESkF4l37qnrWRjJlThsJCk+w2gJxfG687NLPiX8k0ut/7ugRaoMnbgIdT2MRnkP
	 r00/sYL3fqjaGcReqd35KeYF9I5SBG8SFo1UEWWmzAMTW6DdFIxzVaSR5U5MJsmlyoB4a
	 UXxijiGXAOuon+90/gQ2yMfZ1eYCv6zBHxfxAjOahfw9/+/RXyFToUp5nK94k33iV1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XdPWuBFz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a52NycHw;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CB606A331
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A8CB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XdPWuBFz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a52NycHw
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5D347A016E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:42:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 13 Nov 2026 14:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794598969; x=1794685369; bh=PIsLwNmXv4
	qWPouOew5ZAumGCyJKFrctUmP0URToJY8=; b=XdPWuBFz9A2UfjeDRs6XYClSeI
	GsrjJ815VfzVJ3Vrb4k7+UfKtIwhwjj4o5Rgz1fjdfHBZLu1Penla2JinsFJSz8e
	exQZYJBlWcMsX+M0+bJxYKePoZ6o2ICBkSc6guBqwzqIOBXnxfaRmB/i2Uhb1JjO
	gHU7k0F7mHd1Vzp3hGSgC3E+bUMl/K99f6wvdJdxQkOrKWuEllWYlia6JRYi25pj
	AcwYV+Ncd2rfm3W7SRt0mQS6//Q1uYr8TthFJn7ZB4Dvz22uSK2Z5oxOU9KKPHwQ
	uHpPmG6SgCv/tiXVFn5DKdFGT8G/cv6BFWDS1RdH+jA16IBbJtF2WyA5ti8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794598969; x=1794685369; bh=PIsLwNmXv4qWPouOew5ZAumGCyJKFrctUmP
	0URToJY8=; b=a52NycHwbtyWi0+f17DxoPMI9XGpo2hfPD73fSntjd0ob8Z6V+d
	Rwh6b5AMfPtdsXSXc9rIJ/OY/1HW31GYei1u9wYksKHuUTWlqAqwBGyZg2ZyJ2aw
	YZ8o0gs6PtV0SJmKkaV/NpRnJHpKw2n20OH5gd+KtHe8XP1Zacku/uoel+n55W2s
	OFxkdtHYMFZz4dfsY1wpAsbH5BOWcc96NDeq8VLpuWKd16hsiC2t4bifjevVq9tQ
	hjLhRIb8LsWHxMcKopKUKBzAAQ9MaAznw2k8h4XaIk3vmzkgAJ5QJGwsRX3rVVPj
	aB0ZsBAUdj5u3GYhO5SPgsFOyyGkgdMQyEw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794598969; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AW5k4+kS8CLhYVzFZDr1oMZpPBLHG+w2BUrcbFvwa6BXxs0
	2S6ClCjIALCg+2TCQXXFnzUjD9QTxJtD4hBZYP1CBtjbAw2OqS+srvqqRCb0MCew
	531Y2OUPhDy42ZJzFetpsn5ZGA9hV9E1TQf64Blijsfcl5H3/ph98n3liWNyPD5E
	l2pFduk919JUiINxnbFD6amzQRzGllEYiM11qSIvXyoqct5urFjGMTyaD043v+Pz
	budh9t7Fs1Ycg7qRWOPep5eHk90RSCxqtcQzcPbOgoz3VEQOHqHcUUbrSj8b6BLE
	H25fKiRNA1BrYgdVzIk3TU7gp0ydmwwBmqQ5UEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tICETbZa/U51GU2fOB+x5fB3o1J/Cy4wVqeJWnr3kyk=:ylXvMMfu8Z3GjXCsOBm4TwPZ96DAJplt8zaZ/q4dIL0=;
X-ME-Sender: <xms:OWj3akmH479BkWcNvR8R37HB_9svb74EJwQwPjaoOw-1dU8LB31vjQ>
    <xme:OWj3aq3w5oeoy0wlQaUjKDSKlJdBokofeqIT4PSqRBAKE_-zJErAnueLZkjcK-63g
    LjpdBeiLYbH7EjW0fXYb3zq7gMoEjkhkHyf68EPIOinI6GC2d_xBg4>
X-ME-Received: <xmr:OWj3anr19azL1aDYk4oK6zR7vAb5xFgg7ouIKRCvp4tHiFb3S10FJUY1ijGPHAKIAbh4dWnFW114vVjzt7Iwr5gcxtXT_J5buAnu>
X-ME-Proxy-Cause: dmFkZTFFkuf+yu1abG7ihiG2cBRiwfHA5aQwxUnhefYNY06VhiHbQrDZFsb8anks+cnSVm
    zRxDKFbELpz3oD/Ogr/vkAN7G1HEmxhdf00XNIqxHCNnuW9V3ZbURgsKAKsvhC9G7cwXRZ
    gsbzmHAPzG0TgFDUDEBVVoWWlwuJ1CfreBTraPtYyNhN5iDu1eq9wFEOQQYlqknDj5+vU4
    mmiUbHxgYTpi8NZMW+YP+14hHMgg8lelLnYfiK/qe5ofgvqJwA6ZQJRwQQ+ZS/8gKRcHw6
    UEIoTfuxTj7Q9y6KR3tJ98bqnQdMnqZzo7Rw6lFPZwVh1040tochReUt5Y0o4Be9E7PnRM
    lwSOyuSN/ubPMFBi5s8EVC0QiIUsM7Hmg4JB/P+IhvmvSSGY77mo+9b2dJnfynWI/kgPBe
    P+c6Lcr9X2pCHHYC8tpLLOmyymvaiKDhH79/z41O00sTsEypej1QdkKxm8wpssT5J4I6lS
    Y7mT27svZ8OwXyXB95geSTZQcH72Vw2Bh9LsL04mBI/FcInl84UgTwlUlDF0k083TSiqsx
    HA8LheuYrK7VNZI/2CjrCKxXqKjpOvzJEcmdsIMfjgdMWZ3E/TML5T8PS2bulJPWddq5VH
    xat9gORqZj5fqDr3KrjeTSwTIScjAx5vAVXB6ET7DKfqR1dDB0XhJ1q/hRdg
X-ME-Proxy: <xmx:OWj3avcu3ZAUfHzI7BLqrTRClt9K6-wZxQpK3mrxxZCBhZFsxTOvQw>
    <xmx:OWj3auoeVJHDGX6W27fBoLUw1O3P_V5LW7Wjh7NiQ-TJxdIbIUPCrg>
    <xmx:OWj3aoGz5S6lsyZdjMtORyMgnN_0KbqwXJOKIjUhgJshgro2LoO5Ww>
    <xmx:OWj3amtn6jck8oiB_-re6ophaSgc27DwISwTWSAHDEf_h3MoaTCWkg>
    <xmx:OWj3ajL42oTnwV--XSvM-6a3h0Thk3v0XqepUcTiT5xPKPRWC6RcUEfT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 14:42:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] promisor-remote: fix crash without a repository
In-Reply-To: <20261113000600.202744-2-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 13 Nov 2026 01:06:01 +0100")
References: <20261113000600.202744-2-christian.couder@gmail.com>
Date: Fri, 13 Nov 2026 11:42:47 -0800
Message-ID: <xmqq33t4bjrc.fsf@gitster.g>
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

Christian Couder <christian.couder@gmail.com> writes:

> When `git ls-remote` is run outside a repo with some promisor remote
> related config options that make it write to its config, namely:
>
>   - "promisor.acceptFromServerUrl", which makes it auto-create a
>     remote, or
>   - "promisor.acceptFromServer" with "promisor.storeFields", which
>     makes it store fields,
>
> it crashes in configure_auto_promisor_remote() or store_one_field(), as
> the `repo` argument passed to these functions has its `gitdir` member
> set to NULL.

It is tricky that "ls-remote" wants to work outside a repository.

> This has been happening since 3e20258d11 (promisor-remote: allow a
> client to store fields, 2026-02-16) for the `storeFields` case, and
> since 7a56394fc6 (promisor-remote: auto-configure unknown remotes,
> 2026-05-27) for the auto-creation case.
>
> Let's fix that by checking if `repo->gitdir` is NULL at the beginning
> of filter_promisor_remote() and returning from it right away in that
> case. It doesn't make sense to further process the promisor remote
> advertisement as `git ls-remote` currently has no use for promisor
> remotes anyway.

Another possibility is to nip this higher in the callchain.  If we
know, as you said, "ls-remote" has no need to talk about promisors,
turning promisor_remote_reply() into a NOOP outside a repository
might be better, but the function does not take a repository
parameter to be able to tell if we have a repository in the first
place---perhaps we should add one?  An illustration patch below.
The callers (there are only two) should of course be updated.

In any case, we should comment and say why we punt when '.gitdir' is
NULL and why it is safe to punt.  In the illustration patch below,
I only covered the former but not the latter.


 promisor-remote.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git c/promisor-remote.c w/promisor-remote.c
index 316d9950aa..702c53c2c4 100644
--- c/promisor-remote.c
+++ w/promisor-remote.c
@@ -1373,11 +1373,20 @@ static void filter_promisor_remote(struct repository *repo,
 	}
 }
 
-void promisor_remote_reply(const char *info, char **accepted_out)
+void promisor_remote_reply(struct repository *repo, const char *info, char **accepted_out)
 {
 	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 
-	filter_promisor_remote(the_repository, &accepted_remotes, info);
+	/* 
+	 * "ls-remote" has no business talking about promisors, and worse yet,
+	 * it can be run outside a repository.
+	 */
+	if (!repo->gitdir) {
+		if (accepted_out)
+			*accepted_out = NULL;
+		return;
+	}
+	filter_promisor_remote(repo, &accepted_remotes, info);
 
 	if (accepted_out) {
 		if (accepted_remotes.nr) {
