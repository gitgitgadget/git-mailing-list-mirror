Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E811F609
	for <e@80x24.org>; Wed, 28 Nov 2018 20:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeK2HMj (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 02:12:39 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:51893 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeK2HMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 02:12:39 -0500
Received: by mail-it1-f170.google.com with SMTP id x19so6497321itl.1
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTlBp6oDhyJDJs4jK9feFVYpY7KfUIsJu0b4suIi/u0=;
        b=a4Ie4TTVj/1N70ygnXrw5pCHkoPaTWuqMzSszisPlCGhw0oTGF08UtAxRSfKc4BVDo
         inyWnG95EpHGAiXr6QzaGub4qlrdQH1elZvaiqsITMZMSJemHWrH2z+lldh3eFtKj67s
         Rk4OAxThDLRwdI3g/ZB5qbbuca892JMHzxnk7mft48QJuLRqtxk0RCuaLtpf+VG/kAQM
         z3bILis6eL3LGeAc8YRpP4gC8wrrCgRL4OXJqJy3dJu/64EfNRrueCz0UKIodjS+lqH/
         LY+5ARUuHU6vvBH9+BbDaiy8DLYeg5JavWlNC8/j8HfVDV37YQKwCQlLvbTH3SICk5Jd
         s0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTlBp6oDhyJDJs4jK9feFVYpY7KfUIsJu0b4suIi/u0=;
        b=ONgpS0OjBlezQhIt6ovBjdXWJutD3gqCbjlEQJ6pqO2GjkhOaFSf3rI+h5YueL0h+P
         xTSM8PitC3iF1TJUzFsBBb8hLIazoKqBs0VAIbrfOSIlX/w35MF7+YnBzptsenT7blo6
         vnQyH8h0QDS4EReSYNsiRWME8pTvD7mmhuDu9/um5+GuxO1LjF6/A8y8hvTBluU0gGCh
         5xXvhgkFWFBWy20lTclIi9sR+SSCMu3BFw4IwYfBWU6rOgnm9YhcuoM0vODkhPISRCDa
         vRVd57UUJac+48mGNIdIqn89MAFYRL9L6B08GPzdEIrwSQYyl+Rt7rjnwSrMOIOt32QU
         a5dA==
X-Gm-Message-State: AGRZ1gKfPD0NxKG9o9oRuntWhqgYTXc4dHLzb0rkn2NyLB5eNFDQ93FA
        lAnI3Rggz/SEo/Xior3W6nQkaM3yV6n5ZWU36xA=
X-Google-Smtp-Source: AJdET5fbQuMOxoMP/cijIYVv4Z2BF22mA8WHypsooJnCLpvpKsHtB5udJNCo7guQb65FjOZanA+5FZqNkWJJyYQHfZY=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr32374799jak.30.1543435789226;
 Wed, 28 Nov 2018 12:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com>
In-Reply-To: <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 21:09:22 +0100
Message-ID: <CACsJy8Cv9ZwWEs-wsOtms3JCXo7x8fL_PBatcb0TgvrrQuMUdg@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 9:01 PM Duy Nguyen <pclouds@gmail.com> wrote:
> should we do
> something about detached HEAD in this switch-branch command (or
> whatever its name will be)?
>
> This is usually a confusing concept to new users

And it just occurred to me that perhaps we should call this "unnamed
branch" (at least at high UI level) instead of detached HEAD. It is
technically not as accurate, but much better to understand.
-- 
Duy
