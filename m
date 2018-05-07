Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B72E200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbeEGXiL (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:38:11 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:38009 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeEGXiK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 19:38:10 -0400
Received: by mail-pl0-f47.google.com with SMTP id c11-v6so1057373plr.5
        for <git@vger.kernel.org>; Mon, 07 May 2018 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSalitdKjPIS3UqShq/LQ7TByQ6ql27nSLcC2nXEIY8=;
        b=DdR8FpsDijO5L+k2Dl3updwLBLJGmw/uBJdhQi0nkk8AGOZEsKkWYrgcfkasvizlOC
         8GlAMKxpewyoGJVsGctiugzH8xFfxuSioEb2yi8Iesm37BRsLE/mLFgL0UOjopIKzIBL
         LeD/ZRIxi49kRki1fTt5XL21UNqjAIaur8KJfmEL9eSW0knRFMGnBeHWoUVHUA2O1hhL
         jNqFQRX0JZYcn3DLLYXnczXrzNjID2pUjmhle27h3AKamHNBEy4bBtZ5Ov8Mt7o/RQDC
         uJoboVYrh8rlD5tujtZaVSpGcFRjO2ZhjIo08Eg4h+dsUFnq9l1b1JVrEBoICk3DWcD3
         eBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSalitdKjPIS3UqShq/LQ7TByQ6ql27nSLcC2nXEIY8=;
        b=j1QALBkZ5SahS+k6SOC/b4da1HVDL7EKXYaoUPFZcQiRCAo0OUxxtip+QaZnSz09O+
         sGIhzpLqeSrLEfxuNUsa+0pYMmjhqKYDUgc91FPhrG3hptSrjSlxtCEuTxKinnD1heJ2
         mYOqMUFLScNYJU+yCDvkLIc/m5Ruac/a2/rIC0IuYI0pwRbxwLp1iFepGlYBU1QlIRkh
         J+/Qe7I6Pz9D75Jds6N9K3AusXgA3YQXSeR6UScx6BH1HSCbCauBTd4xvURjNIit9Pup
         Eupl2AF8v+qxE+BOho2eOSM3Pc7UohpAfDUBZRVkENjnldCRpNBVSiqqBw0g10b9QIFh
         G74Q==
X-Gm-Message-State: ALQs6tDSS7WqFxJWWSAtN+D2aoaPH25YJrKC/eoqA1Z9norhQ+XZK2w6
        MdTZCdHdnfrBGomImNSxYFob+Q==
X-Google-Smtp-Source: AB8JxZrSpXpTLaUop9+kGAdgjT2OoOWy7Be4ZHoA5a/Vxshg2ciVAyUVKpK+UAfPdh7GE/6Xet9+TQ==
X-Received: by 2002:a17:902:7241:: with SMTP id c1-v6mr39492425pll.217.1525736289652;
        Mon, 07 May 2018 16:38:09 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e0dd:ed95:919f:45e6])
        by smtp.gmail.com with ESMTPSA id t9-v6sm39766419pgr.37.2018.05.07.16.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 16:38:08 -0700 (PDT)
Date:   Mon, 7 May 2018 16:38:07 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180507233807.GB77370@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
 <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
 <CACsJy8BdJ0=gWZQVfSqy-vjtZVT4uZNzRaPYxRYxx2WNzaLodw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BdJ0=gWZQVfSqy-vjtZVT4uZNzRaPYxRYxx2WNzaLodw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 05, 2018 at 08:15:03AM +0200, Duy Nguyen wrote:
> On Sat, May 5, 2018 at 4:43 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > Teach 'git-grep(1)' a new option, '--column', to show the column
> > number of the first match on a non-context line.
>
> Why? Or put it another way, what is this option used for? Only
> git-jump? (which should also be mentioned here if true)

Good question. My primary intention is giving
'contrib/git-jump/git-jump' the information it needs in order to tell
$EDITOR how to seek to the relevant position within a line.

I have amended this patch to include the relevant bits, and will attach
in v5.


Thanks,
Taylor
