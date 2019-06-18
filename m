Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270FB1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfFRXO1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:14:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40274 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRXO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:14:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so1250300wre.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEHRccUk+4iJqN2szxhZORH8BLQ4pIc4mG/bUBtqCRM=;
        b=qBP51Rx+7k0rlNSfRWTDQEhrZspAvx/u15gBD6n54IYELyJehoTdP0SvnMZckIXfXW
         4ruPXDSf0Jfsy/ZVvXUTsGsi3FETWwxMPq1suNDJUFq+i9Wfviebm0ZVYh7fjgVCa9EV
         UmpQl+G8AMmRNS+I+pJEOTAGD80BtF6fKXVovsicxTemegcOVccUBIKgobgTVH87cYyU
         yb2JHH83W8SwTyqmQytK1PkYdrJ6a91D9RNj/NRBHXmgZLQddJSp6LsT+sl3kY37ONCF
         zQSixA/ZetF3u2L1U4U4hXkDqoAC9k+qqjpl1B+4I8y8chQoboy7WcRlbMSvFKLCECG3
         79MA==
X-Gm-Message-State: APjAAAVmdC3wbMpFqJt9Xf08qOf340lgQQl4hhKRTyRcy0lMjtQssuvg
        W6RpmcWK0K4Y2OD35eLfl2lTi7TutFE7WxbH4tA=
X-Google-Smtp-Source: APXvYqwcxc7tQvrRPpcF2pFkLcKrkX3MPoPucUkfpaWUWtSYPOnA3SU3Jqq8FTiqu7fRmREF3MpOJq2h0KTWPNM07e4=
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr5514666wrw.231.1560899665413;
 Tue, 18 Jun 2019 16:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.149.git.gitgitgadget@gmail.com> <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 18 Jun 2019 19:14:14 -0400
Message-ID: <CAPig+cTXdz6s_cftPydKjtESz986s1xLQvwV8xPzYSR_xLK6Cg@mail.gmail.com>
Subject: Re: [PATCH 03/17] cache-tree.c: avoid reusing the DEBUG constant
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 8:24 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In MSVC, the DEBUG constant is set automatically whenever compiling with
> debug information.
>
> This is clearly not what was intended in cache-tree.c, so let's use a less
> ambiguous constant there.

s/constant/macro name/ would be clearer.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
