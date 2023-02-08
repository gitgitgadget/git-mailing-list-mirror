Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232B6C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 16:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBHQTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBHQTl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 11:19:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E8125
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 08:19:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d2so15206158pjd.5
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 08:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7iRG91CpOPLME8uzeQqZzwiMLecKp2wY7DCH1kFuLc4=;
        b=LNYGIZIMr1grYJtRqJef68goMmXTrybkAyNh+jZgWYD7Nnjb5fDhCtTSfr3NJvU16K
         A8x1PCV1Jj0FGGuLFGAT2quyhdkIl1am/Ke2Kw5/p5zDnH+YX1Bww4dYLRv7uazeUZ/Y
         jGQQQbW4crxgnt6xugCMwTuJ9wwlOfYP47QUpCkxxa38w089NXeJr16Fr4QpRAf5tjDm
         3BDgKxNagunPziyzy2hecv4wbomJP/tPDq9EYmg2H1yzVxXkAWWoeAnDBPeB0stFP/Ms
         5JCAMnuUZd7dVrpObVD1+zXMR2qOIz3rDOuSjJ+xdwg91vQ1dcvzO1JJ7duL91RWs9LV
         pv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iRG91CpOPLME8uzeQqZzwiMLecKp2wY7DCH1kFuLc4=;
        b=xBab5SaAqrf49B3byCiEbUbgRM0+hSnGv3UgOB+FpzxYgmBoyHSS8SYqO4oah0z2HY
         5rELqgy71zGPH87zBJpU6iMhiiVMXVrlFhl3XpRkQ2c1LPSmZ2YDfxmW2tCYT5TfKdh4
         jLB/B9hEMoJ9pW/Pawa4xAFvKjC8ofgfUqAR7rNSAr4hoOdKuwFgIu+j6WGlKlH1T2Tx
         9htUYLCA+QOcRXB68s+HMjrJvraZ8nt1GXdeBvRBrXmtWxd07YcfRlaaT/Ky4blvRzj1
         I5x6TFmerBSvw09hLCrGiChsOtmQdivWQesWA2zOU/J2Q4tTSHJuvYk+uoRHyHD278T0
         L0aQ==
X-Gm-Message-State: AO0yUKXL9M1DmlojemrqILX875p4to/TaeY0Jt23lVGwqhlelRJ4ivSf
        wWvnlGiKUXA9hgqBBfRCV4Y=
X-Google-Smtp-Source: AK7set/XKX3BGktCmQ1Bpd/wsAD4DdwJHC0iM4mVWxg4QS13paNAfKpGbUQV+mrb9ZQgs9IorHgNMA==
X-Received: by 2002:a17:902:ecca:b0:199:1825:a98a with SMTP id a10-20020a170902ecca00b001991825a98amr8569643plh.37.1675873180184;
        Wed, 08 Feb 2023 08:19:40 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id jl24-20020a170903135800b00196503444b0sm11302357plb.43.2023.02.08.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:19:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     git@vger.kernel.org, Roman Dodin <dodin.roman@gmail.com>
Subject: Re: [PATCH] remote: align columns on -v
References: <20230207235238.1850757-1-kolyshkin@gmail.com>
Date:   Wed, 08 Feb 2023 08:19:39 -0800
Message-ID: <xmqq5yccuo2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kir Kolyshkin <kolyshkin@gmail.com> writes:

> Currently, git remote -v produces a misaligned output when a remote name
> is more than 8 characters long (i.e. longer than a tab step). Here's how
> it looks like:

The condition under which URLs do not align is not when they are
more than 8 characters long.  If all of your remotes have
10-character names, their URLs would perfectly align, no?  The
description may need to be tightened if we really wanted to do this.

But I am skeptical, even without my devil's advocate hat on.

> giuseppe	https://github.com/giuseppe/runc (fetch)
> giuseppe	https://github.com/giuseppe/runc (push)
> kir	git@github.com:kolyshkin/runc.git (fetch)
> ...

The current output allows programs to post-process by splitting each
line with a tab, but this change will break such practice and force
those who use such practice to do something different (like "split
at the first run of whitespaces or tabs").

> While at it, let's keep the \t in case some tools depend on it
> for parsing (there will still be trailing spaces in the remote name).

That will not help avoid breaking the behaviour for existing
practice (they did not need to strip the whitespaces, but now they
are forced to).  It only make the output uglier by putting mixture
of whitespaces and tabs.

So, I dunno.

Thanks.
