Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C0B1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 17:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964791AbeFRRo4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 13:44:56 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:37258 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964780AbeFRRox (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 13:44:53 -0400
Received: by mail-yw0-f170.google.com with SMTP id j134-v6so5936240ywg.4
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm81riithRv4oIDkEcIU81rWnMjJIcRprdXLymRMx0w=;
        b=lkghp3PR1kDkFWEL1MsV7Vf4Fh74qzgS+nTiDJevU2XeF1vXKzVrz9lz+0jQ1aDUOI
         z01NA45OGfSxeHOIbRdHcJqLE3zG6fxEPpS/SzCx9SpyrmA9jDoM7HN6TFJxCYHje25g
         K+1txPDSksxf4teucENLiBdRm12KAdQSh1UKMRlQUwl8+nT18wRhe4L7J6jodyfNxicK
         dlD4Cg7k7kxwqA2oomMdm8Ot3E+52rVxoRPeCQduNPxYmmb5p/ubCwDRo/14Q3eX6VC/
         6OyFSQ+O6CcTeT5fIL/rIiU8wjE9yM/3JWFxNtBPcwxPfJLvIGj2Nz0Kq7ihLyH9nGTC
         Axnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm81riithRv4oIDkEcIU81rWnMjJIcRprdXLymRMx0w=;
        b=UKN6phJo9s7xsDXWog1fF27YLSeosQYNyktCa2awxM334cdMLPvTCExbyfUyRICRXf
         Qp3VP3UxdwyFl71Or1rGqrJZ0+w6q8A2NApy45yp76ztBSBjbHiLghyMqANolh1iQzqf
         aDLfWRF8+mi0hOZOUuLn98dR+dJN4/dYiHeCyjKgcjVJCt3Jxf41og6ZTK4VYXJ/pU5a
         zh92UxNxmxP7TWrij6b8nHOmoh0j/lO0XT6o0jHScb0LCW/s7pO7Z8mIDFf2oF3n8RZs
         +vaQa4Mtxw0SilyJWJkgYoBkQDcLGXFoNHN4q5Q7PAws0+GPR97cpY+QbvKPvIDi+DZ9
         RhEw==
X-Gm-Message-State: APt69E1rrLSvnIV33w9EKUoT4I1g81L4Z/0P3TxhBdDk9HeCNaYtK1Cr
        sBSXdAhTkTZyjS/uC3wprD5n1AQnp+qhC5Qgn06KHA==
X-Google-Smtp-Source: ADUXVKJdFt2l3bd9eK6UGQZjNQ7iA42JygDn8pLSyTFXyVfFXct0jkw7Hj9CTRkBuD10LJCaJrYGAIRPTU78RSwAPFI=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr6482144ywf.238.1529343892707;
 Mon, 18 Jun 2018 10:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAH-HCWW2xUqO9HNfzaduXbn1PnwWinVJcTh9AG3Ubmq0LtAQLg@mail.gmail.com>
In-Reply-To: <CAH-HCWW2xUqO9HNfzaduXbn1PnwWinVJcTh9AG3Ubmq0LtAQLg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 10:44:42 -0700
Message-ID: <CAGZ79kakxmiePTybKbdgqGhgboeWFJeN4pmGHbqNorHYmf9QvQ@mail.gmail.com>
Subject: Re: need for `git submodule update` over `git pull --recurse-submodules`?
To:     samjnaa@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 17, 2018 at 8:41 PM Shriramana Sharma <samjnaa@gmail.com> wrote:

> Do I need to execute any `git submodule` commands separately even if I
> do `git pull --recurse-submodules`?

Ideally you don't need "git submodule" commands any more, the rest of git
is slowly converging to have builtin submodule functionality.

> All I want is to stay in sync with
> the cloned repo.

That should just work with "pull --recurse"

> But if so what is the use of `git submodule update --recursive` or
> `git submodule update --remote --rebase` or such, which is somewhat
> confusing to me I'm sorry to say.

The git-submodule command was the first command implemented that
dealt with submodules. In the beginning there was no "git pull --recurse"
but the only way was to run "git submodule update" to change
the state of submodules. Now there are better ways to do that, such as
the recursive pull.

Hope that helps,
Stefan
