Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922BC201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932880AbdCKMi2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 07:38:28 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:35225 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932711AbdCKMiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 07:38:22 -0500
Received: by mail-io0-f175.google.com with SMTP id z13so63015232iof.2
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 04:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=91AwU1QR/kyfPZgJZSKjvuJV0ZhgE8NTYhN5ViINZws=;
        b=GnYpPhko8E2j0bfv0tS33CoX16o1SUsMI3Wp8sS/20N8U1WylZUf1uEVApara//z/l
         EVvngIISXVJX9bFDJESYVhvcOpEXRB+7xNgK6PyBiM1Z5UrnU2QoVJSlTtbv3O6zZInF
         SOtvjxoKDPBucw3NL7sI/3n+CQ7HxVjm3/MPU/Ke7yCCpyyO2a4i3cAMemZufMqZd5R2
         xardr6fppDwDnvcccHTnbobxgPO2Hh8MmZgd3nNIGAniDjhzmBhcialDCUSNQDythyhY
         Sl8jq1nKkm+Ldwpi4ko1FB1FPpPIW2iTuMWHYZLGch0HxdjsslwLyL6aNRsTaAZ0JzGz
         zidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=91AwU1QR/kyfPZgJZSKjvuJV0ZhgE8NTYhN5ViINZws=;
        b=ss8+hqljwwPQHgz2RuiF+8SM7L/5qTj31pobSGokLLObYk7DOMjnd5Zjbt6cLi8490
         oYvrjFqTmDi2+NokmhVGDvk3g4bbU+tpmyZAFPXJLjSSMW5NiJgiUx08Hc69N/BcHXsP
         4HT1xNOGhrIFfyqEGuo/gZSLUgQ0xfhbKVT7l9Ik+mxPI+CX4bPH07nTGRwoRzDuzXTP
         gp7gZtlGrLD4zEpffdRavsEIP4+bKyLtznYUrm/eghq4+OeAebMqVgaEq5F9yKPXQBSv
         Q22+yjSffdNlSOL4vKrTVXhJ9CBsX0VWo8SLaCDxWnmiLroSeakITb6xDk8yhdmcQvgF
         CBCw==
X-Gm-Message-State: AMke39mPVQEVA+DqavNp2fq1GWhE60hNFTMzrPNgPWQMU3I1pdc70tY3gUMObr9WXlABWoW+ZmFcrrTRA7ndtA==
X-Received: by 10.107.200.139 with SMTP id y133mr22396321iof.147.1489235900979;
 Sat, 11 Mar 2017 04:38:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 11 Mar 2017 04:38:00 -0800 (PST)
In-Reply-To: <20170310220020.2666-1-jmelvin@codeaurora.org>
References: <20170310220020.2666-1-jmelvin@codeaurora.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 11 Mar 2017 13:38:00 +0100
Message-ID: <CACBZZX4guVXWDHgAotdNa6CqTSv3iNSWpdCbexJQ_Y3AXU+AUQ@mail.gmail.com>
Subject: Re: [PATCH v2] repack: Add option to preserve and prune old pack files
To:     James Melvin <jmelvin@codeaurora.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        nasserg@codeaurora.org, mfick@codeaurora.org,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 11:00 PM, James Melvin <jmelvin@codeaurora.org> wrote:
> The new --preserve-and-prune option renames old pack files
> instead of deleting them after repacking and prunes previously
> preserved pack files.

I think some of this rationale...

> This option is designed to prevent stale file handle exceptions
> during git operations which can happen on users of NFS repos when
> repacking is done on them. The strategy is to preserve old pack files
> around until the next repack with the hopes that they will become
> unreferenced by then and not cause any exceptions to running processes
> when they are finally deleted (pruned).

...belongs in the actual docs, i.e. here:

> +--preserve-and-prune::
> +        Preserve old pack files by renaming them instead of deleting. Prune any
> +        previously preserved pack files before preserving new ones.
> +

This is a really obscure option with an obscure use-case, let's
explain that in the docs, and also mention NFS & what problems it
solves there, so someone having the same issue can find the solution
more easily.
