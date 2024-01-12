Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95A2AEEC
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PA+JQa+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705065165; x=1705669965; i=johannes.schindelin@gmx.de;
	bh=4nBD6qPcUEdMPIfiPh8jmnVlKXK/UliqnoxMUi+OuCY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=PA+JQa+XoQb+LMAkXNmiYHU+u5H6BB0+tZRVi6/vUCXEtpxDQcIgzWBpS3QRnNVY
	 WJ/tABt+OucwNjjbTJXsVfmNCqUjulDv+diAPnrHZeJmwaoCmhNRfNPVzWnDviB2m
	 +OlYQy8d06kKvzUr7nGOoHGoa7IajtMal4ogmLz7lYuXol4Rpm72WXX8NBQ62vZqP
	 F4NvNRwcdgyMOEAYgcHURjXYrPX4Q3a9hki5mI/IogSiwXInqsEpVAC3oFOkuZWS1
	 1tdT2mMNAG7snIR1S8TF9dnuvNEaAsrF0sFODh+YGdWvjlvbQOAnZWvxx/JfAc2KO
	 wknFegTGO9AvmZwl+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.101]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1riPYM0AXb-00KjRD; Fri, 12
 Jan 2024 14:12:45 +0100
Date: Fri, 12 Jan 2024 14:12:43 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 1/2] t9902: verify that completion does not print
 anything
In-Reply-To: <ZaEZar9OTVgfkD9r@framework>
Message-ID: <27edf445-d7fa-7aaf-7682-4ecc03366ef0@gmx.de>
References: <cover.1704969119.git.ps@pks.im> <73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im> <d978494d-6c48-5923-4745-c42a39e1187a@gmx.de> <ZaEZar9OTVgfkD9r@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WOrfqAjN9nFMfB+mexCI+31zI81oLzqO9whWko2f4GejrGlazTh
 0T6RHlFukX0slJWpGX2A1xa0gilrd2IdhLFvpAzm8CESAMTG29dznIhNcg7yJCftu4V9+0/
 Ks5PaV4lSHksjryfsuZk7u+1Yvx+5uxDgWjS1Ao1amDDJGs4TfErh4kPCcpHu9O2YygZep1
 dxP77mUPwd1Ko0rB3SAoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H+XpBL4mIGc=;Kk1Qkrs+3xWzoVyvVl6iJkQ6ysD
 c6CMBIpb5pR3CeMBTlIBf54+fJc7FOraOGV+UqEWWHZRUhdIBcQEpqHCKzM7MtItMC04CG2DI
 yr/OGchCyAcuJm3fXT6PQa88ACUUVMEsVchenNm7FHARgf9wrTfk34mAMBNMwocLlc7lSE3Ag
 Cb7oQ+Vc7MzfaP564bixzhk+ibVSSWrKvLKq69pEcEejtbkFRN5rjJPYLrJFIdMp5kYHqXebX
 TupbNbueauzbE2f+kBzwA93dMcBS9/1zVre+tzCoRTFvvixuQPkdpy/MEjcw/OylKLR7LSEoB
 1XpXdlb5PRYv0i5phZloJJ3XK9fuFavJUm4qNLNYRsiUBf8/TGOxS/7eMRir0ZoTb49Wkx9Vo
 HHuQFMhMoS7+ovZfRRBAwm5O6/UT4qYPwYIULQQwDi2Cvmkt8/VYYpE3eUCeSGa5jrnVwl7z3
 pOOE8xS3iRKOBYEGMeCffHfszNgy7Y6PsmKm/ZYQQN+Naa0ln6QxnPxdSCNG6RH/KKT8LJ/1i
 6gP04ij+T6ij5bb/dji9aqx8ZtI0SMzWaVYYmSl29C2EiL3TCLt1odUxZvkGO5IsRoOCGA5Rm
 cjw0VARt3hECrE8/JNPJlGWdc0siXpI8GHpUs+Amr1yurSKX9i7JbR45QfNzfctiHq7MPB4Te
 iDFmtjyIgo9POwl8evX/wDMrBGjyjFn0TOnBJxekcDgBEMDmxeBqKVWbl084BdfOH+R944pOn
 gNfqT46t8oFcEsQt//BCLPnk8GXf1jb6GUK1FKbjsX2DMoro21mkH5Bxi8nZdMgPt0m7p9h3q
 obQgWp0NcOdHsbduwlCztzACo1+C09PGMGPmP1HoyY1cRXgPkGA6EaAphXyf992E5t08Fnc3T
 k7becqehKcTe28WuXKHARlUxzP7HmwEJUQ/c0pUXdH6Ev7xfTW+W4mwdGorHvGObflC21APdw
 vWmpkA==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 12 Jan 2024, Patrick Steinhardt wrote:

> On Fri, Jan 12, 2024 at 11:08:21AM +0100, Johannes Schindelin wrote:
>
> > On Thu, 11 Jan 2024, Patrick Steinhardt wrote:
> >
> > > The Bash completion script must not print anything to either stdout =
or
> > > stderr. Instead, it is only expected to populate certain variables.
> > > Tighten our `test_completion ()` test helper to verify this requirem=
ent.
> > >
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  t/t9902-completion.sh | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > > index aa9a614de3..78cb93bea7 100755
> > > --- a/t/t9902-completion.sh
> > > +++ b/t/t9902-completion.sh
> > > @@ -87,9 +87,11 @@ test_completion ()
> > >  	else
> > >  		sed -e 's/Z$//' |sort >expected
> > >  	fi &&
> > > -	run_completion "$1" &&
> > > +	run_completion "$1" >"$TRASH_DIRECTORY"/output 2>&1 &&
> > >  	sort out >out_sorted &&
> > > -	test_cmp expected out_sorted
> > > +	test_cmp expected out_sorted &&
> > > +	test_must_be_empty "$TRASH_DIRECTORY"/output &&
> >
> > It seems that this fails CI on macOS, most likely because we're runnin=
g
> > with `set -x` and that output somehow ends up in `output`, see e.g. he=
re:
> > https://github.com/git/git/actions/runs/7496790359/job/20409405194#ste=
p:4:1880
> >
> >   [...]
> >   ++ test_completion 'git switch '
> >   ++ test 1 -gt 1
> >   ++ sed -e 's/Z$//'
> >   ++ sort
> >   ++ run_completion 'git switch '
> >   ++ sort out
> >   ++ test_cmp expected out_sorted
> >   ++ test 2 -ne 2
> >   ++ eval 'diff -u' '"$@"'
> >   +++ diff -u expected out_sorted
> >   ++ test_must_be_empty '/Users/runner/work/git/git/t/trash directory.=
t9902-completion/output'
> >   ++ test 1 -ne 1
> >   ++ test_path_is_file '/Users/runner/work/git/git/t/trash directory.t=
9902-completion/output'
> >   ++ test 1 -ne 1
> >   ++ test -f '/Users/runner/work/git/git/t/trash directory.t9902-compl=
etion/output'
> >   ++ test -s '/Users/runner/work/git/git/t/trash directory.t9902-compl=
etion/output'
> >   ++ echo ''\''/Users/runner/work/git/git/t/trash directory.t9902-comp=
letion/output'\'' is not empty, it contains:'
> >   '/Users/runner/work/git/git/t/trash directory.t9902-completion/outpu=
t' is not empty, it contains:
> >   ++ cat '/Users/runner/work/git/git/t/trash directory.t9902-completio=
n/output'
> >   ++ local -a COMPREPLY _words
> >   ++ local _cword
> >   [...]
> >
> > Maybe this is running in Dash and therefore `BASH_XTRACEFD=3D4` in
> > `test-lib.sh` has not the intended effect?
>
> Meh, thanks for the heads up. Another test gap in GitLab CI which I'm
> going to address soon via a new macOS job.
>
> In any case, Dash indeed does not honor the above envvar.

Hmm. I had a closer look and now I am thoroughly confused. In
`t/lib-bash.exe`, we make sure that this test is run in Bash. And indeed,
when I call

  BASH=3D1 POSIXLY_CORRECT=3D1 TEST_SHELL_PATH=3D/bin/dash dash t9902-comp=
letion.sh -iVx

I am greeted by this error message:

  git-completion.bash: Syntax error: "(" unexpected (expecting "fi")

So something else must be going on here.

> I also could not find any alternate solutions to redirect the tracing
> output. So for all I can see there are a few ways to handle this:
>
>   - `set -x` and then restore the previous value after having called
>     `run_completion`.
>
>   - Filter the output so that any line starting with "${PS4}" gets
>     removed.
>
>   - Don't test for this bug.
>
> Not sure which way to go, but the first alternative feels a bit more
> sensible to me. It does remove the ability to see what's going on in the
> completion script though in case one wants to debug it.

Personally, I would go for option 2, filtering out the xtrace output. This
here seems to work:

=2D- snip --
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b14ae4de14e..23cd1cd9508 100755
=2D-- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -87,11 +87,14 @@ test_completion ()
 	else
 		sed -e 's/Z$//' |sort >expected
 	fi &&
+	PS4=3D+ &&
 	run_completion "$1" >"$TRASH_DIRECTORY"/output 2>&1 &&
+	sed "/^+/{:1;s/'[^']*'//g;/'/{N;b1};d}" \
+		<"$TRASH_DIRECTORY"/output >"$TRASH_DIRECTORY"/output.x &&
+	test_must_be_empty "$TRASH_DIRECTORY"/output.x &&
+	rm "$TRASH_DIRECTORY"/output "$TRASH_DIRECTORY"/output.x &&
 	sort out >out_sorted &&
-	test_cmp expected out_sorted &&
-	test_must_be_empty "$TRASH_DIRECTORY"/output &&
-	rm "$TRASH_DIRECTORY"/output
+	test_cmp expected out_sorted
 }

 # Test __gitcomp.
=2D- snap --

It is a bit ugly, in particular the `sed` expression (which is a bit
complex because the `output` file can contain multi-line strings enclosed
in single-quotes), and we could probably lose the `"$TRASH_DIRECTORY"/`
part to improve the reading experience somewhat.

But my main concern is: Why does this happen in the first place? If we are
running with Bash, why does `BASH_XTRACEFD` to work as intended here and
makes it necessary to filter out the traced commands?

Ciao,
Johannes
