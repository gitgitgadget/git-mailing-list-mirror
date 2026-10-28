Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215661;
	b=xzuHI0OO/6fVV6n8IHb56Dmd9a6zauSXhmJIwsOl2JMOaNZJtzAnkKSL1/gJ5ZfpQJvz
	 +/eboV+gk+ONRy59QpYEqawhXIoj0r7K0/e1LEkiIXnLxUjpWraldBfQx3G6KNN6JweMQ
	 P/ma3BIaSTY9cL+l0Xigw8w+9xtGn6KwXXYzcF2ZZWoaFm308tR9WZ6NLtQLQR3XaF6JM
	 A7gWRMbBGB1xCwvrS3lJfqszerm8ovCklqoJ6r5iqP+wNmFwzsBQ4WO8ZPFayaioPByKw
	 hM4r+qiQmbLjlr5OEbBF0jtxzSIA7h1OOAbfzGvrFd4lrN8vgKAemH2z3m8CpbKVXWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215661;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=hR3xzQDEoycjEal02khglfCKpUmcD0BtG6rvW5E3398=;
	b=Ig68kkNI+LxARqGz/dExPKK2XgxcZL/l4kbreOlw8h5cOKkTYY8UffR41BRmRq5cMD11
	 7Up+mcOC9/NBJW82dG3UbGYuTKhwD+T/fK8cDUy/qyzoYeuoHvPER55xXmtKJFJr0QPX2
	 t1wk1q8qipoX2tSyp+5Ek7yoUfOlR9Yqa0L9j1oH38vcRsY6MLj6t85RZG6SZDW9QL+Vk
	 L6Hz4KJQFaL71reW3amf/TTmZwzYTnv3U7xK/rsZvLYB9v57RKQmM8ha9/XHbdMA/tDYd
	 u9Y13x5YMHXUiiBTd+krv12PFQ9tomKkRNuA+E4MgYrQOykixeLEAIfAYK1DfFV12oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=BnA9Nmmq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ai01HKnj;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB5606A31D
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 19:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AFB5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=BnA9Nmmq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ai01HKnj
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E170FEC065F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 15:27:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 15:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793215659; x=1793302059; bh=hR3xzQDEoy
	cjEal02khglfCKpUmcD0BtG6rvW5E3398=; b=BnA9Nmmq0C2VVPM+hZUZu1CqO8
	A8KnoSkmczrOcZNHv9v0DKOnkUco3motJ2TCwy59vOBMI/P5sJALNSAiUMciphsJ
	O5lI1Rj1YSmcaC/sxJ/W4r8+MO/McM+W/88OtZDdBzZLt2ipVjmxWZ6jV2HvKaLQ
	hTR96oNar5dE39id8t6gke20Sy5EJy8iHAsRGD3lQulCHwqCldOVLyZT3NADypmj
	QIAoQAn+CrZzyYtMfJgPol92JLW86ejFVIKb1FvQ6oY9risueRVQL0CpSa9wO50o
	hPRIumt+87zloqz7rU7I3JiTqFZl+E0wrIF/Y1vbf3DvH68CDXV80SihV1aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793215659; x=1793302059; bh=hR3xzQDEoycjEal02khglfCKpUmcD0BtG6r
	vW5E3398=; b=Ai01HKnjt1qbe2cKe5DmupnXI0vjxFuCdQ/cTBeY0TOmm4IBPhn
	8/tPQvyvXacJcpL6DcXdwcE+jN+0z8kvZJE3h8WRsyxAlLjqqYrYuw5GdzPIFFyt
	gWn7ucCnqAuhWVlOtQvlquhBK+5qKJ1iPFMgcGfBxLIhBxEXlgcRaoAnLqv/1R1r
	oWu50mdmRMsp3iu+TXDdyCfB9edoMiHTJCyMieZCTWrJnyaGtzIL0+jodzQoNZN3
	cqvnTGJ8B3l+vcy0nldVhTIjiCt15xDCC+WiCcKOP1NfIRF761y5d3ySzlpnoEXT
	V129G/2MCNLXCCMw6RoA5gJ61IOjPf3vqwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793215659; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:D89/bzqwlCQPzePQTH/fJxnmthYqFaj/CCC3GYYjWrcxmRI
	rObolGOzePuguTGX+A8bcrvZEiAzOWN6kgOLDtTuZ4llpTnbygsyGMRC+15VEtl3
	W3PIlBv4og/iTwIelUd0e+XxeLubEb3PWoXgCpxe81/t5GBNUBNed8Cv/zV89s14
	17JrqJyGQcGfDcLCVdWgj6rMHp0sGclSUoyD3+lFasObzzv5aQcuyPVyJj+CSkqX
	Ub41AFdLj1jHTWxyQTG4k8yQ9LCugXliAXw54bkzurwX1j58+wUifIlxWT0zw+Y2
	ez+XHL+XTbCCxxAmD1BLDwg0lXCONMjVRFE56lQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:iSXMAO9Y5jfoov0fE5iV4b76AnHmEOvAHF3jdIdHE5s=:l7jwdi94nFSi4br6HeJcjVEcbUy6j+Szzo1AFDlvr68=;
X-ME-Sender: <xms:q0ziakl2t7lnqmz6-SY8Y-FvY6xWRhGl8HXNdvYbLHWjkMAPkVaCRw>
    <xme:q0ziaq2z3aOSJmyIAvjXxKX7cpt3LVrlTaVb56f90Y2LVfYz2hEMvIH3V3KMJry1d
    ZMsKZuEz4x5sSfh85s8qL1x5b05AzLuKslv0EWIIIjEICsdOdJUgFI>
X-ME-Received: <xmr:q0zianr8OAzYnEGpJttafNAeXSclfWNBP2QGVcoCPjScsrmvhHwBIeUoxoGfvVTC6Zj7uLbim4DlGMUjC5eEYfCRiLHhINnTbbPA>
X-ME-Proxy-Cause: dmFkZTE7X98lbSDbGAXXooJoGPbiWD7jnofDZvbEic9ZoYCphqO6RT84T9AVduCctbo139
    eCI/cBaMI36eIhcXozR2UXxONJQxZ1Oviw+mV++r1gNuVptw0PShwBAUBjVZMN8ofgpV1U
    fDSlt3FNswjrBHj1eqzKN88knMqr8EEWUMZxCfc9pTZ2EaOWy4Y640EYJoX++lQAKlVggO
    mlDn+NmC4XR8u2kHMQTcqhca8Y+FuA1e5iuiI9WrtZS1Y5tVAODk3r1X7SmolyJ9WbO81E
    2LcKoyp4hIG9KNwQ24EE2DJK2pjH3y/t2+sSLZWi1yvJ7M+xHjnbsewO2hBJRbVbv/dhNV
    Fsk+plX/ekyeDtho6z1QzyerkpBvSUV/NMqYYRSEnrkCV8K2gSH6TjMw95p+RtpkEzput0
    yAO+qTwYhGUjEDmyM5JP3LMFs/MekRFytQgEScdwdB2tSIsoXE02MM+wDAf9AHP/p+dLYf
    BSjP/W2ZAB2NNkQ7MsIqwIV1qMKHmDs76Tde3nueAKkGZXnRm+u46oVrFSPHuNoQZw+AQB
    qmqthDDORdKCJnnlYjRGqizRe7uQhj6LpOLL78gHFm/bSw5h4hNZ9l4GkRRdyAOpgDFddM
    FcPtIL8T9e7VST1hoNNi/oF26VuQ1jeIeME1wPBNt4PgIPbd3Pg/FxTBzh9A
X-ME-Proxy: <xmx:q0ziavcpscxLUIG6u8U4n4XHyvDXxppmkmboNQDgSWEJxIbtkKbu5g>
    <xmx:q0ziaur9F-JLvvVKRXZQSSkuIJVYWjp-5_64xMiULz2OWWix5hwKsA>
    <xmx:q0ziaoGmpSDW5vJK1h2jwC5BIzpDy2X_3jyr9r4j-Ih9oywfZpK62A>
    <xmx:q0ziamve9p7WJnVX3xi5LyUpioZSCz07eXVQ0Ujb2AXggcxZYUiQPA>
    <xmx:q0ziajK_jAxIopdNO66-m20IYU418dQS-Wo613955iGuWCHf6tge0eRu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 15:27:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 5/5] setup: report when GIT_OBJECT_DIRECTORY is what
 we could not use
In-Reply-To: <20261028115412.169748-6-kaartic.sivaraam@gmail.com> (Kaartic
	Sivaraam's message of "Wed, 28 Oct 2026 17:24:03 +0530")
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
	<20261028115412.169748-1-kaartic.sivaraam@gmail.com>
	<20261028115412.169748-6-kaartic.sivaraam@gmail.com>
Date: Wed, 28 Oct 2026 12:27:38 -0700
Message-ID: <xmqq4ie5aamt.fsf@gitster.g>
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

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Improve this error reporting UX by explaining the real cause wherever
> we are about to die. Because the check does not depend on the candidate
> that is given to is_git_directory(), it is enough to ask once, at the
> point of failure, whether the configured object directory is to blame.
> With this, the user would see the following:
>
>   ...
>   $ git status
>   fatal: not a git repository (or any parent up to mount point /)
>   Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
>   cannot access object directory '/tmp/git-objects' set via
>     $GIT_OBJECT_DIRECTORY: No such file or directory

Hmph, this is only a half of the real story isn't it?

    $ git status ;# to show I am in a healthy repository
    on branch master
    nothing to commit (use -u to show untracked files)

In such a healthy repository, if I have a bogus DB_ENVIRONMENT,
discovery does not have to fail.

    $ GIT_OBJECT_DIRECTORY=/ git status
    fatal: bad object HEAD

On the other hand, if I am truly in a bogus non-repository,
it does not matter where DB_ENVIRONMENT points at.

    $ (cd / && GIT_OBJECT_DIRECTORY=. git status)
    fatal: not a git repository (or any of the parent directories): .git

Even when DB_ENVIRONMENT points at a valid object directory

    $ (cd / && GIT_OBJECT_DIRECTORY=$HOME/w/git.git/.git/objects git status)
    fatal: not a git repository (or any of the parent directories): .git

the command fails because it cannot find a valid repository.

> +static int describe_unusable_object_dir(struct strbuf *out)
> +{
> +	const char *objdir = getenv(DB_ENVIRONMENT);
> +	int saved_errno;
> +
> +	if (!objdir || !access(objdir, X_OK))
> +		return 0;
> +	saved_errno = errno;
> +
> +	/*
> +	 * TRANSLATORS: The first %s is a path, the second %s is the
> +	 * name of the environment variable that set it, and the third
> +	 * %s is the system error message.
> +	 */
> +	strbuf_addf(out, _("cannot access object directory '%s' set via $%s: %s"),
> +		    objdir, DB_ENVIRONMENT, strerror(saved_errno));
> +	return 1;
> +}

As this is called ONLY when we cannot figure out a usable GIT_DIR,
we do not have to worry about a case where $GIT_OBJECT_DIRECTORY is
not set and $GIT_DIR/objects/ is not readable.  So I do not think
this additional message hurts much, but I am not sure how much it
would help.  It would make the message more confusing in the "no
valid repository, DB_ENVIRONMENT pointing at a healthy object
directory" situation in the above example.

