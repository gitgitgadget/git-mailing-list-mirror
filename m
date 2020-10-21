Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC83C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C778224178
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="aZCWzU3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506393AbgJUVnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:43:14 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:44242 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506390AbgJUVnO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 17:43:14 -0400
Date:   Wed, 21 Oct 2020 21:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603316586;
        bh=zJ8qLw3jtj8itRlsgSAYNpo+ug6Ve2r3Js7i2KP0hoU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aZCWzU3TyetJap6XJwpMqetW4XtGSqV3KcqaAFLN228f/Kzxxy2xziHXhN1RilNBF
         vAkV6hSmriPfAGTLc7yFIe987MJ8BfRmik4ijY+KtwXHVgQwkKBSn2simcez3cp8oS
         oSWZ8+SXXSYCbb3lKsNLu43HwEt9XfkRrXbqo/PY=
To:     Junio C Hamano <gitster@pobox.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test script
Message-ID: <CEI_CVj6T-VEnw0cl0U6E5BSJ3Z6ZdYXAwnV96r8u0qbLK3EgS3b0Sqan1D_AgNqPm22FGPSL_easRZyLukEAIbbVCvxsiC9QVawVJBiTbI=@protonmail.com>
In-Reply-To: <xmqq4kmn8lpp.fsf@gitster.c.googlers.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com> <fc5fecec-1a77-871d-d1f9-dad1bae8920c@gmail.com> <xmqq4kmn8lpp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip, Junio,

Thank you for your reviews and support, they're much appreciated and I'm ha=
ppy the patch looks ok.

> I'll probably have to hand-edit the authorship before applying
> (check the From: of the e-mail) so that the identity on the
> signed-off-by trailer matches the author, but other than that the
> patch looks quite good to me, too.

My big apologies Junio, I mistook "authorship" to mean my `git config --glo=
bal user.name` and `git config --global user.email` settings.

Should I resend the patch email?

Thank you all,
Joey


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, October 21, 2020 12:42 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:

> Phillip Wood phillip.wood123@gmail.com writes:
>
> > Hi Joey
> > On 20/10/2020 20:53, Joey S wrote:
> >
> > > Modernize the test by replacing `test -e` instances with
> > > `test_path_is_file` helper functions, and `! test -e` with
> > > `test_path_is_missing`, for better readability and diagnostic message=
s.
> >
> > This is a good summary of the changes and importantly explains why
> > we're making the changes
> >
> > > Signed-off-by: Joey Salazar jgsal@protonmail.com
> >
> > The patch looks fine to me now
> > Thanks
> > Phillip
>
> I'll probably have to hand-edit the authorship before applying
> (check the From: of the e-mail) so that the identity on the
> signed-off-by trailer matches the author, but other than that the
> patch looks quite good to me, too.
>
> Thanks, both.
>
> > > t/t7006-pager.sh | 84 ++++++++++++++++++++++++-----------------------=
-
> > > 1 file changed, 42 insertions(+), 42 deletions(-)
> > > diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> > > index 00e09a375c..fdb450e446 100755
> > > --- a/t/t7006-pager.sh
> > > +++ b/t/t7006-pager.sh
> > > @@ -19,7 +19,7 @@ test_expect_success 'setup' '
> > > test_expect_success TTY 'some commands use a pager' '
> > > rm -f paginated.out &&
> > > test_terminal git log &&
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >     test_expect_failure TTY 'pager runs from subdir' '
> > >     @@ -65,49 +65,49 @@ test_expect_success !MINGW,TTY 'LESS and LV e=
nvvars set by git-sh-setup' '
> > >     test_expect_success TTY 'some commands do not use a pager' '
> > >     rm -f paginated.out &&
> > >     test_terminal git rev-list HEAD &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success 'no pager when stdout is a pipe' '
> > >     rm -f paginated.out &&
> > >     git log | cat &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success 'no pager when stdout is a regular file' '
> > >     rm -f paginated.out &&
> > >     git log >file &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git --paginate rev-list uses a pager' '
> > >     rm -f paginated.out &&
> > >     test_terminal git --paginate rev-list HEAD &&
> > >
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >     test_expect_success 'no pager even with --paginate when stdout is
> > >     a pipe' '
> > >     rm -f file paginated.out &&
> > >     git --paginate log | cat &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'no pager with --no-pager' '
> > >     rm -f paginated.out &&
> > >     test_terminal git --no-pager log &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'configuration can disable pager' '
> > >     rm -f paginated.out &&
> > >     test_unconfig pager.grep &&
> > >     test_terminal git grep initial &&
> > >
> > >
> > > -   test -e paginated.out &&
> > >
> > > -   test_path_is_file paginated.out &&
> > >     rm -f paginated.out &&
> > >     test_config pager.grep false &&
> > >     test_terminal git grep initial &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'configuration can enable pager (from
> > >     subdir)' '
> > >     @@ -122,107 +122,107 @@ test_expect_success TTY 'configuration ca=
n enable pager (from subdir)' '
> > >     test_terminal git bundle unbundle ../test.bundle
> > >     ) &&
> > >     {
> > >
> > >
> > > -       test -e paginated.out ||
> > >
> > >
> > > -       test -e subdir/paginated.out
> > >
> > >
> > >
> > > -       test_path_is_file paginated.out ||
> > >
> > >
> > > -       test_path_is_file subdir/paginated.out
> > >
> > >
> > >     }
> > >     '
> > >     test_expect_success TTY 'git tag -l defaults to paging' '
> > >     rm -f paginated.out &&
> > >     test_terminal git tag -l &&
> > >
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag -l respects pager.tag' '
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.tag=3Dfalse tag -l &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag -l respects --no-pager' '
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.tag --no-pager tag -l &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag with no args defaults to paging'
> > >     '
> > >
> > >     no args implies -l so this should page like -l
> > >
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >
> > >     rm -f paginated.out &&
> > >     test_terminal git tag &&
> > >
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag with no args respects pager.tag'
> > >     '
> > >
> > >     no args implies -l so this should page like -l
> > >
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > >
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.tag=3Dfalse tag &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag --contains defaults to paging' '
> > >
> > >     --contains implies -l so this should page like -l
> > >
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >
> > >     rm -f paginated.out &&
> > >     test_terminal git tag --contains &&
> > >
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag --contains respects pager.tag' '
> > >
> > >     --contains implies -l so this should page like -l
> > >
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.tag=3Dfalse tag --contains &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag -a defaults to not paging' '
> > >     test_when_finished "git tag -d newtag" &&
> > >     rm -f paginated.out &&
> > >     test_terminal git tag -am message newtag &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag -a ignores pager.tag' '
> > >     test_when_finished "git tag -d newtag" &&
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.tag tag -am message newtag &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag -a respects --paginate' '
> > >     test_when_finished "git tag -d newtag" &&
> > >     rm -f paginated.out &&
> > >     test_terminal git --paginate tag -am message newtag &&
> > >
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag as alias ignores pager.tag with
> > >     -a' '
> > >     test_when_finished "git tag -d newtag" &&
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.tag -c alias.t=3Dtag t -am message new=
tag &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git tag as alias respects pager.tag with
> > >     -l' '
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.tag=3Dfalse -c alias.t=3Dtag t -l &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git branch defaults to paging' '
> > >     rm -f paginated.out &&
> > >     test_terminal git branch &&
> > >
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >     test_expect_success TTY 'git branch respects pager.branch' '
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.branch=3Dfalse branch &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git branch respects --no-pager' '
> > >     rm -f paginated.out &&
> > >     test_terminal git --no-pager branch &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git branch --edit-description ignores
> > >     pager.branch' '
> > >     @@ -232,8 +232,8 @@ test_expect_success TTY 'git branch --edit-de=
scription ignores pager.branch' '
> > >     touch editor.used
> > >     EOF
> > >     EDITOR=3D./editor test_terminal git -c pager.branch branch --edit=
-description &&
> > >
> > >
> > > -   ! test -e paginated.out &&
> > > -   test -e editor.used
> > >
> > > -   test_path_is_missing paginated.out &&
> > > -   test_path_is_file editor.used
> > >     '
> > >     test_expect_success TTY 'git branch --set-upstream-to ignores
> > >     pager.branch' '
> > >     @@ -242,13 +242,13 @@ test_expect_success TTY 'git branch --set-u=
pstream-to ignores pager.branch' '
> > >     test_when_finished "git branch -D other" &&
> > >     test_terminal git -c pager.branch branch --set-upstream-to=3Dothe=
r &&
> > >     test_when_finished "git branch --unset-upstream" &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git config ignores pager.config when
> > >     setting' '
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.config config foo.bar bar &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git config --edit ignores pager.config' =
'
> > >     @@ -257,33 +257,33 @@ test_expect_success TTY 'git config --edit =
ignores pager.config' '
> > >     touch editor.used
> > >     EOF
> > >     EDITOR=3D./editor test_terminal git -c pager.config config --edit=
 &&
> > >
> > >
> > > -   ! test -e paginated.out &&
> > > -   test -e editor.used
> > >
> > > -   test_path_is_missing paginated.out &&
> > > -   test_path_is_file editor.used
> > >     '
> > >     test_expect_success TTY 'git config --get ignores pager.config' '
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.config config --get foo.bar &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git config --get-urlmatch defaults to
> > >     paging' '
> > >     rm -f paginated.out &&
> > >     test_terminal git -c http."https://foo.com/".bar=3Dfoo \
> > >     config --get-urlmatch http https://foo.com &&
> > >
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >     test_expect_success TTY 'git config --get-all respects
> > >     pager.config' '
> > >     rm -f paginated.out &&
> > >     test_terminal git -c pager.config=3Dfalse config --get-all foo.ba=
r &&
> > >
> > >
> > > -   ! test -e paginated.out
> > >
> > > -   test_path_is_missing paginated.out
> > >     '
> > >     test_expect_success TTY 'git config --list defaults to paging' '
> > >     rm -f paginated.out &&
> > >     test_terminal git config --list &&
> > >
> > >
> > > -   test -e paginated.out
> > >
> > > -   test_path_is_file paginated.out
> > >     '
> > >
> > >
> > > @@ -392,7 +392,7 @@ test_default_pager() {
> > > export PATH &&
> > > $full_command
> > > ) &&
> > >
> > > -       test -e default_pager_used
> > >
> > >
> > >
> > > -       test_path_is_file default_pager_used
> > >
> > >
> > >     "
> > >     }
> > >     @@ -406,7 +406,7 @@ test_PAGER_overrides() {
> > >     PAGER=3D'wc >PAGER_used' &&
> > >     export PAGER &&
> > >     $full_command &&
> > >
> > >
> > > -       test -e PAGER_used
> > >
> > >
> > >
> > > -       test_path_is_file PAGER_used
> > >
> > >
> > >     "
> > >     }
> > >     @@ -432,7 +432,7 @@ test_core_pager() {
> > >     export PAGER &&
> > >     test_config core.pager 'wc >core.pager_used' &&
> > >     $full_command &&
> > >
> > >
> > > -       ${if_local_config}test -e core.pager_used
> > >
> > >
> > >
> > > -       ${if_local_config}test_path_is_file core.pager_used
> > >
> > >
> > >     "
> > >     }
> > >     @@ -464,7 +464,7 @@ test_pager_subdir_helper() {
> > >     cd sub &&
> > >     $full_command
> > >     ) &&
> > >
> > >
> > > -       ${if_local_config}test -e core.pager_used
> > >
> > >
> > >
> > > -       ${if_local_config}test_path_is_file core.pager_used
> > >
> > >
> > >     "
> > >     }
> > >     @@ -477,7 +477,7 @@ test_GIT_PAGER_overrides() {
> > >     GIT_PAGER=3D'wc >GIT_PAGER_used' &&
> > >     export GIT_PAGER &&
> > >     $full_command &&
> > >
> > >
> > > -       test -e GIT_PAGER_used
> > >
> > >
> > >
> > > -       test_path_is_file GIT_PAGER_used
> > >
> > >
> > >     "
> > >     }
> > >     @@ -489,7 +489,7 @@ test_doesnt_paginate() {
> > >     GIT_PAGER=3D'wc >GIT_PAGER_used' &&
> > >     export GIT_PAGER &&
> > >     $full_command &&
> > >
> > >
> > > -       ! test -e GIT_PAGER_used
> > >
> > >
> > >
> > > -       test_path_is_missing GIT_PAGER_used
> > >
> > >
> > >     "
> > >     }
> > >     --
> > >     2.29.0.rc2
> > >


