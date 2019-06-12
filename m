Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9991F462
	for <e@80x24.org>; Wed, 12 Jun 2019 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfFLTOw (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 15:14:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:41999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfFLTOw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 15:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560366883;
        bh=EFHlnBSCbWqucnADzvpKcICMm1OHj4p3N6M8/85KVsI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fe6sZz5X6Ad8ENCbcFtmXIAM8wuNyxtENIhX14b688HQHeUKL5nOSShSWlZJgwErj
         apba2Xm9tEemi5TJ+UKnCMUfFNb6E4SED124LH+MbkjXNgi2pzbDiTaG89PMIaxwui
         BJRoe5H4Dx4bDH4w2aOxSpDey19Vq/yNYn7h6VRc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1hjyOR288W-008rm1; Wed, 12
 Jun 2019 21:14:43 +0200
Date:   Wed, 12 Jun 2019 21:14:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
In-Reply-To: <20190611211151.GG4012@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <20190430142556.20921-1-szeder.dev@gmail.com> <20190611130320.18499-1-szeder.dev@gmail.com> <20190611130320.18499-4-szeder.dev@gmail.com> <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com> <20190611211151.GG4012@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-246659270-1560366884=:789"
X-Provags-ID: V03:K1:jzd2dofCdnoHVkcMdhKT30DCjO3gyYU7kUfiky6ZArTvWe560ms
 tWJoLqJ3W99V8Aw3e0ddWJFNMOGmDW0eRTv2sxI1gdTWAnk+plj2wdZ03cwcVBUGw1SgtVh
 OdvmOe1kdmjV1vYOBHO23ABBCA/jzI0a/f7Bf/onRu/f9VZZJHQ2K94bZj8R5vKV3VdwauW
 43toj5OLjPlP+7tkjn2Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tgib3KkYNGc=:gMKsdBRlZvTieuJtXFIbK5
 crMAl9U9XlzHKow6oZ5E05139zd650dlev5bB4j9qMKK6JXzOXIsXWlZqmJVwqd3wiY7GE60c
 K0c+e3Al/+WF5Ks5P3NTeOov4ZYoFjMxNWdbU9OFixoSSl2E500m4u8FaIUyQ6nAm0pBDkly5
 jegIamyPy1FxFFWMwFCcuMDKKsS9yjuqFkcCO+1dGFk5w7ZP1/L59MjX9HYbUvcHmZoxq928S
 sVgAgbLK52zA7lPfQoydj7vQUyz8HLCtDiW0I7UKB34QsQQzSKy6JrL91zMzLFg7swtjJGkXf
 mJ40RuUecVF02CuDtHkYBpQ8EfFFg000nHPkvTe9K2mnTUSC9i3eE4psANKaW5WmuVmhTd5ln
 RAlaaAOZXWZs9PwFN0JNKfPMjQk+7ZE0YqwRcgz55CIxf8b4kDXlMfMo4LoRm8zxHR7Z7ShIC
 3MAV9ih4BHAQSEcWfeCmaaVGkYIPAvS+VIXP+tUOZlOLxoMUm5SYk1ewH60bFQ7Kw9rQq45BI
 21+up7Vcx3Ik3kvw0hF5stBC8uyjaLdCjD8QBNjWdmjRr+NOO459Y6Uw56P+CmcU/LNFi8VfM
 DQzSOI0xJ3xA+44oBhapzfLfYxvciCV865hqD/3+UzSU0QeVV9szpRN/wq6znrNsQXVZaghVW
 4Mvr0gd1c7B1SRVdIOlC2g8JBRfYr3DWp8BBuGnStVwN94dGu9rch+KioRARZaSLtGlhkl1qj
 N8s04AghlV1d5Xr+2eZgygQDh9K635Q8pTjqasfVF90lgLwGkZRYKYtba92lTU0GzSAaofP/0
 h8L9Wep7uDhbKxhNl1i4x0zpOB5ZYIsCAGbnR16ezYf6Ui//foogFhpGmMA7W81eh7IId6tvq
 t2DGxSxmF5Afoq05fQVxtyL/IuDNbwdpt6IOl7Q23iycgcPpLcu6yKQ3kCCLsnvKI/2k1pJQr
 KoLcs1esdWhAxMVP4J35qOAeGx2EN87721Crd009gEpH6D84kylhRtOhXvnrNfLSD2gJ3cX7X
 sR2rc0KyDl0vewF+PI4Jfgg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-246659270-1560366884=:789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 11 Jun 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Jun 11, 2019 at 01:36:16PM -0700, Junio C Hamano wrote:
> > SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> >
> > > -Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccess=
fully rebased and updated refs/heads/missing-commit.
> > > +Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ      =
                                                                          =
QSuccessfully rebased and updated refs/heads/missing-commit.
> > >  EOF
> >
> > Yuck,
>
> Oh yeah...
>
> >... but I do not see how else/better this test can be written
> > myself, which makes it a double-yuck X-<
>
> Perhaps hiding those spaces behind a helper variable e.g.
> 'dump_term_clear_line=3DQ<80-spaces>Q' and embedding that in the here
> docs specifying the expected output in these three tests could make it
> ever so slightly less yuck...
>
> > Are we forcing out test to operate under dumb terminal mode and with
> > a known number of columns?
>
> 'test-lib.sh' sets TERM=3Ddumb relatively early on, and in these tests
> we don't use 'test_terminal' to run 'git rebase', so...  yeah.  And
> term_columns() defaults to 80.
>
> However, if the terminal were smart, then we would have to deal with
> ANSI escape suddenly popping up...

And I fear that is *exactly* what makes
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D10539&view=
=3Dms.vss-test-web.build-test-results-tab
fail...

You cannot easily see it in that output (probably because of incorrectly
encoded Escape sequences in the `.xml` output), so I'll paste what I see
here, locally, when running `t3404-*.sh -i -V -x`:

=2D- snip --
[...]
ok 99 - rebase -i respects rebase.missingCommitsCheck =3D ignore

expecting success:
        test_config rebase.missingCommitsCheck warn &&
        rebase_setup_and_clean missing-commit &&
        set_fake_editor &&
        FAKE_LINES=3D"1 2 3 4" \
                git rebase -i --root 2>actual &&
        test_i18ncmp expect actual &&
        test D =3D $(git cat-file commit HEAD | sed -ne \$p)

++ test_config rebase.missingCommitsCheck warn
++ config_dir=3D
++ test rebase.missingCommitsCheck =3D -C
++ test_when_finished 'test_unconfig  '\''rebase.missingCommitsCheck'\'''
++ test 0 =3D 0
++ test_cleanup=3D'{ test_unconfig  '\''rebase.missingCommitsCheck'\''
                } && (exit "$eval_ret"); eval_ret=3D$?; :'
++ git config rebase.missingCommitsCheck warn
++ rebase_setup_and_clean missing-commit
++ test_when_finished '
                git checkout master &&
                test_might_fail git branch -D missing-commit &&
                test_might_fail git rebase --abort
        '
++ test 0 =3D 0
++ test_cleanup=3D'{
                git checkout master &&
                test_might_fail git branch -D missing-commit &&
                test_might_fail git rebase --abort

                } && (exit "$eval_ret"); eval_ret=3D$?; { test_unconfig  '=
\''rebase.missingCommitsCheck'\''
                } && (exit "$eval_ret"); eval_ret=3D$?; :'
++ git checkout -b missing-commit master
Switched to a new branch 'missing-commit'
++ set_fake_editor
++ write_script fake-editor.sh
++ echo '#!/bin/sh'
++ cat
++ chmod +x fake-editor.sh
+++ pwd
+++ builtin pwd -W
++ test_set_editor 'C:/git-sdk-64/usr/src/git/.git/worktrees/wip/temp-reba=
se-123/t/trash directory.t3404-rebase-interactive/fake-editor.sh'
++ FAKE_EDITOR=3D'C:/git-sdk-64/usr/src/git/.git/worktrees/wip/temp-rebase=
-123/t/trash directory.t3404-rebase-interactive/fake-editor.sh'
++ export FAKE_EDITOR
++ EDITOR=3D'"$FAKE_EDITOR"'
++ export EDITOR
++ FAKE_LINES=3D'1 2 3 4'
++ git rebase -i --root
rebase -i script before editing:
pick 6e62bf890e21 A
pick 313fe965c048 B
pick d0f65f2f81ee C
pick 0547e3f1350d D
pick 8f99a4f1fbbd E

rebase -i script after editing:
pick 6e62bf890e21 A
pick 313fe965c048 B
pick d0f65f2f81ee C
pick 0547e3f1350d D
++ test_i18ncmp expect actual
++ test_have_prereq C_LOCALE_OUTPUT
++ save_IFS=3D'
'
++ IFS=3D,
++ set -- C_LOCALE_OUTPUT
++ IFS=3D'
'
++ total_prereq=3D0
++ ok_prereq=3D0
++ missing_prereq=3D
++ for prerequisite in "$@"
++ case "$prerequisite" in
++ negative_prereq=3D
++ case " $lazily_tested_prereq " in
++ case " $lazily_testable_prereq " in
++ total_prereq=3D1
++ case "$satisfied_prereq" in
++ satisfied_this_prereq=3Dt
++ case "$satisfied_this_prereq,$negative_prereq" in
++ ok_prereq=3D1
++ test 1 =3D 1
++ test_cmp expect actual
++ GIT_ALLOC_LIMIT=3D0
++ test-tool cmp expect actual
diff --git a/expect b/actual
index 05fcfcb..9555e34 100644
=2D-- a/expect
+++ b/actual
@@ -6,4 +6,4 @@ To avoid this message, use "drop" to explicitly remove a c=
ommit.
 Use 'git config rebase.missingCommitsCheck' to change the level of warnin=
gs.
 The possible behaviours are: ignore, warn, error.

-Rebasing (1/4)^MRebasing (2/4)^MRebasing (3/4)^MRebasing (4/4)^M         =
                                                                       ^MS=
uccessfully rebased and updated refs/heads/missing-commit.
+Rebasing (1/4)^MRebasing (2/4)^MRebasing (3/4)^MRebasing (4/4)^MESC[KSucc=
essfully rebased and updated refs/heads/missing-commit.
error: last command exited with $?=3D1
not ok 100 - rebase -i respects rebase.missingCommitsCheck =3D warn
#
#               test_config rebase.missingCommitsCheck warn &&
#               rebase_setup_and_clean missing-commit &&
#               set_fake_editor &&
#               FAKE_LINES=3D"1 2 3 4" \
#                       git rebase -i --root 2>actual &&
#               test_i18ncmp expect actual &&
#               test D =3D $(git cat-file commit HEAD | sed -ne \$p)
#
=2D- snap --

(I copy-pasted this from the output of `less` so that the control sequence=
s can be seen.)

To be utterly honest, I really fail to see a reason why a test case that
purports to verify that `git rebase -i` respects
`rebase.missingCommitsCheck=3Dwarn` should fail when the progress is shown=
 in an
unexpected format.

It strikes me as yet another poorly written test case that fails to catch =
the
intended regressions, instead it catches a bug *in the test case itself* w=
hen
legitimate changes are made to the progress code.

Nothing in a test suite is worse than a test that fails (or succeeds) for =
the
wrong reasons.

To make things even worse, the code that generates that `expect` file is
outside the test case.

Here it is, in its full "glory":

=2D- snip --
q_to_cr >expect <<EOF
Warning: some commits may have been dropped accidentally.
Dropped commits (newer to older):
 - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
To avoid this message, use "drop" to explicitly remove a commit.

Use 'git config rebase.missingCommitsCheck' to change the level of warning=
s.
The possible behaviours are: ignore, warn, error.

Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ             =
                                                                   QSucces=
sfully rebased and updated refs/heads/missing-commit.
EOF
=2D- snap --

May I please *strongly* suggest to fix this first? It should

- completely lose that last line,
- be inserted into the test case itself so that e.g. disk full problems ar=
e
  caught and logged properly, and
- the `test_i18ncmp expect actual` call in the test case should be replace=
d
  by something like:

	sed "\$d" <actual >actual-skip-progress &&
	test_i18ncmp expect actual-skip-progress

This should obviously be made as a separate, introductory patch (probably =
with
a less scathing commit message than my comments above would suggest).

And that would also remove the double-yuck.

Ciao,
Dscho

--8323329-246659270-1560366884=:789--
