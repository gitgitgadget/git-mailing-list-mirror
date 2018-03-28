Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F031A1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 04:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750732AbeC1EJC (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 00:09:02 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:43260 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeC1EJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 00:09:01 -0400
Received: by mail-pl0-f50.google.com with SMTP id f3-v6so44442plr.10
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bFd4o6lW9nXz3bjt+pwmdqqL4men941q3rlvNJZ1EGI=;
        b=cgiQ81eOs/05n1Zs2R5UYwSQuiS6+wMCCHJTf0e+MjFCGmpUl0+wUIDv/uu63GqmLT
         hyUJ+2X5dpSHBFsYn9QlwymJHDjdB1aRK/ncfrdh/uURaCY0z5xluh45RgPjEJUC7dgw
         rA+6h4rn/glS3znAhHf7eB6EqbD5wDWftTmXTBurVZ8bqLK6Wdml1pDgbv8pd5QhAASs
         HibSiUSJV3cdBYTrZMh0plzBAbN6lHYSlOqDew46S4R+kyS/hxqCQoJNWzAVdkxCOvNw
         LGlzzZNUm8uTFFJZiMIdOIAt66CQRXHmwx81PmGMFPNuzX2le9r5l+yIUxZZVlf2J0ZU
         vigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bFd4o6lW9nXz3bjt+pwmdqqL4men941q3rlvNJZ1EGI=;
        b=IMHYm0zzZdXEl/jEZu+uCSaYTJ8tHfiFvzSzX1j4gxpiHe73mSB10zxmQm64vZoKj4
         VvKSftE3WqbHA/J5AK+HTJ7D0Zwgk00Eq6pS9Avp3GAnu/9EU2ziuX5YsZVtR7LoyNDc
         sI5a5LFAe+aI34gHgRnA2bvnBAmpr3Gy4gSuqLnHfUbEkK/aIBuShoP/lrMjr+pARYi0
         GQW6F+r13VFVP8JnFmeZORXRbhROtED//tj3lsScAV14CmNvvNBTWT4wiNK5SwWY51dx
         03QJCNAFNiG/Yjc2Lv9blcuBMM2ZSb9c/qWokUhtrS4CzZUHyCtAkqCDo+KGqGGtovMO
         Dyog==
X-Gm-Message-State: AElRT7G66lnhkZlT/8A+TKdYDFzpHqgUjfMx8fUWpYXJRiIjZNWhkjA5
        W3WpLhsge1dZCFEAiOxbKwVy/kphhg6DAIzNFtE=
X-Google-Smtp-Source: AIpwx4/J1WFK1ADwwWJ2/ELmVj1Gu7DcoWfIn+zDShlQeXUAvvatspph6dV9oxsYeXEUOkQQiSNTnEB6EDlK8YRRXRU=
X-Received: by 2002:a17:902:8481:: with SMTP id c1-v6mr2054582plo.304.1522210140833;
 Tue, 27 Mar 2018 21:09:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.141 with HTTP; Tue, 27 Mar 2018 21:09:00 -0700 (PDT)
In-Reply-To: <20180327232824.112539-1-sbeller@google.com>
References: <CAGZ79kYGY5bjh0WPQh7xkXQxLkB9EQ-OcJhVuGE8YUnwmvk2Fg@mail.gmail.com>
 <20180327232824.112539-1-sbeller@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Mar 2018 06:09:00 +0200
Message-ID: <CAN0heSpG9zq1bFawid7MoaVQ--WXPv=cXduhjjV=Q3kcK2TMeQ@mail.gmail.com>
Subject: Re: [PATCH] submodule deinit: handle non existing pathspecs gracefully
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, kumbayo84@arcor.de,
        pc44800@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 March 2018 at 01:28, Stefan Beller <sbeller@google.com> wrote:
> This fixes a regression introduced in 22e612731b5 (submodule: port

s/22/2/

> submodule subcommand 'deinit' from shell to C, 2018-01-15), when handling
> pathspecs that do not exist gracefully. This restores the historic behavior
> of reporting the pathspec as unknown and returning instead of reporting a
> bug.
