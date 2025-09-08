Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5918AFF
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350957; cv=none; b=mpk82ZyXNVzx+0UMFvaniILpzZXOzm7QFfN778Fb8VFTfBceJbdd841eNOR+CEHHVDfTLAvEYU/Q9QvUrwlkzT1NO3Bg5FCtrymJwngbM2lbYDwApFiwycAo29Wt+ZeKsvF2smdlrbzqEXisw6IG//ArmiK0aZaERlTWgi5IO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350957; c=relaxed/simple;
	bh=kqw3v4b7aI+KZCwq/P4WVJmr6pa32hVbKuJwPTDTIic=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=H641QxhQXEpBZG6nC4o/F/pr32Uo6RdpaFggcMZ8bq/DRuTD6eKIRCVKYtaGhmqgtDcjM0thMAPC5zzHy4w6KdoXELsFaDNFRmUUsL9K5Cih1JpA0U1r87/3PX77EWUJ9u9hI6U3JcXPe2OIgFMLItVqLv6rbFMf9PziY3ivR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 588H1hQX2997465
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Sep 2025 17:01:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Elijah Newren'" <newren@gmail.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>,
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
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Calvin Wan'" <calvinwan@google.com>
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com> <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local> <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net> <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im> <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com> <aLqIHCdlbwF5X6Cm@pks.im> <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com> <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com> <CABPp-BEEU0yhurwewuRjrceU+AeHy9vYzXaOFmK5u0nnoSbp6w@mail.gmail.com> <049401dc20d6$69086400$3b192c00$@nexbridge.com> <CABPp-BHQyQk+Vkzm3RhVXxvNrpLB--bCLYwSCfZBQhB6PGBQQQ@mail.gmail.com>
In-Reply-To: <CABPp-BHQyQk+Vkzm3RhVXxvNrpLB--bCLYwSCfZBQhB6PGBQQQ@mail.gmail.com>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Mon, 8 Sep 2025 13:01:38 -0400
Organization: Nexbridge Inc.
Message-ID: <049f01dc20e2$42c75650$c85602f0$@nexbridge.com>
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
Thread-Index: AQEGadT21z5OprxVD7HWLLwOJZ29EAFNCYxRAdIt06UCgtOkMwLNWyY+AkPZBcsB+sNnaQLQ9HhNAfwz3cQCYIs5bgMRNqFTAiZSYtwCDxYVSgETxoD6AUaJgf4BwEHCzbU7CPow
X-Antivirus: Norton (VPS 250908-8, 9/8/2025), Outbound message
X-Antivirus-Status: Clean

On September 8, 2025 12:13 PM, Elijah Newren wrote:
>On Mon, Sep 8, 2025 at 8:37=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>>
>> On September 8, 2025 11:31 AM, Elijah Newren wrote:
>> >On Sun, Sep 7, 2025 at 9:10=E2=80=AFAM <rsbecker@nexbridge.com> =
wrote:
>> >>
>> >> On September 7, 2025 12:10 AM, Elijah Newren wrote:
>
>> >Thanks, Randall, this is useful information.  In regards to one =
point not fully
>covered
>> >by Phillip:
>> >
>> >> Also remember that without support from the git team, the code =
base is
>> >> no longer the same, meaning the auditors will not necessarily =
accept
>> >> fixes from third-party sources.
>> >
>> >Why does it need to be "third-party" sources?  Linus years ago =
blessed having
>> >someone else be in charge of providing updates for stable releases =
of Linux.
>Junio
>> >could do the same with Git and similarly mark an individual or group =
of people as
>> >the maintainers for the last Rust-optional version of Git, and those =
individuals
>could
>> >make official releases of Git with extended security fix support.  =
Then it's not
>every
>> >platform repeating the backporting work that needs to be done, but =
rather
>> >individuals from the affected platform(s) collaborating on that work =
and then
>> >making official first-party releases.
>>
>> Linux has one set of rules, and other platforms have others. I do not =
define the
>> audit requirements for PCI, SWIFT, or HIPPA compliance (and other =
rules outside
>> of North America), which apply one way or another to most of my =
community.
>> The audit teams, which are both internal to the companies and at
>> governmental regulatory levels, do this. It is 100% out of my control =
but is a
>> reality. Fixes to any code involved in managing financial and health =
instruments
>> must be done by authorized and recognized sources. I am not one of =
them.
>
>Perhaps I wasn't clear?  Let me try to summarize what I've understood
>of the conversation:
>
>Randall: We need to have official git releases for the last
>Rust-optional release.
>Elijah: Great!  Let's enable interested folks to make official git
>releases for the last Rust-optional release.
>Randall: We need to have official git releases for the last
>Rust-optional release.
>
>Which makes me just want to repeat what I said last time -- let's
>enable some folks to do that.

Ok, what does that look like. When and how? Will I get added to the list =
of
committers for this? How many people? Starting when, ending when? It =
would
be very nice to have some kind of project plan for this with =
dependencies
and milestones - I have been asking. If someone sends me a list, I can =
start
officially tracking it.

