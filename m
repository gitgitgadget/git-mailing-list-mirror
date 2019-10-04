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
	by dcvr.yhbt.net (Postfix) with ESMTP id 526AF1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 09:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfJDJUT (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 05:20:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:37007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729379AbfJDJUS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 05:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570180814;
        bh=KZ+27di0u1FbpxjCs3nd4FSUSySkW1gkEmCgK7DGO98=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NT/NXC6NNfKU1/u6o03GlN0F2fik/d3C6jgJkjl2DXX11qEiC1LC83uMXPx8lHo2g
         Xa1HzZlZ6a3oyONL7RBaafI1p200L2RuydFKTAYTxjYK3QoZCnOJrGIsJdTVCPNADr
         Z/lirM019UdzA8Hlxcwmx+19I067YAwDfZf/Y1C0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.189]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1i81FR0tfb-013uLU; Fri, 04
 Oct 2019 11:20:14 +0200
Date:   Fri, 4 Oct 2019 11:19:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] stash apply: report status correctly even in a
 worktree's subdirectory
In-Reply-To: <xmqqk19lbha6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910041118380.46@tvgsbejvaqbjf.bet>
References: <pull.354.git.gitgitgadget@gmail.com> <a687c16b824ec9ab45d1e2c39a5470ed89153fc0.1569415522.git.gitgitgadget@gmail.com> <xmqqk19lbha6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cn3sCD2VJKlHNTMXXSjmXrlH+TWtadizD88mn6sWgKcTCzDnP+A
 Rpwrb7TbHHH4ajP1UoavVo7/rJVXt0kEw6IGYlvAQzATeheaLUxdA/Q2SllgyhSF5ActoJK
 70SVbV4eIhsNatfmxpQcMyH8WhDmDOc1fPXE4NEGdjjb425lSG0ye2KQJFtQX4sWW+2DpV5
 48nhiJLrBVKApCQMMacBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3soVZHY6nzo=:qTRmXWIaPuaXtAmOZawubP
 js/qs3pE+CkAvMUK7TRN4QstyMIAHMdGPUne6zbfrAfopnycxfOdIxkaovmVEPj4mCgJxoqFs
 sPNEgg/5RdW/02M2ESTXHl8Zk/TeepuvEhgCppVO47VzGLQKEkxWvekKpDeRgMeVDHq2+QQtT
 MU1tkhVgJ3SorKLja4WbwSl57mFowYJbr10ls8cjo4FrS4rSUitbub07gFnnY3n9XcDXvQRRU
 xI/+hdx0eV0/SV1DREux6zhPDDL7j6BCKXtfk0DBGKptxdafDgFUXU5MSTVzR+oB89mMAkqyt
 d6EHnGm1Tv4akFrYwsUhYYvMYwRgKjzfXJVnsHVFwkbhB167b2eusJrU5ATd6umkD/a5dInLs
 pF7ftiXbDUsHba2yJRJtnmhqPnjGVCtTXTDcangkZfm0juBrpt+fJxS1KhOI88L/TDXE+h1o0
 uxMLM7ClkVzbi5438of1Pz7dld7Y88H9P2ZdmmYN8y19TWqVt79ijAyenS36z4RHbpCzQR4rO
 WfgznziCHT1GV5z9i4dWEGZNVzpWymka5OeugITU8ihdWPZqH0RYR2fRo0qlJPG1Azme0HVix
 TZkbvq2TLIjhY8+hyYXI1b1c6jcll2T9dJFod9/NBV8zzEHNzA/iB3dObicEfQaIOXMVUe4SH
 WCF7/fSw/ot81N/2FXUr9q2yVXkGW1NBDHfox0SEePP9XoWRvUQwl9wWvzUjsK8O375bPk8/a
 LDfwijWPo9p1pxS2AUqC0SrVdp3PhlYYF1QK/GCBRsHDs4l5gyn5RYlsPCLIrlnQdyRsWXYR6
 eV2uNK/AhJCKcwl8ni8EP0FoVuORYPv3rF5bnZ9VOLPGnZgAoIxa9sMLacB3HsPiw7exkoTp5
 VdZP6yqgKg4s+scKhVX87OA4DIW13LNFdSLOEXLRxJNoClM36Rvz8DCaXZweYMfcP1zZiIgDO
 bRvErmBwHyPYP5Sz9aE//jDbXeoQTHChyPjNBbXKjjs1V733KwSTuhIpEx6Uwd1PkjCWB4Mk4
 edLvN9Noog1uEV065KDDibq+UvSAAvKwy8od02khj5hJ+RQ4Wk4HqadLR1vNFeVcTWtnzEChM
 YSOpdBTqvM3KVuoO+SCjB4uGH7lQL0nzleqj7LkleKRUHUbKeat0VuZqMZIeKS4gnD4GerVDV
 vhlb+UMt3pqMzWw942XAxipjQZ1aPJQY08omyf8acmhicqgCu92rkN7+EU6782US+bCmfN1c5
 a0VCRFJv7thleW2VyDmSi8tKAN8lZgBmElzg3/II9iWw/5V13ID0wTZwLZMg=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index b5a301f24d..a1e2e7ae7e 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -497,6 +497,8 @@ static int do_apply_stash(const char *prefix, stru=
ct stash_info *info,
> >  		 */
> >  		cp.git_cmd =3D 1;
> >  		cp.dir =3D prefix;
> > +		argv_array_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=3D%s",
> > +				 absolute_path(get_git_work_tree()));
> >  		argv_array_push(&cp.args, "status");
> >  		run_command(&cp);
> >  	}
>
> Nicely spotted.  Exporting GIT_WORK_TREE alone without GIT_DIR feels
> a bit disturbing, at least to me, though.

You're absolutely right! Of course, the problem this patch fixes is
_because_ `GIT_DIR` is defined, but I should make sure that I don't
introduce the reverse problem ;-)

> I wondered if this misbehaves when the end user has GIT_WORK_TREE
> environment exported, but in such a case, get_git_work_tree() would
> return that directory, and by re-exporting it to the child process,
> we would honor the end user's intention, so all is good, I think.

Yes, that'd my understanding, too. It won't hurt to re-define that
variable, but it hurts not to define it at all.

Ciao,
Dscho

>
> Thanks.
>
> > diff --git a/t/t3908-stash-in-worktree.sh b/t/t3908-stash-in-worktree.=
sh
> > new file mode 100755
> > index 0000000000..2b2b366ef9
> > --- /dev/null
> > +++ b/t/t3908-stash-in-worktree.sh
> > @@ -0,0 +1,27 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2019 Johannes E Schindelin
> > +#
> > +
> > +test_description=3D'Test git stash in a worktree'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +	test_commit initial &&
> > +	git worktree add wt &&
> > +	test_commit -C wt in-worktree
> > +'
> > +
> > +test_expect_success 'apply in subdirectory' '
> > +	mkdir wt/subdir &&
> > +	(
> > +		cd wt/subdir &&
> > +		echo modified >../initial.t &&
> > +		git stash &&
> > +		git stash apply >out
> > +	) &&
> > +	grep "\.\.\/initial\.t" wt/subdir/out
> > +'
> > +
> > +test_done
>
