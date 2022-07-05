Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D6C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 19:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiGETeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiGETeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 15:34:00 -0400
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 12:33:58 PDT
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F1101F0
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657049637;
        bh=8BP8xusy7C3cODkElZI2QO67ONeDR+CMSr4oD56SQlA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=M8DeYzr3KHXQAYVE88FHdCjWVbdIub5x82ywCfgXvqDAWIPzh+Oh5htwNVET5pa2p
         hAfxls4vUIgKJJvY3OLEQfjCoS5BvmYZ6GLGtW99eIWyLjZMAC4wniouggcr8sQw4X
         9PQclLbfrc2lqDTcTip2z7CkwGCUkMef5K00a8QY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtwr-1oK7wx1DnV-00BS3Y; Tue, 05
 Jul 2022 21:28:42 +0200
Date:   Tue, 5 Jul 2022 21:28:40 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v5] ls-files: introduce "--format" option
Message-ID: <20220705192839.irfrfx4z6jwimcmu@tb-raspi4>
References: <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com>
 <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1262.v5.git.1657002760815.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Th/84hM6mOhxqGner3I2qgR6bQiyn7Lizu7B46nZSbiNGg/8vl+
 BkGwLkVRVKTRglyd1gU8XpcHER0ihFJhMLID+CcLHKqRFjtV4tozNyUB3aypsZkSWTCkNE4
 g8CO857Mkx645CyNlWIDsRz0uLLvfyipNnZaBcx4F8z6Y6j3CZBzsrjY7ZyluXF4nC3Joc7
 MJLPIuhmmw1/CTUPG6tTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nKv0EM+Y4a0=:7jwVaI5pcPRx+/2hp9CbAf
 B/4dkBJecB+1wAjflP5fhIeKNwNfq/ZRFdaX/2nvb/jLgmchMBHs7UFKa/e9AUzMMOKR5dF1q
 LbACEoC4n1rqbR9inbywv4lR5qvOYzA0Vi7X5csCbZPUgOUBUgi8gwp7dAVCpyzr6mBtGLn8G
 HS2wMymAQvmedc1PYvM8x1i8eebGvc6HUHbT5QrGUkS0UXNyOBUAFjmWtD+jRDfSask856WqK
 Nj7vA88geZVf/++EvDgM6Q2UEe78rDUC1wdJhjz+FMy1nQblqBTY/5WQSU/oDhoF0rM3VEnOF
 5oZChakctUZ8ZGWjtyMedDobT9R8756wdgkaqFSQpvUrO0q9HD7pVAQwsahKEIj+5EIkPd7i+
 zQaC8vLhVRcpevse6FLuKe6PTv9LItuvR40bm09uKz0IdEWhzwBUgrp2Yl5M10jtWvNAGtZNk
 r+3o7QlBTwra17F/N7s6FZ3PXYGVpzEB/LUi3JAbkfsj+ijIIiNn9W8syBlb4EoSaHaahgq7W
 Kn+0ch91Uc+PWxkZhcCNZvD19LVEITRyOeh8AGCjNL93B5crApUP7GKI9FtBuIQtci6WuSxTZ
 t/s0rac0Iue0+GbS7r43kqvC16IPfF0c7jDr4xncDrCOvq65b05O2X9aAFlpyjZ9xrGzw+KH2
 OQ2Vc0f5iZsFFZ2cPhGqbJ/Zi0Qr1N/DM/m8WuUzPTZaEipFdFMZOsqu1AfpRYm6nzUZsCJom
 QZIOc4kCuhWMVgNTLw3kh3Az0+zryKhPskIkv23aVF/HxRu5mwaZcsK92YfWeTwj9jGhFkHXZ
 YXq/HPOKW4KgqNKDoDjVWQ3gvBF8puqWWs8jz9xCRwqw1JOksajFxdvivMdDvL0HLItSAO+mM
 VcEpQZiQGyPW9pIdfucpsWVHiaT99i0acCBL02Vho/dvVUmL4B26lsNe3vNfCTUcGSHiP528B
 z8uCoRDQ+qFVRRFkoPtHcHqDlEilumRvi+qxzXIsSy765w+3rPWCb3js5beiC0FlCU5PoX2EF
 voZ0tiCVY6QrEIQfHQe9v/O9EJphUd0wXGaJihW09yZfADVXjRtPXIY8ulttSpIzfNvlieU0w
 MO4S4UDSAPW00yGAIf4ynmuRR41Otb1aBMT
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 06:32:40AM +0000, ZheNing Hu via GitGitGadget wrot=
e:
> From: ZheNing Hu <adlternative@gmail.com>
>
> Add a new option --format that output index enties
> informations with custom format, taking inspiration
> from the option with the same name in the `git ls-tree`
> command.
[]
> +FIELD NAMES

Nice

> +-----------
> +Various values from structured fields can be used to interpolate
> +into the resulting output. For each outputting line, the following
> +names can be used:
> +
> +objectmode::
> +	The mode of the file which is recorded in the index.
> +objectname::
> +	The name of the file which is recorded in the index.
> +stage::
> +	The stage of the file which is recorded in the index.
> +eolinfo:index::
> +eolinfo:worktree::
> +	The <eolinfo> (see the description of the `--eol` option) of
> +	the contents in the index or in the worktree for the path.
> +eolattr::
> +	The <eolattr> (see the description of the `--eol` option)
> +	that applies to the path.

This may be a matter of taste, looking at the eol-stuff:
Should the ':' be dropped and we have 3 fieldnames like this:

eolindex
eolworktree
eolattr

> +test_expect_success 'git ls-files --format eolinfo:index' '
> +	cat >expect <<-\EOF &&
> +	lf
> +	lf
> +	EOF
> +	git ls-files --format=3D"%(eolinfo:index)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format eolinfo:worktree' '
> +	cat >expect <<-\EOF &&
> +	lf
> +	lf
> +	EOF
> +	git ls-files --format=3D"%(eolinfo:worktree)" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git ls-files --format eolattr' '
> +	printf "\n\n" >expect &&
> +	git ls-files --format=3D"%(eolattr)" >actual &&
> +	test_cmp expect actual
> +'
> +

What exactly should this testcases test ?
Does it make sense to set up a combination of index, worktree, attr,
which are happening in real live ?

There are some tests in t0025, t0027 and t0028 that do more
realistic tests of different combinations.


