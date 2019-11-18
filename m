Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4F51F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 07:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKRHBm (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 02:01:42 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43343 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfKRHBm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 02:01:42 -0500
Received: by mail-wr1-f43.google.com with SMTP id n1so18005737wra.10
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 23:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1Rky8WlhSnR2RlhAnUO6sqo3sVemevqyI/pgTmPYVQ=;
        b=Mp3FqAunkSHrA3xBEwbdr+opypPFToaSs658uToAw0FYUcEvHNJgbbHtav1lEUGuQa
         j+UGY84WzgTPs8AG1kSnWwqJJR/Ppg2MTVDkebe534d09YlYFhQw4KhKAVPvtjfcny1Q
         g/3xl2QgSXUX0KQD/NN9Z0tc+V8vHahXb6Edb8u5ZONOuHPnz/CGssk3dFtBKrwXXCBc
         iC9PLxukwOpmVATnEaqJyCGvqs8PzX0NbB6VLTU0c8J/gUqZzdqlau7xRQ3fv1IPocY0
         fuNjTNyRgVyhe5ALOLRzKByYerFbZ713mXuoeJZnqVGYfm4eqIAlc5c1yRU+e662qlY5
         iF5A==
X-Gm-Message-State: APjAAAUcxYEV6qN0BxNqjQOCfNH8A7Bzg0LVFoY3ASF8tw53OZdzpCaQ
        R4nFriA5QrO3eDNn8JF3P+37WsaTsTZkWrBg0rQ=
X-Google-Smtp-Source: APXvYqxj7kHI2pLSGu4MT59FAEcaori7zpZUn76RJ5KeucVXe2AoOodDrvEIQ+AI5rvx/aVtgJIgw9uMdwRvmQc+2Qo=
X-Received: by 2002:a5d:6410:: with SMTP id z16mr9659931wru.78.1574060499875;
 Sun, 17 Nov 2019 23:01:39 -0800 (PST)
MIME-Version: 1.0
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
 <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com> <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
 <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org> <CACKP9cv=J=_sDUsLZi7-GerFD=qbHuJT0MBdfgsMsN4pD25L2A@mail.gmail.com>
 <6bb36048-6649-ebe3-062f-c5564f7d4ec4@kdbg.org> <CACKP9csUwnYJFL55KSMmys+o7FC5Wzds_2kbCcYNESiL-SES1A@mail.gmail.com>
 <31883f6f-7b5a-a2aa-951d-51f9eee6f68d@kdbg.org>
In-Reply-To: <31883f6f-7b5a-a2aa-951d-51f9eee6f68d@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Nov 2019 02:01:28 -0500
Message-ID: <CAPig+cTBnWyLVLJBpeFhmW3yOmgiCr0YT3aHQFBT=pXWcheRLw@mail.gmail.com>
Subject: Re: working directory status
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Sivanandan Srilakshmanan <ssrilaks@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 1:51 AM Johannes Sixt <j6t@kdbg.org> wrote:
> Am 18.11.19 um 05:32 schrieb Sivanandan Srilakshmanan:
> > I was reluctant to create clones of each project on my local machine
> > each with it's own "main working tree"
> >
> > I figured:-
> >
> > I could setup a "Local bare repository" and create remote link to the
> > hosted git repositories.
> > (https://git-scm.com/docs/git-worktree#_list_output_format)
> >
> > Create "Local branches" when needed. Create a "linked working tree"
> > associated with the local branch.
> >
> > This way I can have a single repository pointing to multiple remote
> > repositories on one side and managing multiple local directories on my
> > PC.
> > In summary, my local repository will be conduit. I guess this is not possible.
>
> I think it is possible. Just don't make it a bare repository if you need
> to create secondary worktrees. (But maybe it even works if it is bare;
> just don't set GIT_DIR; I don't do it this way, so I cannot tell.)

git-worktree explicitly supports the use-case of the main worktree
being bare. (Of course, in this case, it's a misnomer to call it the
"main _worktree_", but the terminology was already established by the
time explicit support for bareness was added, so the term "main
worktree" stuck.)
