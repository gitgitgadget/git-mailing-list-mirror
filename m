Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F51CAA79
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308184; cv=none; b=jJ8MxfixOlWM6Zg0PfTrLBDtmcLHwIcWlhXsBk/ET+Gc6IrKY/4PsKDo4q9iH8y5u5NITzIi1qxiyrb43s4pZi0tyDzLYoiwbtuZWMPYiMQ/YE7hVmO2BvDVKpsYBnjv+NE07La93d2L8NXZg+3tOSdfpdLqW3XJ0TabN9T8BKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308184; c=relaxed/simple;
	bh=qeqvMVDsXZuoInzMRgZiuGxBN5PQlpzO+BRyebJeb84=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q5jPHQ2BBAAzcaFrnpel7q55+dpp1/Bn7yR15Br6wxfxJ7S1L0x/t9OHXbfSC2h18CXnRxSYay1lm9Uf0kQzKayBOsAqYQ7uAw9Z8CtyB4DShtpW9NrG6ZPOlsP1JGIW60KZFHyCDdPgj+jXGpsjnw+5v8x+VBV1UDYJZpeHRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=O3ZE/iYY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="O3ZE/iYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745308180; x=1745912980;
	i=johannes.schindelin@gmx.de;
	bh=29bjZR6P6Pa93qdPyVS7p00betFm8WM68r5CalqGazw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O3ZE/iYYY6+oijHRc1DPc87VcQnGN607J6VYn39VyFDOzHk9XZAuuded97X72s7m
	 OTFafCResPlfa7iN82qP6ufBmL+T8t6TyRoPKUZgmOQGUzFMzAUDkFHunfpRWhVJr
	 Wt6XBjxZOH/NitvouFXgfj5dVA+eorwM7azhIeShM7wyCnRhCdVc+Tgiolv5I6sRA
	 uIAzCWmPpn0r7DudXVCBRgXyCJk9GY0Xz7eiz+AVIhFWjrQ3YRIYZo5UNhnoh27fQ
	 RrgpGNTzMMXgA+fhBLxjAIZqoN+ZAcO8W5w75iMHYgGkBN3UjGDlXi5agTefZi+Bw
	 XFDa1nhPslC1uREq4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.53]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1uAj152IOB-00Bz0p; Tue, 22
 Apr 2025 09:49:40 +0200
Date: Tue, 22 Apr 2025 09:49:40 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 6/6] max_tree_depth: lower it for clangarm64 on Windows
In-Reply-To: <aAdImbydzMUkCFqB@pks.im>
Message-ID: <17780ada-bb64-c780-939f-0702f53dd3ca@gmx.de>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com> <6ebc3ef57fd0455fc70c4a8531c7ed094d9cdaff.1745239150.git.gitgitgadget@gmail.com> <aAdImbydzMUkCFqB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OiOEl7PoznwdBLLLxYAzwhXXX0Vtt5AdF8VuiWMNc4dwzmZ2fH9
 oolhbrENjdGREXoH2r0bn6ELBNjExVAzglTdj7Ci6QXhM/arkJJL4d5BbpIKhGlo6+4FMlS
 gOBnIrAomqTWqF16hTMsDXsCF11YSf+La7FV7bQSDgZrw794hzo6rnc8UA2LfQbi9bO5xLU
 qpap3NHYB9pHHMo1sKWXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EJX2kee8WrI=;9p7UKioD+WIOdQgkwWRT4WYDt73
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 22 Apr 2025, Patrick Steinhardt wrote:

> On Mon, Apr 21, 2025 at 12:39:10PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/environment.c b/environment.c
> > index 9e4c7781be0..cc853950bb2 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -82,9 +82,21 @@ int max_allowed_tree_depth =3D
> >  	 * the stack overflow can occur.
> >  	 */
> >  	512;
> > +#else
> > +#if defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aa=
rch64__)
>=20
> Tiny nit, only because it puzzled me for a second: this should probably
> be `#elif`.

I will change it.

> > +	/*
> > +	 * Similar to Visual C, it seems that on Windows/ARM64 the clang-bas=
ed
> > +	 * builds have a smaller stack space available. When running out of
> > +	 * that stack space, a `STATUS_STACK_OVERFLOW` is produced. When the
> > +	 * Git command was run from an MSYS2 Bash, this unfortunately result=
s
> > +	 * in an exit code 127. Let's prevent that by lowering the maximal
> > +	 * tree depth; This value seems to be low enough.
> > +	 */
> > +	1280;
> >  #else
> >  	2048;
> >  #endif
> > +#endif
>=20
> Hm. This whole construct feels rather awful, if you ask me. Instead of
> papering over the issue it would be nice if we eventually fixed the root
> cause, which is that we use recursion on a data structure that has an
> unbounded depth in theory.

True.

It is also quite awful that I cannot find a way to represent
`STATUS_STACK_OVERFLOW` by anything else than exit code 127, which always
misleads me into thinking that an executable or a DLL might be missing.
But I did not find any.

> Anyway, that is clearly outside of the scope of this patch series, so
> the bandaid is good enough for now.

True enough!

Thank you,
Johannes
