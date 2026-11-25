Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626461;
	b=4JaHec+xmI+nrdHpaJk/1mL3JMRTXxJ+v+CzsxYsUajnMuviVPu37rKeSwFu5Odk/hib
	 SkRvYwec56Ug/gLcZQsDJO80Zt/d2eE0XK/6iM1jftwjIJIsPJ3SOYu7pILE4OKDc4hL8
	 JMHla2A1j+xhhsvy3HXu/7DoOjOPNROFr7nk814tUhsHmALsRiNfOxomuh0nxLd6k6S1V
	 2sD3iLQYQmb910bBrKYTmRjyJPUPk7eS0fwxX3XKCr5dRKqhmdlg4HRiaGt1/jfZTSKHd
	 pQMeTEcTvZsugh+PGOj69uDAAtIzEHbdpb388fohprCvk5zS5pxH+gYxTtoNmrlM0OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626461;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XjVcVdvaeL9SVZNIcVg8jFwSis6rxAhmKxxqhd3R4Ao=;
	b=l8CCx/KAMWLpYO6LIPC3CMgZfsr7LvQUDx0jzocTUBfy2rYYwZzzIOPNxy3MHLGgm1ZJ
	 dZuvrsMOP77tXbqficszYrZQBCi8pP+Gwuh2VTMOLs73k8gRj4hkTDOO4VcfK+RayMm1e
	 oB8UVX0Hf/NYdVxTE/gqkJR/i5NYyGmDb5F1N3PefUma2rKQ/B/S2FNIKqszv4gttfaEY
	 fYAlbXdFZhqoNu6+mGA2hTKDIZ2+rUvrywiYXy0iAGwDLokhhgBWAUeYL1ESEAK4cdZz+
	 0e6poL8Pm0HCMRENdgfdwWaetBUIvPk+u2HG1RuckD20aacf3S7w5LOKQS6tr2MfWnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lLbvjUQH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=x1MQAwh4;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8F606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E8F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lLbvjUQH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=x1MQAwh4
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4C7D140038A
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:07:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 12:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795626459; x=1795712859; bh=XjVcVdvaeL
	9SVZNIcVg8jFwSis6rxAhmKxxqhd3R4Ao=; b=lLbvjUQHsMVhOOOX0n0s9L/ZUs
	OwMVZI/bm5ghrngS9UzWS0Kj9emvRttiBiPZjnF8OtDpTY0ReGw6tbntjfKQNvWN
	qoJg6UUMY3p5pi1rEvz+RyqA9CjjZDuaAzKFwZCpO1e311VTybwdwHbVQFHEJsU4
	7wnpfbEKMZ6zz0kj95OofqezAjZuO3TteMRk+hWopVM8BIDQpDo+wDZiRGxvSSnN
	Q7bBLpi+8tJcQvwwDBtLKeWWXCY+GjEnt8nfqJ/9Hjv6zMa8af33e/UIbmpBlCnx
	eirb8L2uP0/+Y527GiIcn1jvvt13yA/ODVLnmkFubtyjz8AaU6Io/Vx1/G2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795626459; x=1795712859; bh=XjVcVdvaeL9SVZNIcVg8jFwSis6rxAhmKxx
	qhd3R4Ao=; b=x1MQAwh4quqTriTgUYjBnkVKHGQdxafgNNWePQD4rDBLA0on4iZ
	TjHGU1DYBdm2v1njonRi57A7yB7la86FplwxZEGLTB6dQNuK/U89hdKFNQT4LDUE
	Qczxk4tCT5U48Q1lS6JR5v66lmqym1G8S8jUEDNzSvHcrbhy4H3iqxDC1Yj2Xpke
	UD203vffLzelO+C4/OI0mXCld9QY8hqF+cuPEzZlCjtiAjS1p1asA2ZpD+fOhIoE
	zfmc7T2zrmtb9GE2znx9BNy2t2DJw4HrtoFDUenL6BK+ELcRKCv2ZLA4jLbZ6Tus
	CYaKiEDg+N6e3qq9b84/J/o6kfyDBVNI14Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795626459; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GDKaJ0ENlj7JFAeu9ajbsNfGAS60+dtWtMPPAMPOqF+6Csm
	CgTXzr6Dvc7Y1JisDmdES0un48ebY1Mc+bBC6PnWQTjeVHyg8eZ/sLlaCe7I3oz3
	NPgPl+hkgi61nhYPVLEXZzQI9P178s7DE0sD/hPgD8cLfe2XUbdamU1HuDssZu3j
	NH5L2WipGwHuhL10EJFeP4oFdf9uXJrzd9Af1dnuQ9B8VV4nXe9rfwqMvoz1j3xV
	jfuXqQTdilNBCAZrJwDXrg+EedGnG6XJwmGI669CECyGogLrht8iE76E1qT+Dlyn
	KCccjHqv5meQktYfdQqJm2LP4J1P8UbBjDvXrPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NifYnEO4geSGvKcPH7SIbbMC3rpS4jVMUqBEQetgZ0w=:av+9k1SSXFjucGjKTOQxDwZmLwIvcLExsUsPzIofgWw=;
X-ME-Sender: <xms:2xUHa1hizOgxTn8u70VEfVQdYdCPF_yi8P8xOr2P7zxO2cMxdcpZ5Q>
    <xme:2xUHazVfbpzCtyMoM8qE3MaIL7d6TaGPjdYIvWmhawBk31eVJ0Kp6BVvKmEnJTvPv
    mArispRfzJwvXLiRfbXhf6tP_A7zWDez5nAfN_Oft-sjW8UmI9-GO8>
X-ME-Received: <xmr:2xUHa8X22eWN5D_e0A_CuiIGpvKdMOg2jocewh3Dkpwc75nyFG1QSJUyKpc6SrwhXTgd3oGrCNQQseI_i9lWCIDEA4AJxADh08r5pL8>
X-ME-Proxy-Cause: dmFkZTEKMni+0JAx2wO22N9SQRXHyKsNt8kYK5BHEW2bVSTYyVu/t1o476MQEN0VLWONFz
    twKb3EU+W0NWusEs5SLhiENotQ7A6+nKHkqG4yzkLcV6I2k3ylDsjyq+jHXQdVasht8/Rz
    HQde6YJUaSjScH6qHdcII9VI3MLnHxvnuMXU3JBpnXUs0/U/zTFQacKIJ1GVXd5vMgutqU
    KVj2YQnFtyKlVCeh6f4u0wTezy0iJ70hNnNqOISk5sXQ5+qGQQzslGg/YOsKaP7mjpnIbM
    NU9OMtifoHY1WzopgvkVKWUCSzTc1Hlkp1+vnahhw98nJcomhf2DySXwOZqULxnYLhiUuH
    5Mk/oejrYLHHJiU/vETbvB/y0wQrSSDhY1v7OJ745X23IDxvIvsuc8oJjZ8FkUQDUbL6hr
    RPO8s2RJvVE5Bu+NJEPf4cj9lRK6P9WCZbd+QRZgihNHw9zJz47KSVO0jU6GBnRjjSBOvp
    GiWIRm98C+2MtGOnoP8foZdAts0AvW+nakw2tAlAbDBQpv6GjfMM0BR35x4bSyK5Z7VNjo
    hMyUg3PHG0bn/+4Xc7ZI3vHwgqTDZ0pCi+hzu2z6jhvp52N7LUjqnfSc2S0JsxCypiogEF
    LaMV0HytRJPyGybJNNRH/fOS0Nr/S9583Be4F5faQGro8XFwFMsUp2wSfk1g
X-ME-Proxy: <xmx:2xUHa7guT5TQYBUNooSH5-N1BlUbiuZ1iqJ2wyBT-J5l2oGCm0fUug>
    <xmx:2xUHa_aqWPlF8KrN3iQ4e0vOiUODwf2yGtHpWUiYqhQuZtOAwWjusA>
    <xmx:2xUHawrT78GairtQvhKVpbTD68rdZYk-_Sd8fwCj_HBAfZzGrzPsBg>
    <xmx:2xUHa0OzMy-mr_2AD0BgphBTnc5v-Kz0MD3K4AIj6T14_dwNr1kQkw>
    <xmx:2xUHa6137vM2cmJP6PaiJmKC85dw_rb4m30bJlI9yePXLCb0boKfI6Ct>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 12:07:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Wonseok
 Oh <wonseok_oh@korea.ac.kr>,  Wonseok Oh <marinelay7@gmail.com>
Subject: Re: [PATCH v2 2/2] sequencer: save the null OID in abort-safety on
 an unborn branch
In-Reply-To: <14e015ba240a661d8cf8b6bdbc4d7093bbc42ad3.1795577024.git.gitgitgadget@gmail.com>
	(Wonseok Oh via GitGitGadget's message of "Wed, 25 Nov 2026 03:23:44
	+0000")
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
	<pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
	<14e015ba240a661d8cf8b6bdbc4d7093bbc42ad3.1795577024.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 09:07:38 -0800
Message-ID: <xmqq4id496w5.fsf@gitster.g>
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

"Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Wonseok Oh <marinelay7@gmail.com>
>
> On an unborn branch, .git/sequencer/head holds the null OID, but
> update_abort_safety_file() writes an empty .git/sequencer/abort-safety.
> Write the null OID there as well so both state files represent an
> unborn branch the same way, as older versions of Git expect.

Don't later versions of Git including the latest one also barf if
get_oid_hex() is unhappy on the contents of the abort-safety file?

In sequencer.c, rollback_is_safe() reads the file like this

    if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
            strbuf_trim(&sb);
            if (get_oid_hex(sb.buf, &expected_head)) {
                    strbuf_release(&sb);
                    die(_("could not parse %s"),
                        git_path_abort_safety_file());
            }
            strbuf_release(&sb);
    }

If a multi-commit cherry-pick on an unborn branch stops without
CHERRY_PICK_HEAD (or after "git reset --merge") and the user runs "git
cherry-pick --skip", sequencer_skip() calls rollback_is_safe() and hits
that die(), I think.

If there is another reroll, mentioning that rollback_is_safe() fails to
parse an empty file would make the motivation even clearer.

> diff --git a/sequencer.c b/sequencer.c
> index 20bfe00ba3..e0bfc6305a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -644,10 +644,9 @@ static void update_abort_safety_file(void)
>  	if (!file_exists(git_path_seq_dir()))
>  		return;
>  
> -	if (!repo_get_oid(the_repository, "HEAD", &head))
> -		write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
> -	else
> -		write_file(git_path_abort_safety_file(), "%s", "");
> +	if (repo_get_oid(the_repository, "HEAD", &head))
> +		oidclr(&head, the_repository->hash_algo);
> +	write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
>  }

The implementation is clean and covers all callers of
update_abort_safety_file().  Trivially correct.

> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index d52fda1c54..fb1ce079f8 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -284,6 +284,17 @@ test_expect_success 'cannot abort a cherry-pick sequence started on an unborn br
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'unborn branch is saved as the null OID in the sequencer state' '
> +	pristine_detach initial &&
> +	git checkout --orphan new_disconnected_state &&
> +	git reset --hard &&
> +	test_must_fail git cherry-pick base..anotherpick 2>err &&
> +	test_grep "could not apply .* unrelatedpick" err &&
> +	echo $ZERO_OID >expect &&
> +	test_cmp expect .git/sequencer/head &&
> +	test_cmp expect .git/sequencer/abort-safety
> +'

Here "unrelatedpick" conflicts against the empty tree, so HEAD stays
unborn and both state files are checked directly.

We could also add a check to run "git reset --merge" followed by "git
cherry-pick --skip" to cover rollback_is_safe() as well, though checking
the state file directly already verifies the change.

Looking good.
