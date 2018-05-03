Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B2B200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeECPOs (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:14:48 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:42820 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeECPOp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:14:45 -0400
Received: by mail-oi0-f48.google.com with SMTP id t27-v6so16389069oij.9
        for <git@vger.kernel.org>; Thu, 03 May 2018 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XHPZG5PjJfQ3FDMOrwUEuDdivAOTxGKSWPqgJkHBfJY=;
        b=qmQF4i1FAE5JLnZZztZ9EuIy77WioLTsqW9g+XHInZvWTehG6APzQS777ZOjQCG4GE
         /gc8zzw75+tppO1kAdNUqKaWGVSjrgym/6F2MmywF6NSyxaAwygt1e7YNduInfMG3dco
         0YH3wvaJsQRzOx+9ZwpSb9ry/KgdmP7AWWlom9RgGpozbesQiMqCb5ZIl0IXX+Hu5AIi
         oVKqGmNEX+w5SN5qHYSU7bm0n1qyGaRyXAecjlksXdHgB1JyTRFBirPEyQMyqPmmqpKn
         288EZy6V1i4OuE0Fq7H3/NTBv6I/pZYIoUvWXKSbOpWMiGfwQtkj7ASywsBLRdqz8cCI
         jlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XHPZG5PjJfQ3FDMOrwUEuDdivAOTxGKSWPqgJkHBfJY=;
        b=KDVk5IUs9c980Q7nq1z/MVCaBXkDV05opdHqBOcMbKOLs3wJ0NpkJz4pvNlv6OH8Dw
         1f2/jHaOys9RVz9gYfVIbcOxHaI7tlzGTH/8ry967xeX0WUn7NI2lr84BQc18kabFcx8
         nYzx5ElVqnu16OfJz/5N89KriRyFeQiFoAalOZ5KEFtdmSiIc/GmrPSTyU06MVP8cVnp
         MssNwmFw0Sz6xKFKYuMe51vZqdJpEf4qjhdW5Qo0uRW1Y6PCgurmkzX/NBMYwROp1bIT
         tvMAjVeH4EAHIaQ6BNZjC0+DSdnQavyHf9H4LsJaa/OTSrEJiNwF+EAsAtDIJOA2byqN
         0aag==
X-Gm-Message-State: ALQs6tCmgqMeu+0aKneRDIC+JnIgehBHimu1U28GZqpaTQMIA/M6bDv/
        cOGy7Yud/Qc2YHzGyDsMBykby2gtTqKy9j3MjgI=
X-Google-Smtp-Source: AB8JxZq1S7NLb9F0qKBu/MWfwbwVyDMGgrVCEKdcXf6cM7gwNJ/qp4WNzT6aehXwSDOVPPzkiwMqyXzpIIyhvXCV35U=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr15299868oie.30.1525360484632;
 Thu, 03 May 2018 08:14:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 08:14:14 -0700 (PDT)
In-Reply-To: <20180503131840.27956-1-avarab@gmail.com>
References: <87y3h1ykwn.fsf@evledraar.gmail.com> <20180503131840.27956-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 May 2018 17:14:14 +0200
Message-ID: <CACsJy8CYp3zVSRtS5ozHCitnWU81AamqEGR8RZdDkwujShEatw@mail.gmail.com>
Subject: Re: [PATCH v2] checkout & worktree: introduce checkout.implicitRemote
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 3:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Introduce a checkout.implicitRemote setting which can be used to
> designate a remote to prefer (via checkout.implicitRemote=3Dorigin) when
> running e.g. "git checkout master" to mean origin/master, even though
> there's other remotes that have the "master" branch.
>
> I want this because it's very handy to use this workflow to checkout a
> repository and create a topic branch, then get back to a "master" as
> retrieved from upstream:
>
>     (
>         rm -rf /tmp/tbdiff &&
>         git clone git@github.com:trast/tbdiff.git &&
>         cd tbdiff &&
>         git branch -m topic &&
>         git checkout master
>     )
>
> That will output:
>
>     Branch 'master' set up to track remote branch 'master' from 'origin'.
>     Switched to a new branch 'master'
>
> But as soon as a new remote is added (e.g. just to inspect something
> from someone else) the DWIMery goes away:
>
>     (
>         rm -rf /tmp/tbdiff &&
>         git clone git@github.com:trast/tbdiff.git &&
>         cd tbdiff &&
>         git branch -m topic &&
>         git remote add avar git@github.com:avar/tbdiff.git &&
>         git fetch avar &&
>         git checkout master
>     )
>
> Will output:
>
>     error: pathspec 'master' did not match any file(s) known to git.
>
> The new checkout.implicitRemote config allows me to say that whenever
> that ambiguity comes up I'd like to prefer "origin", and it'll still
> work as though the only remote I had was "origin".
>
> I considered splitting this into checkout.implicitRemote and
> worktree.implicitRemote, but it's probably less confusing to break our
> own rules that anything shared between config should live in core.*
> than have two config settings, and I couldn't come up with a short
> name under core.* that made sense (core.implicitRemoteForCheckout?).

I wonder if it's difficult to add a dwim hook that allows us to
replace the entire dwim logic with a hook? Doing this "preferring
origin" in a shell script should be easy and it lets us play more with
tweaking dwim logic. (Yeah sorry I'm getting off topic again)
--=20
Duy
