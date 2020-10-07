Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132CC4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D64320872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eFQuh7tT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgJGVnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:43:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:52955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgJGVnt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 17:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602107021;
        bh=BxOD7WRbO9/5+Q7aovGh94ce8/lr1IlsUVyrK7cLNeE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eFQuh7tTssEXB3RNu83Xsj+9t95S8DF6Uyi+KCqLvV0gGSdzDml3JJAc7YNITYeVT
         5UfAqHZ6dmVE0g7T7RE5T/+WOuwXLbyBw9HioWxDX4vU/YWkMMhKMWkkXL5UQSZCzn
         Kxe2dzPL7jY7QluhGgqKAIUMXH2v7fhe6lptUViY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUs7-1kbkYR0v3x-00xsUB; Wed, 07
 Oct 2020 23:43:26 +0200
Date:   Wed, 7 Oct 2020 23:43:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] help: do not expect built-in commands to be hardlinked
In-Reply-To: <xmqqpn5u2bps.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010072330090.50@tvgsbejvaqbjf.bet>
References: <pull.745.git.1602074589460.gitgitgadget@gmail.com> <xmqqpn5u2bps.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:P9qrh+EqchCXReVUik+EuZr9WFL2cXSm9K6McLbe6Sn0TwgFh2L
 nbqSOYydPgh9olPYsF2qJYUmFfsH8QsVm2MhjDmj7DS+LNZGbae5EqsDyOkVOeNhRr5B4qX
 OrcUZbYZWLOCbrruInvxlIuTuvx/5gVbSqVItcvbKb1kM3I2UeQ/CRILBqHIRcYtRMBERN+
 HlzejlB561PBEJ6Wec1WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IBOF0XjIjiA=:fx0hCTI8xA7SQyjzApX4Wx
 PU4USqDswf7iNHBmuG46j6G/rkcTEP9F+ZVCS2J6MKSHtFRn9encnnrBZLuywuCLH2/ihkxFC
 0xQ9vM1wCgoCZwmY6QfSFkUeoXHZS6rsDH51+100yON5vzED4OZcv+QqWbJ4Imn3jXXgGPf5w
 5anwv48W7H0oJn4W/uVYBXQR/8beKbljEP7PFBMYYRelTUtbiTRrGu/hmSzY/ayOElkQkI5LL
 uREF1eDmTykzkiNtQEJt3AvWio49ItVXW3BUBNfobjhvyu2HYVa0L6eaqqCc9eYzVzvJPrDsZ
 C9qtbaDrkRXK8Oy3d3tK6sJ9GdarquIn829Ij8RjfFZNqxnYSkkZ/ztC1FXgXojtmcjj0oppN
 imNbaBdwAym/a5yQD3jqC6BPfCd2m9g4RAKSUq984EbfMUp2JxRxiApwFUtXo2pJLG8FCLM6J
 nP7ct5g8rFw4E+DwaiN7zr24YjD53vwU+B547sPUeTOIUi82dON6hfqAC2KQQDVhZ/cJ7J/kt
 AAzPuBN/SxuU1tdXMuJ5BjdOCJBegxFeigKzhFJUotOsM09OuVNRhE5KQTsNG5JDylwoi6BeH
 +nGgj916PJ8tJF/cGdZ5NHBypVMWJ9jDB3QMVmAnKU/Mnek2uf7NIrGX0myLzPjHHg4iCBlYQ
 zSj1LbruuIdRIDPHi7y2izvLq/U3IIkuHVA/DW+SJ0dd0uMw6I1KHQqAUhxjupVzHZgqHXX9j
 EZ98cUQ8OMon2c39Xjh+kH2ubMJevI8PRr9r/O6KiTymmCcjcU9qKkJwEJfpyh0QBhfhZUbyA
 zitz7xvCA6dlPE2vVacAt38j5V4+P2I8OkB2UV1veH+2J3t/ze/3PGLxGnvkgh1yrSEmeFzN2
 nS13sZK+E96JmO1EwQipSx9nbwDyn1JC2UTz9Xfv+/8Q6zAhH31Au51hoqKHUjcHNAoqme/7B
 SfMMzYWEq+Gl78qQkisFxBqhdXnlYi6nghtP+qcvwZDL1KWDojC2SRbzQGMJFJhbIBBq3EQ6d
 wSqkRyW/6kfvxJ3sgr+bz5pjbppZX+Ibj3ZOSNZKEb0hsGve9l7HiQWUdrpqo6ZrrH7LvCpC0
 g5rU8t17ykSd2gew2O3T5hsYbR8cAL8Q1n5v69W34LNmVmHznn2mk7IZ7TJLx2ndujxTRw1Pq
 FHNMvm4TCdnXhJn1t7JUdTKPXiZzy8h2Z25GFl6JfgXn3rttConJZvhZcvs0u91QYvTxQ23l8
 semZoEIMc1uRRsl5xt4dLkx1LHvYX8XUBVmqz7koZVMyzYiXUDdkN/+d/8YGcjshxCAH+5yc8
 d/PjI/OMKfjiRJLaELVxWeUH1V5GXN+PfaOKUgmpawPI3I90DXttKFbP7rj9pW7loLkqU8CRE
 cmgpMXrx4LktFbucsI3PtgkvfHn9/Ems4Jqi+V2h73mumeuAcE8uI7FHj88JdYZLqeNG1+m7e
 suCGHTR2XnZwsi1V0PdXn/c15wKy3rpjdkOpGZsaaJvnyd45gBgo+M
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 7 Oct 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When building with SKIP_DASHED_BUILT_INS=3DYesPlease, the built-in
> > commands are no longer present in the `PATH` as hardlinks to `git`.
> >
> > As a consequence, `load_command_list()` needs to be taught to find the
> > names of the built-in commands from elsewhere.
> >
> > This only affected the output of `git --list-cmds=3Dmain`, but not the
> > output of `git help -a` because the latter includes the built-in
> > commands by virtue of them being listed in command-list.txt.
> >
> > The bug was detected via a patch series that turns the merge strategie=
s
> > included in Git into built-in commands: `git merge -s help` relies on
> > `load_command_list()` to determine the list of available merge
> > strategies.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     Fix the command list with SKIP_DASHED_BUILT_INS=3DYesPlease
> >
> >     In a recent patch series
> >     [https://lore.kernel.org/git/20201005122646.27994-12-alban.gruin@g=
mail.com/#r]
> >     , the merge strategies were converted into built-ins, which is goo=
d.
> >
> >     Together with the change where we stop hard-linking the built-in
> >     commands in CI builds, this broke t9902.199.
> >
> >     The actual root cause is that git merge -s help relies on
> >     load_command_list() to find all available Git commands, and that
> >     function had the long-standing bug that it expects the built-in co=
mmands
> >     to be available in the PATH.
> >
>
> That is not a bug in "merge -s help" or "longstanding" at all.  It
> has been a quite natural and long-standing expectation to find all
> the merge strategies on PATH (after GIT_EXEC_PATH is added to it),
> because that was the promise we gave to our users long time ago and
> have kept.

Sure, we promised to the outside world that those built-ins would always
be in the PATH, but we highly recommended against using dashed
invocations.

To me, that means that _internally_ we should have been more stringent
about how we do things ourselves.

In any case, your complaint isn't about the commit message, so I hope it
can advance?

> The bug is in load_command_list() and it was introduced by the
> recent SKIP_DASHED_BUILT_INS series.  We forgot to teach the
> function that in the new world order, what we see on disk plus what
> we have in the built-in table are the set of subcommands available
> to us, and the rule that was valid in the old world order can no
> longer be relied upon, and nobody noticed  the breakage while
> developing or reviewing.
>
> >  git.c  | 13 +++++++++++++
> >  help.c |  2 ++
> >  help.h |  1 +
> >  3 files changed, 16 insertions(+)
> >
> > diff --git a/git.c b/git.c
> > index d51fb5d2bf..a6224badce 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -641,6 +641,19 @@ static void list_builtins(struct string_list *out=
, unsigned int exclude_option)
> >  	}
> >  }
> >
> > +void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
> > +{
> > +	const char *name;
> > +	int i;
> > +
> > +	if (!skip_prefix(prefix, "git-", &prefix))
> > +		return;
>
> Do we want to explain that this is for dropping "gitk" and the like
> in a comment near here?

I guess I have to explain this, as it is too easy to mistake this
`skip_prefix()` to work on the actual command names rather than about the
`prefix` parameter.

The `commands[]` array in `git.c` stores only the command names, but
`load_command_list()` is called with the prefix `git-` or `git-merge-`.
Therefore, `load_builtin_commands()` skips the prefix `git-` *from the
`prefix` itself*.

I'll send the next iteration shortly.

Ciao,
Dscho

>
> > +	for (i =3D 0; i < ARRAY_SIZE(commands); i++)
> > +		if (skip_prefix(commands[i].cmd, prefix, &name))
> > +			add_cmdname(cmds, name, strlen(name));
> > +}
> > +
> >  #ifdef STRIP_EXTENSION
> >  static void strip_extension(const char **argv)
> >  {
> > diff --git a/help.c b/help.c
> > index 4e2468a44d..919cbb9206 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -263,6 +263,8 @@ void load_command_list(const char *prefix,
> >  	const char *env_path =3D getenv("PATH");
> >  	const char *exec_path =3D git_exec_path();
> >
> > +	load_builtin_commands(prefix, main_cmds);
> > +
> >  	if (exec_path) {
> >  		list_commands_in_dir(main_cmds, exec_path, prefix);
> >  		QSORT(main_cmds->names, main_cmds->cnt, cmdname_compare);
> > diff --git a/help.h b/help.h
> > index dc02458855..5871e93ba2 100644
> > --- a/help.h
> > +++ b/help.h
> > @@ -32,6 +32,7 @@ const char *help_unknown_cmd(const char *cmd);
> >  void load_command_list(const char *prefix,
> >  		       struct cmdnames *main_cmds,
> >  		       struct cmdnames *other_cmds);
> > +void load_builtin_commands(const char *prefix, struct cmdnames *cmds)=
;
> >  void add_cmdname(struct cmdnames *cmds, const char *name, int len);
> >  /* Here we require that excludes is a sorted list. */
> >  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
> >
> > base-commit: 8f7759d2c8c13716bfdb9ae602414fd987787e8d
>
