From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Sun, 8 May 2016 08:33:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605080811380.4092@virtualbox>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org> <alpine.DEB.2.20.1604251704300.2896@virtualbox> <CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com> <572BA80E.3000309@kdbg.org> <CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
 <alpine.DEB.2.20.1605061733170.2963@virtualbox> <CAP8UFD0ht+ozCMguGwBc19dd9ViXG4tTE0mdaOQ+JVXhSOk02Q@mail.gmail.com> <alpine.DEB.2.20.1605071409490.2963@virtualbox> <CAP8UFD2wFZgOzmadm7X2988RyDGve92TsoMHPf2S5Ydyhc=Nyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 08:34:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azII4-0001pB-1W
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 08:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbcEHGdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 02:33:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:56622 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbcEHGdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 02:33:54 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lm6IP-1bYcxt11Qv-00Zd0u; Sun, 08 May 2016 08:33:28
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD2wFZgOzmadm7X2988RyDGve92TsoMHPf2S5Ydyhc=Nyg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:hF5ScgGQamxdETevPDKSBt24xrQP61EfqitZF5KQWJ9BXHvzPy6
 MheQQ1ozrUqdiplbOMYrrxkVuEZN2XhzRHBQSkbCKqyQjJSt7h2Ns8khXOQF8SYY334Hp7B
 wX0SmwKXnvt2m/Xdn4oOIP73nza3JD7pBbx+I/ljb2P8fKTvrXwaCk0VrzSics3QgAl36If
 Qtxmq3Q0gvD8zGx4ncwSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tUDQ3CODxgk=:OAJ0UOjih0IzBO80oNaWex
 /NkpFRDyGmEaaXEPrpH6y2hQtoJ7VUoxXhVU1pGhyBVczK3sEzatOj/XwtR3jbJa/2h35nSCm
 EHdpKgmF4ENKssk+9kCUYBuT7ieVFA8OsZhXjkm8r2Xv1KflUMPPh6d1JPvR0oBDubbhjrCe3
 NARTJup/dj+MfDBLLzL7Bmz8iQpwxErzlsHRZX13w46LnEE5r3x16hSItDKPnnqTIJdaUq+y7
 niunNGEhclG+VDpKK08YYgHoSNbsIv1UAE5NzuqZCW01E1/iUIzw06Xs+LR88sxT8f3wV62wj
 T8AyKHHJKitthMQI4mFl+Vdn5sWQ+fWU37J+FfW9a2jxjTMVZJPJJ2sTapQ1BwEjjIYq5B5+v
 n9IrLJx3Izz8ebqrMaoNI+t3aygT32CnzNMMpBbZR3avpOpvlL0k4kU+QYISEllCawZije24Z
 psWYnrnU/fjhliwRTidgSCALijl9rHB7BeOToKpN/s4THyPyctgN+AJLxsU+uixK9gq6oB033
 bizLF92tsdB+vYi5oB739xM4h84JlZJyGQq7vGmYIRL5fzhkYN/1huhQdYvfJRHZMISR/mSev
 tcNP9VGccqc66Zq2WNh1inyTUetKPAmALHjFQXTY4PKPRibnZP9Kbugu4GNizAwf3Ihx3JjSP
 bnkgj6nsKZmAsO8UaeofcIj4ydz94MRk8EAFAW7btcgD42Rz3DK5DKIHpzJbg9ROVC4eI0Itz
 LkilR98dtfdkx1I9OsKLzo+W2p/HxXXt1eTZ9CmszJqDswq3FF1+LOttMVJ+jIOrCQc5kowD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293910>

Hi Chris,

On Sat, 7 May 2016, Christian Couder wrote:

> On Sat, May 7, 2016 at 2:13 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 7 May 2016, Christian Couder wrote:
> >
> >> On Fri, May 6, 2016 at 5:34 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >
> >> > No, you should change the code that requires that ugly dup()ing so
> >> > that it can be configured to shut up.
> >>
> >> After taking a look, it looks like a routine that does nothing could
> >> be passed to set_error_routine() and that could do part of the trick.
> >>
> >> This part might not be too ugly, but it would anyway be more complex,
> >> less close to what the code is doing now and more error prone, as one
> >> also need to make sure that for example no warning() or
> >> fprintf(stderr, ...) are called and nothing is printed on stdout.
> >
> > I am afraid that you *have* to do that, though, if you truly want to
> > libify the code.
> >
> > Of course you can go with really ugly workarounds instead. Something
> > like a global flag that die() and error() and warning() respect. It
> > would incur some technical debt, but it would make your life easier in
> > the short run.
> >
> > Both the real solution and the workaround would be better than the
> > current version of the patches that dup() back and forth, just to
> > avoid addressing the real problem.
> 
> The code that is now in master in builtin/am.c does:
> 
>     if (state->threeway && !index_file) {
>         cp.no_stdout = 1;
>         cp.no_stderr = 1;
>     }
> 
> and in run-command.c there is already:
> 
>         if (cmd->no_stdout)
>             dup_devnull(1);
>         [...]
>         if (cmd->no_stderr)
>             dup_devnull(2);

Of course it does that. Because there is no other way, that's why: you
cannot change the code that is spawned by start_command().

> for Linux and the following for Windows:
> 
>     if (cmd->no_stderr)
>         fherr = open("/dev/null", O_RDWR);
>         [...]
>     if (cmd->no_stdout)
>         fhout = open("/dev/null", O_RDWR);

And it is very well contained on Windows. No other callers. The code
is limited to run_command.c.

> so the current code is already using dup_devnull() for Linux that you
> don't want me to use, and it looks like there is already a simple way
> to do that on Windows.

The difference between the code in master and what your patches try to do
is that in the latter case, you want to dup() just for a while, to shut up
a code path that is not only known very well, but our very own code that
is easily changed, only to dup() it *back* in the end.

The claim is that this libifies the procedure. But it makes the code
really nasty for use as a library: if this is run in a thread (and you
know that we are going to have to do this in the near future, for
performance reasons), it will completely mess up all the other threads
because it messes with the global file descriptors.

And that is why it is ugly: it incurs an enormous technical debt that will
make code changes substantially more complicated down the road.

In essence, you save yourself a little time by sloppily dup()ing back and
forth. At the expense of making the life much harder for the developer who
needs to use your code as a library function.

And actually, hiding even fatal errors might be an ugly side effect of the
current implementation, an unfortunate implementation detail, really, not
something we want to preserve when libifying the code. And actually,
dup()ing the *caller's* stdout is not exactly preserving the current
behavior that dup()s the *called process'* stdout.

So yes, I find the proposed patch inelegant.

If others are okay with this, I will shut up. But I have to point out that
it is ugly code, plain and simple, that silences an entire global file
descriptor, just temporarily, only to avoid a careful set of patches that
introduces a silent mode to the library functions that need to be called,
which might even facilitate other libifying efforts.

I hope you do not take this as a personal attack. It is not intended as
such. It is intended to help end up with the best possible code quality.

Ciao,
Johannes
