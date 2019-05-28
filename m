Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C211F462
	for <e@80x24.org>; Tue, 28 May 2019 22:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfE1Wsy (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 18:48:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32842 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1Wsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 18:48:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so303432wrx.0
        for <git@vger.kernel.org>; Tue, 28 May 2019 15:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3aLkwPIzcxgPeIQG4PFRW7KboCDQc4lBAVATfpiJXRU=;
        b=feSBAotMB1xnrcgyDnIO6zgKi24W8cApa/aSn3Ng5tx+RWqEGjdCHLZvua5UG6UQs2
         i0UBWSQfV/Z1m5+oAIox9MCM61l44WwVf6NBLQkC+N5z9khCcP7obxqyx32Xtzyy24nV
         HLuo9zTY1qMQ0QqavpSAnj38gGfeqIJ1YHJpoat2hBKTPWh19aLUXfxEbM8fw71wSeT8
         VFhU5Crzm1Pd16hO2m3+V95ESKuaBwcZa52eGqXvNcUnsL0Qpqu4Za2cqWBa284vce4N
         FHtN5HDpeN9pZx+ju0aF8/RyU5Yfkl+9+MjNEQt0GET2ThCjXUC3X7IVMPqP2nCTF2lq
         j2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3aLkwPIzcxgPeIQG4PFRW7KboCDQc4lBAVATfpiJXRU=;
        b=nZul3HsWOrEqJETcN0ndqD4gvwWA+Q28pcp2Q+UCTSMeIMxNLPFLH/eje0aTrF/GkB
         cuDP9MQN55qzYeFz9rlfVvATUJteCwBzF+yCD0RkjaLefTjDEWRdIv+n+JMiF3nfT6JA
         riuQBFbhEMUIiCG3tuUoHr6COHVQkiwICgEbXumqWSIHrOH98qWKezsn/0Foiv+O4+Vc
         ZerflaMnrwp/gfKlz5PJbbVOL5AprJk2Apfy3jRXcX87fAyXRL9XrezjdPsx/9gtyccy
         KbD0hdRPRbt4uX/G3qx/hXTo+IHbFsfETWrYroCBmtgzBEP044LMYfHuJN5s6k5kPH/f
         pLlA==
X-Gm-Message-State: APjAAAXbFkOOZ4XTebvXrQjZUgkrrtkKqE6odpvP59nNYHdzelCVVnLJ
        hY1OQMFrC7aW/YNI/hauhpEiXamm
X-Google-Smtp-Source: APXvYqy7FTz4KALavlhERgA8AJhzTYIztjnCb0qbEJpjAt+24a+hImxaFvxuKiCCV5VGjMg+t1ShYw==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr24216496wrt.150.1559083732136;
        Tue, 28 May 2019 15:48:52 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d26sm3583188wmb.4.2019.05.28.15.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 15:48:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Dominy\, Patrick A" <patrick-dominy@uiowa.edu>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fsck finds duplicate entries
References: <2FFF873C-0FCB-4E5F-BEA2-BCE54A623D1E@uiowa.edu>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <2FFF873C-0FCB-4E5F-BEA2-BCE54A623D1E@uiowa.edu>
Date:   Wed, 29 May 2019 00:48:50 +0200
Message-ID: <87d0k2mbzh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 28 2019, Dominy, Patrick A wrote:

> Hi,
> Running git fsck against one of our repositories yields the following:
> Error in tree xxxxxxx: duplicateEntries: contains duplicate file entries
>
> We are struggling with the best approach to resolve the issue.  We=E2=80=
=99ve used git replace, which successfully creates the replace reference, b=
ut fsck still returns the same duplicate entry error.
> The commit that introduced the issue happened some time ago, making going=
 back to the bad commit and replaying the commits a daunting task.
> Any suggestions would be much appreciated.

At this point you either rewrite the repository or live with it. To live
with it see the fsck.skipList documentation in git-config(1). I.e. you'd
whitelist this tree as known-bad.
