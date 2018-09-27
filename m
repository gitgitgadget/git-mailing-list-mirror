Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942D71F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeI1CCT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 22:02:19 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40428 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1CCT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 22:02:19 -0400
Received: by mail-yb1-f193.google.com with SMTP id w7-v6so1628822ybm.7
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HctGj+yYWLSgQuMHI2rcu196mtQlHNrIT2Wmtversg8=;
        b=Ofbp+4lAcY5DA2KGhSo0G2t+ztK41KCUv/N+afGRl3i444SnDpJTbiAWBhgg/uaWs6
         9aj9wms75jSVbtz54IW5Asrm72MHCqBS4MeQFgSnZMVVuDuKhPIyIYZ0/31Rk6ooWfFR
         yVWnf8kDsUC8E//mx2HPYQNvGZFgXTKrhZwqsdJF1dSOE0GNIO48pOragy752PmenX7t
         UeImLIi1uOgrO3XW1rqr9e7tf2ExmK3ZHZ4/13uIDQLcewoSzmeiHphe+iz8cShvztfu
         gkwM4XyUvAm+atW8+aMi9fmlWMnP3KFj8FHejmAUh1mezg5feHbsHfGBRT8NtLT7Nmal
         b/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HctGj+yYWLSgQuMHI2rcu196mtQlHNrIT2Wmtversg8=;
        b=Qqao46Xf6lR5D3BUoUYkB1Kxvm58VYZtBmIm+/RDS6RcxXKAhuUZRzrOgfcI3yvPpA
         7As8JnBCu5upBcOcj2OulfYE0WHlD38G+VDsM7+uzrGZoxdJmjBwnsqzHtWUGHxIJw+H
         K0ozUkv+KlusXu22lRxRUcGhl0IXATtS0SigbPO5fe4yOlo9Cjz9MY1rN9QYmumB0eya
         u5as4gwKtm98e3ZC/Ph/lZA5SFr4Nnu0ENjdlHoEbC7hkUhrHUhNpJ7QCNUYx/1cclnE
         8sS8qOtHyXb7Gc4mAuzc8+07Jw+85Z6vPTUMRhZET2BCMrAR87/FzBB/XFEjCZkQ0U0x
         RNPg==
X-Gm-Message-State: ABuFfojkH9jIz4mnISIyKAMJZgEgz9zXEWM67XSLwmgAAPTnAbQ9XESU
        1hNnaRXSlhUjZNcugzsNEsajt45IxcALru7GbcC/pg==
X-Google-Smtp-Source: ACcGV613Qwg9LH3j1sZqN4eyw27T+Wv2E1qo0vq1LMI9yR1gQTZv3jKpmhdIrvTDQDvjcJHqlrvGVtXir22G0+j5Pk4=
X-Received: by 2002:a25:db02:: with SMTP id g2-v6mr6508786ybf.493.1538077346373;
 Thu, 27 Sep 2018 12:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180927181054.25802-1-sammck@gmail.com>
In-Reply-To: <20180927181054.25802-1-sammck@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Sep 2018 12:42:15 -0700
Message-ID: <CAGZ79kaRYra+2Ue2TSS74tE_gdg8ppSfNtVQK4LhOrQTj8td8Q@mail.gmail.com>
Subject: Re: [PATCH] submodule: Alllow staged changes for get_superproject_working_tree
To:     Sam McKelvie <sammck@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 11:12 AM Sam McKelvie <sammck@gmail.com> wrote:
>
> Invoking 'git rev-parse --show-superproject-working-tree' exits with
>
>     "fatal: BUG: returned path string doesn't match cwd?"
>
> when the superproject has an unmerged entry for the current submodule,
> instead of displaying the superproject's working tree.
>
> The problem is due to the fact that when a merge of the submodule referen=
ce
> is in progress, "git ls-files --stage =E2=80=94full-name <submodule-relat=
ive-path>=E2=80=9D
> returns three seperate entries for the submodule (one for each stage) rat=
her
> than a single entry; e.g.,
>
> $ git ls-files --stage --full-name submodule-child-test
> 160000 dbbd2766fa330fa741ea59bb38689fcc2d283ac5 1       submodule-child-t=
est
> 160000 f174d1dbfe863a59692c3bdae730a36f2a788c51 2       submodule-child-t=
est
> 160000 e6178f3a58b958543952e12824aa2106d560f21d 3       submodule-child-t=
est
>
> The code in get_superproject_working_tree() expected exactly one entry to
> be returned; this patch makes it use the first entry if multiple entries
> are returned.
>
> Test t1500-rev-parse is extended to cover this case.
>
> Signed-off-by: Sam McKelvie <sammck@gmail.com>

Thanks for following up, this patch is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks for adding the test as well!
Stefan
