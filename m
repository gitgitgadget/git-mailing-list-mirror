Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918371F404
	for <e@80x24.org>; Fri,  2 Mar 2018 18:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427580AbeCBSz5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 13:55:57 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:38070 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422764AbeCBSz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 13:55:56 -0500
Received: by mail-vk0-f42.google.com with SMTP id s1so6336227vke.5
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 10:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BssoJn7az5hNMVFZysxwGcQAd8cbZYweefKGBQ+tF7o=;
        b=sYc4F/grQTRjrtQyOiZsQukqpZQ+VBpxIUv2KI4D4h9kNzwgYVP6Spph6+d0wXgLtB
         9dxUMcu7zX89TAL0JjrJ7imHi0mIczCQpplbndnzbt73mVGGJKyCAiPRyGlDx9uwQih7
         rvDFHtsahtzO47vZQV3sI39av00FlEvSvlaVH5nGykmUNTbIw+wJSiJpSghmdNI7FkGf
         C1Yle3jwGKx2MxC2pUGPV/45wQr3qotokmiOGLDSOfOJsSATF05MU45mFy0Djm89lme8
         zZq0M2kfg9STm7bGT11IjkrsILXwz+z3Xqm2+J2J1qEvp9EAEwXE3knTAc9PNmqxFv2c
         SXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BssoJn7az5hNMVFZysxwGcQAd8cbZYweefKGBQ+tF7o=;
        b=AdDkRgII2wQRJFMnnVT6JMyxihnv44hh6whhR4secfbFtab73ZW0lFBEtPmJ3oS0P1
         bxibnKAbeCH1sx5sss7GMuaxDZq795NXKUiqTojc6vfZ/Mm92vCYsFWnuEzxDw3RKCPT
         NLp5TLx9iJEpxziJ0GZZbUdfM8mL2F+TI/5/VEPjmuaFpzn18g1zx1iniBv5c/Nw+uRS
         oeq46vL7QPOT8cdSZLBy/4Na3aD5srIy2iU8ZMzpb1tv+YrTCneihKbq/RDKB358q35x
         C+haeKPy2/aj+menkdNoBjHTF6cAFUmdyp3lN6ktz23/uLfw1qEfNGZ16ZTGHUya2cxk
         qzqQ==
X-Gm-Message-State: APf1xPCPQulRWFnYhA0ZNFR4mixPUomBn8b6uyODQEYODdJeS5BH9M8T
        deTiFIPg9MhX/ydJp5Ds9Yu5YEeamH5e/08PUgw=
X-Google-Smtp-Source: AG47ELvQh2GO8xtD3yrtI9ZzI71USPlr0nTiP0KMajAGmA7AO3XDk0RBI9R1iHNNsjQwsKnZyyNTiw/zgl5riKAPqYM=
X-Received: by 10.31.78.68 with SMTP id c65mr4432975vkb.58.1520016955322; Fri,
 02 Mar 2018 10:55:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Fri, 2 Mar 2018 10:55:54 -0800 (PST)
In-Reply-To: <xmqqsh9icsh1.fsf@gitster-ct.c.googlers.com>
References: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com> <CAM0VKjmRT-vdyxsXTk1FB4BMLc8z6968kapqyqx5djKof5hQFg@mail.gmail.com>
 <xmqqwoyucsom.fsf@gitster-ct.c.googlers.com> <xmqqsh9icsh1.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 2 Mar 2018 19:55:54 +0100
Message-ID: <CAM0VKjkBUXH0sTnyweA3wBEt0p3PJcC3DTpoMCHr=b21Ne+YYg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #01; Thu, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 6:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OK, I think I now understand what happened.  I misread the "fold"
> discussion and thought we were still exploring the possibility, to
> avoid showing uninteresting zero-status case to the users.
>
> If we do not care about that part, then it seems that the discussion
> thread is complete.  Let's move on.

I think we don't care much about folding, at least not in conjunction
with the patch in question.  And even if we change our minds in the
future, we can always add that on top.


Note that nowadays there is a _different_ issue that may make folding
worthwhile.

Recently[1] we started to run the test suite twice in one of the Linux
build jobs: once "as usual" and once with split index enabled.  If a
test fails in this build job, then it's impossible to tell which one of
the two test runs failed just by looking at the end of the build job's
log; one has to scroll back to the start of the failed test run to see
the executed command shown by the 'set -x' trace.  Now, if the failure
happened in the split index enabled test run, then this line is
somewhere in the middle of the looong log (even without the patch in
question!), which is a bit inconvenient to find.  If the outputs of
building Git _and_ the "as usual" test run were folded, then this line
would be closer to the top and easier to find.

Though, arguably, if all or most of the other build jobs have succeeded,
then it's quite likely that the failure happened in the split index
enabled test run.  And if the other build jobs have failed as well,
then, on one hand, the failure is almost certainly in the "as usual"
test run, and, on the other hand, one can check the output of any of
those other failed build jobs to see what went wrong.  As far as I
observed, the failure tends to happen in the split index enabled test
run most of the time ;) and I have a couple of patches almost ready for
submission to address some of the transient failures related to split
index.

[1] - ae59a4e44f (travis: run tests with GIT_TEST_SPLIT_INDEX,
      2018-01-07)
