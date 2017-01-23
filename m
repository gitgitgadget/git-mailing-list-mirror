Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61DB20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbdAWQdt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 11:33:49 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:38248 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWQds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 11:33:48 -0500
Received: by mail-it0-f46.google.com with SMTP id c7so69734612itd.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kkfkv/ZHZS10PZ/i+agDHUqCtRKKLCSbwF2/osKy9VQ=;
        b=qvPjJS2BLxuD3OnvTudJF+aR0aZGtgHIpD+7iw7SxYC1CrqdTVQiPxlc/QVrfvaWbR
         47WbqNtNTpBaGfLa6EFx7VsM8LJcHw2RBr3pwOxdUw8Pm6l6Tb8h1AZnueSu5m9gqvLk
         Qlnl2VgeLf4w/SQUCBvr1IoxaKF+qzVdBlMsw4JmG09eGONmhVsjCh9rx5feBwEeyaRG
         UI8XJrCuzLYv640UZnYj1fSGFJVtD/GcutEGlVpg91njyb5C0OVTBxMxnW8tQmxvr3Yr
         aUCtRw07dUxMUbVmy/7D9JGemRcBI0ptI1z6bjGYTyUph37pOzWldKApTmPzVDdOrCQS
         nTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kkfkv/ZHZS10PZ/i+agDHUqCtRKKLCSbwF2/osKy9VQ=;
        b=AifvQJToJurDd6YScBRhcajPiIaErvUwT7zeN51Ej4KVBdtiAr8eMpFj2Um3oz6oB/
         P/vrNCEy+Z/uX15uDeln5DGlEo4IIzRRCfCFhMFIjQdldNFJVp7WZqBO9DFsgUmTxhzM
         a2y2Zl6NUQBix8vEG9dFYtDmbTvLz7qa2zKS2xKuQBV+X2ANgij2//rsJGXIcwP/u0PZ
         eE+C3X7h2DYGooN4SuvvueZUkIRahZCtIM3B6SEO7F+vpd8ZO59Q7VbnNfyqjePPu+R9
         1NX8u072DSNl5hy+OFQdz1t4zdxDEMKtc24NGe1Tx7XN7kBMAbhrb0qqnyw2fqHNIFjx
         Grjw==
X-Gm-Message-State: AIkVDXJ/THRGu1055Ijt+ZcUdf+7nWQaPjNihjXpGQEfMQSkG4+KiMC2Xmpmi2D6SgXgo9Gbula1v9VGcSMXXw==
X-Received: by 10.36.181.3 with SMTP id v3mr16243979ite.45.1485189226189; Mon,
 23 Jan 2017 08:33:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Mon, 23 Jan 2017 08:33:45 -0800 (PST)
In-Reply-To: <xmqqlgu2u0qx.fsf@gitster.mtv.corp.google.com>
References: <20170122212855.25924-1-eantoranz@gmail.com> <CAOc6etaQ-fDWn38YzXkGOC0fSan1vrxjVDUXS924nBXWTTrhNQ@mail.gmail.com>
 <xmqq1svuvh0y.fsf@gitster.mtv.corp.google.com> <CAOc6etY5odte=TKyWX3Wf1BVaNTfDeA-xsGOKiyuH88HZgqFDQ@mail.gmail.com>
 <xmqqlgu2u0qx.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 23 Jan 2017 22:03:45 +0530
Message-ID: <CAFZEwPPx2vDJVf=uk0iUJ2sh9DxWwp2Lp1k-APz9n=7NYMN5uQ@mail.gmail.com>
Subject: Re: [PATCH] blame: add option to print tips (--tips)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Mon, Jan 23, 2017 at 5:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> That is too early to tell.  At this point we only know there are me
> who won't use it and you who will, among all the other people in the
> world.

We can probably make it useful with some extended efforts. I use
git-blame and I sometimes find that I don't need things like the name
of the author, time, timezone and not even the file name and I have to
use a bigger terminal. If we could somehow remove those fields then
maybe this would be a useful feature.

Idea: Make git-blame understand `format`

git-log has a format option in which we can configure what all things
we need and what we don't. We could probably do the same here also.
After carefully using the format specification with git-log each
person can get a good look at however he seems to view. But I am not
sure whether this is worth the effort. I personally find this `format`
feature useful.

Regards,
Pranit Bauva
