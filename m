Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CFAC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CFB20B1F
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZTIEkP9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgHNMNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:13:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:34025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgHNMM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597407176;
        bh=gsEXP5u5o0PgB5RKEQMODv0WX1oLFVTTtLMu3fD/iRM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZTIEkP9GmH0g3jaowSMwLlzh1RCXsD/aj4VNXRKmu0k04+v8WJwTdsBlJlR6SxnI7
         uedjCwTrreeOt6yK6O/QswFyAAXO55GxZ+rjTp+BuoMGE55UP/rkZCO6J+ylhmUcuq
         m+zaC2XC0q9Fbs78TAfMKVHHqU7z2GG8VhEQfptE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.231.116] ([89.1.213.40]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHs0-1kz3o21oja-00toN7; Fri, 14
 Aug 2020 14:12:56 +0200
Date:   Fri, 14 Aug 2020 14:12:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] sequencer: avoid garbled merge machinery messages
 due to commit labels
In-Reply-To: <pull.828.v2.git.git.1597243205137.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008141412370.54@tvgsbejvaqbjf.bet>
References: <pull.828.git.git.1596654345718.gitgitgadget@gmail.com> <pull.828.v2.git.git.1597243205137.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dxzAl7BIoL4H+Gxu2WG50PbQRJlcfThhbbmgXlTK3fFf68XTRoj
 npAN89hBheJyWQJtirDnvuBHpPpiePHBxXGExHYfqgP02SJ6isWXYUG1ZB3mXx8BNzVyTIn
 6okjQrnq00OEQrdHyQuOWawCLrzDbpnhNoEg1FPk6CJcHTo4m5aPWMQ90spkqxJKU6El61z
 9J9qOZ8/LCdmaaWD6zrJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ngqWI2fz43c=:SG/DxXzsJPWNKjtBho1RZ7
 A/CnW1PIGr/VlksqU7IGUryYYycbQRmq7oZfQ55p0MZQu/eNfmWxVOioU11MlJw+ccCPWEVhS
 1IfpeXX8iPsx/3qU3q4Hoqc2pbgDIreSkuoCQnt7qeBArVY04nDb7g+2wY1TdrCUqec8YQsWq
 PzQjOQaZLHzTPDKfMBXhRDi8YfsMVt0ddQmbrzvf53jIM8S314KQ01kSxKGA1LpnWH1p9XNDw
 ZSMGW8YoVsPLug3SUZEvT4PV5WvxSt0vCJVc3NTeR+R5I7eqTlWPnA9QRc1XkpTvDwM4Ywp+n
 wiw8NNqUMFVreGq5bPC4EDilpUYyVG6sRlVYrE7meOKcZJoTUazQHxoNbnFM+MEjNzK1lZrHV
 GjU6A9vx79yX2SoXQ2GxLZEeAgAdxaJ7IuSYRV8N9Jaearm+6QFJWFMDv0CQUQ28KmhHe7AlV
 /eYJazYBm6e9EMZDYKeYssIkIzyNptw4e/CRLs4yIBnPTP11+vHeu33yamXOGEEOkI0rIXt4i
 4ii8GsvD2grSL+e0fBj7+DqOu5UAILBxwBSQGQcjvVc3rwKMyY6DTmoXu49qlY17jEkVJr2tA
 I7CXLJvCxpN2Yyxyz7+f3lurg5D1WjVPOWVFwvncJx6ooxq9opY0TWeebu+IY6nbBr8ekk4FW
 hbFATHqo7DkyTV4l0PdFSVLkD2hEtgPz4Sk6wlU0IGFYnpGUNf9V5vKEbzMm2cqmD+UjH/7HZ
 yyhIZ1Yqxw5epLHBXzA3+4KI7W5vCkQ05SWg5CZNLY1abu52Wc68k+m+LpqxPJEfp5Cpi3b21
 virUD7kCnvGH48HxzcuGrftSfV0HphUeVq2ec2hSSY+4FY+0qutTr1Z0LIK576IzSv0Qhtq2F
 CUXVPRGSQVaeQGn5bz6JEwjskijmgYFPUy6q47+Uqz0VOGTStssbpt4lbdsKfz/fXLxUIqNL+
 7li4dvM9jdcLYOSfZ2CeJzUhHOvQGd7QvcrXIYyJDnv7WEw4p2pSSVcpH/t1l4jKjzbMZEdmY
 M/qT/TfgA6BcjoT5xBjO8iTi2FqJ2vwWT55n1xc/JknbFqEB36/EPaMh1ZC0hHm+WoVnA0+S8
 e5siRlxpjAMHM2T8v2dWFafCtVOrQGyUPiPxn1DYfHXCOn+uCca951GeGuxBpwNFUeWDj4DyQ
 f2X4H26gHmRNjuc6f/494VuZw/JKKk7xOOiOZCp7KkWiLk8FN54zWkofD0NmOcKcfY34udKqe
 UaDdmOHpz94F+62gACIwpzMaLlkfBWOg2KPXyyg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 12 Aug 2020, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> sequencer's get_message() exists to provide good labels on conflict
> hunks; see commits
>   d68565402a ("revert: clarify label on conflict hunks", 2010-03-20)
>   bf975d379d ("cherry-pick, revert: add a label for ancestor", 2010-03-2=
0)
>   043a4492b3 ("sequencer: factor code out of revert builtin", 2012-01-11=
).
> for background on this function.  These labels are of the form
>   <commitID>... <commit summary>
> or
>   parent of <commitID>... <commit summary>
> These labels are then passed as branch names to the merge machinery.
> However, these labels, as formatted, often also serve to confuse.  For
> example, if we have a rename involved in a content merge, then it
> results in text such as the following:
>
>     <<<<<<<< HEAD:foo.c
>       int j;
>     =3D=3D=3D=3D=3D=3D=3D=3D
>       int counter;
>     >>>>>>>> b01dface... Removed unnecessary stuff:bar.c
>
> Or in various conflict messages, it can make it very difficult to read:
>
>     CONFLICT (rename/delete): foo.c deleted in b01dface... Removed
>     unnecessary stuff and renamed in HEAD.  Version HEAD of foo.c left
>     in tree.
>
>     CONFLICT (file location): dir1/foo.c added in b01dface... Removed
>     unnecessary stuff inside a directory that was renamed in HEAD,
>     suggesting it should perhaps be moved to dir2/foo.c.
>
> Make a minor change to remove the ellipses and add parentheses around
> the commit summary; this makes all three examples much easier to read:
>
>     <<<<<<<< HEAD:foo.c
>       int j;
>     =3D=3D=3D=3D=3D=3D=3D=3D
>       int counter;
>     >>>>>>>> b01dface (Removed unnecessary stuff):bar.c
>
>     CONFLICT (rename/delete): foo.c deleted in b01dface (Removed
>     unnecessary stuff) and renamed in HEAD.  Version HEAD of foo.c left
>     in tree.
>
>     CONFLICT (file location): dir1/foo.c added in b01dface (Removed
>     unnecessary stuff) inside a directory that was renamed in HEAD,
>     suggesting it should perhaps be moved to dir2/foo.c.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Reviewed-by: Taylor Blau <me@ttaylorr.com>
> Acked-by: Junio C Hamano <gitster@pobox.com>
> ---
>     sequencer: avoid garbled merge machinery messages due to commit labe=
ls
>
>     Changes since v1:
>
>      * Added Taylor's Reviewed-by, and Junio's Acked-by (I assume that's=
 a
>        fair translation of "Looks good", anyway; feel free to adjust whe=
n
>        you apply otherwise).

Here's my ACK, if you want it ;-)

Ciao,
Dscho

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-82=
8%2Fnewren%2Fsequencer-merge-messages-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-828/n=
ewren/sequencer-merge-messages-v2
> Pull-Request: https://github.com/git/git/pull/828
>
> Range-diff vs v1:
>
>  1:  da49e2eb58 ! 1:  762eb962cc sequencer: avoid garbled merge machiner=
y messages due to commit labels
>      @@ Commit message
>               suggesting it should perhaps be moved to dir2/foo.c.
>
>           Signed-off-by: Elijah Newren <newren@gmail.com>
>      +    Reviewed-by: Taylor Blau <me@ttaylorr.com>
>      +    Acked-by: Junio C Hamano <gitster@pobox.com>
>
>        ## sequencer.c ##
>       @@ sequencer.c: static int get_message(struct commit *commit, stru=
ct commit_message *out)
>
>
>  sequencer.c                     |  2 +-
>  t/t3404-rebase-interactive.sh   |  2 +-
>  t/t3507-cherry-pick-conflict.sh | 20 ++++++++++----------
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index fd7701c88a..e988c12ad2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -355,7 +355,7 @@ static int get_message(struct commit *commit, struct=
 commit_message *out)
>  	subject_len =3D find_commit_subject(out->message, &subject);
>
>  	out->subject =3D xmemdupz(subject, subject_len);
> -	out->label =3D xstrfmt("%s... %s", abbrev, out->subject);
> +	out->label =3D xstrfmt("%s (%s)", abbrev, out->subject);
>  	out->parent_label =3D xstrfmt("parent of %s", out->label);
>
>  	return 0;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.=
sh
> index 4a7d21f898..1d0a656ebd 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -256,7 +256,7 @@ test_expect_success 'stop on conflicting pick' '
>  	D
>  	=3D=3D=3D=3D=3D=3D=3D
>  	G
> -	>>>>>>> $commit... G
> +	>>>>>>> $commit (G)
>  	EOF
>  	git tag new-branch1 &&
>  	test_must_fail git rebase -i master &&
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-confl=
ict.sh
> index 752bc43487..152ea11dc9 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -283,12 +283,12 @@ test_expect_success 'failed cherry-pick describes =
conflict in work tree' '
>  	a
>  	=3D=3D=3D=3D=3D=3D=3D
>  	c
> -	>>>>>>> objid picked
> +	>>>>>>> objid (picked)
>  	EOF
>
>  	test_must_fail git cherry-pick picked &&
>
> -	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
> +	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
>  	test_cmp expected actual
>  '
>
> @@ -298,16 +298,16 @@ test_expect_success 'diff3 -m style' '
>  	cat <<-EOF >expected &&
>  	<<<<<<< HEAD
>  	a
> -	||||||| parent of objid picked
> +	||||||| parent of objid (picked)
>  	b
>  	=3D=3D=3D=3D=3D=3D=3D
>  	c
> -	>>>>>>> objid picked
> +	>>>>>>> objid (picked)
>  	EOF
>
>  	test_must_fail git cherry-pick picked &&
>
> -	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
> +	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
>  	test_cmp expected actual
>  '
>
> @@ -319,7 +319,7 @@ test_expect_success 'revert also handles conflicts s=
anely' '
>  	a
>  	=3D=3D=3D=3D=3D=3D=3D
>  	b
> -	>>>>>>> parent of objid picked
> +	>>>>>>> parent of objid (picked)
>  	EOF
>  	{
>  		git checkout picked -- foo &&
> @@ -345,7 +345,7 @@ test_expect_success 'revert also handles conflicts s=
anely' '
>  	test_must_fail git update-index --refresh -q &&
>  	test_must_fail git diff-index --exit-code HEAD &&
>  	test_cmp expected-stages actual-stages &&
> -	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
> +	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
>  	test_cmp expected actual
>  '
>
> @@ -429,16 +429,16 @@ test_expect_success 'revert conflict, diff3 -m sty=
le' '
>  	cat <<-EOF >expected &&
>  	<<<<<<< HEAD
>  	a
> -	||||||| objid picked
> +	||||||| objid (picked)
>  	c
>  	=3D=3D=3D=3D=3D=3D=3D
>  	b
> -	>>>>>>> parent of objid picked
> +	>>>>>>> parent of objid (picked)
>  	EOF
>
>  	test_must_fail git revert picked &&
>
> -	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
> +	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
>  	test_cmp expected actual
>  '
>
>
> base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
> --
> gitgitgadget
>
