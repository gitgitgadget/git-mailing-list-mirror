Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC9C35240
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951342071E
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 10:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DDR7DiVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgAZKEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 05:04:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:44133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgAZKEY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 05:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580033054;
        bh=Fxpf5BgOoIx8+YxDXLHO87Io1Buo52vvaCbWzWw/PPU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DDR7DiVr4RiYC7U0juDM/wsIeykft7q+CQ/eWuR7bER8LP1ubZWRHeQNbHSaznams
         5jb1KBjKNtp650BfBk8VYoFVNjgc3qa9tDDExZdQrGN/iJMEvJKrZKcum+QHYUXBTg
         ktHpMdnL2bYVUmDZS9zrOh0PaNclOALUNiquzu2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1jTc9A1vF7-00akgU; Sun, 26
 Jan 2020 11:04:14 +0100
Date:   Sun, 26 Jan 2020 11:04:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/2] rebase -i: extend rebase.missingCommitsCheck
In-Reply-To: <20200125175436.29786-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001261043540.46@tvgsbejvaqbjf.bet>
References: <20200111173917.15690-1-alban.gruin@gmail.com> <20200125175436.29786-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TtZh6VxybtKn7l9g2G2A4bXfhN/5FdA/z2WucIkheBkc8y8dJEu
 I5nZ1z+00e/DEp9qJojzTWHxIWlLWCYttl7hveehwWCpBYNBBIePuJXK08LnzX+SP3MJdCp
 0aVYGbNZbIZXqbZlmxcT491jFfIA/kHZOvucKQIaOU7uZ/3g8yFGr2gXggWsGOagsJ/XgI5
 p2Mks+MdrY+oZ8e0RuFcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pf2yTcc2bWc=:lUd1NTcpj8we26t2cb3cmC
 jeaxaA6wuqsVkKoYnKebITJEhMb7Y6Mi5h3iI5KDfkdSVbR3gAtNs5+6H2ELSHsJw+EKYyPR6
 6AzXloRYYajK4P8pHJ2XfFLH92TWBsR7asMa6PFlMpSYcs+8l2yIrLHAehFYd0cE0sA4sGKKP
 3+y1wwNzOBzKqAuz93O6kHnybW7Mnk7TTn9WxJaxdlKY3JM5hQw655aIF5iAu3LAK88egkBO3
 4UAWbXyl500Rl17dGae8dQs0js1dJV9/6DKeZPix2S+GIBZsi2cLxK2NTG5rZabBay/XZpcPB
 g3Vc21iggsgOb16ZjqVGPcr84F9jF0MHtpypCZGTrkvC5Fe952+bW6I/1hzCO5Ab+spjplJET
 OABHRwnP7eSlTO7eGLdsv2NqhR3sqRPYk6KwHR73jac1vvU4JaOnvCAajUVeCcC4frdxPwPeZ
 RqZpGc2w8XT7FeECTDGI0boAkbqDJrh6ExcRNrPfnxof0CBtd1PLPLfpfAsNaGQGp34mC3cai
 JBnYvlJDpd71LiTHuEtWXQmpPSWvCgLSt76dJNSPx8JBDh0ieoFH11IqfDqKpxBDkKnO6z/Us
 tWZIu0auLN7RML3B1lMeIYJUwXNKxx9WXbnfUar338iA0YFGmdEadqPlCCdTmJcpmmwmAvy4u
 560M5ZywJvrVV1Zifl+cCDV5cR+xNBAQ57X57iWgRLg4W68K5dtx4Bdmg6cMDO4TyrNIcCSOj
 B5mVKZJgRijrZnp/apoAV1cU8aNh6t/HXyerFeQ9V3Z/wMhz7lihMcaBnyq8wKJztcxLKv8UR
 UX8qm6I0cJsbFsRDSpXLimsWqzAYfw2S1N30fCHFuzoqY91ZXB4FyZJ76lcqvpZq/O7n64OL8
 zWmZl9pYrT8qEIFdpxQP0FXnrAafXoytumqEn7pom+Gp8FtnwUftDFAqgdQOsRuMQyoZWU3zB
 SjcwPMeF2hXokPjc1wyIZRrFovklaugxpJzcForeFt6jGfl0Ag/3Ax9pYTkp8bhkfXJrbOoXP
 AolsW0A9wDGi8J4qPZxhlXD0Jqvi6+QbItRkZXWrmGm03pZe6ri2GE+iFBQP2PVcLuyspV/zZ
 6drhQ3VteBaS+EIogvNIbbNSozFYfoMiH/8JdVuYwNDA6AyNHC2O+pKNQxfNI+WQm4qNtODf3
 dS3uzGXU4QC3/ba02d058BnIB1t3n2pzAUkRAfMMLQywrA80KSbT3ueuNfrRb4ZHDe1OMS9Gl
 SLvEX3g/9Qpd2WT/E
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Sat, 25 Jan 2020, Alban Gruin wrote:

> Changes since v4:
>
>  - Added a test to check that no errors are raised when editing the todo
>    list after pausing the rebase; it was provided by Phillip Wood.
>
>  - Fixed the issue pointed out by this test by creating a backup of the
>    todo list even if the edited list is incorrect.  This step was moved
>    before the user edits the list, so the backup can be created with
>    copy_file() instead of todo_list_write_to_file().

Please note that I changed this to always use `todo_list_write_to_file()`
in `js/rebase-i-with-colliding-hash` (see e.g.
https://github.com/gitgitgadget/git/commit/26027625).

The reason is that the copy would be made with _abbreviated_ commit IDs.
And during the rebase, those abbreviated IDs could become non-unique.

I have to admit that I did not follow the evolution of your patch series
terribly closely, but from your description I gather that we want to be
careful to ensure that the `.backup` file is written with non-abbreviated
commit IDs always.

The way I read your patches, they will conflict with
`js/rebase-i-with-colliding-hash`, so maybe it would be a good idea to
base your patches on that branch?

Thanks,
Dscho

>
>  - In edit_todo_list(), `incorrect' is set to 0 by default.  This only
>    concerns the initial edit case; instead of opening and parsing the
>    backup, we use directly `old_todo' as a reference.
>
>  - Don't check if the "dropped" file flag exists at the initial edit.
>
> Alban Gruin (2):
>   sequencer: move check_todo_list_from_file() to rebase-interactive.c
>   rebase-interactive: warn if commit is dropped with `rebase
>     --edit-todo'
>
>  rebase-interactive.c          |  90 ++++++++++++++++++++++---
>  rebase-interactive.h          |   5 ++
>  sequencer.c                   |  51 ++++----------
>  sequencer.h                   |   2 +-
>  t/t3404-rebase-interactive.sh | 121 ++++++++++++++++++++++++++++++++++
>  5 files changed, 219 insertions(+), 50 deletions(-)
>
> Range-diff against v4:
> 1:  996045a300 =3D 1:  996045a300 sequencer: move check_todo_list_from_f=
ile() to rebase-interactive.c
> 2:  11b0e1e78c ! 2:  6dbaa8cbe6 rebase-interactive: warn if commit is dr=
opped with `rebase --edit-todo'
>     @@ Commit message
>          `edit_todo_list_advice' is removed from sequencer.c as it is no=
 longer
>          used there.
>
>     -    This changes when a backup of the todo list is made.  Until now=
, it
>     -    was saved only once, before the initial edit.  Now, it is also =
made if
>     -    after the user edited the list, if it has no errors or if no co=
mmits
>     -    were dropped and `rebase.missingCommitsCheck' is set.  Thus, th=
e
>     +    This changes when a backup of the todo list is made.  Until now=
, it was
>     +    saved only once, before the initial edit.  Now, it is also made=
 if the
>     +    original todo list has no errors or no dropped commits.  Thus, =
the
>          backup should be error-free.  Without this, sequencer_continue(=
)
>          (`rebase --continue') could only compare the current todo list =
against
>          the original, unedited list.  Before this change, this file was=
 only
>     @@ Commit message
>          no errors were found at the last edition, so any missing commit=
s here
>          have already been picked.
>
>     -    Four tests are added to t3404.  The tests for
>     +    Five tests are added to t3404.  The tests for
>          `rebase.missingCommitsCheck =3D warn' and `rebase.missingCommit=
sCheck =3D
>          error' have a similar structure.  First, we start a rebase with=
 an
>          incorrect command on the first line.  Then, we edit the todo li=
st,
>     @@ Commit message
>          has been dropped.  Then, the actual rebase takes place.  In the=
 third
>          test, it is also checked that `--continue' will refuse to resum=
e the
>          rebase if commits were dropped.  The fourth test checks that no=
 errors
>     -    are raised when resuming a rebase after resolving a conflict.
>     +    are raised when resuming a rebase after resolving a conflict, t=
he fifth
>     +    checks that no errors are raised when editing the todo list aft=
er
>     +    pausing the rebase.
>
>          Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>          I don't think the way I create `expect.3' files in "rebase --ed=
it-todo
>     @@ rebase-interactive.c: int edit_todo_list(struct repository *r, st=
ruct todo_list
>      +	const char *todo_file =3D rebase_path_todo(),
>      +		*todo_backup =3D rebase_path_todo_backup();
>       	unsigned initial =3D shortrevisions && shortonto;
>     -+	int incorrect =3D 1;
>     ++	int incorrect =3D 0;
>
>       	/* If the user is editing the todo list, we first try to parse
>       	 * it.  If there is an error, we do not return, because the user
>       	 * might want to fix it in the first place. */
>       	if (!initial)
>      -		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
>     -+		incorrect =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf,=
 todo_list);
>     -+
>     -+	incorrect |=3D file_exists(rebase_path_dropped());
>     ++		incorrect =3D todo_list_parse_insn_buffer(r, todo_list->buf.buf,=
 todo_list) |
>     ++			file_exists(rebase_path_dropped());
>
>       	if (todo_list_write_to_file(r, todo_list, todo_file, shortrevisio=
ns, shortonto,
>       				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_=
HELP))
>     @@ rebase-interactive.c: int edit_todo_list(struct repository *r, st=
ruct todo_list
>      -	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 06=
66))
>      -		return error(_("could not copy '%s' to '%s'."), todo_file,
>      -			     rebase_path_todo_backup());
>     -+	if (initial && copy_file(todo_backup, todo_file, 0666))
>     -+		return error(_("could not copy '%s' to '%s'."), todo_file, todo_=
backup);
>     ++	if (initial || !incorrect) {
>     ++		if (!initial)
>     ++			unlink(todo_backup);
>     ++
>     ++		if (copy_file(todo_backup, todo_file, 0666))
>     ++		    return error(_("could not copy '%s' to '%s'."), todo_file, t=
odo_backup);
>     ++	}
>
>       	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
>       		return -2;
>     @@ rebase-interactive.c: int edit_todo_list(struct repository *r, st=
ruct todo_list
>      +	} else if (todo_list_check(todo_list, new_todo)) {
>      +		write_file(rebase_path_dropped(), "");
>      +		return -4;
>     -+	} else {
>     -+		todo_list_write_to_file(r, todo_list, todo_backup, shortrevision=
s, shortonto,
>     -+					-1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HEL=
P);
>      +	}
>
>       	return 0;
>     @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i res=
pects rebase.mi
>      +	git add file1 &&
>      +	git rebase --continue
>      +'
>     ++
>     ++test_expect_success 'rebase.missingCommitsCheck =3D error when edi=
ting for a second time' '
>     ++	test_config rebase.missingCommitsCheck error &&
>     ++	(
>     ++		set_fake_editor &&
>     ++		FAKE_LINES=3D"1 break 2 3" git rebase -i A D &&
>     ++		cp .git/rebase-merge/git-rebase-todo todo &&
>     ++		test_must_fail env FAKE_LINES=3D2 git rebase --edit-todo &&
>     ++		GIT_SEQUENCE_EDITOR=3D"cp todo" git rebase --edit-todo &&
>     ++		git rebase --continue
>     ++	)
>     ++'
>      +
>       test_expect_success 'respects rebase.abbreviateCommands with fixup=
, squash and exec' '
>       	rebase_setup_and_clean abbrevcmd &&
> --
> 2.24.1
>
>
