Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CEFC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 13:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58707222BA
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 13:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hjJ9cPG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbgJINas (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 09:30:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:57765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732173AbgJINas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 09:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602250245;
        bh=z0zErdnVwctlGzXSILNeNAf4e9Uz0oxNd7CPJ7o4rRc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hjJ9cPG3jUPFbs/LlvvxIUc52R9qJTH9dWAsxJ7BW9nfe8+P1v3cQE2SL6LLvc/tf
         M7NxrxeceBlgffFpO74fedqIvEWxeD20mCLsyQ4aitbCWQQG856SO6vdyyCpYPkTVD
         ihWdlpozeqmwVIcfcK5811sWdLHIs+ybFLMCmRzI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.213.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1knv971beO-00NAbz; Fri, 09
 Oct 2020 15:30:45 +0200
Date:   Fri, 9 Oct 2020 13:13:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ci: skip GitHub workflow runs for already-tested
 commits/trees
In-Reply-To: <20201009072922.GC24813@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2010091254180.50@tvgsbejvaqbjf.bet>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com> <pull.619.v2.git.1602170976.gitgitgadget@gmail.com> <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com> <20201009072922.GC24813@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-148249349-1602241984=:50"
X-Provags-ID: V03:K1:/JNu8qvHVdWtXnez2S5h8hRJarL/s+/cL+DdRWdcCrWTVtMNJJE
 4vEkU5j4DTvrmVG6osHRf16CoIpgvUQlGvSMja1ucahPrs1KAm5k5SEu+LJN/AHVvNkp/2U
 0be6/1WtQ6PmJ15WNGzTCW5eFVe+4qd3Hhlft9ne/D1Q9DgcWDsBdPM36nTjH5BJiDcUU67
 j5Fbe53hiCFhF7n+e/M6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b5XNS6YdyXI=:QlzJzfTMiugN3HYRwUcBTB
 gcOVUfE7YzR7ZtzQnPCNvgE32WqDbZAQqqUG2ShGrconiNzuoTIW44I2+V3sH5vti0qORwAU0
 asMlmgp3Te22f+ZyEDeq+sl4JkOmtCUUfcRARCIClJp56hxRJj514aMxcB0yc5R6FuFHXmu6K
 t09czKh3mjbN2rWA9AlQpBCwaZ6nEWIx+5H+GOemOaIAv77qNoSe7oRhh5IVZJhb8s+ZdoA3X
 oIdWHW8WVtj/U5a9zeqqUJqgClv4OamwvN/1I9eDssqBmiXTfPwBWXG9asvkyJZ/zgO667OIS
 J78i/wS4EHlT+iJFcsp6uD/31fIhM+/R7/MmhDPb38fUU4CaA7YJ1FSXYAmsV8GGal1inyTb0
 HFfqAyf3pFPtyn2TWfQiuc5Sm5nVQtjGJ8ki0PPWnhsg+HADuINEyeUaXY7GxNYOkO3VfrRcL
 yXb8dkivi3KN+C1LOURwWoiru+2GpCovZc6CsSyF2dQO/NV57T3MwaMf1XB87IRVL53H7TUt4
 4LiNWYW8aDjRFpWIX1sPni6jXwnALXps2iYTOuL3tpmUqtaAhEqhHV6pwxlipcYFAE5OSTlHl
 AYYtDpKu4lRCNOTr+4MoleTMvVIT9kqQGQ5UB0KoWAYV9U5XZ03wfGgtER964rwwHbRmqBO/u
 /MirvXqDc0h94c+WT9hsORvxh7sCONU4PL1pQjil4Sy9svylkOk0jpEVxLa6nY9AbRsoSsaPc
 +4qONFzOUN2gaD2+9uIjfdtc4/L5BXZcLhHplUA44aukHztSEboc9279u7EJgOi9+bK/XpK5N
 wuzBokaRLNIneaKxB5ti/WJXTkTAnfYeXjahUhljrLOuvD/5JcltBcxQRxfdPWRNqoGXbB+Ab
 5/msksUNmXUInJ3Ut2vZ+AfJ8lwK+BxDah3yE8fY5WNYZ6RAGwXXD94JPHPPbQ299Wi2YtxKg
 r/KekHa4YmMm8Ji0Kwj1G0pHOCp91XPxT2xf636ZGmDMbYX9Zy7ZcNcZecyljhiAGAQSrCM6T
 ImwVDHaKw7aK6Bl7p99DB4hwnS2/DeNHF2dGz3nYBxFbnbXr2oU39bBxLysHRbXn7QXAZA84u
 I6V9Kwf+aYacP+H/Z9jXxB7xU84ev14izcN7oGOGnULzGqsCa4Ys4tY1LYxo5+prdHLIEx6oC
 9nI1jnQL46u2uMKciTOWNXKKu8BxfZ/0wIQK6doK3VIhfYZnj/+jLQ2Y/2Ej1VyzprfJFYQdt
 F5r0fxWINwxh25SDy6/lT2WqlOE13mbOCbXJjxA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-148249349-1602241984=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 9 Oct 2020, SZEDER G=C3=A1bor wrote:

> On Thu, Oct 08, 2020 at 03:29:34PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When pushing a commit that has already passed a CI or PR build
> > successfully, it makes sense to save some energy and time and skip the
> > new build.
> >
> > Let's teach our GitHub workflow to do that.
> >
> > For good measure, we also compare the tree ID, which is what we actual=
ly
> > test (the commit ID might have changed due to a reworded commit messag=
e,
> > which should not affect the outcome of the run).
>
> We have been doing this on Travis CI for a few years now.  Does that
> approach not work on GitHub actions?  Please explain in the commit
> message why a different approach is taken here.

You're not being terribly clear about what exactly "We have been doing".

Are you referring to the `skip_good_tree()` function that stores
information in a file in the `good_trees_file`?

If so, no, we cannot do that anywhere else than on Travis because that
relies on a directory that is somehow shared between runs. And that is a
feature that only Travis offers as far as I know (and it does not come
without issues, e.g. when two concurrent runs try to write to the same
file at the same time).

Since this strategy relies on a Travis-only feature that does not work on
the three other CI services we use (Cirrus CI, Azure DevOps, GitHub
Actions), I see little point mentioning it in this commit message...

However, I might be very well wrong on that assessment.

Ciao,
Dscho

>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  .github/workflows/main.yml | 39 +++++++++++++++++++++++++++++++++++++=
-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 5bd321e5e1..7391b46d61 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -9,7 +9,7 @@ jobs:
> >    ci-config:
> >      runs-on: ubuntu-latest
> >      outputs:
> > -      enabled: ${{ steps.check-ref.outputs.enabled }}
> > +      enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-i=
f-redundant.outputs.enabled }}
> >      steps:
> >        - name: try to clone ci-config branch
> >          continue-on-error: true
> > @@ -35,6 +35,43 @@ jobs:
> >              enabled=3Dno
> >            fi
> >            echo "::set-output name=3Denabled::$enabled"
> > +      - name: skip if the commit or tree was already tested
> > +        id: skip-if-redundant
> > +        uses: actions/github-script@v3
> > +        if: steps.check-ref.outputs.enabled =3D=3D 'yes'
> > +        with:
> > +          github-token: ${{secrets.GITHUB_TOKEN}}
> > +          script: |
> > +            // Figure out workflow ID, commit and tree
> > +            const { data: run } =3D await github.actions.getWorkflowR=
un({
> > +              owner: context.repo.owner,
> > +              repo: context.repo.repo,
> > +              run_id: context.runId,
> > +            });
> > +            const workflow_id =3D run.workflow_id;
> > +            const head_sha =3D run.head_sha;
> > +            const tree_id =3D run.head_commit.tree_id;
> > +
> > +            // See whether there is a successful run for that commit =
or tree
> > +            const { data: runs } =3D await github.actions.listWorkflo=
wRuns({
> > +              owner: context.repo.owner,
> > +              repo: context.repo.repo,
> > +              per_page: 500,
> > +              status: 'success',
> > +              workflow_id,
> > +            });
> > +            for (const run of runs.workflow_runs) {
> > +              if (head_sha =3D=3D=3D run.head_sha) {
> > +                core.warning(`Successful run for the commit ${head_sh=
a}: ${run.html_url}`);
> > +                core.setOutput('enabled', ' but skip');
> > +                break;
> > +              }
> > +              if (tree_id =3D=3D=3D run.head_commit.tree_id) {
> > +                core.warning(`Successful run for the tree ${tree_id}:=
 ${run.html_url}`);
> > +                core.setOutput('enabled', ' but skip');
> > +                break;
> > +              }
> > +            }
> >
> >    windows-build:
> >      needs: ci-config
> > --
> > gitgitgadget
> >
>

--8323328-148249349-1602241984=:50--
