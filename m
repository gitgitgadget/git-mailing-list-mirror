Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608028;
	b=dRLugpCkfd2EgCO79FCRRwUyVZeQhUrp9tp/Y9Kq3XOAIz1SwlXOo7gxpcbLmMH0M955
	 Pf4N9uP/cSV2V103llKE/AbCkTY6DmkIck3pE/oPdEED78Q0x+8cTX2/9kh/RPvnrnY7a
	 VCQYfGSLk1PN8ihM9Dn0tni0HI2pP6iNMBo2a3u0JXvPl5OSM3pbu5dinKoCi9aMb1RLq
	 Kukwkm6m268ZOTf9FLVNPTl4i/rguxM2m0mX4mjaToU1OPvYXn0/xguvrkvyk6c60EGDR
	 0CFb7zl/CquTQxViYZQzTShcbQ7RDGGDmP5YpzgFvCoytL3JiL+U07vo8zG+hOC2KLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608028;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QIOZ+djrmD3PE7rxGcYDDnCFlyIB4Jh8uyRTVaw5mp8=;
	b=UMh8VqtAlkbx0frjSDEWy9Aa30vh0Wzssxh+PGuqNP5cPYGGBRpJQLAzoxpTQQ4kZOPR
	 xgaUuWMawwRjBSs9yUUFAbO7Ep7DlfeeuAFgf38AuFlCr0ShZZNWWXvgJ5pxagxCH9yBY
	 xHU+M7UeSz2vNiR+BtE80k4kwHrPNy/EYbERpiNpaJ//byQwwAUSI3QxX7nHJ6Fi5vPzp
	 akK4cAJXThKo4yY+4adGtP1/9lOJrfD48BSuRrfoFX+9daXclc5jtNvwg70aoCQk0WiGC
	 4fNc5/anSmT2ZuvUqdKoaxEj3HemtS2RwcNuhx5oApkI1HhR03YnVOabilZ++0g6i/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XSlHhm6W;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="LpT1aI/b";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CEB606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7CEB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XSlHhm6W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LpT1aI/b
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C74C7A00E5
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:40:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 21 Oct 2026 14:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792608027;
	 x=1792694427; bh=QIOZ+djrmD3PE7rxGcYDDnCFlyIB4Jh8uyRTVaw5mp8=; b=
	XSlHhm6Wgot9cyvBKfsUOxqw9D0wY8E3Z9/Xv7flSjXKmi02KmOIGzujrRs5J1C5
	VOtsdhnrXlhE2L2tS+VZotZzljuXs6k9YwAx0xRL99Bf9MwJHMrMmWN6LdRq/JAz
	clEbVq603bmYbEXZuFVYnrfum4dYRWVHxDagX+356KN+sbcG4GtsZVzTmdyFc7y2
	4QUXNiH3Vg+6ssLqJCdoD795NjM+g3L1H3qO4X1+3knnm8v9ANwnKbRmmWLM3hYd
	u1Mmxt+GTI6rvX03HjUpj9MEqWMNPUQ3fvIMNRTmftmHzHqT1QY/kduajWSLDjJX
	zS6cq4Z79OXLbAIDxMKqow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792608027; x=
	1792694427; bh=QIOZ+djrmD3PE7rxGcYDDnCFlyIB4Jh8uyRTVaw5mp8=; b=L
	pT1aI/bvVzUR51p69t8eStupyEUF25/zc1pfmXRdqx6C5ZMKKIh2lpu6L/H3KWt8
	zpoALZOoonsyXB1mqSDjcltObcR4F1/z3SHau1FQzJSGKnyFKBrPMZ+C50fNxXOJ
	7/Rwz3VoFuAmKnW9ZHm1L4qY7o42CzdCwJ0BP3vcm/EDhtegsmHxukqtyplk49Pn
	t9oO2z1T9rb10DyFJIoPLCYcV0H5GowDQ2DmpLKX7Y6hMdCgYMezNlV/qxv2luWa
	MTF/jyuaiwCW+eG0suSt4XL0Npk0H+9ICWQCRtVEnPv7EXSjSXdQQSeNboGaN3Z7
	WvErAOfIVWJZdqVxgE4BA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792608027; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CxHMDzj2A/CJ6hE22fQ6KI8lNsEoQmauvBhCeI5888oful1
	fbYegUp7bKZD/clRm7yiBef0WnUGdWcrMcW3kBMWA26nZYp+UxqeVlosNZkkC4jf
	ExG3lqftbnO/e/r0LDRGNhlkAI8uxuRA12acoX/5XosHeioWlBNHat4zaAoq6lZy
	biUmU3Os5tVRUHpTlhBIpH7O625bDaQ9flYPa7TOeGxxhepIymaIe9DIy4uDdftM
	CW/VzD1RbQrxHt2iAYRRsD6JmHBr461uRVS0IofwqcG5jTmsWgCwrkfyqDUuj570
	C4zVAZgdCmXwAilsaPZtUG6VSbtN1r1xVDIrnXw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:4CpiA4JwxKXOO2rRYQPvzmr+zlMk3S5ogWTUvXIwLVg=:w9N9uzv9jwrY1diskgqP1iHxLaSAR5l6Sl1+30hjokM=;
X-ME-Sender: <xms:GgfZal3Qgx5OB-a7GT92Q0xROb7TbSFVkcHT8JiUhzZ6ntUdQCfngg>
    <xme:GgfZatlvsKziOV4Jtho48XcrWjUuOe6Uf4DkB4wCXL3_hu0j-wJ61-VrYdZHc05Xj
    KddecydR5xkWBUuG9w1QrbtmuDAO-CsIWImeOR2utfkMomVTIVtOQ>
X-ME-Received: <xmr:GgfZal9SvopyzicMe3s1BWfKm4OyLYFWEzclBJYsoHOpHZW_AUvzEVlMzmR07g5goBH1pzmbUQoxmZ4tIqA9LcDqMcGI_Mov8rHB>
X-ME-Proxy-Cause: dmFkZTFe6GYRDph52mc2oiAoxrxEdcor2j2/cneLacns64cUz8E51CqC6wQrLcmDrjI6ea
    KyKvd1WFaJG+XyhflYgbLfvWMdmuIx3C7KnQugnvkk3wN+Lft4VbQbouL6s28TxO9ZJk8f
    qu9y5QGxV/visTIyE9JOO2Hlm6L6KJ2VjrDd++8hDArqu3K3NVFolPtsQ2gQ5NVgnyvjUC
    HYlAjbKArUh68P/rfrQsvxgJT0/fjfMTPs17EB4JKqty4F2XRFMv/2BU2dIrNRsjlbVKwV
    TzFtnsoT6AfsuGut6ViEuEdG5won5VkSLdrAEC3gi22xOLNFQx5QL6wj5goA4ETJ6EwNEH
    /OoPrGNug7aLKBtg8yENN+h4lSeOUtGcpbaQasEaS9e56zt8m6DYlhw6aICrzNVfxPY1Xd
    xIcE8zVp2idm/DQUi7b6WwRohNNolYLoSXzkilOQ9m3YsImj8qVs+Ic4Dhv2aRQS+syNoz
    y5IYwotl03tMQ/wkMSU0CaqNsZBP8APRIOSvmLhk1+yd2aYvBS/rptXUnGCiEWDlesF6cz
    shGouFZ8veXG34KW7niJQ6GjeGOiL0pJATAbyTt8vDRPIk+y+28cZaorMkRzAbDxsgvABQ
    51hbK+Kxojra7gruoFKnU1M9Z9LlVCnqXc6zjAnWESMSFbTLhZtH+nnTLEpg
X-ME-Proxy: <xmx:GgfZairGmmZzhOxwVHaWweSvbnzqk9OrvjawZyoplwxzf7VWSIDc2Q>
    <xmx:GgfZaulj4S7moUMiIloCxG2zTVwCJKJXnAFS6nH3WYy461B5uREoMg>
    <xmx:GgfZapgh-JXaeyVTWk80VO9hib_VPJDuRUiXovB4jDxv_cjqi0DJeg>
    <xmx:GgfZamc4uNkek87RIeoq3BqY2xOzlq0tBpFL1Q9wolxHXsMXOSoFlA>
    <xmx:GwfZal7ZHgrksXG1ERpmvrD2wluOPtF6RQ6YxW9frYFq82JVj8cw51Wc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 14:40:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian =?utf-8?Q?No=C3=A9?= Ramos =?utf-8?Q?L=C3=B3pez?=
 <chris@nortesoftware.dev>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] gpg-interface: fail when the ssh revocation file is
 missing
In-Reply-To: <20261021041720.572035-1-chris@nortesoftware.dev> ("Christian
 =?utf-8?Q?No=C3=A9?=
	Ramos =?utf-8?Q?L=C3=B3pez=22's?= message of "Wed, 21 Oct 2026 00:17:20
 -0400")
References: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
	<20261021041720.572035-1-chris@nortesoftware.dev>
Date: Wed, 21 Oct 2026 11:40:25 -0700
Message-ID: <xmqqa4o6oq1y.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Noé Ramos López <chris@nortesoftware.dev> writes:

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 60c315fba..ddbb29e78 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -533,6 +533,9 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>  		 * we still call check-novalidate to display the signature info
>  		 */
>  		ret = -1;
> +	} else if (ssh_revocation_file && !file_exists(ssh_revocation_file)) {
> +		ret = error(_("ssh signing revocation file configured but not found: %s"),
> +			    ssh_revocation_file);
>  	} else {
>  		/* Check every principal we found (one per line) */
>  		const char *next;
> @@ -576,15 +579,9 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>  				     verify_time.buf,
>  				     NULL);
>  
> -			if (ssh_revocation_file) {
> -				if (file_exists(ssh_revocation_file)) {
> -					strvec_pushl(&ssh_keygen.args, "-r",
> -						     ssh_revocation_file, NULL);
> -				} else {
> -					warning(_("ssh signing revocation file configured but not found: %s"),
> -						ssh_revocation_file);
> -				}
> -			}
> +			if (ssh_revocation_file)
> +				strvec_pushl(&ssh_keygen.args, "-r",
> +					     ssh_revocation_file, NULL);
>  
>  			sigchain_push(SIGPIPE, SIG_IGN);
>  			ret = pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,

It is a bit hard to see what really goes on with the default
context, so here is an excerpt from "git show -W" output:

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 95abf1ef4e..904165a892 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -461,164 +461,161 @@ static void parse_ssh_output(struct signature_check *sigc)
> ...
>  	/* Find the principal from the signers */
>  	strvec_pushl(&ssh_keygen.args, fmt->program,
>  		     "-Y", "find-principals",
>  		     "-f", ssh_allowed_signers,
>  		     "-s", buffer_file->filename.buf,
>  		     verify_time.buf,
>  		     NULL);
>  	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
>  			   &ssh_principals_err, 0);
>  	if (ret && strstr(ssh_principals_err.buf, "usage:")) {
>  		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
>  		goto out;
>  	}

We asked "-Y find-principals" with allowed_signers file.  There are
a few cases.

>  	if (ret || !ssh_principals_out.len) {
>  		/*
>  		 * We did not find a matching principal in the allowedSigners
>  		 * Check without validation
>  		 */
>  		child_process_init(&ssh_keygen);
>  		strvec_pushl(&ssh_keygen.args, fmt->program,
>  			     "-Y", "check-novalidate",
>  			     "-n", "git",
>  			     "-s", buffer_file->filename.buf,
>  			     verify_time.buf,
>  			     NULL);
>  		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
>  				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
>  
>  		/*
>  		 * Fail on unknown keys
>  		 * we still call check-novalidate to display the signature info
>  		 */
>  		ret = -1;

If we find that the signature is done with an unknown key, we run
another ssh-keygen with check-validate to show the signature info.

By the way, it is not a problem this patch introduces, but the
comment at the end of this block is a bit misleading.  I first
thought another check-novalidate invocation will happen later in the
function but "we still call" refers to the invocation of ssh-keygen
we just made before the comment.

> +	} else if (ssh_revocation_file && !file_exists(ssh_revocation_file)) {
> +		ret = error(_("ssh signing revocation file configured but not found: %s"),
> +			    ssh_revocation_file);

Inserting the missing revocation file check here means we do not
even give signature information for known keys from this "else if"
block that we would have given for unknown keys in the "if" block,
which is not quite satisfactory.

I wonder if we should be able to somehow fold this into the earlier
"if()" block, making it the single place that deals with failures?

>  	} else {
>  		/* Check every principal we found (one per line) */
>  		const char *next;
>  		for (line = ssh_principals_out.buf;
>  		     *line;
>  		     line = next) {
>  			const char *end_of_text;

And everything we do when we recognise the signing key does not
change, except that ...

>  			/*
>  			 * We found principals
>  			 * Try with each until we find a match
>  			 */
>  			strvec_pushl(&ssh_keygen.args, "-Y", "verify",
>  				     "-n", "git",
>  				     "-f", ssh_allowed_signers,
>  				     "-I", principal,
>  				     "-s", buffer_file->filename.buf,
>  				     verify_time.buf,
>  				     NULL);
>  
> -			if (ssh_revocation_file) {
> -				if (file_exists(ssh_revocation_file)) {
> -					strvec_pushl(&ssh_keygen.args, "-r",
> -						     ssh_revocation_file, NULL);
> -				} else {
> -					warning(_("ssh signing revocation file configured but not found: %s"),
> -						ssh_revocation_file);
> -				}
> -			}
> +			if (ssh_revocation_file)
> +				strvec_pushl(&ssh_keygen.args, "-r",
> +					     ssh_revocation_file, NULL);

... we no longer need to see if the file is missing, which makes sense.
