Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Y5eTbq6Z"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E428DA1
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700124152; x=1700728952; i=johannes.schindelin@gmx.de;
	bh=2OkhlqKu4SbTFo4r/VgRTrKyVSqPjesHSgy58ynJBV8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=Y5eTbq6ZxiqZvfIJd3A5o+v/P3bOddJ2Ztd2ZwW7hehAurM0pOrDy6+Ncg+HWULg
	 9ouDRO+zpl9lk4zpUQcJfka4uVLeoUMMUfhtnqJl102l4u0RKSNJYp0XafXlxbWcy
	 NUTMI5pSRHBr7HduvCw+DCUyVlSjb/8fLgy3xIYbMGD8221r7UI6cJYctCzTSq4Tt
	 rjrUVk5dZD0c3nknofLr4QfLUnFnGbhxEquUue6xoHDmpsiM2LOQk98Rep2gNFCR6
	 cu6rrMo6bk+MS68eAgjMZm7oXbMBkT2KXURFOPWC3+IjWHdNqgcZeii9vP5ZI59bI
	 cumLI1CvLq7vZ8GJ4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1rIjJo2OEa-00xbzN; Thu, 16
 Nov 2023 09:42:32 +0100
Date: Thu, 16 Nov 2023 09:42:30 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Josh Steadmon <steadmon@google.com>
cc: Jeff King <peff@peff.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Feasibility of folding `unit-tests` into `make test`, was Re: [PATCH]
 ci: avoid running the test suite _twice_
In-Reply-To: <ZVU4EVcj0MDrSNcG@google.com>
Message-ID: <850ea42c-f103-68d5-896b-9120e2628686@gmx.de>
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com> <20231113184909.GB3838361@coredump.intra.peff.net> <ZVU4EVcj0MDrSNcG@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-424398454-1700124152=:482"
X-Provags-ID: V03:K1:jdQ4jWTSXUDWuJmSACfMvyp1FZi3nkXlHdHCyPEiMoMuiTnS+bS
 X1uY/Qe5ULP9VbITEtkXRwLI73mOJ0o/SiG3HWBaAcUFFLt1xBZjsbnUKYhzn6DmrpSTpCV
 rSB2KuD8KFePIQpKpI8IXjPhBarG743NdTmBM2fYi/GWNlqGC/lHw7j7uyfSwNNQqmM8VTg
 s9ei4rUWOHKo9XPBkG+hQ==
UI-OutboundReport: notjunk:1;M01:P0:l8WdKQV9yAc=;ZZGS5DMh4agK5Sbt0Z+7vpzZa8p
 nbDpbgCZ7xxlzpT2LAhQHEBdKBQ5W8hJ7l/jPOGncW+FRp13chR8HbGa48QnPfLUNflYnyzV1
 VZ1n0Wthepn8OA8jSHU+e6HRFr6o2ZlQBpLmPgQnzVIyS6uSqIYAMP/VYpQGPsQTyTryOLYoP
 KFroayXlUG4TCCUDoVf2UadDaSea06n9XXJmi54S4m2ZwPyAoXskjUgAZ0l3nScd6Coivb9Ec
 ku8ThWvzGeMR8UvbCM1vlzPOUtFsWFWy62duQ/2+a6ffi0rjkv3d9Nhty6HOwhatF9hJMHxFo
 poHWJhC97DBB9AD8jyBZ6P5WDIbj1Kcn25aI3dwil3b0xIam33zZKOo0enthXYXRsr+HTr3b6
 3fwPB0VjvclVzfpN3BJCR42f8IBeNs90byLaZ9g7muyflHZwefvuXVy0X4m7afk/T7+Io1fMT
 5fmW91Aev6pIXLpKoeb55F7Y4mRvCwzNCANhWNxjP2a7J305syV2T+NpJLllLLFPC8nzc/Mr0
 etIJqfULk2VQ1XvC3vgqUTdB7DDQlW66rUESYLYUSrU1MNJzepwxB1A4GANBUxKA0icrMePi9
 ejHbCg5a+S2o+k5UiaFp8Ab3OJWxRZuBaCGezQcNW13dKJfOTW3FvbVYdGthwcbYvgPoabGEZ
 Ovrru1CaLISyqtdjHrZFp3SfN4o3QH0lO9H6gX/9NXPML1JSQfAQfn0UVdAAEy2CFbwN+HBmC
 x8cPxthNTchGAtehTAMu5hBAKyu9XSOtteJ/rKto1miHhQoxgLnt22/lizoj5vNdB7Cc4hWGA
 F2UN2SuiCWpMPkU+E9DwfsoK2sPw3ddiF62VxAdeolc6FjCCyNPOaMfY5laX/iGLCDQPA/CCt
 vKLx6DeoDI0b1GSP38SigMR6SKm9hVbkdvH+M4S3xd2aymhYJsi0ydH6pMOEIvU4ZngHTyMQF
 Dk0orA==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-424398454-1700124152=:482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Wed, 15 Nov 2023, Josh Steadmon wrote:

> On 2023.11.13 13:49, Jeff King wrote:
> >
> > why are the unit tests totally separate from the rest of the suite? I
> > would think we'd want them run from one or more t/t*.sh scripts. That
> > would make bugs like this impossible, but also:
> >
> >   1. They'd be run via "make test", so developers don't have to rememb=
er
> >      to run them separately.
> >
> >   2. They can be run in parallel with all of the other tests when usin=
g
> >      "prove -j", etc.
>
> The first part is easy, but I don't see a good way to get both shell
> tests and unit tests executing under the same `prove` process. For shell
> tests, we pass `--exec '$(TEST_SHELL_PATH_SQ)'` to prove, meaning that
> we use the specified shell as an interpreter for the test files. That
> will not work for unit test executables.

Probably my favorite aspect about the new unit tests is that they avoid
using the error-prone, unintuitive and slow shell scripts and stay within
the programming language of the code that is to be tested: C.

> We could bundle all the unit tests into a single shell script, but then
> we lose parallelization and add hoops to jump through to determine what
> breaks. Or we could autogenerate a corresponding shell script to run
> each individual unit test, but that seems gross. Of course, these are
> hypothetical concerns for now, since we only have a single unit test at
> the moment.

I totally agree with you, Josh, that it makes little sense to
try to contort the unit tests to be run in the same `prove` run as the
regression tests that need to be invoked so totally differently.

> There's also the issue that the shell test arguments we pass on from
> prove would be shared with the unit tests. That's fine for now, as
> t-strbuf doesn't accept any runtime arguments, but it's possible that
> either the framework or individual unit tests might grow to need
> arguments, and it might not be convenient to stay compatible with the
> shell tests.
>
> Personally, I lean towards keeping things simple and just running a
> second `prove` process as part of `make test`.

Agreed.

> If I was forced to pick a way to get everything under one process, I'd
> lean towards autogenerating individual shell script wrappers for each
> unit test. But I'm open to discussion, especially if people have other
> approaches I haven't thought of.

One alternative would be to avoid running the unit tests via `prove` in
the first place.

For example, we could use the helper from be5d88e11280 (test-tool
run-command: learn to run (parts of) the testsuite, 2019-10-04) [*1*]. It
would probably need a few improvements, but certainly no wizardry nor
witchcraft would be required. It would also help on Windows, where running
a simple test helper written in C is vastly faster than running a complex
Perl script (which `prove` is).

Ciao,
Johannes

Footnote *1*: I had always wanted to improve that test helper to the point
where it could replace our use of `prove`, at least on Windows. It seems,
however, that as of 4c2c38e800f3 (ci: modification of main.yml to use
cmake for vs-build job, 2020-06-26) we do not use the helper at all
anymore. Hopefully it can still be useful. =F0=9F=A4=9E

--8323328-424398454-1700124152=:482--
