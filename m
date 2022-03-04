Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D4C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbiCDSr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbiCDSrz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:47:55 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79FA8A6E9
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:47:06 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j9-20020a170903024900b0015195e68490so5116672plh.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=evRtAHxcGyTF4HIMCNCGXylECyJyLVP/Vc9aLMMojVk=;
        b=kT9DeBlSSfMSagK+V33SUTogiQ5oIscp3fRe4VtAzluHqUiR8lYrQJn0Pq4HuIyUA2
         HO/gtV6aJjVzmOOJzDt8HJ/E04wUEUSe3TpS7QO7SSUQK2dc6EcJqvA0AN7yM48K2+oY
         UzdiPkG7/pAJam0njvR9OWxDb2YlVMlM8tLsjo1V22o8rkfVQkvg0sscYKakdu04lkB3
         FZGaPQybQfYP5NAEqda5B3z4XQu88o2aAA5peWAMffCcvIbV7TINm8VFdyCOjYQ//nPm
         x4muY+TMfVr50cWgZOOTh+tTqv7NIE04jPS9K/RF4sPKQyRUb5c5E6DokSPhCS6Tyx1C
         lxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=evRtAHxcGyTF4HIMCNCGXylECyJyLVP/Vc9aLMMojVk=;
        b=4KLlihjvsaHqYmvO9wtb8jz5OcLs9P4WneR0L+oC5GRa9uuYfwdrM5CzAF6z+Yk+ah
         LOVYpJdcw6yIOpdAPw0Hbf9YLd+wojJRpuXBUGzFIzBcQlJxP2ShkpjCEG4QKxeaSVpD
         /5LX63ECnDTLKiIG4SbwTpuolegBoj8HTqbyCwIbzGK07HrYRAv/tmNKP6249Nvd+l3E
         O69gcM5Uv95f7O7BoGh7fY8Xo7jc91nlx5cllUca5LpXAvj0TxyZNX2uwEYBL2to29Np
         WWOse9L42VrKdz2fObEogguZbJ4NNfuSW2kAsOBsJyuFTTYqx6gi6o+JenLObamlNuum
         kxLw==
X-Gm-Message-State: AOAM530S8k86qgOzzgNeMtgTIJ1ZLrbjEl+y3i5RK8Ng6k1oG+xIDmTo
        nnjAeg9dpavZIlHX7AcMD3FcdUyXQubd9g==
X-Google-Smtp-Source: ABdhPJzgN0OGY3bVuU1YtQ2JD7fAI66TsFeyOJ9wOrYXHCflTwL/KzjB6CME0UzR3UpRPk0BVsiYtPdPYJ++Ow==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:ddcc:0:b0:4e1:c248:d4a7 with SMTP id
 w195-20020a62ddcc000000b004e1c248d4a7mr72459pff.63.1646419626193; Fri, 04 Mar
 2022 10:47:06 -0800 (PST)
Date:   Fri, 04 Mar 2022 10:47:04 -0800
In-Reply-To: <5353fb06-09e4-77bf-554c-1cd750158730@github.com>
Message-Id: <kl6lilst4kt3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com> <1a9365c3bc5b810a60593612bfba97a8b0c1d657.1646166271.git.gitgitgadget@gmail.com>
 <kl6lczj2exbn.fsf@chooglen-macbookpro.roam.corp.google.com> <5353fb06-09e4-77bf-554c-1cd750158730@github.com>
Subject: Re: [PATCH v3 6/8] read-tree: narrow scope of index expansion for '--prefix'
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:
> There's an (admittedly subtle if you aren't familiar with sparse index)
> distinction between a "sparse directory" index entry and "a directory
> outside the sparse-checkout cone with SKIP_WORKTREE enabled on its entries".
> Ultimately, that's what necessitates the two checks but, as in [1], I want
> to use this as an opportunity to shed some light on what 'unpack_trees(...)'
> does.

Thanks! This explanation was really helpful.

> Using our example above, suppose 'baz/' is partially expanded in the index,
> with the following index contents:
>
> H bar/f1
> S baz/deep/
> S baz/f2
> H foo
> H foo1
>
> If we use the prefix 'baz/' here, we actually traverse the trees properly:
> 'baz/deep/' and 'baz/f2' will be found and merged - no index expansion
> needed! But if we only checked '!path_in_cone_mode_sparse_checkout(...)', we
> would have expanded the index because 'baz/' is outside the sparse cone. 

In particular, I didn't consider that a directory outside of the
sparse-checkout cone could be partially expanded. This seems to be the
crux of it, which is that even if the path is outside of the
sparse-checkout clone, we can still get correct behavior (without
expanding the index) if its entries are expanded...

> This presents a problem because index expansion is *extremely* expensive -
> we should avoid it whenever possible. That's where checking
> 'index_name_pos(...)' comes in: if the directory is in the index as a sparse
> directory, the position is '>= 0' and 'ensure_full_index(...)' is called; if
> the directory is inside an existing sparse directory, the position will be
> '< 0' but the index will be expanded implicitly. In every other case, we
> avoid expanding the index and proceed with the merge as normal.

and because of this, we don't always need to expand the index when the
path is outside of the cone, so my suggested patch expands the index in
too many cases.

What I also didn't consider is that index_name_pos() doesn't _always_
expand the index, it only expands the index when the directory is
inside a sparse directory entry.

So the side-effect of index_name_pos() is actually _exactly_ what we
want. Granted, it would be clearer if we had a function that did _only_
'expand if path is inside a sparse directory entry', but I suppose it's
overkill.

(Purely optional suggestion) I wonder if we could add a test that can
distinguish between 'always expand if --prefix is outside of the cone'
vs 'expand only if path is outside of cone AND inside a sparse directory
entry'. The scenario you described sounds perfect as a test case, though
I don't know how feasible it is to set up.
