Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB97CF30
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346340; cv=none; b=nzxsHTPIA5vVsFURTbWaCahrYse6g/65RCeQ7QFQMXUSmwiJP6mWu0asNdzk7iGWVxivq88j/Dve1g3EHeoQjFKoQNny1L2YhN795adlNyuYdCk0ygd4dRpxJkG5dpciYwkZ9XWPdkkAiad9xTW2tJ8Atf2X6k6+jPnnvOWwsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346340; c=relaxed/simple;
	bh=PTSfG1qXopYOOz0xNQk/h787unuOdUpNvMmxQ3qi9yY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZT+KXF4x95Jcr3RnOC1c1OJ5Dhb3S/xydQVqLGgbdF5hR1dKnj9lwnnPY2Hyhvv6p0wVrTCImuZPHXtxtRjQx7TuB+7V1E09z3RoMKi/pICZ2z4wm3+b6cSDQTTBrEKaL1ZPRWXdjQokJeXjOwCTFpyqwCwbpUlPI/WTQS8IGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46INjOXL1137379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 23:45:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
Cc: <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" <avarab@gmail.com>
References: <20240718173843.2411415-1-emilyshaffer@google.com> <xmqqh6cmmi8n.fsf@gitster.g>
In-Reply-To: <xmqqh6cmmi8n.fsf@gitster.g>
Subject: RE: [PATCH v3] Documentation: add platform support policy
Date: Thu, 18 Jul 2024 19:45:19 -0400
Organization: Nexbridge Inc.
Message-ID: <00fa01dad96c$8fda8890$af8f99b0$@nexbridge.com>
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
Thread-Index: AQI9HqTdTD3Oq4lRtj8m7TuVu19lpQMQTpnisSAXIbA=
Content-Language: en-ca

On Thursday, July 18, 2024 6:46 PM, Junio C Hamano wrote:
>Emily Shaffer <emilyshaffer@google.com> writes:
>
>> Supporting many platforms is only easy when we have the right tools =
to
>> ensure that support.
>
>"easy" -> "possible".
>
>> +Compatible by next release
>> +--------------------------
>> +
>> +To increase probability that compatibility issues introduced in a
>> +release will be fixed in a later release:
>> +
>> +* You should send a bug report as soon as you notice the breakage on
>> +your
>> +  platform. The sooner you notice, the better; watching `seen` means
>> +you can
>> +  notice problems before they are considered "done with review";
>> +whereas
>> +  watching `master` means the stable branch could break for your
>> +platform, but
>> +  you have a decent chance of avoiding a tagged release breaking =
you.
>> +See "The
>> +  Policy" in the link:../howto/maintain-git.txt[maintainer's guide]
>> +for an
>
>Running
>
>    $ make -C Documentation howto/maintain-git.html
>    $ lynx Documentation/howto/maintain-git.html
>
>tells me that the title of the document is "How to maintain Git".
>
>> +  overview of which branches are used in git.git, and how.
>
>"git.git" -> "the Git project"
>
>> +Compatible on `master` and releases
>> +-----------------------------------------
>
>Underline that signals what level the header is is drawn to the same =
column as the
>header title itself, or you'd confuse the formatter.
>
>
>> +To make sure all stable builds and regular releases work for your
>> +platform the first time, you can make sure `master` doesn't break =
for your
>platform:
>
>"can" -> "want to"?
>
>But "to make sure X, you can make sure Y" feels a bit awkward.
>
>    To make sure ... work for your platform, help us avoid breaking the
>    tip of `master` by merging topics that break your platform.
>
>> +* You should run nightly tests against the `next` branch and publish
>> +breakage
>> +  reports to the mailing list immediately when they happen.
>
>Can't it be daily instead of nightly ;-), or is it better than nothing =
if you can afford to
>run only once every other day?
>
>A topic (unless it is during the shuffle time around -rc0) usually =
spends no less than
>7 calendar days in 'next', so while I would appreciate if somebody runs =
tests twice a
>day, in practice you should be able to catch a new breakage in 'next' =
if you run a full
>and thorough test twice a week.
>
>> +* You should either:
>> +
>> +** Provide VM access on-demand to a trusted developer working to fix =
the issue,
>> +   so they can test their fix, OR
>
>"VM access on-demand" -> "on-demand access to your platform" (iow, =
physical
>iron is also fine for our purpose).
>
>> +Compatible on `next`
>> +--------------------
>> +
>> +To avoid reactive debugging and fixing when changes hit a release or
>> +stable, you can aim to ensure `next` works for your platform. (See
>> +"The Policy" in the link:../howto/maintain-git.txt[maintainer's
>> +guide] for an overview of how `next` is used in the Git project.) To =
do that:
>> +
>> +* You should add a runner for your platform to the GitHub Actions or
>> +GitLab CI
>> +  suite.  This suite is run when any Git developer proposes a new
>> +patch, and
>> +  having a runner for your platform/configuration means every
>> +developer will
>> +  know if they break you, immediately.
>> +
>> +** If adding it to an existing CI suite is infeasible (due to =
architecture
>> +   constraints or for performance reasons), any other method which =
runs as
>> +   automatically and quickly as possible works, too. For example, a =
service
>> +   which snoops on the mailing list and automatically runs tests on =
new [PATCH]
>> +   emails, replying to the author with the results, would also be =
within the
>> +   spirit of this requirement.
>
>It would be very nice if they did this, indeed.  Explaining that =
something that
>mechanically looks vastly different is within the spirit is a very good =
move.
>
>> +Minimum Requirements
>> +--------------------
>> +
>> +Even if platform maintainers are willing to add tests or CI runners,
>> +we will not consider helping to support platforms that do not meet
>> +these minimum
>> +requirements:
>> +
>> +* Has C99 or C11
>
>OK.
>
>> +* Has dependencies which were released in the past 10 years
>
>This is hard to understand and I wonder if we can clarify.  I get what =
you want to
>say: suppose we rely on library X that is getting regular feature and =
security updates
>in reasonable cadence, say every 6 months there is an upstream release =
of library X,
>but a niche platform has ported the library only once long time ago, =
and hasn't
>updated it ever since.  Now the Git project may consider helping a port =
to such a
>platform if the initial port of library X was 8 years ago, but will not =
if it was 12 years
>ago.
>
>But if Git depends on an ultra stable library whose last public release =
was 12 years
>ago, disqualify everybody is not what this requirement wants to do.
>
>I attempted to formulate my version along ...
>
>    Keep up with the versions of dependencies (libraries, etc.) and
>    not to lag behind compared to typical mainstream platforms by
>    more than X years.
>
>... the above line, but to me it is no better than the original, so I =
failed miserably.  But
>the idea I am bringing to the table here is that time of release is not =
absolute.  If
>typical mainstream platforms consider a release of a library made 8 =
years ago from
>the upstream performant, functional, and secure enough and fit for use, =
we do not
>consider that they are approaching the limit.  But if another platform =
uses the same
>library from 12 years ago, i.e.
>lagging behind others by 4 years is a problem at the same graveness =
using another
>library that was released 6 years ago, when other platforms are using a =
much
>younger vintage of the same library released at 2 years ago.
>
>Having said all that, everything I removed from my quote I found =
agreeable.  Very
>well written.

I am concerned about setting a specific limit here. The reason is that, =
as a platform/community maintainer:
1.  I do not control the library versions that are available - in most =
cases
2. I do not control the available toolchain - in all cases
3. Support is required for all OS releases dating back 5 years from the =
close of sales - this is not actually a huge problem except for #1 and =
#2. However, it does not serious constraints on what toolchains are =
available. Most of what we do is use static linkage to avoid a lot of =
compatibility issues, other than OpenSSL that has to be flexible based =
on the rate of CVEs raised and solved.
4. Porting some new tools (e.g., GO, Rust, gcc, libc, glibc), is usually =
impossible no matter what my skill level based on platform prohibitions.

I'm sorry to have to complain about this, but it is a reality of exotic, =
non-linux, platforms that are still being maintained and active (the =
last major NonStop OS release was 11 months ago, and another is due to =
drop imminently, so this is not a dead or dying platform). The last =
thing I want to have is having users locked out of future git versions, =
based on the increasing adoption of git on NonStop that has been =
(immodestly said) mostly my fault. Can we solve this in some acceptable =
way?

Sincerely,
Randall

