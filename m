Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2022820CE
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261460; cv=none; b=FDHNqjOZNewtDXxUr5VkDHl9SIousaXf/1LQYdeywnlXuFnORKgrr5pRGUXVfLIQT/UrM9ExSdg73s5M2zFwiRug/DjjdCo7lRgm3XK46aL6Kzbhegt0o7eLNhAPb6TCoq8PiBAyxmQnJJYzopMiE8xKlL9i6X7vPvlz72bggL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261460; c=relaxed/simple;
	bh=Kr6NKfRm0GWK7na58B1kr2BjwxjzZvXfX7PKhVkV180=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qaetCx3JeDoSGyTXJBwIx6yAn6Y5gGQEIeb7nH0KPkhkltPLNscDhNFnJPUl6DLaC0nLqvR0hLnCqbEYUcbStkxVHKE9yr7ivHjA5IzBDc19qUk8cf6fnl0BYVZZLjzyzbQfC6zVHtT9ETs48xWwTpIAz3ti7wCJmV2jBWBBYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 587G9pWf2738710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Sep 2025 16:09:51 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Elijah Newren'" <newren@gmail.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
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
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com> <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local> <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net> <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net> <aLl6iFXeAvL_hvqR@pks.im> <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com> <aLqIHCdlbwF5X6Cm@pks.im> <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>
In-Reply-To: <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Sun, 7 Sep 2025 12:09:46 -0400
Organization: Nexbridge Inc.
Message-ID: <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com>
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
Thread-Index: AQEGadT21z5OprxVD7HWLLwOJZ29EAFNCYxRAdIt06UCgtOkMwLNWyY+AkPZBcsB+sNnaQLQ9HhNAfwz3cQCYIs5bgMRNqFTAiZSYty1aq648A==
X-Antivirus: Norton (VPS 250907-2, 9/7/2025), Outbound message
X-Antivirus-Status: Clean

On September 7, 2025 12:10 AM, Elijah Newren wrote:
>Sorry for the delay; life outside of work is challenging at the =
moment...
>

I am going to address the critical point mentioned below and snip the =
rest for brevity.

>I still don't see why distributors _must_ ship the latest version of =
Git and why folks
>on some platforms are considered broken if they are using a slightly =
older version.
>Let me ask again: has anyone answered why this is considered mandatory? =
 If they
>have, I've missed it, but I've asked multiple times.  Even if you want =
to lump
>"distributors cannot build a newer version" under the umbrella of =
"breaking
>changes", I argue it's a much different kind of break and one which =
merits different
>timelines for handling than e.g. lumping it in with 3.0.

I do not see that distributors _must_ ship the latest version. Suppose =
we are on
2.51.0 and a CVE comes out that prohibits its use in an organization =
that does
not allow any medium-high to high CVEs. This represents hundreds of =
thousands
of impacted users in my community alone. How does the CVE get applied if =
the
latest cannot be built and the git team does not apply the CVE fixes to =
old
versions. Personally, I do not care if git versions are different =
between work
and home, or even between CI/CD and other platforms. I don't even care
if I have to use JGit instead of git in some situations (which I see is =
a likely
outcome of this discussion). Is there an official statement of what an =
LTS
means? In other projects LTS is typically, and formally by policy 5 =
years.
From what others have said here, positions of 6 months, 3 years, and
"apply it yourself if you want to continue to use git" have been made.

The core problem of adding a breaking dependency is when a CVE comes
out that prohibits git from being used at all. If the git team is not =
going
to provide a clear statement, one way or another, if how CVEs (at
whatever severity level) will not have a commitment of any kind,
then distributors are essentially cast adrift and on our own. It would
be helpful of those of us who donate our time, for no compensation,
are able to plan for this in a meaningful way. Please remember that
we have to justify our participation to our management teams to be
allowed to continue to participate. Nothing is free from this end
and if fixing (not just applying fixes) CVEs are now 100% our
responsibility, if would be critical to know that when we build our
business cases to our bosses, who I am fairly certain will say an
emphatic no.

Also remember that without support from the git team, the
code base is no longer the same, meaning the auditors will not
necessarily accept fixes from third-party sources. This particular
point enabled adoption on some platforms, particularly NonStop.
Adoption was at 1-2 customers when we had a divergent code
based because some platform fixes being different from the
standard code-base and could not be certified as valid. Once the
code-base because common, adoption was rapid and enthusiastic.
If this goes away, I suspect that adoption rates will go negative.
I am aware that that particular discussion is actually happening
in some organizations in my community right now, with companies
looking for alternatives to git based on this discussion thread.

With over a decade of respect and participation,
Randall

