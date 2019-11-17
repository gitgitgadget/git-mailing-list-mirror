Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95781F5A2
	for <e@80x24.org>; Sun, 17 Nov 2019 20:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfKQUdl (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 15:33:41 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45251 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfKQUdl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 15:33:41 -0500
Received: by mail-wr1-f53.google.com with SMTP id z10so17025466wrs.12
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYJy+/gHV+u43rBDiqsZ0l8/B8ZRgPQGL4PW65LvqmI=;
        b=Nzrjas83G+WuniFBDDY9dqgDTWF0UKI3BHm9TIbO+KVItHJLdGBBZzAfWodwT3cFvk
         RkODP+XG+gR/HHpY6788v5zRwSZSgckrhb7U48mM73uAahN/ofrbzR6+cS7xitaJIgi2
         VA206YakffMAk0F+nG2iSkI7uAf9f5IAxOeAR52+eNZAIN8d3PRcgsOUdBLftIcupVq8
         6vnsajiA5Nr1LKTAwnu42c6nIS/UNjVe9iZNk6KgE5rAJ3pRvD872oNvXW3ZtO35is4n
         Mlb1mg6+w1a2vR4pQJ8K2UQ6w53qGvhJ+zydQxSnbHq2KUwSZkXDKOQvL3BqLhSgybnu
         anmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYJy+/gHV+u43rBDiqsZ0l8/B8ZRgPQGL4PW65LvqmI=;
        b=CjVwjmWB4dvLqfEVUK+ol/8jHxFQpxrMqhuhhw3Z9FxRFRpReCh7lTqsDFDynCLLrs
         UZn8FOQmcQv2pIXjO+QAQ3vDeO3yEfp3QyQcTU88PPVaDRMfghHpsqWA9TtAZ6PQAhjv
         LKMdgr5xoiD9WfyMDjiaFYUAelnWmrEY6Yz7utAKQmdkcexYcvsTXEAJv2YRZfNwY3HQ
         Jxh8LL0E2t5uLJI0OFzxi2wJzV+YZyjTTYJLzHOfRyQALQ8ngrWOxzQxHTJQYdQUdXiq
         TwcbcR9cVRrT5yv/iifRiXzfY3seTvTdShmT91QJLRbTe84JdXoHt8Vbhfb6mQVy1zZb
         5vqQ==
X-Gm-Message-State: APjAAAXyka6wNq261+3v79O57UeaGMIEQHB5tQEMSjlYloMF/qa+PtjJ
        of2dP6bNabvd4Pt8KyeaWo7RPw1V3MugifkjTcZF/Da2ZRo=
X-Google-Smtp-Source: APXvYqyQ/IeZBKmDm9zH3aVIWhCJ625Tq4M09wARHQIL2+cCBjBDo8D7zTfRzegeVZlFmsvvIU9YWj+l+4u3gbrWwEA=
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr13767173wrv.216.1574022819309;
 Sun, 17 Nov 2019 12:33:39 -0800 (PST)
MIME-Version: 1.0
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
 <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com> <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
 <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org>
In-Reply-To: <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org>
From:   Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Date:   Mon, 18 Nov 2019 07:33:29 +1100
Message-ID: <CACKP9cv=J=_sDUsLZi7-GerFD=qbHuJT0MBdfgsMsN4pD25L2A@mail.gmail.com>
Subject: Re: working directory status
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

Thank you for taking the time to guide me.

Reading git documentation, my understanding is that, if you needed to
use "git worktree add" then it is recommended to keep your work tree
(Working Dir) outside of your repository.
My understanding, please correct me if I am wrong, is to have multiple
worktree outside of the Git Repository.

if you used "git clone" to setup your directory and your worktree is
included in the same location as the Git Repository, then GIT_DIR is
not required.

Please assist me to understand what I am doing incorrectly. The
"output 1" below is incorrect because Local_Newfeature (working
directory / worktree) is associated with the incorrect branch
(Local_Kumfeature_branch)
Local_Newfeature directory should be pointing to "Local_Newfeature_branch".

Output 2 is correct.

====== Output 1 - incorrect =========================================
C:\test\Local_Newfeature>git --work-tree=C:\test\Local_Newfeature status
On branch Local_Kumfeature_branch
Your branch is up to date with 'Lakshman/feature_branch'.

nothing to commit, working tree clean


===== Output 2  - correct =============================================
C:\test\Local_Newfeature>git branch
* Local_Kumfeature_branch
  Local_MyTest_branch
+ Local_Newfeature_branch
+ Local_SGSfeature_branch
  Local_feature_branch


C:\test\Local_Newfeature>git worktree list
C:\GitRepo                (bare)
C:/test/Local_Kumfeature  b0a097e [Local_Kumfeature_branch]
C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch]
C:/test/Local_SGSfeature  b0a097e [Local_SGSfeature_branch]

Thank you for your assistance and guidance in advance.

Lakshman

On Sun, Nov 17, 2019 at 11:30 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 17.11.19 um 12:07 schrieb Sivanandan Srilakshmanan:
> > Hi Pratyush,
> >
> > Thank you so so so very much for responding quickly. I am learning git
> > to assist my teams skill up on git.
> >
> > My current version is v2.23.0 which I downloaded and installed a month
> > ago. Nevertheless, I have downloaded and installed v2.24.0 and the
> > problem still persists.
> >
> > I have the following environment variable set
> > GIT_DIR=C:\GitRepo
> > GIT_HOME=C:\tools\Git
>
> Setting GIT_DIR without also setting GIT_WORKTREE is not a supported
> use-case. Therefore, ...
>
> > C:\test\Local_Newfeature>git branch
> > * Local_Kumfeature_branch
> >   Local_MyTest_branch
> > + Local_Newfeature_branch
> > + Local_SGSfeature_branch
> >   Local_feature_branch
> >
> >
> > C:\test\Local_Newfeature>git worktree list
> > C:\GitRepo                (bare)
> > C:/test/Local_Kumfeature  b0a097e [Local_Kumfeature_branch]
> > C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch]
> > C:/test/Local_SGSfeature  b0a097e [Local_SGSfeature_branch]
>
> ... this does not work as expected, ....
>
> > C:\test\Local_Newfeature>git --work-tree=C:\test\Local_Newfeature status
> > On branch Local_Kumfeature_branch
> > Your branch is up to date with 'Lakshman/feature_branch'.
> >
> > nothing to commit, working tree clean
>
> ... but this works (--work-tree is the same as setting GIT_WORKTREE).
>
> Nobody sets GIT_DIR during normal day-to-day work. Do not set it unless
> you know what you are doing.
>
> -- Hannes
