Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8220C492
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781479; cv=none; b=MF9I40VRzv6PJV+CqiOfv2YWlxUo5iL8cxR8rS3yf+jK5cIjSZKMWpQXUt+SOVt9qosRuuQFopZ1bqBgkleTAyQtaQmxSUBpHNjQNRJTuO/eaife1D2KUrkg0ApQQyaaZZQizJLjw4ObKnhBT83PzT9S21FwCcmMtRFPBJH+K1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781479; c=relaxed/simple;
	bh=T9xxhcjSBmSATmKxJEaFzT5u59lDldIuxsX0kbE3WAg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZDc/HYtrVoYoNKAN7o0flVlRv7D+HAETuL//SNki5p57g5+BzSG/pZunGTveJdI8i4gk1mC6CbpWOQYli3VL4SugWizzbI8ivtSSqtbPU5bqK6DACZIrjf6OjBGg/9HzvzaiIoKXIjBlIBCTSaHeiXyAIGPCLYg9/13VkZYk/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dnO0CtpX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dnO0CtpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744781461; x=1745386261;
	i=johannes.schindelin@gmx.de;
	bh=7i6IgrnF0CukRHkIiQQKVtyAgL7gReYmXf6AoAoz1Cs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dnO0CtpX2rcAFtk0EYIURusWkaCFj8jnT8iSrlbhI4pFtv7jasI/LzGHMmeK5F11
	 GhQOgWVBehtDPvTaXWvzFZnBkcmkQwKzqXeYCwXQof6lCbgkQGztJuutg0ap81KP0
	 8ybeKa6DWW5s28j4GKgfluu96Kk/i4YbQkAHGlIa9y+M+kcbXc0TGpcgwDgHS1a/p
	 Zyur0SEAdgZ5KyWae20EjhBNhzoejOnlZVgSI9ADdVjpLyE3qJ8fEtEA66Aa+T+Qd
	 AsHcgeW6tZIYUfKEdbSzcgbn3xPhvd8cLhbZPmZUY6mukDIvsXpj5uglTee7q0QHD
	 39HSGZziUKZ/VnB+fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.9]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1tggPN0sAK-00QXWx; Wed, 16
 Apr 2025 07:31:01 +0200
Date: Wed, 16 Apr 2025 07:31:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Todd Zullinger <tmz@pobox.com>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFH] fedora: pedantic fails complaining that awk is missing
In-Reply-To: <Z_80oMscHcR4pyvf@teonanacatl.net>
Message-ID: <81209cfd-049e-c853-9c4a-2cf9803e56a4@gmx.de>
References: <xmqq34e9kmef.fsf@gitster.g> <Z_80oMscHcR4pyvf@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qSJIlILLA17NOpNKOGhyFhdryfMp++OfXZgAPBrewgvxG6ZxIAm
 xFDuJbMmaLuApewmtAyQkBQ5p6gWE/Cy7JTO5E/M9h4ZrjH5MWTJMNEtBHNdzcDRXWOhcQP
 G9MZk0JIGyupJnyK4WAWXlLFBQRUAv5ZYDpr4Mhu+HL8J17tBiQAgNITvuaFZ0CAm7CYxmj
 OSYJ2XdcOUTgz0V6VDb9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eny+ATOI5gQ=;AuMgVIeo88NRZjzwelx0NoyPCYI
 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
Content-Transfer-Encoding: quoted-printable

Hi Todd,

On Wed, 16 Apr 2025, Todd Zullinger wrote:

> Junio C Hamano wrote:
> > GitHub Actions CI started failing the pedantic (fedora) job at the
> > tip of 'master' few days ago, and the log claims the failure is due
> > to missing "awk".  Even though we have seen a few topics to rewrite
> > Perl scriptlet, and I think at least one of them uses awk, but they
> > haven't hit 'master' yet, so it is puzzling why this started failing
> > all of a sudden.
> >=20
> > So here is a band-aid.  I wouldn't be surprised if the base image
> > was updated without telling us.  We have seen Ubuntu 20.04 base
> > image retired to cause CI failures as well.
> >=20
> > Almalinux does not even seem to have awk available as a package
> > (or it may be called differently, but we are not suffering from
> > the lack of awk on that platform anyway), so make sure we ask for
> > awk only on fedora.
> >=20
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >=20
> >  * As the scheduled retirement of U20.04 image broke CI jobs running
> >    for 'master', I started looking at making it pass again with the
> >    minimum change, i.e. by merging dd/sparse-glibc-workaround and
> >    js/ci-github-update-ubuntu topics.
> >=20
> >    Then I somehow found that another job is broken.  And this patch
> >    seems to make it work.  Not knowing how it got broken is
> >    unsatisfactory, though.
>=20
> I can hazard a guess (or several)...
>=20
> It is likely that the image pointed to by the fedora:latest
> tag has moved from fedora 41 to 42, which was released
> today.  The fedora 41 container images have awk installed
> while the fedora 42 images do not.  That change is, I
> suspect, just part of reducing the size of the base
> container images.

Thank you for that excellent and thorough insight. This is indeed the case
in the instances I looked at (for example, Git for Windows' `shears/main`
branch was using F42 most recently, and failing:
https://github.com/git-for-windows/git/actions/runs/14485163916/job/406293=
42280#step:2:38
whereas the preceding build used F41 and succeeded:
https://github.com/git-for-windows/git/actions/runs/14473893559/job/405946=
56287#step:2:37).

> In both AlmaLinux and Fedora (as well as other RHEL
> derivatives/relatives), awk is provided by the gawk package.
>=20
> On Fedora, `dnf install awk` uses the package filelist data
> to determine that /usr/bin/awk is provided by gawk and
> installs gawk as a result.
>=20
> On AlmaLinux (8 & 9, by my quick testing), that is not the
> case and you'd need to use `dnf install gawk` or `dnf
> install '*bin/awk'` to get it installed.  Though awk is
> included in the current AlmaLinux 8 and 9 images, so it
> isn't strictly needed.  But it's probably better to be
> explicit that we need it installed, as a defense against
> some future change to the AlmaLinux container removing awk.
>=20
> Using gawk (or even '*bin/awk') would likely be clearer.
> That avoids relying on 1) a case statement to set an awk
> variable; and 2) the different behavior of older and newer
> releases of dnf with respect to the install argument
> matching on the names of binaries provided by the package.
>=20
> But that's certainly subjective. ;)

This reasoning is very convincing, so I allowed myself to turn that into
the following commit (which fixed the build:
https://github.com/git-for-windows/git/actions/runs/14485317015/job/406297=
41228):

=2D- snipsnap --
=46rom 4890df8bf1c1311ef0c3b5a92412ccc4f833f944 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 16 Apr 2025 07:17:24 +0200
Subject: [PATCH] ci(pedantic): ensure that awk is installed

The image pointed to by the fedora:latest tag has moved from fedora 41
to 42. The fedora 41 container images have awk installed while the
fedora 42 images do not.  That change is most likely just part of
reducing the size of the base container images.

In both AlmaLinux and Fedora (as well as other RHEL
derivatives/relatives), awk is provided by the gawk package.

On Fedora, `dnf install awk` would work, but for unintended reasons! It
uses the package filelist data to determine that /usr/bin/awk is
provided by gawk and installs gawk as a result.

On AlmaLinux (8 & 9, by my quick testing), that is not the case and
you'd need to use `dnf install gawk` or `dnf install '*bin/awk'` to get
it installed. Having said that, awk _is_ included in the current
AlmaLinux 8 and 9 images, so it isn't strictly needed.  But it's
probably better to be explicit that we need it installed, as a defense
against some future change to the AlmaLinux container removing awk.

Using the package name "gawk" is the right thing to do.

Note that even '*bin/awk' would have worked, but it is less specific.
And who knows, maybe in the far future a BSD variant of awk is offered,
too, and would then cause ambiguities. Best to avoid that.

Suggested-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 8700c0f2924d..be9ba5e30a47 100755
=2D-- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -31,7 +31,7 @@ alpine-*)
 	;;
 fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl pyth=
on3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/=
dev/null
+	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl pyth=
on3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-dev=
el >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
=2D-=20

