Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0D71F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938951AbcIYOUE (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:20:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35379 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938708AbcIYOUD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:20:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id 133so10161780wmq.2
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HKJKMxuYKMmszSEr3FOYkyAEGQXUt6YM18uq1DcQwnA=;
        b=IxMSgIc34yBObkHbKA8Lp9HGrR7tj4iFiOZ6P+6frMequjDShX67zCJief4W+STpP6
         SoW295NAKEvj2RYrLhwRlCLVNTDD5u2intc/durWZ380hyRHWYBNIN6YNByLfCdzVZq7
         ENjIOjv9wMIRMHUQ02lw7ye4AMWuVDsGk4Wr8NuWiIQRBFPISVIMMBgB16JXfux7rv4L
         WNyMxvnXKf4q5oJAV6wS3dtYHAW70t7Pc4QRkFx+/wvhzPCro+Q2lKMnOWXV37qgDNWt
         0a9I/f2N2RsB4+f31gPhMarOwNtYK9YF40Vz7Zh5IgF77utq8ZYxASW56vsPb+e6Gejv
         IOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HKJKMxuYKMmszSEr3FOYkyAEGQXUt6YM18uq1DcQwnA=;
        b=YeX13s6yYLkmTCvuDHSQSIGKxoPasiaoADoTjP52BEPEeZgZG0BMRG7aFmgwDWNZ6t
         xbRQSYpf++fHcVNiq0/9WYOOYXswkdP84wC0kVM1dhl4QEu6bXPKgzfVHBsMP95qyDdh
         hsD/oNB+5P0W14zOwxjr0lESsDEcVgy3/hXDiogzjX5/E4LZXxmjF8O9PFzVThgzh+HU
         GRrPpuKfPCXwAJOAEDlgukKKN698DFsanGoOYqQDUKtXxBTT6PbuCQ01QH9uvDPI/GJo
         n/K9VVwb16yds1xYY9dLrPEGvJdXfK8i+wMPc9V0IUDt+jOqymxuKJ7LqBA+ICg0DPjN
         3CrQ==
X-Gm-Message-State: AA6/9RkqrLfhX6Dt+/ABlSTEmSDWQLpu7ZiKSLtNJl7+FJ3NuW6vJPwMb1TT846lytu/MQ==
X-Received: by 10.194.158.193 with SMTP id ww1mr2391996wjb.176.1474813202076;
        Sun, 25 Sep 2016 07:20:02 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id gf4sm17293929wjb.47.2016.09.25.07.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 07:20:00 -0700 (PDT)
Subject: Re: [RFC PATCH v2] revision: new rev^-n shorthand for rev^n..rev
To:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org
References: <20160925085511.12515-1-vegard.nossum@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Santi_B=c3=a9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ab725c6e-5c8f-d137-fefc-7f094ea7b7bb@gmail.com>
Date:   Sun, 25 Sep 2016 16:19:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160925085511.12515-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.09.2016 o 10:55, Vegard Nossum pisze:
> I use rev^..rev daily, and I'm surely not the only one. To save typing
> (or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
> we can make rev^- a shorthand for that.
> 
> The existing syntax rev^! seems like it should do the same, but it
> doesn't really do the right thing for merge commits (it gives only the
> merge itself).
> 
> As a natural generalisation, we also accept rev^-n where n excludes the
> nth parent of rev, although this is expected to be generally less useful.
> 
> [v2: Use ^- instead of % as suggested by Junio Hamano and use some
>  common helper functions for parsing.]

Minor sidenote: the above should go after the "---" line, as it should
be not included in the final commit message.

> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/revisions.txt | 14 +++++++
>  builtin/rev-parse.c         | 28 ++++++++++++++
>  revision.c                  | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  revision.h                  |  1 +
>  4 files changed, 134 insertions(+)

