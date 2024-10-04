Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31688146D6E
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040290; cv=none; b=Kfe05mbC1P6Hn48uBjVgJl8N9nR7+8UMvMSt5hcu2S8m5d01LuN/vG8Cj1UL/GZ1MWepNDQn+Jk3+8sd/9CiNUlwMmhGrBZMiDKgQ89+3KxMFJm2424vEM35b+mcKTetJe8sKhFbo1XmuWa7NI9cXQJmUgfa4h97aYPjqV9pLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040290; c=relaxed/simple;
	bh=mQDjtGxjWnC229NwdvZp197oTfAGNTCu7hlEXuejSwU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t4Y+PoQtZ/jA65+3ohVkt+SM41K/1XSS/6Lb2w6R6VFX0yeRzFeW36+EVtHHxC78QKeqDdC36cL0WxF45ZhK3UHRlyDie0NqXEniOdL61nEzuZlDVNJKovSfaRsXx3+otSF22x26TMB6o6dfcPJDsM2tfaEeZYh2EmK4t3/VlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=A/8m93nc; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="A/8m93nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728040276; x=1728645076;
	i=johannes.schindelin@gmx.de;
	bh=l2NkwIL8NsBdkRMY4KlPgPVzt4U0ZQHq2O9ApE29dxA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A/8m93ncl9eTIgkWQIQiAHtJ5osinC1WDr80/parzE2UD0/iZVVjqzdF4ls13ijv
	 XBfkL9uhIwaVDMkamsSgaYYUoNKNc09MlDfcp1M91uyvjzEZRC2M3S7+NuJOf3YrP
	 2Kqg6JgprENFrhhVjqjDRcpf2akrqvx19+Ar8u3p98BAm4bTWEKqtGGJkhFoG0oED
	 jTwsdnZc2yhYSYDjkM7oF+nMrjMju8SWYmDvXuhaSRN2XGyjA9QUxb6i3v9V9QWtP
	 PJigv6PNw0XQzaRCy9Vk/wWKzhzK+IizPGtTm6rRU+tfzDfl6Foe8t43M0QFTqJLH
	 X1G8SahzFEIrM7VdlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwXh-1slQkc3OrB-00HALM; Fri, 04
 Oct 2024 13:11:15 +0200
Date: Fri, 4 Oct 2024 13:11:15 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, 
    GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.47.0-rc1 test failure on cygwin
In-Reply-To: <Zv--68J5qv60IuQz@pks.im>
Message-ID: <f29241a7-aadd-e824-97f3-a95ac6619951@gmx.de>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com> <Zv9oIrKveu-JAGQM@pks.im> <Zv-HbT8qrM6IYKb4@pks.im> <8718c5c4-1d0a-104b-eb39-6338ae9c5dbf@gmx.de> <Zv--68J5qv60IuQz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M1nbcqdLMyTg/PbxA2XYWZ6n3FjOTFSnr+RopkcKWUjO6+XlMnN
 Fso2SfERLs35cG2QtX/krKElf1G/i9udAi7QR7VdgiZww44+40a5BfjDKdmiA7RMPgJuhkQ
 KmUI0uUJfYUv2uA3gBvhv+PLhF0+eriTH3m5JkRJz8OETMoj/NYG3bVOaPeyIAli2awLNY0
 AYcs9KFIkH8DMLK4djS1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vzILgQ3Pg84=;h1lI0ih8zrbZ7aYfyoGaWiWKTf4
 aHxA7e9tlMMxlen6Yaj7wbGy3blTrUk7POmXJ0FF5f2J6DEYS/CUE2tRHW/fbTl6xILCTcuzR
 JndbTYyFOjJxh6u5WnxhZhNyW80BLQEHNSj85PL9EH5sgFTjQ2lE6+fRjMRSkUYCjMpFx5Fwm
 9TWNdPWXiJSlwTgx5wIdNP+tRip72iN8+w09LDOIcSblkDoDBRjE6a8Bm+Q0d6fTSf5Ro4lTT
 7COwAmUqatDqyU/cujI32DZpDwAuazDetbLjAwJAbVSHVoXg6x2VtniTUfR/5GDnab3S+1Ruc
 97FPqAf5OrWopUSq6+zo17/UjdIpYcMJ5fov8ZULppSpuMECTLenJCdboHda7HVUd3n65E1Mc
 6l+CCN+sque+rJCIAK4VlLKtznUHWvJqGRbgIgKL2whcOMXoAjj9imcm8fmbOht3evv/pn6Sk
 5Xtd/55Qse9+slh0/mUkk8aioh6DX4EuNnbVI2/I3ArS5c35jPzOKNfKbrAmui3kejNTOVOOL
 sgTB8kCCdUHLPhOlR53JDPg6WMVzFhyqMqWT1L1KLBidntG4ZiM6kTxgchzUkgTZjK0gvQDdx
 CNdWd2xc45g7FJYYWrEh5YbKw//zwQ3Y3EDrNtxauBOgD+FtwO7gvRtAgK4fST/5qcTL4Vuhi
 RYQGkEO6kQtjOeVnjCdAe9UdHOvW6bRAHoYBJUqPQ0xbRxX+q4xR/lRvlMC+qRIru/c862sQZ
 ej3FXcNKZVB5kFT+bVh2lp6E5t4ryIUlgHNkdqZr5Oc5lAT3ZNd46Vuxm4tSr9vOid2T8APcR
 IET8rc6sq+MUt3LglYT93Ndg==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 4 Oct 2024, Patrick Steinhardt wrote:

> On Fri, Oct 04, 2024 at 11:13:34AM +0200, Johannes Schindelin wrote:
> >
> > On Fri, 4 Oct 2024, Patrick Steinhardt wrote:
> >
> > > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > > index 2d951c8ceb..b5cad805d4 100755
> > > --- a/t/t0610-reftable-basics.sh
> > > +++ b/t/t0610-reftable-basics.sh
> > > @@ -455,10 +455,7 @@ test_expect_success 'ref transaction: many conc=
urrent writers' '
> > >  	git init repo &&
> > >  	(
> > >  		cd repo &&
> > > -		# Set a high timeout such that a busy CI machine will not abort
> > > -		# early. 10 seconds should hopefully be ample of time to make
> > > -		# this non-flaky.
> > > -		git config set reftable.lockTimeout 10000 &&
> > > +		git config set reftable.lockTimeout -1 &&
> > >  		test_commit --no-tag initial &&
> > >
> > >  		head=3D$(git rev-parse HEAD) &&
> >
> > That looks plausible to me, as this test is exercising the POSIX emula=
tion
> > layer of Cygwin much more than Git itself (and therefore I expect this
> > test case to take a really long time on Cygwin). If it turns out that =
this
> > works around the issue, I would propose to use something like this
> > instead:
> >
> > 		# Cygwin needs a slightly longer timeout
> > 		if have_prereq !CYGWIN
> > 		then
> > 			git config set reftable.lockTimeout 10000
> > 		else
> > 			git config set reftable.lockTimeout 60000
> > 		fi &&
>
> We also saw that this creates an issue when running e.g. with the memory
> and leak sanitizers. So I'd just generally raise the timeout value to
> something way higher to avoid flakiness, like 5 minutes.

Sounds good!

> > > The issue on Win32 is different: we cannot commit the "tables.list" =
lock
> > > via rename(3P) because the target file may be open for reading by a
> > > concurrent process. I guess that Cygwin has proper POSIX semantics f=
or
> > > rename(3P) and thus doesn't hit the same issue.
> >
> > Indeed, this is where the symptom lies. I worked around it in Git for
> > Windows v2.47.0-rc1 via this patch:
> >
> > -- snipsnap --
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index c1030e40f227..56db193d1360 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -784,6 +784,7 @@ int mingw_open (const char *filename, int oflags, =
...)
> >  	int fd, create =3D (oflags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O=
_EXCL);
> >  	wchar_t wfilename[MAX_LONG_PATH];
> >  	open_fn_t open_fn;
> > +	int tries =3D 0;
> >
> >  	va_start(args, oflags);
> >  	mode =3D va_arg(args, int);
> > @@ -813,7 +814,11 @@ int mingw_open (const char *filename, int oflags,=
 ...)
> >  	else if (xutftowcs_long_path(wfilename, filename) < 0)
> >  		return -1;
> >
> > -	fd =3D open_fn(wfilename, oflags, mode);
> > +	do {
> > +		fd =3D open_fn(wfilename, oflags, mode);
> > +	} while (fd < 0 && GetLastError() =3D=3D ERROR_SHARING_VIOLATION &&
> > +		 retry_ask_yes_no(&tries, "Opening '%s' failed because another "
> > +			"application accessed it. Try again?", filename));
> >
> >  	if ((oflags & O_CREAT) && fd >=3D 0 && are_wsl_compatible_mode_bits_=
enabled()) {
> >  		_mode_t wsl_mode =3D S_IFREG | (mode&0777);
>
> Wait, this is surprising to me as I saw the error happening when calling
> rename, not open. So why would retries in `open()` fix the symptom? I'm
> probably missing something.

I am sorry, I did not really read the bug report in detail, I only meant
to unblock Git for Windows v2.47.0-rc1 and thought I had a fix in hand. It
certainly fixed the failures on my local machine, but it unfortunately did
not fix the problems in CI.

I tried to debug in CI a bit, but it is a gnarly bug to investigate, what
with plenty of processes the intentionally block each other, and no `gdb`
to help.

> In any case I also tried something like the below patch (sorry,
> whitespace-broken).

Oh, you reminded me that the `mingw_rename()` function looks
_substantially_ different in Git for Windows than in Git. I did not have
the time (or the strength of mind, more like) to upstream those changes
yet.

> But unfortunately this still caused permission errors when the new path
> was held open by another process.

Yes, this will _always_ be a problem, I think. The
`FILE_RENAME_POSIX_SEMANTICS` as per its documentation should help, but if
it does not in your tests it might actually not quite work as advertised
(wouldn't be the first time I encounter such an issue).

I tried to read through the code (it's a lot!) to figure out whether there
is potentially any situation when the `tables.list` file is opened but not
closed immediately, but couldn't find any. Do you know off-hand of any
such scenario?

> I think for now I'd still lean into the direction of adding the !WINDOWS
> prerequisite to the test and increasing timeouts such that I can
> continue to investigate without time pressure.

Let me bang my head against this problem for a little while longer. You
might be right, though, that this is a thing we cannot fix in time for
v2.47.0, which would be sad.

Ciao,
Johannes

>
> Patrick
>
> @ -2152,9 +2152,12 @@ int mingw_accept(int sockfd1, struct sockaddr *sa,=
 socklen_t *sz)
>  int mingw_rename(const char *pold, const char *pnew)
>  {
>         DWORD attrs, gle;
> -       int tries =3D 0;
> +       int tries =3D 0, wpnew_len, wpold_len;
>         wchar_t wpold[MAX_PATH], wpnew[MAX_PATH];
> -       if (xutftowcs_path(wpold, pold) < 0 || xutftowcs_path(wpnew, pne=
w) < 0)
> +
> +       wpold_len =3D xutftowcs_path(wpold, pold);
> +       wpnew_len =3D xutftowcs_path(wpnew, pnew);
> +       if (wpold_len < 0 || wpnew_len < 0)
>                 return -1;
>
>         /*
> @@ -2166,6 +2169,58 @@ int mingw_rename(const char *pold, const char *pn=
ew)
>         if (errno !=3D EEXIST)
>                 return -1;
>  repeat:
> +       {
> +#define FileRenameInfoEx                      22
> +               enum {
> +                       FILE_RENAME_REPLACE_IF_EXISTS         =3D 0x01,
> +                       FILE_RENAME_POSIX_SEMANTICS           =3D 0x02,
> +                       FILE_RENAME_IGNORE_READONLY_ATTRIBUTE =3D 0x40,
> +               };
> +               typedef struct FILE_RENAME_INFORMATION {
> +                       union {
> +                               BOOLEAN ReplaceIfExists;
> +                               ULONG Flags;
> +                       };
> +                       HANDLE RootDirectory;
> +                       ULONG FileNameLength;
> +                       WCHAR FileName[1];
> +               } *PFILE_RENAME_INFORMATION;
> +               size_t wpnew_size =3D wpnew_len * sizeof(wchar_t);
> +               PFILE_RENAME_INFORMATION fri =3D NULL;
> +               HANDLE handle =3D NULL;
> +               BOOL success;
> +               int ret;
> +
> +               handle =3D CreateFileW(wpold, DELETE,
> +                                    FILE_SHARE_READ | FILE_SHARE_WRITE =
| FILE_SHARE_DELETE, NULL,
> +                                    OPEN_EXISTING, FILE_ATTRIBUTE_NORMA=
L, NULL);
> +               if (handle =3D=3D INVALID_HANDLE_VALUE) {
> +                       errno =3D ENOENT;
> +                       ret =3D -1;
> +                       goto out;
> +               }
> +
> +               fri =3D xcalloc(1, sizeof(*fri) + wpnew_size);
> +               fri->Flags =3D FILE_RENAME_REPLACE_IF_EXISTS | FILE_RENA=
ME_POSIX_SEMANTICS |
> +                            FILE_RENAME_IGNORE_READONLY_ATTRIBUTE;
> +               fri->FileNameLength =3D wpnew_len;
> +               memcpy(fri->FileName, wpnew, wpnew_size);
> +
> +               success =3D SetFileInformationByHandle(handle, FileRenam=
eInfoEx,
> +                                                    fri, sizeof(*fri) +=
 wpnew_size);
> +               if (!success) {
> +                       errno =3D err_win_to_posix(GetLastError());
> +                       ret =3D -1;
> +                       goto out;
> +               }
> +
> +               ret =3D 0;
> +out:
> +               CloseHandle(handle);
> +               free(fri);
> +               return ret;
> +       }
> +
>
>
