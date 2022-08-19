Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE980C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347451AbiHSKFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbiHSKFS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:05:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0FEEC62
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660903512;
        bh=TbpzE0Qd1hqFsBaCvuht3a496aJZ11hOyeWchrCPaU4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NqJFtzxUJNtQMKJX2ZI9UdZC6RppdhdTK383G/1ybZTlDU2vg91zxsZW+YELM9qWh
         yYqVplSgkivjxKIcgRyZPVC1X0FrBs394DCwv1Wy31ymtI3CsK+fxQLRRjMnX/sDzj
         itg+oK8SYGJw+WSxKdsfjtlYNKDmxNRbyYTUV/jI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1poA-1oMn0y0gUS-002J6Y; Fri, 19
 Aug 2022 12:05:12 +0200
Date:   Fri, 19 Aug 2022 12:05:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
In-Reply-To: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
Message-ID: <4q6248n0-nqr5-p5pp-64s3-qq7nr53q01op@tzk.qr>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kmuFSfnPFDTYny/R3bZWRXaEFhA9QPxylUOFe61UJPY36+TSspO
 INlD2Uf3BUxKnihtRHYrrVa1CXLntnNjfKtikdbJ0aaElshPKb0deP20QcXeLr1uj3ha+9S
 p2rlUPPCukU0bW9IwqKBkFlFs06XV2i9zqfX8u7GQIKGbkJ04/v2gIjlouCB2w8c9fLgdu5
 ddA/z8y+sJ6R2Il52GC+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oeejs6mfovA=:KOXE8F2d70GueXh8G4zU0/
 mk5p+ZTCZTZ61A9eaKir16b4IKQ//5XN2kYo5jcT3FEyynESfNLTM0MqyZ3ezd5dcLwQaL0NY
 XecDxa3cwVtJDOzz1Dua1o5pvYNIm58LkPMCHEX3+7qzw1mtIrbvwVpT6yqpKgCGnpFrADlKu
 DKuSJJUacvGAPTlb+a1+bi+BYm/Xh/hvTcUz2UwyaYuu7iFWk/8OBcLc0QrWSHP0BWu4NQA5v
 rhc9iYYTv1ue0T/TQ2lP7u8N10S+jbq7uWCoYe/VRBU4jeG1i5ZDAHGKDYrffM1ICo5rLMWTa
 73pm5UYHze9FKlKw3+RkhTg/JZYRD07kSbiIXTlsTAnbH1DkWg5q5lw9akwTRLfqOMY1ygiqL
 U4iJrOzqHP6NzgPpfs3tPD1G8OpLZTVSMuKMT4nBnMcAbX/1q6Zm9TB5/GgpifB+38dUDWDYy
 MKB3KrBr7qf4EHslIFt6onoFYwINSpSqNOf8fIkntvJULq2apBAbv+qDeNeo8LRLIVQcHG4/K
 HCdP3CLw5gbNCnKpokqayb2Y1SLLbqIn2eHfCL0kit8Ti9q6rTCm2W822Ak6EZw5zWZ+m1f0a
 GVFWVhSc1hXHhDDjd7PlN8H6iSph4k7gJtx0Vyau7opWyZ0hH1T50C02a1UmFClugl6xXFq9e
 e9TC8YmxoL0Virklcq92X1aVZhckUmnBuyZM2Tese4NIsY1o0wgFWoKBEvaRxWEA5dmmvYsqX
 ymAVVeor6yDEIkPOLsHiTUhK29lk8jNI7H9qXSURReykjx6ekEFhvKJF0O56waH2Ly49/qiqR
 djeYBch3yxSehqZ410JaVrOYbT3j7IwuGKf7DSC6e1M5nrMXkpgDdzedU8K3zyK1TZ4+Q6EW0
 4wfKAUc5lUYhdsiUenPW/nfGVNOLvn/boTjQTKnumrQ3bAfumbaQDf1lSynW9pypNcd+q2NZy
 khK79zQBGdDLIrWxYNqzY8WNxjctk6KAuRQOA9Rs+rk+X+/SHADgqbfz1LJvmau8lmGqUSthx
 06qOk24K0qXDYknou4d4BldCMgSskL0IqjImehxKF9jbnnyjOkYe4rbfqUvN7CK7zUDxCYk24
 OtwhTBXFivHNvFZYn7bWJ83vc8w3K6Y6qmx/SlMT+mNBRO2jaHHj8jkHg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 18 Aug 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Though perhaps not common, there are uses cases where users have large,
> network-mounted repos. Having the ability to run fsmonitor against
> network paths would benefit those users.
>
> As a first step towards enabling fsmonitor to work against
> network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
> was introduced for Windows.

If you start the commit message along the following lines, it might be
easier/quicker to grok the context for the keen reader:

	In 85dc0da6dcf (fsmonitor: option to allow fsmonitor to run against
	network-mounted repos, 2022-08-11), the Windows backend of the
	FSMonitor learned to allow running on network drives, via the
	`fsmonitor.allowRemote` config setting.

> Setting this option to true will override the default behavior
> (erroring-out) when a network-mounted repo is detected by fsmonitor. In
> order for macOS to have parity with Windows, the same option is now
> introduced for macOS.
>
> The the added wrinkle being that the Unix domain socket (UDS) file
> used for IPC cannot be created in a network location; instead the
> temporary directory is used.

Thank you very much for this note, after a cursory read I expected that
part of the code to be a left-over from some "We know better than the
user" type of automatic default, and this paragraph definitely helped me
overcome that expectation.

>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>     fsmonitor: option to allow fsmonitor to run against network-mounted
>     repos
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2=
Fedecosta-mw%2Ffsmonitor_macos-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edec=
osta-mw/fsmonitor_macos-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1326
>
>  compat/fsmonitor/fsm-settings-darwin.c | 77 ++++++++++++++++++++++----
>  fsmonitor-ipc.c                        | 47 +++++++++++++++-
>  fsmonitor-ipc.h                        |  6 ++
>  3 files changed, 117 insertions(+), 13 deletions(-)

I am somewhat puzzled that this has no corresponding change to
`Documentation/`.

And now I realize that this was the case also for the patch adding
`fsmonitor.allowRemote` support for Windows.

Could I ask you to add a patch to document this config setting?

>
> diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/f=
sm-settings-darwin.c
> index efc732c0f31..9e2ea3b90cc 100644
> --- a/compat/fsmonitor/fsm-settings-darwin.c
> +++ b/compat/fsmonitor/fsm-settings-darwin.c
> @@ -2,10 +2,28 @@
>  #include "config.h"
>  #include "repository.h"
>  #include "fsmonitor-settings.h"
> +#include "fsmonitor-ipc.h"
>  #include "fsmonitor.h"
>  #include <sys/param.h>
>  #include <sys/mount.h>
>
> +/*
> + * Check if monitoring remote working directories is allowed.
> + *
> + * By default, monitoring remote working directories is
> + * disabled.  Users may override this behavior in enviroments where
> + * they have proper support.
> + */
> +static int check_config_allowremote(struct repository *r)
> +{
> +	int allow;
> +
> +	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
> +		return allow;
> +
> +	return -1; /* fsmonitor.allowremote not set */
> +}
> +
>  /*
>   * [1] Remote working directories are problematic for FSMonitor.
>   *
> @@ -27,24 +45,22 @@
>   * In theory, the above issues need to be addressed whether we are
>   * using the Hook or IPC API.
>   *
> + * So (for now at least), mark remote working directories as
> + * incompatible by default.
> + *

This was moved up, okay.

>   * For the builtin FSMonitor, we create the Unix domain socket for the
> - * IPC in the .git directory.  If the working directory is remote,
> - * then the socket will be created on the remote file system.  This
> - * can fail if the remote file system does not support UDS file types
> - * (e.g. smbfs to a Windows server) or if the remote kernel does not
> - * allow a non-local process to bind() the socket.  (These problems
> - * could be fixed by moving the UDS out of the .git directory and to a
> - * well-known local directory on the client machine, but care should
> - * be taken to ensure that $HOME is actually local and not a managed
> - * file share.)
> + * IPC in the temporary directory.  If the temporary directory is

This is incorrect. It is still the `.git` directory in the common case,
not a temporary directory.

> + * remote, then the socket will be created on the remote file system.
> + * This can fail if the remote file system does not support UDS file
> + * types (e.g. smbfs to a Windows server) or if the remote kernel does
> + * not allow a non-local process to bind() the socket.
>   *
> - * So (for now at least), mark remote working directories as
> - * incompatible.
> + * Therefore remote UDS locations are marked as incompatible.
>   *
>   *
>   * [2] FAT32 and NTFS working directories are problematic too.

Doesn't this patch address this, too? See below for more on that.

>   *
> - * The builtin FSMonitor uses a Unix domain socket in the .git
> + * The builtin FSMonitor uses a Unix domain socket in the temporary
>   * directory for IPC.  These Windows drive formats do not support
>   * Unix domain sockets, so mark them as incompatible for the daemon.
>   *
> @@ -65,6 +81,39 @@ static enum fsmonitor_reason check_volume(struct repo=
sitory *r)
>  			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
>  			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
>
> +	if (!(fs.f_flags & MNT_LOCAL)) {
> +		switch (check_config_allowremote(r)) {
> +		case 0: /* config overrides and disables */
> +			return FSMONITOR_REASON_REMOTE;
> +		case 1: /* config overrides and enables */
> +			return FSMONITOR_REASON_OK;
> +		default:
> +			break; /* config has no opinion */
> +		}
> +
> +		return FSMONITOR_REASON_REMOTE;
> +	}

This `switch()` statement sounds like a verbose way to say the same as:

		return check_config_allowremote(r) =3D=3D 1 ?
			FSMONITOR_REASON_OK : FSMONITOR_REASON_REMOTE;

> +
> +	return FSMONITOR_REASON_OK;
> +}
> +
> +static enum fsmonitor_reason check_uds_volume(void)

What's an UDS volume? Do you mean to say "Unix Domain Socket Volume"?

If so, it would be better to turn this into a function called
`filesystem_supports_unix_sockets()` and to return an `int`, 1 for "yes",
0 for "no".

> +{
> +	struct statfs fs;
> +	const char *path =3D fsmonitor_ipc__get_path();
> +
> +	if (statfs(path, &fs) =3D=3D -1) {
> +		int saved_errno =3D errno;
> +		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
> +				 path, strerror(saved_errno));
> +		errno =3D saved_errno;
> +		return FSMONITOR_REASON_ERROR;
> +	}
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
> +			 path, fs.f_type, fs.f_flags, fs.f_fstypename);
> +
>  	if (!(fs.f_flags & MNT_LOCAL))
>  		return FSMONITOR_REASON_REMOTE;
>
> @@ -85,5 +134,9 @@ enum fsmonitor_reason fsm_os__incompatible(struct rep=
ository *r)

It is unfortunate that the diff hunk stops here, and mails lack a button
to increase the diff context. In this instance, the hidden part of the
`check_volume()` function is quite interesting: it returns
`FSMONITOR_REASON_NOSOCKETS` for `msdos` and `ntfs` file systems.

Which means that your patch changes behavior not only for remote file
systems, but also for local ones without support for Unix sockets.

To heed the principle of separation of concerns, please do split out that
part. I would recommend to make it the first patch to support
`msdos`/`ntfs` file systems (by registering the Unix sockets in a
temporary directory instead of the `.git/` directory). The second patch
can then introduce support for `fsmonitor.allowRemote` on macOS on top of
the first patch.

>  	if (reason !=3D FSMONITOR_REASON_OK)
>  		return reason;
>
> +	reason =3D check_uds_volume();
> +	if (reason !=3D FSMONITOR_REASON_OK)
> +		return reason;
> +
>  	return FSMONITOR_REASON_OK;
>  }
> diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
> index 789e7397baa..6e9b40a03d5 100644
> --- a/fsmonitor-ipc.c
> +++ b/fsmonitor-ipc.c
> @@ -4,6 +4,7 @@
>  #include "fsmonitor-ipc.h"
>  #include "run-command.h"
>  #include "strbuf.h"
> +#include "tempfile.h"
>  #include "trace2.h"
>
>  #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
> @@ -47,7 +48,51 @@ int fsmonitor_ipc__is_supported(void)
>  	return 1;
>  }
>
> -GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
> +GIT_PATH_FUNC(fsmonitor_ipc__get_pathfile, "fsmonitor--daemon.ipc")

Why rename this? That's unnecessary chatter in the patch. Let's avoid such
things in the future, it only costs reviewers time.

> +
> +static char *gen_ipc_file(void)
> +{
> +	char *retval =3D NULL;
> +	struct tempfile *ipc;
> +
> +	const char *ipc_file =3D fsmonitor_ipc__get_pathfile();
> +	FILE *fp =3D fopen(ipc_file, "w");
> +
> +	if (!fp)
> +		die_errno("error opening '%s'", ipc_file);
> +	ipc =3D mks_tempfile_t("fsmonitor_ipc_XXXXXX");
> +	strbuf_write(&ipc->filename, fp);
> +	fclose(fp);
> +	retval =3D strbuf_detach(&ipc->filename, NULL);
> +	strbuf_release(&ipc->filename);
> +	return retval;
> +}
> +
> +const char *fsmonitor_ipc__get_path(void)
> +{
> +	char *retval =3D NULL;
> +	struct strbuf sb =3D STRBUF_INIT;
> +
> +	const char *ipc_file =3D fsmonitor_ipc__get_pathfile();
> +	FILE *fp =3D fopen(ipc_file, "r");
> +
> +	if (!fp) {
> +		return gen_ipc_file();
> +	} else {
> +		strbuf_read(&sb, fileno(fp), 0);
> +		fclose(fp);
> +		fp =3D fopen(sb.buf, "r");
> +		if (!fp) { /* generate new file */
> +			if (unlink(ipc_file) < 0)
> +				die_errno("could not remove '%s'", ipc_file);
> +			return gen_ipc_file();
> +		}
> +		fclose(fp);
> +		retval =3D strbuf_detach(&sb, NULL);
> +		strbuf_release(&sb);
> +		return retval;
> +	}
> +}

I am afraid I do not understand how this code can guarantee a fixed path
for the Unix domain socket.

It _needs_ to be fixed so that a singleton daemon can run and listen on
it, and an arbitrary number of Git clients can connect to it.

If it is not fixed, you will cause Git to quite possibly start a new
FSMonitor daemon for every invocation that wants to connect to an
FSMonitor daemon.

This means that the path of the Unix socket needs to have a 1:1
relationship to the path of the `.git/` directory. If you install it in
that directory, that invariant is naturally fulfilled. If you want to
install it elsewhere, you will have to come up with a reliable way to
guarantee that connection.

One option would be to install the Unix sockets in the home directory,
under a name like `.git-fsmonitor-<hash>` where the <hash> is e.g. a
SHA-1/SHA-256 of the canonicalized path of the `.git/` directory.

>
>  enum ipc_active_state fsmonitor_ipc__get_state(void)
>  {
> diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
> index b6a7067c3af..63277dea39e 100644
> --- a/fsmonitor-ipc.h
> +++ b/fsmonitor-ipc.h
> @@ -18,6 +18,12 @@ int fsmonitor_ipc__is_supported(void);
>   */
>  const char *fsmonitor_ipc__get_path(void);
>
> +/*
> + * Returns the pathname to the file that contains the pathname to the
> + * IPC named pipe or Unix domain socket.
> + */
> +const char *fsmonitor_ipc__get_pathfile(void);
> +
>  /*
>   * Try to determine whether there is a `git-fsmonitor--daemon` process
>   * listening on the IPC pipe/socket.

Thank you for working on this, also on the Windows side. It definitely
helps!

Ciao,
Dscho
