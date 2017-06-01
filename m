Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9A320D12
	for <e@80x24.org>; Thu,  1 Jun 2017 01:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdFABwo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 21:52:44 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36527 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdFABwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 21:52:43 -0400
Received: by mail-pf0-f175.google.com with SMTP id m17so23115830pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 18:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E74Oh6Kyj+9yWKzp2kUN3RSJClZWC5ot2UoFgOA+tjY=;
        b=QZJmXockkYyTAaAfDE+3PMUcGAmjaKIUplczh2O56DRDCj+VRtRIqtCghUXsWwf41Y
         BEGQ4fxGIH9cZrRn2yVlCh86ueuQgBvZQDyGDb7ambhXd8EClSbBx7k0GPaERB9N0HPk
         jRW+ZxCgcAEz1mZ/0fbKeHVwGEyi5Ag7X8GJKAlpywvMj8O+galkukf/9holkrGchdrd
         cQXwxlMhZb4QrJEZHfer6l5S0F36qrDXXhWV0Zi3BX4RK74dG3nPb4+S2iIhX/1bLK6c
         BwPQNLXohjkzBhc9ldd+3o69Nk9rGVeN7XP1liualYft5IY1MQXeB9UF6CKONOryBe5u
         ik1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E74Oh6Kyj+9yWKzp2kUN3RSJClZWC5ot2UoFgOA+tjY=;
        b=tLUMDLkZei56rNaJ0ykJ4eAsTrV3sylGbuPKsoSLIiAtYJFXveYBrKf0upwegSuOat
         dy72889uxHc6I4yXIS0kGDOmfg3ZOku+CCdxgzfYMpHm6iuqptNjBb1WLyMcXcO95P4t
         Mrh9swrdWUStr4WsmFwU+fOJau24Z9mgj0jGLdLq7OCUZFtMx8aMlJvCfR7mtxxuSTES
         9Pe4JIRcECv+1gr9A3U0Syh7W62atau0SPzhMCfdXVnTsoMLYDCcgy+5xeSyuoE/Otn6
         CnddhZzKKnrI37oMDbYdDgLWZmAyo1KXyMU3m9/Y0UNDqDS2DXkV2Z8/lCqm9YJiVp8F
         Rg7g==
X-Gm-Message-State: AODbwcCrWXGBVUVD2ZuR/5lNxYLrf0VxeN+OUnzGzoewpfch9EbkhtJn
        LqgVo2QD6ysXRSieWhM=
X-Received: by 10.99.227.81 with SMTP id o17mr35885862pgj.41.1496281963251;
        Wed, 31 May 2017 18:52:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id o66sm30875627pga.64.2017.05.31.18.52.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 18:52:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tyler Brazier <tyler@tylerbrazier.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] pull: ff --rebase --autostash works in dirty repo
References: <0102015c5166284d-d8dd6534-a8d5-452d-af14-d827934ef593-000000@eu-west-1.amazonses.com>
        <0102015c5c7054ac-5ec72a28-ff81-42b8-8224-26a588cef485-000000@eu-west-1.amazonses.com>
Date:   Thu, 01 Jun 2017 10:52:41 +0900
In-Reply-To: <0102015c5c7054ac-5ec72a28-ff81-42b8-8224-26a588cef485-000000@eu-west-1.amazonses.com>
        (Tyler Brazier's message of "Wed, 31 May 2017 02:58:04 +0000")
Message-ID: <xmqqbmq88oeu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tyler Brazier <tyler@tylerbrazier.com> writes:

> When `git pull --rebase --autostash` in a dirty repository resulted in a
> fast-forward, nothing was being autostashed and the pull failed. This
> was due to a shortcut to avoid running rebase when we can fast-forward,
> but autostash is ignored on that codepath.
>
> Now we will only take the shortcut if autostash is not in effect.
> Based on a few tests against the git.git repo, the shortcut does not
> seem to give us significant performance benefits, on Linux at least.
> Regardless, it is more important to be correct than to be fast.
> ---

Missing sign-off.

Otherwise, nicely done.  Thanks.
