Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AEA1F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 10:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbcJMKbl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 06:31:41 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34743 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbcJMKbi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 06:31:38 -0400
Received: by mail-io0-f173.google.com with SMTP id r30so80262886ioi.1
        for <git@vger.kernel.org>; Thu, 13 Oct 2016 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v3GgT881HsnRV2Yk3nht4ezouhJ8t+2ADOE7iaZmjs0=;
        b=lJrDh5bXnZroa93AWLTcgoXsWZSrsdN+zheOgDozj1PR2vEBzpJHTv1SXuJwF4uU1z
         VOIgPmsclpMWoiwii28vfSWYpHElTuyYXWW5EbucU53HHMOdQ9XQl/Ce2K14VGHEx3Wn
         WWAC3zMWGc8Mb/TJPKqG2QsbW/KZdhs6AmSpD9IaLNzw+w6OWpq+TFlEDmTBM3PZXKuU
         k7pGF8OcZw98VgJimP5M/CFHeGg08Qm+ir7BsKrAgr1kAEAgZdO2w7jyTPNJIFonTZL6
         a2kCUYeNMt5ipRETQ98I7xtdZwfAHNDExmIH7dlh7Zn09XP5SSoXYieX67ZPv/F6/t6G
         ZN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v3GgT881HsnRV2Yk3nht4ezouhJ8t+2ADOE7iaZmjs0=;
        b=FkqE0KvGExbb18dlPVf4A3jVaml0jp77daOkeEgWRLktFYoQyBtjqq/krDnFgNpMZg
         oE96HC1Z9e04/xk6r/ei55DtddqOAh9pSONziqKoea8pC1LHK8+vPBtvGnWsw1nz/73u
         ep3m0yFk3nFQN3hMFMZK94ZtR2aVQbsje+/zZUofNbCwA8MI9GhqJ6ts9g8HMw1z1TbS
         aLC7ZQFtc3HD53TmsCMmBh0Y3H5h46wrH87WRuDKwM98pUES16de/5WzDryWGB8Wicjz
         ULM4HMtPZEi1/1OV42ZhCVn/zPcVMzAqfFYg1Z8fYrXtHxOFr10zzGq8dXMvohLB2N0p
         Arpw==
X-Gm-Message-State: AA6/9RlMng0TMId/Z6x2Av0s/rkIq2BY2z1NKU8b9kYrdWIXE4mCPMLmd9iVCi1dZE1MetoNaP/aNoK/KnS9og==
X-Received: by 10.107.15.222 with SMTP id 91mr5962921iop.19.1476354697666;
 Thu, 13 Oct 2016 03:31:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Thu, 13 Oct 2016 03:31:07 -0700 (PDT)
In-Reply-To: <xmqqbmyp4d28.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
 <20161012164104.zcxpcwqrp5h65qmc@hurricane> <xmqqfuo14dnr.fsf@gitster.mtv.corp.google.com>
 <xmqqbmyp4d28.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 13 Oct 2016 17:31:07 +0700
Message-ID: <CACsJy8BUhASP0t7bm1_zGttSY+V5PuLGNBRXdiNK4x0Bdib9Ng@mail.gmail.com>
Subject: Re: [PATCH] worktree: allow the main brach of a bare repository to be
 checked out
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Tutty <mtutty@gforgegroup.com>,
        Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 1:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>
>>> OK, so here it is as a proper patch.
>
> Here is what I queued.  Duy, what do you think?  It seems OK to me.

Ack. Thanks both.
-- 
Duy
