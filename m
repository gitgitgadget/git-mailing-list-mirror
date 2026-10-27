Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125904;
	b=4N8+lswVpyjh7bimRKpiUD3Wo8jeyroqxVfYG1FyNApjMud1XsvdEG3jAoGo9VAChOSu
	 3Ary6ndupnKGVhmowBFsRyWrom+EWxbpa7hPi6Rl1AlXPnlC05xx9i51bS0RnjVF38PkT
	 iE7FM7ggSzdTta6IvlWCRFWudYykfW+tzEI5rIjkp/UU+Ju8CMoQ+y9Q7iiMPMmP/aNoJ
	 nxkDlkaJ+xqJGH8+h0CqYkrOjBBuPxRbdt4C4k06YB1Iyc+AAgqJ3G6KO1/1YuWX6mgsI
	 gWVMj4rVt09/zhGUECWZKt7OQsCPEkZJWxABEf8BFGk949SLoQfv1D027xmzX/J4sBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125904;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=ReVWxMQUL2NgFEvl5l4Tbh2kNYJZFVerS7jV5RcB2g4=;
	b=gTdD8RZiNClk6DijnQxk96kN2rMC79ptMo9BqpfLBuifWZfvDkn/bxJzqeibZfBCmM84
	 Pw2Ux1dVLT2hYHe+QgEXvgSz43ZdhRI/2yqoz9HzsqZVA0CmSnEzXZAXdiHs4Cq3ila8C
	 0CaJfPSW93vkThjX3EZM/HAhxgKI8lmAB4TuLM649f7mLBubMtepEpB3t5oohpNXvjlIq
	 Z31/RDpkz+G3TjSBwipH3SBTYSpy7QmIcKsicA8gcFCzJO80zOaGkQLaQg1UlsGc2cswk
	 s/ciP3bHKHPsNkN5IydErhhzAo59h2NRi1F3j1NnbrdbjXCsZ+i6HHc8Qni761He1yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=Vd8pPwK1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AMU6IHd3;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84E606A338
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E84E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=Vd8pPwK1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AMU6IHd3
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DE96140008A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:31:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 14:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793125902;
	 x=1793212302; bh=ReVWxMQUL2NgFEvl5l4Tbh2kNYJZFVerS7jV5RcB2g4=; b=
	Vd8pPwK1ZdA1c2L5toVdvFcyloXK8jfLW9fBdou0YpaUId/GAs9PjiyPEfw4TEzj
	Atp/IY2WhIdhOKpgHwxdyTnsZ63uRyL1zpBYmYEz7EI2ydUJIXFR+0RBK7P2TkSk
	LOHDImwKyX13k5K1tQubWOFXS7710tEIYKpfuJ6jxFz8Izy4C1ndqCdbxxwJ3KVb
	tobrLp9S3Hcjg9KmQlS1bsj9bfS7pvf8I4B36Dy8hoiUu26LjqtiisK6QxdIAKik
	7G+6vkiKM+5m7ExanTHQDJjQyp0YmiEQWVZMwX2x1R/bm8P7wSyOekmfBUyJRAXg
	TqRBvrpltMD0LWqVxjI9rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793125902; x=
	1793212302; bh=ReVWxMQUL2NgFEvl5l4Tbh2kNYJZFVerS7jV5RcB2g4=; b=A
	MU6IHd3pRCaxs7l6JUO+zobp+tkumBFH/iMh8DNl3YA3jxh7NlBrsitdEEP5wBTp
	HWKLPY1pBjQyT9UjHp4pFBDP3nOm0xQltTM/PfsXiYd1nKOuDPXl2qjBwqn4wt6a
	/sd/XDvE5+ERv8MxfPKyNHM/IJk4sg5BCqzdwsQP0w1L5qEaGq6aZHRrJMNlD9Fz
	hGvediNa34Ltn7tF6OFIXWmiNDSDN3PirRgLklD+dYuDAHsRK3M5xEwR7/gec2u8
	OepstNI+S5r6A9nJ1nptOKBvhGMHwxsTnPH3KOAHm8pZAfd1iWh+rCaunwsHYHyQ
	wriclxTgnr4lqNSZellGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793125902; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:W1mG7oAMvrKlCNNDWi4AXK6mBhO0aRN0OrnQ4dL8h3CpIdW
	URBxJ0m3AkHmmSr8w/YjA7Sh3G4wgFlvlu4zGchrSi1RrjCtXGUJfcqalUidMgRt
	bXAA/m5DZSHq6k0Kf4qlBYVdXBJNdc/VQoB8+NaS/pf8AcInqPOripOp5U50mIld
	AOn0xXpBXJIgx3tyuxyawc6t6qRSbsCY+g5EhL6iOT7RUIP+u2rd/BoRoKz8+ZYC
	SzREdi0AAYEE27GSdgwBv0WLNpMX4ErLAW7x/vLCsgdCsjw46p0K4iL+PIC0xViW
	nZLpck+7ekSbNWJhZM8SMfmIKG8AOjDo3q7JPCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:N5sRKxxMbFxjAfWKUytBoM6BB9KdWnl6of548y/fGCU=:NXt+yq3gPbO5gwgulGAtTzsOtI1XgKw9fxhLbTpYVr4=;
X-ME-Sender: <xms:Du7gam_57i_I29iWp6T9_3sIMZnY2pnGqcxo_7gWKJTbswX2HYLHQQ>
    <xme:Du7gatuuXLT8txsgqL3-8OaoM4raZo55w_BiuuM7TxP-d63XsG4yctQ2eKlyJ0CGD
    LaBLICxVK_yz8_B4ZPKcg-PqimlkN4ZJr6qjYGdjbVub-E38e1AqVI6MQ>
X-ME-Received: <xmr:Du7gahBDXZr1DbK53eqJTwdXI0RZr7mRVSM6MDcEJJjbmnIR6bBKjuk2BRpuI0nF2zY1pachbd1GWOSaDD4apGKqsgYW-tx3JrdUA98-HFhcz2I>
X-ME-Proxy-Cause: dmFkZTEdB9QyX6coDYD9Rjf1Gle/FTIXyGPf+6IPvXy0RpeQXZ2z7fgHjCHZkNO5MKIQZS
    W0jsRbnkUgxiKiIFuJ2sRfshcO8P6lkwslvknqRxExK0ZmMT9Ie7ikQs4pIfcOF/mkxJCD
    o7IMpU7PuuAIkZcd84uVA2GyZLpNCyCg8wQJgZTsJNsHRDvYBM5WTlepTlAGEZS5GiJXEm
    8+uUu+vJI1aBnDWD++h8H+pL9TsCSn9gxTNTaNfCZuLot37OGvVT2mfSn8Ck0I0LkeT9P9
    Mwy+zM05Ll7/uLySKDMOpV6zZcsaSqjv9uoVGsMDsdUIv9sa6gjs6gsMMajnK9S17p/+U4
    OiUprdk8vh33LOA2H3jV8DrZGJYDhTW+coVfGa+1EjI6Foq7Nl5oPbetXKK4CamII0tGZ2
    vhWEiSIHeLuvoaI475m/gsddJJ5EWo3gw4/kALBQ/pQoRLFC2qiHkymcjLFBMN6h/lvz2m
    r+yp3tLFHOqOO9rb441uHPNWofKodofO7T9cUb+YF8BgbSyRf712o7e4SqFm30yHSWVctc
    0YyaIkbE/UmwT5LmQrUJ9EBryjhAqGKlH+HHRsiADiLNuhCRwH1Acc0XVcBQRXpmkAePaG
    6KQaao5IR2Gr1Htnef+7Ja7anHArSW2vshgqwbMPQirrKhEpLMcECQo/teJA
X-ME-Proxy: <xmx:Du7gatX71Q9lH0qHrEFTz3X27dY9KjIBiom-VSczck-fsDI_i-wPKQ>
    <xmx:Du7ganDN-okYRkH1NonhCJh_WhziWLIdVISSqfp6iTrvcqugxAf8kQ>
    <xmx:Du7gao9mMuYapKtXjONyuUtTMhy-3gx4GzTdMa2aHUXaBj3Lt9xz5g>
    <xmx:Du7gamE4WWGPFVjvgwml7DJzbqDDsl_aTEkL4YlIR1gxxoCJ_hJpVg>
    <xmx:Du7gajf6fwbw34mdzX7H45-gqLZ8g2FKsCg3z0NOQ_ZIzi7xkdxIimI1>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 14:31:41 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v3 0/2] doc: add new git tutorial
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <A48F72E1-8686-453E-91EC-674BD92CA1E5@gmail.com>
Date: Tue, 27 Oct 2026 14:31:31 -0400
Cc: Julia Evans <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Tuomas Ahola <taahol@utu.fi>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEC4FB30-2262-4006-9704-693D099D41B5@jvns.ca>
References: <e7a03372-56cb-45c7-ae32-68b3c9e6bd27@app.fastmail.com>
 <A48F72E1-8686-453E-91EC-674BD92CA1E5@gmail.com>
To: Ben Knoble <ben.knoble@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Oct 27, 2026, at 11:19=E2=80=AFAM, Ben Knoble =
<ben.knoble@gmail.com> wrote:
>=20
>>=20
>> Le 27 oct. 2026 =C3=A0 10:30, Julia Evans <julia@jvns.ca> a =C3=A9crit =
:
>>=20
>> =EF=BB=BF
>>=20
>> On Fri, Oct 23, 2026, at 2:01 PM, Ben Knoble wrote:
>>>>> Le 23 oct. 2026 =C3=A0 11:17, Julia Evans via GitGitGadget =
<gitgitgadget@gmail.com> a =C3=A9crit :
>>>>=20
>>>> =EF=BB=BFSo far we've gotten 112 comments from 30ish beta testers =
who have tried to
>>>> learn Git for the first using this tutorial. Most of them were able =
to
>>>> finish it successfully. By far the most common piece of feedback =
was that
>>>> people want to learn more about collaboration and branching. I've =
written a
>>>> draft of a tutorial on branching, but this is already quite a lot =
of words
>>>> so definitely we can't cover it in this series.
>>>>=20
>>>> I don't know if it's possible to get this merged quickly, but if it =
were I
>>>> think it would be amazing since people are so eager for a tutorial =
on
>>>> branching. If we spend a huge amount of time revising this I think =
there's a
>>>> real risk I'll run out of funding before we have time to write =
about
>>>> branching. Ideally I think it would be great if we could merge a =
"good
>>>> enough" version and then have a way on the website for users to =
give
>>>> feedback on it, so that we can later incorporate that feedback and
>>>> iteratively make it better over time.
>>>>=20
>>>> Thanks to Paula, Agavi, Ken Wells, Michael / Chgowiz, Ishmaeel, and =
all 20
>>>> or so other test readers.
>>>>=20
>>>> changes in v3: (v2 was the "first" real version since v1 was a WIP)
>>>>=20
>>>> * Say that the tutorial supports any version above 2.23.0, when git =
switch
>>>> was introduced, since the next part of the tutorial on branches =
will use
>>>> git switch
>>>> * Mention that on Windows the tutorial will work best in Git Bash =
for and
>>>> it might need adapting for PowerShell. (thanks to Ben)
>>>> * Add a warning about how Git can dump you into vi, how to handle =
that
>>>> situation, and how to write a longer commit message. I tried to =
strike a
>>>> balance between lightly suggesting that it might be good to write =
longer
>>>> commit messages, while making it clear that you can just use -m"" =
if
>>>> you're not ready to navigate the world of editor configuration. I =
don't
>>>> think we can use Pro Git here though since it's a bit outdated. =
(thanks
>>>> to Ben)
>>>=20
>>> I noticed some discussion in Discord about the main text being out =
of date,
>>> but while the appendix makes copious references to editors
>>> that have fallen out of style I think it also covers common cases
>>> like VS Code and so on.

Yeah I now see that=E2=80=99s a great list, I=E2=80=99ll add a link. I =
wonder if at some point in the
future it would make sense to manage this list in Git (like with merge =
tools)
but that=E2=80=99s out of scope :)

> ;) long emails?

Yes, I really need to start using Apple Mail more consistently.
The Fastmail web UI I=E2=80=99ve been using really doesn=E2=80=99t work =
for these emails :)

>>>>   ++
>>>>   ++Warning about terminal text editors
>>>>   ++-----------------------------------
>>>>   ++
>>>>   ++If you run `git commit` without any arguments, Git will open a
>>>>   ++text editor in the terminal for you to use to edit your commit =
message.
>>>>   ++This lets you write a longer commit message with more details.
>>>>   ++By default, Git uses the `vi` text editor, which is extremely =
difficult
>>>=20
>>> Personally, I=E2=80=99d drop =C2=AB extremely =C2=BB here to avoid =
casting a judgement?
>>=20
>> The goal isn't to judge vim (I love vim!), it's to make sure people =
who aren't
>> familiar with it know that it's not a good idea to try to figure out =
how to use it
>> in the middle of a tutorial on how to use Git.
>>=20
>> It's almost impossible for me to imagine someone successfully =
learning vim
>> when they're unexpectedly put into it for the first time.
>=20
> I too love Vim, and I agree. (Well, I sort of did learn both at=20
> the same time, but I had a lot of free time as a first-semester=20
> freshman in college=E2=80=A6).=20
>=20
> Anyway, I think since the goal is not to judge, I=E2=80=99d still =
consider dropping
> =C2=AB extremely =C2=BB, but it=E2=80=99s your call!
>=20

I=E2=80=99ll think about it! Maybe we can briefly explain what it is =
about vim that makes it so
difficult (like "Some signs that you're trapped in `vi`: suddenly typing =
doesn=E2=80=99t work
anymore=E2=80=A6=E2=80=9D) and take a more =E2=80=9Cshow don=E2=80=99t =
tell=E2=80=9D approach.


>>>>   ++2. Run `git config --global core.editor YOUR_PREFERRED_EDITOR`
>>>=20
>>> This is probably ok for now. Long term I encourage folks to set
>>> EDITOR and/or VISUAL environment variables, so all
>>> programs know what to do, but shell configuration is way
>>> off-topic here :)
>>=20
>> Yeah. It also depends on whether the user is planning to use a =
terminal
>> editor at all, I think some folks will choose to use their IDE =
integration to
>> work with Git and so setting EDITOR might never become relevant in
>> that case.
>=20
> Well, if they use their IDE=E2=80=99s integrated terminal and run a =
command
> that looks at either variable=E2=80=A6 ;) Although I wonder if some =
set
> those variables in such terminals automatically?
>=20
> Regardless, I=E2=80=99ll let this one go as it=E2=80=99s off-topic as =
I said =E2=80=98:D


