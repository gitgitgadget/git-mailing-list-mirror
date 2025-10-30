Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED680270EC1
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814187; cv=none; b=jEjH9FDGOxF+1GSlYDAAS4OXb09U1oN6crlL+WBWeHpVNFBYNikI5tmy8SycSUVfFxux2W60y5c/y+f6kdo585iiD0lrM5dPBHh3Bs/MlTK/3svn+d2QEf4ZGWfldv87sjf319NcUjKjHIyvW/WIRwqKlhqYujbZDaXKjYxjW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814187; c=relaxed/simple;
	bh=DJERn+0LhEOHODecXog3NxFmWTcjxMp9Oh7DqJCfWoA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dd/gNxhvPjqvvgrP3/BvfDj2xeqWdhlEXkYqmiVblu1AiQy1Aj1Xqs5AGIGUxIEtl3YX/e0BhPGK5yuP9EpGndrafdbvYrZ0RvV8gomzhA81z2G6oTrM3yDnRh4eKoHYnGUeZr+gXSoY2JqB7kZytFnfebbLhb0hn3dejR8SYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=nl9P+lVA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nl9P+lVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761814182; x=1762418982;
	i=johannes.schindelin@gmx.de;
	bh=41R7dHlLFtFEHZTjCWFXzw0gQfTIE1SZxOsjOOGIfBg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nl9P+lVA9lxf54kLAOA+Hq4JXBwYFQ5S3jx2zKxgYMmH9AWLgFQVX7mRL8Mtk49K
	 SDKaQXSrrmlq2CZBD6fLSYF27wknq0HVMRRBoMf9aiHQB31hAd7kANxrtBHJVBgSk
	 2gdYobEk8nHqjwxR3zQvTbzUBWGSa7oDQwlVZf6XfCVnWMXcSlE4ScvyzExuUWI9g
	 xbAaC/q9z6ZJPmUb+0QobSLN3V/iVWmvcX73LSm8BzHMsIEqa7tcV6JOkA2Ay6DWp
	 lsXl6K/YlFsA11xnFShs8nWu3GPORaxroLibZ4bN72DmbHryfx/b9UGwTYjevuzsg
	 0zILg8m3AePkVAQgYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1vqCk525R1-00iOpA; Thu, 30
 Oct 2025 09:49:42 +0100
Date: Thu, 30 Oct 2025 09:49:41 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Devste Devste <devstemail@gmail.com>
cc: git@vger.kernel.org
Subject: Re: git clean deletes negated pathspec if directory causing data
 loss
In-Reply-To: <CANM0SV3qgqjWeAu+NvfPxeDLgo6-eRWKmi9xkpUtN6w7LJh7oQ@mail.gmail.com>
Message-ID: <a77f4e6f-86a3-ea15-feb5-4d08636ffd94@gmx.de>
References: <CANM0SV0R7OYJKeBAs5-WY2Wqp7VxhKv5=LQ4cuDd6MaQwNqGNw@mail.gmail.com> <CANM0SV3iRF=jVAFj=+rrgOC_nXEJ=_v1bUG88n3T9+PQD=a2-A@mail.gmail.com> <CANM0SV3qgqjWeAu+NvfPxeDLgo6-eRWKmi9xkpUtN6w7LJh7oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2DvV+VwQiunf8XV2NGFKHm01gI5PesKT3SmZ7C3tF38lpD49U94
 CVdJvVYfjs+Dd45xCMt7S8IybU7BCHUWnGCDsXE8cEPuyeJQdNBjm0K3kG8J52YzoBLT7d8
 OI5Rk9CGaTSPgwtjpx7ssTYckUmVNJte6Fqlj2V/VnRCYLlvLCOe4ZFIdMdUQQghTc2QVya
 aGQCudojxaJSyoEPstIIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b78I0A2evUM=;EasabeMmdbbMdUN/svdygMQKNgM
 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
 Eghz2jDlN6eaGoMlnIA/d4zwqzStqJfBMGQoAT
Content-Transfer-Encoding: quoted-printable

Hi Devste,

On Wed, 29 Oct 2025, Devste Devste wrote:

> Anyone?
>=20
> On Sun, 5 Oct 2025 at 13:33, Devste Devste <devstemail@gmail.com> wrote:
> >
> > Just to clarify: it's not about the negation not working, but clean
> > ignores the pathspec for ignored directories completely. I only want
> > to delete .rej and .log files, but it will also delete gitignored
> > directories (that may or may not contain any .rej or .log files)
> >
> > On Sun, 5 Oct 2025 at 13:27, Devste Devste <devstemail@gmail.com> wrot=
e:
> > >
> > > I am using:
> > > git version 2.51.0.windows.1
> > >
> > > Run:
> > > echo .idea/dictionaries >> .gitignore
> > > mkdir -p .idea/dictionaries
> > > touch .idea/dictionaries/foo.xml
> > > git clean -f -f -d -X --dry-run -- ':!/.idea/dictionaries' ':*.rej' =
':/*/*.log'
> > >
> > > Outputs:
> > > Would remove .idea/dictionaries/
> > >
> > > No matter how you specify the pathspec (':!.idea',...) it always wan=
ts
> > > to delete the .idea/dictionaries directory, even though it does not
> > > contain any .rej or .log files and is explicitly set to excluded

I can reproduce, both on Windows and on Linux. (Note that I prefer the
`:(exclude).idea/directories` form because it is more descriptive and it
also does not run afoul of Bash's special handling of the exclamation
point).

Unfortunately, the code in question is quite convoluted, and the intention
is also not quite clear. The main problem seems to be to agree on what
`-X` should mean in conjunction with `:(exclude)`.

One interpretation (which I assume is yours): When `-X` implicitly adds
items to be removed, `:(exclude)` should be able to remove them again.

The interpretation of the authors of the logic I see in the source code,
though, seem to treat the `-X` as a completely separate mechanism that
overrides whatever `:(exclude)` may be specified on the command-line.

Honestly, I am unsure how to resolve this, especially given that the
overall architecture of `dir.c` (which contains the business logic of
exclusions specified e.g. by `.gitignore) seems to have grown so
organically as to result in a complex, hard-to-reason-about state.

In case the Git maintainer (whose call it is, ultimately, on which side to
land regarding above-mentioned options) sides with your interpretation,
here is a patch to add a regression test demonstrating your use case:

=2D- snipsnap --
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 6f16f389319..6bc7c42a572 100755
=2D-- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -362,6 +362,14 @@ test_expect_success 'git clean -d -X with ignored tra=
cked directory' '
=20
 '
=20
+test_expect_failure 'git clean -d -X with :(exclude)' '
+	test_when_finished "rm -rf build" &&
+	mkdir -p build &&
+	touch build/lib.so &&
+	git clean -d -X -- ":(exclude)build" &&
+	test_path_is_file build/lib.sh
+'
+
 test_expect_success 'clean.requireForce defaults to true' '
=20
 	git config --unset clean.requireForce &&
