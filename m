Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F56306B08
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346122; cv=none; b=YWOIzzHOmi1nr6BaqoisY+P9GHvQqorCWXcg31etqSXABiXrk5c5OMi8CLMACreaFI7VNqYwPhyDDsjh9NV8+b2JfwqBp3E60JVC0RhYtLyAax254QnTYiaQ6AmjkVrT1yI2e8bqKQuWG7yoThBVRxQg4QR/FqNiwC8DbvW7KA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346122; c=relaxed/simple;
	bh=Ycfb+Gs9nSfLEfpQBGd9qfr2a+PS+bWGwyWRMRFXK3s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ac4ZJcTcAIupP+OMBfGh022DCR+GvFXvyEQdmzAc+AExoqzknJqVODkGEd2KhekRhkmTyzuyFwSj9tjBAUxgMSMSn7vdtgZUEVLIhINfGjbb+1j+GpRt31WHyP1wcMyWHInUT1IC82tGfwfKqwVuj2j4Pb/LDAULe+pNhgLsrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 588FfSkJ2981225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 15:41:28 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ezekiel Newren'" <ezekielnewren@gmail.com>
Cc: "'Elijah Newren'" <newren@gmail.com>, "'Patrick Steinhardt'" <ps@pks.im>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'Josh Soref'" <gitgitgadget@gmail.com>, <git@vger.kernel.org>,
        "'Christian Brabandt'" <cb@256bit.org>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Eli Schwartz'" <eschwartz@gentoo.org>,
        "'Haelwenn \(lanodan\) Monnier'" <contact@hacktivis.me>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?UTF-8?Q?'Matthias_A=C3=9Fhauer'?=" <mha1993@live.de>,
        "'Sam James'" <sam@gentoo.org>,
        "'Collin Funk'" <collin.funk1@gmail.com>,
        "'Mike Hommey'" <mh@glandium.org>,
        "'Pierre-Emmanuel Patry'" <pierre-emmanuel.patry@embecosm.com>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Calvin Wan'" <calvinwan@google.com>
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com> <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local> <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net> <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im> <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com> <aLqIHCdlbwF5X6Cm@pks.im> <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com> <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com> <CAH=ZcbAjpgAVjVK6iYEr2150a+WgFfxrWuJUoR1pa08JqM4BDw@mail.gmail.com>
In-Reply-To: <CAH=ZcbAjpgAVjVK6iYEr2150a+WgFfxrWuJUoR1pa08JqM4BDw@mail.gmail.com>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Mon, 8 Sep 2025 11:41:23 -0400
Organization: Nexbridge Inc.
Message-ID: <049501dc20d7$0bb08ed0$2311ac70$@nexbridge.com>
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
Thread-Index: AQEGadT21z5OprxVD7HWLLwOJZ29EAFNCYxRAdIt06UCgtOkMwLNWyY+AkPZBcsB+sNnaQLQ9HhNAfwz3cQCYIs5bgMRNqFTAiZSYtwCDxYVSgFsUdi3tVBkB3A=
X-Antivirus: Norton (VPS 250908-0, 9/7/2025), Outbound message
X-Antivirus-Status: Clean

On September 8, 2025 11:10 AM, Ezekiel Newren wrote:
>On Sun, Sep 7, 2025 at 10:10=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>>
>> On September 7, 2025 12:10 AM, Elijah Newren wrote:
>> >Sorry for the delay; life outside of work is challenging at the =
moment...
>> >
>>
>> I am going to address the critical point mentioned below and snip the =
rest for
>brevity.
>>
>> >I still don't see why distributors _must_ ship the latest version of
>> >Git and why folks on some platforms are considered broken if they =
are using a
>slightly older version.
>> >Let me ask again: has anyone answered why this is considered
>> >mandatory?  If they have, I've missed it, but I've asked multiple
>> >times.  Even if you want to lump "distributors cannot build a newer
>> >version" under the umbrella of "breaking changes", I argue it's a
>> >much different kind of break and one which merits different =
timelines for
>handling than e.g. lumping it in with 3.0.
>>
>> I do not see that distributors _must_ ship the latest version. =
Suppose
>> we are on
>> 2.51.0 and a CVE comes out that prohibits its use in an organization
>> that does not allow any medium-high to high CVEs. This represents
>> hundreds of thousands of impacted users in my community alone. How
>> does the CVE get applied if the latest cannot be built and the git
>> team does not apply the CVE fixes to old versions. Personally, I do
>> not care if git versions are different between work and home, or even
>> between CI/CD and other platforms. I don't even care ...
>
>Ok, that answers the question for NonStop, but that doesn't answer the =
question
>for the plethora of other distributions. Most distributions don't ship =
the latest
>version of Git in their package manager, and if an organization deems =
it critical to
>have the latest they can build it themselves and ignore the Git version =
in the
>package manager. So why does Windows, Mac, Linux, etc... _need_ the =
latest
>version of Git in the package manager?
>
>If security updates are backported to NonStop, until that platform =
supports Rust,
>then I don't see why using an older version of Git in Windows, Mac, =
Linux, etc... is a
>catastrophe. Most existing distributions _can_ package the latest =
version of Git, but
>they _don't_.
>
>I reiterate Elijah's question "Why _must_ distributors ship the latest =
version of
>Git?".

My emphatic answer is that they do not. There is no requirement from me =
or anyone
I know to ship the latest version. What is crucial is that there be =
fixes for medium-high
and above CVEs that are delivered in 30 days from initial fix =
availability (that would be
in Rust, for this conversation and applied to C). If that were =
supported, I could live with
as would my customers and their auditors for LTS releases. Please see my =
expectation
of LTS defined elsewhere in this thread - essentially 5 years. Perhaps 3 =
at a bare minimum.

