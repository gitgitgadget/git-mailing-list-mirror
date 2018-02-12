Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CDAD1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbeBLVhH (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:37:07 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:44100 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeBLVhG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:37:06 -0500
Received: by mail-io0-f181.google.com with SMTP id z6so18911482iob.11;
        Mon, 12 Feb 2018 13:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CInzmcyBsvG91oBlhAaFqXVNJO0bmZxikj2QJEY/qsc=;
        b=D8/MZHH1+uobKtG8rL3QvdJhDT3iohxilz8HPqOsHx8ciFFM6zxcPloUUraqZ0H6Az
         o0nWnjW1Aq3+2I57ZQ5PZd4XNR7GDkznMUOMAe1xp1IdzNdqnVJcMLG19/EyEtG7u2Q+
         z6v4EHBLNbauT/gjOS7Y6BdhNLZ3tMBBhEe3WY0Zz7IBsPgfP2TPa+MXwhCs1zy4uqDB
         SArtbcDugItjjsa0qui8x2fGEtLw/svv3dTebc3uiyjoQltyVk9Eyeq1ajbgPhNxtISb
         4yZ46cEgtyLGa4apxEROrdLcuLVkRawzLvo8i6fRyCKjV1Gkfvp4dbkbfK4irhGdGVJN
         It6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CInzmcyBsvG91oBlhAaFqXVNJO0bmZxikj2QJEY/qsc=;
        b=RElkMCa928yxzx+KzvRoEMGrJROovPmtQPoZzAeXoyKk/AmGTTiRQLjuD0lJleTszu
         SgQ9Leg6XgB+oWdjvTQDVKvBZAfS4fOyHvEZusUxNrV3Z3Jyha/s33L2wTKeyLqJVqcE
         rurr3rJ1Z93VgeUkibzFMrEMOHAjac4vj6C0z62lpnHx8JkzXX7LAH1hJXOCt4pe3Kpd
         RtxjuZTDxz11IUrAGi/agsguMjwZgHFv1Md1xRJHnOA+YiIIXVcsWXzkRTwG5aW/QchB
         w5sLfxAl/fQ7IsFdpy3Uk0WaMucSaLI17nKFBYUMncbO6KFMGUPX9oLQsSOZHZbKLg0n
         25Zg==
X-Gm-Message-State: APf1xPABPZVXgyuDMtlTkM5+3aX+TPLk0yjrxdTYSQkA4NsgcU4m7AWN
        Nx0FO5X5jKNlkpkvfpU3PG0bgsdh+DC3cSDgxmg=
X-Google-Smtp-Source: AH8x224FFU4aYxIF8BjQupXZ2fFtCI5r52QuvlglvU8tT8nbRNW7l3RzPVhzmR99ysePBV24b20lbNV/rjVXIOyPCII=
X-Received: by 10.107.132.18 with SMTP id g18mr3264709iod.46.1518471425227;
 Mon, 12 Feb 2018 13:37:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.135.221 with HTTP; Mon, 12 Feb 2018 13:37:04 -0800 (PST)
In-Reply-To: <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
References: <20180213080036.3bf3a908@canb.auug.org.au> <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Feb 2018 13:37:04 -0800
X-Google-Sender-Auth: yZypYrjvgTauC04HjSreCF1XlgE
Message-ID: <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 1:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The reasoning is to avoid losing the signature from the tag (when
> merging a signed tag, the signature gets inserted into the merge
> commit itself - use "git log --show-signature" to see them).

I think the commit that actually introduced the behavior was

    fab47d057: merge: force edit and no-ff mode when merging a tag object

back in 2011, so we've had this behavior for a long time. So it's
probably not be worth tweaking the behavior any more, and maybe we
need to educate people to not update to other peoples state with "git
pull".

Maybe we could just tell people to have something like

       git config --global alias.update pull --ff-only

and use that for "try to update to upstream".

               Linus
