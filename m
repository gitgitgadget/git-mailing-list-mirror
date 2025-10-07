Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34E2E92A3
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858597; cv=none; b=CNNIEG0V25qn/nPDN23szOJxU9jwZ9XT+vojYQg/dmdFk1WO9pHs9wHniTwmoKi5BlV63QifL6eqtEg5v88odj7i4CvqCC924vzk8QAPdMDTBL8l4gr1zN7/GtdGDnUDH+7abL4IFz3wN7POlwGbthBAq8ta3t9VColS11IlT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858597; c=relaxed/simple;
	bh=KmC7fpvC4xgRDbLrrYvKrYDsm0ZMuLbMU1e4gfzYTSI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=A9k6jrZ89Lrzzq8Jf4+Od6CMRCThplpisNCVgRmRDRN6Z4wCaYOt5O2Pl+vaYRORhbBHv9Erl5zduAW2Ix94OEAX9UBHSCUwRoHM3W93nn5p1Dra07LZ7njNcZ2a+PyDILvGcKx/AfMKk0NoWQ+Kp9pKGaKtZYY4P3bIDswnwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 597HaMbr1480018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Oct 2025 17:36:22 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>, "'Ben Knoble'" <ben.knoble@gmail.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>,
        "'Luca Milanesio'" <luca.milanesio@gmail.com>, <git@vger.kernel.org>
References: <aN5-n_ArhQqaQZgt@pks.im> <D59D0576-63C9-4144-B49E-54D43A80E0B0@gmail.com> <aOTrBAXhKF4iYzQB@pks.im>
In-Reply-To: <aOTrBAXhKF4iYzQB@pks.im>
Subject: RE: When should we release Git 3.0?
Date: Tue, 7 Oct 2025 13:36:16 -0400
Organization: Nexbridge Inc.
Message-ID: <00ff01dc37b0$e5bfb430$b13f1c90$@nexbridge.com>
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
Thread-Index: AQIKTgEoCIx2TxbMnA2paTGIZAqD3QGQZ4q0Ac23OgO0P9QIIA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 251007-6, 10/7/2025), Outbound message
X-Antivirus-Status: Clean

On October 7, 2025 6:27 AM, Patrick Steinhardt wrote:
>On Thu, Oct 02, 2025 at 12:54:13PM -0400, Ben Knoble wrote:
>>
>> > Le 2 oct. 2025 =C3=A0 09:33, Patrick Steinhardt <ps@pks.im> a =
=C3=A9crit :
>> >
>> > =EF=BB=BFOn Wed, Oct 01, 2025 at 12:04:38PM -0400, Taylor Blau =
wrote:
>> >>
>> >>
>> >> So my feeling here is that we should take into account not just =
the
>> >> readiness of the underlying Git implementation used by hosting
>> >> providers in the Git ecosystem, but also the readiness of the
>> >> hosting providers themselves to do the work necessary to =
facilitate
>> >> that transition outside of their Git implementation.
>> >
>> > We definitely should take into account the readiness. But what I
>> > think we'll need is a roadmap from impacted Git implementations and
>> > hosting providers so that we can answer the question when they plan
>> > to have
>> > SHA256 support ready.
>> >
>> > Without such a roadmap it's basically impossible for us to set up
>> > any realistic date. In that case, we only have one of two options:
>> >
>> >  - We just wait until eventually everyone has SHA256 support. This =
has
>> >    the effect that there is no pressure on anybody, and thus it is =
more
>> >    likely than not that it'll just never happen.
>> >
>> >  - We set a strict, "uninformed" deadline that may be too ambitious =
and
>> >    unrealistic.
>>
>> This seems like a false dichotomy to me. Of course we can forever
>> debate options to go forward, too, so at some point we must have a
>> decision :)
>>
>> Anyway, what about establishing a strong but adjustable =
(=E2=80=9Cproposed=E2=80=9D)
>> timeline now, based on informed opinions from folks who have already
>> provided estimates of what=E2=80=99s required? Then we can shop =
around for
>> input on the proposed deadline while still taking into account new
>> information.
>>
>> It also provides impetus: =E2=80=9Csans input, we will go forward =
with the
>> proposal, so let us know if you need more time=E2=80=9D might =
motivate folks
>> to firm up their own timelines and provide said input.
>
>Yeah, it's definitely my goal here to do exactly that: reach out to =
folks and take
>everyone's input into account. Once we've got it, propose a timeline.

My own blocking situation is a lack of Rust. This is being discussed by =
the OS
vendor and I hope we get some progress soon. I do not control what =
"soon" is
but it is at least a year. This is HPE NonStop.

>I guess as part of that initial communication with the stakeholders we =
can also
>mention that the current plan is to release roughly towards the end of =
next year,
>which may help to put things into perspective.
>
>> > Once we have roadmaps, we should set a strict deadline that takes
>> > them into account. Any hosting provider or implementation of Git
>> > that doesn't provide a roadmap will not be taken into account in =
our planning.
>>
>> Btw, I=E2=80=99ve often wondered since I see representatives from
>> GitHub/GitLab (and JGit/Gerrit to a lesser extent) often prominently
>> identified as such: do we have folks from GitTea/SourceHut/other
>> smaller forges around on the mailing list to weigh in? I assume =
we=E2=80=99d
>> also like to include their input.
>
>Such smaller forges should definitely be included. My plan is to gather =
a list of
>stakeholders for now and then send an email where we Cc maintainers of =
such
>implementations.

My own front-end implementation has been ready for SHA-256 for 2 years =
and
have been (im)patiently waiting. I have a distinct separation between =
git version
and implementation so there is no direct dependency there. Only Rust =
availability
on the git built is holding my own situation back.
--Randall

