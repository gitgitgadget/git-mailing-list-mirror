Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE48207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbcJCWeG (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:34:06 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34774 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbcJCWeE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:34:04 -0400
Received: by mail-oi0-f47.google.com with SMTP id n132so151901694oih.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p7lirHmZJSnFVIvHPRNZHINf9F0l/cOda8PMbiexp+w=;
        b=sloCiP6lQHVrWrmKmcFX108KJVEYyLZ4x+GqjOCaI+H8PPrCGDV7tBgNJ1cGMqzXo1
         yY76kak9KdEEfQUqIpMLGJ77NlTAHPnVgf4e76203RCGSV9WI39gntKV1nWNCMJDy0h3
         uxOMdZkvRbunFGBuxE3cobI3vKZnOPNoB/j9tUeduJHUDlKfM8xHHQFDNon4OSI2etge
         fVThVc2d0JlxXYD2vZ88X0U1u75yV2EzaqGlgqmQ+m/BlBiBLTvG6NuLsZ7/JwMbmL8M
         229+8OwsHFq1G+LOUnpvNJCkbykWeK7XCcEpdt/V6pJOziVxdScmVLFcI9LS84vXatlB
         o9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=p7lirHmZJSnFVIvHPRNZHINf9F0l/cOda8PMbiexp+w=;
        b=kGTnlG88uDn2G5MImpUhlggU82ZttRxB580DMO6eMEbRxInm7axlE3KaKKU35eghWT
         t7n0aSstv8xgdh46C9upEZ/p6283/sHw6OTxZYQUmVreqhIkiVJFo+SQ1NNWRWG4m2bZ
         0wG0G0H+XZ2iUWCqP3KiMfdksO91AROVLpdfpFRXqIC5g4E2RH3Q8rkAlp/dYtjUWBmy
         CM6/oupfb6wbGUyrA0SW7hLQMCN70byGSK1yAfQ6g0KHb/FPT6UtY52draRNS6B1oZSk
         3M/IrDz8KCKbkXJ9dS6/ahZU//XGS+xC0ZaJyNymSGm6mHVx/hfq06+twQFXfjHKuxZO
         CYXA==
X-Gm-Message-State: AA6/9RlBaSwdj4GJkwv6HslrL3ZnzWAEBZWkcc3zr70z9MAVv1E76rgkE8C0mjwAbv7bJK3jOKvPc8U2hmzWgA==
X-Received: by 10.157.12.247 with SMTP id o52mr250102otd.222.1475534043932;
 Mon, 03 Oct 2016 15:34:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.21.198 with HTTP; Mon, 3 Oct 2016 15:34:03 -0700 (PDT)
In-Reply-To: <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
References: <20161001001937.10884-1-gitster@pobox.com> <20161001001937.10884-4-gitster@pobox.com>
 <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Oct 2016 15:34:03 -0700
X-Google-Sender-Auth: H5V0GG27o-XkVifkrOkitaZtsBs
Message-ID: <CA+55aFydV+9c3-5C03XUj7v_wGJF5NyJNaP6742zLVgZs410FA@mail.gmail.com>
Subject: Re: [PATCH 3/3] abbrev: auto size the default abbreviation
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 3:27 PM, Jeff King <peff@peff.net> wrote:
>
> +       if (len < 0) {
> +               unsigned long count = approximate_object_count();
> +               len = (msb(count) + 1) / 2;
> +               if (len < 0)
> +                       len = FALLBACK_DEFAULT_ABBREV;
> +       }

that second "if (len < 0)" should probably be testing against
FALLBACK_DEFAULT_ABBREV, not zero. Or at the very least
MINIMUM_ABBREV. Because a two-character abbreviation won't even be
recognized, even if the git project is very small indeed.

            Linus
