Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D18230BC2
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582486; cv=none; b=Fqejw55jRFVkpOYr2LqZIRo8eUjv1nWH9e2amRblq3gONEyQcJ51EEwgkJe2BRrrqJVGqKbhElse58yRZ9U9szK9NLhZv1IvN/i8btFbvk0hmN3tFqGgD9svobTYYaw33Kq5JuP2D162Vow2gHRkk7q5NLr7YYWM2jYtyVEzdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582486; c=relaxed/simple;
	bh=7YmOBWt7Hl/uohilt3kSJ4GkduP+ZNNk3PUHTZ21zK4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mbWUvyG2CFpvi3KBgu8ScRc1750y10nBXe0Tl/wDAlYtVOHKltSgZoHlH8mo++egvugz1Ch/gDWFxLnAYbvQs0Pu+VLXr1Oe7K7dvJTptH+AjHLsXb8zSQ1RiQUmQT6ykN0CNWP4422n7YMfVp/LPC+OIeehqxk9sAVpZiqCPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Ph49lfiQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Ph49lfiQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745582482; x=1746187282;
	i=johannes.schindelin@gmx.de;
	bh=7/2hS5F2nDhwgT5QSGgRf+SKgMS2T3eLJI/+GRK2Trs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ph49lfiQMTEEaQmoj3hxSXAWozGzeHgpRM4bosGflSBqwc1CXh0dYP/U60BNJ8i+
	 Nese5vUYN9KpL7hgZtlj0qgaXeqmm4Aa908bN8eSzDGu9msTJbBEOcaQnR+PQ0lfG
	 W+KeSf+co4GnsWCYzcG9Pid0tcfnhszkI3m/wGbiXwp2/Ev4IRGUBVqH/lsy0zCr9
	 QjRT1EoRxUkyLNyY+JCLO7LF4Gn27KtifR0v1LrxpsavteizhI//WkjtzN339cP9S
	 pei8rV4tQ0rtEK0Q0B4shlY8AMsaLdLDU2p7D5JWkjlpsVxz7cm+gzSOpgUTsdTLl
	 ++nxnNyNJqq9g46CJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.52]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1uiAzf0xde-00bQos; Fri, 25
 Apr 2025 14:01:21 +0200
Date: Fri, 25 Apr 2025 14:01:20 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: skip unavailable external software
In-Reply-To: <aAsNUYUKJZbrMCf2@pks.im>
Message-ID: <a80a320b-80ca-3d61-a4a2-f2528e7ca053@gmx.de>
References: <xmqqfrhxtdg9.fsf@gitster.g> <xmqqmsc5rw94.fsf@gitster.g> <aAsNUYUKJZbrMCf2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZFrDUSMsKJZzG1ARE1OkLr2lCIlRn7o51BHTwCa1bvy3Y6aUnRg
 DURfVGmdNLoXHvXvjVrMRgHPZiiDtbBy+8q4YYH92ToulLtUmUagBrrRKRR680PeqXIhd6O
 /skPavxgV2NSdjwGkFx6wREVuwzbHFoqRRlK5H3XSFvUsVjjdGR9I6Wl7rgEvzujJTq4D2R
 7v9qtNRk5CCEJL8xMa2dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ho2TELP4XzY=;mbpXrTa6dBj5V2HbTpIxSjTqt4D
 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
 sMwiq/s/5g==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 25 Apr 2025, Patrick Steinhardt wrote:

> On Thu, Apr 24, 2025 at 04:10:47PM -0700, Junio C Hamano wrote:
> > The ci/install-dependencies.sh script used in a very early phase of
> > our CI jobs downloads Perforce, Git-LFS, and JGit, used for running
> > the test scripts.  The test framework is prepared to properly skip
> > the tests that depend on these external software, but the CI script
> > is unnecessarily strict (due to its use of "set -e" in ci/lib.sh)
> > and fails the entire CI run before even starting to test the rest of
> > the system.
> >=20
> > Notice a failure to download to any of these external software, but
> > keep going.  We need to be careful about cleaning after a failed
> > wget, as a later part of the script that does:
> >=20
> >         if type jgit >/dev/null 2>&1
> >         then
> >                 echo "$(tput setaf 6)JGit Version$(tput sgr0)"
> >                 jgit version
> >         else
> >                 echo >&2 "WARNING: JGit wasn't installed, see above fo=
r clues why"
> >         fi
> >=20
> > will (surprise!) succeed running "type jgit", and then fail with
> > "jgit version", taking the whole thing down due to "set -e".
>=20
> Yeah, I think this is a sensible direction to go. It is unfortunate that
> this may lead to silent breakage of these dependencies unless somebody
> explicitly looks for those warnings. But that feels like the lesser evil
> compared to failing the whole pipeline.
>=20
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  ci/install-dependencies.sh | 31 ++++++++++++++++++++++---------
> >  1 file changed, 22 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 0df74610d0..e51304c3b0 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -66,16 +66,29 @@ ubuntu-*|i386/ubuntu-*|debian-*)
> >  		mkdir --parents "$CUSTOM_PATH"
> > =20
> >  		wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
> > -			"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
> > -		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
> > -
> > -		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION=
.tar.gz"
> > +			"$P4WHENCE/bin.linux26x86_64/p4d" \
> > +			"$P4WHENCE/bin.linux26x86_64/p4" &&
> > +		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
> > +			rm -f "$CUSTOM_PATH/p4"
> > +			rm -f "$CUSTOM_PATH/p4d"
> > +			echo >&2 "P4 download (optional) failed"
> > +		}
>=20
> I think it would be preferable to only handle failure of wget as chmod
> shouldn't ever fail if wget was successful. The same is true for the
> other downloads -- let's be as strict as possible but allow failure of
> those actions that depend on the network.

That is true. It would probably also make sense to mark the message as a
`::warning::` on GitHub (and the equivalent on GitLab), so that it is
shown a bit more prominently in the CI summary.

Further, as per Matthias Sohn's (i.e. the JGit maintainer's)
recommendation at
https://discord.com/channels/1042895022950994071/1364872237710184520/13648=
86912044765216,
the JGit download link in particular should probably be changed to
https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit.pgm/6.8.0=
.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
(which would work around the CI failures as well and could take the
pressure off of working on more graceful dependency management in Git's
CI, but then, we don't need more time to discuss the patch in this here
thread because it already was fast-tracked to `master`).

Ciao,
Johannes
