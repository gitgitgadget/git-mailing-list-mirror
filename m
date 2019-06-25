Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D911F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfFYL4e (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:56:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:36271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfFYL4e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561463787;
        bh=jvFgrUblKKQ56SzU46Qu4VyOi8bZ2buQu7c98zJHpeE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CyDPEqRUvY8LxqUEFEKXQT1r0Cv30EW7HaFhmLheT4H/SDFdpdyxsX2+Ez5jMqmjm
         UhyA5I1uRZ6GHhyRAxrfYwmFZaTFKMuH0Qhkgm88NBZ/nhemXSqqYEknqwZTXD3Lm3
         oOKO/U1TVa7nfFnGfUSzuoVRBv7Co86SEpOU/uQw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPV69-1hbdKV3KFt-004hM7; Tue, 25
 Jun 2019 13:56:26 +0200
Date:   Tue, 25 Jun 2019 13:56:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] status: do not report errors in sequencer/todo
In-Reply-To: <af4b823caac84899b5ac71da61af5ec00f88bb2f.1561457483.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251356110.44@tvgsbejvaqbjf.bet>
References: <pull.275.git.gitgitgadget@gmail.com> <af4b823caac84899b5ac71da61af5ec00f88bb2f.1561457483.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:44YzrqhUCq3gej3Y6hG9IUzsQZKiqv0rlG1dumFJ5hs5+aqS6tI
 iubulGHce2iw9G8W1PHy9D3mGr7xYcWZ3tL7zllBGnjtdqb6JA0g8a/fObVoJODqbbgRUYB
 Y8+krZQuy8HD5lTIQcgOEL4UfgW8RkJGba0GAEuvhChbitoFqqJlZfTk8eEAk9sFuTivDs3
 QzkgGBA3SHGkL3LpaYfkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zrZmvGVtCl8=:SByBuu2RzeK/yRLeciz3G0
 z4hr8aVPEbH2H6os7TQQ4WPiujENgo+BgmagD4zX+q48UGb5nd3dx0vMkTMnCDPH05f7Xriu9
 aoFco6U8dw2RPFsS01tTsZa5Fv1Z4sXqYKLpmqJ8d2nuWWlYWzXp7PFTkqF8UgyZP2H50H4RJ
 9yWXALHamXUnZ0GoQNQALDyJHx7LuHFUU23oXmAiN1KuZwfnlvGIPEDxjIn2gX95xH7jekIjQ
 YKsF5JkJmgTmYco8nyvHVK7C/7Z15ITNMySaXW6zL1QLlUMHqkBGbgiNL/B1m0AeD7mPaKvNM
 eN6DOKhylLyKxZ/oo5UWmJ9n1nWO2ohmRPXif3grt2ID7SHeh47Lm0mw27AL0eiZ0niKV6qxo
 WxEaOTWbOz0AoEqZ8HANTUjN2wHQywB4Gw0pY8zfdNKF61hhkEncB26kl8lcPDfNgFgC0ypKe
 jQg7MmxHrHVHyMGItCDJEV0DLxp/CzCRgXfp38xvBPmeNc8w8zE/3EXG3Y5k1ZKp4FKrSNfUh
 +xXWSBDnME/kZZqxg/mP+Sv8sqy2fMTaVA+djMYM9RLIhWGuWptek9vaj/H3IBiNkaMWInrpK
 bbzR9Q7jiYLf7RLRJZqlz7VAT6lGzgm5DyXR3YHCRYoBBX6JGerj3GRZbKvYVnwmEIzdehhbM
 2JHGSADHDlR71qvJsaOvIJD04PiJUPDwlYrZgIks4EgSspczw2/jhqzqH7eAg2RdSxd/Q/cfk
 ooNV1IC/KLZZKjA5omd0nCOPrIjeoChu2lFNZR4UkeuVp+KzTlsE/Sn0eR3Y9Mx5pZEioxdJ7
 hAS51sOLXzVsKT1g6Q5MB0YI9bL8uobxJrZpcy45JDh/K0M4P9qADRnHjfwvN/sOj5zDAN6/9
 RsT5htHGiGKY3bV6Jnslq4NrlPGd99vVrNKxOyDxtrhVIxYqD/GWADmAXmf32lzxq24+vqvV0
 0obSYS9Yd5HW2pXz4mbikM14reUojMlqxtjO3gfQ6bSt8sjV8ohoCyoThDORqyr7u+usPT8DC
 y3NOSO/3P5ctc93ktw+b+jzS2SI/fSyFbBP1YNzmMnhEHzYinZzuQqfaVu3USvPs++DbEUBjz
 H+x/Xio8yI/igpO7zDWywvcFQ1J1s/Mh+VT
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 25 Jun 2019, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> commit 4a72486de9 ("fix cherry-pick/revert status after commit",
> 2019-04-16) used parse_insn_line() to parse the first line of the todo
> list to check if it was a pick or revert. However if the todo list is
> left over from an old cherry-pick or revert and references a commit that
> no longer exists then parse_insn_line() prints an error message which is
> confusing for users [1]. Instead parse just the command name so that the
> user is alerted to the presence of stale sequencer state by status
> reporting that a cherry-pick or revert is in progress.
>
> Note that we should not be leaving stale sequencer state lying around
> (or at least not as often) after commit b07d9bfd17 ("commit/reset: try
> to clean up sequencer state", 2019-04-16). However the user may still
> have stale state that predates that commit.
>
> Also avoid printing an error message if for some reason the user has a
> file called `sequencer` in $GIT_DIR.
>
> [1] https://public-inbox.org/git/3bc58c33-4268-4e7c-bf1a-fe349b3cb037@ww=
w.fastmail.com/

Very nice, I particularly like the simplicity of the code in `sequencer.c`
after this patch.

The entire patch series looks good to me.

Thanks,
Dscho

>
> Reported-by: Espen Antonsen <espen@inspired.no>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c            | 24 ++++++++----------------
>  t/t7512-status-help.sh | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 793f86bf9a..f8eab1697e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2177,34 +2177,26 @@ static int parse_insn_line(struct repository *r,=
 struct todo_item *item,
>
>  int sequencer_get_last_command(struct repository *r, enum replay_action=
 *action)
>  {
> -	struct todo_item item;
> -	char *eol;
> -	const char *todo_file;
> +	const char *todo_file, *bol;
>  	struct strbuf buf =3D STRBUF_INIT;
> -	int ret =3D -1;
> +	int ret =3D 0;
>
>  	todo_file =3D git_path_todo_file();
>  	if (strbuf_read_file(&buf, todo_file, 0) < 0) {
> -		if (errno =3D=3D ENOENT)
> +		if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
>  			return -1;
>  		else
>  			return error_errno("unable to open '%s'", todo_file);
>  	}
> -	eol =3D strchrnul(buf.buf, '\n');
> -	if (buf.buf !=3D eol && eol[-1] =3D=3D '\r')
> -		eol--; /* strip Carriage Return */
> -	if (parse_insn_line(r, &item, buf.buf, buf.buf, eol))
> -		goto fail;
> -	if (item.command =3D=3D TODO_PICK)
> +	bol =3D buf.buf + strspn(buf.buf, " \t\r\n");
> +	if (is_command(TODO_PICK, &bol) && (*bol =3D=3D ' ' || *bol =3D=3D '\t=
'))
>  		*action =3D REPLAY_PICK;
> -	else if (item.command =3D=3D TODO_REVERT)
> +	else if (is_command(TODO_REVERT, &bol) &&
> +		 (*bol =3D=3D ' ' || *bol =3D=3D '\t'))
>  		*action =3D REPLAY_REVERT;
>  	else
> -		goto fail;
> -
> -	ret =3D 0;
> +		ret =3D -1;
>
> - fail:
>  	strbuf_release(&buf);
>
>  	return ret;
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index c1eb72555d..3c9308709a 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -798,6 +798,22 @@ EOF
>  	test_i18ncmp expected actual
>  '
>
> +test_expect_success 'status shows cherry-pick with invalid oid' '
> +	mkdir .git/sequencer &&
> +	test_write_lines "pick invalid-oid" >.git/sequencer/todo &&
> +	git status --untracked-files=3Dno >actual 2>err &&
> +	git cherry-pick --quit &&
> +	test_must_be_empty err &&
> +	test_i18ncmp expected actual
> +'
> +
> +test_expect_success 'status does not show error if .git/sequencer is a =
file' '
> +	test_when_finished "rm .git/sequencer" &&
> +	test_write_lines hello >.git/sequencer &&
> +	git status --untracked-files=3Dno 2>err &&
> +	test_must_be_empty err
> +'
> +
>  test_expect_success 'status showing detached at and from a tag' '
>  	test_commit atag tagging &&
>  	git checkout atag &&
> --
> gitgitgadget
>
