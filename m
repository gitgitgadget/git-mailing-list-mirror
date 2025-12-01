Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B22940B
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595862; cv=none; b=eDt/q/NJSqu9OkT7zbW9LEN4PJYL0RElT3PW9g3epeOc51wYHrKBRyKJavJKDRgLFfRf3AJkB73mwrYCWZqTSWxNH/epO1L7mitAgMLN5fr3iStKQXO/i/PIKOv9YinYypw1X1OCzUJVhyAhaSPaGadlZvZDyeGyJl63urYo814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595862; c=relaxed/simple;
	bh=RidGBPsjsnrslTCstDCKgiez3Pemx28CB0HC22pCS0s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iAUMdiPdRqMzOWi5GY/uUe+0pD40l5RhPW2MbAZpg6cQxvGUtbZbR2o6F27jC4z5vR1YsH4Oc5CRf7I2EZUCD8AOkYa+X/Ge5LyW9vmzSJWVqUAEPByh8ojXy6Q76+kPEkzbsCghmGV1T/grsQ/JxKT/VSLYqMnDFakPm22VNXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZcUr6s3O; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZcUr6s3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764595855; x=1765200655;
	i=johannes.schindelin@gmx.de;
	bh=r2ZPJHQ/OkzFoteIH66vZkBrXeA3S4kzJQOs2KEng/U=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZcUr6s3OHIM2nsPaXWGWGY/7yfeDa3Gp3yZnH6tbQj8j2YbQzpP4FBjdEPm1OAz1
	 Zj9U6XdEz6jG9ShsA4Z7Lb5h2qGlYBpHj4r7Y3v+paGyhnx9rdEFvFwfSSZHpt7zC
	 kB7mxBmvOe4iiycnh9D2vFR//RySk6sU64uzqQ+a5k4d8n7CLLqGnwCuG9zVAIHSf
	 JdjIsp0iqV56ytniAHLVKcraJ1hqH2R1Z5dG+MW2lVShOGwjKtsvL63O8T2nhn+Zx
	 FRFZYAz23bVPng9ZhHzqz/dG6vVfO9JsLgFPV85dBX2C2r274ZEMiy1N5DxEJn7Cz
	 hrHlZaijj7B8iAwHGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmfo-1vXJHJ1WSg-00JdO9; Mon, 01
 Dec 2025 14:30:55 +0100
Date: Mon, 1 Dec 2025 14:30:53 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 10/10] t7800: work around the MSYS path conversion on
 Windows
In-Reply-To: <CAPig+cSKmmSewLYp_zAk7y+y=STxPjvG9f5LzrmTbtvNt_AoPw@mail.gmail.com>
Message-ID: <3000e017-189d-e8ea-83da-5bccfd595349@gmx.de>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com> <f7f1e91cef81068f3572b745aebc33d1d2a26c06.1764440906.git.gitgitgadget@gmail.com> <CAPig+cSKmmSewLYp_zAk7y+y=STxPjvG9f5LzrmTbtvNt_AoPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1849102013-1764595855=:16689"
X-Provags-ID: V03:K1:DAvO4qfsJsD7FLirF/LCioh0JCAxQq57Vrh3ZFdL3kLq1r/qtA6
 164HJUPvFfMRhLqY6qj59TrtVRH4+6zEuDRKQuK/2aYMYGy0zOqQ/h2iD3WW3Kx3Ennv3Uj
 3s/mz3ilW/MmHky9AByBQBlKErKXWhK1qNoCmNlAt0COVV76twvXZrtro8bWDPTnwfA+Uhb
 sFR/3kxWHACm/85mBF2Lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FH2/T1jMFCc=;0Pd2YHex+I83RprbxlNySDqh0XM
 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
 OeQlR1fU=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1849102013-1764595855=:16689
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Sun, 30 Nov 2025, Eric Sunshine wrote:

> On Sat, Nov 29, 2025 at 1:29=E2=80=AFPM Johannes Schindelin via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> > Git's test suite's relies on Unix shell scripting, which is
> > understandable, of course, given Git's firm roots (and indeed, ongoing
> > focus) on Linux.
> >
> > This fact, combined with Unix shell scripting's natural
> > habitat -- which is, naturally... *drumroll*... Unix --
> > often has unintended side effects, where developers expect the test
> > suite to run in a Unix environment, which is an incorrect assumption.
> >
> > One instance of this problem can be observed in the 'difftool --dir-di=
ff
> > handles modified symlinks' test case in `t7800-difftool.sh`, which
> > assumes that that all absolute paths start with a forward slash. That
>=20
> s/that that/that/

Thanks,
Johannes

>=20
> > assumption is incorrect in general, e.g. on Windows, where absolute
> > paths have many shapes and forms, none of which starts with a forward
> > slash.
> >
> > The only saving grace is that this test case is currently not run on
> > Windows because of the `SYMLINK` prerequisite. However, I am currently
> > working towards upstreaming symbolic link support from Git for Windows
> > to upstream Git, which will put a crack into that saving grace.
> >
> > Let's change that test case so that it does not rely on absolute paths
> > (which are passed to the "external command" `ls` as parameters and are
> > therefore part of its output, and which the test case wants to filter
> > out before verifying that the output is as expected) starting with a
> > forward slash. Let's instead rely on the much more reliable fact that
> > `ls` will output the path in a line that ends in a colon, and simply
> > filter out those lines by matching said colon instead.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20

--8323328-1849102013-1764595855=:16689--
