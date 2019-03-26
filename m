Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F2620248
	for <e@80x24.org>; Tue, 26 Mar 2019 14:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfCZOfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 10:35:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36038 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZOfi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 10:35:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16so1717015edr.3
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Ee1wtuE4QgIePqqRPBuee7aV6XnYf0gqBjuSCPRG0E4=;
        b=GiWSYYHUMNXNVL61EYgW/vM1P4ReUwGeVnvssNVTzZOmV5a/ciMDl0eyVN7qUY8gWI
         jQFyH9pYDmTyoXkXc2B6Uk6D3PZ0SqCb4Jq6NyDlWAhoga6jnGqMxbKtMOl8GI0MkhEh
         DoITF7hWH7nM8xQo/wpNa09t8drbEjbGlEWtxdChYhCwbg2onkwGDfBgciE5rLgjgsBf
         1RH8W+0C39Ot+XAXNpWQy/vdrq63tBy/DMZk8VAIPjhZCF1FM6UIFvkspxxy/zmDCQrt
         xIlq+0moSHUooz0RAuVxXefK4l03tegMb5ZCBq+y0fiPwWCHUAwGM0em4Ty8LwtzHNqA
         Tf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Ee1wtuE4QgIePqqRPBuee7aV6XnYf0gqBjuSCPRG0E4=;
        b=BIasKgIouLbZXHfiriFNYJk4hIATPaJTdigDODGHJnMgtWpw+b/6ppGA2b7NpQX5f9
         3NOEm3kjl58VfLI4iOT/rQX3NNonNCBR+UWwJLE76lG8vogxNyiy+MT1ph4ghTzwWonD
         N9jpmV0hbKmXqOTrBzbHoKEJa/UT49h12J5RZCTekjCsiBRrO0kLNLDS4rmoDpSd5I72
         iOBt+k2CUuslTscEnu/HDpnUnpqPH1RGtzAj0p7XLrtzfm/oSy2B9SU/cB67o94zEamk
         roal81mugSZ0EwfB7WxpapoArQuqSv2+AX0nXLnB/ItJQorUmOWGC+mwPB1RbWTO5dZ0
         RDeg==
X-Gm-Message-State: APjAAAUNFOh+r1srTblkbvUs1RsbjGIztVx7qf4hOM4JCDI5Po2DusRG
        nfuIc8dWO0vIe9Fx4PSO7Ug=
X-Google-Smtp-Source: APXvYqxlkpx7oBeshCDQ82KuzEHwIoKzPdev4nxoHVtlO72P7ZEwR1c60cpDQr09JufoAx1p74W7/A==
X-Received: by 2002:aa7:d1d0:: with SMTP id g16mr20809912edp.109.1553610937138;
        Tue, 26 Mar 2019 07:35:37 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id w6sm4145105eja.50.2019.03.26.07.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 07:35:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase: learn --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <cover.1553354374.git.liu.denton@gmail.com>
Date:   Tue, 26 Mar 2019 15:35:34 +0100
Message-ID: <87bm1xbt55.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 23 2019, Denton Liu wrote:

> This series teaches rebase the --keep-base option.
>
> 'git rebase --keep-base <upstream>' is equivalent to
> 'git rebase --onto <upstream>... <upstream>' or
> 'git rebase --onto $(git merge-base <upstream> HEAD) <upstream>' .
>
> This seems to be a common case that people (including myself!) run into; I was
> able to find these StackOverflow posts about this use case:
>
> * https://stackoverflow.com/questions/53234798/can-i-rebase-on-a-branchs-fork-point-without-explicitly-specifying-the-parent
> * https://stackoverflow.com/questions/41529128/how-do-you-rebase-only-changes-between-two-branches-into-another-branch
> * https://stackoverflow.com/a/4207357

Like with another series of yours I think this would be best squashed
into one patch.

Maybe I've misunderstood this but isn't this like --fork-point except
with just plain "git merge-base" instead of "git merge-base
--fork-point", but then again 2/3 shows multiple base aren't supported,
but merge-base supports that.

I'd find something like the "DISCUSSION ON FORK-POINT MODE" in
git-merge-base helpful with examples of what we'd pick in the various
scenarios, and also if whatever commit this picks was something you
could have "git merge-base" spew out, so you could get what rebase would
do here from other tooling (which maybe is possible, but I'm confused by
the "no multiple bases"...).
