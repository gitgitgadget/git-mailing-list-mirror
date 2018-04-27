Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1258B1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758761AbeD0REA (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:04:00 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:42169 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757569AbeD0RD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:03:59 -0400
Received: by mail-oi0-f41.google.com with SMTP id t27-v6so2172313oij.9
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=059uWetl/986FbD6WeHXIgBcrvaafVOKpaiL83Es30s=;
        b=K1Lk2SAc/69ATBH05YuQke8/wZkaKF8nyABM28FGbD5//gT/qDvOGFFm7verIPhROL
         RPnBapcV/6JPuUi1+fnYr+pRWVbRx/eETuE2z+OWlFX+L/jtLxe36ZuuhdY/GADgZsBF
         9G2jNLclCzqj/PjfALfRrKjsCWjRKov/9xA+GeQe3LUCZorleQltqgu8/MfAWFrGPqsN
         CTiDV0/nC1DhUFGk4xDw5TLEmld4ZrN1bmV4r4ZgeRA5XA8/4pB3fXfjvlqY+qEBQdTQ
         xodlb5MO0XBeR4l6ntkBMQ1t5nOXBoGYWOabJlx8bMDhahVpbZSL+rK19vyoXzzdu60O
         VMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=059uWetl/986FbD6WeHXIgBcrvaafVOKpaiL83Es30s=;
        b=JC60qeyjimPQefwhcpQ/jkNHCS+mJqc3A29qvmZ+LizVE6XoVWD3H9QJo7rCgpnfzv
         hU6MtwFiaP4Ufqw4s6cvRDB/GNtME2qMK94gO3ChmdJ46bRzLxJ4Zn+qf9ChOp+WumUE
         A6fI+GZWB+zxkMa9TyUiZFCWypCYSisF3lQOtpf6f3tPA96HMVaBOzK3XcGq/TB3sNST
         xlw1FjVT4/7loEZJlL6fOHu3PqGheqjRnE8gO8QYhjpJH456WZ3XFbHH3Xj5iQDNdyPr
         nm9y/fdi2ds4mjX8HA+mFYhc7PAuWvofpWUaU55axj3WM7kQQZ8alUJV5r5sLY9tRk51
         IsDw==
X-Gm-Message-State: ALQs6tBvfQ+jEdU0RkgCV097kQJlhhIDXshCthLb6RlEZ/YcmcgoPDm6
        CpwAnkZ59dj/8av9qSwi8p4v1VV/fU4YEmdJwxq+yQ==
X-Google-Smtp-Source: AB8JxZqSXvGCni9+RUKtDceXBHorQ9j1atS4RkYyt1d7pqiJaxl8/FpoTbG1N0q/6zzXq3AE/GvJq6jlnzEZ9idi3XA=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr1813627oie.30.1524848638399;
 Fri, 27 Apr 2018 10:03:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 27 Apr 2018 10:03:27 -0700 (PDT)
In-Reply-To: <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com> <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 27 Apr 2018 19:03:27 +0200
Message-ID: <CACsJy8AVTkqDomQW7Np5opnK+bMk53pcMtCQRBr-=QXEXs8Nqg@mail.gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 5:18 PM, Marc Branchaud <marcnarc@xiplink.com> wrot=
e:
>> The best approach to do so is to have those people do the "touch"
>> thing in their own post-checkout hook.  People who use Git as the
>> source control system won't have to pay runtime cost of doing the
>> touch thing, and we do not have to maintain such a hook script.
>> Only those who use the "feature" would.
>
>
> The post-checkout hook approach is not exactly straightforward.

I am revisiting this because I'm not even happy with my
post-checkout-modified hook suggestion, so..

>
> Naively, it's simply
>
>         for F in `git diff --name-only $1 $2`; do touch "$F"; done
>
> But consider:
>
> * Symlinks can cause the wrong file to be touched.  (Granted, Micha=C5=82=
's
> proposed patch also doesn't deal with symlinks.)  Let's assume that a hoo=
k
> can be crafted will all possible sophistication.  There are still some
> fundamental problems:

OK so this one could be tricky to get right, but it's possible.

>
> * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are
> identical so the above loop does nothing.  Offhand I'm not even sure how =
a
> hook might get the right files in this case.

This is a limitation of the current post-checkout hook. $3=3D=3D0 from the
hook lets us know this is not a branch switch, but it does not really
tell you the affected paths. If it somehow passes all the given
pathspec to you, then you should be able to do "git ls-files --
$pathspec" which gives you the exact same set of paths that
git-checkout updates. We could do this by setting $4 to "--" and put
all the pathspecs in $5+ [1] e.g. "HEAD@{1} HEAD 0 -- path/to/file" in
the above example.

There is  third case here, if you do "git checkout <tree-ish> --
path/to/file" then it cannot be covered by the current design. I guess
we could set $3 to '2' (retrieve from a tree) to indicate this in
addition to 0 (from index) and 1 (from switching branch) and then $1
could be the tree in question (pathspecs are passed the same way
above)

[1] I wonder if we could have a more generic approach to pass
pathspecs via environment, which could work for more than just this
one hook. Not sure if it's a good idea though.

> * The hook has to be set up in every repo and submodule (at least until
> something like =C3=86var's experiments come to fruition).

Either --template or core.hooksPath would solve this, or I'll try to
get my "hooks.* config" patch in. I think that one is a good thing to
do anyway because it allows more flexible hook management (and it
could allow multiple hooks of the same name too). With this, we could
avoid adding more command-specific config like core.fsmonitor or
uploadpack.packObjectsHook which to me are hooks.

Another option is extend core.hooksPath for searching multiple places
instead of just one like AEvar suggested.

> * A fresh clone can't run the hook.  This is especially important when
> dealing with submodules.  (In one case where we were bit by this, make
> though that half of a fresh submodule clone's files were stale, and decid=
ed
> to re-autoconf the entire thing.)

Both --template and config-based hooks should let you handle this case.

So, I think if we improve the hook system to give more information
(which is something we definitely should do), we could do this without
adding special cases in git. I'm not saying that we should never add
special cases, but at least this lets us play with different kinds of
post-checkout activities before we decide which one would be best
implemented in git.
--=20
Duy
