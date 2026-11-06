Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967034;
	b=JLEpHTasEo51unPyU4CgYyL9ZFghD8isc+x4AE+Vyozf5033bNUG+ABCSchFtTwtXhpB
	 G8PgOjqgRBmhj6echP0cgxhU5XVHoqlXHOjyt9c/smqGRwxy32x5c6nTP8B2wy93n5hTW
	 jz1KHVnroW57g94QeSF+f899z7qkIP1RuM1aBYYAZdwZSdVtS3334ACG2w5Br6luJHzS3
	 ymIZxkfsPOV4p4mxu1yVB0u5WepYw2bTErW2GoqI12nUxSpFZF9NyK/rprn47GwALlNs9
	 deC+ZbcueYji/bTL50sW9oeeSzMb35e2a8Ja+pyAVW3s+KYCGblef/yEb4VRXFRleuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967034;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=pf3ThfVzpszGoUZM5ErxCtRylTkD2GWwvjnCUX2rNOw=;
	b=f2uiy0f1PX/HytILo0G5J84xp61CgIzYZKiHGe2nZCiFJB01I1WwoqqQ8rAkPEV0D3+6
	 4IzL0M3yHvs0Y+gqGzXHTCiJV8bzDcf+tGjuLqirp3WcTRwgq/cvjNB1ojLUsQfkJR3pS
	 NHFPFzB7SRr6gwNRxVuLAL6R2d96xp/pC2MbYF028BNhEUoa+SQZ5QnRQX9CnLHBnjPfb
	 9YPNbHGuDXBxt5KwAf3bHG1dyrYSLUQDVy/HiEI/aSQvE59X7CSAqQe5R07GwSSTl4ts4
	 2NPh9zaioqiV/lq9ucJINmMLNfHcj7qZviCRGfAULHrpGVXVJ1/0xnr4qwra5DqWlsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=delpeuch.eu;
	spf=pass smtp.mailfrom=delpeuch.eu;
	dkim=pass header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.a=rsa-sha256 header.s=s1-ionos header.b=1X08YPyh;
	arc=none smtp.remote-ip=217.72.192.74
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4828606A33C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 12:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4828606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.a=rsa-sha256 header.s=s1-ionos header.b=1X08YPyh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1793967025; x=1794571825; i=antonin@delpeuch.eu;
	bh=pf3ThfVzpszGoUZM5ErxCtRylTkD2GWwvjnCUX2rNOw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=1X08YPyhW3syGozDoiFiMkemkKr3IhVv3Dafz1vlGjqIRUqwkTrs6F9cBIP2slxj
	 MsQcRekV/9hJO40u9GftKBVMbCuW8Bm++Sx2JVBChAaOVk0sI6pSRjr6H25R8B9sm
	 bv+E45NDBHsSBOCwqG3g+4RxZfzYgO4NLY6Sdl6gqpxFon0qc63boAkc1o2ANh9NZ
	 FmKxT/mblb86H3/VHOm9Bz7fwFVgNvAAGGmIJWBMS4iWc8k2a4vpA4Gvi1f6p9syf
	 daSJoJKLtGMpaD/9LZwPMbCsh2e+0fYnOWHILSfhZYlGxggAUlIe+fuTYbL83aOh8
	 ukxUwqNYXIBOaWF1Ww==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MkYsS-1weSh510BC-00d3qE; Fri, 06
 Nov 2026 13:10:25 +0100
Message-ID: <e977b49f-8462-4b63-bdff-daee75994a36@delpeuch.eu>
Date: Fri, 6 Nov 2026 13:10:24 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document the current project governance
To: Junio C Hamano <gitster@pobox.com>,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Christian Couder <christian.couder@gmail.com>
References: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com>
 <xmqqmrrqg7uf.fsf@gitster.g>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
In-Reply-To: <xmqqmrrqg7uf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vfc1N311oPeXYSTpwz550fmR4QA5uJCyN3QiT338k2+pEcev5q6
 jtjOxRS2/W4euyN+J9Efe/fYVS7n+suMlB9NKl9OtddKf1pIK6e5ijm/GzhC//BS86D5B2q
 aAy2qygDTFW993NxWzxt4HVCLLrBknFY8W9QXxvRmNxMPLUwVVhUxzUlZ6kEItcPb5w0Lha
 Y1YAQaefF4M0E9Hr8Vcaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AHNUYiiMeCM=;SS3pDerbeh+4q+uNoZHpGNv8pQt
 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

Hi Junio,

Thank you so much for your feedback!

On 02/11/2026 23:57, Junio C Hamano wrote:
> "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +This document describes the social structures in place in the Git proj=
ect. It intends to be neither prescriptive, nor express a judgment on the =
merit of those existing ways of working.
> Can you line-wrap these?  Even though once .adoc is rendered into
> .html or whatever presentation format, how the source document had
> its words in it would not be visible, but a single long line that
> has an entire paragraph is very hard to work with when we are
> discussing the document in its source form.
Sorry about that, will do when I re-roll this.
>> +The Git project develops a free and open source distributed version
>> +control system.  The scope of the project covers
>> +https://git-scm.com/install/source[the git.git repository],
>> +associated repositories hosted under the https://github.com/git[git
>> +GitHub organization] and the <git@vger.kernel.org> mailing list.
>> +Other spaces are considered external to the Git project for the
>> +purposes of this document.
> Do we want to also cover Discord and IRC chat channels?
> (cf. https://git-scm.com/community)

Happy to include those. Perhaps a dedicated section on communication=20
channels would be more fitting then, as we could also document who=20
moderates those spaces.

Do you know who moderates the IRC channel and the Discord server? Is it=20
also the PLC?

>> +[NOTE]
>> +=3D=3D=3D=3D
>> +Not knowing exactly what is considered part of the Git project or a th=
ird-party project, I have left the following repositories and initiatives =
out of the scope of this document for now, but I am not sure about this ch=
oice:
>> +
>> +* https://github.com/git-for-windows/git[Git for Windows]
> What do they call themselves?  A friendly fork?  https://gitforwindows.o=
rg/
> might be a more official entry into their universe.  I dunno.

Since they have their own governance=20
(https://gitforwindows.org/governance-model.html), I would treat it as a=
=20
separate project and keep it outside the scope of this document (despite=
=20
the fact that the distinction looks a bit artificial to me as an outsider)=
.

>
>> +=3D=3D=3D Project Leadership Committee
>> +
>> +The Project Leadership Committee (PLC) liaises between the project
>> +and the Software Freedom Conservancy, Git's fiscal sponsor.
> We are a "member project" of SFC, which acts as our "fiscal sponsor"
> for us, providing non-profit administrative, financial and legal
> infrastructure.
Is this a comment, or text that you would like to see part of the=20
document? I think it's a good idea to make the term "fiscal sponsor"=20
more precise as you did, as it's a confusing term for many people (who=20
might otherwise think that SFC funds the Git project).
>
>> +Those members are renewed by cooptation, after consultation with the
>> +community. When doing so, the over-representation of an employer in
>> +the PLC is
>> +avoided.footnote:[https://lore.kernel.org/git/20180821020849.GA2527@si=
gill.intra.peff.net/[Re:
>> +Git Project Leadership Committee], Jeff King, 20 Aug 2018]
>> +
>> +NOTE: Is there any existing process for leaving the PLC? (for
>> +instance, if someone has become inactive in the project or is in
>> +conflict with the rest of the project's leadership)
> Nothing that I know of.
Great, then I'll document that as such.
>
>> +=3D=3D=3D Security team
>> +
>> +The security team triages vulnerability reports sent to the project.
>> +They do so on the private mailing list <git-security@googlegroups.com>=
.
>> +This team also includes people operating widely used git hosting sites=
 and packagers.footnote:[https://lore.kernel.org/git/xmqqbj9d3y9x.fsf@gits=
ter.g/[A note from the maintainer], Junio C Hamano, 1 Oct 2026]
>> +
>> +Is the list of subscribers to git-security public?
> NTK as far as I know.
>
>> +How does one gain and lose access to this list?
> By asking for an invitation.
Thanks. I think it would be worth documenting who is able to add=20
subscribers to this list. I am assuming you are, but are you the only one?
>> +Does Johannnes Schindelin play a particular role in the security
>> +team?
>> +https://lore.kernel.org/git/5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.d=
e/[He
>> +seems to have the lead in triaging vulnerability reports], but I
>> +can't really tell to what extent
> Why don't you ask him yourself by CC'ing this patch ;-)
Makes sense, thanks. Johannes, I would welcome insights as to whether=20
security reports are triaged and acted on by you alone, or whether other=
=20
people have responsibilities in this field.
>
>> +=3D=3D=3D Localization maintainer
>> +
>> +Jiang Xin coordinates the localization of Git by maintaining https://g=
ithub.com/git-l10n/git-po[git-po].
>> +
>> +NOTE: How would their successor be appointed?
> Not limited to this, but there is in general no "appointing"
> process.  If there becomes an open seat that needs to be filled,
> it will stay vacant until somebody volunteers.

Makes sense. Here again, I should have asked my question differently:=20
who is able to give the necessary permissions to a new localization=20
maintainer? Are you an "Owner" of the https://github.com/git-l10n org?

Or would you just stop pulling localization changes from this repository=
=20
into your tree, and point it to another repository, where the new=20
localization maintainer would have the necessary permissions?

Cheers,

Antonin

