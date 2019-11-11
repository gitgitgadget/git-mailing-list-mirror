Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFA21F454
	for <e@80x24.org>; Mon, 11 Nov 2019 04:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKEnF (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 23:43:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43135 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfKKEnE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 23:43:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so8627326pgh.10
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 20:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EfXSGO694xyNPnZtE7OqV1ZG83ybae1EsKn9fB+Vkls=;
        b=kgJvICIIQdOEE7yGeGw/89engYtrJJjyIBPTBNj8mJKGnLZ8ZQ7EptZuYIFut5U0Bi
         T771bPCmRTM3LMaWv3K0Cpi0YgS4dgQ02vEyYTCIxoyo2WFHoa3XYXKcrkonUZc15cF/
         oit8/ifkwRkVViUbgWoAnH6RpIxI7Nvuh4iQPld9o+PM0QHVZaazvi/sxjz7OWVtuGPm
         Hcy6auV6AYeE+6PeB2RGsp2TfRHef9RZ5xCV02657gms9vMF7wgWJJCeKN7/r6Zkd+3Z
         v44fTLNJnRfX77t6aAWQFwRf6k7vgHR9WJj1kBr9CJrBqVKR0dWUhpILP3AOaVItb9OA
         xOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EfXSGO694xyNPnZtE7OqV1ZG83ybae1EsKn9fB+Vkls=;
        b=qqKJ24YPMNqHOutIlLsa+MAlbmpVbo/10884WEv1uBVpNDonne39UiQyDTUG/25RbI
         UOv8L1dJjBqZLhcJelcFSjQTeU24SrfKiksS4BIPuAuHOHvNAN4QG0AOJAzCulEiSnHQ
         GMn44MohuJasuVgNl2oG2IC/2ElSv0jl8vcu8IcGKouEWxzM7Ql5644ifQc9N4Pptbz0
         nxKScKRhaN94iBiSvzD6gIHos/OP6UTTq2Bk8DEPPZgvh5Fa1rGk2L3cS/2barEHrQir
         jfthTKCtTk1+7H7uqzknhCMh7cHvzUwJczPXBdIN+H+Oe0NGxUPabSxfdbiOz+qatWbt
         YYXA==
X-Gm-Message-State: APjAAAWFGm/3449AS/AttH31KP9wfCvKrrDaEM8GY9lAuWNRbouZzrld
        OQ5aPwXG8S0xz9cvhSwoOhZkJqqm
X-Google-Smtp-Source: APXvYqz1ggHw5sUeR5NUde+Pjq7m59hQVn0KTSJn+F+cqgs5LUsJwHDMdOzALj+pIawkJ9uMkR/abg==
X-Received: by 2002:a63:fc16:: with SMTP id j22mr15281584pgi.35.1573447384080;
        Sun, 10 Nov 2019 20:43:04 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id f185sm12869287pfb.183.2019.11.10.20.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 20:43:03 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:43:01 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 0/9] Improve odd encoding integration
Message-ID: <20191111044301.GB26528@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573205699.git.congdanhqx@gmail.com>
 <xmqqd0dzhxgi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0dzhxgi.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-11 13:02:37 +0900, Junio C Hamano wrote:
> Doan Tran Cong Danh <congdanhqx@gmail.com> writes:
> 
> >  t/t3433-rebase-i18n.sh           |  84 +++++++++++++++++++++++++++++++
> >  t/t3433/ISO8859-1.txt            | Bin 0 -> 15 bytes
> >  t/t3433/eucJP.txt                | Bin 0 -> 68 bytes
> >  t/t3900-i18n-commit.sh           |  37 ++++++++++++++
> >  7 files changed, 195 insertions(+), 11 deletions(-)
> >  create mode 100755 t/t3433-rebase-i18n.sh
> 
> Doesn't "make test" barf with test-lint failure with this series
> merged to 'pu'?
> 
> In other words, isn't 3433 already taken by another series?  

It's taken in pu but not master.

I branched out from master and I forgot to check pu hence I hadn't
noticed this barf earlier.

Should I send a re-roll to rename to t3434?

-- 
Danh
