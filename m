Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F3EC28D13
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 23:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbiHSXHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 19:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbiHSXH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 19:07:29 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD49B729B
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 16:07:29 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id cb8so4440924qtb.0
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 16:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZRLJM84oWuntgP5/l10ixt+z3ZzxOMuskZWFhOMqH7Q=;
        b=JbBlB1UXmdfdqTprUPptw+dNMIPM24FiKHJjMPANVkEHTcBGsQRl/LstppkfnolbJS
         /fU+IcodtwDqNq0f0GyrqZagRI2kKozK1zO09WIYux8VmD/5G3eml7iWdKlzkXFhyA7s
         XHP0psZb+9R/5rhwifzrrHLsy7RMsaUkBXirzOcKfcmG4HRdfwPSjQ9cqRwhX94XY2pO
         Vn5OXLMFz8FS3qM0VdcDhp8kJepl9M4nq7xA036uOXkELKuhpiMctArTCltAmt203lI9
         uIyRKr/adrlaEAHJDb1yzGPtwOtQ4q925kjbEda5tdocWk22vojko+W8eaK72uyCVbLX
         99HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZRLJM84oWuntgP5/l10ixt+z3ZzxOMuskZWFhOMqH7Q=;
        b=MKPyn6XViETJa34/b2seMZqNzZvvnYY+qmbOOj571sdwuCc8nZdAr5GrUpOliwfKJW
         p85RzL0eO9ep7bagRKw9iZ2avN5D+QJw/d/btp//UuleUz13ztU3+cvpZK9NwfKiFfRL
         qM9lJDbR+TiFmcfaSfyy+3iemJ0n1MARkhruDZHQUVgXpsq1aN4olH5s92lG9fqxw7py
         p05E8iFp+IT+vccltXzG/yYpcimMBl6rKZe+MM0RhdRXdXQe6imKfs8tHt+IsNaWAB1U
         GVG/SBm7jeylAOROTplBZzqxg+vhJJ1LQwC6oKeVuTcSwymKsskNwdiUaoNtyAw8Z3gR
         T6uA==
X-Gm-Message-State: ACgBeo16A60cNNNmlPstWxb5npcLxnWjoGcQPRLrT/WeW84AHtHVBXP+
        GaFPWYpB/h2ARTTTPeQ/lIavkas2qpB2wxgcybs=
X-Google-Smtp-Source: AA6agR714wzWHdRQYQ9BpdMFOeKR1Lbd5g37GpbA3w5GlR50x2XPvCxXic8TJ6/cfFc9DxSHWsT+FMmmXuFNu1NIhQ0=
X-Received: by 2002:ac8:5b06:0:b0:344:6481:86cb with SMTP id
 m6-20020ac85b06000000b00344648186cbmr8232811qtw.523.1660950448266; Fri, 19
 Aug 2022 16:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net> <892b2a45-1b6b-aa87-4902-471793135183@github.com>
In-Reply-To: <892b2a45-1b6b-aa87-4902-471793135183@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Aug 2022 16:07:17 -0700
Message-ID: <CABPp-BFoFBE4o1-M258-DHQSbW8WS2-EQCipCdmq2ECi9BL7pg@mail.gmail.com>
Subject: Re: [PATCH 0/6] unused function parameter potpourri
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 12:35 PM Derrick Stolee
<derrickstolee@github.com> wrote:
>
> On 8/19/2022 4:48 AM, Jeff King wrote:
> > Here are a few small cleanups of unused function parameters. The first
> > five just drop the unused parameters. These are all trivially correct,
> > since otherwise the compiler would complain. But I tried to make sure
> > that dropping was the right thing in each (rather than it being a bug
> > where the parameter should have been used).
> >
> > The final one just uses the parameters for an assertion, following a
> > pattern we've used before.
> >
> > I'll try to cc the individual authors for each patch.
> >
> >   [1/6]: xdiff: drop unused mmfile parameters from xdl_do_histogram_diff()
> >   [2/6]: log-tree: drop unused commit param in remerge_diff()
> >   [3/6]: match_pathname(): drop unused "flags" parameter
> >   [4/6]: verify_one_sparse(): drop unused repository parameter
> >   [5/6]: reftable: drop unused parameter from reader_seek_linear()
> >   [6/6]: reflog: assert PARSE_OPT_NONEG in parse-options callbacks
>
> Thanks for doing this cleanup. It all looks correct to me.

Like Phillip, I seem to also have a blind spot for unused parameters
-- this isn't the first one I created either.

Anyway, this series looks good to me as well.

> Patch 5 mentioned some choice as to modifying the parameter list
> versus using the UNUSED() macro. I think renaming the method can
> solve the uncertainty there, but it's also not necessary for the
> change to be correct.
