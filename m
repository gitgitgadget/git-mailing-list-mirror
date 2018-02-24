Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963421F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeBXAgJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:36:09 -0500
Received: from mail-yb0-f182.google.com ([209.85.213.182]:42680 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBXAgI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:36:08 -0500
Received: by mail-yb0-f182.google.com with SMTP id i13-v6so3510678ybl.9
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4gXyhVHJS7vUhqGTfb9kGXztf9InfrfFdMCTIpWJ5D0=;
        b=lwXbuHMFxxGWb7owZ0ug0BweENAjX3PpuGikUYjRew9sbuXfpucLErL4etRBpGDpC5
         l6wnuvlIbfdvYKzfRVEOxmLDhHZO1g9KmJcg990ioVNwoPJgHm1uRlxzmUrLPe5pkPPl
         JJGCsOlWStUHlkaIFY0oVZk4tiZKRDEPqozwOSR5PsADPoaY1dXAJVF6pnfEADFLwisg
         YLfeMtewLi+iVc9ThFIM6gO1GMfx0OhFz/p38MKGhT0iGgMvoIrquuIlnrVwkoboTeiu
         K4UXdL8T65wHvwwf9s0ymZE2Xzsq2QC/VudfR97X9f2sjtwg5RKmwiwjX74tpVXqmO8B
         vZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4gXyhVHJS7vUhqGTfb9kGXztf9InfrfFdMCTIpWJ5D0=;
        b=kVtYWaS4/GCUaBlZOOb5qcLgc6Pdoh+4HXonn+Ey12DhvsQFQo5JS7AKWC6pyHKTxR
         iv9jsTO/GWd4j0HCzbfQD7Rgxf69/l4DMKUuE9vrHl6bywAf+AuuGSU7ziVk2TJcsrOl
         kQQx9XDihHzdVbrvmSIYo1GyGtIoQqYGoDGOGjAmB4bQXR6UTJCGqJv2C8CyvbOdnY2L
         hCf4xfNjNLYuv1ye36aD7Banm/2MmQMFCObHH/uV/n6sAeXgaloLoDl8rqV1MdCc4BDs
         L0RN0o4PXURKEsU+5935WQTN0xRwMmucHnY7lCkmvY7yzZkRVpqXmqEF58vxL4D0H8Ge
         JcnA==
X-Gm-Message-State: APf1xPA3HUt5mS1wAqsRkyGKabTvlW/3cfngOgLHkOgwPWc6xtlE4V/J
        rRUMMO9Tji9HsH2Tj4wCGc2g3AyMlp12FkBRIEZbhQ==
X-Google-Smtp-Source: AG47ELt6NW7aH4A5sy+Q8Z8P0opCc26g3Sih6RyWOLV9p1qqp3r5XZVmLJrl3/+hI7b8RwmTAVPlR49uxI13oHxs+Sw=
X-Received: by 2002:a25:f40e:: with SMTP id q14-v6mr2389759ybd.334.1519432567832;
 Fri, 23 Feb 2018 16:36:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 16:36:07
 -0800 (PST)
In-Reply-To: <OF65A78D43.F69630E3-ONC125823B.0057EE88-C125823C.0042D7B0@continental-corporation.com>
References: <OF65A78D43.F69630E3-ONC125823B.0057EE88-C125823C.0042D7B0@continental-corporation.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 16:36:07 -0800
Message-ID: <CAGZ79kZPFF-htksHsnRSDpScWoCLap5Az+s=09htx_0Tz2_u8A@mail.gmail.com>
Subject: Re: Issue in switching branches with different submodules
To:     Christian.Zitzmann@continental-corporation.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 4:10 AM,
<Christian.Zitzmann@continental-corporation.com> wrote:
> Hello,
> I've found an issue in git when working with submodules.
> My Project is set up using hundreds of components by submodules (and
> nested submodules), that are independent created in central development
> groups.
> Now it occurs that the structure of the submodules is changed over time.
>
> E.g.
> Project1(OldBranch)
>   - ComponentX/SubComp1 -> ssh://Server/ComponentX/SubComp1
>   - ComponentX/SubComp2 -> ssh://Server/ComponentX/SubComp2
>   - ComponentX/SubComp2 -> ssh://Server/ComponentX/SubComp2
>
> Project1(Masster)
>   - ComponentX-> ssh://Server/ComponentX
>
> There is both a repository for the old subcomponents, and for the new
> Component on the server.

ok, so you're saying this is all a client side problem?

> When trying to switch between the branches all git commands are failing.
> It seems like most git commands are not creating the SubComponent
> submodules because the .git file from the Component is not deleted
>
> A 'git submodule sync' fails with:
> fatal: Not a git repository:
> D:/Project1/ComponentX/../.git/modules/ComponentX
>
> Looking into the folders I see:
> D:/Project1/.git/modules/ComponentX/SubComp1
> D:/Project1/.git/modules/ComponentX/SubComp2
> D:/Project1/.git/modules/ComponentX/SubComp3
> D:/Project1/ComponentX/.git (file)

As a quick workaround to repair your current corrupted repo,
you can just delete the .git file, which presumably contains

  gitdir: ../.git/modules/ComponentX

I think this reveals (yet another) problem that we have with
with submodule names. Submodules used to have its git directory
inside its own working tree, but now they are encouraged to have
it in the superproject in .git/modules/<name>.

Considering your submodules
    "ComponentX/..."
    "ComponentX"
you may have a directory conflict, because there is already a
directory named "ComponentX" so we cannot store the later
submodules git directory.

> A 'git submodule update --init also fails with this folders
> Neither a forced checkout or a hard reset is working.

For this problem you could manually repair the superproject by
giving better names to submodules, such that you have unique
names, such that one is not the prefix directory of another.

> Similar errors can occur when switching between branches with a different
> number of components used as submodules vs. project specific content.
> As a result it happens that people are working with an incosistend state
> of the working directory.
>
> My expectation would be that, when switching between branches/commits with
> a git checkout --recurse-submodules the branche including all submodules
> is checked out fully to exactly the state of the desired branch/commit
> I.e the following usecases are an issue
> - Deleted submodule
> - Added submodule as replacement of local directory
> - Changed remote location of submodule (One component is available from
> different providers having individual repositories)
> - Restructured Component (see example)

I agree with this expectation and we'd need to discuss how to make this happen
as the submodule naming scheme doesn't allow for this to work flawlessly.

> Similar issues are existing when creating the new structure to commit it,
> but here the error is more obvious and people are manually deleting as
> much as required to get the new submodules correctly in.
>
> Best regards

Thanks for this bug report; I needed some time to ingest it and come up
with speculation on what might be the cause. (Not sure if it is the correct
root cause though)

Thanks,
Stefan
