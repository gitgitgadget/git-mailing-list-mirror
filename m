Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9B362027C
	for <e@80x24.org>; Mon, 29 May 2017 10:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdE2KRr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 06:17:47 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34885 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdE2KRq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 06:17:46 -0400
Received: by mail-oi0-f42.google.com with SMTP id l18so73966005oig.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wzHv8CCWoX8LmGayVcjv83BT0mxvOfGUiqvbeeRdmzM=;
        b=AZWK3XIweehyemHpvTiG58HiEBytyC3gQ3r5McDR9fBFozD5PxNVFMj3k18kKcC2Zj
         H+lHI2Rzlh0r83aJnILNhHI04lMnYJ7yuIl2YUWBCkoj+ZwJAtgCgJZHzSDZYUUwzYWO
         XPrJlvB1VA1NjRVzfpVTKXC15tV2/DpgeBdqR//Ah2CRomjcTJeiEFK28JMzINIjgakJ
         h1t5If15B0LX/YaIc6zpRYwzUW1i6aBI0zU8vMsCGzrir3YWQVp8zL4AGv90VlNsoyzN
         SVRZcVspl8VTOK4kDkvVzo5QI9KzT6JyDOeOuOU8fgEfZvdV1NGngXEP7W9fanct//8v
         9aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wzHv8CCWoX8LmGayVcjv83BT0mxvOfGUiqvbeeRdmzM=;
        b=XWFW5UwG3ehvSXy9o5twh0NjEqbN8VceTeGitAsaRTL/MWfI4TdXrC7QMQsAxQCOrm
         hzGVzZk1AclNKtFv2CjPIfBQC4k8CdaB3QvGqFG7NW+hn+x+eYqwPxKp0yoYEe9f/6UK
         +PuAzyBiIaqWicKoNZty7+/ni3OIJHimlivU+hTZo2pSnhMN6vXztT6NLLD2buOlEGVz
         QVqdTCGoBsHRydHDHj5HTQIb17skCB4apgy/eXa6V6an6FhKCYZRtJkeJx4ySzNIqYs6
         dWpG3HiNBpro8DEEupa1vjym3pHro3LDjNs9ePgpqKxDpTj6IBVMHpFrV1b4jvSeB0+Q
         1sEw==
X-Gm-Message-State: AODbwcD3EM+alZYu7tDIJBft7uQk1TLkKGxGD3Nd4Or8RkXPFCKuT7mZ
        4zpsCtvrZrvWo0VvViy68tX/DtShhQ==
X-Received: by 10.202.213.211 with SMTP id m202mr6879858oig.153.1496053065724;
 Mon, 29 May 2017 03:17:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Mon, 29 May 2017 03:17:15 -0700 (PDT)
In-Reply-To: <xmqqshk568s4.fsf@gitster.mtv.corp.google.com>
References: <63F1AEE13FAE864586D589C671A6E18B0D6B8C@MX203CL03.corp.emc.com> <xmqqshk568s4.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 May 2017 17:17:15 +0700
Message-ID: <CACsJy8A691aGfKfa7h1y7A3sgnWgDm_eLA5tj78ES1XjP+mK5Q@mail.gmail.com>
Subject: Re: git worktrees must exist even if locked
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "taylor, david" <David.Taylor@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 5:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "taylor, david" <David.Taylor@dell.com> writes:
>
>> The original report was against Git v2.12.2.  I have since tried v2.12.3, v2.13.0,
>> and the next branch.  All exhibit the same symptoms.
>>
>> Even if you ignore the original scenario for creating the problem, if I do a 'rm -rf' or 'mv'
>> of a tree that contains within it worktrees, that should not break the use of Git with
>> worktrees that live elsewhere nor commands that don't require a repository.
>
> Duy, any ideas?

We are supposed to tolerate missing worktrees if locked. I'm guessing
that lots of changes in get_worktrees() lately may perhaps forget
about this and be too strict on locked worktrees.
-- 
Duy
