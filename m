Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D823F41F
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448348; cv=none; b=oqGrRrRD2bE3y1wEg1LlP58yfRbhRgTu1P0AU4PDOxn7u/REmaQWPPXgytBtjTuK9NF4V1AQwk7/FmFQefeGZVpKGaENdXeo1CdgjrlCxeb94rqOVp8aw7x3Bw6AmRxnxcJZ65P6gBUlv70KI4oWSdZHAuDIkGYJZPx8vFJAotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448348; c=relaxed/simple;
	bh=WeH4OFs5/1Avu+XXkgFnM/SI5KljGHlTV3K0bYaaOk0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WnNVNb/RELeJcvt8zNUqahexdtfTQhIab+6VC9bk7Dgl2LlgZ46oqWh06q4qMDKgvNFYvg9aNgr8rNHP755VSXSg5T7qIidnQoFO4A5JKl5VVUe3AKkIureUWeKuTpuG2owDtLxT/d0Gm6FDuNH8WiGKNVHlhC+Unom4UdHmOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=hkoX4VWq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="hkoX4VWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751448342; x=1752053142;
	i=johannes.schindelin@gmx.de;
	bh=FyUOkYVXcu1MxI49EamCHv5F7Qv6houQnRumKabTQ2E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hkoX4VWqKdsTA50N9lZsmoWXSr4PNOyNAmsmDh3EI22Gk563fkZvBe8b6HgiD2RO
	 P8kw+5f0r1yZtnNDrWY7GKH4Uap2rML1ulOGNPLlm+O51afuVk9N8A9ZDg2JDaDX1
	 bYiwYsAREV0/RC7zPdQ8X8EpYLWAd/e8fgAYhhYibu9+UK2Zjiokb4QPPUD43eaHu
	 MLjYnwrW/c+v0+/kBa6IjVbbVOe8RAI67Ynkoc79ryHMvIeTgEmTlSJEiUf0W4h3m
	 4juQ5DgNVU5Y44Edow/djK9yGIMx9VqG/u70zSJhuUJi2mSaPMCUCQcNJpdrSl81E
	 QopjIkgVgyUf+3phaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1uo18D1mGl-013MIb; Wed, 02
 Jul 2025 11:25:42 +0200
Date: Wed, 2 Jul 2025 11:25:40 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Hohwiller=2C_J=C3=B6rg?= <joerg.hohwiller@capgemini.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Windows] Severe problems after upgrading to 2.48.1.windows.1
In-Reply-To: <VI1PR02MB64959DB453F766E69CBB2AD9FB45A@VI1PR02MB6495.eurprd02.prod.outlook.com>
Message-ID: <af1bac80-00f7-a0d6-54f2-326f47925b18@gmx.de>
References: <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com> <d3f55106-8f87-b535-1c7c-29d382378342@gmx.de> <VI1PR02MB6495A9779866FD337F2F8E1CFBA92@VI1PR02MB6495.eurprd02.prod.outlook.com> <a81435f0-f09d-9197-9776-2402457fdef0@gmx.de>
 <VI1PR02MB64951BAFB488287E136125AFFB852@VI1PR02MB6495.eurprd02.prod.outlook.com> <74e24bc5-5f19-fcfd-383c-a948ec98ff28@gmx.de> <VI1PR02MB64959DB453F766E69CBB2AD9FB45A@VI1PR02MB6495.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1187300436-1751448342=:10938"
X-Provags-ID: V03:K1:VI2xKou5lq9e4nsd4h7zlYfbR/zgvSa8RF6hSiUY2p56ZetAO5l
 BWZXOL9oS+vR2GTrFO/BEJLqLvsBdaF47T7wnLJWn+XScBSngpY+EkQ8AyFMRYbi/8kYdOx
 q1lpvkT8ssetfpYCG5FfuKE2dfZwN7KYD9DQzkgt45mBo4Ef2xCpBEuVxdBhoW/F98Yb1w6
 v78sDJMQjv7q7e9qgdyvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6ny9kT8d+zw=;HCm94iXu28FCKP/GAOhmfF4adpd
 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
 1Q==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1187300436-1751448342=:10938
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=B6rg,

On Fri, 27 Jun 2025, Hohwiller, J=C3=B6rg wrote:

> Thanks for the detailed instructions.
> I am still seeing really wired errors like this:
>=20
> error: cannot lock ref 'refs/remotes/origin/main': is at 3a7074794ada9e4=
17dee0a8ddd1248bcb86721b0 but expected 81c93e5393e41850c8de7d7b924e9f346c1=
d2ccc
> ! 81c93e5393e4..3a7074794ada  main                    -> origin/main  (u=
nable to update local ref)
> error: could not fetch origin
>=20
> Surely, I can simply trash my repo and clone from scratch but as a devel=
oper I know how hard it can be to reproduce such edge-case errors and how =
valuable such state can be.
>=20
> I tried to follow your instructions:
> 1. done
> 2. done
> 3. failed:
>=20
> /usr/src/git (master)
> $ make
> make: *** No targets specified and no makefile found.  Stop.

Right, step two should have been to call `sdk cd git`, which would have
initialized your clone. You can do that post-hoc via:

	cd /usr/src/git
	git fetch origin v2.50.0.windows.2
	git switch -d FETCH_HEAD

Ciao,
Johannes

>=20
> $ ls -la
> total 9
> drwxr-xr-x 1 hohwille 1049089   0 Jun 27 17:28 ./
> drwxr-xr-x 1 hohwille 1049089   0 Jun 27 17:25 ../
> drwxr-xr-x 1 hohwille 1049089   0 Jun 27 17:25 .git/
> -rw-r--r-- 1 hohwille 1049089 168 Jun 27 17:28 config.mak
>=20
> Sorry, but I have to give up again.
>=20
> I will save a backup of that repo but have to create a fresh clone as cu=
rrently I am completely blocked and every git pull / git gc / ... fails wi=
th exit code 1.
>=20
> Cheers
>   J=C3=B6rg
>=20
> -----Original Message-----
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
> Sent: Friday, April 25, 2025 13:25
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
> would you be able to follow the same advice I have at
> https://github.com/git-for-windows/git/issues/5427#issuecomment-27355359=
41
> to build Git and investigate a bit further (because I cannot reproduce y=
our problem and therefore cannot do that for you):
>=20
> 1. install the Git for Windows SDK:
>    https://gitforwindows.org/#download-sdk
>=20
> 2. Create `/usr/src/git/config.mak` with the following contents to disab=
le compiler optimization and ASLR:
>=20
> ```
> DEVELOPER=3D1
> ifndef NDEBUG
> CFLAGS :=3D $(filter-out -O2,$(CFLAGS))
> ASLR_OPTION :=3D -Wl,--dynamicbase
> BASIC_LDFLAGS :=3D $(filter-out $(ASLR_OPTION),$(BASIC_LDFLAGS)) endif `=
``
>=20
> 1.  run `make` in `/usr/src/git/`.
>=20
> After that, you can run Git's executables in GDB like so:
> ```
> gdb --args ./git.exe -C /path/to/refs/drive init test-git-repo
>=20
> ```
>=20
> Now, it is useful to ask the debugger to pause the program when the code=
 path is entered that outputs an error message. The functions in Git that =
output error messages are `error_builtin()` and `die_builtin()`. So you ca=
n set the breakpoints
>=20
> ```
> b error_builtin
> b die_builtin
> ```
>=20
> before calling `run` in `gdb` to stop execution at the appropriate time.=
 Doing this will stop execution when the `error_builtin()` function is cal=
led, i.e. when the error message you reported would be shown. Once that is=
 the case, you can obtain a back trace with `bt`. Example:
>=20
> ```
> (gdb) bt
> #0  setup_git_directory_gently_1 (nongit_ok=3D0x0) at setup.c:846
> #1  0x000000000057dfd8 in setup_git_directory_gently (nongit_ok=3D0x0)
>     at setup.c:937
> #2  0x000000000057e211 in setup_git_directory () at setup.c:1014
> #3  0x0000000000487bfc in cmd_rev_parse (argc=3D2, argv=3D0x1951a88, pre=
fix=3D0x0)
>     at builtin/rev-parse.c:589
> #4  0x000000000040296a in run_builtin (p=3D0x5fb8e8 <commands+2184>, arg=
c=3D2,
>     argv=3D0x1951a88) at git.c:373
> #5  0x0000000000402c8d in handle_builtin (argc=3D2, argv=3D0x1951a88) at=
 git.c:579
> #6  0x0000000000402e2a in run_argv (argcp=3D0x108fe00, argv=3D0x108fdb8)
>     at git.c:637
> #7  0x0000000000402fb9 in cmd_main (argc=3D2, argv=3D0x1951a88) at git.c=
:709
> #8  0x000000000049f699 in mingw_main (argc=3D3, argv=3D0x1951a80)
>     at common-main.c:40
> #9  0x000000000049f64d in main (argc=3D3, argv=3D0x3230498) at common-ma=
in.c:25
>=20
> ```
>=20
> This back trace shows which functions were called by which other functio=
ns. The inner-most code location is `#0`, which was called from `#1`, whic=
h was called from `#2`, etc. In the example above, the `main()` function c=
alled the `mingw_main()` function which in turn called the `cmd_main()` fu=
nction, and so on, until eventually the `setup_git_directory_gently()` fun=
ction was called, which then called the `setup_git_directory_gently_1()` f=
unction, where the execution was stopped to let you, the user, inspect the=
 current state in the debugger.
>=20
> You can inspect the source code at the current code location using the `=
l` command (or specify a line number or even a file and a line number like=
 so: `l git.c:709`, or a function name, like so: `l run_builtin`).
>=20
> You can navigate between the different stack frames using `up` and `down=
` (which is confusingly the opposite direction as in the list above).
>=20
> Importantly in this instance, you can go `up` to the function that issue=
s the error message, then inspect the surrounding code with `l`. This shou=
ld already be very helpful in the investigation to figure _what_ is going =
wrong, and if all you do to help this ticket is run with the debugging so =
far and then paste the output of `gdb` in this ticket, it should go a long=
 way to fix this bug.
>=20
> Please let us know how it goes!
>=20
> On Thu, 24 Apr 2025, Hohwiller, J=C3=B6rg wrote:
>=20
> > Hi Johannes,
> >=20
> > Also I see this error every time I run "git pull origin main":
> >=20
> > fatal: failed to run reflog
> > error: task 'gc' failed
> >=20
> > The pull still works but I guess something is really wrong but cannot =
tell exactly what.
> >=20
> > Kind regards
> >   J=C3=B6rg
> >=20
> > -----Original Message-----
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Sent: Thursday, April 24, 2025 15:10
> > To: Hohwiller, J=C3=B6rg <joerg.hohwiller@capgemini.com>
> > Cc: git@vger.kernel.org
> > Subject: RE: [Windows] Severe problems after upgrading to=20
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
> > On Fri, 4 Apr 2025, Hohwiller, J=C3=B6rg wrote:
> >=20
> > > Thanks for your response and suggestions.
> > > I downloaded and installed the latest SNAPSHOT:
> > >=20
> > > $ git -v
> > > git version 2.49.0.windows.1.7.g4ca71ba531.20250326122305
> > >=20
> > > However, the error still remains. I cannot pull my repo without the =
error I was referring to.
> >=20
> > I should have clarified that you will need to remove the `.lock` file =
manually, unfortunately, before trying again (if it exists, that is).
> >=20
> > Ciao,
> > Johannes
> >=20
> > > This blocks my workflows.
> > > There are workarounds like using `git pull origin main` manually in =
git-bash but it is quite inconvenient not being able to use git via Intell=
iJ or git-fork without errors.
> > >=20
> > > Kind regards
> > >   J=C3=B6rg
> > >=20
> > > -----Original Message-----
> > > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Sent: Tuesday, April 1, 2025 17:45
> > > To: Hohwiller, J=C3=B6rg <joerg.hohwiller@capgemini.com>
> > > Cc: git@vger.kernel.org
> > > Subject: Re: [Windows] Severe problems after upgrading to
> > > 2.48.1.windows.1
> > >=20
> > > ******This mail has been sent from an external source. Do not reply=
=20
> > > to it, or open any links/attachments unless you are sure of the=20
> > > sender's
> > > identity.******
> > >=20
> > > Hi J=C3=B6rg,
> > >=20
> > > On Mon, 3 Mar 2025, Hohwiller, J=C3=B6rg wrote:
> > >=20
> > > > I just upgraded to 2.48.1.windows.1 (reinstall via Git-2.48.1-64-b=
it.exe).
> > > > Also I kept the checkbox to cache files (new feature?) =E2=80=93 m=
aybe a mistake, let see.
> > >=20
> > > If you are referring to FSCache, no that's not a new feature.
> > >=20
> > > > After the upgrade, I pulled some repo with git-fork and got this e=
rror:
> > > > error: could not delete references: cannot lock ref 'refs/remotes/=
origin/bugfix/XY-74488': Unable to create 'D:/projects/projectname/workspa=
ces/main/projectname/.git/refs/remotes/origin/bugfix/XY-74488.lock': File =
exists.
> > >=20
> > > While this looks different than
> > > https://github.com/git-for-windows/git/pull/5515 (where writing to a=
 ReFS drive on Windows 2022 was broken by a regression), the root cause as=
 well as its fix could be the same. Can you test the latest snapshot at ht=
tps://gitforwindows.org/git-snapshots/ to confirm or refute this hypothesi=
s?
> > >=20
> > > Ciao,
> > > Johannes
> > >=20
> > > >
> > > > I looked locally (even in CMD with copy & paste of the exact file =
reference) but the lock file is NOT there.
> > > > I repeat the pull and get the same error, but no such lock file ex=
ists.
> > > >
> > > > To avoid external side-effects from git-fork, I opened a new git-b=
ash and called =E2=80=9Cgit pull=E2=80=9D manually in the terminal.
> > > > This did not give me any error but gave me this:
> > > > $ git pull
> > > > From ssh://git.company.com/repos/projectname
> > > >    72477d57f026..de79f4dbbf68  =E2=80=A6
> > > > * [new branch] =E2=80=A6
> > > > * [new branch] =E2=80=A6
> > > > * [new branch] =E2=80=A6
> > > > * [new branch] =E2=80=A6
> > > > * [new branch] =E2=80=A6
> > > > * [new branch] =E2=80=A6
> > > > * [new branch] =E2=80=A6
> > > >    ce3979d639d7..b80b70a56da7 =E2=80=A6
> > > > $ echo $?
> > > > 1
> > > >
> > > > So what could be the error leading to exit code 1?
> > > >
> > > > Almost the same happens for git-fetch.
> > > >
> > > > I downgraded to git version 2.47.1.windows.2 and after that tried =
the same again.
> > > > A difference is that now I additionally I get logs like this at=20
> > > > the top $ git pull
> > > > remote: Enumerating objects: 269, done.
> > > > remote: Counting objects: 100% (143/143), done.
> > > > remote: Compressing objects: 100% (41/41), done.
> > > > remote: Total 269 (delta 89), reused 87 (delta 87), pack-reused=20
> > > > 126 Receiving objects: 100% (269/269), 59.37 KiB | 2.58 MiB/s, don=
e.
> > > > Resolving deltas: 100% (94/94), completed with 51 local objects.
> > > > From ssh://git.company.com/repos/projectname
> > > > =E2=80=A6
> > > > $ echo $?
> > > > 1
> > > >
> > > > Looks familiar. Is it a bug or a feature that the latest git stops=
 logging these status information?
> > > >
> > > > I have various other git repos that continue to work fine so I now=
 rather think that this is not a general bug in git pull/fetch but related=
 to the specific repo.
> > > > However, that used to work for years before I upgraded today.
> > > >
> > > > Status on that repo says:
> > > > $ git status
> > > > On branch main
> > > > Your branch is behind 'origin/main' by 387 commits, and can be fas=
t-forwarded.
> > > >   (use "git pull" to update your local branch)
> > > >
> > > > Untracked files:
> > > >   (use "git add <file>..." to include in what will be committed)
> > > >         find-tests.sh
> > > >
> > > > nothing added to commit but untracked files present (use "git add"=
=20
> > > > to
> > > > track)
> > > >
> > > > Sorry to bother but do you have any further hints or ideas, what I=
 could try to fix my problem?
> > > >
> > > > Kind regards
> > > >   J=C3=B6rg
> > > >
> > > >
> > > > ________________________________
> > > >
> > > > Firma: Capgemini Deutschland GmbH
> > > > Aufsichtsratsvorsitzender: Dr. Volkmar Varnhagen
> > > > Gesch=C3=A4ftsf=C3=BChrer: Henrik Ljungstr=C3=B6m (Sprecher) =E2=
=80=A2 Jost F=C3=B6rster =E2=80=A2=20
> > > > Felizitas Graeber =E2=80=A2 Vera Schierholt
> > > >
> > > > Sitz: Berlin, Amtsgericht Berlin-Charlottenburg, HRB 98814 This=20
> > > > message contains information that may be privileged or confidentia=
l and is the property of the Capgemini Group. It is intended only for the =
person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print, retain, copy, disseminate, distribute,=
 or use this message or any part thereof. If you receive this message in e=
rror, please notify the sender immediately and delete all copies of this m=
essage.
> > > >
> > > This message contains information that may be privileged or confiden=
tial and is the property of the Capgemini Group. It is intended only for t=
he person to whom it is addressed. If you are not the intended recipient, =
you are not authorized to read, print, retain, copy, disseminate, distribu=
te, or use this message or any part thereof. If you receive this message i=
n error, please notify the sender immediately and delete all copies of thi=
s message.
> > >=20
> >=20
>=20

--8323328-1187300436-1751448342=:10938--
