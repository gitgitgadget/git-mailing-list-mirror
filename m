Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203162;
	b=agB/QutakQ25vZLosd8MmlnOsfN3bnKj4oe10hRsB4JbBAG4xoBAWw6lXfkNurvE2NQ5
	 7e5h1ZaGxyGuJeKrbDqhCP8FV63LeM4pEhEZkTanPWv6J6WhSfTSEmD71Nw3hSnu+Qqgf
	 7DEZ4iD78q5qyiSTQhNkq4+8PkrqsSdrrVYE07euSak7QIbW7y5r2JIZJ2Cq4lodf3N99
	 ga/ZnGJffpHAbNanP8YjoGWBxAAizWUkKtorSXu+fv6d8Ua4zMaPw1KXX0GQgdTlKlY93
	 hjTYy44d5Pv9LbzG/O2P1FwJIdYfuN5MvstyGEUCNYmO5iMthfBIOD7aYRqvEEqbDLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203162;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=pJna+EbdnAfGnxAvKuM9BMwWhytwREkzinQ+me020B0=;
	b=EaFItabz7gdoOPAdCXpQAqfDXIpYSk4NQ9ZA1rMDb7+ohLHWcbUDpVhKD75PNrKV5i3X
	 RsG/f4RMmMYexkALfovuZ+YaLTK8qYcAlMESBlmHT5XAzEbuOnxDAXKEceNuJFAgDLiJ3
	 jLNUMc4o9fd5aBbqPMloZZM03RI96Y7/jVtOg1d5AlwqVuBJBH78Uf7SgK5CYW03/fd4x
	 t4p24r4LirN2N4J3bq9EHwe4NshR1kC67BHLCU3/xa2ckQunrzv0MmpWXB5a2z+veCrNs
	 zwE0ugstIVq9qC6RLCn4GnLFfPeGxwFZea9ESbim/kkoO4xJvDUsNDvbQsAQwvbuz2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Y0Hv8vOq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PAxczaUB;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9A60A2633
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 15:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E9A60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Y0Hv8vOq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PAxczaUB
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id ED5D61D000C2
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:59:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 28 Oct 2026 11:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793203160; x=1793289560; bh=pJna+EbdnA
	fGnxAvKuM9BMwWhytwREkzinQ+me020B0=; b=Y0Hv8vOq818PcwvAchAl4L3J9S
	inRmZpkMfzYNECFxVfM7CNQwQV2+F1Nz+aL7ZhbLFykl66VWV7zDFQ0RpaClFyX1
	QTgLmuXuCNbvPVqlygK/gOc+XyiNqUsjiTU2zirt4CQ6JO2wmnmtC6hIB+McopCd
	Pty+66N2Rp0ASiPUFuamy1bX6JeTwJF2CuHx1cpnE84oByxq1SyctAb2+ivh5rMN
	OLQcK7IuoZEsbCJ+i+VOPObVyXoD/REHTWvhAiq+yR10ggGRVbrQuM4XFhO89qxg
	hXUUtYIP7ryWPu4ZDpt8LhhZIXe1FEEARRXXiJNgakdVVAHOfa1Mlp/p8VMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793203160; x=1793289560; bh=pJna+EbdnAfGnxAvKuM9BMwWhytwREkzinQ
	+me020B0=; b=PAxczaUBZhA0OTo7Y4SBzJpKDFtYvVia7eHCCO6WVr2ApwWsskW
	uCPGMWGry+W4Oo+S2lsvUiPPk+mvLj5E5VTTuDdev5fFYNaRt02Mlvy+gJG32bGO
	R8PkGKpOMk0wUPYmKfg/cKRKcy5PgUsydjUP+EQ7dolrkFdAuClhdaWVF0s6iM2L
	tbbWGUdWm5oKK9xEgfHLq2MXlBNwG8sJutrf/ToTUv+/rbSdM1hQyCS3ex9B/g5R
	CAu+WbGxz8pN0nx1jeTCrD3siCBbLjAvNNpJvy/pko588YidBZhqcdzZnXT/UwKx
	X+VQYYRuKnVHOzArOb5Yvb0UEI+8NKRMZgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793203160; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Zz4IAGoUZpZCzVQAOjjRpcB89W1ujooM6cCo45tqYezr3NE
	JWeB33qNzUGg/N3tNPk0Et2+MmXlMtcTv9uEzNd+aH78TFFOzcakQr3w02brf41o
	bEPpvJqz43B6vgeYYTDPRBdySDCP9bmuIAxLp/uJ4Bp241vSeLra1dnohc/Js3PD
	GqoXZFBe8WOUdr2jvXOf7cA/7GT44DFdj98iU3s/6nJVRhEEfe1RlwZiJ6vp5vfP
	PgFhQDqpfsX4drVxW9zk5QAlxzGD4ae6VzV+qUFL6io86IW/PvwWFd0O/pQD4oVd
	4L5YQRO+0f824ir9pNJbE0oILqf9KFV2m+quqDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nCqWKD8JjH4dzRicus0uBuvJgS0073czW3SxqprQCm4=:OsfWV+78rtahZE1bMudid0PF9uf+JK3IgKgvk1muvZc=;
X-ME-Sender: <xms:1xviat1yFOQhfIPDNSGmZbsB2gUHGimYh-K8eQoFZ4hnxUbHQxIMVA>
    <xme:1xviaq9c0CCz6dcBD0ZY26Jvm5vCEbA9mpIx_eUhiIoBvK--MvONNvRkqPRPMJqQ6
    dNBioSR4HBtQc8GibFLQI3dgycjwQz69VUeMSx8p2xfZjDCiBHKnw>
X-ME-Received: <xmr:1xviamNDYwIH35QPIPs2QfojuZUKy7pAfIPVOlcNzbeiv0LOCTJKQhnNJLJRwdBPlx78ogPpUrPlUWjThnaPNYAIYqASVGstIjEs>
X-ME-Proxy-Cause: dmFkZTFEdLZ3/f0Q+UAv2bfTl8K74fWg61+IhpWpCLJmAm7u27t0GS7bjxnNoK1Sy9OMR0
    O9dnWO/xug5PEeykPasrS1oxTjNrWgoegVKlXAodEpLU/wz/YpGN/VYzlFmzpj8FCJ1CxG
    0pXIi7x0khLZU4G/aQtgvctWfIYQfEGwCL/CsoEEuzyS+aUke0S8kzQEQXsWEE2dEiryms
    nObLG7iWl6ktxebQco74ojlU5OS418VKZaNIMeitiyFnomTD+KZEtDkIj7gctnVhYQs+QL
    uBUymkmh58ADr0lVTO4xqxAiCuwSVpbl6ievZP1KK1u1NkJJWin536PRevySksu8IMl9Nq
    67mAIuDNxOKhYVM0oMt28YON8KviwJ22nvPVNPm0GzKVXzCGInSbwxqXExUiigR1jFEtQc
    ITFOEU9TyOLiswun0JHVvYcZga7aqrhMjMfLzX/wUmoWkF4ZvWgUrNP0uFKiRcsFCt7LlV
    pGUVYoSh/MhU1C51gJuY47a/kyL5W+CM6mJG9GRGK/cbblQIQwuWk1Hceq0074PslSFrE6
    0ELK2eVMpQERcEdKFkSy0iNOnVloCYAGvQmTvTFjqx41afGoZL+5I2IyXSnm1YIgHaZZYk
    +aKhfdhj4AjL2qakFAr4tvKJfLE+rdui5EdBHMQMkxeNoD8aOZJYFou5j9lA
X-ME-Proxy: <xmx:1xviamfNs7EIUePb4rqb7aSzlDK1D01TLA0Ut9QbwT9s9HHJ68kC7g>
    <xmx:1xviatW7IhZZqK8LaTkvRZ-woh3QzCA_ZARmKtwWZX8nXBwZSTaSMw>
    <xmx:1xviamix44PlmsuQfLnnH8JkUoe-RKLLk4eZSje0Vy7m9z5B18zfyw>
    <xmx:1xviak9Bb8uyfVRiVq-MWq7_QJdn1BuMGvk-gH9mriSUW32dlAQ2Sg>
    <xmx:2BviaoOSDHi4nCysIjpXQOlyUnMzPBC_u7CqP8tK3kYIKXYkkHw0yZTo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 11:59:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Matt Hunter <m@lfurio.us>,  git@vger.kernel.org,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] init: show absolute path of (re)initialized repository
In-Reply-To: <auGePs3hkgJ85JlV@pks.im> (Patrick Steinhardt's message of "Wed,
	28 Oct 2026 08:03:26 +0100")
References: <20261020053932.1274210-1-m@lfurio.us>
	<20261028051704.2759358-1-m@lfurio.us> <auGePs3hkgJ85JlV@pks.im>
Date: Wed, 28 Oct 2026 08:59:18 -0700
Message-ID: <xmqqecd9ddex.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 28, 2026 at 01:16:37AM -0400, Matt Hunter wrote:
>>  Changes in v3:
>>     - expand test to cover the full output of the init command
>>     - Link to v2: https://patch.msgid.link/20261022120749.3567828-1-m@lfurio.us
>
> Thanks, I'm happy with this version.
>
> Patrick

Thanks.  Marked as ready for 'next'.
