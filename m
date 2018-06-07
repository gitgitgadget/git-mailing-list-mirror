Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B47B1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeFGFYg (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:24:36 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37225 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeFGFYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:24:35 -0400
Received: by mail-ua0-f196.google.com with SMTP id i3-v6so5644870uad.4
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UEW3Ha7UKbm/25Kw2G/3JFVf/WZsIlgo/yvZDS9ViH0=;
        b=dH2aaunEDfTFvQ3rCNyr79yd2npVdjM1/oL6GTj2EoZTCTGrpTaGszWkf3eAB0HQH1
         0g41gGx+lVq7NHn+03pMlhJfQR/4fmfrn7goudeAvT1xFnLovvpE9FHRSFdibwoadTnm
         pPeDRuO5Y9hk9h87zvtJyiokLGkOaKVwG7IAoBS1jkMRzs+MdmMK1A1SZzX8VGRA982s
         KEkznRLaf797E1yHWZDdajAtWd1YpeaBGL4jsogMkKsTD4kvEPiVl02hPjNXECP6OVrr
         2iNUzx3tdXbkmzyQ8DvbuuSpyzQqooEfQ04Z5eV7WnWKidg3ehscapRFBEgISkccvoh4
         NZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UEW3Ha7UKbm/25Kw2G/3JFVf/WZsIlgo/yvZDS9ViH0=;
        b=iEgl1pRonbvOHKuPNnjf0gxF06RdQpn7ujauSIf3JlzNsk/1EZhDk3GBLLy3OJxcys
         XqeqRFJJrdYUbvXJM3zf4xhtG+oQ41gADHHYLzWx7wZQ/pI1govrUQvMJ4jbadbIeZ8r
         X/XgO1YrgZtJmJt9aBmad6RkoCYLAlG6zrWUZTWoddm9LGmhnCZTz6mF0vkjbohR/4HP
         qxj2Cg43+0Vwqfa/PmsxxDaAG5im2RLJ5ZOd/+VsFe5To4zZubzJvqzRSzOly6s3TWvN
         89aQwLpIL5hAI8B43rgL5Rl2+WjcBQdP4Zl8ee4lX1fk4oMfHzKTaJ+5jT9/H2VGNrJN
         DeXQ==
X-Gm-Message-State: APt69E1HR/5y4FbngYzWoqpEkmnK6sB8penzRsgTtqp6v9Jc4YvMsSeo
        DYjastklAqD+bjdrIJjievdDuIAMlb+eL1P0iGU=
X-Google-Smtp-Source: ADUXVKJ7W/w0OWLXaMIv19NwUnhBdraUjSsPya+ujVE9GuV+TSjMwAPlQPHVOYGeLKZmZA+X9u7hUeMPsG4/QAh3jHQ=
X-Received: by 2002:ab0:596f:: with SMTP id o44-v6mr247227uad.29.1528349074701;
 Wed, 06 Jun 2018 22:24:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 22:24:34 -0700 (PDT)
In-Reply-To: <20180607050615.19598-1-newren@gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050615.19598-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jun 2018 22:24:34 -0700
Message-ID: <CABPp-BEJncFwszHvEX1U9FGz6AwjOEb2mTj0=iNt+60m8uB_2A@mail.gmail.com>
Subject: Re: [PATCH] git-rebase--merge: modernize "git-$cmd" to "git $cmd"
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 10:06 PM, Elijah Newren <newren@gmail.com> wrote:
> <Comments for after diffstat:>
> I tend to think git-rebase--merge is less popular than the other rebase
> types, leading to it being more overlooked and less well tested than the
> other ones.  This git-$cmd usage seems to support that argument.
>
> Anyway, this patch may be irrelevant if others agree with my goal to
> delete git-rebase--merge and implement --merge on top of the --interactive
> machinery, but sending it along in case others don't agree with that goal.
> </Comments>

I would forget to pull that out of the commit message area and put
that next to the diffstat in the email.  Whoops.

Oh, well.
