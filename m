Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00831C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 22:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJNWzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 18:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNWze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 18:55:34 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E94457D
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 15:55:33 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3573ed7cc15so59478657b3.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 15:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bpXAmlU17PiqNCQLd2KjeOuuJQo2E3u5FzdtEVKBrgk=;
        b=IH3tptUJPKjE6Fh7V6U1eJrFZ6eK/LJJP6YEwWd2a961mGdtk4dxnmxw/NnpGUNolc
         GxzOF/OI0+KGb6SNnwSCcKxfMdNPC7QYa9Uchmmhk2HbaLBcK75ab9iE5muOwuWJLEMD
         xzYs6DSdf9PhN1MvRMElurU1vGVjj0RRPvsJAVkXuvFtjxQEaHO3WEntCdZMRpGDtEwx
         NejF9P3oddZxJqsxArSV87uRaCFUP+JYhW4BSSFv5jLskg6zvHwqkqR6K19L27C2Dx1V
         7KLkZNwlFYarT4aBo/fXwwVxePRAhAIa8PPnKP3mVMIvVjqALnSNZfMKynhnv8Gmn2+G
         v6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpXAmlU17PiqNCQLd2KjeOuuJQo2E3u5FzdtEVKBrgk=;
        b=baDYC+mSXexUuRpIm+nab2Ix6ndihSxhs2OqkM2QKDJ1vJfGGblcRW1oH0x+rgtHUh
         KfSfbzZrdltSD7prk9mMPTI7REUbZaI9l7rXKrxA7/JR0RSnNttyRgALcKou5u86Wg9L
         ArQK+YW0x+hqdqV1l9gp6Xbe4oHlx7H1Zg079p/8TP6XGC+/34zZITabN3SUsyynsRqW
         ZGSTKIFlS5OfopvoJ6NdU5FlRZ5dujNqr8Zt8pQj0bNgCLkyABBGp6euk4jFrNXxvVHL
         s17yvxzK0zeJu0K8iZc0Qq0R85nnXFRBzIwgxM9MihKFZrVvJHuuSFaI0wNHRXJiq4YC
         xdHA==
X-Gm-Message-State: ACrzQf1wB4lwodqLusNmSOr+P+Esj/mOrjQSMq90li95sX5jYtclzD8i
        ycHiDLMLyNEaVHE2lQR+Q8zN83xGv7doOIFAkSnTnQ==
X-Google-Smtp-Source: AMsMyM7TPX0T2rdqcpKGxVuJQ3CQJtO1qizEak73p75iRiI2fpY3Gka2m8kGTwCPTx3R/phndehJMwspumzweV+39d8=
X-Received: by 2002:a81:8701:0:b0:341:9e24:5992 with SMTP id
 x1-20020a818701000000b003419e245992mr103931ywf.110.1665788132654; Fri, 14 Oct
 2022 15:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
 <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com> <bbaa2425ad0cbb4b945cdce3402c6ed5fab381ec.1665737804.git.gitgitgadget@gmail.com>
 <xmqqbkqe6qv4.fsf@gitster.g>
In-Reply-To: <xmqqbkqe6qv4.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Fri, 14 Oct 2022 15:55:22 -0700
Message-ID: <CAMKO5CuCbyFt739GOzcvFn92i8vNqK6vgJqvT8E5zs=kJ1+H=A@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] builtin: patch-id: add --include-whitespace as a
 command mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jerry Zhang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 2:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +--include-whitespace::
> > +     Use the "stable" algorithm described below and also don't strip whitespace
> > +     from lines when calculating the patch-id.
> > +
> > +     This is the default if patchid.includeWhitespace is true and implies
> > +     patchid.stable.
>
> This seems very much orthogonal to "--stable/--unstable.
>
> Because the "--stable" variant is more expensive than "--unstable",
I didn't realize it was more expensive, I'm assuming you mean in terms
of time, maybe it does
slightly more hashing operations under the hood?  I tried timing some
runs locally
and they were a wash:

time /bin/sh -c "git show | git patch-id --stable"
dddea79ee68d62a32cf8c0d7bb6691bcd0445628
4677fe858366a51ff3c5a0c0893418e32e934262

real 0m0.011s
user 0m0.003s
sys 0m0.012s
time /bin/sh -c "git show | git patch-id"
6602a3b2fe8b17d5bc295c2703901ad3e18eee18
4677fe858366a51ff3c5a0c0893418e32e934262

real 0m0.012s
user 0m0.009s
sys 0m0.007s

The operation is probably bound by process / disk overhead quite a bit
and a small
amount of cpu use wouldn't really be user-visible. Based on these
results I don't think
a user would choose --unstable just for the speed gain (if any).

> I am not sure why such an implication is a good thing to have.  Why
> can we not have
>
>     --include-whitespace --stable
>     --include-whitespace --unstable
>
> both combinations valid?
If you accept my point above, then a user would only choose
"--unstable" if they actually
had a need for backwards compatibility, such as for a persistent
database. Trying to include
whitespace on top of that would break the compatibility they're
relying on. So my conclusion was
that there isn't any usecase for the combination "--include-whitespace
--unstable", and it's better for
usability and not needing to always maintain compatibility if we don't
expose it to users at all.
