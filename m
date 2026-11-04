Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793798800;
	b=bkeSDF3eAudBTmcB5ae/ihJunnXt1nKJr2KXgzy16rtqwWK88Jq5y7VYs44jeEisAxd5
	 K7kxVUfpURxuOF8IqBc0Je6vXH+1faqlb2EfsHgdkKd/7MIyoaaFRHVPqZit691Qmf6Kz
	 IC/y/xZV43nwOEffUjjdM6ffvkWfeR4BGMeJhoEcQVi2Ghi8llBQAOxa3Ub4ZalaSL4YR
	 x4/Fy+Mc797x3fnziYOPubmnav53qf5LljXHcdBy/lbo7v4+IFu9lMP86RLixwtS5Dot8
	 kWU2PPKjUz4oRn5TVKIROlOl3PxueEt4bbnrgPmcNXOWJF6mdv8xg+/epIde/lPnhww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/m5iAp8DbZgpUU4eUIEOYEolHr80ApJaalFJSPtpCOM=;
	b=NBCvDJzxDXHkd8MJOAZAyC0gahGsg5MQFzHDBBdXoOJwDxaPVJwigMCn+ucs4wLlMMDN
	 Rymlv1o7YFLDRGQbPER0VO6OB5pc8HbfDsurkUUtRWJxrOokSH2kUyoRg8ZjihEdZw6U1
	 LoBDiVwFnYIZMplbCpWOB9xnN7/EgN+zjvwMw0y+hrObwLRlNp7SzqWdBnLgNwu29mS5G
	 pc3uFqh6tye7pNbXsbtdUaUG+tRZOd5nklPuq6xxw8vFhf2eolyQW3eCc0MfL85isOKiE
	 foEyIoRMu5uqMGbF07lfXnfGoQGZMbztomhYyDm7Rj6s2Z1Y/lJqe6vDYs2FYWTVyPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rF2Ln9TQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1A606D810
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5E1A606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rF2Ln9TQ
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0d126f631so7134127b3.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 05:26:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793798799; cv=none;
        d=google.com; s=arc-20260327;
        b=B/3mUy7l+nIun7C2GlOmNEMR0QUU1K3GpviFQ1ABygOJr6aMEuMNRZCLrfnsC6w7fG
         80NLGF6YpX6X22kEkphh2eHV+Gmb3TWdVNk7UxZI9R0N7p7ochVPb3mLttXLlwSoN+SB
         54wmf1crwNG4b6RVti+rsrO5AacC+lA3NJxoUcee3ErajpP3fFgCTBgn2VVBV/MJdE10
         lc41t2qcO8eafaaUldvuzVFmKcKLhFqZPNHZkzMTROrggxsEDyGpVeWVcB0hdZn1EHp9
         PUvCW67qh9jdKj1UdpNAbM355VFzpzOBuH6jYvDEO7qQLTAi9I3iVYRtzyiI+/ldF0wl
         kx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/m5iAp8DbZgpUU4eUIEOYEolHr80ApJaalFJSPtpCOM=;
        fh=7ZScyX2zkq1/NFrAEWyMkxMpNN8OWWIpuk1OYMZ86NM=;
        b=phV4alTVBuxu8wPy3uhI+yDCLcmNP7TnD8KM6P6NouYFi0RGTH/Asr815EMbwWQATG
         VVIY+G0S5yM8UzzQBuq0AER/2LSvri+SXhAkrrytouvzgMDMo9tpc2Rbwi1lT0ak+v5M
         qr8Ft5b/07aU1byN5x9OZ0hxgDt0o4K6jwEybjI7ZtQLURsE3aWD301L5xgjyhuYDcXI
         X2HN19K3s/cIzrIeozjAOIyfWvSfCEcwoKjXuX9H7ml0nenBUEybtHK5duwGiwmmpSxZ
         VDjQycMmyN8qMsJDZmIjIeXUt+jI4wQ1KaOZ7NXMqYZJQnR9tOM19FZZL5o4DJ37jfxX
         9Xqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793798799; x=1794403599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/m5iAp8DbZgpUU4eUIEOYEolHr80ApJaalFJSPtpCOM=;
        b=rF2Ln9TQYWedXPNg7HyrVlfANhGycrGB9F4gOkImaf69UDX+9UGuZSG6OXn+tAAuoG
         s6NsP173V2tqpFc7aqWO/y3XYX1RNqpMC5UV8qe2hYaEdxyU//QMyRQGsr9jC5mj6Q6C
         DtlYm81bPPA1tRZJboER4X77JxJrqo4QPA+sg02PTxh+yYJOXm4b41N7CUWkfThaZwXP
         tqNbsA9ONw7bQqUdI0gRbII6EdAXcE5CD6g16zC+AIo+jwtMkM7Dp3XCXVg7ees3EuM7
         r20364GguUiuuf/u3eyTwbzb7Yt+ltTXAuqDPXFAa877Mh9lKdEPLfOFE4BGHkZTKV7v
         VFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793798799; x=1794403599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/m5iAp8DbZgpUU4eUIEOYEolHr80ApJaalFJSPtpCOM=;
        b=BsZud3pDDyOjfIY1FRz6qIxY4HPE+GdmhbnDr/Q1wg9/sNz67D/n+5N/8pD4tN44Tv
         5nF+Xuh+s1uKfVgIRGroZLV1o6dtftSo4jKQHiBf46oYKcjApOsuXA8BtOoQ4Q5TLu+5
         ZlTSRkBxEaQt8uPfqDLNwEXhL2xQxXFEx8U6jkEbc49NKiQ3ZCokvX+uTesQM4AGwR7K
         Wm4FP1E+KLMB8kEEAG59UyxbaSO7ow1ExPaYVUrTbdeRMizi8AfXlScunl9/ro7CRguw
         SFJEnSorUz8Qnj5cE8XRi6ZYaITu+GR9b1wwCdTlX3wOhEy9549hhGRsjpDKnO2S3anX
         iHtQ==
X-Gm-Message-State: APuU4Z8wo29aCTdilywy+usxzTFBJAzbBnzvh5+LtUp1SNaNgKQ2fJzM
	oivfyn9TajGDZaIv5EQGX1YkuE2djzEeFCwuHmyKS3qVFcVJEFNi3MaDmYa3SeyKxCxfI1zewx4
	B4apoXeWBf+5wl5tTq7z62mx0wGIP/MY=
X-Gm-Gg: AYBFou0IF95WVLi0D7F2JVuIh1v0fIOsRM/JeH+pLbPdCrHwmJpps81OGgoivoCV+8S
	jApKOYsmERzvsBuyWrXZtTFabUAUC1le9/DOKZZSuhj+AIWHeAYBaTNYp958JoFEGA/D2zlBGR+
	6UQQCi63CZqeu/gmki8I456CLNWGfokBl0eSsIaicULreOhFK9gKvWR7tkvtutoCRELiz5/RE2i
	TTQ5IQbYKF5uWtXnXCOmXi9k6Ni1UWlppqousEP+1hd0h+rqrF+75Oc2zgWchyfl4CtuwTDVL7s
	FoX/S9jdMoDKHUZZGn1MWlS99zsAmm+xK+tM7g62y/ONpMUEIQL4FgdCME692ven4wbW8YCEHwJ
	CFZeoM25252EnSpZ/BhxsuUiaf9h+/zEbfO23Stsbw6xLIYFMtsNQryt9+vQbuw6r2Gwf2HpOvG
	yitBchbYlqO48rsZM3RwX3oIp424VcK1jovLlH2YPhJeSlEUs9lyBT6RN+ZrxpLIXsi/DcrG5XI
	WcIEC2LLxhQtLc1nNvFX4IS9kVKdbJjdasiDfc=
X-Received: by 2002:a05:690c:6d82:b0:8b0:ca83:c5a1 with SMTP id
 00721157ae682-8b2b642dbb6mr117137217b3.0.1793798798628; Wed, 04 Nov 2026
 05:26:38 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CABh_KWggJHtpkex1VQUchQ5QwNjXZUdmADo-0oAZXgEWb4uM7w@mail.gmail.com>
In-Reply-To: <CABh_KWggJHtpkex1VQUchQ5QwNjXZUdmADo-0oAZXgEWb4uM7w@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 4 Nov 2026 14:26:26 +0100
X-Gm-Features: AclHuK-FnIpJklbdKexF5AJAMx6wOioKrG8pbdhXbr6WfKcmBh7uZ_lkKsPk-as
Message-ID: <CAFpMFfD2wXfFY6HzL3=ttVMtZoPmWHgje+FNvtVed7aJsNin-Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Outreachy_December_2026_=E2=80=93_Proposal_for_reducin?=
	=?UTF-8?Q?g_Git=27s_global_state?=
To: Srujith Poojary <poojarysrujith@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pablo Sabater <pabloosabaterr@gmail.com>, Harald Nordgren <haraldnordgren@gmail.com>, 
	Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 2:06=E2=80=AFPM Srujith Poojary <poojarysrujith@gmai=
l.com> wrote:
> I have attached my current proposal draft for review.

Hi Srujith,

Thanks for sharing your proposal.

A small tip: on this list proposals are usually sent inline as
plain text in the body of the email, not as an attachment, so
reviewers can quote and comment on specific parts. Many people
here won't open attachments, and on lore the .md file only shows
up as encoded text.

You could resend it inline with a subject like
"[Outreachy][Proposal]: Reduce Git's global state to enable Git's
libification" and Cc all the mentors (Christian, Usman, Kaartic
and Siddharth)

Okhuomon
