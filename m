Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765927;
	b=cbkMq2aK6wSTiKBv9skG8ssXU7jdmnuH5UFcteU7L3jJyOgthDcCk7l0kd/mf5W54STz
	 1fv2z7v5a8bto8Us6E0TIYWl08iK1ozG9AHZuhnBhUJ2ABfkDCi2rLJBNbdPk8WYYMKnU
	 RKKYHVYofgkp6H3AzGZbckJslrPme2LFU86NEniN93USQDUZjW6I8yQkHHjRH9mJE3TTG
	 xUF5639bFqbZxNR9pGOoWI9vXDd+Z9ERhqouEMXpHOt+V4lWdi7faCQgPSRqTTYCpuHyT
	 uuqmafU+GYwWk1ei7nM5p4PdGyWzvnCvW+reh7zKd8HWQ+/Ba7nMzOg7aZgevdjMZfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765927;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=4AW8+XPhC+HYGcpJMdXnHFRSYTpOxo4K3frILUqzahw=;
	b=ba4dL6WNcDZ5uajziOjZCHDlyKhX1x5Iszirxsu0nbqlLAVBHrF/EcwkYEKUaP0iN4EP
	 jMlR1zvTECErRQ51W4QcdKbWKNQMGw3Gro0G8IOt986wub0S3j+yJclLE5AfE+4AJVmME
	 +jssWLJtd7Io3liEf6l8d/KwiovgEExCoXqdV2ZVZBtJRITPPDZvCTh7WMMZCeMwBpy82
	 05SX3lY0Z6gTWTLKHHdFBAg/apMVzpcL6NimzNvwzJTVqPVVDW9EX3XfNDVYIqVOjcpG7
	 0qh0ioZDMpkvc1sUAyHrwaSf9BE05GaISbzD6xl8dzD07S1QBmJUTbnDsZk8HZ718iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=RKKNaoiW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fe4XUjwK;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71509606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71509606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=RKKNaoiW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fe4XUjwK
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 834D81D000F1
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:32:06 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 23 Oct 2026 10:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792765923;
	 x=1792852323; bh=4AW8+XPhC+HYGcpJMdXnHFRSYTpOxo4K3frILUqzahw=; b=
	RKKNaoiWcrLUnWbEETmRHvQTTmMyjLhj/Hp6w/X2WNoHaBmZ/LwAeJJTmp+avPbe
	VL/D3unfd2iMv0CWyP+KQaUyMxYtw4i3jcpsE7TF+QY8C/9ETCG7a1kY3hDJKKDB
	BBlA4dG/MLJgCxUYn0SECUUoJ8OpBjSQ2VfPawHKJT8+hrGcPu5mrOFN25PjqTQJ
	D66PpqN3N5OHHdk89RfPL0skbnvinBjMippkItO56eIKa4j1mIXjDe0x5LYudpMV
	Ey6vJNnJLYIv1yLZ3728hTLmCX5ucXU4WLFHVP0fqLTwxYS1krodJ/ug+fZjEYZ+
	3x1A7gyU6tJJTRZxNo0JvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792765923; x=
	1792852323; bh=4AW8+XPhC+HYGcpJMdXnHFRSYTpOxo4K3frILUqzahw=; b=F
	e4XUjwK+ZkE44RAYA0bL5Ky4k+tzT/ukShPWq5Uw8oHWQ+L6MSQcPqU90Xls+t/e
	VBvVn71L1C335KJsv/xlrpJzU+AfKh4Mrcv/YNfZ4WuI5KaQcXnroDGmP7DZNNDb
	jb6wiPtD6j4r01m7yIBOG4cQuOgxQBPRw2wjUgvfCcvKAe8F3hEhdJuVhn/4vDr4
	AikUiihkV3TrrXvhGWgo0E7pPRgglT+S23oLCE2fVIeHlUog1oXo/eWS26L+Xr+L
	5Ra8BPsLIVX4NHuyaxCEsTwXBnHrqizhJUFgK+7Ipc3VosRtWg1hKZ8PThj4ytOF
	l1peU5Kh/bM+vbu80+Uog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792765923; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:is9xLdPfHIyfK9nt8oA9BJEmGahJPVtRKJGknl2yGVs5V14
	jm7m1D3A5x4qJAPcFIzQl8fLu/GxqdPA2Ig+ynmLqJeU6hIzEIefJbGVCAgOD0Zh
	7PTZQ7kdbREEDBA6kHHHRhGF0P+U3yaCFbt3rCL9iBm40/68Mkgc5UembsBvyZr4
	JXRjWJFEkm0ULOBd6WNO++WDHU/cZir0ReKWYSkRYDv1sMbiS/EkDS+V+ED2sznl
	gJmPwz9jbwsKZFy0A7cgpLCpwwszdL7iPbpmmZL95/CvtFHFDOBYV7kmi0BESGHL
	c/FKS/YTZjylOhh9DTIXPiErFTM/+/iaE0FSUEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dkRsx6VtE0kzqYKOhz+kdA4s6wan4X4NQW/0aEzBIVA=:PQReW/Vl4NhFHhXoCl6o+9+Tl0dhjq/Km0vME35xn64=;
X-ME-Sender: <xms:4W_bakHL7ec-e4oMeyZ3h5EeosZTN2Gi-4oYs6tLJUuvSh0yadTkFl4>
    <xme:4W_baoLEVv4MvHRrJKo79GtpXrnXMzyZ4wCHDqOlr3-XnvscfT34OnPGFZuQwo5Mb
    jCbOJzbGp2370mdz-C6z6oYk0h_tAovIqEtVroxlsJRnJWN65J0mSk>
X-ME-Proxy-Cause: dmFkZTG3Ic1QWZfOsEO8OaHW5qlZM8AZXrX0u89iivcrmRtpFN+CnCWS7h+RLiO8LNWGg8
    8HaVqb/z2xz5dI46LH9qwTxgL1PRCQWFkptQ8i6u+A55Ra/3QryxgQRi9BpEgsAFbnYjuN
    L01L+HRoB32ARERR5X7FSoSR+P3d0D3xwrKJUdOfC6pusw+4YlpYKoESdTstEMC+gqYf0D
    vssXGazme+EvDs00SoREIZWUQQ2vdGrt6e9G8Q8m/YV46HZNApjg9Khpk6xjuo2hls5Kwx
    yh/X7dCFYKJZ9Cf/oABKANaobhM98D+qMn9SNLPRov/7+Ire3oarZAdioWXYY6aH0LaeHD
    umcdyQp3Kihtd9xSQ3iyR74XGTWD94CgH0yHiY4LC0W+Sw8x+AiyAv8aeQePWmdZ5llOLq
    vn3+5VWnWxchi3awZ5/ob8gzrzy1SqnHan+P63ujtnAn3UN+rn2M+phZswgtA6BZ7x2M4f
    7w0GCZwYWS2ah1MoGrfFBAGGFaJd5usvtGRVU72egmuNMEeD7IIud3wp/uQVbEcB5tP1py
    91ps6ssWwe0Z+QnB8Sn5LDhlhONMTFckkKrysQqSQ+LSFdvhkfghjoCAjni0EjFw3U0jb9
    2k1word0vPINIGCDnz445A88rmC8N3IAOR0489Fv2LIrr1Dd1+E3ltHjJwVg
X-ME-Proxy: <xmx:42_baltLtXW8HKpSWoTQMNLAh2tDV4_o8ZbfzXS1F0DWhBw9lxf8Sw>
    <xmx:42_basTl6DoFjOT0AOFw7Uv3eLha7ECwFehv8Spw06f8EnG_vbMS5g>
    <xmx:42_bajMiiclKJZ8hl8-HbpztDoLPVcs6JVrDq-Y6Mm9N8dtlcvDy_g>
    <xmx:42_bapavtxNoEstDmusLixfJ-Hxr80OGffdX6ptbrxnrJwsOc5BeOQ>
    <xmx:42_batsLzUlDaCLq2uai6ZaD_qZLulDXhcZXBTVobCJlKYK9A3cpraNy>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D119D22C009D; Fri, 23 Oct 2026 10:32:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AGAb6ilPifF3
Date: Fri, 23 Oct 2026 16:31:41 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "Emily Shaffer" <nasamuffin@google.com>, git@vger.kernel.org
Message-Id: <e7088e2a-195d-4c34-85b9-5e09d6f98aff@app.fastmail.com>
In-Reply-To: <xmqq4iedc99a.fsf@gitster.g>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> <xmqq4iedc99a.fsf@gitster.g>
Subject: Re: [PATCH] Documentation: propose community voting process
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026, at 06:48, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>>[snip]
>> I also think it would be sensible to restrict eligibility to the curr=
ent
>> set of active contributors, who will have to live with the consequenc=
es
>> of the decision, by requiring eligible contributions to have been made
>> in the previous two years. I have historic contributions in a couple =
of
>> projects that I'm not active in anymore and I would not expect to be
>> able to influence an decisions those projects make now.
>
> But do you care about these past projects enough to (1) notice that
> they are having a policy discussion, (2) bother visiting them again
> to learn their current voting procedures, and (3) actually cast a
> vote to help improve them?  You may not have been active recently,
> but if you care enough, and if your past knowledge of how the
> project works still applies, wouldn't the project participants
> appreciate your input?
>

I see the concern wrt. dogpiling from non-active contributors,[1] but it
seems very impractical. A dogpile (this was the word used so I=E2=80=99l=
l just
stick to it) a la GitHub issues means that someone links to a GitHub
issue (which is open to all) and many, many outsiders comment on the
issue. For example. But imagine this happening via social media. All of
the people ready to dogpile would also need to have contributed in the
past. How could you get a flood of such a filtered set?

Imagine vote whipping former Git contributors who have scratched an
itch, fixed a bug, or fixed three typos, 5=E2=80=9320 years ago, to get =
them
all to vote for or against something. Okay, again no one made this
argument.[1] But this is to illustrate that the worst-case dogpiling
(or vote whipping) is not feasible.

=E2=80=A0 1: This is not to say that anyone in particular had this conce=
rn. But
     I could imagine it.

>[snip]
