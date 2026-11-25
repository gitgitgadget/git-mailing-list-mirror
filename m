Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633785;
	b=FoLr3vOJf7gD+ro5C4zZA1A+fLkYXmjhqVwC6iOf6z0mLC+enGs6AljUHepVjdCRanfC
	 0i78Z8dNdckdQXDg4kinz/Srt9w0siQGQbAQzlNXbxxdnB6Tv3QvNRk+dLp96tzszAHwE
	 hbctmGyuRp7Zwa/HvCb5DpOY3eRW/CPpU2zbXV2GzjVtUhxm4RuAnrzg36NO9RCjs8tTQ
	 A0t2emKrbKkvvaPW+sRnfV8a6+aSXTdvbhUwpxHZ8APtel/pj+yEggiCy3MclrVEjG4vx
	 GXreHmpOj55/lu3vxSsKHCsm9E4GytKLjob9Ev1a1hMBhbgeTIwXuy+tO5oQoV7MHww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633785;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jiDDeOrETjvjue5supPedrahr+jKJhEStjH6PZ0oowg=;
	b=RNf0+G2S2LUtlDU8fbbs5pXk2LIwggpQsteOR7lp0XS+zpJnQj9TH9uO72OQy3VvGEX2
	 h94G+/ZKT4VKktsnsxuxGpZF9WZ0ZF4jxi+ZWUjqy4pvvtWPCZvbXUqvspW07IUYOWoDR
	 BBkJTtxiLXUYWAAvQ0seSSqg58FA39gE9U4VFsK3E1OKiWnlzHLiJrOupS1GNiI3UJdvU
	 gOq4yynhuCXkpVxtibPzzg+lZpAj44JWJdI6em+xmHJ6dt4R4aQkmzzmc28F9HDlAQPhf
	 V5tr6yYNpJ6IzI5yQ0pnXsRjz2VxfkQZzY7XnxWz8XzZog3P4VwyJ2z7L0XS4srqwfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fSi2VxAP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ozBDB8XE;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7C606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C7C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fSi2VxAP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ozBDB8XE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 18215EC0C7C
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:09:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Nov 2026 14:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795633784; x=1795720184; bh=jiDDeOrETj
	vjue5supPedrahr+jKJhEStjH6PZ0oowg=; b=fSi2VxAPd8gYGlbuaB23FuZjhL
	0ykiKec/sCa586Dj0Qf688RB3/KRWCtN3oB4gt6m89/4v3yK2lgSZyHC12CS1E07
	e/oOYBS/v7o9UcQK7UnTzlX8nF1yLbOhNDoActyXVN788pIu1pJsPCal+1J8hUHk
	h4L37ZT3AjcK/h/nYb6TsiG2fNVr1JpliKvuLzBraSCMVanYKg3MMBzSrXDxlrkm
	jCIvlPwKT468k56DH6ya3lRehIEL+7WvKUJZ3WVjFSvupn6Ha+xfx7JDVOlLCdkc
	qQDf1m2dQEqEyEDtxkvEj1bHnvqXhIP3FryRbrnwYZmLw9mZOLfQAyomgNAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795633784; x=1795720184; bh=jiDDeOrETjvjue5supPedrahr+jKJhEStjH
	6PZ0oowg=; b=ozBDB8XErY/W+uwCzUAakjFSQ9MSTvEMdWwz5jHAiaHOUNEBKky
	46ANGV6lRaXHHg4VYLt7kkycz/iNZFuK/i7v3UBpKNLAOelUU6VQB1iI+6Tp4IBg
	q3Su4RvA26POD8j9zK8aP5srb6Y5+evplr810r3x3m0QIjIf2szXZmnWXpVovEEo
	n1ivKYYIU5lg1+d+emX1pHOJTmnILSC4OROWEch7AF4b5naFQlqrzEZ5HgXVb1rT
	jhonvyAmv85nu77G4+7Pou3Y8w+W7uTJM5xkq8G06Aff8/K0gu4a4wOCkIGjG32d
	e2uyT19dC5YbdSmOucOnIcirHV0cyJdiXBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795633784; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mB0lDHUig8ykaZAMf8mh2MfCtxOZZ66Y7enx1M/3brbPCOl
	BzMxtC9R2Y5DW4Z/j9OLVqTuu+h6OVEiAp2LMe+kXPT9Dc6BZ8o/5IVxZvrzKD9d
	hqrxqpSmFb1C1p8ATNPSR3XuWpebUiz/5zw4tg7kUvNaEcuMixFtozlcGnSFxySb
	sxlg4RfD/5dxbGgJVku4j0GvObVl3X/VJiZAVwjBYKMbCfyqwMDM9bgQSeGsnlan
	MbCgR6WaPlnFXMmB9OlKmOG8Ep9Ah6Ey5Fwliypo+zhNR98FEN4EloYJPNeWqkJj
	sROJSHAVyJ8MpdpShP09v6usOtysnTK2ep+5SCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:uw+h2E/N6uBtF8oEDWd1e3sXJM7WJ3P7rfQQSgKzXDk=:zbFbhnsRq3bqULpBaBj2lsnWKEeFX+fW2edMoU9ic+M=;
X-ME-Sender: <xms:dzIHa8aw5IcdQ7aQ6b0E5recm5Wo3rTPjKjA-83BxMW8wRSS3ZV9qA>
    <xme:dzIHa2cjIoyQ9V1WUZ-2M1w8QG8yxApAe7QaupTGvUKZkoEGCdhGvs4IwP1y9CJHO
    bLfIRbwFtCr4otGqIRANQmHrMYT6tbAEgE9YLWqkKEWosvqzP5-8Q>
X-ME-Received: <xmr:dzIHa9Ja2N5odx1IKwXt2lf8rOBUTvgU7KLS1r_xCH52_lVfI8aTfGF3Uk_3gpkXayMKGJ5xvI_Ms15C5s5Z7K2S7oc-aSnQsdW3oTI>
X-ME-Proxy-Cause: dmFkZTERSTAswU2WZStW+KDisTeSuj2Z+pc/q8zhbLCPF/2YQmL8XrSkUlPFQtCHgzrmlp
    EeK2PxINaZmGLvWo8yxOMMQePVzyA/gMTepQhIgh8iQ9QyXy4UK6CX+rCtuTi6+5zg6ZTs
    0QPD1LWGFBB7OcLTXQLcsafAxt31T/N5zE+JcH6zJO5PRhzJwCOJGAyDcU6/jqSyz+XOtb
    EKBgM9Zqa98f1hux8YfxKRt1ILy8908RCISwCfwGxyp7ozDWfLg7DSMnWzXT9QdPBxRLYF
    tmnu4P8lKIUc8y/jwJD8+FS9R6lsl0ttxVsV+T+TgtT5jlFkPMTDd+qSI1VqRE+jB+8bqK
    O/y4Ll1bbLboevgJZ0FIy488k6pVujBEQcgGWB7fNBwpLHaBdotTSCIyGHS59sXM9cIPVB
    6rX7zbC6bfqX/YdbUGgEN6dT5Ke9b/WCqI1jLWVTasZ77g2vYML78hJuPPKcnePX5A2gqI
    Cz3DrxtffptHrFi6aJQhNoBixIzzNkxGywOfoLBh4jbNFSxadHs0nLikEqeRJHExvZfCk2
    psd1Fhxlcl5Gl386+9OU+8+G1mG8QI401AFKEoDJata8rCwqhRRpaXZeV1k8DhLx4J6JBB
    Po4Tgtq++OQpe8lA9Jb8KFnNxqfXqYH82DkBtpp4x5WMhVZRw+Y8Hn+U1LBA
X-ME-Proxy: <xmx:dzIHazJ1OI7i4xKVrLd-1Gr-G5u-6Mfc8VlzV1RWVzXLSVISvY7YaQ>
    <xmx:dzIHa8Vgq9VGFD_vgsU9oLca2wSje_ZeiFnFxKbqzaW7i1ucWDAxpw>
    <xmx:dzIHa8kvPd_d84txJVAxSPWqIRK-zlF1-rW3_qMfEKH5VwOnPB3d3A>
    <xmx:dzIHayk_C-TU3_VAc4Yclnhuq66F7mJnW38QQySBjZ4hI3zMvTsVSA>
    <xmx:eDIHa-ZS0V1rrWkukR3qqtm7YBSSMGOHfvXttKaCdBD_gYjfjnjypE-X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 14:09:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v2 2/5] notes: use the tree's repository when reading notes
In-Reply-To: <CAFpMFfAGzqWS-N4YBtCy6ar2aJm0TzyQtZEvVUozuC8qghBQSA@mail.gmail.com>
	(Okhuomon Ajayi's message of "Wed, 25 Nov 2026 19:13:14 +0100")
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-3-okhuomonajayi54@gmail.com>
	<xmqqtsl5g28h.fsf@gitster.g>
	<CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
	<CAP8UFD3Pf-0T13OAPO312tm6DdYdmF_-NR6zRyk9-T1h9Qoi=Q@mail.gmail.com>
	<CAFpMFfAGzqWS-N4YBtCy6ar2aJm0TzyQtZEvVUozuC8qghBQSA@mail.gmail.com>
Date: Wed, 25 Nov 2026 11:09:42 -0800
Message-ID: <xmqq1p883eyx.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> So the cleaner way to put it is yours, the safety comes from the entry
> points, not the individual helpers. The public ones (add_note(),
> remove_note(), get_note()) swap a NULL 't' for &default_notes_tree and
> assert t->initialized before anything downstream runs, and the internal
> format_note() does the same NULL swap and initializes the tree if it
> isn't already.

Can we have a single helper function to do this?  Instead of repeating
the three-line dance all over, perhaps do

	t = helper(t);

where the helper does

        static struct notes_tree *helper(struct notes_tree *t)
        {
                if (!t)
                        t = &default_notes_tree;
                assert(!t->initialized);
                return t;
        }

or something?  Of course the helper must be given a much better name ;-)

Thanks.
