Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E2B1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 04:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfKREcp (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 23:32:45 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37943 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKREcp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 23:32:45 -0500
Received: by mail-wr1-f52.google.com with SMTP id i12so17769598wro.5
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 20:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trfY4D634Y8rYLloRqwsWA0EAKxuBwqddWQLcluu/Oc=;
        b=hxdjp7o0WPC2rvV74sO30IEgKf4QPcJT8Pqsr8jAEfVwIG3IeLq3HZbAKZSBDOK6QH
         n6qjBcwgnWMXBpf1KuSudjmOcD4YA3zi4KVHx4SYKlAH2zSlrcR8MilBsGiG/R8wc2So
         b3QLgNhkgv6acqd284ON/lYu8mTvG9obeSs/0TlwUxlhUnRtG9mKjrMYal/0k+nRylO2
         tBNtxoOBSHqy8cJFVzeMOslUB8FAoVmOuF7+zSRaNLHX6OtuSbvr939ElWEXV7tiANTt
         1EiHyDLHWIEitAH6A2OE7mp7ngnL77LQy+73779zugya7mmMSBAIlXC+aNpKdTpZF4cv
         YfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trfY4D634Y8rYLloRqwsWA0EAKxuBwqddWQLcluu/Oc=;
        b=ubrc3/AHecqlybC9dNhB6rhnXDN46Xn8WDF6GQPqcEirgAxVDHt3cYbYUy2Ah/CpPJ
         yJt4LNIZ+NMWmmPpRxuvYRdpoViK3ODUhOc8Na61/K0Q+79UXJ+jKA85e8dtwzPljb6b
         h4sggJP5D5EEY6ad+aQF596RokN9aHn4CbwKrVVcgS/ooYQpDSzWVs8wLue+OhwasSoV
         ILYFN/k+bwSr2r6lXo+rADPZ9O59K0M2JyHlSwWVaIAD+YGjTIV5h9Tu80xzKT1b6AV8
         r2GF4o6VQnh0ZvFuY7spslk6DTgs1gjsb3rnXBVxY6aI3SlsQEGafokjQyv+ZVM6NL7P
         KAoQ==
X-Gm-Message-State: APjAAAV3OVOKJtWs/BY+ug4S/Utsc8jsyKEKWXFxVQ6MUcldXpY2MzMO
        N0fqJCMT3R/3eNzED2Vj3UbDqWNrV7F4uz11xgB+QmkFV+s=
X-Google-Smtp-Source: APXvYqyMU0bsaU1luEUnSepW0lcu+i/V7FukjqwR5UZH5EPYKOOG7rtbbO8vP/krANiYL0NcsCVxR+eQ3b+vkKVqxdY=
X-Received: by 2002:a05:6000:1181:: with SMTP id g1mr25990648wrx.131.1574051562861;
 Sun, 17 Nov 2019 20:32:42 -0800 (PST)
MIME-Version: 1.0
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
 <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com> <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
 <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org> <CACKP9cv=J=_sDUsLZi7-GerFD=qbHuJT0MBdfgsMsN4pD25L2A@mail.gmail.com>
 <6bb36048-6649-ebe3-062f-c5564f7d4ec4@kdbg.org>
In-Reply-To: <6bb36048-6649-ebe3-062f-c5564f7d4ec4@kdbg.org>
From:   Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Date:   Mon, 18 Nov 2019 15:32:32 +1100
Message-ID: <CACKP9csUwnYJFL55KSMmys+o7FC5Wzds_2kbCcYNESiL-SES1A@mail.gmail.com>
Subject: Re: working directory status
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

Thank you so very very, very much for your guidance.

My team and I maintain multiple projects, each with it's own remotely
hosted git repository.

I was reluctant to create clones of each project on my local machine
each with it's own "main working tree"

I figured:-

I could setup a "Local bare repository" and create remote link to the
hosted git repositories.
(https://git-scm.com/docs/git-worktree#_list_output_format)

Create "Local branches" when needed. Create a "linked working tree"
associated with the local branch.

Clean up the linked working tree when work is complete.



This way I can have a single repository pointing to multiple remote
repositories on one side and managing multiple local directories on my
PC.
In summary, my local repository will be conduit. I guess this is not possible.

Based on my requirement would you suggest the best approach would be
to create git clone for each remote repository?

Thanks again for your help and guidance.

Thanks
Lakshman

On Mon, Nov 18, 2019 at 9:26 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 17.11.19 um 21:33 schrieb Sivanandan Srilakshmanan:
> > Reading git documentation, my understanding is that, if you needed to
> > use "git worktree add" then it is recommended to keep your work tree
> > (Working Dir) outside of your repository.
> > My understanding, please correct me if I am wrong, is to have multiple
> > worktree outside of the Git Repository.
>
> That sounds reasonable. Note though that if you need N worktrees, then
> you have one worktree with the (non-bare) repository, and N-1 worktrees
> outside that repository.
>
> > if you used "git clone" to setup your directory and your worktree is
> > included in the same location as the Git Repository, then GIT_DIR is
> > not required.
>
> Yes.
>
> > Please assist me to understand what I am doing incorrectly. The
> > "output 1" below is incorrect because Local_Newfeature (working
> > directory / worktree) is associated with the incorrect branch
> > (Local_Kumfeature_branch)
> > Local_Newfeature directory should be pointing to "Local_Newfeature_branch".
> >
> > Output 2 is correct.
> >
> > ====== Output 1 - incorrect =========================================
> > C:\test\Local_Newfeature>git --work-tree=C:\test\Local_Newfeature status
> > On branch Local_Kumfeature_branch
> > Your branch is up to date with 'Lakshman/feature_branch'.
>
> You observe this incorrect output because you have GIT_DIR set.
> Obvously, Git looks at the branch that the HEAD of $GIT_DIR refers to.
>
> Do not set GIT_DIR if you do not know what it is good for.
>
> > ===== Output 2  - correct =============================================
> > C:\test\Local_Newfeature>git branch
> > * Local_Kumfeature_branch
> >   Local_MyTest_branch
> > + Local_Newfeature_branch
> > + Local_SGSfeature_branch
> >   Local_feature_branch
>
> If Output 1 is incorrect, this is not correct, either: Note that
> Local_Kumfeature_branch is marked as the branch for this directory, but
> you intend it to be Local_Newfeature_branch, yet it is marked as living
> in a different worktree.
>
> Do not set GIT_DIR if you do not understand the consequences.
>
> > C:\test\Local_Newfeature>git worktree list
> > C:\GitRepo                (bare)
> > C:/test/Local_Kumfeature  b0a097e [Local_Kumfeature_branch]
> > C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch]
> > C:/test/Local_SGSfeature  b0a097e [Local_SGSfeature_branch]
>
> I do not know whether it is a sane use-case to have a bare repository
> and separate worktrees.
>
> Do not do that. Make a regular clone with a worktree and create
> secondary worktrees from there.
>
> -- Hannes
