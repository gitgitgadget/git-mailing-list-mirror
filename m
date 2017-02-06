Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6611FC46
	for <e@80x24.org>; Mon,  6 Feb 2017 10:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbdBFKfV (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 05:35:21 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:34161 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdBFKfU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 05:35:20 -0500
Received: by mail-it0-f45.google.com with SMTP id k200so20404382itb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 02:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N/nGmAXVTXBRqcGsN2WghzlngS2UtGndwNuNMTer3Ps=;
        b=clPzd+K6EN5CyQ2SV1v2w3xhl34oOitdIHA3uFmpqDTTN88qJEEDRLPCKErDRLvRqs
         uLKWSWKru4oP+p2GMZGz4XRjQ92hpxDZZgBcj92CFy6jzHhBGeIub08dEIRUbFzl9Y3j
         C+Ac+1Oab3s6LaGsjcPk/NKx51s9KzzH8Un9gMK0wiDKgQgFIcm8k+jqB4BG60n53SO5
         0hFctH+gblOqAKjwXgWpXLFh7YZVUL59f68Zp12i7+o+j8ImDD4Sa0c+yZ4+lgWZREBZ
         tanwl1SLniH6vCV9XyqRaMnoy+/gMYezH+QHzA6RDOSqPW+QMiXxUzWjdc4OEpdQr2jN
         8FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N/nGmAXVTXBRqcGsN2WghzlngS2UtGndwNuNMTer3Ps=;
        b=ff6JxauYxwEpGWeZ6/FMlAW6QKBg/mxNUUGtHD31/0ZcJWBiJbi6KesPC6vv2MGTxx
         xJkVVDsbZmW8Kdm1i4QH8F32iiDU0mFxfyfEzAAPQh620B2W/4Vso1OmmkqBLptgN/zS
         UqJc7zUfL3T1YMSBYC6YyQLXX+UB2wq5YHmM7Z6UG3emJwr5orduOtlSYqcvspoFCWZ7
         F+MKb8Du0MwHvqjFkKyqsXG6KK5mnXvif6DQ6wtLxSKOKAJ1gcHWCzMRxB+NzYwjmPSa
         ldhX5+DI3cl33VU18I3qBMh6bSp2Z30rMxzH0Zx8xfs5n7PWjm6l1zmoPDTQhPAPjkNy
         qr2g==
X-Gm-Message-State: AIkVDXKLy3cp3BQuiuokDNPl2bM+/j+MK7qnDibkejNo2rZrmdZ4P7mkOn4Fra515ZQiYKqD8186SdYTFaENPXzj
X-Received: by 10.36.40.198 with SMTP id h189mr6657908ith.114.1486377319652;
 Mon, 06 Feb 2017 02:35:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 6 Feb 2017 02:35:19 -0800 (PST)
In-Reply-To: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
References: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Feb 2017 02:35:19 -0800
Message-ID: <CAGZ79kaZUOO4qusCDF9=VJ-6QPjAvc5eSaazjWWEocRMHuTSug@mail.gmail.com>
Subject: Re: gitconfig get out of sync with submodule entries on branch switch
To:     Benjamin Schindler <beschindler@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Answering the original email, as I feel we're going down the wrong rabbit
hole in the existing thread.

On Mon, Jan 30, 2017 at 8:21 AM, Benjamin Schindler
<beschindler@gmail.com> wrote:
> Hi
>
> Consider the following usecase: I have the master branch where I have a
> submodule A. I create a branch where I rename the submodule to be in the
> directory B. After doing all of this, everything looks good.
> Now, I switch back to master. The first oddity is, that it fails to remove
> the folder B because there are still files in there:
>
> bschindler@metis ~/Projects/submodule_test (testbranch) $ git checkout
> master
> warning: unable to rmdir other_submodule: Directory not empty
> Switched to branch 'master'

checkout currently doesn't support submodules, so it should neither
try to delete B nor try to repopulate A when switching back to master.
checkout ought to not even touch the existing submodule B.

>
> Git submodule deinit on B fails because the submodule is not known to git
> anymore (after all, the folder B exists only in the other branch). I can
> easily just remove the folder B from disk and initialize the submodule A
> again, so all seems good.

by initializing you mean populating(?), i.e.

    git submodule update

would work without the --init flag or preceding "git submodule init A".
That ought to not redownload A, but just put files back in the working tree
from the submodule git directory inside the superprojects git dir.

>
> However, what is not good is that the submodule b is still known in
> .git/config.

Oh, I see. You did not just rename the path, but also the name
in the .gitmodules?

> This is in particular a problem for us, because I know a number
> of tools which use git config to retrieve the submodule list. Is it
> therefore a bug that upon branch switch, the submodule gets deregistered,
> but its entry in .git/config remains?

The config remains as it indicates that you express(ed) interest in
submodule A, such that when switching branches

  master->renamedToB->master

then we'd still care about A. As for the tools, I'd rather see them use

    git submodule status/summary

instead of directly looking at the config, because the config may
change in the future.

>
> thanks a lot
> Benjamin Schindler
>
> P.s. I did not subscribe to the mailing list, please add me at least do CC.
> Thanks
