Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD34C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 08:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiBZIzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiBZIzo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 03:55:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BDF1D9B79
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:55:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h15so10467097edv.7
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQlUKheHksESm7BZM2aMofytnoD+CcbJIazHIn+PFjg=;
        b=FF0nqDU6hE9Ka0Ym0pHVdyhAbOSzEHTvfLZWl7KV8EY+qTmty0+vbQrk6itcSF0pFh
         CQO5BzCILwWKT5IIohKPVcCmH5EK+9vlu94fTuKXawJTSvhOq5L2RxbPsQ6gFwb2C2DR
         x2lHe1uRSxSp0waWZVI+ohN6TFUjacSZqxaf5IcabOOH+I5MdQRvoHbOMziAHpCt9TJ1
         WD+v9ds/ObRAeXBEOBVJ9O6Qqj+UdusGNYYjGttkn4wKwy1bLEn5DgJfbHHFOAcKB3lL
         soq8DsZW6EaIpSk0VUqQ81prcpRzDnAlqo+IgtkSByPjn6k0CKZmFxa+2eKTzdhRVzA6
         y8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQlUKheHksESm7BZM2aMofytnoD+CcbJIazHIn+PFjg=;
        b=6ezAzG7vIsohtDvmNMuCQ+YN0zxOyYtvCXmfGVZpQXPHMSiJlif4mgZN8rQh3H9/1J
         JaxLBmBC0FIQtx87dwscUT1TTrX/ParUfjaJmez/0OXxNCAM3VcSj9NAonudnGidDEHz
         igVrDhZbsf+/oCI8GQET/4tvxf83UyNYVHdINpoXSz6TiEi41MGYGbAZSr+F+TcFyKXt
         7x82R6Bh8E/tBuN4/s/hmAzm/JVw6SCrab/auO3oz0e1q9XFcWLsIEb1fhWQ8uE7tXxk
         74AMafGgAQuFsvGDUGT2apLfziKYK1xubIFUY0/XIfsPLE6i8iFuUwwpAM+mKZGXOGFT
         gWcg==
X-Gm-Message-State: AOAM531sPHL1XdrSvPyp3AcG58Z/0mqUpeRnfYQ7iSIJcbtJe9EkMwgw
        HImKpfRUDTqbn2aVb8SKLcmzCEa/0JMSd5shoLTsSXTNARg=
X-Google-Smtp-Source: ABdhPJwvAKnSm5N2VNVlRP9setZQwoBI9cZQX4BpxNh/L99bHXgEm0gRK/PDVmnuonVzXb4HmIqmswUa8s/yo0YVD8o=
X-Received: by 2002:a05:6402:491:b0:413:6c2e:bb2c with SMTP id
 k17-20020a056402049100b004136c2ebb2cmr6765428edv.196.1645865708569; Sat, 26
 Feb 2022 00:55:08 -0800 (PST)
MIME-Version: 1.0
References: <xmqqee3q73e1.fsf@gitster.g>
In-Reply-To: <xmqqee3q73e1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Feb 2022 00:54:57 -0800
Message-ID: <CABPp-BG++YqesTxp+JL3XzwrogfMag1NscoMpCOExmV9z6Py9A@mail.gmail.com>
Subject: en/merge-tree (Was: Re: What's cooking in git.git (Feb 2022, #07;
 Fri, 25))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 7:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/merge-tree (2022-02-23) 13 commits
>  - git-merge-tree.txt: add a section on potentional usage mistakes
>  - merge-tree: add a --allow-unrelated-histories flag
>  - merge-tree: allow `ls-files -u` style info to be NUL terminated
>  - merge-tree: provide easy access to `ls-files -u` style info
>  - merge-tree: provide a list of which files have conflicts
>  - merge-ort: provide a merge_get_conflicted_files() helper function
>  - merge-tree: support including merge messages in output
>  - merge-ort: split out a separate display_update_messages() function
>  - merge-tree: implement real merges
>  - merge-tree: add option parsing and initial shell for real merge function
>  - merge-tree: move logic for existing merge into new function
>  - merge-tree: rename merge_trees() to trivial_merge_trees()
>  - Merge branch 'en/remerge-diff' into en/merge-trees
>
>  A new command is introduced that takes two commits and computes a
>  tree that would be contained in the resulting merge commit, if the
>  histories leading to these two commits were to be merged, and is
>  added as a new mode of "git merge-tree" subcommand.
>
>  Will merge to 'next'.
>  source: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>

Let's wait.  The extra data needed to handle Dscho's usecase might
still suggest an output format change, and the command is intended to
be plumbing-ish, so I'd like a bit more time to make sure we've got
the format we want.  Also, his comment/suggestion about -z affecting
"Informational Messages" section is also interesting and might be
worth doing even if it doesn't provide all the things Dscho wants for
his usecase.
