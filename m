Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8FA1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 10:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRKkg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 05:40:36 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55868 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRKkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 05:40:36 -0500
Received: by mail-wm1-f43.google.com with SMTP id b11so16796452wmb.5
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 02:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iv1u2AMyemz5uRO/OsJR+uYVXXZnJonPCOS/02kv0iI=;
        b=S9Odt1U2Lw7ndyYNbh1FNr9eeOXZOhhWRxrtFw3r4LIDxTuNoNRjDpRcYOZZTq9Pjr
         xd2KuE4mtcnCDjizMXtbGsfxt/CRQ7AOET/vz1ETbldjmc0s3ecqrWVSaXI83hDdVsza
         5pRpl0sGepXAUa9xl6rhjcDw1v2xd9kN/9D/JJCZeJsX+WJq2vqDRfSuMIRUZvfXNse2
         qcWqwZ7hZ+K95f0JbMa/lmASATqJX3fVE58/HvzB7PkYSFQLyuP7NIVpKEGCyaT68m9O
         wt+7QkkvKidc8sCCTsXis7FRhFnR0RrPM7DJkqOI9BzMojvzxjVUwxU1/PTVkDDtI9tj
         FAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iv1u2AMyemz5uRO/OsJR+uYVXXZnJonPCOS/02kv0iI=;
        b=qyg4LtaytNwJxX+m/b4uRU3FHtBJnLGgnDZV5MBSS+bQe4BnG0uuZb4V9c8GFhYCYk
         UZO1CeSgDQkImU0hu8UYwzxLtbwDAlJsy12o6mbbtNXFcSreEdwmy99iBNSEJW5bWfG4
         zsDsjCVyZA5msDsD80wDdHCC5lSoppS9iSsoBs4r2c3fdQSYzdcUPEvcMwNPmRJIadwK
         4niueuyf+0WJHJwI/tOVeVEMgqyZ6ieYI7RvJp85lVxr5LNCD69RP60xrJTa2Mbxo+nH
         HQpJnzwVVIAMnL/t7JlPVQA7LECgC2/8NrPqKUQccOOyEb460/cLMoP9+N8VOLha/m1O
         2hqg==
X-Gm-Message-State: APjAAAWuqskOO93mlk/nvdDeREsNUGsm1SdeZRraoPt0yJqD9CeWpurg
        zGrQTVlQmCs5jytreiys9K2VQEWE1TyF6iBbrdQ=
X-Google-Smtp-Source: APXvYqxSn4tpRPsyqvgbubzjdklil/HjeazUIy+nldudyoUxzGzHo3lAg9/3TXqOZiKPNeNBnkNnLzMofB7B9JaifKU=
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr28517135wma.38.1574073633840;
 Mon, 18 Nov 2019 02:40:33 -0800 (PST)
MIME-Version: 1.0
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
 <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com> <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
 <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org> <CACKP9cv=J=_sDUsLZi7-GerFD=qbHuJT0MBdfgsMsN4pD25L2A@mail.gmail.com>
 <6bb36048-6649-ebe3-062f-c5564f7d4ec4@kdbg.org> <xmqqk17x1wvx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk17x1wvx.fsf@gitster-ct.c.googlers.com>
From:   Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Date:   Mon, 18 Nov 2019 21:40:22 +1100
Message-ID: <CACKP9ct0AJE94=C32QEH_uD8S8PdGoFeW15oftcf-wifh6hWLA@mail.gmail.com>
Subject: Re: working directory status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes, Junio, Eric & Pratyush

Thank you very much for your support. I greatly appreciate your guidance.

It is clear now and it is working well. It is possible to use a local
bare repository as a conduit to manage multiple remote repositories.

I had to re-read the https://git-scm.com/docs keeping in mind the
guidance given, to get a better handle on it.

For the benefit of anyone else stumbling across this thread.

As mentioned earlier ****  DON'T  ***  set GIR_DIR and GIT_WORK_TREE.

Step 1. create a git repo (bare/non-bare)
Step 2. git worktree add --track -b    Local_Newfeature_branch1
Local_Newfeature       remotes/Lakshman/feature_branch

The above will create a local branch Local_Newfeature_branch1
The above command will also checkout the code into  the directory
Local_Newfeature.

You can perform all your git command inside the directory Local_Newfeature.

C:\test\Local_Newfeature>git branch
  Local_Newfeature_branch
* Local_Newfeature_branch1
  Local_feature_branch

C:\test\Local_Newfeature>git worktree list
C:/GitRepo                (bare)
C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch1]



Works like a charm. Thank you all very, very very much for your
guidance and feedback much appreciated.

Thanks
Lakshman


On Mon, Nov 18, 2019 at 6:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > ...
> > Do not set GIT_DIR if you do not understand the consequences.
>
> I think the explanation in your earlier message was probably a bit
> more helpful.  If they want to use GIT_DIR, they need to also set
> and export GIT_WORK_TREE.
>
> Of course, with both exported, asking "git branch" for which branch
> is checked out would ask about the working tree that GIT_WORK_TREE
> points at without consulting $(pwd), so it is rather pointless.
> When the user switches to another worktree, both GIT_DIR and
> GIT_WORK_TREE need to be updated to point at appropriate places, so
> it sort of defeats the purpose.
>
> >
> >> C:\test\Local_Newfeature>git worktree list
> >> C:\GitRepo                (bare)
> >> C:/test/Local_Kumfeature  b0a097e [Local_Kumfeature_branch]
> >> C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch]
> >> C:/test/Local_SGSfeature  b0a097e [Local_SGSfeature_branch]
> >
> > I do not know whether it is a sane use-case to have a bare repository
> > and separate worktrees.
> >
> > Do not do that. Make a regular clone with a worktree and create
> > secondary worktrees from there.
>
> As long as GIT_DIR/GIT_WORK_TREE are both set and exported (or both
> unset, a new worktree made out of a bare clone should work just
> fine.  At least that is one of the use case I recall the feature was
> designed to be used in.
>
> Thanks.
>
