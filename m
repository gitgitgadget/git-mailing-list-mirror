Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11155C33CB1
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EE92072B
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 12:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NPNHFcXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgANMrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:47:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:40783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgANMry (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 07:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579006065;
        bh=w1YelNmv+Vm/wVodCcF0VMojSLJvdp9kJp7F1Tiq9mQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NPNHFcXq2rmUFx5VKL/IRIj/dFLHWCMl0db4fLUlCxyfD2jWWRHipkzkM3MduglrC
         r7ALgbclG8prPutOarkoj1XsYc/QxUu4JunZ/NSLWzIcs7cU9Niaw298taeWZPDsYy
         /N6O7fLw3kx5FW96nAsycUJrlM/Je2MELnWWDiF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1j9IEV3Rzf-00IWti; Tue, 14
 Jan 2020 13:47:44 +0100
Date:   Tue, 14 Jan 2020 13:47:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/10] built-in add -i/-p: treat SIGPIPE as EOF
In-Reply-To: <20200113170417.GK32750@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2001141301310.46@tvgsbejvaqbjf.bet>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com> <pull.175.v3.git.1578904171.gitgitgadget@gmail.com> <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com> <20200113170417.GK32750@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1685775113-1579006064=:46"
X-Provags-ID: V03:K1:uLmevteo0ZUt3rsnpBS/rT+OtloSZwUBeSnADtsnSui1xkOkrwe
 A5HzJDQE3zYwrZHGWYOCkYf7hQWGNKDTQjWccYl9nGkXT1Yw7QmEX6hQhB89aay2HLiU9LS
 idy3EXuCAEya+wqM68R9oS8wkNtNXboaPpm6YSrpmRUyr4Hrs+hHUshysrFTD5htqJt01Ko
 V5vQSlddpWjlyAs5uGXcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCI7SczvPRg=:XRIb5KpUQjKz75imQHs0/F
 0xPQhTIe1COUraNemRDnQ2EZh4KwquI+2vmhpYI+oK3fyy+RnVg54OyGhHS0+7DfR91sEPZ1S
 KMP/4nvykC/Hxsbbng6Ov5bsj7FL3ygk1o7CsTTzI2dYFAfuTIHOSZbtacK94nyWMehxgzvrD
 /gkwXEeM9YmoUJhLwGKk2Am9CxjeJ9fB/LWy6qbPV37fAt7JI+xbYhYLBFDRW7xzVHO3rDYp7
 hgVcA7XvaVLEGQcYN0UqOzdQyqQg+kZILOpYS79yT6FgH6QgLuFldm/s35YbGYeyURJgJ8rfY
 RrCv85YYXeBgoZZioC4SHpRzYltTT+3VXnfNuR5smo4cHL+2sCJBX9TmUQibSttv1QxeW/x3O
 FmVnU83asMw5Si3rMrY+Rph782msmhIwh5KL8zJxwVNb1SbCrhuThCeFrcmsFK3Ax4LziwaFf
 akXvM/peOhTnrVqCuJZqmVFoafDUaL4V6bI/N8nRJSKbzpJy5DUgSBYTDDNE1CO1zUmuyuJqv
 EJL2oUmBAsTQR93We4sU3fnavofreTm14xRNzSn6Dv+9RWkbzAr0ysiFWJbgHq7RX6GBtbOpK
 +76h4zbmEobsQk+h5nKmDRWFCwfpeUDXnqTCJz3GW/oxqZif9+7BhVUPdDA3GeO750Jz/4LfX
 Cju2gx+b5bVEGQzhO80/iXddbSFXwNjBjeOmz0JajWHtroGsLd9uoFfLe3IkxG8Y9ZtLZX5Jk
 nfn8jx7loONq0b0AuRNY8jG+eCYqDiO1U2qFTbseb6LGAVi4FFQs5pVPPkfe1lhSF6nBz3hY9
 hZcijrhw1nFVm0nbjzQvN2fRaXc+Kr/XlhvyWI6bhWyhfkEPV6M3j+V3OoFnmm+2mulqvnvhb
 IWB4cGPoD2GaCN57AzO7rDRQCSQLnsIHVgrAV+gnC2O5cIeYcdyRe3iAwkU0K7M2FMd6LXKpn
 aHllEVoNbaXn+VTnl2b+WM6OIeicmzWEceD1rZ8FKvAiqHVcxuIOsRtKvPnnXshSY4RopPj6b
 j9yI0AUsGQRB+gOGYBpvJwEdABDmf4Atr56m+xiD1oLUwA9pSBP6kEAyNBDUy6MnPD/FOqPcv
 Q/imUKF+9bW3Eue3F/pUDhqRXzuQ0ZFzFQpD2dqOBcQufDwULFQU69OfU1rUZ3jDcL2NP5TZV
 +aApc48J/sF4n0tyoxuRZ2usI0UqvuQ32JZXRquYMQzwQd4lkq6fg7cVTcHoR4SbFdOKLxe6X
 2Iuidpl7VBh7h8O5V0PLhpMx3AnOMh5Nt5m6NKLJ9j+NX5UZ0AflTEG2RuhM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1685775113-1579006064=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 13 Jan 2020, SZEDER G=C3=A1bor wrote:

> On Mon, Jan 13, 2020 at 08:29:22AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > As noticed by G=C3=A1bor Szeder, if we want to run `git add -p` with
> > redirected input through `test_must_fail` in the test suite, we must
> > expect that a SIGPIPE can happen due to `stdin` coming to its end.
>
> I don't think this issue is related to the redirected input: I
> modified that flaky test to send "unlimited" data to 'git add's stdin,
> i.e.:
>
>   /usr/bin/yes | test_must_fail force_color git add -p
>
> and the test with --stress still failed with SIGPIPE all the same and
> just as fast.
>
> After looking into it, the issue seems to be sending data to the
> broken diffFilter process.

Ouch. Thank you for investigating. For my education, how did you debug
this? I could not find a way to identify *what* caused that SIGPIPE...

> So in that test the diff is "filtered" through 'echo too-short', which
> exits real fast, and doesn't read its standard input at all (well, apart
> from e.g. the usual kernel buffering that might happen on a pipe between
> the two processes). Making sure that the diffFilter process reads all
> the data before exiting, i.e. changing it to:
>
>   test_config interactive.diffFilter "cat >/dev/null ; echo too-short" &=
&
>
> made the test reliable, with over 2000 --stress repetitions, and that
> with only a single "y" on 'git add's stdin.

Ah, my diff filter simply ignores the `stdin`... That's easy enough to
fix, and since real-world diff filters probably won't just blatantly
ignore the input, I think it is legitimate to change the test.

> Now, merely tweaking the test is clearly insufficient, because we not
> only want the test to be realiable, but we want 'git add' to die
> gracefully when users out there mess up their configuration.

I think it is sufficient to tweak the test, but I agree that a better
error message might be good when users out there mess up their
configuration.

> Ignoring SIGPIPE can surely accomplish that, but I'm not sure about
> the scope.  I mean your patch seems to ignore SIGPIPE basically for
> almost the whole 'git add -(i|p)' process, but perhaps it should be
> limited only to the surroundings of the pipe_command() call running
> the diffFilter, and be done as part of the next patch adding the 'if
> (diff_filter)' block.

Right. Very heavy-handed, and probably inviting unwanted side effects.

> Furthermore, I'm worried that by simply ignoring SIGPIPE we might just
> ignore a more fundamental issue in pipe_command(): shouldn't that
> function be smart enough not to write() to a fd that has no one on the
> other side to read it in the first place?!
>
> So, when the diffFilter process exits unexpectedly early, then the
> poll() call in pipe_command() -> pump_io() -> pump_io_round() returns
> with success and usually sets 'revents' for the child process' stdin
> to 12 (i.e. 'POLLOUT | POLLERR'; gah, how I hate unnamed constants :).
> Unfortunately, at that point we don't take any special action on
> POLLERR, but call xwrite() to try to write to the dead fd anyway,
> which then promptly triggers SIGPIPE.  (This is what usually happens
> when stepping through the statements of those functions in a debugger,
> and the diffFilter process has all the time in the world to exit.)
>
> We could handle POLLERR with a patch like this:
>
>   --- >8 ---
>
> Subject: run-command: handle POLLERR in pump_io_round() to reduce risk o=
f SIGPIPE
>
> diff --git a/run-command.c b/run-command.c
> index 3449db319b..57093f0acc 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1416,25 +1416,31 @@ static int pump_io_round(struct io_pump *slots, =
int nr, struct pollfd *pfd)
>  	if (poll(pfd, pollsize, -1) < 0) {
>  		if (errno =3D=3D EINTR)
>  			return 1;
>  		die_errno("poll failed");
>  	}
>
>  	for (i =3D 0; i < nr; i++) {
>  		struct io_pump *io =3D &slots[i];
>
>  		if (io->fd < 0)
>  			continue;
>
> -		if (!(io->pfd->revents & (POLLOUT|POLLIN|POLLHUP|POLLERR|POLLNVAL)))
> +		if (io->pfd->revents & POLLERR) {
> +			io->error =3D ECONNRESET;  /* What should we report to the caller? *=
/
> +			close(io->fd);
> +			io->fd =3D -1;
> +			continue;
> +		}
> +		if (!(io->pfd->revents & (POLLOUT|POLLIN|POLLHUP|POLLNVAL)))
>  			continue;
>
>  		if (io->type =3D=3D POLLOUT) {
>  			ssize_t len =3D xwrite(io->fd,
>  					     io->u.out.buf, io->u.out.len);
>  			if (len < 0) {
>  				io->error =3D errno;
>  				close(io->fd);
>  				io->fd =3D -1;
>  			} else {
>  				io->u.out.buf +=3D len;
>  				io->u.out.len -=3D len;
>
>   --- >8 ---
>
> Unfortunately #1, this changes the error 'git add -p' dies with from:
>
>   error: mismatched output from interactive.diffFilter
>
> to:
>
>   error: failed to run 'echo too-short'
>
> It might affect other commands as well, but FWIW the test suite
> doesn't catch any.

Hmm. My first impression is that the error message could be a bit better,
but that it is probably a good thing to have. It would have helped _me_
understand the issue at hand.

> Unfortunately #2, the above patch doesn't completely eliminates the
> SIGPIPE, but only (greatly) reduces its probability.  It is possible
> that:
>
>   - poll() returns with success and indicating a writable fd without
>     any error, i.e. 'revents =3D 4'.
>
>   - the bogus diffFilter exits, closing its stdin.
>
>   - 'git add' attempts to xwrite() to the now closed fd, and triggers
>     a SIGPIPE right away.
>
> This happens much rarer, 'GIT_TEST_ADD_I_USE_BUILTIN=3D1
> ./t3701-add-interactive.sh -r 39,49 --stress-jobs=3D<4*nr-of-cores>
> --stress' tends to take over 200 repetitions.  The patch below
> reproduces it fairly reliably by adding two strategically-placed
> sleep()s, with a bit of extra debug output:
>
>   --- >8 ---
>
> diff --git a/add-patch.c b/add-patch.c
> index d8dafa8168..0fd017bbd3 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -421,6 +421,7 @@ static int parse_diff(struct add_p_state *s, const s=
truct pathspec *ps)
>  			filter_cp.git_cmd =3D 0;
>  			filter_cp.use_shell =3D 1;
>  			strbuf_reset(&s->buf);
> +			fprintf(stderr, "about to run diffFilter\n");
>  			if (pipe_command(&filter_cp,
>  					 colored->buf, colored->len,
>  					 &s->buf, colored->len,
> diff --git a/run-command.c b/run-command.c
> index 57093f0acc..49ae88a922 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1419,6 +1419,7 @@ static int pump_io_round(struct io_pump *slots, in=
t nr, struct pollfd *pfd)
>  		die_errno("poll failed");
>  	}
>
> +	sleep(2);
>  	for (i =3D 0; i < nr; i++) {
>  		struct io_pump *io =3D &slots[i];
>
> @@ -1435,8 +1436,11 @@ static int pump_io_round(struct io_pump *slots, i=
nt nr, struct pollfd *pfd)
>  			continue;
>
>  		if (io->type =3D=3D POLLOUT) {
> -			ssize_t len =3D xwrite(io->fd,
> +			ssize_t len;
> +			fprintf(stderr, "attempting to xwrite() %lu bytes to a fd with reven=
ts flags 0x%hx\n", io->u.out.len, io->pfd->revents);
> +			len =3D xwrite(io->fd,
>  					     io->u.out.buf, io->u.out.len);
> +			fprintf(stderr, "after xwrite()\n");
>  			if (len < 0) {
>  				io->error =3D errno;
>  				close(io->fd);
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 12ee321707..acffc9af37 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -561,7 +561,7 @@ test_expect_success 'detect bogus diffFilter output'=
 '
>  	git reset --hard &&
>
>  	echo content >test &&
> -	test_config interactive.diffFilter "echo too-short" &&
> +	test_config interactive.diffFilter "sleep 1 ; echo too-short" &&
>  	printf y >y &&
>  	test_must_fail force_color git add -p <y
>  '
>
>   --- >8 ---
>
> and 'GIT_TEST_ADD_I_USE_BUILTIN=3D1 ./t3701-add-interactive.sh -r 39,49'
> fails with:
>
>   + test_must_fail force_color git add -p
>   about to run diffFilter
>   attempting to xwrite() 224 bytes to a fd with revents flags 0x4
>   test_must_fail: died by signal 13: force_color git add -p
>
> I don't understand why we get SIGPIPE right away instead of some error
> that we can act upon (ECONNRESET?).

Isn't it buffered?

In any case, I would take the above-mentioned patch, even if it makes it
"only" less likely to hit `SIGPIPE`.

> FWIW, it fails the same way not only on my box, but on Travis CI's Linux
> and OSX images as well.
>
>   https://travis-ci.org/szeder/git/jobs/636446843#L2937
>
>
> Cc'ing Peff for all things SIGPIPE :) who also happens to be the
> author of both pipe_command() and that now flaky test.

I'll go with Peff's suggestion to use `sed 1d` instead of `echo
too-short`.

Thanks,
Dscho

--8323328-1685775113-1579006064=:46--
