Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442587;
	b=Yk3sGbjQXYIyvjJgc0NcYhlYbHLMxVPYni8ZQrRDkD2TUN+x18wuVGiT3yonshkaBRHI
	 YYb1FejLXfTpvuFW/7xa88ELDrYX2ggc5PV7JZ4YySGy486gW1Dn/NR/7dovwUZEJlbjM
	 4Hxjbw7OWQG1yAiKCHOQeqbQ9E7nZFKvCzRGHWDoTBuTgUyOW60HvKpQsl0gqtifElcdU
	 kW226YuAtEXTGHl6Msessnku2EeUYTbkoGlpMGFmu5QNeqyg9l6mOqccN1kbcU2vc/E61
	 6FMETrOH78l/wzzYorWbI3/W23xOXFyzUErelz4mam/GNUQSHzOzKYmdN7ixNVKFMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442587;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=NIiBkOM3gHIA7o2XGlBvLemNaKITrOi9U8fRtu0nW78=;
	b=c8V75cQNfE3b7BcE4BqC92RjFBDBHJosWEobzG1EBMiPdPqKSF73xW5TVdf0i//NAuaj
	 CtDBmkLzY3Djo1IrCjVowB263hKC3KEyfR8b8GPK7Kh3mqFBaUEOxs0G/Jbrbx+5VOGYv
	 B7VWqFHebcq0Abj2QHHiMCrhCO+zhCwGp8fwXchWZcDxGNJu7RL36gCMnsppnXnvv+zoT
	 7IdSrk7Lour+GB8DVEtWDfcxK/fRkGLiEhfktrxWCL/QD6364w4Q5HKiYwiYhWRueIrMM
	 IY+LXWHh6YbFwQ/DcDL8Nn+GPqMg7D3nrShGt2TxwLl/qseuoO/FdRAG9KQ/YTotSvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=ewVb2ppI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rLLZO+al;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5F606A31C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=ewVb2ppI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rLLZO+al
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 968AC14000E2
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:43:05 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 16:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792442585;
	 x=1792528985; bh=NIiBkOM3gHIA7o2XGlBvLemNaKITrOi9U8fRtu0nW78=; b=
	ewVb2ppIB/Ewfsg+8s3L/xcMOvQ7Vts/w0uAPj4BlmiSrFWrVXT7qGtv22CEza52
	Kba8wJFkA6grkSi7z7SN75A0e+33fwtpLy+tksTZ+tJDBcqmSdETyzpG8LiBDQDM
	19BynBmtf25mKElkyqQJ5ApgL7fP/HQDLVa+nLl30z5yA4ng2sAE8FGl4DFC+i0A
	m+UkCdVnyCssWmUQ8B/+DqLO5j5NrGpNQ9ecSr4TDbNKTnNJpIDX1kR1NNe9G8pI
	K7evqkd0QyWNn2gUyT8Ko29dLABCGfel/ZHUElyzqlYYBlO00RY9s5uBOEf9yC5q
	oF5Dcts+XYAT2uju+qcAxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792442585; x=
	1792528985; bh=NIiBkOM3gHIA7o2XGlBvLemNaKITrOi9U8fRtu0nW78=; b=r
	LLZO+al1htXm6RekUluAmUhMgsrpakvCFIeeucBF5u1b2cm8MFGah5XXXtaGyKNC
	f9F/VRDPkx2WToZspBsjmmzIPJxcx6ym3jGKyNttDWlqXv4oByRwVBZOPawWbUl1
	6JoKjN9hUZRffOqHjU7hrJGjoKWthUlyA4dZVQMOSZraRc417KuK0a8slaIPNV6B
	/rQYd2GLvX1JncP8k0MXq5+q8fi55V0wmuEP0KtjG+Z5NExSrz1K7p7y8eTQMKEm
	IgcG49zAdYrpuNYEpBDc6hStxMmT/unI/8pbC1kz3bkQXoLUhNgEUBoudt9BpeHU
	MgF4gfcepXaPdN8l7wPUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792442585; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hPluOPK7HcFw4W7nW4FCe3ewxTuIu3YJBfo+FFtMjKBi4I7
	Nau4+Jr0CjcoIb2NqRrc+fw/IryIHk8z8hMzpJ7x0tIMRBKhMuWB2FEV1FYl4+Ig
	Ape7sL2b29eeF9HWNFhqo1rTWdUDJk5Vpta1mNMdQ15olrcvYlwBoxBXU8XHCo+M
	8BE44R972Q9HPFhId1HP18nmqR4oB5o7EdRbRfnOnjXuyuZHOJaRPAY9kC3Ccl1m
	wHfkeS7nYP9U5Q+oNJkwjhdWJh1JzEZxMcJukGaPkuTdas+30TJSNDWUFA90l4fI
	fiOLirPALSls9FvyU7smavj983ZS412Qi/95HpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5cA6jMjtif3yzo64XZCZzENxJcVPsSCLdBOKj4TrXVY=:NIiBkOM3gHIA7o2XGlBvLemNaKITrOi9U8fRtu0nW78=;
X-ME-Sender: <xms:2YDWav9YXRfWHkNPVPEihedkv2Vg8ZNK0kElkvfNEIkFzj0XwYtGQg>
    <xme:2YDWamjSVtmWHg6bMRRe__PaIQaJyPbHqWTZyp3Ir27DZ3lz9kQvDkwHbfk5q-3VT
    v6w-kD6JD2LdGb_Wk8VqSeoJ_DWw8gpwBTZ7dpsaa0MTn0yb7cKL4B6>
X-ME-Proxy-Cause: dmFkZTG2ldR3cdQgyZ8A2znPeyX84LgmHOcvT6rLj0fce4vUXEtOreB9jCKAeq9i/Ht1rl
    HqmDJ1hA+j+nO2jctsN7rxtpnWRhRDrE6aq8sUC+AETbkVNy0fo9pFG99Qzx2qpgU7v69n
    XT18rpFIjte/xF7yGg2PwpccuJGw5t7Pz7AwEmZu1Rai2un1Cr/PXcf12KH1VFKZKtQB9Z
    5IPaUe/jkPjc1rc2NDDffwlEUhKElM2h1NaDdPsYaMummx8hA+0ig7Wk9BNCwKL8j8QVdq
    adBWAOJueZ8B+7hGPLwxXC/0PEMDZ9ArCl1OcYkKuhjAVNuaKkqJERzgI74Ji9GM6DA2D+
    QmP5Yfs55D6dcTlHeVbnlgLDb3a72UyQvTdkXnVvBz8rsib4v3fWhnk2ChMKjhN01zr9sX
    E77tsSmCiB+rADACwHCtg1gcrKnFLWbsj4CsIIPrAJ2ixwrNu9F9UZ3dbTR7Zny2Y4uMPc
    xfFgWblEtwKvRVjzJktAtjEXc8NecqctoPTVHk8fPy0wR63kFIO9BTsj9MaRty7PY5DNTR
    d/RdVv7moUP/kD0augUuhk2bP6khaiZvSW/ZLKnBBPZm7//j+B+TO3ipvSUyTq/4X9dhjg
    wrXdyxYZrG6Ju+Qeu6RM1040QOmVkRusB6hgM3cO5mESq7BSalANeXzL6n0g
X-ME-Proxy: <xmx:2YDWah6mLU9_JkSo_VNmHLtDUPOHO-ZEefF4Kc_J0LrO6JGqeKq_QQ>
    <xmx:2YDWamoyIcqJ5_H4PnTpV5sMw_lhUBv-qBS-RyzpMaq_idSlerLGeA>
    <xmx:2YDWarguh7NVsIOpM_qjCu9sUQbWATPianP6g0gGh-IV3fZCplirVg>
    <xmx:2YDWaoK1uZCFPqoXuHYqdYLz9cS5V05uJ3tTfJrthFEURUoz7wycFw>
    <xmx:2YDWag5vuGlJGCcKZ79Dq_nFKoHtzwbb4pUKWyKi-Q1xCiOk5Tw8WP6D>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D6E3782738; Mon, 19 Oct 2026 16:43:05 -0400 (EDT)
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
X-ThreadId: ApuIcoGem8Go
Date: Mon, 19 Oct 2026 16:42:45 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <ed7e07cb-af42-4e14-a576-0e0810b4b4d5@app.fastmail.com>
In-Reply-To: <F1D19B27-6BA9-456B-A43A-41D7B597F749@gmail.com>
References: <3a38b208-2640-46a9-b486-9be614d71480@app.fastmail.com>
 <F1D19B27-6BA9-456B-A43A-41D7B597F749@gmail.com>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Oct 19, 2026, at 12:49 PM, Ben Knoble wrote:
>> Le 19 oct. 2026 =C3=A0 10:25, Julia Evans <julia@jvns.ca> a =C3=A9cri=
t :
>
> Acknowledging the original was a long email to begin with,
>
>>> On Wed, Oct 7, 2026, at 3:48 PM, D. Ben Knoble wrote:
>>>> On Tue, Oct 6, 2026 at 3:37=E2=80=AFPM Julia Evans via GitGitGadget
>>>> <gitgitgadget@gmail.com> wrote:
>>>> +[[step_2]]
>>>> +Step 2: Introduce yourself to Git
>>>> +---------------------------------
>>>> +
>>>> +The first time you use Git on a computer, it's a good idea to tell=
 Git
>>>> +your name and public email address. If you don't, you'll get a lot=
 of
>>>> +warnings from Git. To do this, run:
>>>> +
>>>> +------------------------------------------------
>>>> +$ git config --global user.name "Namey McName"
>>>> +$ git config --global user.email you@example.com
>>>> +------------------------------------------------
>>>> +
>>>> +The name and email is so that other people you're collaborating wi=
th can
>>>> +know who made the changes. You can set them to anything you want.
>>>> +
>>>> +To check if the name and email have been set, you can run these
>>>> +commands:
>>>> +
>>>> +------------------------------------------------
>>>> +$ git config user.name
>>>> +$ git config user.email
>>>> +------------------------------------------------
>>> Ought we recommend the newer forms (git config set, git config get)?
>>> Or is the idea to remain compatible with older versions, such as the
>>> 2.32 I happen to have in /usr/bin on unsupported macOS 12.7.6 from
>>> very old (?) XCode?
>
> I think this got missed?

It did! Because of the plain text emails it's tough for me to scan the >=
> and >
to see the replies (">>" and ">" look similar to me) so I missed them, I=
 don't
know if it's possible to set up my email system to make it easier.

I didn't know about `git config set`, I put it on my list to think about=
. I
claimed at some point in this tutorial that it works on "any version abo=
ve
2.0", which is a claim I didn't actually check yet, but I do think it's =
valuable to
support old versions and be explicit about which Git versions you can us=
e the
tutorial with.

>>>> +
>>>> +Set your default branch name to `main`, by running this command.
>>>> +Git is going to change its default branch name to `main` soon, so =
this
>>>> +sets you up well for the future.
>>>> +
>>>> +------------------------------------------------
>>>> +$ git config --global init.defaultBranch main
>>>> +------------------------------------------------
>>>> +
>>>> +If there's no output, then it succeeded.
>>>> +
>>>> +Step 3: Create an empty folder and 2 files
>>>> +------------------------------------------
>>>> +
>>>> +In your terminal, create an empty folder and change directories in=
to it.
>>>> +Later on you could follow the same steps in this tutorial to take =
an
>>>> +existing project and start managing it with Git, but we're going t=
o use
>>>> +an empty project so that everyone following this tutorial has the =
exact
>>>> +same files.
>>>> +
>>>> +For example, run these commands to make a folder called `myproject`
>>>> +
>>>> +------------------------------------------------
>>>> +$ mkdir myproject
>>>> +$ cd myproject
>>>> +------------------------------------------------
>>> I don't know, and I'll probably bias towards what you've already
>>> written over asking for changes, but: does it make things any easier
>>> to read and follow along with if we "git init myproject" instead?
>>> Perhaps this version plants the seed that it's not too late to start
>>> tracking any existing project, though, which is valuable :)
>>> I wonder if you had some rationale for choosing this particular
>>> sequence? Just curious, now.
>
> And so was this.

I didn't see this one either :)

I had no idea `git init myproject` existed! I do think it's nice to
make it more obvious how you could start tracking an existing project.

> Both are fairly minor in the grand scheme of things, so I=E2=80=99ll t=
reat=20
> silence as =C2=AB not interesting right now =C2=BB and not be offended=
 ;)
>
>> Thanks for the review!
>
> You=E2=80=99re quite welcome!
