Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1C020C11
	for <e@80x24.org>; Tue, 28 Nov 2017 03:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdK1Dsp (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 22:48:45 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44367 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbdK1Dso (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 22:48:44 -0500
Received: by mail-qt0-f194.google.com with SMTP id h42so42008395qtk.11
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 19:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pWZLPijPqPNeqEfsDmTbHtDQ4phWhFz4h1mMoY5oXNo=;
        b=CKULjUfF+fHp9uLfBwCw7lBKr1kyqit4clPuaURgyLfDoHmnwFOJh+UTSbfxOTu31E
         fChCyBWpFN07c8xj4mWtSjxXTdDQOMYOTXW2N7tbO2ep8M4ydujq+iDanCxah+RKT/AA
         7+sO7odfPGSLG50enmdMRg6Ruov6Ajdi5pSLWrWNoUWLbEc7hK6xNiHmHkqTvgVuSRdf
         LCElONlXv+MyHt1PeHyBo3v6Pp76RXiUyuRsanACBesTynOdjZ9jCjYIB+4Myp6hPRHH
         NDAmBD7XQERh5T5aNBg2yOgUfzN1964oABw/qVoQ86ivydIZm7HkipDxxsUJNKFFrCtr
         n7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pWZLPijPqPNeqEfsDmTbHtDQ4phWhFz4h1mMoY5oXNo=;
        b=N2F8oz669f8+o0POT/hZmRCatKuQzZKRzClDBbYVeeh8Z9iN37E5XQ9wbJ0sZcfNSa
         ClnpbLsILhW9R+2yxN+1qbsT4yfodzGHrUYJjVamVWWtu9iGeyG+ZI+yVZrO5e6dDUn0
         GNe+S8527lsqcN+UiNhFTBCHZo7HV4R/DXdVJ0KjyfocmMc5k+HAFh5BF+ivTmXeFHEM
         JUcAAlA7rm8vnSXvJf8VjuqW2L/YkNHilkNN7Ht3wT26hrxT9VP8CnaRitqPQmWnayW3
         BxpGXa9w6h1X/0gevAMjyRVH695rHpN0NKIEn6NbVuedZaJM4kpBhnE/NwragHAduIqW
         ZqZw==
X-Gm-Message-State: AJaThX7Js4TfQWD8kBK8iMwBZ7q6+BEXFC+QJOq36L5XzogzUcXuVKox
        hrxa2R/0WMQWmvVNTrjagYpbpBezWLKkKJdCibY=
X-Google-Smtp-Source: AGs4zMacq/TyDX8og53IG12c1VydheonCQ0ZG3TBLPt2QgSrK8bdGXloIUrnJMesWAUyn9bLLvF4duq+tnZb/6b1508=
X-Received: by 10.237.35.37 with SMTP id h34mr65210568qtc.9.1511840923881;
 Mon, 27 Nov 2017 19:48:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Mon, 27 Nov 2017 19:48:43 -0800 (PST)
In-Reply-To: <xmqq7eub85rz.fsf@gitster.mtv.corp.google.com>
References: <20883815-0d9b-a4d8-cc93-0eb8b918551f@gmail.com>
 <20171127173621.6707-1-kaartic.sivaraam@gmail.com> <xmqq7eub85rz.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Nov 2017 22:48:43 -0500
X-Google-Sender-Auth: 9ibgFyYOfU56fu4ZoY6lcI1bJLE
Message-ID: <CAPig+cT3jbZ=VRWpggw_tvegAGnjGQ0Mxp8m2DdKKPhfKTVEWA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] builtin/worktree: enhance worktree removal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 10:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I actually wonder if this "early check and return" is making the
> code unmaintainable.  What if we instead did it with just the
> codeflow restructuring, perhaps like so?
>
>         if (!validate_worktree(wt, 0)) {
>                 /* OK, work tree is sound */
>                 if (!force) {
>                         /* protect from information lossage */
>                 }
>                 /* do the actual worktree removal */
>         }
>         /* remove the control info */

With this approach, validate_worktree() will print an error message
saying that the worktree directory is missing before the control info
is actually removed. Kaartic's original patch silenced the message
(and _all_ error messages from validate_worktree()) by passing 1 as
the second argument. That seemed heavy-handed, so I suggested keeping
the validate_worktree() call as-is but doing the directory-missing
check first as a special case.

But perhaps that special case isn't necessary. Perhaps I was
overcautious about having those error messages silenced. After all,
the user has explicitly asked to delete the worktree, so (presumably)
nothing is lost by honoring that request, even if there are validation
errors. (We could even add a --verbose option to 'remove' to re-enable
those messages, but that's probably overkill.)

> There is no need for a new helper function when done that way, which
> allows us not to worry about two clean-up places drifting apart over
> time.

I had envisioned a simple 'goto remove_control_info' rather than extra
nesting or refactoring, but that's a minor point.
