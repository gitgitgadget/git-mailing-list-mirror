Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70876C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566142071A
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbgGAPkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:40:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35876 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731473AbgGAPkA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 11:40:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id 17so23725417wmo.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 08:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A01sj1J1wzLzZkWtXYMDVTrJ5g3UJeIdy9fCeYIZBGU=;
        b=U/1s4KfOXlg+rSgt/GFFYjp8vNnfO/YU8SgD1NnI/Xmg3c/kp6iYsWG4YCrubz9EvL
         TIqJNcdrPpALgdovz4LluvAJOA3J5dPlphkwyYxglf/YaLu1mAWNyE2tXnq4UihTsZfv
         SgZKviMDDVcqbZcYYO7Z9PedacVDWWGaCOQi1Sw7wYoTtBjEyv0bMJxWCwnvQxFTCRmJ
         o+tCaNE88h2SjaZ5jKK30332U8OsPf4n4/0xci6w2z1kGDh8r48QfYOWJ+aDoycU2pRp
         gEJlRwzVr78/tZ4iSy2rc0uFQLMXWofx8S9DhrSfcmkCtCNWAuMl9yocqugG3ZBgz6Yx
         xydg==
X-Gm-Message-State: AOAM533niylXrUVW0JDXyuuB6ghoUy8HGAY2bsbf+NQRuTDMtQxJgzks
        XrmJQ20Wb3O5F0EWjepoWZdOAWt4Z8gUEinyCASs5Q==
X-Google-Smtp-Source: ABdhPJxFukrRtxAdxijEIbTJoaIX6YPXnKwIOCukc+lBORFDGfCsdfPWjhmdZ3A5S0qRgg/dgQktX9F+IA2UH5Rr538=
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr20881064wme.107.1593617998105;
 Wed, 01 Jul 2020 08:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200701093653.3706-1-ben@wijen.net>
In-Reply-To: <20200701093653.3706-1-ben@wijen.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Jul 2020 11:39:46 -0400
Message-ID: <CAPig+cS6XnUK9MQL68_yoR9Gve4_itmawsd_0-yJr3S5=3-zPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] git clone with --separate-git-dir destroys existing
 directory content
To:     Ben Wijen <ben@wijen.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 5:46 AM Ben Wijen <ben@wijen.net> wrote:
> I found an issue with git clone, when using --separate-git-dir and that directory already exists,
> it's content is destroyed.

Thanks for fixing this.

> I have created a patch set on origin/next, but (as I have learned this the hard way) please let me know
> if this needs to be backported...

Does this patch series depend on certain topics in 'next'? If not,
please base it on 'master' instead. This will allow it to graduate
from 'seen' to 'next' and eventually 'master' without being held back
by any other topics in flight. On the other hand, if it does depend
upon some topic in 'next', then it is a good idea to specify which
specific topics it needs. That way, your patches will be able to
graduate after those specific topics graduate rather than having to
wait until _all_ of 'next' graduates (which could take forever).
