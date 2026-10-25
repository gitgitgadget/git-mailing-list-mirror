Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954399;
	b=fCLQ0L4FHXLihMaewA1hJ4Ulxrzvb9wrTTJIcqm6WFe3hIodWeTMRAhGJBejnguqCufm
	 mR+Xn/z5sTy/h1Bkdcj8BfOroZTugfMcO4yTXj7ONeQJCYLRlC/iOoZKeKEtX1DqAZfE1
	 k9Diwhb47cJ2+rOy6k5pwu5xT1Rj+W14Ml7+s+h0uP2qUdST3xJ1V6kfR/zcGBsk4wJ91
	 uD+ObEqx5adjxe4Bic8p3Db7UBTR7Iem90hSLRqmpMiC5cNhbkCN9Juatra2E0VcKv7G0
	 c8+xWLdG2iMZuPjifjMzDPAdtzh4biCHaIWxscvvKxRURlANSU3PKJI0deAU+M649nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954399;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=3Yrxl5vmZqU/CxHaGfD2rroOo2RlSNTIjbeO0091LjU=;
	b=1Cdq6mZkYT9MOyu+fmdvO6Pf0R+CDGF3LF+gZ42zAVqHzzxY7SaGpIMWnyiO1hdPjYzt
	 sEeWSlud5OD4JQo9uRm7EV7xettfiM+gkT82DXfmNqhyhxVBYUhS1o/PWfHXJJQKKDyQe
	 5FLegB7D2Wf2zCxVyXIZhMlqJWIPOFMMQlqZ+f6WDb0wxxeTeJkCVuMCATVmOtMNrRbTM
	 dNk1xW6FNZFMACukWx+DbyVXebX1c5JACfopbisVkt3L7wj0RgO733nkTeVvBaqIj+OFV
	 Ob1wUfRvdsJxs/qzFWsTy5vvHGkIo0LaNnS53eS0Wb3CcFSyedFDtRA3hRAxLzjiY7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=u4z3hw9y;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=X6pUXXI1;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C8606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 18:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=u4z3hw9y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=X6pUXXI1
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 506387A0055
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 14:53:17 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 25 Oct 2026 14:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792954393;
	 x=1793040793; bh=3Yrxl5vmZqU/CxHaGfD2rroOo2RlSNTIjbeO0091LjU=; b=
	u4z3hw9yLddZNx9bYoaY8MjnnyHhrqlsac9dR63oVscsDUGopCNxPU9HuGYQgJQj
	c90ytc5m1TVlznYAWYk02tig/9oLpYbX301lvayci5MZpIFWflwda/1i9qnEPQZB
	DIICUGaboAHcGidBwSghXOFg57jHO9s8NbsrMPaXHJl/3AUH2SR2ALJbpVF2IQ3y
	gEXcfHoI+H8ZU7IFv5QAOnxTp/cEXoMwjX57Z2ALKvKHcEtAssepmedKEfgitKDC
	w+yQV0uifYWTV1sFMDWESwdJ9INFbbiOfWdLBRl+hCfOJrYae+EkkrUHwkDKe7Sn
	N0ah+jCaRwQSjCbm4sLmRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792954393; x=
	1793040793; bh=3Yrxl5vmZqU/CxHaGfD2rroOo2RlSNTIjbeO0091LjU=; b=X
	6pUXXI1N7nJgG6dbS0hmjD2ZhLkk4lEfB+wFxghDgOdorgf+97VjJZy7FhxDPdPr
	s9sWeG64WIHm8AkhruYOzsPO5YY2r1wnBFjlAZ8LkIbhGai0p/pdXJy49jKVVsd7
	Pmk99lOHPOKTIQfYn1U4fh4vc+JpfIN7lcCCjrvf9n3U1/txkrZRguHMErKjycfL
	tpMGwcK3QlT3nvPOIiz6X7nJasywJ6iGc0LuxOlewUiCjn45nvXhX8C+a5mPoo47
	ESR+XjaPhQcrm+/fSvxTFCPm4Gw3MAXgjNwq+xKWGKVxf5ralRTBgV98flyMTAQf
	BBIjiHeaN6fkWj5qg+ssQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792954393; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NgDNtkUVoCWUbyItydtvjwCl9/Gq5+gC++HyJfoJpftISAn
	7V4iVrz5tKN08y6Y9f4nILBj565U5/7AwUuAKY6cYpr03AQnr0g+IlhXiv+q0FVX
	cXIVzW8rSwl8ViEB3E1IvtFViq/YMhXxZL2uVYw9dWUGA9svWbzX2tIFQM8DM4dn
	JCdj7Ow9aJ5ytmSu4A1jxj9IiGUxltoNANUW3MA4NqAIEkKLsP+BvgJ7lbkwp6D1
	ioVrK8FiijP4BulqO0kQieAcvHuOmQYEFgTqUkI7t87tHdYU3uWMVc1EeOdM+1xS
	YKFOkzagxjCGAAJzCQQlr8xGEkpFZX6evZeNksw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:I043A1RQwZc3rg+arMCoNrm0HTrMDZUlcAV3xZZP5m8=:ALqZZcDXfx2N97HTdeHV0s1m+GNwUBwfWlPYyh8fTLA=;
X-ME-Sender: <xms:FlDearcwTupy4bwBKEv7UXXj0EM0GJXGtP4sSPRNA2TrMgQfPADQejg>
    <xme:FlDeasD7UXlxXOKcpnb-79m97MYJUQtSj1AQcnpRll589bw1qoCELHaKaIzJwbqM3
    zouHs8pnTSrivYSwZW-tijpkB9CZG0_2ljdnil78EdxzA6hFlQPWZM>
X-ME-Proxy-Cause: dmFkZTENj8DhEyqYrko0FdZLG2/i7EZJ9539sPXy0KZKE0WQhBfHwPcsW/7LXfF7tg9swf
    aL8KaxkOAKsMy+M/j+RGgahBa3EwlFDfD83B4bw+7BCTN+ATql4HY2ahdflHYe4ht/1LMc
    5aIjwiwZR5EX0RDr8Psnhq2Z/m1szKOdHpGXmr+/bw2HkxJzEH4iPt30TlSOUSzOGA/u+y
    fhUkeMAjNigvt3ZjKeSt1d0/l5bhGu5wv18mWPyzEZpuD/dcYD8wEV/zifijMfbkMrz8zB
    SmKUr3lSyrta/PgcqTUHsDKB7BpLCo9qiyfBPYqUeiZjUYHP80N1a/+c+zICETyVu2n8h2
    TiiXKfIDmMSg1bOzVHD/ZOAHCnXTOwwVBNZpycMPxiWikmwkTTi+Jf1OIxEA97lwUn3QPr
    FryxMQqB1yqSF4hoDAD5R0SBCTLgz5vxvCtH/HE5qba7IPEzgTviwz9DtfnM5cZRMDZDGM
    ojslBoS5lIyuLyw4ZBeS9nD8BOPHJxAXyL0zV922mTZhJUsGJbSE9MXAX9BtZ4tjqTMW8D
    K6Ee+YtFyjNcum1u3osU02crX6AhUNQYCoAzg1wWOv/zQh1US2H7qHZp9ZvYw1T3epop5x
    WQVtoxipsxUxZt5AtUa+HgYpCUAHMxV2l6QehxnvU2eKXmtTZyqsiKZlcrtQ
X-ME-Proxy: <xmx:F1DeatKs8yBglCimlf3_OR5Yil02OvVksXRGleuRTdYnk8KmnxWiNg>
    <xmx:F1DeaiexikYrzdZnAygiFHzefutA8WnoSKDExUjQpfvefGbWXZidxQ>
    <xmx:F1Deas9GoCyz63iVospIs_-8JVEoAzWQg8Q9PyskLF0LzteHUgETgw>
    <xmx:F1Deavo-4Ff3VdWdOF7HVAxRISzldLv-veXziCJq0Zd9iaAh_MT2QA>
    <xmx:GVDeajS84YsDroldyLuYMBG0qpxhxjka_BYDu6OzMsmkfNfjDm4vd26_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0702D22C009C; Sun, 25 Oct 2026 14:53:10 -0400 (EDT)
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
X-ThreadId: AgdWeLtCs7o3
Date: Sun, 25 Oct 2026 19:52:49 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, GGG <gitgitgadget@gmail.com>
Message-Id: <fc4d4a00-bc3a-4e1a-939c-f3a68fd8ce08@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnVJ618QXq99M=XNm19eEObQC-DTLcpeYOiizzSu_YNEpw@mail.gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
 <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com> <xmqq5wyr128q.fsf@gitster.g>
 <CAHwyqnVJ618QXq99M=XNm19eEObQC-DTLcpeYOiizzSu_YNEpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026, at 20:46, Harald Nordgren wrote:
> On Sat, Oct 24, 2026 at 6:40=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
>>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>> > I'm rather skeptical of this in its current form. Not all commands =
that
>> > modify the working tree update the reflog and some commands such as=
 "git
>> > cherry-pick A B C" create multiple reflog entires that are
>> > indistinguishable from multiple invocations of a single command.
>>
>>[snip]
>>
>> By the way, I too was annoyed that 'git reflog' defaults to the log
>> of HEAD a long time ago, but the irritation soon waned once I made
>> it a habit to always provide @{now} or @{0} to the command, as that
>> notation refers to the current branch.
>
> Thanks Phillip, Ben and Junio for pointing this out!
>
> I didn't realize that reflog could be changed to operate only on one
> branch. And it makes it a lot better! Seems like it should be the
> default, and I don't think a lot of people would complain, I'll
> certainly never run the old reflog again.

Well. I wrote in this thread:

> That you rebase many commits and then the reset points (where each one
> started and ended) get obscured in the reflog is classic for me. And I
> think many have had the same issue.

But now I wonder if that was just an illusion:

    $ # The rebase was for five commits
    $ git reflog --no-decorate test-branch
    0e77d8619b8 test-branch@{0}: rebase (finish): refs/heads/test-branch=
 onto 7e34d8174dcda3435d1404c9a30bef46afe6c13e
    d1bcad06e24 test-branch@{1}: branch: Created from HEAD

I have always known about per-branch reflogs and that `HEAD` has its
own, but maybe I was too much in the habit of running without the branch
name after rebases?

So maybe my use case was fine all along. But that still leaves
Patrick=E2=80=99s[1] problems with it.

[1] https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/

>
> However, the format is quite heavy with the full name references,
> seems like they could be cleaned up:
>
>[snip]
