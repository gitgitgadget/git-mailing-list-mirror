Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC63FC433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 14:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354790AbiELOWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 10:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345321AbiELOWT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 10:22:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39B3BA9BD
        for <git@vger.kernel.org>; Thu, 12 May 2022 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652365320;
        bh=9jn1xDkBhceOMeeUhGC4uNdfhUX6F7TsEH9bgtzFIkM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=htRS5nGc1mLp7ARqYZEX1FTIFjQKPpPspdLI0DeTvdzUMXS9B5hvYmWZyqLt2gClS
         uExaIIdYHTBKdCYNjv7Yn/RreSzr285ESYfwGDbo2J2Ugfmhak193ZyruqxvJ/MSiF
         eogHVhL0sVTxNreAuXqmnkI7CScJuICq4pJAJqvY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([213.196.213.50]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpru-1o9eYU1RYQ-00pMyb; Thu, 12
 May 2022 16:22:00 +0200
Date:   Thu, 12 May 2022 16:21:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 04/28] fsmonitor-settings: bare repos are incompatible
 with FSMonitor
In-Reply-To: <72b94acd5fe87eaa1dba9bfb66a7a738a0b46a91.1650662994.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205121620540.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <72b94acd5fe87eaa1dba9bfb66a7a738a0b46a91.1650662994.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DmpKfUVk/++cEmv5D9lMMTeD8wiVe8nbVeEfVMxVjGnHYhujS7Q
 lRwt3bTGOpLyCaz+IdaHmI8qBW+0gYqm5Yseh6baMoh1SXozMm8Yjkl2tbZgXD8gMMcquVB
 DW9DbwINPTUg8PEi3MtinczMNEd68498VVSIpLtbMdtJLLOQU9Hg9WvD7u8bdHVCxdZwGi9
 P1bWs+MmQ3ja+WSfPG60A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YZvsZuAdFdg=:qEDlaLPcjvesGRCvWmV5Wl
 z/2EpwJRhs3aBYFI8cVgVxNVV8V467zSI5DFxitEztL4sLzp2hh0UlNoxNPDJqRoBAqESfVa/
 xJZwIchy+dMlCeagcSNBjsvmOzh8cMdjzhaYufSWjL4piP6okRcaWYVrrvqdiQ+1QwcmSxbwS
 NGmc3K4DRx+cc+995dI41SIbutJaaVs/FHCshGGrPDo1r7qsh3jyoZvHdkNzqzFu1xkBOhoW9
 XPfis4AOt5dvBmx3QXq0s5FgUUWQqYwj+T1s71VZ2xb+ceybk8L4b12vkfpNdVLqSjKjCWCcA
 2N0Uycv8Ywm3Y8ldgmAvaVKyrgP3NMfnDCT35jZvoxPIc8ubVGZxiYBqHqTkDusA23qmbYCmH
 K7MHDn2dJGUdrufpmM2DMvN9E1BWDWDyZq5fPJl5zk3FvlrHjW/KjbpfL8ASnznTaYXzx2Aj+
 OTNznD2Jd1KNYFPRodlJcY3Kwsux8XQpMdcWeGP7vR37/Lg7sLwncSBLjlrJ+oiNekQ33RRvc
 ItSfu/ZHp0WLp+g8DwIHk2VCsozJuLR+Eq4ubLFXHuVutOEdptYkUQZx7sOjYgkR4qFM2oQQl
 E/V1NG67LqCSqSzltQd88OTfiwcz2gs/A7T/nzCKJ/HkHu2E0bSmo50iu6ojUHbRqOfbsNNbH
 ryL2DpQLH1km5JgWtoDe3cKhkLKfe8hUZ9DtSxNFK7+4Eoea6galgsKNciDpVs0TsfTlzlFoZ
 LtEQwGjVF1P2mTMpGotLYJfskx3lDPDY574BVaBmHs4u1r3HFbk/ub0NHTHmUMbLh3B5/Fe11
 tXrTOyCmWn4Al3lSmDKVbfwyuCkW6+KcaG7LZBjyRrmQCSp37tWHgC4s6Ijs9KxFFA4BR5nHb
 y2MF8IUoXSsCF1Kz1M2GCupFt9/OVq+wbSBlVLZmxdSQTj08mYpmE4JaevusmXChyk+X9Ew45
 YOuNBrUkDKhy8ZcG4dFA4RtVRI8/JyS5ZijtEYgKPbFKIYU9RpHGcOQ6CclQonEePGJV4BnLE
 zx2KHswRkPvQxD3C8Qhd6V7a8OXLhwL8XUvKWyt6mwuQrVyip5MahLV5+PTv8vWdmwDNno5zX
 oBYCnrURaXUgL4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Bare repos do not have a worktree, so there is nothing for the
> daemon watch.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/fsmonitor--daemon.c |  18 +++++
>  builtin/update-index.c      |  16 +++++
>  fsmonitor-settings.c        | 133 ++++++++++++++++++++++++++++++------
>  fsmonitor-settings.h        |  16 +++++
>  t/t7519-status-fsmonitor.sh |  23 +++++++
>  5 files changed, 186 insertions(+), 20 deletions(-)
>
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 46be55a4618..66b78a0353f 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -1423,6 +1423,7 @@ static int try_to_start_background_daemon(void)
>  int cmd_fsmonitor__daemon(int argc, const char **argv, const char *pref=
ix)
>  {
>  	const char *subcmd;
> +	enum fsmonitor_reason reason;
>  	int detach_console =3D 0;
>
>  	struct option options[] =3D {
> @@ -1449,6 +1450,23 @@ int cmd_fsmonitor__daemon(int argc, const char **=
argv, const char *prefix)
>  		die(_("invalid 'ipc-threads' value (%d)"),
>  		    fsmonitor__ipc_threads);
>
> +	prepare_repo_settings(the_repository);
> +	/*
> +	 * If the repo is fsmonitor-compatible, explicitly set IPC-mode
> +	 * (without bothering to load the `core.fsmonitor` config settings).
> +	 *
> +	 * If the repo is not compatible, the repo-settings will be set to
> +	 * incompatible rather than IPC, so we can use one of the __get
> +	 * routines to detect the discrepancy.
> +	 */
> +	fsm_settings__set_ipc(the_repository);
> +
> +	reason =3D fsm_settings__get_reason(the_repository);
> +	if (reason > FSMONITOR_REASON_OK)
> +		die("%s",
> +		    fsm_settings__get_incompatible_msg(the_repository,
> +						       reason));
> +
>  	if (!strcmp(subcmd, "start"))
>  		return !!try_to_start_background_daemon();
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 876112abb21..01ed4c4976b 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1237,6 +1237,22 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
>
>  	if (fsmonitor > 0) {
>  		enum fsmonitor_mode fsm_mode =3D fsm_settings__get_mode(r);
> +		enum fsmonitor_reason reason =3D fsm_settings__get_reason(r);
> +
> +		/*
> +		 * The user wants to turn on FSMonitor using the command
> +		 * line argument.  (We don't know (or care) whether that
> +		 * is the IPC or HOOK version.)
> +		 *
> +		 * Use one of the __get routines to force load the FSMonitor
> +		 * config settings into the repo-settings.  That will detect
> +		 * whether the file system is compatible so that we can stop
> +		 * here with a nice error message.
> +		 */
> +		if (reason > FSMONITOR_REASON_OK)
> +			die("%s",
> +			    fsm_settings__get_incompatible_msg(r, reason));
> +
>  		if (fsm_mode =3D=3D FSMONITOR_MODE_DISABLED) {
>  			warning(_("core.fsmonitor is unset; "
>  				"set it if you really want to "
> diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
> index 757d230d538..7d3177d441a 100644
> --- a/fsmonitor-settings.c
> +++ b/fsmonitor-settings.c
> @@ -9,23 +9,42 @@
>   */
>  struct fsmonitor_settings {
>  	enum fsmonitor_mode mode;
> +	enum fsmonitor_reason reason;
>  	char *hook_path;
>  };
>
> -static void lookup_fsmonitor_settings(struct repository *r)
> +static enum fsmonitor_reason check_for_incompatible(struct repository *=
r)
> +{
> +	if (!r->worktree) {
> +		/*
> +		 * Bare repositories don't have a working directory and
> +		 * therefore have nothing to watch.
> +		 */
> +		return FSMONITOR_REASON_BARE;
> +	}
> +
> +	return FSMONITOR_REASON_OK;
> +}
> +
> +static struct fsmonitor_settings *alloc_settings(void)
>  {
>  	struct fsmonitor_settings *s;
> +
> +	CALLOC_ARRAY(s, 1);
> +	s->mode =3D FSMONITOR_MODE_DISABLED;
> +	s->reason =3D FSMONITOR_REASON_UNTESTED;
> +
> +	return s;
> +}
> +
> +static void lookup_fsmonitor_settings(struct repository *r)
> +{
>  	const char *const_str;
>  	int bool_value;
>
>  	if (r->settings.fsmonitor)
>  		return;
>
> -	CALLOC_ARRAY(s, 1);
> -	s->mode =3D FSMONITOR_MODE_DISABLED;
> -
> -	r->settings.fsmonitor =3D s;
> -
>  	/*
>  	 * Overload the existing "core.fsmonitor" config setting (which
>  	 * has historically been either unset or a hook pathname) to
> @@ -38,6 +57,8 @@ static void lookup_fsmonitor_settings(struct repositor=
y *r)
>  	case 0: /* config value was set to <bool> */
>  		if (bool_value)
>  			fsm_settings__set_ipc(r);
> +		else
> +			fsm_settings__set_disabled(r);
>  		return;
>
>  	case 1: /* config value was unset */
> @@ -53,18 +74,18 @@ static void lookup_fsmonitor_settings(struct reposit=
ory *r)
>  		return;
>  	}
>
> -	if (!const_str || !*const_str)
> -		return;
> -
> -	fsm_settings__set_hook(r, const_str);
> +	if (const_str && *const_str)
> +		fsm_settings__set_hook(r, const_str);
> +	else
> +		fsm_settings__set_disabled(r);
>  }
>
>  enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
>  {
>  	if (!r)
>  		r =3D the_repository;
> -
> -	lookup_fsmonitor_settings(r);
> +	if (!r->settings.fsmonitor)
> +		lookup_fsmonitor_settings(r);
>
>  	return r->settings.fsmonitor->mode;
>  }
> @@ -73,31 +94,55 @@ const char *fsm_settings__get_hook_path(struct repos=
itory *r)
>  {
>  	if (!r)
>  		r =3D the_repository;
> -
> -	lookup_fsmonitor_settings(r);
> +	if (!r->settings.fsmonitor)
> +		lookup_fsmonitor_settings(r);
>
>  	return r->settings.fsmonitor->hook_path;
>  }
>
>  void fsm_settings__set_ipc(struct repository *r)
>  {
> +	enum fsmonitor_reason reason =3D check_for_incompatible(r);
> +
> +	if (reason !=3D FSMONITOR_REASON_OK) {
> +		fsm_settings__set_incompatible(r, reason);
> +		return;
> +	}
> +
> +	/*
> +	 * Caller requested IPC explicitly, so avoid (possibly
> +	 * recursive) config lookup.
> +	 */
>  	if (!r)
>  		r =3D the_repository;
> -
> -	lookup_fsmonitor_settings(r);
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor =3D alloc_settings();
>
>  	r->settings.fsmonitor->mode =3D FSMONITOR_MODE_IPC;
> +	r->settings.fsmonitor->reason =3D reason;
>  	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
>  }
>
>  void fsm_settings__set_hook(struct repository *r, const char *path)
>  {
> +	enum fsmonitor_reason reason =3D check_for_incompatible(r);
> +
> +	if (reason !=3D FSMONITOR_REASON_OK) {
> +		fsm_settings__set_incompatible(r, reason);
> +		return;
> +	}
> +
> +	/*
> +	 * Caller requested hook explicitly, so avoid (possibly
> +	 * recursive) config lookup.
> +	 */
>  	if (!r)
>  		r =3D the_repository;
> -
> -	lookup_fsmonitor_settings(r);
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor =3D alloc_settings();
>
>  	r->settings.fsmonitor->mode =3D FSMONITOR_MODE_HOOK;
> +	r->settings.fsmonitor->reason =3D reason;
>  	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
>  	r->settings.fsmonitor->hook_path =3D strdup(path);
>  }
> @@ -106,9 +151,57 @@ void fsm_settings__set_disabled(struct repository *=
r)
>  {
>  	if (!r)
>  		r =3D the_repository;
> -
> -	lookup_fsmonitor_settings(r);
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor =3D alloc_settings();
>
>  	r->settings.fsmonitor->mode =3D FSMONITOR_MODE_DISABLED;
> +	r->settings.fsmonitor->reason =3D FSMONITOR_REASON_OK;
> +	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
> +}
> +
> +void fsm_settings__set_incompatible(struct repository *r,
> +				    enum fsmonitor_reason reason)
> +{
> +	if (!r)
> +		r =3D the_repository;
> +	if (!r->settings.fsmonitor)
> +		r->settings.fsmonitor =3D alloc_settings();
> +
> +	r->settings.fsmonitor->mode =3D FSMONITOR_MODE_INCOMPATIBLE;
> +	r->settings.fsmonitor->reason =3D reason;
>  	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
>  }
> +
> +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
> +{
> +	if (!r)
> +		r =3D the_repository;
> +	if (!r->settings.fsmonitor)
> +		lookup_fsmonitor_settings(r);
> +
> +	return r->settings.fsmonitor->reason;
> +}
> +
> +char *fsm_settings__get_incompatible_msg(const struct repository *r,
> +					 enum fsmonitor_reason reason)
> +{
> +	struct strbuf msg =3D STRBUF_INIT;
> +
> +	switch (reason) {
> +	case FSMONITOR_REASON_UNTESTED:
> +	case FSMONITOR_REASON_OK:
> +		goto done;
> +
> +	case FSMONITOR_REASON_BARE:
> +		strbuf_addf(&msg,
> +			    _("bare repository '%s' is incompatible with fsmonitor"),
> +			    xgetcwd());
> +		goto done;
> +	}
> +
> +	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
> +	    reason);
> +
> +done:
> +	return strbuf_detach(&msg, NULL);
> +}
> diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
> index a4c5d7b4889..4c7592896e4 100644
> --- a/fsmonitor-settings.h
> +++ b/fsmonitor-settings.h
> @@ -4,18 +4,34 @@
>  struct repository;
>
>  enum fsmonitor_mode {
> +	FSMONITOR_MODE_INCOMPATIBLE =3D -1, /* see _reason */
>  	FSMONITOR_MODE_DISABLED =3D 0,
>  	FSMONITOR_MODE_HOOK =3D 1, /* core.fsmonitor=3D<hook_path> */
>  	FSMONITOR_MODE_IPC =3D 2,  /* core.fsmonitor=3D<true> */
>  };
>
> +/*
> + * Incompatibility reasons.
> + */
> +enum fsmonitor_reason {
> +	FSMONITOR_REASON_UNTESTED =3D 0,
> +	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */

s/disbled/disabled/

I usually try to avoid pointing out speling erors, but I kind of wanted to
show that I really studied this patch series for a couple hours.

The patch looks good to me,
Dscho

> +	FSMONITOR_REASON_BARE,
> +};
> +
>  void fsm_settings__set_ipc(struct repository *r);
>  void fsm_settings__set_hook(struct repository *r, const char *path);
>  void fsm_settings__set_disabled(struct repository *r);
> +void fsm_settings__set_incompatible(struct repository *r,
> +				    enum fsmonitor_reason reason);
>
>  enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
>  const char *fsm_settings__get_hook_path(struct repository *r);
>
> +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
> +char *fsm_settings__get_incompatible_msg(const struct repository *r,
> +					 enum fsmonitor_reason reason);
> +
>  struct fsmonitor_settings;
>
>  #endif /* FSMONITOR_SETTINGS_H */
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index a6308acf006..9a8e21c5608 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -55,6 +55,29 @@ test_lazy_prereq UNTRACKED_CACHE '
>  	test $ret -ne 1
>  '
>
> +# Test that we detect and disallow repos that are incompatible with FSM=
onitor.
> +test_expect_success 'incompatible bare repo' '
> +	test_when_finished "rm -rf ./bare-clone actual expect" &&
> +	git init --bare bare-clone &&
> +
> +	test_must_fail \
> +		git -C ./bare-clone -c core.fsmonitor=3Dfoo \
> +			update-index --fsmonitor 2>actual &&
> +	grep "bare repository .* is incompatible with fsmonitor" actual &&
> +
> +	test_must_fail \
> +		git -C ./bare-clone -c core.fsmonitor=3Dtrue \
> +			update-index --fsmonitor 2>actual &&
> +	grep "bare repository .* is incompatible with fsmonitor" actual
> +'
> +
> +test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo=
' '
> +	test_when_finished "rm -rf ./bare-clone actual" &&
> +	git init --bare bare-clone &&
> +	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
> +	grep "bare repository .* is incompatible with fsmonitor" actual
> +'
> +
>  test_expect_success 'setup' '
>  	mkdir -p .git/hooks &&
>  	: >tracked &&
> --
> gitgitgadget
>
>
