Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A24101D4
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154059; cv=none; b=grCjZG18VXFob703xEO/XrmUTHCGS7F97tsIBUbxOvPyUreR+PW3XWTKq2Dir/h9MAeMqrwV/7vG+Y9eEcA8FdUIduqvrknNqkRLFngdccxGsSNElIlVluIDB/EQOBhmdOVMWrTyB9RzWyOQSCYLOm/az5PQYYkI/SvdqkKx8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154059; c=relaxed/simple;
	bh=4jYVuninRxn/vj3M0BAmJYOuFgHv6679gBe1M8uN9s4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Maq0RV7fFdYpkzs/aL2p4mVGw3Moh+tl7X9aLBTxW7vLZwJUlpDX5YSr3RYMDlM4wGpv9AbXArl/5wcEc+4QhqbHk2T90t0JK1/qFryr+HvzKt5/O/ldhqm/wr0LCxAP3lgORSxYfLiFgpdl9bh3eUPATD+7ajvs8bxmHdRg5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46GIKfYZ658277
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 18:20:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Emily Shaffer'" <nasamuffin@google.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" <avarab@gmail.com>
References: <20240711232413.693444-1-emilyshaffer@google.com> <xmqqed7ylbna.fsf@gitster.g> <CAJoAoZnUbgX1MpisdS+TkGLFrBUyX_x_M_Q6iZ2n_AhP8r4mNA@mail.gmail.com> <xmqq34oa1an3.fsf@gitster.g> <CAJoAoZnbsqF7xi9AW4--d9Dsfh=GnRuko6rRELsGUW0ihRvaVg@mail.gmail.com>
In-Reply-To: <CAJoAoZnbsqF7xi9AW4--d9Dsfh=GnRuko6rRELsGUW0ihRvaVg@mail.gmail.com>
Subject: RE: [PATCH v2] Documentation: add platform support policy
Date: Tue, 16 Jul 2024 14:20:36 -0400
Organization: Nexbridge Inc.
Message-ID: <01a501dad7ac$de59ba20$9b0d2e60$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIFP0bK226z3oZ1ne7kWQpKk7LXQQFQIoQ6ARd1jNwBImJingDQJgansYIIEhA=

On Tuesday, July 16, 2024 1:59 PM, Emily Shaffer wrote:
>On Mon, Jul 15, 2024 at 4:46=E2=80=AFPM Junio C Hamano =
<gitster@pobox.com> wrote:
>>
>> Emily Shaffer <nasamuffin@google.com> writes:
>>
>> > If I fudge with the rewrite a little, I get:
>> >
>> > """
>> > Git has a history of providing broad "support" for exotic platforms
>> > and older platforms, without an explicit commitment. Stakeholders =
of
>> > these platforms may want a more predictable support commitment. =
This
>> > is only possible when platform stakeholders supply Git developers
>> > with adequate tooling, so we can test for compatibility or develop
>> > workarounds for platform-specific quirks on our own.
>> > Various levels of tooling will allow us to make more solid
>> > commitments around Git's compatibility with your platform.
>> > """
>>
>> This reads well.
>>
>> > """
>> > Note that this document is about maintaining existing support for a
>> > platform that has generally worked in the past; for adding support
>> > to a platform which doesn't generally work with Git, the
>> > stakeholders for that platform are expected to do the bulk of that
>> > work themselves. We will consider such patches if they don't make
>> > life harder for other supported platforms, and you may well find a
>> > contributor interested in working on that support, but the Git
>> > community as a whole doesn't feel an obligation to perform such
>> > work.
>> > """
>>
>> The part before "We will consider" reads very well.  The part after
>> that, I haven't formed a firm opinion on (yet).
>>
>> > """
>> > * You should run nightly tests against the `next` branch and =
publish breakage
>> >   reports to the mailing list immediately when they happen.
>> >
>> > ** You may want to ask to join the
>> >    mailto:git-security@googlegroups.com[security
>> >    mailing list] in order to run tests against the fixes proposed =
there, too.
>> > """
>>
>> Looking good, I guess.
>
>It seems like there's not much more in contention from the current =
responses to
>this thread and v2. I've got a reroll ready with mostly =
wording/formatting changes
>based on your reply.
>
>I asked Johannes if he wanted to take a look on Discord[1], it seemed =
like he wasn't
>interested in doing a full review and doesn't want his name on the =
maintainer list:
>
>me: @dscho did you see
>https://lore.kernel.org/git/20240711232413.693444-1-
>emilyshaffer@google.com/
>? do you want to be written down as windows maintainer? or does this =
policy differ
>enough from the way GfW works that it doesn't make sense for you?
>[...]
>dscho: That document makes sense for Git, including on the NonStop =
platform.

Putting it the way below, we could use my team's GitHub Issues list for =
our fork (we haven't used the fork since 3.0 happened and we finally got =
to the same code base). The repo is still there, if this team wants it, =
but I think the general mailing list for NonStop issues is probably =
better. Most (by a long way) of our issues have ultimately been of =
general interest. My community is rather shy (not used to mailing lists) =
and also mostly blocking access to GitHub.com, so... mailing list for =
discussions.

>dscho: For Git for Windows, the processes are substantially different, =
for example:
>not using a Git mailing list but instead GitHub discussions, issues and =
pull requests.
>Also, there is no seen, next, master nor maint. There's main.
>me: yeah, I guess I'm really asking - does this do enough for what you =
need to make
>your GfW fork work
>dscho: So: Thank you for notifying me and asking; I think it'll be fine =
without my
>name in it.
>
>What's next to move this patch forward? Should I be asking around for =
more people
>to review it? Or do you think it's close enough to ready that I should =
send v3
>without waiting longer so you can take it? I took a look at =
DecisionMaking.txt but
>don't see that there's a clear answer; of the people participating in =
this thread my
>impression is that we have consensus, but there's also not that many =
people
>participating.
>
> - Emily
>
>1:
>https://discord.com/channels/1042895022950994071/1156706741875130499
>/1262827182162575471
>(requires Discord login and Git server membership :/)

