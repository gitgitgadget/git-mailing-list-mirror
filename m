Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA6351C06
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438818; cv=none; b=TSniR7h5WTDCsawK6HWcIhASsf3oCMO3PQrGZ3Ghi5cONE+H5u/EPbcnzpTbG9Bxl7gLGjgyR7ELGZ62w/2bF/XyNW0BMY/WIjmP0KcR9SLVHLng/NaZ22Fzpzpu/eNaTtxISr7raVx+qY05WlceUWsjlVqLJ/zTrZR1VLHKYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438818; c=relaxed/simple;
	bh=Q+9cGX+5JBRy2qXOuQWqNBbR+Rtwk+2rwL4KzmiHTTY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RwB4VbduqpA9z83UuRd7+A+TwLmLWWGRsKkQS/ldVmTZtEJ5iHYaq/HibxGT/21UkN9q49FA5vrDCHZz9WRkx44fVFt87mP616mLx0FzomM8XJ2nUrfU+meCy32CkjdqW3R9HX38X6Q7HCYiKjYArg+ENFulxqdMlPIg6/7t/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=uu9FVLVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vrQsLEPY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="uu9FVLVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vrQsLEPY"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D022914000B1
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 01:53:34 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 08 Oct 2026 01:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791438812;
	 x=1791525212; bh=Q+9cGX+5JBRy2qXOuQWqNBbR+Rtwk+2rwL4KzmiHTTY=; b=
	uu9FVLVKeUZom/DtOxAqx+1F4yjyJOIb+E3Bke18jsdGZb9WXWgilHWdjLMZeYqd
	mtFSOARFeO9lwTnZNU1j0C+NK+gp2yCVkefZcbxRkMAunyWoD3fTQwuEsYDnH9Km
	daGiS0m9vjFpi5jOn+l7d7jBi7XHLPPDUFJF3jPhry+5yG1nH3FSM5KBoSLKU2c2
	pVRv3MrptyH5v56tPw1I/TK15xRhJWqmD00NKWHEzfbeuV4tNq7LQNMATovcqxyz
	KtqAEVjPFuEvc8c5jqkCePqjZb3d7rGzHklkf8u2hWk6FmLnt0uLw2517hw51e1d
	dm37zu+aKI45xzZ6aG/TIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791438812; x=1791525212; bh=Q
	+9cGX+5JBRy2qXOuQWqNBbR+Rtwk+2rwL4KzmiHTTY=; b=vrQsLEPYMb/3z91mV
	+lkF5FH+89AwI6fbkTZm7PKZkSLevyYNHF3jQsq+3Uh7WBQx55m1yb0TGV9+w7v3
	T+JspObJ/wzwl4k7dYIr+EbAo00CLfSxIHfK2H8Rs6m+4xf3ocTqXAwQKjAObeDs
	STCFV+i/Vvzy10PfLfq9qd7qbrY7s9bKYk4GH+AT8QOVcR/Q0d3+oA1u4EHASGCl
	HcOw5DkxNXXIoJt2j2Q6fmamnroE1n/rT0mulZJ5Hn59/Sdo+mkY1tdZTqprjNDR
	hIVwoCp3G663o9m0WTW6iOVqQ2lkc8r73Cp9NEfAyhvudZYfwnUMmd+yxFWTAJxV
	HdDrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791438812; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fDEz8Ir0k1AWI677uwdQZ1uNWosDTgk+ve89TdOIP7dXCgc
	5NSh82r3JgBvEdbEP0bdPPQBKbx1kuO5SOT3IerF+A2IAWNqDi+IBbAw31qiiA8j
	/0OCv3NlK+SJhmx+7mxR+IzEmefGoTTcj352M/zViGVBUZCE2IaWMZuCBXfXp82s
	h0sM9Bw9JH3xUiPyjV4MJbq2iv2r02N/n4dU4DVofCry2w9SCYr90LGfMCobhlSM
	cDe5phh76/fhnckZ3ESvax9z6HKV8h0+1HSOUonZtPm90gkLYrpLCA1/q9eZegwQ
	On4U7X7nq/qJKFOkCS4kOXZdp5AmnrYauC8G4zg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:K/Vm622C3IT2CvPAtByQh3ht48kRt9nV6Oqb3LF8gpc=:Q+9cGX+5JBRy2qXOuQWqNBbR+Rtwk+2rwL4KzmiHTTY=;
X-ME-Sender: <xms:2S_HapAg_-yguaUD6t9AC6WahQC0-IAOeYDLguolm7F4i8WyVEkDbHs>
    <xme:2S_HaiURMeDttIzju_YiCFR8R-e4Cst2XAsUYJZ3BXrtjQEOZOlANc8asTlbEoGUI
    f0sdqhBawcGKF9iS9mT4UiZ3iSObeDZCgFUlQ5Rkf4KiegKIC2w_3U>
X-ME-Proxy-Cause: dmFkZTFH+115m3Yz47FEB2TrCi5e2Lltix3T8RoBw3Ds5wbf0M9QDBAgSm52K57wgSLMVs
    +Sp8unnMGF38fBUY5kfzbjGR9aAmSUWOVhEIJXUen33xZzZdVzokmf7B6u4thIKTWT+CNi
    J7F2fis2t8CNEZLIJZ0ri1pMKfRhs1s+Zt1qKyhRRCFDhNCaeb2WDGXG+EX1LFVFnzwQlt
    tl2vsCQYSjStQblmV6DUvCGW30ojw3G32NArcp+YVuCzEnqlpf4dWjzPkFdGVE6YW5Z3yz
    7x4OxuD5ZUKfpDiiUZKXUhn4GXThKmPQwC3EXw4v/plIbQxjpgMSxScO3upLwDmZ+mTlHL
    P9RcDUZebQ2r/5BT7h11blfpEPjpT0pYj216HJkoBEJkuLKG8HLXhmjyGqZUWW7G8/kpeu
    Bx3YBY/sw3HxxxbCDhEwE5x7TqM9KPb72SOSb8nOcXa0KsMW6EWs7pvm7X/mmo5mnaejgk
    pR4/vOM3vvBpMsykSkd9bMiCJrlBeTBSn46CmQivrbTwI5J7+ao80vacGen4a0RaFim29C
    0msaENrTq8RZsvZw7qzfpllrUAKZKBQOhhmd5r8xldBFBOtLbawkc/IwBukiSNZJl0PZXc
    qda0rXKaBJ6EVNT5vAv1JYzpezFBtO9477zairkyRNosFHqQ4bW3+paCzqjA
X-ME-Proxy: <xmx:2i_HajoVFIDiDpTjfs-n6nPzGL93MG9B_yWF1GPwnQbCGzw0GW4Xeg>
    <xmx:2i_HarczN0pc0C2wLEogaWIDTRrKfjTiX9wndIToGt8Yh2zCkW6Jtg>
    <xmx:2i_Haqqk7D0aZZLdaGBHG5T5VPWfNVnfzcQgOBcBT-rvQtNuFLU8mg>
    <xmx:2i_HakEmAYF14uykkMHE4t-u2fdBLNCkUgfIgi9JACU6TO6vfnTCew>
    <xmx:3C_Har5P10iThHREEF4dwmWl8QqZKuvxauH7-WT-Szl9O9HG10UfOBcB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 82EB522C009E; Thu,  8 Oct 2026 01:53:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALF2Vz3OCTeZ
Date: Thu, 08 Oct 2026 07:53:09 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Scott Chacon" <schacon@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Scott Chacon" <scott@gitbutler.net>, git@vger.kernel.org
Message-Id: <a54e82eb-1252-4d6b-8b4c-6e99da59252d@app.fastmail.com>
In-Reply-To: 
 <CAP2yMa+kgphMe-cpcZSvPSqwm-npUDVp=HaNRW+MPmPzZ_aOXw@mail.gmail.com>
References: <20261007142954.31761-1-scott@gitbutler.net>
 <20261007142954.31761-2-scott@gitbutler.net>
 <asa8ymCv4hoRJcZM@fruit.crustytoothpaste.net>
 <CAP2yMa+kgphMe-cpcZSvPSqwm-npUDVp=HaNRW+MPmPzZ_aOXw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI assistance
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026, at 06:49, Scott Chacon wrote:
> On Wed, Oct 7, 2026 at 11:42=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>[snip]
>
> I agree that generated output can reproduce material we don't have
> permission to distribute (though I think this is incredibly rare for
> anything complex). What I question is whether that possibility means
> knowing every source in the training set is necessary to make any DCO
> certification.
>
> Human contributors have also read code under many different licenses
> (and news articles and blogs) . We don't ask them to account for
> everything they've ever read before signing off on a patch.

Metaphors gone amok. You don=E2=80=99t regulate how submarines and human=
 bodies
can operate in territorial waters based on the fact that they both swim.=
[1]

Corporations already have non-compete clauses in order to keep knowledge
workers from applying their braincraft to competing businesses.

>[snip]
>
>> I'm a distributor of Git and I don't want to be sued or arrested beca=
use
>> I end up distributing code that I don't have the right to distribute.
>>[snip]
>
>[snip]
>
>>[snip]
>
> I'm not saying that other projects haven't taken positions as
> conservative as Git's current policy. I'm saying that much larger
> projects with much larger legal surface area such as Linux have
> adopted more progressive ones. Linus is fine with it on a project with
> the same DCO, the same license, and honestly, a lot more legal
> scrutiny.

Honestly, if an individual wants to avoid the risk of getting sued over
copyright then that=E2=80=99s their prerogative.

>[snip]

[1] I=E2=80=99m not a lawyer so maybe one does.
