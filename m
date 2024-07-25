Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136E55884
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936438; cv=none; b=hxelM1MprvL6ULx8wbHK9WkgaLS2JAQoFvDHzJRCLTS1sKhan9vgbXI4FxZxicay7eaTyjQm7BNqAnj9vjF0c/k6YGaWLMrW15ppWtWjY5DAvQB72lhOqrVI1nTnjxTtD763A2AAyJA+UUzfvzvcYyyqFTVFnPQwtDTEVadf8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936438; c=relaxed/simple;
	bh=Suv23e3x9ucJOwJu25uvOAELYJADO4UDQXnrDdNdpWA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZpeoarYumkAmbarA6aWMqoc0UAk+bR6c4hOovTTukjs+KRtXArA+NI6RTjYgzKJrP4iQ7xlwuDVt6/CF0Etg9OpZO7juWKUzhSoJc0sQjUvYJfgqxfWmg5VvQQWX5pv7iWyCkP+rHSQHRDNZWlZ4Rkc1Ig5NwIttHCvuMxG/h/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46PJeKuR2260772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 19:40:21 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Emily Shaffer'" <nasamuffin@google.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" <avarab@gmail.com>
References: <20240718173843.2411415-1-emilyshaffer@google.com> <xmqqh6cmmi8n.fsf@gitster.g> <CAJoAoZmKD5su=1-kw7x590zVdkqT1xPMs1VumH1j=aMHtD4mcg@mail.gmail.com>
In-Reply-To: <CAJoAoZmKD5su=1-kw7x590zVdkqT1xPMs1VumH1j=aMHtD4mcg@mail.gmail.com>
Subject: RE: [PATCH v3] Documentation: add platform support policy
Date: Thu, 25 Jul 2024 15:40:16 -0400
Organization: Nexbridge Inc.
Message-ID: <05d701dadeca$7ceba8f0$76c2fad0$@nexbridge.com>
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
Thread-Index: AQI9HqTdTD3Oq4lRtj8m7TuVu19lpQMQTpniArH2sF2xFT764A==
Content-Language: en-ca

On Thursday, July 25, 2024 2:53 PM, Emily Shaffer wrote:
>On Thu, Jul 18, 2024 at 3:46=E2=80=AFPM Junio C Hamano =
<gitster@pobox.com> wrote:
>
>[..snipped nits, I have fixed them for v4]
>
>> > +* You should run nightly tests against the `next` branch and
>> > +publish breakage
>> > +  reports to the mailing list immediately when they happen.
>>
>> Can't it be daily instead of nightly ;-), or is it better than =
nothing
>> if you can afford to run only once every other day?
>>
>> A topic (unless it is during the shuffle time around -rc0) usually
>> spends no less than 7 calendar days in 'next', so while I would
>> appreciate if somebody runs tests twice a day, in practice you should
>> be able to catch a new breakage in 'next' if you run a full and
>> thorough test twice a week.
>
>I ended up adding a sub-point to explain cadence preference and =
reasoning, since
>that's a lot to fit into a parenthetical. Thanks.
>
>>
>> > +* You should either:
>> > +
>> > +** Provide VM access on-demand to a trusted developer working to =
fix the
>issue,
>> > +   so they can test their fix, OR
>>
>> "VM access on-demand" -> "on-demand access to your platform" (iow,
>> physical iron is also fine for our purpose).
>
>Done, thanks.
>
>> > +Minimum Requirements
>> > +--------------------
>> > +
>> > +Even if platform maintainers are willing to add tests or CI
>> > +runners, we will not consider helping to support platforms that do
>> > +not meet these minimum
>> > +requirements:
>> > +
>> > +* Has C99 or C11
>>
>> OK.
>>
>> > +* Has dependencies which were released in the past 10 years
>>
>> This is hard to understand and I wonder if we can clarify.  I get =
what
>> you want to say: suppose we rely on library X that is getting regular
>> feature and security updates in reasonable cadence, say every 6 =
months
>> there is an upstream release of library X, but a niche platform has
>> ported the library only once long time ago, and hasn't updated it =
ever
>> since.  Now the Git project may consider helping a port to such a
>> platform if the initial port of library X was 8 years ago, but will
>> not if it was 12 years ago.
>>
>> But if Git depends on an ultra stable library whose last public
>> release was 12 years ago, disqualify everybody is not what this
>> requirement wants to do.
>>
>> I attempted to formulate my version along ...
>>
>>     Keep up with the versions of dependencies (libraries, etc.) and
>>     not to lag behind compared to typical mainstream platforms by
>>     more than X years.
>>
>> ... the above line, but to me it is no better than the original, so I
>> failed miserably.  But the idea I am bringing to the table here is
>> that time of release is not absolute.  If typical mainstream =
platforms
>> consider a release of a library made 8 years ago from the upstream
>> performant, functional, and secure enough and fit for use, we do not
>> consider that they are approaching the limit.  But if another =
platform
>> uses the same library from 12 years ago, i.e.
>> lagging behind others by 4 years is a problem at the same graveness
>> using another library that was released 6 years ago, when other
>> platforms are using a much younger vintage of the same library
>> released at 2 years ago.
>
>Yeah, I think it makes sense to relax just a little bit more, and give =
ourselves flexibility
>to use common sense. I ended up with:
>
>"""
>* Uses versions of dependencies which are generally accepted as stable =
and
>  supportable, e.g., in line with the version used by other =
long-term-support
>  distributions
>"""
>
>It's not quite my favorite, still, because I guess that LTS distros =
could get to a point
>we don't want to support (do we really want to provide cutting-edge git =
features to
>a 25-year-old LTS distro, for example?). Plus, "just look at everyone =
else's
>homework and use that"
>feels a little weird.

A common practice across many commercial and Open Source projects is to =
fix LTS at a 5 year limit and usually for
High-CVE class security fixes. That is, at least, when there is a =
commitment to retroactively fix problems. The
Impression (from the outside of git - until about a year ago when =
"friends" fixes where done) is that the way to get
a git fix is to upgrade. Somewhere in the middle would be more =
appropriate, I think. I do not think 25 year LTS
is common, useful, or even likely, even for exotics (we use 5 year since =
a fixed announcement of a "closed selling
date"). We could designate 2.46 as LTS 5 years from next week, as an =
example, which might not be so terrible. But
LTS tends to be for qualified fixes only, like CVEs at a certain level, =
with functional stability (no enhancements
allowed after a specific date - say "official release + 1 year"). =
OpenSSL is a bit more stringent, where once an LTS
designated release moves past beta, there are no functional changes =
allowed, just bug fixes, and about a year later,
just security fixes. When establishing an LTS, my core requirement is =
that I have a compatible supported
compiler, not just a compiler available. For example, the minimum OS I =
support is 7 years old - 2 during active
sales + 5 years after, which aligns with the vendor's OS policy. This =
also means that I might use c99, but only a
fully supported c99+toolchain, not just one that is available that might =
run on the box. This means that any
shipped binaries are not guaranteed to run on any OS version that is no =
longer supported, including the
compilers on that version - probably more rigid than git would need =
though. May 2024 was a big month
because a bunch of things were deprecated/dropped. This type of policy =
does take active product
management, which, in gits case, would need volunteers who actively =
watch conditions on relevant platforms - I
do that for the git builds on NonStop, so my team stops building git =
versions for dropped OS releases.
My only issue there is cleaning up "dead" versions so people cannot =
download git builds that we are pretty
sure will no longer run (there are complex reasons it is a difficult =
activity).

... but I have gone on too long, but LTS is a very heavy-weighted term =
with generally stringent rules. The above
was really just context for decision-making around LTS, not specific =
comments about the content. Sorry.

>Will keep thinking on this, I'd welcome other suggestions for phrasing.
>
>>
>> Having said all that, everything I removed from my quote I found
>> agreeable.  Very well written.

