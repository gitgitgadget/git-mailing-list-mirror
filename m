Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A733C1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeGSXa0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:30:26 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:39016 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbeGSXa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 19:30:26 -0400
Received: by mail-yb0-f182.google.com with SMTP id k124-v6so3923166ybk.6
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34BSwlCElmM3L4oMVqJseh9m4iTTenikCII4QrHUJcQ=;
        b=dg6tG86DlZtGSB3E18Xe3WdcWAR0Qi4RUhnQVrxW3sFDvhmvTUXWiigyL/AqZRKBca
         U8vGqyaRzmzLA60djAq4tXJqR2LvSwL38543DDjItKUXFVoNUTlu/Jt53ilZQ0+eBD/I
         4o74BntR1v1s2CYyVEsrHaZwPDXntdTn/Pr3QDFFdyRUCQp88bIgVFQAYoUYegLAFrHd
         eQL0mthtpCuRLkNkNmldJrXVth08S8D2JggCxKg5MUo37SS77HmJkWW+5fSqQEVG1Dcv
         0T9Pyabzht8h6XPuXOmkbbcNSFc9HswcCb6s0syJTZ9DgAn/6Vdwr1LFYYfnnUHbceiF
         /hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34BSwlCElmM3L4oMVqJseh9m4iTTenikCII4QrHUJcQ=;
        b=LgIThuPQYkH5Qbuh+GDx/R2f6IhE3Gz+z04+w1J6refcEfdP5UfyYVY6jviq0NRLJ8
         y4Y2ZfSC8P8tVcDe4/Z6Y7xlESYd7wGu6kI5Jg0KXeZdQrdlocwVHaLiAMDeMNhm58E7
         n4KAUckW3el6dhERtYSPg2tBnEPypvgs7Tse9qRObbCH18Z5cJv2Nc8Eue7gztxyW0dJ
         1npCITiRtkjKfpsczMLgeBT7ltTPe1AvYgjR7kFIaMiCVcAYYuGh01k5Fpr7+rIgYZZK
         2O3nd7CgRp6mC+TcbF/3sHLpocGQIqYmL7pSXUEdrjm4qVVDOjmNX4GSYWM93c1ZB4m5
         b09Q==
X-Gm-Message-State: AOUpUlGrzV+wdVVbX+V7fJrc6r8Qs3SjJ2Hy3SUXrp/K95cj8gqzl8Il
        mgEQ2O8A/KLSOyr9GnLW81qabb8jnPL4sjbGb8Rylg==
X-Google-Smtp-Source: AAOMgpdxgOZJAiKgxfKJ0+DylqAeC1p8nNYziDd0vmbUMzbaggG9K2qTrWaP1SnJjRBuYdlY6zPYJB7Z+ykd4OtyK04=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr6745070ybi.247.1532040313229;
 Thu, 19 Jul 2018 15:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <C00CED1F-D685-40E5-A5CC-4040BFD82886@gmail.com>
 <CAGZ79kbJnyRbeH8yMa=QaqNofA_Ek_SwmH5qRaCaq4cyQ26Kqg@mail.gmail.com> <xmqqr2jydf6c.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2jydf6c.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jul 2018 15:45:02 -0700
Message-ID: <CAGZ79kYAQwfHZBSVG6ShVO6FCBKVu3CeKJ7ZLsRGVkfV73WmYA@mail.gmail.com>
Subject: Re: Find commit that referenced a blob first
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        primetheus@github.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 3:38 PM Junio C Hamano <gitster@pobox.com> wrote:

> > If the given object refers to a blob, it will be described as
> > <commit-ish>:<path>,
> > such that the blob can be found at <path> in the <commit-ish>, which itself
> > describes the first commit in which this blob occurs in a reverse
> > revision walk from HEAD.
>
> You walk from the latest to earlier commit (because there by
> definition can be is no reverse pointer from older to newer commit),

but a "reverse walk from HEAD" produces the commits to us in an order
as if we were walking from earlier to latest?
