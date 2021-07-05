Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2ABC07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2C761977
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 21:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhGEVyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 17:54:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:50301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhGEVyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 17:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625521929;
        bh=VBaKtr8tJmR8C6tvFxWBiepMhhw5wvxpWvBHruDUAPo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TQ6bbb7kCS9bnrLioGT+BYIBvhWwTOd6G+siAQrxvNZ0bgzqoIEkBx4ZQ4brrL00U
         xVwH3QIJyMpFW8t5MtXgVwqTcNidEPLoab5eaZofhsrwMby40s1d5zadX5A+KWg1Es
         z2w07x/iSlFsGNveQqDehn0K1sEuMbpbfDl4PCEg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.249.152] ([89.1.213.17]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1lI4t91mC2-00ikvE; Mon, 05
 Jul 2021 23:52:09 +0200
Date:   Mon, 5 Jul 2021 23:52:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 14/34] fsmonitor--daemon: implement 'start' command
In-Reply-To: <87a6n5d600.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107052336480.8230@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com> <87a6n5d600.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2031558655-1625521929=:8230"
X-Provags-ID: V03:K1:p0vYJk9YpCFOtyDOBg+tZFgLS2g9wra4T8Ej/eC+99QU7OG+IJj
 G0pGF1iAM+0DaiDp08TMQ8GWPmwtjKqLqbmdHtH47uPK/sudnLXd7tpFLknil0iLFhZEoFm
 9uuGVrEsO4mMYoYvucQOEAgDngqkWVobuJ4Vzg11DGa9RxGpEijR7/P9vuFug7RykrY4Res
 LcixGiN4huc6iswzf4DIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dFHKJay6SEc=:CGJUAyiNLX5uxtbhKFo3w+
 R+6T2YTVzhpBRH9cxtQTIjNb4vimA4IWw8tVysc/2rnST5NFshxmCQmlFiUl9YyxL3wv7G9F/
 JqsEjo6Po1u6RYCFxDC14j5YG8UbiXUi7txGVdA2ITl4PPQ0ZiSz/DJabHJHL3uPXNy1kFHbq
 pCOq20NsXVMxCehNyxU1tZQxy5gcm7YZ3cM0z+cxHEBL5WdY4hVK5wWneWhZq3BrIZtPC6qz6
 DbnXr1/xdme2lGkkUfbwTCihGih8DIm8EFgIP3ywMxJcIqS49AMSMIWbNtdXNpw5ZNFLIAjgK
 rxqRY7hG2udtyvZFc3CV5H4lf2EgmN/NLajqmMheETojYnEyK7NQCQS723G5REOCiAH20ylY0
 L1pajjVRlXAhU90Ul75FL2RakolirzXQGOX9p2Q2/CxzWN/VFSSxv9c8QMRSDKJ7JRDfpnLyu
 59Z/535qbFt2HoloEMj1+4IIbOfc9D9MkoAu25/TvNnh31FKSBlorfLMZooxtZGI/VISqpUju
 SDsVugbDhNGABQAdKoOYwIZrsM80VaPEjB6EFhPystS1dfx84VoSCpaCdNdaJL7E3+mw3sPX9
 3XRKot91sinx5cmkTiiBVpKPrWBoKObP70cR5KgOveDl3a5v5CIgKIDmyHWggPuXVf8CNCNs3
 4RwppoxI+zUPmtziRn2t+ycZQgZyK8wyEE3wfXY1W/rfa518todCl9PzdOXx1DLEf5OfERmRZ
 pmH9ksHdyVo6gQKDKEXqPXkIiPvL6SAgYy6DaDGLtxzcSaKf6FQetBT1lqFua67pmz7ScO/4d
 fegvmN5ztsoj8+oY143CB+srPV/3Uy7Hj/LToW3erubsgs+m0rYdQYGalCq03GfO00Szm0kUf
 Jn7iUBRIEtIMqLQLb62iOHFPd8zVKy0LH3VJHSnKJHZDunxL5BzuTIrJ3koSi4bjoj8xwGmzm
 7FTy1WepZrYx1DL3Fl0LLXwSQHasxGmFk80C9PlBd2SPu2UhzuNZOHx5JFIbhvFb7CW6gAbyD
 mPXPdTGzQqOZf9OF2n44ZwmcYofbDSINLFvUoh5AAT/YkQVZZsMgO1EdhY1zPrMdbi+mWP2A3
 rFrv9WTlAhlEGm9JhjDc9xWKZbCdUbnYLUPXtuBbm37+R2TO38PKdOc3w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2031558655-1625521929=:8230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 2 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>
> > +#ifdef GIT_WINDOWS_NATIVE
> > +/*
> > + * Create a background process to run the daemon.  It should be compl=
etely
> > + * disassociated from the terminal.
> > + *
> > + * Conceptually like `daemonize()` but different because Windows does=
 not
> > + * have `fork(2)`.  Spawn a normal Windows child process but without =
the
> > + * limitations of `start_command()` and `finish_command()`.
> > + *
> > + * The child process execs the "git fsmonitor--daemon run" command.
> > + *
> > + * The current process returns so that the caller can wait for the ch=
ild
> > + * to startup before exiting.
> > + */
> > +static int spawn_background_fsmonitor_daemon(pid_t *pid)
> > +{
> > +	char git_exe[MAX_PATH];
> > +	struct strvec args =3D STRVEC_INIT;
> > +	int in, out;
> > +
> > +	GetModuleFileNameA(NULL, git_exe, MAX_PATH);
> > +
> > +	in =3D open("/dev/null", O_RDONLY);
> > +	out =3D open("/dev/null", O_WRONLY);
> > +
> > +	strvec_push(&args, git_exe);
> > +	strvec_push(&args, "fsmonitor--daemon");
> > +	strvec_push(&args, "run");
> > +	strvec_pushf(&args, "--ipc-threads=3D%d", fsmonitor__ipc_threads);
> > +
> > +	*pid =3D mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out)=
;
> > +	close(in);
> > +	close(out);
> > +
> > +	strvec_clear(&args);
> > +
> > +	if (*pid < 0)
> > +		return error(_("could not spawn fsmonitor--daemon in the background=
"));
> > +
> > +	return 0;
> > +}
> > +#else
> > +/*
> > + * Create a background process to run the daemon.  It should be compl=
etely
> > + * disassociated from the terminal.
> > + *
> > + * This is adapted from `daemonize()`.  Use `fork()` to directly
> > + * create and run the daemon in the child process.
> > + *
> > + * The fork-child can just call the run code; it does not need to exe=
c
> > + * it.
> > + *
> > + * The fork-parent returns the child PID so that we can wait for the
> > + * child to startup before exiting.
> > + */
> > +static int spawn_background_fsmonitor_daemon(pid_t *pid)
> > +{
> > +	*pid =3D fork();
> > +
> > +	switch (*pid) {
> > +	case 0:
> > +		if (setsid() =3D=3D -1)
> > +			error_errno(_("setsid failed"));
> > +		close(0);
> > +		close(1);
> > +		close(2);
> > +		sanitize_stdfds();
> > +
> > +		return !!fsmonitor_run_daemon();
> > +
> > +	case -1:
> > +		return error_errno(_("could not spawn fsmonitor--daemon in the back=
ground"));
> > +
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +#endif
>
> The spawn_background_fsmonitor_daemon() function here is almost the same
> as daemonize().

Yes, the code comment above that function even says that it was adapted
from `daemonize()`.

And above that, of course, is a _completely different_ implementation that
works on Windows (you will notice that this is in stark contrast of
Windows, where the `daemonize()` function will simply fail with `ENOSYS`).

> I wonder if this & the Windows-specific one you have here can't be
> refactored into an API from what's now in setup.c.

Given that there is no `fork()` on Windows (which has been the subject of
many a message to this mailing list), I think the answer to this question
of yours is a resounding "No".

> Then we could make builtin/gc.c and daemon.c use that, so Windows could
> have background GC, and we'd have a more battle-tested central codepath
> for this tricky bit.

Please. Not _more_ sidetracks.

The issue of getting `git gc --auto` to daemonize on Windows is a rather
complicated one. I won't bore this list with the details, but link to
https://github.com/git-for-windows/git/issues/2221#issuecomment-542589590
(a ~950 word analysis of the problem).

> It seems to me like the only limitations on it are to have this return
> slightly more general things (e.g. not set its own errors, return
> structured data), and maybe some callback for what to do in the
> child/parent.

And one version doesn't `die()`. Nor does it call `exit(0)` in the parent
process. But it calls `fsmonitor_listen()` in the child process. And if
you wanted to refactor `daemonize()` to do all that, it would have to be
renamed (because it does no longer _necessarily_ daemonize), and it would
have to have a `gentle` flag, and it would somehow have to indicate in its
return value whether `0` means that the parent process returned
successfully or the client process. And soon we'll end up with a function
that is both longer and more unreadable than what we have right now.

>
> > +/*
> > + * This is adapted from `wait_or_whine()`.  Watch the child process a=
nd
> > + * let it get started and begin listening for requests on the socket
> > + * before reporting our success.
> > + */
> > +static int wait_for_background_startup(pid_t pid_child)
> > +{
> > +	int status;
> > +	pid_t pid_seen;
> > +	enum ipc_active_state s;
> > +	time_t time_limit, now;
> > +
> > +	time(&time_limit);
> > +	time_limit +=3D fsmonitor__start_timeout_sec;
> > +
> > +	for (;;) {
> > +		pid_seen =3D waitpid(pid_child, &status, WNOHANG);
> > +
> > +		if (pid_seen =3D=3D -1)
> > +			return error_errno(_("waitpid failed"));
> > +		else if (pid_seen =3D=3D 0) {
> > +			/*
> > +			 * The child is still running (this should be
> > +			 * the normal case).  Try to connect to it on
> > +			 * the socket and see if it is ready for
> > +			 * business.
> > +			 *
> > +			 * If there is another daemon already running,
> > +			 * our child will fail to start (possibly
> > +			 * after a timeout on the lock), but we don't
> > +			 * care (who responds) if the socket is live.
> > +			 */
> > +			s =3D fsmonitor_ipc__get_state();
> > +			if (s =3D=3D IPC_STATE__LISTENING)
> > +				return 0;
> > +
> > +			time(&now);
> > +			if (now > time_limit)
> > +				return error(_("fsmonitor--daemon not online yet"));
> > +		} else if (pid_seen =3D=3D pid_child) {
> > +			/*
> > +			 * The new child daemon process shutdown while
> > +			 * it was starting up, so it is not listening
> > +			 * on the socket.
> > +			 *
> > +			 * Try to ping the socket in the odd chance
> > +			 * that another daemon started (or was already
> > +			 * running) while our child was starting.
> > +			 *
> > +			 * Again, we don't care who services the socket.
> > +			 */
> > +			s =3D fsmonitor_ipc__get_state();
> > +			if (s =3D=3D IPC_STATE__LISTENING)
> > +				return 0;
> > +
> > +			/*
> > +			 * We don't care about the WEXITSTATUS() nor
> > +			 * any of the WIF*(status) values because
> > +			 * `cmd_fsmonitor__daemon()` does the `!!result`
> > +			 * trick on all function return values.
> > +			 *
> > +			 * So it is sufficient to just report the
> > +			 * early shutdown as an error.
> > +			 */
> > +			return error(_("fsmonitor--daemon failed to start"));
> > +		} else
> > +			return error(_("waitpid is confused"));
> > +	}
> > +}
>
> Ditto this. could we extend the wait_or_whine() function (or some
> extended version thereof) to do what you need with callbacks?
>
> It seems the main difference is just being able to pass down a flag for
> waitpid(), and the loop needing to check EINTR or not depending on
> whether WNOHANG is passed.

Given that over half of `wait_or_whine()` is concerned with signals, which
the `wait_for_background_startup()` function is not at all concerned with,
I see another main difference.

> For e.g. the "We don't care about the WEXITSTATUS()" you'd get that
> behavior with an adjusted wait_or_whine(). Wouldn't it be better to
> report what exit status it exits with e.g. if the top-level process is
> signalled? We do so in trace2 for other things we spawn...

The `wait_or_whine()` function also adjusts `atexit()` behavior, which we
would not want here.

Therefore, just like the suggestion about `daemonize()` above, it appears
to me as if the suggested refactoring would make the code dramatically
more complex and less readable.

In other words, it would be a refactoring for refactoring's sake.
Definitely not something I would suggest.

Ciao,
Johannes

--8323328-2031558655-1625521929=:8230--
