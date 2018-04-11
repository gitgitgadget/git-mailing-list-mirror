Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474A01F404
	for <e@80x24.org>; Wed, 11 Apr 2018 21:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755203AbeDKVO6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 17:14:58 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36603 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755075AbeDKVOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 17:14:55 -0400
Received: by mail-qk0-f196.google.com with SMTP id c12so1832470qke.3
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HvLd5MRqsGOvTuxjJoPXz1HYPj07kjPklVerWNDKML8=;
        b=k4DW2hGNF4H4F62Njv0lggfIzvn870HB3pTqOD4XBuwzfSl+lDqB203QHvCfAd//Ra
         glhllzLc/QXnhnUHNLUpQkoXn3TobFdv9bXmqjvGJZGJLhU95Iwudjs0rXtrYtKFB/Vf
         FUHHVd30eJS8LyOEyIgDadw/bZ+dQWtE/1n91ivFe4Bgu3IgxToD9LbuEnNO8EgNFs3z
         4iG15KIsJbjFqPmn0y9W89cqyDaYFGspTF3DBQYCJHcKlpzaIxuXHNYTAWZquXw2P0XO
         +869E0GO1KInfY2UuXbMAjCMIGpAcYJvyRGYlzXJohf0wTG/DrV8B4vVVT3G67p2PkUg
         hI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HvLd5MRqsGOvTuxjJoPXz1HYPj07kjPklVerWNDKML8=;
        b=Hywqo4zKTSQNIEzpRt/lwB+T4yZYrZzuHzDH1BdstQF+tzsnZsdJvnMpFzTDCUt3Pn
         lEfSKtRmlhTkBNAmJ+AK3VW+y6md3nPFh88Wm1rW1idj0ejvssEjgHA3BJXS4NrbMnn3
         rQly1cqXBZx/AhYcKenNgYZS1M0dnUjk15y1Adhsp3mjlHyvYkUvLMU0969j58K8RqJT
         jvYdwG8O3WO4qd9+p7TB9QEQrJnozlappFb8Gnj7Ef+nUlTKWGOCOjgtwDk0IKP4io3l
         4T74qgz1EJ3z6F832TStIXGmxgxF02nkY6D5+oK7cXPokBoGBHBL1daRU8oq7I77gfjc
         u5zg==
X-Gm-Message-State: ALQs6tBpdfMXhx2840kvsDngn1XZSIYnYVZgkF9HyP+BClVzTuCGgy3n
        jnS8rfojB/ROaOnPlLFN+V+mxhGtuVuK715v3vk=
X-Google-Smtp-Source: AIpwx4/RsHSyvyb+Rg4qYb9yOXUZIDnRoUmxJoNRSAN7bGjkvRfb7tv2qNYMnpcTYRrBTbU4s2t+2Y/+Ut3lr2BO7OA=
X-Received: by 10.55.159.140 with SMTP id i134mr8774433qke.220.1523481295052;
 Wed, 11 Apr 2018 14:14:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 11 Apr 2018 14:14:54 -0700 (PDT)
In-Reply-To: <20180411205015.GP2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
 <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com>
 <20180409193007.GL2629@hank> <CAPig+cRXsir3siZ5eArk6k1mF9kaDfFe1mL+T9faR6dxSUez7w@mail.gmail.com>
 <20180411200955.GO2629@hank> <20180411205015.GP2629@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Apr 2018 17:14:54 -0400
X-Google-Sender-Auth: QeTtV1Wo_fk92lAgaqm4yqI1g10
Message-ID: <CAPig+cSs1+Uxmguf7A11kZNvOagJDiSZHyETotMkcLJnbn+dNw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 4:50 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> And just as I'm re-reading my commit messages, I guess there was one
> more motivation for printing the "HEAD is now at ..." line ourselves:
>
>     If the '--no-checkout' flag is given, the output of 'git worktree add'
>     is just:
>
>         Preparing foo (identifier foo)
>
>     even though the HEAD is set to a commit, which is just not checked out.
>
> I think I can live with that for now, I personally don't use
> '--no-checkout', and we could fix this at some point in the future if
> we desire to do so.  I think we can consider that out of scope for
> this patch series, as its main goal is to introduce the new dwim.

Sounds reasonable, especially since the proposed "Preparing worktree
(_branch description_)" provides similarly useful feedback.
