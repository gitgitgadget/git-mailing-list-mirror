Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11B6EB7C
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621024; cv=none; b=W+lq80X1rmXFkGw0zLFWGKFjA+GVGchvmRhNND9JwoOCgOsADc9hVk0/xaOxWrx04aJMHlh5zhDj4Xp5IG/s4Oqn9G9RtA0e0wlm6yuPFQNyIDtlrEhXCJMMoqFZYbGhu75+hzO1kNL3d4/XQk5RRFzL/t4JYi/xn4buUoq/5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621024; c=relaxed/simple;
	bh=vyUU1cVWVJRSBNbRWSaruL6UHGnIMDrjZU7OKwbGQcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ch6Py45I3VTMan8IZo8DosgX/nwsHk4Kz4ZgRmMcwTBDB2RXi1mVw9aAFypuVTugziDIBi3+ooTXqFV0KSfzZwM5cWQTKK3i8bcr0pLa74f++R5Afxe3rmheg3UmUSdul+xHs4zkNg3pFJeGF/jG+SLcHbqAtR6E7kxZ+Yz/qTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ihqhiOPw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ihqhiOPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743621017; x=1744225817;
	i=johannes.schindelin@gmx.de;
	bh=0DUV9NvE4fMD8qi4BuExK7VA5eQZ4bybaM1t0Jmk6nM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ihqhiOPw9wI+rre5wdbBo9a3xnHxIjmrZRW+fN/8OJE2hJb5+UxMjFvNXJHvirSS
	 Uwr3Vr4Jp3ejgiV0d5Thhi4MiCcxbOlkqRAGQZtpwNjOhcTuvCx/wGg48UXQQWygg
	 e5WVbObxgGmLAO5DVVrL6t2DLEX1S9ARHTnlICk0i3BH2oCr4NU/rOUZIYdp/NR9/
	 iUUxokQVF9Nvp/xXaf3NFG802piLYABWxm7RVl4nJPV1296K7XhJ4fS6HGyY9Gr/e
	 0RByUSjC9UsVPNdP6kovb0hauxg+nheZdD+usuuViwleZPLtrKVrZZ+Bq/vufaRMw
	 WXmzWuIb2RaTpiKd8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1tr0w40XVR-002o4K; Wed, 02
 Apr 2025 21:10:17 +0200
Date: Wed, 2 Apr 2025 21:10:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 06/20] t: introduce PERL_TEST_HELPERS prerequisite
In-Reply-To: <Z-zkQyRCM3BkovgY@pks.im>
Message-ID: <5a344739-6556-858f-8769-c42e48f01a6f@gmx.de>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im> <20250327-b4-pks-t-perlless-v3-6-b436de9da1b8@pks.im> <ee5e082f-6ab5-b996-9a0d-f7e5192c01be@gmx.de> <Z-zkQyRCM3BkovgY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QOh2y+dIcRKm7Z2dAVgGijFiFO8+nzOuZKymASKKz/Fgw9LUiu8
 u7jJ4iAD+yGVblX7rSwQF08/EHGghYMeDBD5e38jsxfFjDF9G319gzqLN83GpAwJJBkf81t
 2FewGKTsl1iK/uTt0n4eugfrr3LOhBHfmhUZ+D4kfY7OzzDzsr08jlDW7wSN0zSEdY2m+Ad
 B1CqQIkhWhh8CruHK0Z2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6WtBecKXakE=;iQjS9JwzitV05LaFqF0sUuh3N0i
 g4wsVoHUR+23v7LO7H6N1vdjWRTzIBLsvEomv80Vu0PN1VfZ/WJI+K/CLNN3Bjk1jUhPICdCi
 TBebsoFjTq5Hqk622jvv3uRubpOGJ0kKq3Ae81EA/9IHf4/RiKBCrJW1SeOTqfupT8nTuhvsv
 z3tDFDSfSSuJ6Y5xQgUKJVonGTI8r8cLXC17pupDmnsM8xwt3vwT1eoilCEzgwR3w8jmzp4rB
 zBYHr7fGP53y0Sl9lQCxQ1EiMhWR+l2Mi8Yjvifn95M6y1xthncKnT2RJfAP7TU42ddi5h2m0
 p1hJs8KIS9oF1Y4ilzCfHShshuG5AhsLQqyaUnN8cpodknaavIvDucENPYDCZOXDNLFWZbQr2
 7W8LaEnvQB7X53INSTF1li7rNKeJAxFya/e2ee4kQ0qiE5O9pC3mAAAkl3TA2Q2nlU0IKzxO4
 i0ldxrxIUvUidbGUle5o6m9GNVeVRf7446ijxeT/YaIVA0ioYXNd3H4wVLlmwB0kyJHvPBEoX
 i+ecwuBw3TRA419vPnQlnuEVeRRZ0umGuV+Eazx3o5QofxjwsxCajhfOrn044BT+YilP9U6HU
 0N3xuNnSd5ZWIHvpmsOh2t5P33CnMSAPMY70fivLIw0+tPS9Xl//BZZMWeSMY69ZNr40eZRwK
 5O5Bk++RIHhV1y/rOPR+T8kN0pA999Zh5tbQetnCmOXkxgr0YsJ3Vqo4UOiGMX9GKCUHR4OHH
 Tik3MTVTqd7R5OGZ/slYatXx2SP2ug/LnvA+teDY5gLSnit2+Zj48p5R6jE4k/FYiQhzqZ2c3
 srHuNcMAeT+B4OkideE5dH/g+lu7meJmgLXkl2XtW9i0O4jRFFRTv7IWTtjfXNh3jf+unXNmj
 8dV1oaY0w0g4JfI+yb56g2OjFs+ELQTZeWwx8zK2/lEUKE97nq0lApwwoU7br8eQlVzTiiMgm
 B9zd4q4ouQsgTvTwdZuR5QKgWEY6kc6uoSi1wsjfAgnR1JLD9jwfA94P3xgWDtCetQ5t4qGux
 oKFAPXEQU12knj009JTfEejEY/RJBNpMnkQ/waLAQoVPVaA9xWXdAeqOhtNtojvE4G6fiPbV5
 Q2DBeEpf3wwDF2Jdws5Rs0WTFPeIgRh2JJDmq3g0aXxqInnyA9/cqdcqZgDTxilkpyik0HIXa
 5B9eEpR8Ej06vSerf9CwP/+k6NtKX3MNdIMPUGhlRCOFvpYcHGxN/Dx9snIFMIxDVCYho0xG0
 QaOJ9KlTKJcakRsRLIpPOcioFVqRCbWpV1tXvwZfrSQ4BnywXfpkIj06c9WWkGC9Nq7UR2VKR
 TPE43072/MjIE1gP5NWgb592Tl2LN8WOFiBHzzDO0j8aexyMLtkO/JKWx2eJJM2MjD47lihx7
 AmZ7tzoNq2K/xMMuKzM4ufU7XdFUAGIuPpLQqJv2A8NoJRaEdBAcxkz0TDbweF3FhsdOf1oo+
 6xXb3XHJgYhOUnlVOFm8os2pQiBuKZN6Z4GS9yu6YLt7YA+lu
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 2 Apr 2025, Patrick Steinhardt wrote:

> On Tue, Apr 01, 2025 at 08:26:36PM +0200, Johannes Schindelin wrote:
> > On Thu, 27 Mar 2025, Patrick Steinhardt wrote:
> >
> > > In the early days of Git, Perl was used quite prominently throughout
> > > the project. This has changed significantly as almost all of the
> > > executables we ship nowadays have eventually been rewritten in C.
> > > Only a handful of subsystems remain that require Perl:
> > >
> > >   - gitweb, a read-only web interface.
> > >
> > >   - A couple of scripts that allow importing repositories from GNU A=
rch,
> > >     CVS and Subversion.
> > >
> > >   - git-send-email(1), which can be used to send mails.
> >
> > There is also `git request-pull` which is a _shell_ script that runs
> > `perl` to parse the output of `ls-remote`, and there is `git
> > filter-branch` (which was apparently not yet dropped?) that uses Perl =
if
> > the `--state-branch` option is in use.
>
> Ah, indeed, thanks!
>
> I should probably mark both of these to require Perl in our build
> systems so that we have a source of truth what requires Perl and what
> doesn't. git-filter-branch(1) also looks somewhat broken because it uses
> Perl directly instead of using PERL_PATH.

True.

> On the other hand, maybe the better fix would be to just convert tools
> to not use Perl at all anymore so that we can eventually get rid of this
> dependency altogether. It feels like we're quite close, and many of
> these conversions are low-hanging fruit.

As for `git filter-branch`, we could simply -- what were the wise words of
Elijah's mentor? -- "debug" it. I.e. delete it and be happy about it.

> > The patch looks good, in particular when fetching the `b4/pks-t-perlle=
ss`
> > branch from https://gitlab.com/gitlab-org/git and inspecting 8fc639f99=
d9f
> > manually, as it is a rather large patch that is pretty much unreviewab=
le
> > on a mailing list.
> >
> > Using several write-only `sed` invocations, I identified that there ar=
e
> > only three hunks that are neither adding a stand-alone `PERL_TEST_HELP=
ERS`
> > prereq nor adding a test preamble of this form:
> >
> > 	if ! test_have_prereq PERL_TEST_HELPERS
> > 	then
> > 		skip_all=3D'skipping <something>; Perl not available'
> > 		test_done
> > 	fi
>
> Thanks for double checking!

You're welcome. I am a bit embarrassed to admit that it took me quite a
bit of time, I believe it was around an hour, to validate this patch
alone.

Ciao,
Johannes
