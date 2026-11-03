Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671033;
	b=WXSntCaesWqGTXkeg3G4ovux7jv5p8pwz8tWI+MvfQ/4a6kK3/Dx357vuFLys7agD/nE
	 kz7i7nvZOcLLEwCKOinlyX6HhHdI4U5LRW6ybgJ8SJDi4/0XCsvqD5LO4cbtazrqyvXLI
	 FcbRcHgo6iEsbgfCpMffJ98w4O3jQHxg1nujy1ZexuDGRivZY0TEycb7PqLBfu5eubz2W
	 5MfKouXwEEgcha+71BSRdo8jGbcKDZ3IJToAJgj8X2qJFnd1fRdWWo4SepYRNwireLhzD
	 o3lb1nyMiZJrM/WAQzGjGBPoeirM9hHc7lnXjlscy3fd5ABNKGVQpUISxBu7sIgxovA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671033;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To;
	bh=ki8N214MhwT9XcXAohKUvykybwpi8wTp0AEK0dt4MQM=;
	b=G1Tv9w5k5SVEMAnj/So8V/4Txfc0i4g+FasCq2jor/hvzaXp29TaZ5o3zHdvUi3gCGAh
	 XzGfxmu05pP1tOkTS45DD1B3KBtdH+mMXd+T9BxXL8a/EPKg+3FblL0hdEtM2F3HpDqun
	 sIgbvsAQQoh9v5F14H+USiDnnXB5yaHHKDJoXd8ZWoyMoQvViJX8QuP6rzY+nb86FwRXJ
	 t30+H0tEt4CHCFNppUWOdJNkHwhYDyPX3ApgQs74ESlPpmem4aI97qzyrdLKNBCP/2tfl
	 ARcPtSxPfNZRUrhFgdM1k7s4ll/GhRdDPfAyeluprjUSfX6dViRDRn/VPTdLquPn6DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=GzcKDu94;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630A606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 01:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D630A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=GzcKDu94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1793671031; bh=fnTYAqyZlJm5TS3jw5+ziOjQcyP28c3JhBU0swZEQa4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=GzcKDu94yF2HwpJmhXJNgZQ3Lalhrwe6Ul3P1Jt3rQfsdRmJYMrDrpxtLNlHG/iHE
	 TpaKeEWgGvZmPKPELIdXYDBuuL4vL39hg2fR7uIMw2rdPVBM8X1DVKkL7nVRpmfjY1
	 oS+ZeMR5XaTn4Irsa9rNHD8ABbud8uYyTm2kPzB4=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 81D4263149;
	Tue,  3 Nov 2026 01:57:11 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 20:56:59 -0500
Message-Id: <DML7B6VVFDH0.3RKFXWKOH0X2L@lfurio.us>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided
 commits
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>, <git@vger.kernel.org>,
 "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
To: "Ben Knoble" <ben.knoble@gmail.com>, "Junio C Hamano"
 <gitster@pobox.com>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <xmqqcxsmg473.fsf@gitster.g>
 <427F4BDB-B21B-468E-9C6A-4A7FE3F13688@gmail.com>
In-Reply-To: <427F4BDB-B21B-468E-9C6A-4A7FE3F13688@gmail.com>

On Mon Nov 2, 2026 at 8:10 PM EST, Ben Knoble wrote:
>> Le 2 nov. 2026 =C3=A0 19:16, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>>=20
>> I thought Harald's case was to take the patches from the previous
>> round of the topic and rebase them on top of a different base (e.g.,
>> updated origin/master), so there is no suitable single <base> for
>> the three-rev form, but I may have misunderstood his example.
>
> I think origin..old-topic and origin..new-topic=20
> would both select only the =E2=80=9Ctopic=E2=80=9D commits as long as bot=
h
> bases are reachable from origin (which seems to be the
> described case, to me).

Put another way, every commit reachable from origin is excluded from
either side of the range-diff.

Harald's example uses the symmetric difference syntax.  I think this
effectively treats the merge-base of the two tips as the shared base in
the range-diff.  It can't tell the difference between new commits that
are part of the topic and ones that are only there by virtue of advancing
the topic's (real) base.

So, I think this <A>...<B> form would yield the expected output if you
only rewrote history in-place _on the same base commit_, but not in the
general case?

>
> I agree with Matt that better selection of inputs to range-diff=20
> makes this specific case better :)=20

When I run this command, I almost always say it like this (with the topic
checked out)

    git range-diff master @{1} @
                          ^
                          or, @{u}
                depending on the workflow
