Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FB20C480
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979530; cv=none; b=pbqQnFimc9GqpGnlp/X8UQKw8D6cQW04vzE9NclqcN0990r2nvJ9dhaYBhrLsxDgPEV8B3Uh+MZxyOD5XPUj7Ig2vzQWnOTtYSyhJqZnRaH898O75si6jtDG3EIwn7/yCDUhBpLZXvAz0F8hvDynpuuCLtzZ9iVDtBNbClTQO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979530; c=relaxed/simple;
	bh=mPevI3PQ5Dgsy0KTEKYJGCA7w1tpLDKXRtMSMK8K53w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uyodgftPumaWZmVRbtLFS/7sLFxQjgvse9YK/iEEbfXObbNWQKSKUsJsiQC5loGQwKUCvz3LTvTW50jX+mh9NxmExf5kFhAR6XGVwAjEk5o4R69oyQrL9wLtC8FzZ7vnK/2Q9eQBl7rVKwj76DWmM3dYMgi0GVCeWEyENS7zY/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57NK4oxw3444976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Aug 2025 20:04:50 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Elijah Newren'" <newren@gmail.com>
Cc: "'Kristoffer Haugsbakk'" <kristofferhaugsbakk@fastmail.com>,
        "'Josh Soref'" <gitgitgadget@gmail.com>, <git@vger.kernel.org>,
        "'Taylor Blau'" <me@ttaylorr.com>,
        "'Christian Brabandt'" <cb@256bit.org>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "'Eli Schwartz'" <eschwartz@gentoo.org>,
        "'Haelwenn \(lanodan\) Monnier'" <contact@hacktivis.me>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "=?utf-8?Q?'Matthias_A=C3=9Fhauer'?=" <mha1993@live.de>,
        "'Patrick Steinhardt'" <ps@pks.im>, "'Sam James'" <sam@gentoo.org>,
        "'Collin Funk'" <collin.funk1@gmail.com>,
        "'Mike Hommey'" <mh@glandium.org>,
        "'Pierre-Emmanuel Patry'" <pierre-emmanuel.patry@embecosm.com>,
        "'D. Ben Knoble'" <ben.knoble@gmail.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Calvin Wan'" <calvinwan@google.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com> <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com> <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com> <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com> <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com> <aKoVcVexWi212pAl@fruit.crustytoothpaste.net>
In-Reply-To: <aKoVcVexWi212pAl@fruit.crustytoothpaste.net>
Subject: RE: [PATCH v3 02/15] xdiff: introduce rust
Date: Sat, 23 Aug 2025 16:04:45 -0400
Organization: Nexbridge Inc.
Message-ID: <033d01dc1469$30088aa0$90199fe0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHKaANAdlFqcOHeZ+UNw9ZV5fNZlgJjoZaSAeK73o4BCSPnmQFMkRvcAya/ufMCJfQ+PgIoVfaOtCN4lxA=
X-Antivirus: Norton (VPS 250823-8, 8/23/2025), Outbound message
X-Antivirus-Status: Clean

On August 23, 2025 3:25 PM, brian m. carlson wrote:
>On 2025-08-23 at 18:30:26, Elijah Newren wrote:
>> I don't think that's fair.  A quick reminder on the history: There =
was
>> lots of excitement about potentially introducing Rust two years ago =
at
>> our virtual Git contributors conference.  Taylor formally proposed
>> adopting it on the mailing list a year and a half ago.  And at Git
>> Merge last year, among those in attendance, there was broad
>> significant interest in adopting Rust with unanimous support for
>> letting it move forward among those that were present (which, yes, we
>> know wasn't everyone).  And there's the three rounds so far of this
>> patch series.  At every discussion where you weren't present, someone
>> else would always bring up you and NonStop, and point out how you've
>> been a very positive long-term member of the Git community and how
>> Rust adoption would likely negatively affect you, which would be
>> regrettable.  We waited years to adopt Rust precisely (and I believe
>> solely) because of your objections.  Josh and Calvin even went the
>> route of making optional not-even-built-by-default Rust libraries
>> (libgit-rs and libgit-sys) when they wanted to add some Rust =
bindings.
>> If years of deference by other community members isn't considered
>> taking you seriously, I don't know what is.
>>
>> I agree that it is disappointing that there isn't a clear way to both
>> gain the compelling advantages of Rust while also retaining the full
>> current extent of our widespread platform support.  It's doubly
>> unfortunate since you're such a positive contributing member of the
>> community.  But not allowing us to ever gain the advantages of Rust =
is
>> problematic too.  So, a decision has to be made, one way or the =
other.
>
>I think it's worth saying that I do appreciate your (Randall's) =
positive contributions
>as well and I would love some way to continue to support NonStop as we =
adopt
>Rust.  To be clear, I care deeply about portability:
>I have owned PowerPC, UltraSPARC, MIPS, and ARM hardware, and I test =
many of
>my personal projects on at least Linux, FreeBSD, and NetBSD.
>
>There is an alternative Rust compiler, mrustc[0], which is written in
>C++ and that I have played around with to see if it could meet our
>needs.  I've been very busy lately and haven't had the time to test it =
out fully, and
>although it will likely require some upstream changes for static =
libraries and a
>compatibility wrapper because its minicargo is very limited in =
functionality, it might
>be an option that we could leverage.  There will necessarily be work on =
Rust
>upstream as well, but I'm hoping that mrustc will at least open doors =
for us.
>
>I also think that Rust is becoming a more and more common language in =
technology
>because of its interoperability with C and its memory safety.
>The support policy I wrote up explains why there is an increasing push =
from
>governments, security professionals, and the technology industry for =
memory-safe
>languages.  If Git is to continue its success and broad adoption, we =
don't want it to
>be labelled software that is using security anti-patterns, and we also =
don't want it to
>be a CVE factory like libxml2 or ImageMagick.  This is the reason I =
ultimately started
>work on the SHA-256 project many years ago: I knew we'd need to do it =
for security
>reasons and that without a more secure hash algorithm, Git would =
eventually be
>dropped.
>
>My hope is that NonStop can find some way to support Rust because I =
think it's a
>compelling language and NonStop would greatly benefit from the wider =
variety of
>software available.  My sense of previous discussions was that we do =
very much
>want NonStop to continue to come along as we support Rust in Git and =
that if there
>are ways we make it easier for both, we'd want to do that.  That's =
certainly my view,
>at least.
>
>[0] https://github.com/thepowersgang/mrustc

I appreciate the encouragement, Brian. I have been trying to port Rust =
(and GO)
for years, without success on the platform. It is only POSIX, but not =
Linux, which
seems to be the requirement to do almost anything anymore.

I gave mrustc a try before. It appears to require GCC, which does not =
port to NonStop.
If you have any build recipes that work with c11, that would be helpful. =
We are
Expecting c17 soon. I can run c11 in c++ mode, but the makefiles seem to =
require
G++, which is part of GCC.

