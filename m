Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC5C1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeDNPoo (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:44:44 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42429 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbeDNPoo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:44:44 -0400
Received: by mail-oi0-f67.google.com with SMTP id 26-v6so1362617ois.9
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8dN7bg5uk4Evjffi0ao/kNf/hv6Qb9rsMM68bLAfEck=;
        b=e4dK96htltODrz7Rhgxt9wX1GGtGO20F8YxkZx8m9ukzvD88TMSkXNex4WktDhYinj
         qMwKuNPRmObdVIO9yYHk7IjbsLxYU7iCuVAvd6c4bF+aRof3sr5d5YCoEqDYZpg/9p65
         NbeZlUMOAxV1MhcXz0H6SUduWbiDOtwUXRsP+8go84nU8WqqKiBYIWTcK6NaAfwbtDUs
         l+TOfM420gnzhmG9MY8mrx9pKsfjtffKZ5hs6UF1q75CDc/WTL2vzy9GZ62JDBbUMSbz
         JKUVrM6jLLUbifwKcGtE99uV9l7+31kClgO7dRBoDAWPXy1iUMM4NuDiWuBvuXboWLAI
         BQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8dN7bg5uk4Evjffi0ao/kNf/hv6Qb9rsMM68bLAfEck=;
        b=e0Xk2k7ja1PB/iYC0dMnKg23c5Qy/6nxYqr8U+DfNXCTjVYGtuMz4ky20zieUpIvJp
         wk5nNutGumdgu+M4tihNu0gr8cgHyho9thjlIJos3g4SCYEGbJcy6ZXurV/nHd+JiHzG
         6RIxaJ7G9kklUa6ZZqdpL9DsPu5q/6P+TtP0lWCkhV3u7buT7q3RwXuWKBmXl+dCHoZv
         C1K2raJFXaEM4eXpum7Oca1zExY8+qMOQFwh+u3TQLpPFGXcJSZ7J6J1J+sZGqNP0Zne
         T/TB9n+HWRp4JSoYBjoMsclx2iGEEaas99xLu+aciKkatQa4Gp16Jfybhcm6+Wq51bpJ
         90RQ==
X-Gm-Message-State: ALQs6tBseWcNRzBg0WXSkpUvGF2XEPX/wYXIc6eL96oqQD6nPqNPo43K
        DGZCq+OCURAjGwaWIhWiI1lrowekFzdXtcxOH0A=
X-Google-Smtp-Source: AIpwx4/HFkb8X96mqGR5xrrR5nUltNG26RooOd1wOeDGqkEZxuwJNsOSa3mE8avw5E5zMWrBIypE4bS3LSs/XyC8W68=
X-Received: by 2002:aca:f141:: with SMTP id p62-v6mr11469595oih.56.1523720683440;
 Sat, 14 Apr 2018 08:44:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 14 Apr 2018 08:44:13 -0700 (PDT)
In-Reply-To: <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley>
References: <20180326165520.802-1-pclouds@gmail.com> <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com>
 <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 14 Apr 2018 17:44:13 +0200
Message-ID: <CACsJy8BqoW_YWBiMoOks+WM5XY7Mmadkd0LUBoUWLDXehx1GZQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 12:06 AM, Philip Oakley <philipoakley@iee.org> wrote:
> I'm only just catching up, but does/can this series also capture the
> non-command guides that are available in git so that the 'git help -g' can
> begin to list them all?

It currently does not. But I don't see why it should not. This should
allow git.txt to list all the guides too, for people who skip "git
help" and go hard core mode with "man git". Thanks for bringing this
up.
-- 
Duy
