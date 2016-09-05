Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6494420705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbcIEV7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:59:15 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35704 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbcIEV7O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:59:14 -0400
Received: by mail-wm0-f46.google.com with SMTP id i204so6478240wma.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EwBtViWKaSw6uoL2neboT7VY0z2pPgCxpuJXgj+nrdM=;
        b=cNGswnEEV15dArKFwIsZxupQvyBYmxYycGGKUk91Ev4PfRG8XCP0b4MUpfNl4uQJby
         8GsJV0bewVhOua7bLja3u1BwmIAtzMS+vLu6SJWTfR71PNVahVXIaouKmZdHqf8DqzuE
         BNdUe6YThRUiJDH5vyzWocaQ4y/FjDyo23bOnTzKREWvls+T+57n5UH40AF6QnqvGy0T
         bH03eZnDreRjCagAQBP2aiFVcSAn/Iqk425kZnzBBgtzMFrmmz2W3vSbl3aV9Nebzb+O
         IuUygK2O8uA5Z7ROKNyQWD1/+F7m9X8UH3AOtoEuj7U+KJ2DXYgobyCXBFxJGfBwS1EV
         YKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EwBtViWKaSw6uoL2neboT7VY0z2pPgCxpuJXgj+nrdM=;
        b=gL/nIN60/D0uVTUTYjXvvWHT2laqspo/L9pLYwPaCPBVuMGywxZkgjn8zOwofIVFrE
         5/7mjF1ydmF80uB/DeuvfslJ32CIRDfZ2Kp0gXmkAN7+EuyCYTn8ut594+iRKf/Z/pbj
         J1Hj5fepPp4pAlesv1mPLLku+cpAUKnblOpFiaLU4GRFWmZpLhUMpnysqxe0GzW077nv
         QnDZDjhNuk5zrdycgBmyNSIIn75lTeG/rsrwIS94OXN6DyBNOgwbDxjKiojAmD4s+WQZ
         a+PcnzWjVME/TQC33GX89chYjubkAYRRvcujYO3Gb3pVOepSTzyjaq8iCizXFpOtgpYn
         uxXg==
X-Gm-Message-State: AE9vXwNoqPp+wadEdx/4GLqPHN8sCl1ejGJA7OBvx+AnnjgYc1Y/sZfm3nih5xUazk51ErVXdEc/IHawuQefwA==
X-Received: by 10.28.15.3 with SMTP id 3mr16554435wmp.31.1473112752521; Mon,
 05 Sep 2016 14:59:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.185.67 with HTTP; Mon, 5 Sep 2016 14:58:31 -0700 (PDT)
In-Reply-To: <CAFaJEqu-JUcwLjrQBk_huSa3DZfCf8O4eAZ=UgcXHzN=CLgtpw@mail.gmail.com>
References: <1472944878.19860.4.camel@gmail.com> <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
 <CAFaJEqu-JUcwLjrQBk_huSa3DZfCf8O4eAZ=UgcXHzN=CLgtpw@mail.gmail.com>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Mon, 5 Sep 2016 23:58:31 +0200
Message-ID: <CAFaJEqv-eZaRwrZhq=rNzQ4gEqE3WXwZVrF61opk-Z2=RrxcbQ@mail.gmail.com>
Subject: Re: [PATCH] stash: allow ref of a stash by index
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pasting text into Gmail's web interface is not conducive to sending tabs
through the intertubes. But you get the idea..

=C3=98sse
