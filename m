Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934491DED69
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580291; cv=none; b=OP3LA8Hoypt4YW/PnYhGTSpSCmnJM/76tk/WRCAlZ3DhfRsck8Qft34+ltA6C1qNz37+yZsDi+oqoK3qWjZJmTuHmZyxNhqco2e76REbRGY4CCjzMK6gK4qjVZx+XBAdwHU34hf9Hi4wSNY7+ARH5ksm+YnyYJ1yCcM7JUFDOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580291; c=relaxed/simple;
	bh=jwxowWM3qg744WEz6fY9iYbi6P7Jh6WN0sxO7x7mC9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EjAXX0U+0H5TEvcjFhL+4USm3czDOLB8qN2Uv4L9ejBPUntXyfeSXFGPDE7DXsTPp4wWWPhX/N5Jx6VlWFYEyvFFXpQlUwVp4lfipjj/UzuwkeoXat4Sb7fizKvFaRNLBO2n+feU+kaPX6aDIb+WHwnv7ThQeKmFtgP5yBzE/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=irLxMWx/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="irLxMWx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745580286; x=1746185086;
	i=johannes.schindelin@gmx.de;
	bh=emwNCb3k/62nDiWejFz7U9RGZnGSUccMi678DmZjM5Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=irLxMWx/aR+72DTpMoiusN7oqUiBScA9oNSEG6w1QxmQDvwvJhVfDwIXrg4tWZZR
	 lUXoXXIZzFknU9+iR0LBU4Or1o3xH5XDqCsT0OyA3eXVSn+9RqfW9XB9QDsI5qP65
	 rQzeASRk5evOwQRyloLQOa2KsEIlqIfCLf2gj0BGcdIK5E3PCnazj8qFBnN23nqpa
	 1uq1wwztL+Ja0+qpu7exAwKwnYE7UYBgckk33FbchaV03eUBJ33fsdkBBTsCqT0Ax
	 q4p7M6V+Hr01aVGAM3lrmup7YUAuKdoJRRVkh99qO3k12IXXaA7k2fIYGVfBsTxdH
	 /Loh5OGylPBW3mh7eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.84]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1vBjwq0q8o-00tfoB; Fri, 25
 Apr 2025 13:24:46 +0200
Date: Fri, 25 Apr 2025 13:24:45 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Hohwiller=2C_J=C3=B6rg?= <joerg.hohwiller@capgemini.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Windows] Severe problems after upgrading to 2.48.1.windows.1
In-Reply-To: <VI1PR02MB64951BAFB488287E136125AFFB852@VI1PR02MB6495.eurprd02.prod.outlook.com>
Message-ID: <74e24bc5-5f19-fcfd-383c-a948ec98ff28@gmx.de>
References: <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com> <d3f55106-8f87-b535-1c7c-29d382378342@gmx.de> <VI1PR02MB6495A9779866FD337F2F8E1CFBA92@VI1PR02MB6495.eurprd02.prod.outlook.com> <a81435f0-f09d-9197-9776-2402457fdef0@gmx.de>
 <VI1PR02MB64951BAFB488287E136125AFFB852@VI1PR02MB6495.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1401488131-1745580286=:96"
X-Provags-ID: V03:K1:fqFdqhtm2DPDIeoAxxE6f/nmIsd0Fgo/UTqqJiaCNG1W0PX6Uvv
 G+xjAjNgzE314orB4ZA4kPmdtN6L0HXorD7jTyT88Zsw8HS2JQkYuuuiQW586JroL3AnHXb
 A7IORAMOfG/VPbvAfax9i5hBomDca6FjTJavqEvJvCj3mCtw0aJvtJTvSOE9ufm0nn4BabN
 7lw4lbcQKynJdGU7Ng0ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F5xGhx9imQE=;RKbGel20X30zez+MQ64jN48lV2g
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1401488131-1745580286=:96
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=B6rg,

would you be able to follow the same advice I have at
https://github.com/git-for-windows/git/issues/5427#issuecomment-2735535941
to build Git and investigate a bit further (because I cannot reproduce
your problem and therefore cannot do that for you):

1. install the Git for Windows SDK:
   https://gitforwindows.org/#download-sdk

2. Create `/usr/src/git/config.mak` with the following contents to disable=
 compiler optimization and ASLR:

```
DEVELOPER=3D1
ifndef NDEBUG
CFLAGS :=3D $(filter-out -O2,$(CFLAGS))
ASLR_OPTION :=3D -Wl,--dynamicbase
BASIC_LDFLAGS :=3D $(filter-out $(ASLR_OPTION),$(BASIC_LDFLAGS))
endif
```

1.  run `make` in `/usr/src/git/`.

After that, you can run Git's executables in GDB like so:
```
gdb --args ./git.exe -C /path/to/refs/drive init test-git-repo

```

Now, it is useful to ask the debugger to pause the program when the code p=
ath is entered that outputs an error message. The functions in Git that ou=
tput error messages are `error_builtin()` and `die_builtin()`. So you can =
set the breakpoints

```
b error_builtin
b die_builtin
```

before calling `run` in `gdb` to stop execution at the appropriate time. D=
oing this will stop execution when the `error_builtin()` function is calle=
d, i.e. when the error message you reported would be shown. Once that is t=
he case, you can obtain a back trace with `bt`. Example:

```
(gdb) bt
#0  setup_git_directory_gently_1 (nongit_ok=3D0x0) at setup.c:846
#1  0x000000000057dfd8 in setup_git_directory_gently (nongit_ok=3D0x0)
    at setup.c:937
#2  0x000000000057e211 in setup_git_directory () at setup.c:1014
#3  0x0000000000487bfc in cmd_rev_parse (argc=3D2, argv=3D0x1951a88, prefi=
x=3D0x0)
    at builtin/rev-parse.c:589
#4  0x000000000040296a in run_builtin (p=3D0x5fb8e8 <commands+2184>, argc=
=3D2,
    argv=3D0x1951a88) at git.c:373
#5  0x0000000000402c8d in handle_builtin (argc=3D2, argv=3D0x1951a88) at g=
it.c:579
#6  0x0000000000402e2a in run_argv (argcp=3D0x108fe00, argv=3D0x108fdb8)
    at git.c:637
#7  0x0000000000402fb9 in cmd_main (argc=3D2, argv=3D0x1951a88) at git.c:7=
09
#8  0x000000000049f699 in mingw_main (argc=3D3, argv=3D0x1951a80)
    at common-main.c:40
#9  0x000000000049f64d in main (argc=3D3, argv=3D0x3230498) at common-main=
.c:25

```

This back trace shows which functions were called by which other functions=
. The inner-most code location is `#0`, which was called from `#1`, which =
was called from `#2`, etc. In the example above, the `main()` function cal=
led the `mingw_main()` function which in turn called the `cmd_main()` func=
tion, and so on, until eventually the `setup_git_directory_gently()` funct=
ion was called, which then called the `setup_git_directory_gently_1()` fun=
ction, where the execution was stopped to let you, the user, inspect the c=
urrent state in the debugger.

You can inspect the source code at the current code location using the `l`=
 command (or specify a line number or even a file and a line number like s=
o: `l git.c:709`, or a function name, like so: `l run_builtin`).

You can navigate between the different stack frames using `up` and `down` =
(which is confusingly the opposite direction as in the list above).

Importantly in this instance, you can go `up` to the function that issues =
the error message, then inspect the surrounding code with `l`. This should=
 already be very helpful in the investigation to figure _what_ is going wr=
ong, and if all you do to help this ticket is run with the debugging so fa=
r and then paste the output of `gdb` in this ticket, it should go a long w=
ay to fix this bug.

Please let us know how it goes!

On Thu, 24 Apr 2025, Hohwiller, J=C3=B6rg wrote:

> Hi Johannes,
>=20
> Also I see this error every time I run "git pull origin main":
>=20
> fatal: failed to run reflog
> error: task 'gc' failed
>=20
> The pull still works but I guess something is really wrong but cannot te=
ll exactly what.
>=20
> Kind regards
>   J=C3=B6rg
>=20
> -----Original Message-----
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
> Sent: Thursday, April 24, 2025 15:10
> To: Hohwiller, J=C3=B6rg <joerg.hohwiller@capgemini.com>
> Cc: git@vger.kernel.org
> Subject: RE: [Windows] Severe problems after upgrading to 2.48.1.windows=
.1
>=20
> ******This mail has been sent from an external source. Do not reply to i=
t, or open any links/attachments unless you are sure of the sender's ident=
ity.******
>=20
> Hi J=C3=B6rg,
>=20
> On Fri, 4 Apr 2025, Hohwiller, J=C3=B6rg wrote:
>=20
> > Thanks for your response and suggestions.
> > I downloaded and installed the latest SNAPSHOT:
> >=20
> > $ git -v
> > git version 2.49.0.windows.1.7.g4ca71ba531.20250326122305
> >=20
> > However, the error still remains. I cannot pull my repo without the er=
ror I was referring to.
>=20
> I should have clarified that you will need to remove the `.lock` file ma=
nually, unfortunately, before trying again (if it exists, that is).
>=20
> Ciao,
> Johannes
>=20
> > This blocks my workflows.
> > There are workarounds like using `git pull origin main` manually in gi=
t-bash but it is quite inconvenient not being able to use git via IntelliJ=
 or git-fork without errors.
> >=20
> > Kind regards
> >   J=C3=B6rg
> >=20
> > -----Original Message-----
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Sent: Tuesday, April 1, 2025 17:45
> > To: Hohwiller, J=C3=B6rg <joerg.hohwiller@capgemini.com>
> > Cc: git@vger.kernel.org
> > Subject: Re: [Windows] Severe problems after upgrading to=20
> > 2.48.1.windows.1
> >=20
> > ******This mail has been sent from an external source. Do not reply to=
=20
> > it, or open any links/attachments unless you are sure of the sender's=
=20
> > identity.******
> >=20
> > Hi J=C3=B6rg,
> >=20
> > On Mon, 3 Mar 2025, Hohwiller, J=C3=B6rg wrote:
> >=20
> > > I just upgraded to 2.48.1.windows.1 (reinstall via Git-2.48.1-64-bit=
.exe).
> > > Also I kept the checkbox to cache files (new feature?) =E2=80=93 may=
be a mistake, let see.
> >=20
> > If you are referring to FSCache, no that's not a new feature.
> >=20
> > > After the upgrade, I pulled some repo with git-fork and got this err=
or:
> > > error: could not delete references: cannot lock ref 'refs/remotes/or=
igin/bugfix/XY-74488': Unable to create 'D:/projects/projectname/workspace=
s/main/projectname/.git/refs/remotes/origin/bugfix/XY-74488.lock': File ex=
ists.
> >=20
> > While this looks different than
> > https://github.com/git-for-windows/git/pull/5515 (where writing to a R=
eFS drive on Windows 2022 was broken by a regression), the root cause as w=
ell as its fix could be the same. Can you test the latest snapshot at http=
s://gitforwindows.org/git-snapshots/ to confirm or refute this hypothesis?
> >=20
> > Ciao,
> > Johannes
> >=20
> > >
> > > I looked locally (even in CMD with copy & paste of the exact file re=
ference) but the lock file is NOT there.
> > > I repeat the pull and get the same error, but no such lock file exis=
ts.
> > >
> > > To avoid external side-effects from git-fork, I opened a new git-bas=
h and called =E2=80=9Cgit pull=E2=80=9D manually in the terminal.
> > > This did not give me any error but gave me this:
> > > $ git pull
> > > From ssh://git.company.com/repos/projectname
> > >    72477d57f026..de79f4dbbf68  =E2=80=A6
> > > * [new branch] =E2=80=A6
> > > * [new branch] =E2=80=A6
> > > * [new branch] =E2=80=A6
> > > * [new branch] =E2=80=A6
> > > * [new branch] =E2=80=A6
> > > * [new branch] =E2=80=A6
> > > * [new branch] =E2=80=A6
> > >    ce3979d639d7..b80b70a56da7 =E2=80=A6
> > > $ echo $?
> > > 1
> > >
> > > So what could be the error leading to exit code 1?
> > >
> > > Almost the same happens for git-fetch.
> > >
> > > I downgraded to git version 2.47.1.windows.2 and after that tried th=
e same again.
> > > A difference is that now I additionally I get logs like this at the=
=20
> > > top $ git pull
> > > remote: Enumerating objects: 269, done.
> > > remote: Counting objects: 100% (143/143), done.
> > > remote: Compressing objects: 100% (41/41), done.
> > > remote: Total 269 (delta 89), reused 87 (delta 87), pack-reused 126=
=20
> > > Receiving objects: 100% (269/269), 59.37 KiB | 2.58 MiB/s, done.
> > > Resolving deltas: 100% (94/94), completed with 51 local objects.
> > > From ssh://git.company.com/repos/projectname
> > > =E2=80=A6
> > > $ echo $?
> > > 1
> > >
> > > Looks familiar. Is it a bug or a feature that the latest git stops l=
ogging these status information?
> > >
> > > I have various other git repos that continue to work fine so I now r=
ather think that this is not a general bug in git pull/fetch but related t=
o the specific repo.
> > > However, that used to work for years before I upgraded today.
> > >
> > > Status on that repo says:
> > > $ git status
> > > On branch main
> > > Your branch is behind 'origin/main' by 387 commits, and can be fast-=
forwarded.
> > >   (use "git pull" to update your local branch)
> > >
> > > Untracked files:
> > >   (use "git add <file>..." to include in what will be committed)
> > >         find-tests.sh
> > >
> > > nothing added to commit but untracked files present (use "git add"=
=20
> > > to
> > > track)
> > >
> > > Sorry to bother but do you have any further hints or ideas, what I c=
ould try to fix my problem?
> > >
> > > Kind regards
> > >   J=C3=B6rg
> > >
> > >
> > > ________________________________
> > >
> > > Firma: Capgemini Deutschland GmbH
> > > Aufsichtsratsvorsitzender: Dr. Volkmar Varnhagen
> > > Gesch=C3=A4ftsf=C3=BChrer: Henrik Ljungstr=C3=B6m (Sprecher) =E2=80=
=A2 Jost F=C3=B6rster =E2=80=A2=20
> > > Felizitas Graeber =E2=80=A2 Vera Schierholt
> > >
> > > Sitz: Berlin, Amtsgericht Berlin-Charlottenburg, HRB 98814 This=20
> > > message contains information that may be privileged or confidential =
and is the property of the Capgemini Group. It is intended only for the pe=
rson to whom it is addressed. If you are not the intended recipient, you a=
re not authorized to read, print, retain, copy, disseminate, distribute, o=
r use this message or any part thereof. If you receive this message in err=
or, please notify the sender immediately and delete all copies of this mes=
sage.
> > >
> > This message contains information that may be privileged or confidenti=
al and is the property of the Capgemini Group. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, yo=
u are not authorized to read, print, retain, copy, disseminate, distribute=
, or use this message or any part thereof. If you receive this message in =
error, please notify the sender immediately and delete all copies of this =
message.
> >=20
>=20

--8323328-1401488131-1745580286=:96--
