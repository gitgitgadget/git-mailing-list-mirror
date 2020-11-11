Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251ADC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0AF2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HjCFOFy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKKVn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:43:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:57935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgKKVnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 16:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605130988;
        bh=OqiYQVSihhyOSq/DvoAW3ApLDOhcMgJEeeufalZkve0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HjCFOFy70SzzXQrawEdHhBB+YqtS6oPxWWQmy4VW+D9YDIUIyipsm9WPRMYxOZUx8
         hNuU9DgIaAP2+/OkM3S0mZ+cxF6zn/Uc4zcDF7L/YyxFhCK09zP9TclaOQgOEGb4Ht
         dSGxk9ctmUzFo1cJ1iOLNU7uTwYs7BDscZgv/uis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1keJsH18Kj-0082Zo; Wed, 11
 Nov 2020 22:43:08 +0100
Date:   Wed, 11 Nov 2020 22:43:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     gitster@pobox.com
cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] t4013: prepare for the new default branch name "main"
In-Reply-To: <pull.783.git.1604829561838.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011112137390.18437@tvgsbejvaqbjf.bet>
References: <pull.783.git.1604829561838.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kVpPMIFm9sq7CXFGAFMVKDxE4/pn3BKzyt0+RsBM8LbNMg1937m
 7ND+ZkZ1SzY97cVcdPMbndf+MHT5wxMIGnYevW4HQUkU+YePcuD2Cp4RqwQJs8ZpSRRYaD1
 54yGLRyiYUDtt6q21R8mnxIRTmOxblfx8UvIhceulMT5N0gsbIzkQ9phmZoJrJf3Yw4s6on
 +XyNYF1LZu0AIlYgVJS3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D5PNdoDKLoA=:2MCNx39StHdHPdsV/zCPyo
 SmXFQBnuF3OdjeKz2/QJ1+s9eaJch/l90+rnzcMw2JPQrfIKbMl8NbBBKEP98s2L0FP9SQ8RY
 MYVCyAeu0v5vk1h60uv7fAqjjI9PVUSCEoV6R+zWB6Mu8dLRoZxMshOZOAZ8j4KNqiXOTuztG
 zDnP6gCv917j8ygxtuJmkUf1U0NFOprRCDvD2KpyPtFoBS8iK/553+NDLZBxfSw9Byg3YbWJX
 FxjA5Wr1xVlxF21Vs6bECXYT2tbqrhH4VwK0TU6GJKSLy1GoYtPDmOu4BZq4AD/8tSwxdRANd
 BNStXhIVLMt00xUeKq3S4tEpaYOeaiINApttvsPdJ6GcVf0npwzDDbZRgHYq/Euc0qQDzoY8J
 IqrRecjmqdPIGFd2kUWKRp3wPvRGDRRfemsX8j/H0Q8sUzay1br5mFFZg8gS9J3JPYjJMo2kn
 r7Eloy9Ofsik8YbmqQ0sdGT8Uf12ASMREbZYxIkKjiETIvfhrK40OhequACu1V3FH5Kv7XsgY
 ldWF9SRAVYbF/8vDdw8Nd8wVKSM+HDzw6kZo+jI6F4e84r66mcHOa6HhPzFDI9ISKaqFMsDcm
 qyT4tOzYBBAqarZEcwmKMYpG5zFqveutV6KPn2h1c6NvYhntcvRRlvqPlAIMFQabobio6QZyH
 L10IluEwmZx9IU7v1gHWVYlV5IJHmC2MOizLxX2nayjieugcvPgN7spOtjnjlDwY7Z58WfwDQ
 fXQxfpwrk67U74KUW2SJ8Z1ZgC0TB7RJ6tIPKyTkNEvbIigk9Kc1//S/G+hTrR+AWKSOnN+sm
 6969c7QWEWEd+c/pKdqTnf1ybK7JO9CX9Lc/zlQSG1GtkL+lPJSy94bPvg4p3Kbwt+7VvMPbn
 7xxpZWpDt59Wcw8vAhxaTIwl80PUAzgesuiIbMPMQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Sun, 8 Nov 2020, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This patch is a bit involved, mainly because the default branch name is
> not only hard-coded in the script `t4013-diff-various.sh` itself, and
> not only in the support files in `t/t4013/`, but also in the _file
> names_ in `t/t4013/`.
>
> The trick to adjust this test script was performed by inserting the
> definition GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain at the beginning =
of
> the test script, and then running these commands:
>
> (cd t &&
>  sed -i 's/master/main/g' -- \
> 	$(git grep -l master HEAD -- ./t4013\* | sed 's/HEAD://'))
>
> and
>
> eval "$(git ls-files t/t4013/ | sed -n \
> 	-e 's/\(.*\)master\(.*\)master\(.*\)/git mv & \1main\2main\3;/p')"
>
> and
>
> eval "$(git ls-files t/t4013/ | sed -n \
> 	-e 's/\(.*\)master\(.*\)/git mv & \1main\2;/p')"
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     t4013: prepare for the new default branch name "main"
>
>     This is yet another big patch in the flurry of patch series on the w=
ay
>     to switch the default branch name used by git init to main.
>
>     I pulled this out from js/default-branch-name-part-4-minus-1 because
>     mk/diff-ignore-regex was still in flight, and conflicted with this h=
ere
>     patch.
>
>     Unfortunately, in the meantime so/log-diff-merge entered seen, and i=
t
>     conflicts, too. So it seems that I waited a bit too long... sigh. To
>     help move this patch forward (because it blocks quite a few patch se=
ries
>     on my side), I based this patch on git/git's master.
>
>     The conflicts are more than mere merge conflicts, of course: the pat=
ch
>     renames a couple of files in t/t4013/ and edits those files to repla=
ce
>     any mention of master with main. Concretely, these commands were
>     executed:
>
>     (cd t &&
>          sed -i 's/master/main/g' -- $(git grep -l master -- ./t4013\*))
>     eval "$(git ls-files t/t4013/ | sed -n \
>                 -e 's/\(.*\)master\(.*\)master\(.*\)/git mv & \1main\2ma=
in\3;/p')"
>     eval "$(git ls-files t/t4013/ | sed -n \
>                 -e 's/\(.*\)master\(.*\)/git mv & \1main\2;/p')"
>
>     In fact, the only thing this patch does on top of the result of thos=
e
>     commands is to set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain in t4=
013.
>
>     I wonder whether it would be better to apply the semantic equivalent=
 of
>     this patch on top of js/default-branch-name-part-4-minus-1, then mer=
ge
>     mk/diff-ignore-regex (resolving the conflicts essentially by re-issu=
ing
>     the commands), and then merge so/log-diff-merge. I tried that and pu=
shed
>     it up as the
>     prepare-for-main-branch-t4013-plus-mk/diff-ignore-regex-plus-so/log-=
diff-merge
>     branch to https://github.com/dscho/git. Unfortunately, so/log-diff-m=
erge
>     branches off from a much later commit in git/git's master than
>     js/default-branch-name-part-4-minus-1, therefore the commit graph of
>     that branch looks a bit messy.
>
>     So I tried another approach: rebasing so/log-diff-merge on top of th=
is
>     here patch, adjusting the patches as needed. The result can be found=
 at
>     https://github.com/dscho/git as
>     prepare-for-main-branch-t4013-plus-adjusted-so/log-diff-merge.

Could you advise how I could help advance this patch further? This is the
last patch I need that is not in `next` to get to the patch series that
actually flips the default of `init.defaultBranch` to `main` (see
https://github.com/gitgitgadget/git/pull/762).

The other patch series are mostly even in `master`, only  the following
prerequisites are only in `next` so far:

	js/p4-default-branch
	js/default-branch-name-adjust-t5515
	js/test-whitespace-fixes
	js/test-file-size
	jk/diff-release-filespec-fix
	en/merge-tests
	rs/worktree-list-show-locked
	ds/maintenance-part-4
	ds/maintenance-part-3

There are also conflicts with fc/bash-completion-post-2.29 and as I
mentioned in the quoted email, so/log-diff-merge. I am not quite sure
where those patch series are, and would be happy to help resolve
conflicts between those branches and the default-branch-name patches.

I would love to move forward with switching `init.defaultBranch` to
default to `main`, and I thought that it would be a good time now, well in
advance of the next -rc phase. What are your thoughts on this matter?

Thanks,
Dscho

>     The output of git range-diff e2850a27a95..f4150457c7d
>     ca254612280..3cd3222b22e reads like this:
>
>      1:  8e30afd4140 !  1:  17b198661f6 revision: factor out parsing of =
diff-merge related options
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## revision.c ##
>          @@ revision.c: static void add_message_grep(struct rev_info *re=
vs, const char *pattern)
>      2:  1f3770bcd09 !  2:  f0de70ab6bd revision: factor out setup of di=
ff-merge related settings
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## revision.c ##
>          @@ revision.c: static int parse_diff_merge_opts(struct rev_info=
 *revs, const char **argv) {
>      3:  acabfff0740 !  3:  3f3d217c3b5 revision: factor out initializat=
ion of diff-merge related settings
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## revision.c ##
>          @@ revision.c: static int add_parents_only(struct rev_info *rev=
s, const char *arg_, int flags,
>      4:  405aa89dfeb !  4:  3f78fd73e74 revision: provide implementation=
 for diff merges tweaks
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## builtin/log.c ##
>          @@ builtin/log.c: static int show_tree_object(const struct obje=
ct_id *oid,
>      5:  1ac1179a479 !  5:  574473b8ccb revision: move diff merges funct=
ions to its own diff-merges.c
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## Makefile ##
>          @@ Makefile: LIB_OBJS +=3D date.o
>      6:  99043703aff !  6:  7d237cb9df1 diff-merges: rename all function=
s to have common prefix
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## builtin/log.c ##
>          @@ builtin/log.c: static int show_tree_object(const struct obje=
ct_id *oid,
>      7:  3ffcf8dd2ac !  7:  95993b629ac diff-merges: move checks for fir=
st_parent_only out of the module
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## builtin/log.c ##
>          @@ builtin/log.c: static int show_tree_object(const struct obje=
ct_id *oid,
>      8:  b14e0c06319 !  8:  4c1897a9f1c diff-merges: rename diff_merges_=
default_to_enable() to match semantics
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## builtin/log.c ##
>          @@ builtin/log.c: static void show_setup_revisions_tweak(struct=
 rev_info *rev,
>      9:  c3a3db7d41f !  9:  f256249a306 diff-merges: re-arrange function=
s to match the order they are called in
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## diff-merges.c ##
>          @@
>     10:  8f260eab8ed ! 10:  31285aa5fb5 diff-merges: new function diff_m=
erges_suppress()
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## builtin/merge.c ##
>          @@
>     11:  820e1f08837 ! 11:  6f7388b2d7c diff-merges: new function diff_m=
erges_set_dense_combined_if_unset()
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## builtin/diff-files.c ##
>          @@
>     12:  c1cd628d982 ! 12:  9e24bee0010 diff-merges: introduce revs->fir=
st_parent_merges flag
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## diff-merges.c ##
>          @@ diff-merges.c: void diff_merges_suppress(struct rev_info *re=
vs) {
>     13:  dac39d0bc1c ! 13:  75d7de500ae diff-merges: revise revs->diff f=
lag handling
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## diff-merges.c ##
>          @@ diff-merges.c: int diff_merges_parse_opts(struct rev_info *r=
evs, const char **argv) {
>     14:  ead9e513b51 ! 14:  435e5169cfc t4013: support test_expect_failu=
re through ':failure' magic
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## t/t4013-diff-various.sh ##
>          @@ t/t4013-diff-various.sh: process_diffs () {
>     15:  fe299a0b5fa ! 15:  09e575c53ed t4013: add tests for -m failing =
to override -c/--cc
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## t/t4013-diff-various.sh ##
>         -@@ t/t4013-diff-various.sh: log --first-parent --diff-merges=3D=
off -p master
>         - log -p --first-parent master
>         - log -m -p --first-parent master
>         - log -m -p master
>         -+:failure log --cc -m -p master
>         -+:failure log -c -m -p master
>         - log -SF master
>         - log -S F master
>         - log -SF -p master
>         +@@ t/t4013-diff-various.sh: log --first-parent --diff-merges=3D=
off -p main
>         + log -p --first-parent main
>         + log -m -p --first-parent main
>         + log -m -p main
>         ++:failure log --cc -m -p main
>         ++:failure log -c -m -p main
>         + log -SF main
>         + log -S F main
>         + log -SF -p main
>         +@@ t/t4013-diff-various.sh: log -SF main --max-count=3D2
>         + log -GF main
>         + log -GF -p main
>         + log -GF -p --pickaxe-all main
>         +-log -IA -IB -I1 -I2 -p main
>         + log --decorate --all
>         + log --decorate=3Dfull --all
>         +
>
>         - ## t/t4013/diff.log_--cc_-m_-p_master (new) ##
>         + ## t/t4013/diff.log_--cc_-m_-p_main (new) ##
>          @@
>         -+$ git log --cc -m -p master
>         ++$ git log --cc -m -p main
>          +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949=
b6b76956d9d5e26f2791ec2ceff5fdc0)
>          +Merge: 9a6d494 c7a2ab9
>          +Author: A U Thor <author@example.com>
>         @@ -1,3 +0,0 @@
>          +    Initial
>          +$
>
>         - ## t/t4013/diff.log_-c_-m_-p_master (new) ##
>         + ## t/t4013/diff.log_-c_-m_-p_main (new) ##
>          @@
>         -+$ git log -c -m -p master
>         ++$ git log -c -m -p main
>          +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949=
b6b76956d9d5e26f2791ec2ceff5fdc0)
>          +Merge: 9a6d494 c7a2ab9
>          +Author: A U Thor <author@example.com>
>     16:  1d617dc2d90 <  -:  ----------- diff-merges: fix -m to properly =
override -c/--cc
>      -:  ----------- > 16:  52f2012a8a8 diff-merges: fix -m to properly =
override -c/--cc
>     17:  0526b313b86 ! 17:  3417f2fd0e4 diff-merges: split 'ignore_merge=
s' field
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## diff-merges.c ##
>          @@
>     18:  7f188afab8b ! 18:  ab9b959cf44 diff-merges: group diff-merge fl=
ags next to each other inside 'rev_info'
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## revision.h ##
>          @@ revision.h: struct rev_info {
>     19:  38ec10c12a8 ! 19:  328fbd9c650 diff-merges: get rid of now empt=
y diff_merges_init_revs()
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## diff-merges.c ##
>          @@ diff-merges.c: static void set_dense_combined(struct rev_inf=
o *revs) {
>     20:  c85c889ae46 ! 20:  ce20b95e25b diff-merges: refactor opt settin=
gs into separate functions
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## diff-merges.c ##
>          @@ diff-merges.c: static void suppress(struct rev_info *revs) {
>     21:  283182de25d ! 21:  e96a3e193cb diff-merges: make -m/-c/--cc exp=
licitly mutually exclusive
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## diff-merges.c ##
>          @@ diff-merges.c: static void suppress(struct rev_info *revs) {
>     22:  f80baa896df ! 22:  8ccbb1a002b diff-merges: implement new value=
s for --diff-merges
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## diff-merges.c ##
>          @@ diff-merges.c: static void set_separate(struct rev_info *rev=
s) {
>     23:  551e4dc3a62 ! 23:  92e4f9483cd t4013: add test for --diff-merge=
s=3Dfirst-parent
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## t/t4013-diff-various.sh ##
>         -@@ t/t4013-diff-various.sh: log --no-diff-merges -p --first-par=
ent master
>         - log --diff-merges=3Doff -p --first-parent master
>         - log --first-parent --diff-merges=3Doff -p master
>         - log -p --first-parent master
>         -+log -p --diff-merges=3Dfirst-parent master
>         - log -m -p --first-parent master
>         - log -m -p master
>         - log --cc -m -p master
>         +@@ t/t4013-diff-various.sh: log --no-diff-merges -p --first-par=
ent main
>         + log --diff-merges=3Doff -p --first-parent main
>         + log --first-parent --diff-merges=3Doff -p main
>         + log -p --first-parent main
>         ++log -p --diff-merges=3Dfirst-parent main
>         + log -m -p --first-parent main
>         + log -m -p main
>         + log --cc -m -p main
>
>         - ## t/t4013/diff.log_-p_--diff-merges=3Dfirst-parent_master (ne=
w) ##
>         + ## t/t4013/diff.log_-p_--diff-merges=3Dfirst-parent_main (new)=
 ##
>          @@
>         -+$ git log -p --diff-merges=3Dfirst-parent master
>         ++$ git log -p --diff-merges=3Dfirst-parent main
>          +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>          +Merge: 9a6d494 c7a2ab9
>          +Author: A U Thor <author@example.com>
>     24:  f0eb0eaf605 ! 24:  da78bc75e5e doc/git-log: describe new --diff=
-merges options
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## Documentation/git-log.txt ##
>          @@ Documentation/git-log.txt: DIFF FORMATTING
>     25:  7178aa87622 ! 25:  906b93dc4bf doc/diff-generate-patch: mention=
 new --diff-merges option
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## Documentation/diff-generate-patch.txt ##
>          @@ Documentation/diff-generate-patch.txt: Combined diff format
>     26:  f4150457c7d ! 26:  3cd3222b22e doc/rev-list-options: document -=
-first-parent implies --diff-merges=3Dfirst-parent
>         @@ Commit message
>
>              Signed-off-by: Sergey Organov <sorganov@gmail.com>
>              Signed-off-by: Junio C Hamano <gitster@pobox.com>
>         +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
>
>           ## Documentation/rev-list-options.txt ##
>          @@ Documentation/rev-list-options.txt: parents) and `--max-pare=
nts=3D-1` (negative numbers denote no upper limit).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-783%2F=
dscho%2Fprepare-for-main-branch-t4013-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-783/dscho=
/prepare-for-main-branch-t4013-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/783
>
>  t/t4013-diff-various.sh                       | 181 +++++++++---------
>  ...ree_--cc_--patch-with-stat_--summary_main} |   2 +-
>  ...iff.diff-tree_--cc_--patch-with-stat_main} |   2 +-
>  ...r =3D> diff.diff-tree_--cc_--shortstat_main} |   2 +-
>  ...diff.diff-tree_--cc_--stat_--summary_main} |   2 +-
>  ...master =3D> diff.diff-tree_--cc_--stat_main} |   2 +-
>  ...e_--cc_master =3D> diff.diff-tree_--cc_main} |   2 +-
>  ...master =3D> diff.diff-tree_-c_--abbrev_main} |   2 +-
>  ...> diff.diff-tree_-c_--stat_--summary_main} |   2 +-
>  ...t_master =3D> diff.diff-tree_-c_--stat_main} |   2 +-
>  ...-tree_-c_master =3D> diff.diff-tree_-c_main} |   2 +-
>  ...-p_-m_master =3D> diff.diff-tree_-p_-m_main} |   2 +-
>  t/t4013/diff.diff-tree_-p_main                |   2 +
>  t/t4013/diff.diff-tree_-p_master              |   2 -
>  t/t4013/diff.diff-tree_main                   |   2 +
>  t/t4013/diff.diff-tree_master                 |   2 -
>  t/t4013/diff.diff_--dirstat_--cc_main~1_main  |   3 +
>  .../diff.diff_--dirstat_--cc_master~1_master  |   3 -
>  t/t4013/diff.diff_--dirstat_main~1_main~2     |   3 +
>  t/t4013/diff.diff_--dirstat_master~1_master~2 |   3 -
>  ...ff.diff_--line-prefix=3Dabc_main_main^_side} |   2 +-
>  ...master^_side =3D> diff.diff_main_main^_side} |   2 +-
>  ...mat-patch_--attach_--stdout_initial..main} |   2 +-
>  ...at-patch_--attach_--stdout_initial..main^} |   2 +-
>  ...e_--stdout_--numbered-files_initial..main} |   2 +-
>  ...t_--subject-prefix=3DTESTCASE_initial..main} |   2 +-
>  ...mat-patch_--inline_--stdout_initial..main} |   2 +-
>  ...at-patch_--inline_--stdout_initial..main^} |   2 +-
>  ...t-patch_--inline_--stdout_initial..main^^} |   2 +-
>  ...--stdout_--cover-letter_-n_initial..main^} |   2 +-
>  ...atch_--stdout_--no-numbered_initial..main} |   2 +-
>  ...t-patch_--stdout_--numbered_initial..main} |   2 +-
>  ... diff.format-patch_--stdout_initial..main} |   2 +-
>  ...diff.format-patch_--stdout_initial..main^} |   2 +-
>  t/t4013/diff.log_--decorate=3Dfull_--all        |   2 +-
>  t/t4013/diff.log_--decorate_--all             |   2 +-
>  ..._--diff-merges=3Doff_-p_--first-parent_main} |   2 +-
>  ..._--first-parent_--diff-merges=3Doff_-p_main} |   2 +-
>  ...g_--no-diff-merges_-p_--first-parent_main} |   2 +-
>  ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
>  ...master =3D> diff.log_--patch-with-stat_main} |   2 +-
>  ...> diff.log_--patch-with-stat_main_--_dir_} |   2 +-
>  ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
>  ...g_--root_--patch-with-stat_--summary_main} |   2 +-
>  ...=3D> diff.log_--root_--patch-with-stat_main} |   2 +-
>  ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
>  ...root_-p_master =3D> diff.log_--root_-p_main} |   2 +-
>  ...log_--root_master =3D> diff.log_--root_main} |   2 +-
>  ...ter =3D> diff.log_-GF_-p_--pickaxe-all_main} |   2 +-
>  ...log_-GF_-p_master =3D> diff.log_-GF_-p_main} |   2 +-
>  ...{diff.log_-SF_master =3D> diff.log_-GF_main} |   2 +-
>  ...aster =3D> diff.log_-IA_-IB_-I1_-I2_-p_main} |   2 +-
>  ...log_-SF_-p_master =3D> diff.log_-SF_-p_main} |   2 +-
>  ...{diff.log_-GF_master =3D> diff.log_-SF_main} |   2 +-
>  t/t4013/diff.log_-SF_main_--max-count=3D0       |   2 +
>  ...ount=3D2 =3D> diff.log_-SF_main_--max-count=3D1} |   2 +-
>  t/t4013/diff.log_-SF_main_--max-count=3D2       |   7 +
>  t/t4013/diff.log_-SF_master_--max-count=3D0     |   2 -
>  t/t4013/diff.log_-SF_master_--max-count=3D1     |   7 -
>  ...iff.log_-S_F_master =3D> diff.log_-S_F_main} |   2 +-
>  ...ter =3D> diff.log_-m_-p_--first-parent_main} |   2 +-
>  ...f.log_-m_-p_master =3D> diff.log_-m_-p_main} |   2 +-
>  ...master =3D> diff.log_-p_--first-parent_main} |   2 +-
>  .../{diff.log_-p_master =3D> diff.log_-p_main}  |   2 +-
>  t/t4013/{diff.log_master =3D> diff.log_main}    |   2 +-
>  ...iff.noellipses-diff-tree_-c_--abbrev_main} |   2 +-
>  ...> diff.noellipses-whatchanged_--root_main} |   2 +-
>  ...r =3D> diff.noellipses-whatchanged_-SF_main} |   2 +-
>  ...aster =3D> diff.noellipses-whatchanged_main} |   2 +-
>  ...t_master =3D> diff.show_--first-parent_main} |   2 +-
>  ...{diff.show_-c_master =3D> diff.show_-c_main} |   2 +-
>  ...{diff.show_-m_master =3D> diff.show_-m_main} |   2 +-
>  t/t4013/{diff.show_master =3D> diff.show_main}  |   2 +-
>  ..._--patch-with-stat_--summary_main_--_dir_} |   2 +-
>  ...> diff.whatchanged_--patch-with-stat_main} |   2 +-
>  ...hatchanged_--patch-with-stat_main_--_dir_} |   2 +-
>  ...oot_--cc_--patch-with-stat_--summary_main} |   2 +-
>  ...d_--root_--patch-with-stat_--summary_main} |   2 +-
>  ...whatchanged_--root_--patch-with-stat_main} |   2 +-
>  ...-root_-c_--patch-with-stat_--summary_main} |   2 +-
>  ...master =3D> diff.whatchanged_--root_-p_main} |   2 +-
>  ...ot_master =3D> diff.whatchanged_--root_main} |   2 +-
>  ...-p_master =3D> diff.whatchanged_-SF_-p_main} |   2 +-
>  ...d_-SF_master =3D> diff.whatchanged_-SF_main} |   2 +-
>  ...ged_-p_master =3D> diff.whatchanged_-p_main} |   2 +-
>  ...atchanged_master =3D> diff.whatchanged_main} |   2 +-
>  86 files changed, 184 insertions(+), 181 deletions(-)
>  rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_--summary_master =
=3D> diff.diff-tree_--cc_--patch-with-stat_--summary_main} (86%)
>  rename t/t4013/{diff.diff-tree_--cc_--patch-with-stat_master =3D> diff.=
diff-tree_--cc_--patch-with-stat_main} (89%)
>  rename t/t4013/{diff.diff-tree_--cc_--shortstat_master =3D> diff.diff-t=
ree_--cc_--shortstat_main} (65%)
>  rename t/t4013/{diff.diff-tree_-c_--stat_--summary_master =3D> diff.dif=
f-tree_--cc_--stat_--summary_main} (71%)
>  rename t/t4013/{diff.diff-tree_-c_--stat_master =3D> diff.diff-tree_--c=
c_--stat_main} (76%)
>  rename t/t4013/{diff.diff-tree_--cc_master =3D> diff.diff-tree_--cc_mai=
n} (91%)
>  rename t/t4013/{diff.diff-tree_-c_--abbrev_master =3D> diff.diff-tree_-=
c_--abbrev_main} (83%)
>  rename t/t4013/{diff.diff-tree_--cc_--stat_--summary_master =3D> diff.d=
iff-tree_-c_--stat_--summary_main} (70%)
>  rename t/t4013/{diff.diff-tree_--cc_--stat_master =3D> diff.diff-tree_-=
c_--stat_main} (75%)
>  rename t/t4013/{diff.diff-tree_-c_master =3D> diff.diff-tree_-c_main} (=
93%)
>  rename t/t4013/{diff.diff-tree_-p_-m_master =3D> diff.diff-tree_-p_-m_m=
ain} (97%)
>  create mode 100644 t/t4013/diff.diff-tree_-p_main
>  delete mode 100644 t/t4013/diff.diff-tree_-p_master
>  create mode 100644 t/t4013/diff.diff-tree_main
>  delete mode 100644 t/t4013/diff.diff-tree_master
>  create mode 100644 t/t4013/diff.diff_--dirstat_--cc_main~1_main
>  delete mode 100644 t/t4013/diff.diff_--dirstat_--cc_master~1_master
>  create mode 100644 t/t4013/diff.diff_--dirstat_main~1_main~2
>  delete mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2
>  rename t/t4013/{diff.diff_--line-prefix=3Dabc_master_master^_side =3D> =
diff.diff_--line-prefix=3Dabc_main_main^_side} (87%)
>  rename t/t4013/{diff.diff_master_master^_side =3D> diff.diff_main_main^=
_side} (89%)
>  rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master =3D=
> diff.format-patch_--attach_--stdout_initial..main} (98%)
>  rename t/t4013/{diff.format-patch_--attach_--stdout_initial..master^ =
=3D> diff.format-patch_--attach_--stdout_initial..main^} (97%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_--numbered-files_in=
itial..master =3D> diff.format-patch_--inline_--stdout_--numbered-files_in=
itial..main} (99%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_--subject-prefix=3D=
TESTCASE_initial..master =3D> diff.format-patch_--inline_--stdout_--subjec=
t-prefix=3DTESTCASE_initial..main} (99%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master =3D=
> diff.format-patch_--inline_--stdout_initial..main} (98%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^ =
=3D> diff.format-patch_--inline_--stdout_initial..main^} (97%)
>  rename t/t4013/{diff.format-patch_--inline_--stdout_initial..master^^ =
=3D> diff.format-patch_--inline_--stdout_initial..main^^} (95%)
>  rename t/t4013/{diff.format-patch_--stdout_--cover-letter_-n_initial..m=
aster^ =3D> diff.format-patch_--stdout_--cover-letter_-n_initial..main^} (=
96%)
>  rename t/t4013/{diff.format-patch_--stdout_--no-numbered_initial..maste=
r =3D> diff.format-patch_--stdout_--no-numbered_initial..main} (97%)
>  rename t/t4013/{diff.format-patch_--stdout_--numbered_initial..master =
=3D> diff.format-patch_--stdout_--numbered_initial..main} (97%)
>  rename t/t4013/{diff.format-patch_--stdout_initial..master =3D> diff.fo=
rmat-patch_--stdout_initial..main} (97%)
>  rename t/t4013/{diff.format-patch_--stdout_initial..master^ =3D> diff.f=
ormat-patch_--stdout_initial..main^} (96%)
>  rename t/t4013/{diff.log_--no-diff-merges_-p_--first-parent_master =3D>=
 diff.log_--diff-merges=3Doff_-p_--first-parent_main} (95%)
>  rename t/t4013/{diff.log_--first-parent_--diff-merges=3Doff_-p_master =
=3D> diff.log_--first-parent_--diff-merges=3Doff_-p_main} (95%)
>  rename t/t4013/{diff.log_--diff-merges=3Doff_-p_--first-parent_master =
=3D> diff.log_--no-diff-merges_-p_--first-parent_main} (95%)
>  rename t/t4013/{diff.log_--patch-with-stat_--summary_master_--_dir_ =3D=
> diff.log_--patch-with-stat_--summary_main_--_dir_} (96%)
>  rename t/t4013/{diff.log_--patch-with-stat_master =3D> diff.log_--patch=
-with-stat_main} (98%)
>  rename t/t4013/{diff.log_--patch-with-stat_master_--_dir_ =3D> diff.log=
_--patch-with-stat_main_--_dir_} (96%)
>  rename t/t4013/{diff.log_--root_--cc_--patch-with-stat_--summary_master=
 =3D> diff.log_--root_--cc_--patch-with-stat_--summary_main} (98%)
>  rename t/t4013/{diff.log_--root_--patch-with-stat_--summary_master =3D>=
 diff.log_--root_--patch-with-stat_--summary_main} (98%)
>  rename t/t4013/{diff.log_--root_--patch-with-stat_master =3D> diff.log_=
--root_--patch-with-stat_main} (98%)
>  rename t/t4013/{diff.log_--root_-c_--patch-with-stat_--summary_master =
=3D> diff.log_--root_-c_--patch-with-stat_--summary_main} (98%)
>  rename t/t4013/{diff.log_--root_-p_master =3D> diff.log_--root_-p_main}=
 (98%)
>  rename t/t4013/{diff.log_--root_master =3D> diff.log_--root_main} (96%)
>  rename t/t4013/{diff.log_-GF_-p_--pickaxe-all_master =3D> diff.log_-GF_=
-p_--pickaxe-all_main} (90%)
>  rename t/t4013/{diff.log_-GF_-p_master =3D> diff.log_-GF_-p_main} (91%)
>  rename t/t4013/{diff.log_-SF_master =3D> diff.log_-GF_main} (86%)
>  rename t/t4013/{diff.log_-IA_-IB_-I1_-I2_-p_master =3D> diff.log_-IA_-I=
B_-I1_-I2_-p_main} (97%)
>  rename t/t4013/{diff.log_-SF_-p_master =3D> diff.log_-SF_-p_main} (91%)
>  rename t/t4013/{diff.log_-GF_master =3D> diff.log_-SF_main} (86%)
>  create mode 100644 t/t4013/diff.log_-SF_main_--max-count=3D0
>  rename t/t4013/{diff.log_-SF_master_--max-count=3D2 =3D> diff.log_-SF_m=
ain_--max-count=3D1} (79%)
>  create mode 100644 t/t4013/diff.log_-SF_main_--max-count=3D2
>  delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=3D0
>  delete mode 100644 t/t4013/diff.log_-SF_master_--max-count=3D1
>  rename t/t4013/{diff.log_-S_F_master =3D> diff.log_-S_F_main} (86%)
>  rename t/t4013/{diff.log_-m_-p_--first-parent_master =3D> diff.log_-m_-=
p_--first-parent_main} (97%)
>  rename t/t4013/{diff.log_-m_-p_master =3D> diff.log_-m_-p_main} (99%)
>  rename t/t4013/{diff.log_-p_--first-parent_master =3D> diff.log_-p_--fi=
rst-parent_main} (97%)
>  rename t/t4013/{diff.log_-p_master =3D> diff.log_-p_main} (98%)
>  rename t/t4013/{diff.log_master =3D> diff.log_main} (97%)
>  rename t/t4013/{diff.noellipses-diff-tree_-c_--abbrev_master =3D> diff.=
noellipses-diff-tree_-c_--abbrev_main} (81%)
>  rename t/t4013/{diff.noellipses-whatchanged_--root_master =3D> diff.noe=
llipses-whatchanged_--root_main} (96%)
>  rename t/t4013/{diff.noellipses-whatchanged_-SF_master =3D> diff.noelli=
pses-whatchanged_-SF_main} (86%)
>  rename t/t4013/{diff.noellipses-whatchanged_master =3D> diff.noellipses=
-whatchanged_main} (96%)
>  rename t/t4013/{diff.show_--first-parent_master =3D> diff.show_--first-=
parent_main} (92%)
>  rename t/t4013/{diff.show_-c_master =3D> diff.show_-c_main} (95%)
>  rename t/t4013/{diff.show_-m_master =3D> diff.show_-m_main} (98%)
>  rename t/t4013/{diff.show_master =3D> diff.show_main} (96%)
>  rename t/t4013/{diff.whatchanged_--patch-with-stat_--summary_master_--_=
dir_ =3D> diff.whatchanged_--patch-with-stat_--summary_main_--_dir_} (94%)
>  rename t/t4013/{diff.whatchanged_--patch-with-stat_master =3D> diff.wha=
tchanged_--patch-with-stat_main} (97%)
>  rename t/t4013/{diff.whatchanged_--patch-with-stat_master_--_dir_ =3D> =
diff.whatchanged_--patch-with-stat_main_--_dir_} (94%)
>  rename t/t4013/{diff.whatchanged_--root_--cc_--patch-with-stat_--summar=
y_master =3D> diff.whatchanged_--root_--cc_--patch-with-stat_--summary_mai=
n} (97%)
>  rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_--summary_mas=
ter =3D> diff.whatchanged_--root_--patch-with-stat_--summary_main} (97%)
>  rename t/t4013/{diff.whatchanged_--root_--patch-with-stat_master =3D> d=
iff.whatchanged_--root_--patch-with-stat_main} (97%)
>  rename t/t4013/{diff.whatchanged_--root_-c_--patch-with-stat_--summary_=
master =3D> diff.whatchanged_--root_-c_--patch-with-stat_--summary_main} (=
97%)
>  rename t/t4013/{diff.whatchanged_--root_-p_master =3D> diff.whatchanged=
_--root_-p_main} (98%)
>  rename t/t4013/{diff.whatchanged_--root_master =3D> diff.whatchanged_--=
root_main} (97%)
>  rename t/t4013/{diff.whatchanged_-SF_-p_master =3D> diff.whatchanged_-S=
F_-p_main} (89%)
>  rename t/t4013/{diff.whatchanged_-SF_master =3D> diff.whatchanged_-SF_m=
ain} (86%)
>  rename t/t4013/{diff.whatchanged_-p_master =3D> diff.whatchanged_-p_mai=
n} (98%)
>  rename t/t4013/{diff.whatchanged_master =3D> diff.whatchanged_main} (97=
%)
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index f72d456d3b..25c2952c40 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -5,6 +5,9 @@
>
>  test_description=3D'Various diff formatting options'
>
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/diff-lib.sh
>
> @@ -61,7 +64,7 @@ test_expect_success setup '
>  	GIT_COMMITTER_DATE=3D"2006-06-26 00:04:00 +0000" &&
>  	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
>
> -	git checkout master &&
> +	git checkout main &&
>  	git pull -s ours . side &&
>
>  	GIT_AUTHOR_DATE=3D"2006-06-26 00:05:00 +0000" &&
> @@ -86,7 +89,7 @@ test_expect_success setup '
>  	for i in B A; do echo $i; done >dir/sub &&
>  	git add dir/sub &&
>  	git commit -m "Rearranged lines in dir/sub" &&
> -	git checkout master &&
> +	git checkout main &&
>
>  	GIT_AUTHOR_DATE=3D"2006-06-26 00:06:00 +0000" &&
>  	GIT_COMMITTER_DATE=3D"2006-06-26 00:06:00 +0000" &&
> @@ -94,7 +97,7 @@ test_expect_success setup '
>  	git checkout -b mode initial &&
>  	git update-index --chmod=3D+x file0 &&
>  	git commit -m "update mode" &&
> -	git checkout -f master &&
> +	git checkout -f main &&
>
>  	GIT_AUTHOR_DATE=3D"2006-06-26 00:06:00 +0000" &&
>  	GIT_COMMITTER_DATE=3D"2006-06-26 00:06:00 +0000" &&
> @@ -103,12 +106,12 @@ test_expect_success setup '
>  	git update-index --chmod=3D+x file2 &&
>  	git commit -m "update mode (file2)" &&
>  	git notes add -m "note" &&
> -	git checkout -f master &&
> +	git checkout -f main &&
>
> -	# Same merge as master, but with parents reversed. Hide it in a
> +	# Same merge as main, but with parents reversed. Hide it in a
>  	# pseudo-ref to avoid impacting tests with --all.
>  	commit=3D$(echo reverse |
> -		 git commit-tree -p master^2 -p master^1 master^{tree}) &&
> +		 git commit-tree -p main^2 -p main^1 main^{tree}) &&
>  	git update-ref REVERSE $commit &&
>
>  	git config diff.renames false &&
> @@ -118,15 +121,15 @@ test_expect_success setup '
>
>  : <<\EOF
>  ! [initial] Initial
> - * [master] Merge branch 'side'
> + * [main] Merge branch 'side'
>    ! [rearrange] Rearranged lines in dir/sub
>     ! [side] Side
>  ----
>    +  [rearrange] Rearranged lines in dir/sub
> - -   [master] Merge branch 'side'
> + -   [main] Merge branch 'side'
>   * + [side] Side
> - *   [master^] Third
> - *   [master~2] Second
> + *   [main^] Third
> + *   [main~2] Second
>  +*++ [initial] Initial
>  EOF
>
> @@ -284,92 +287,92 @@ diff-tree initial mode
>  diff-tree --stat initial mode
>  diff-tree --summary initial mode
>
> -diff-tree master
> -diff-tree -p master
> -diff-tree -p -m master
> -diff-tree -c master
> -diff-tree -c --abbrev master
> -:noellipses diff-tree -c --abbrev master
> -diff-tree --cc master
> +diff-tree main
> +diff-tree -p main
> +diff-tree -p -m main
> +diff-tree -c main
> +diff-tree -c --abbrev main
> +:noellipses diff-tree -c --abbrev main
> +diff-tree --cc main
>  # stat only should show the diffstat with the first parent
> -diff-tree -c --stat master
> -diff-tree --cc --stat master
> -diff-tree -c --stat --summary master
> -diff-tree --cc --stat --summary master
> +diff-tree -c --stat main
> +diff-tree --cc --stat main
> +diff-tree -c --stat --summary main
> +diff-tree --cc --stat --summary main
>  # stat summary should show the diffstat and summary with the first pare=
nt
>  diff-tree -c --stat --summary side
>  diff-tree --cc --stat --summary side
> -diff-tree --cc --shortstat master
> +diff-tree --cc --shortstat main
>  diff-tree --cc --summary REVERSE
>  # improved by Timo's patch
> -diff-tree --cc --patch-with-stat master
> +diff-tree --cc --patch-with-stat main
>  # improved by Timo's patch
> -diff-tree --cc --patch-with-stat --summary master
> +diff-tree --cc --patch-with-stat --summary main
>  # this is correct
>  diff-tree --cc --patch-with-stat --summary side
>
> -log master
> -log -p master
> -log --root master
> -log --root -p master
> -log --patch-with-stat master
> -log --root --patch-with-stat master
> -log --root --patch-with-stat --summary master
> +log main
> +log -p main
> +log --root main
> +log --root -p main
> +log --patch-with-stat main
> +log --root --patch-with-stat main
> +log --root --patch-with-stat --summary main
>  # improved by Timo's patch
> -log --root -c --patch-with-stat --summary master
> +log --root -c --patch-with-stat --summary main
>  # improved by Timo's patch
> -log --root --cc --patch-with-stat --summary master
> -log --no-diff-merges -p --first-parent master
> -log --diff-merges=3Doff -p --first-parent master
> -log --first-parent --diff-merges=3Doff -p master
> -log -p --first-parent master
> -log -m -p --first-parent master
> -log -m -p master
> -log -SF master
> -log -S F master
> -log -SF -p master
> -log -SF master --max-count=3D0
> -log -SF master --max-count=3D1
> -log -SF master --max-count=3D2
> -log -GF master
> -log -GF -p master
> -log -GF -p --pickaxe-all master
> -log -IA -IB -I1 -I2 -p master
> +log --root --cc --patch-with-stat --summary main
> +log --no-diff-merges -p --first-parent main
> +log --diff-merges=3Doff -p --first-parent main
> +log --first-parent --diff-merges=3Doff -p main
> +log -p --first-parent main
> +log -m -p --first-parent main
> +log -m -p main
> +log -SF main
> +log -S F main
> +log -SF -p main
> +log -SF main --max-count=3D0
> +log -SF main --max-count=3D1
> +log -SF main --max-count=3D2
> +log -GF main
> +log -GF -p main
> +log -GF -p --pickaxe-all main
> +log -IA -IB -I1 -I2 -p main
>  log --decorate --all
>  log --decorate=3Dfull --all
>
>  rev-list --parents HEAD
>  rev-list --children HEAD
>
> -whatchanged master
> -:noellipses whatchanged master
> -whatchanged -p master
> -whatchanged --root master
> -:noellipses whatchanged --root master
> -whatchanged --root -p master
> -whatchanged --patch-with-stat master
> -whatchanged --root --patch-with-stat master
> -whatchanged --root --patch-with-stat --summary master
> +whatchanged main
> +:noellipses whatchanged main
> +whatchanged -p main
> +whatchanged --root main
> +:noellipses whatchanged --root main
> +whatchanged --root -p main
> +whatchanged --patch-with-stat main
> +whatchanged --root --patch-with-stat main
> +whatchanged --root --patch-with-stat --summary main
>  # improved by Timo's patch
> -whatchanged --root -c --patch-with-stat --summary master
> +whatchanged --root -c --patch-with-stat --summary main
>  # improved by Timo's patch
> -whatchanged --root --cc --patch-with-stat --summary master
> -whatchanged -SF master
> -:noellipses whatchanged -SF master
> -whatchanged -SF -p master
> +whatchanged --root --cc --patch-with-stat --summary main
> +whatchanged -SF main
> +:noellipses whatchanged -SF main
> +whatchanged -SF -p main
>
> -log --patch-with-stat master -- dir/
> -whatchanged --patch-with-stat master -- dir/
> -log --patch-with-stat --summary master -- dir/
> -whatchanged --patch-with-stat --summary master -- dir/
> +log --patch-with-stat main -- dir/
> +whatchanged --patch-with-stat main -- dir/
> +log --patch-with-stat --summary main -- dir/
> +whatchanged --patch-with-stat --summary main -- dir/
>
>  show initial
>  show --root initial
>  show side
> -show master
> -show -c master
> -show -m master
> -show --first-parent master
> +show main
> +show -c main
> +show -m main
> +show --first-parent main
>  show --stat side
>  show --stat --summary side
>  show --patch-with-stat side
> @@ -378,22 +381,22 @@ show --patch-with-raw side
>  show --patch-with-stat --summary side
>
>  format-patch --stdout initial..side
> -format-patch --stdout initial..master^
> -format-patch --stdout initial..master
> -format-patch --stdout --no-numbered initial..master
> -format-patch --stdout --numbered initial..master
> +format-patch --stdout initial..main^
> +format-patch --stdout initial..main
> +format-patch --stdout --no-numbered initial..main
> +format-patch --stdout --numbered initial..main
>  format-patch --attach --stdout initial..side
>  format-patch --attach --stdout --suffix=3D.diff initial..side
> -format-patch --attach --stdout initial..master^
> -format-patch --attach --stdout initial..master
> +format-patch --attach --stdout initial..main^
> +format-patch --attach --stdout initial..main
>  format-patch --inline --stdout initial..side
> -format-patch --inline --stdout initial..master^
> -format-patch --inline --stdout --numbered-files initial..master
> -format-patch --inline --stdout initial..master
> -format-patch --inline --stdout --subject-prefix=3DTESTCASE initial..mas=
ter
> +format-patch --inline --stdout initial..main^
> +format-patch --inline --stdout --numbered-files initial..main
> +format-patch --inline --stdout initial..main
> +format-patch --inline --stdout --subject-prefix=3DTESTCASE initial..mai=
n
>  config format.subjectprefix DIFFERENT_PREFIX
> -format-patch --inline --stdout initial..master^^
> -format-patch --stdout --cover-letter -n initial..master^
> +format-patch --inline --stdout initial..main^^
> +format-patch --stdout --cover-letter -n initial..main^
>
>  diff --abbrev initial..side
>  diff -U initial..side
> @@ -412,13 +415,13 @@ diff --name-status dir2 dir
>  diff --no-index --name-status dir2 dir
>  diff --no-index --name-status -- dir2 dir
>  diff --no-index dir dir3
> -diff master master^ side
> +diff main main^ side
>  # Can't use spaces...
> -diff --line-prefix=3Dabc master master^ side
> -diff --dirstat master~1 master~2
> +diff --line-prefix=3Dabc main main^ side
> +diff --dirstat main~1 main~2
>  diff --dirstat initial rearrange
>  diff --dirstat-by-file initial rearrange
> -diff --dirstat --cc master~1 master
> +diff --dirstat --cc main~1 main
>  # No-index --abbrev and --no-abbrev
>  diff --raw initial
>  :noellipses diff --raw initial
> @@ -471,12 +474,12 @@ test_expect_success 'diff-tree --stdin with log fo=
rmatting' '
>  	Third
>  	Second
>  	EOF
> -	git rev-list master | git diff-tree --stdin --format=3D%s -s >actual &=
&
> +	git rev-list main | git diff-tree --stdin --format=3D%s -s >actual &&
>  	test_cmp expect actual
>  '
>
>  test_expect_success 'diff -I<regex>: setup' '
> -	git checkout master &&
> +	git checkout main &&
>  	test_seq 50 >file0 &&
>  	git commit -m "Set up -I<regex> test file" file0 &&
>  	test_seq 50 | sed -e "s/13/ten and three/" -e "/7\$/d" >file0 &&
> diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_mas=
ter b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
> similarity index 86%
> rename from t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_mast=
er
> rename to t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
> index 9951e3677d..af1cf20f4c 100644
> --- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree --cc --patch-with-stat --summary master
> +$ git diff-tree --cc --patch-with-stat --summary main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master b/t/t4=
013/diff.diff-tree_--cc_--patch-with-stat_main
> similarity index 89%
> rename from t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
> rename to t/t4013/diff.diff-tree_--cc_--patch-with-stat_main
> index db3c0a7b2c..0ec6042097 100644
> --- a/t/t4013/diff.diff-tree_--cc_--patch-with-stat_master
> +++ b/t/t4013/diff.diff-tree_--cc_--patch-with-stat_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree --cc --patch-with-stat master
> +$ git diff-tree --cc --patch-with-stat main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.diff-tree_--cc_--shortstat_master b/t/t4013/di=
ff.diff-tree_--cc_--shortstat_main
> similarity index 65%
> rename from t/t4013/diff.diff-tree_--cc_--shortstat_master
> rename to t/t4013/diff.diff-tree_--cc_--shortstat_main
> index a4ca42df2a..9a4ef03197 100644
> --- a/t/t4013/diff.diff-tree_--cc_--shortstat_master
> +++ b/t/t4013/diff.diff-tree_--cc_--shortstat_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree --cc --shortstat master
> +$ git diff-tree --cc --shortstat main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>   2 files changed, 5 insertions(+)
>  $
> diff --git a/t/t4013/diff.diff-tree_-c_--stat_--summary_master b/t/t4013=
/diff.diff-tree_--cc_--stat_--summary_main
> similarity index 71%
> rename from t/t4013/diff.diff-tree_-c_--stat_--summary_master
> rename to t/t4013/diff.diff-tree_--cc_--stat_--summary_main
> index 81c3021541..9db08a4aa9 100644
> --- a/t/t4013/diff.diff-tree_-c_--stat_--summary_master
> +++ b/t/t4013/diff.diff-tree_--cc_--stat_--summary_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree -c --stat --summary master
> +$ git diff-tree --cc --stat --summary main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.diff-tree_-c_--stat_master b/t/t4013/diff.diff=
-tree_--cc_--stat_main
> similarity index 76%
> rename from t/t4013/diff.diff-tree_-c_--stat_master
> rename to t/t4013/diff.diff-tree_--cc_--stat_main
> index 89d59b1548..7ecc67a524 100644
> --- a/t/t4013/diff.diff-tree_-c_--stat_master
> +++ b/t/t4013/diff.diff-tree_--cc_--stat_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree -c --stat master
> +$ git diff-tree --cc --stat main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.diff-tree_--cc_master b/t/t4013/diff.diff-tree=
_--cc_main
> similarity index 91%
> rename from t/t4013/diff.diff-tree_--cc_master
> rename to t/t4013/diff.diff-tree_--cc_main
> index 5ecb4e14ae..1a962856ad 100644
> --- a/t/t4013/diff.diff-tree_--cc_master
> +++ b/t/t4013/diff.diff-tree_--cc_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree --cc master
> +$ git diff-tree --cc main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>  diff --cc dir/sub
>  index cead32e,7289e35..992913c
> diff --git a/t/t4013/diff.diff-tree_-c_--abbrev_master b/t/t4013/diff.di=
ff-tree_-c_--abbrev_main
> similarity index 83%
> rename from t/t4013/diff.diff-tree_-c_--abbrev_master
> rename to t/t4013/diff.diff-tree_-c_--abbrev_main
> index b8e4aa2530..039d127cf2 100644
> --- a/t/t4013/diff.diff-tree_-c_--abbrev_master
> +++ b/t/t4013/diff.diff-tree_-c_--abbrev_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree -c --abbrev master
> +$ git diff-tree -c --abbrev main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>  ::100644 100644 100644 cead32e... 7289e35... 992913c... MM	dir/sub
>  ::100644 100644 100644 b414108... f4615da... 10a8a9f... MM	file0
> diff --git a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master b/t/t40=
13/diff.diff-tree_-c_--stat_--summary_main
> similarity index 70%
> rename from t/t4013/diff.diff-tree_--cc_--stat_--summary_master
> rename to t/t4013/diff.diff-tree_-c_--stat_--summary_main
> index d019867dd9..05a8d16ba7 100644
> --- a/t/t4013/diff.diff-tree_--cc_--stat_--summary_master
> +++ b/t/t4013/diff.diff-tree_-c_--stat_--summary_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree --cc --stat --summary master
> +$ git diff-tree -c --stat --summary main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.diff-tree_--cc_--stat_master b/t/t4013/diff.di=
ff-tree_-c_--stat_main
> similarity index 75%
> rename from t/t4013/diff.diff-tree_--cc_--stat_master
> rename to t/t4013/diff.diff-tree_-c_--stat_main
> index 40b91796b3..61d9f450df 100644
> --- a/t/t4013/diff.diff-tree_--cc_--stat_master
> +++ b/t/t4013/diff.diff-tree_-c_--stat_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree --cc --stat master
> +$ git diff-tree -c --stat main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>   dir/sub | 2 ++
>   file0   | 3 +++
> diff --git a/t/t4013/diff.diff-tree_-c_master b/t/t4013/diff.diff-tree_-=
c_main
> similarity index 93%
> rename from t/t4013/diff.diff-tree_-c_master
> rename to t/t4013/diff.diff-tree_-c_main
> index e2d2bb2611..a84e1185cf 100644
> --- a/t/t4013/diff.diff-tree_-c_master
> +++ b/t/t4013/diff.diff-tree_-c_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree -c master
> +$ git diff-tree -c main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>  ::100644 100644 100644 cead32e925b1420c84c14cbf7cf755e7e45af8ad 7289e35=
bff32727c08dda207511bec138fdb9ea5 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3=
 MM	dir/sub
>  ::100644 100644 100644 b414108e81e5091fe0974a1858b4d0d22b107f70 f4615da=
674c09df322d6ba8d6b21ecfb1b1ba510 10a8a9f3657f91a156b9f0184ed79a20adef9f7f=
 MM	file0
> diff --git a/t/t4013/diff.diff-tree_-p_-m_master b/t/t4013/diff.diff-tre=
e_-p_-m_main
> similarity index 97%
> rename from t/t4013/diff.diff-tree_-p_-m_master
> rename to t/t4013/diff.diff-tree_-p_-m_main
> index b60bea039d..29c9fc20b8 100644
> --- a/t/t4013/diff.diff-tree_-p_-m_master
> +++ b/t/t4013/diff.diff-tree_-p_-m_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree -p -m master
> +$ git diff-tree -p -m main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>  diff --git a/dir/sub b/dir/sub
>  index cead32e..992913c 100644
> diff --git a/t/t4013/diff.diff-tree_-p_main b/t/t4013/diff.diff-tree_-p_=
main
> new file mode 100644
> index 0000000000..c658062422
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_-p_main
> @@ -0,0 +1,2 @@
> +$ git diff-tree -p main
> +$
> diff --git a/t/t4013/diff.diff-tree_-p_master b/t/t4013/diff.diff-tree_-=
p_master
> deleted file mode 100644
> index b182875fb2..0000000000
> --- a/t/t4013/diff.diff-tree_-p_master
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -$ git diff-tree -p master
> -$
> diff --git a/t/t4013/diff.diff-tree_main b/t/t4013/diff.diff-tree_main
> new file mode 100644
> index 0000000000..dc5b9fdeb6
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_main
> @@ -0,0 +1,2 @@
> +$ git diff-tree main
> +$
> diff --git a/t/t4013/diff.diff-tree_master b/t/t4013/diff.diff-tree_mast=
er
> deleted file mode 100644
> index fe9226f8a1..0000000000
> --- a/t/t4013/diff.diff-tree_master
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -$ git diff-tree master
> -$
> diff --git a/t/t4013/diff.diff_--dirstat_--cc_main~1_main b/t/t4013/diff=
.diff_--dirstat_--cc_main~1_main
> new file mode 100644
> index 0000000000..168a357a02
> --- /dev/null
> +++ b/t/t4013/diff.diff_--dirstat_--cc_main~1_main
> @@ -0,0 +1,3 @@
> +$ git diff --dirstat --cc main~1 main
> +  40.0% dir/
> +$
> diff --git a/t/t4013/diff.diff_--dirstat_--cc_master~1_master b/t/t4013/=
diff.diff_--dirstat_--cc_master~1_master
> deleted file mode 100644
> index fba4e34175..0000000000
> --- a/t/t4013/diff.diff_--dirstat_--cc_master~1_master
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -$ git diff --dirstat --cc master~1 master
> -  40.0% dir/
> -$
> diff --git a/t/t4013/diff.diff_--dirstat_main~1_main~2 b/t/t4013/diff.di=
ff_--dirstat_main~1_main~2
> new file mode 100644
> index 0000000000..6809733708
> --- /dev/null
> +++ b/t/t4013/diff.diff_--dirstat_main~1_main~2
> @@ -0,0 +1,3 @@
> +$ git diff --dirstat main~1 main~2
> +  40.0% dir/
> +$
> diff --git a/t/t4013/diff.diff_--dirstat_master~1_master~2 b/t/t4013/dif=
f.diff_--dirstat_master~1_master~2
> deleted file mode 100644
> index b672e1ca63..0000000000
> --- a/t/t4013/diff.diff_--dirstat_master~1_master~2
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -$ git diff --dirstat master~1 master~2
> -  40.0% dir/
> -$
> diff --git a/t/t4013/diff.diff_--line-prefix=3Dabc_master_master^_side b=
/t/t4013/diff.diff_--line-prefix=3Dabc_main_main^_side
> similarity index 87%
> rename from t/t4013/diff.diff_--line-prefix=3Dabc_master_master^_side
> rename to t/t4013/diff.diff_--line-prefix=3Dabc_main_main^_side
> index 99f91e7f0e..67a2145a36 100644
> --- a/t/t4013/diff.diff_--line-prefix=3Dabc_master_master^_side
> +++ b/t/t4013/diff.diff_--line-prefix=3Dabc_main_main^_side
> @@ -1,4 +1,4 @@
> -$ git diff --line-prefix=3Dabc master master^ side
> +$ git diff --line-prefix=3Dabc main main^ side
>  abcdiff --cc dir/sub
>  abcindex cead32e,7289e35..992913c
>  abc--- a/dir/sub
> diff --git a/t/t4013/diff.diff_master_master^_side b/t/t4013/diff.diff_m=
ain_main^_side
> similarity index 89%
> rename from t/t4013/diff.diff_master_master^_side
> rename to t/t4013/diff.diff_main_main^_side
> index 50ec9cadd6..ab81ec9e47 100644
> --- a/t/t4013/diff.diff_master_master^_side
> +++ b/t/t4013/diff.diff_main_main^_side
> @@ -1,4 +1,4 @@
> -$ git diff master master^ side
> +$ git diff main main^ side
>  diff --cc dir/sub
>  index cead32e,7289e35..992913c
>  --- a/dir/sub
> diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master=
 b/t/t4013/diff.format-patch_--attach_--stdout_initial..main
> similarity index 98%
> rename from t/t4013/diff.format-patch_--attach_--stdout_initial..master
> rename to t/t4013/diff.format-patch_--attach_--stdout_initial..main
> index 52fedc179e..9f56380350 100644
> --- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master
> +++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main
> @@ -1,4 +1,4 @@
> -$ git format-patch --attach --stdout initial..master
> +$ git format-patch --attach --stdout initial..main
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--attach_--stdout_initial..master=
^ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main^
> similarity index 97%
> rename from t/t4013/diff.format-patch_--attach_--stdout_initial..master^
> rename to t/t4013/diff.format-patch_--attach_--stdout_initial..main^
> index 1c3cde251b..80132ea99e 100644
> --- a/t/t4013/diff.format-patch_--attach_--stdout_initial..master^
> +++ b/t/t4013/diff.format-patch_--attach_--stdout_initial..main^
> @@ -1,4 +1,4 @@
> -$ git format-patch --attach --stdout initial..master^
> +$ git format-patch --attach --stdout initial..main^
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-file=
s_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--numbered=
-files_initial..main
> similarity index 99%
> rename from t/t4013/diff.format-patch_--inline_--stdout_--numbered-files=
_initial..master
> rename to t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_i=
nitial..main
> index 02c4db7ec5..8e889090fb 100644
> --- a/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initi=
al..master
> +++ b/t/t4013/diff.format-patch_--inline_--stdout_--numbered-files_initi=
al..main
> @@ -1,4 +1,4 @@
> -$ git format-patch --inline --stdout --numbered-files initial..master
> +$ git format-patch --inline --stdout --numbered-files initial..main
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefi=
x=3DTESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--stdout=
_--subject-prefix=3DTESTCASE_initial..main
> similarity index 99%
> rename from t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=
=3DTESTCASE_initial..master
> rename to t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=
=3DTESTCASE_initial..main
> index c7677c5951..d7d2b12d15 100644
> --- a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTES=
TCASE_initial..master
> +++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTES=
TCASE_initial..main
> @@ -1,4 +1,4 @@
> -$ git format-patch --inline --stdout --subject-prefix=3DTESTCASE initia=
l..master
> +$ git format-patch --inline --stdout --subject-prefix=3DTESTCASE initia=
l..main
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master=
 b/t/t4013/diff.format-patch_--inline_--stdout_initial..main
> similarity index 98%
> rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master
> rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main
> index 5b3e34e2c0..c49c423f82 100644
> --- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master
> +++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main
> @@ -1,4 +1,4 @@
> -$ git format-patch --inline --stdout initial..master
> +$ git format-patch --inline --stdout initial..main
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master=
^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^
> similarity index 97%
> rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master^
> rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main^
> index d13f8a8128..8669dbfe6c 100644
> --- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^
> +++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^
> @@ -1,4 +1,4 @@
> -$ git format-patch --inline --stdout initial..master^
> +$ git format-patch --inline --stdout initial..main^
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--inline_--stdout_initial..master=
^^ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
> similarity index 95%
> rename from t/t4013/diff.format-patch_--inline_--stdout_initial..master^=
^
> rename to t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
> index caec5537de..b749be58b0 100644
> --- a/t/t4013/diff.format-patch_--inline_--stdout_initial..master^^
> +++ b/t/t4013/diff.format-patch_--inline_--stdout_initial..main^^
> @@ -1,4 +1,4 @@
> -$ git format-patch --inline --stdout initial..master^^
> +$ git format-patch --inline --stdout initial..main^^
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initia=
l..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial.=
.main^
> similarity index 96%
> rename from t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial=
..master^
> rename to t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..=
main^
> index 244d964fc6..567f222198 100644
> --- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..mast=
er^
> +++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main=
^
> @@ -1,4 +1,4 @@
> -$ git format-patch --stdout --cover-letter -n initial..master^
> +$ git format-patch --stdout --cover-letter -n initial..main^
>  From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
>  From: C O Mitter <committer@example.com>
>  Date: Mon, 26 Jun 2006 00:06:00 +0000
> diff --git a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..m=
aster b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
> similarity index 97%
> rename from t/t4013/diff.format-patch_--stdout_--no-numbered_initial..ma=
ster
> rename to t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
> index bfc287a147..195b62ea4f 100644
> --- a/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..master
> +++ b/t/t4013/diff.format-patch_--stdout_--no-numbered_initial..main
> @@ -1,4 +1,4 @@
> -$ git format-patch --stdout --no-numbered initial..master
> +$ git format-patch --stdout --no-numbered initial..main
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--stdout_--numbered_initial..mast=
er b/t/t4013/diff.format-patch_--stdout_--numbered_initial..main
> similarity index 97%
> rename from t/t4013/diff.format-patch_--stdout_--numbered_initial..maste=
r
> rename to t/t4013/diff.format-patch_--stdout_--numbered_initial..main
> index 568f6f584e..0678a38515 100644
> --- a/t/t4013/diff.format-patch_--stdout_--numbered_initial..master
> +++ b/t/t4013/diff.format-patch_--stdout_--numbered_initial..main
> @@ -1,4 +1,4 @@
> -$ git format-patch --stdout --numbered initial..master
> +$ git format-patch --stdout --numbered initial..main
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--stdout_initial..master b/t/t401=
3/diff.format-patch_--stdout_initial..main
> similarity index 97%
> rename from t/t4013/diff.format-patch_--stdout_initial..master
> rename to t/t4013/diff.format-patch_--stdout_initial..main
> index 5f0352f9f7..b4a6302e7c 100644
> --- a/t/t4013/diff.format-patch_--stdout_initial..master
> +++ b/t/t4013/diff.format-patch_--stdout_initial..main
> @@ -1,4 +1,4 @@
> -$ git format-patch --stdout initial..master
> +$ git format-patch --stdout initial..main
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.format-patch_--stdout_initial..master^ b/t/t40=
13/diff.format-patch_--stdout_initial..main^
> similarity index 96%
> rename from t/t4013/diff.format-patch_--stdout_initial..master^
> rename to t/t4013/diff.format-patch_--stdout_initial..main^
> index 2ae454d807..36b3221582 100644
> --- a/t/t4013/diff.format-patch_--stdout_initial..master^
> +++ b/t/t4013/diff.format-patch_--stdout_initial..main^
> @@ -1,4 +1,4 @@
> -$ git format-patch --stdout initial..master^
> +$ git format-patch --stdout initial..main^
>  From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
>  From: A U Thor <author@example.com>
>  Date: Mon, 26 Jun 2006 00:01:00 +0000
> diff --git a/t/t4013/diff.log_--decorate=3Dfull_--all b/t/t4013/diff.log=
_--decorate=3Dfull_--all
> index 3f9b872ece..7cfd2ea22d 100644
> --- a/t/t4013/diff.log_--decorate=3Dfull_--all
> +++ b/t/t4013/diff.log_--decorate=3Dfull_--all
> @@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
>
>      Notes added by 'git notes add'
>
> -commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/mas=
ter)
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/mai=
n)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
> diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--deco=
rate_--all
> index f5e20e1e14..735f1aa83c 100644
> --- a/t/t4013/diff.log_--decorate_--all
> +++ b/t/t4013/diff.log_--decorate_--all
> @@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
>
>      Notes added by 'git notes add'
>
> -commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> main)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:04:00 2006 +0000
> diff --git a/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master =
b/t/t4013/diff.log_--diff-merges=3Doff_-p_--first-parent_main
> similarity index 95%
> rename from t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master
> rename to t/t4013/diff.log_--diff-merges=3Doff_-p_--first-parent_main
> index 597002232e..fe180fda3b 100644
> --- a/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_master
> +++ b/t/t4013/diff.log_--diff-merges=3Doff_-p_--first-parent_main
> @@ -1,4 +1,4 @@
> -$ git log --no-diff-merges -p --first-parent master
> +$ git log --diff-merges=3Doff -p --first-parent main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--first-parent_--diff-merges=3Doff_-p_mast=
er b/t/t4013/diff.log_--first-parent_--diff-merges=3Doff_-p_main
> similarity index 95%
> rename from t/t4013/diff.log_--first-parent_--diff-merges=3Doff_-p_maste=
r
> rename to t/t4013/diff.log_--first-parent_--diff-merges=3Doff_-p_main
> index 5d7461a167..dca62d4e60 100644
> --- a/t/t4013/diff.log_--first-parent_--diff-merges=3Doff_-p_master
> +++ b/t/t4013/diff.log_--first-parent_--diff-merges=3Doff_-p_main
> @@ -1,4 +1,4 @@
> -$ git log --first-parent --diff-merges=3Doff -p master
> +$ git log --first-parent --diff-merges=3Doff -p main
>  commit 80e25ffa65bcdbe82ef654b4d06dbbde7945c37f
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--diff-merges=3Doff_-p_--first-parent_mast=
er b/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
> similarity index 95%
> rename from t/t4013/diff.log_--diff-merges=3Doff_-p_--first-parent_maste=
r
> rename to t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
> index 194e893c94..0b54118088 100644
> --- a/t/t4013/diff.log_--diff-merges=3Doff_-p_--first-parent_master
> +++ b/t/t4013/diff.log_--no-diff-merges_-p_--first-parent_main
> @@ -1,4 +1,4 @@
> -$ git log --diff-merges=3Doff -p --first-parent master
> +$ git log --no-diff-merges -p --first-parent main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_=
 b/t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
> similarity index 96%
> rename from t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
> rename to t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
> index a18f1472a9..3ed46cc867 100644
> --- a/t/t4013/diff.log_--patch-with-stat_--summary_master_--_dir_
> +++ b/t/t4013/diff.log_--patch-with-stat_--summary_main_--_dir_
> @@ -1,4 +1,4 @@
> -$ git log --patch-with-stat --summary master -- dir/
> +$ git log --patch-with-stat --summary main -- dir/
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--patch-with-stat_master b/t/t4013/diff.lo=
g_--patch-with-stat_main
> similarity index 98%
> rename from t/t4013/diff.log_--patch-with-stat_master
> rename to t/t4013/diff.log_--patch-with-stat_main
> index ae425c4672..2e12b557cb 100644
> --- a/t/t4013/diff.log_--patch-with-stat_master
> +++ b/t/t4013/diff.log_--patch-with-stat_main
> @@ -1,4 +1,4 @@
> -$ git log --patch-with-stat master
> +$ git log --patch-with-stat main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--patch-with-stat_master_--_dir_ b/t/t4013=
/diff.log_--patch-with-stat_main_--_dir_
> similarity index 96%
> rename from t/t4013/diff.log_--patch-with-stat_master_--_dir_
> rename to t/t4013/diff.log_--patch-with-stat_main_--_dir_
> index d5207cadf4..d511ea7f6b 100644
> --- a/t/t4013/diff.log_--patch-with-stat_master_--_dir_
> +++ b/t/t4013/diff.log_--patch-with-stat_main_--_dir_
> @@ -1,4 +1,4 @@
> -$ git log --patch-with-stat master -- dir/
> +$ git log --patch-with-stat main -- dir/
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_ma=
ster b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
> similarity index 98%
> rename from t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_mas=
ter
> rename to t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
> index 0fc1e8cd71..3cfd0e6422 100644
> --- a/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.log_--root_--cc_--patch-with-stat_--summary_main
> @@ -1,4 +1,4 @@
> -$ git log --root --cc --patch-with-stat --summary master
> +$ git log --root --cc --patch-with-stat --summary main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master =
b/t/t4013/diff.log_--root_--patch-with-stat_--summary_main
> similarity index 98%
> rename from t/t4013/diff.log_--root_--patch-with-stat_--summary_master
> rename to t/t4013/diff.log_--root_--patch-with-stat_--summary_main
> index dffc09dde9..9f4d6dfa44 100644
> --- a/t/t4013/diff.log_--root_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.log_--root_--patch-with-stat_--summary_main
> @@ -1,4 +1,4 @@
> -$ git log --root --patch-with-stat --summary master
> +$ git log --root --patch-with-stat --summary main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_--patch-with-stat_master b/t/t4013/=
diff.log_--root_--patch-with-stat_main
> similarity index 98%
> rename from t/t4013/diff.log_--root_--patch-with-stat_master
> rename to t/t4013/diff.log_--root_--patch-with-stat_main
> index 55aa98012d..0d69ae2e11 100644
> --- a/t/t4013/diff.log_--root_--patch-with-stat_master
> +++ b/t/t4013/diff.log_--root_--patch-with-stat_main
> @@ -1,4 +1,4 @@
> -$ git log --root --patch-with-stat master
> +$ git log --root --patch-with-stat main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_mast=
er b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
> similarity index 98%
> rename from t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_maste=
r
> rename to t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
> index 019d85f7de..1b71add9de 100644
> --- a/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.log_--root_-c_--patch-with-stat_--summary_main
> @@ -1,4 +1,4 @@
> -$ git log --root -c --patch-with-stat --summary master
> +$ git log --root -c --patch-with-stat --summary main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_-p_master b/t/t4013/diff.log_--root=
_-p_main
> similarity index 98%
> rename from t/t4013/diff.log_--root_-p_master
> rename to t/t4013/diff.log_--root_-p_main
> index b42c334439..04581296ed 100644
> --- a/t/t4013/diff.log_--root_-p_master
> +++ b/t/t4013/diff.log_--root_-p_main
> @@ -1,4 +1,4 @@
> -$ git log --root -p master
> +$ git log --root -p main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--root_master b/t/t4013/diff.log_--root_ma=
in
> similarity index 96%
> rename from t/t4013/diff.log_--root_master
> rename to t/t4013/diff.log_--root_main
> index e8f46159da..d5e90fd6b4 100644
> --- a/t/t4013/diff.log_--root_master
> +++ b/t/t4013/diff.log_--root_main
> @@ -1,4 +1,4 @@
> -$ git log --root master
> +$ git log --root main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_-GF_-p_--pickaxe-all_master b/t/t4013/diff=
.log_-GF_-p_--pickaxe-all_main
> similarity index 90%
> rename from t/t4013/diff.log_-GF_-p_--pickaxe-all_master
> rename to t/t4013/diff.log_-GF_-p_--pickaxe-all_main
> index d36f88098b..1f7a497c2d 100644
> --- a/t/t4013/diff.log_-GF_-p_--pickaxe-all_master
> +++ b/t/t4013/diff.log_-GF_-p_--pickaxe-all_main
> @@ -1,4 +1,4 @@
> -$ git log -GF -p --pickaxe-all master
> +$ git log -GF -p --pickaxe-all main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.log_-GF_-p_master b/t/t4013/diff.log_-GF_-p_ma=
in
> similarity index 91%
> rename from t/t4013/diff.log_-GF_-p_master
> rename to t/t4013/diff.log_-GF_-p_main
> index 9d93f2c23a..c80dda41e9 100644
> --- a/t/t4013/diff.log_-GF_-p_master
> +++ b/t/t4013/diff.log_-GF_-p_main
> @@ -1,4 +1,4 @@
> -$ git log -GF -p master
> +$ git log -GF -p main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.log_-SF_master b/t/t4013/diff.log_-GF_main
> similarity index 86%
> rename from t/t4013/diff.log_-SF_master
> rename to t/t4013/diff.log_-GF_main
> index c1599f2f52..b94a7f7839 100644
> --- a/t/t4013/diff.log_-SF_master
> +++ b/t/t4013/diff.log_-GF_main
> @@ -1,4 +1,4 @@
> -$ git log -SF master
> +$ git log -GF main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_master b/t/t4013/diff.l=
og_-IA_-IB_-I1_-I2_-p_main
> similarity index 97%
> rename from t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_master
> rename to t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_main
> index 929f35a05b..67e26b4e54 100644
> --- a/t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_master
> +++ b/t/t4013/diff.log_-IA_-IB_-I1_-I2_-p_main
> @@ -1,4 +1,4 @@
> -$ git log -IA -IB -I1 -I2 -p master
> +$ git log -IA -IB -I1 -I2 -p main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_-SF_-p_master b/t/t4013/diff.log_-SF_-p_ma=
in
> similarity index 91%
> rename from t/t4013/diff.log_-SF_-p_master
> rename to t/t4013/diff.log_-SF_-p_main
> index 5e32438972..fa82ac1490 100644
> --- a/t/t4013/diff.log_-SF_-p_master
> +++ b/t/t4013/diff.log_-SF_-p_main
> @@ -1,4 +1,4 @@
> -$ git log -SF -p master
> +$ git log -SF -p main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.log_-GF_master b/t/t4013/diff.log_-SF_main
> similarity index 86%
> rename from t/t4013/diff.log_-GF_master
> rename to t/t4013/diff.log_-SF_main
> index 4c6708d2d0..dbf770db49 100644
> --- a/t/t4013/diff.log_-GF_master
> +++ b/t/t4013/diff.log_-SF_main
> @@ -1,4 +1,4 @@
> -$ git log -GF master
> +$ git log -SF main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.log_-SF_main_--max-count=3D0 b/t/t4013/diff.lo=
g_-SF_main_--max-count=3D0
> new file mode 100644
> index 0000000000..683b17eb99
> --- /dev/null
> +++ b/t/t4013/diff.log_-SF_main_--max-count=3D0
> @@ -0,0 +1,2 @@
> +$ git log -SF main --max-count=3D0
> +$
> diff --git a/t/t4013/diff.log_-SF_master_--max-count=3D2 b/t/t4013/diff.=
log_-SF_main_--max-count=3D1
> similarity index 79%
> rename from t/t4013/diff.log_-SF_master_--max-count=3D2
> rename to t/t4013/diff.log_-SF_main_--max-count=3D1
> index a6c55fd482..2102426f8c 100644
> --- a/t/t4013/diff.log_-SF_master_--max-count=3D2
> +++ b/t/t4013/diff.log_-SF_main_--max-count=3D1
> @@ -1,4 +1,4 @@
> -$ git log -SF master --max-count=3D2
> +$ git log -SF main --max-count=3D1
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.log_-SF_main_--max-count=3D2 b/t/t4013/diff.lo=
g_-SF_main_--max-count=3D2
> new file mode 100644
> index 0000000000..23e12a4cbb
> --- /dev/null
> +++ b/t/t4013/diff.log_-SF_main_--max-count=3D2
> @@ -0,0 +1,7 @@
> +$ git log -SF main --max-count=3D2
> +commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:02:00 2006 +0000
> +
> +    Third
> +$
> diff --git a/t/t4013/diff.log_-SF_master_--max-count=3D0 b/t/t4013/diff.=
log_-SF_master_--max-count=3D0
> deleted file mode 100644
> index c1fc6c8731..0000000000
> --- a/t/t4013/diff.log_-SF_master_--max-count=3D0
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -$ git log -SF master --max-count=3D0
> -$
> diff --git a/t/t4013/diff.log_-SF_master_--max-count=3D1 b/t/t4013/diff.=
log_-SF_master_--max-count=3D1
> deleted file mode 100644
> index c981a03814..0000000000
> --- a/t/t4013/diff.log_-SF_master_--max-count=3D1
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -$ git log -SF master --max-count=3D1
> -commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
> -Author: A U Thor <author@example.com>
> -Date:   Mon Jun 26 00:02:00 2006 +0000
> -
> -    Third
> -$
> diff --git a/t/t4013/diff.log_-S_F_master b/t/t4013/diff.log_-S_F_main
> similarity index 86%
> rename from t/t4013/diff.log_-S_F_master
> rename to t/t4013/diff.log_-S_F_main
> index 978d2b4118..a75a42e143 100644
> --- a/t/t4013/diff.log_-S_F_master
> +++ b/t/t4013/diff.log_-S_F_main
> @@ -1,4 +1,4 @@
> -$ git log -S F master
> +$ git log -S F main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.log_-m_-p_--first-parent_master b/t/t4013/diff=
.log_-m_-p_--first-parent_main
> similarity index 97%
> rename from t/t4013/diff.log_-m_-p_--first-parent_master
> rename to t/t4013/diff.log_-m_-p_--first-parent_main
> index 7a0073f529..459e10786b 100644
> --- a/t/t4013/diff.log_-m_-p_--first-parent_master
> +++ b/t/t4013/diff.log_-m_-p_--first-parent_main
> @@ -1,4 +1,4 @@
> -$ git log -m -p --first-parent master
> +$ git log -m -p --first-parent main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_-m_-p_master b/t/t4013/diff.log_-m_-p_main
> similarity index 99%
> rename from t/t4013/diff.log_-m_-p_master
> rename to t/t4013/diff.log_-m_-p_main
> index 9ca62a01ed..07453c5698 100644
> --- a/t/t4013/diff.log_-m_-p_master
> +++ b/t/t4013/diff.log_-m_-p_main
> @@ -1,4 +1,4 @@
> -$ git log -m -p master
> +$ git log -m -p main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d=
9d5e26f2791ec2ceff5fdc0)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.lo=
g_-p_--first-parent_main
> similarity index 97%
> rename from t/t4013/diff.log_-p_--first-parent_master
> rename to t/t4013/diff.log_-p_--first-parent_main
> index 28840ebea1..247980817b 100644
> --- a/t/t4013/diff.log_-p_--first-parent_master
> +++ b/t/t4013/diff.log_-p_--first-parent_main
> @@ -1,4 +1,4 @@
> -$ git log -p --first-parent master
> +$ git log -p --first-parent main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_-p_master b/t/t4013/diff.log_-p_main
> similarity index 98%
> rename from t/t4013/diff.log_-p_master
> rename to t/t4013/diff.log_-p_main
> index bf1326dc36..c82b4dbf16 100644
> --- a/t/t4013/diff.log_-p_master
> +++ b/t/t4013/diff.log_-p_main
> @@ -1,4 +1,4 @@
> -$ git log -p master
> +$ git log -p main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_master b/t/t4013/diff.log_main
> similarity index 97%
> rename from t/t4013/diff.log_master
> rename to t/t4013/diff.log_main
> index a8f6ce5abd..50401f73e6 100644
> --- a/t/t4013/diff.log_master
> +++ b/t/t4013/diff.log_main
> @@ -1,4 +1,4 @@
> -$ git log master
> +$ git log main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master b/t/t4=
013/diff.noellipses-diff-tree_-c_--abbrev_main
> similarity index 81%
> rename from t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
> rename to t/t4013/diff.noellipses-diff-tree_-c_--abbrev_main
> index bb80f013b3..3aa1f80af3 100644
> --- a/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_master
> +++ b/t/t4013/diff.noellipses-diff-tree_-c_--abbrev_main
> @@ -1,4 +1,4 @@
> -$ git diff-tree -c --abbrev master
> +$ git diff-tree -c --abbrev main
>  59d314ad6f356dd08601a4cd5e530381da3e3c64
>  ::100644 100644 100644 cead32e 7289e35 992913c MM	dir/sub
>  ::100644 100644 100644 b414108 f4615da 10a8a9f MM	file0
> diff --git a/t/t4013/diff.noellipses-whatchanged_--root_master b/t/t4013=
/diff.noellipses-whatchanged_--root_main
> similarity index 96%
> rename from t/t4013/diff.noellipses-whatchanged_--root_master
> rename to t/t4013/diff.noellipses-whatchanged_--root_main
> index c2cfd4e729..2bec055835 100644
> --- a/t/t4013/diff.noellipses-whatchanged_--root_master
> +++ b/t/t4013/diff.noellipses-whatchanged_--root_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged --root master
> +$ git whatchanged --root main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.noellipses-whatchanged_-SF_master b/t/t4013/di=
ff.noellipses-whatchanged_-SF_main
> similarity index 86%
> rename from t/t4013/diff.noellipses-whatchanged_-SF_master
> rename to t/t4013/diff.noellipses-whatchanged_-SF_main
> index b36ce5886e..0c1476d19e 100644
> --- a/t/t4013/diff.noellipses-whatchanged_-SF_master
> +++ b/t/t4013/diff.noellipses-whatchanged_-SF_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged -SF master
> +$ git whatchanged -SF main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.noellipses-whatchanged_master b/t/t4013/diff.n=
oellipses-whatchanged_main
> similarity index 96%
> rename from t/t4013/diff.noellipses-whatchanged_master
> rename to t/t4013/diff.noellipses-whatchanged_main
> index 55e500f2ed..c48d2851aa 100644
> --- a/t/t4013/diff.noellipses-whatchanged_master
> +++ b/t/t4013/diff.noellipses-whatchanged_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged master
> +$ git whatchanged main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.show_--first-parent_master b/t/t4013/diff.show=
_--first-parent_main
> similarity index 92%
> rename from t/t4013/diff.show_--first-parent_master
> rename to t/t4013/diff.show_--first-parent_main
> index 3dcbe473a0..480502d65c 100644
> --- a/t/t4013/diff.show_--first-parent_master
> +++ b/t/t4013/diff.show_--first-parent_main
> @@ -1,4 +1,4 @@
> -$ git show --first-parent master
> +$ git show --first-parent main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.show_-c_master b/t/t4013/diff.show_-c_main
> similarity index 95%
> rename from t/t4013/diff.show_-c_master
> rename to t/t4013/diff.show_-c_main
> index 81aba8da96..74ef8bc96b 100644
> --- a/t/t4013/diff.show_-c_master
> +++ b/t/t4013/diff.show_-c_main
> @@ -1,4 +1,4 @@
> -$ git show -c master
> +$ git show -c main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.show_-m_master b/t/t4013/diff.show_-m_main
> similarity index 98%
> rename from t/t4013/diff.show_-m_master
> rename to t/t4013/diff.show_-m_main
> index 4ea2ee453d..8fd56736d9 100644
> --- a/t/t4013/diff.show_-m_master
> +++ b/t/t4013/diff.show_-m_main
> @@ -1,4 +1,4 @@
> -$ git show -m master
> +$ git show -m main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (from 9a6d4949b6b76956d=
9d5e26f2791ec2ceff5fdc0)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.show_master b/t/t4013/diff.show_main
> similarity index 96%
> rename from t/t4013/diff.show_master
> rename to t/t4013/diff.show_main
> index fb08ce0e46..630b52a95e 100644
> --- a/t/t4013/diff.show_master
> +++ b/t/t4013/diff.show_main
> @@ -1,4 +1,4 @@
> -$ git show master
> +$ git show main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master=
_--_dir_ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_di=
r_
> similarity index 94%
> rename from t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_=
--_dir_
> rename to t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_d=
ir_
> index c8b6af2f43..ce0754d556 100644
> --- a/t/t4013/diff.whatchanged_--patch-with-stat_--summary_master_--_dir=
_
> +++ b/t/t4013/diff.whatchanged_--patch-with-stat_--summary_main_--_dir_
> @@ -1,4 +1,4 @@
> -$ git whatchanged --patch-with-stat --summary master -- dir/
> +$ git whatchanged --patch-with-stat --summary main -- dir/
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master b/t/t4013=
/diff.whatchanged_--patch-with-stat_main
> similarity index 97%
> rename from t/t4013/diff.whatchanged_--patch-with-stat_master
> rename to t/t4013/diff.whatchanged_--patch-with-stat_main
> index 1ac431ba92..aabccf39a5 100644
> --- a/t/t4013/diff.whatchanged_--patch-with-stat_master
> +++ b/t/t4013/diff.whatchanged_--patch-with-stat_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged --patch-with-stat master
> +$ git whatchanged --patch-with-stat main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_ b=
/t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
> similarity index 94%
> rename from t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
> rename to t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
> index b30c28588f..c05a0e8149 100644
> --- a/t/t4013/diff.whatchanged_--patch-with-stat_master_--_dir_
> +++ b/t/t4013/diff.whatchanged_--patch-with-stat_main_--_dir_
> @@ -1,4 +1,4 @@
> -$ git whatchanged --patch-with-stat master -- dir/
> +$ git whatchanged --patch-with-stat main -- dir/
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--su=
mmary_master b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--su=
mmary_main
> similarity index 97%
> rename from t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--sum=
mary_master
> rename to t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summa=
ry_main
> index 30aae7817b..1f74b1b548 100644
> --- a/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_m=
aster
> +++ b/t/t4013/diff.whatchanged_--root_--cc_--patch-with-stat_--summary_m=
ain
> @@ -1,4 +1,4 @@
> -$ git whatchanged --root --cc --patch-with-stat --summary master
> +$ git whatchanged --root --cc --patch-with-stat --summary main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary=
_master b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_main
> similarity index 97%
> rename from t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_=
master
> rename to t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_ma=
in
> index db90e51525..80d9812151 100644
> --- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_master
> +++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_--summary_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged --root --patch-with-stat --summary master
> +$ git whatchanged --root --patch-with-stat --summary main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master b/=
t/t4013/diff.whatchanged_--root_--patch-with-stat_main
> similarity index 97%
> rename from t/t4013/diff.whatchanged_--root_--patch-with-stat_master
> rename to t/t4013/diff.whatchanged_--root_--patch-with-stat_main
> index 9a6cc92ce7..c0b9082a2c 100644
> --- a/t/t4013/diff.whatchanged_--root_--patch-with-stat_master
> +++ b/t/t4013/diff.whatchanged_--root_--patch-with-stat_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged --root --patch-with-stat master
> +$ git whatchanged --root --patch-with-stat main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summ=
ary_master b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summar=
y_main
> similarity index 97%
> rename from t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summa=
ry_master
> rename to t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary=
_main
> index d1d32bd34c..0002c6912e 100644
> --- a/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_mas=
ter
> +++ b/t/t4013/diff.whatchanged_--root_-c_--patch-with-stat_--summary_mai=
n
> @@ -1,4 +1,4 @@
> -$ git whatchanged --root -c --patch-with-stat --summary master
> +$ git whatchanged --root -c --patch-with-stat --summary main
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.whatchanged_--root_-p_master b/t/t4013/diff.wh=
atchanged_--root_-p_main
> similarity index 98%
> rename from t/t4013/diff.whatchanged_--root_-p_master
> rename to t/t4013/diff.whatchanged_--root_-p_main
> index ebf1f0661e..39f3e2be74 100644
> --- a/t/t4013/diff.whatchanged_--root_-p_master
> +++ b/t/t4013/diff.whatchanged_--root_-p_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged --root -p master
> +$ git whatchanged --root -p main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_--root_master b/t/t4013/diff.whatc=
hanged_--root_main
> similarity index 97%
> rename from t/t4013/diff.whatchanged_--root_master
> rename to t/t4013/diff.whatchanged_--root_main
> index a405cb6138..36f4d6697f 100644
> --- a/t/t4013/diff.whatchanged_--root_master
> +++ b/t/t4013/diff.whatchanged_--root_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged --root master
> +$ git whatchanged --root main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_-SF_-p_master b/t/t4013/diff.whatc=
hanged_-SF_-p_main
> similarity index 89%
> rename from t/t4013/diff.whatchanged_-SF_-p_master
> rename to t/t4013/diff.whatchanged_-SF_-p_main
> index f39da84822..0e2e67c0df 100644
> --- a/t/t4013/diff.whatchanged_-SF_-p_master
> +++ b/t/t4013/diff.whatchanged_-SF_-p_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged -SF -p master
> +$ git whatchanged -SF -p main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_-SF_master b/t/t4013/diff.whatchan=
ged_-SF_main
> similarity index 86%
> rename from t/t4013/diff.whatchanged_-SF_master
> rename to t/t4013/diff.whatchanged_-SF_main
> index 0499321d0e..34c6bf6b95 100644
> --- a/t/t4013/diff.whatchanged_-SF_master
> +++ b/t/t4013/diff.whatchanged_-SF_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged -SF master
> +$ git whatchanged -SF main
>  commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:02:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_-p_master b/t/t4013/diff.whatchang=
ed_-p_main
> similarity index 98%
> rename from t/t4013/diff.whatchanged_-p_master
> rename to t/t4013/diff.whatchanged_-p_main
> index f18d43209c..18f3bdeef4 100644
> --- a/t/t4013/diff.whatchanged_-p_master
> +++ b/t/t4013/diff.whatchanged_-p_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged -p master
> +$ git whatchanged -p main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
> diff --git a/t/t4013/diff.whatchanged_master b/t/t4013/diff.whatchanged_=
main
> similarity index 97%
> rename from t/t4013/diff.whatchanged_master
> rename to t/t4013/diff.whatchanged_main
> index cd3bcc2c72..d6c83ed8b0 100644
> --- a/t/t4013/diff.whatchanged_master
> +++ b/t/t4013/diff.whatchanged_main
> @@ -1,4 +1,4 @@
> -$ git whatchanged master
> +$ git whatchanged main
>  commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:03:00 2006 +0000
>
> base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
> --
> gitgitgadget
>
