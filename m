Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE981F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfIEWZ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:25:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41446 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfIEWZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:25:28 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so8355362ioh.8
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DboFo6lP5YWVoeMCxmBIMLUHOg32UaVDr8KTBrRlO5s=;
        b=LEltdUaXVT4m9JshbzN158OIA+m/xctdgqr/GLLIQTBfUTXfu/L7Dz4R5DIbPYIsmL
         dkLwU5nSD2GMMQSTN8o/KvNxrO1UF+bvfMbOKrgQcdLBo9sNI1xlUiZn0AMG5K+zJhkw
         guokp78WFdXArmSFLIuychr0EyfaQewl2zaqX2nCrz6ZwkB9i/rOPD2GD3oQMRuaD/bw
         g3VEBWY30hYUH+bxuSpv7P9KVFUeJstxDXxpb2brvR33KVgEaisqwftdR/XWM0sMKJvA
         WUzrrNM0wBQIKuy9475UHYgTmos7b0zFrnux3lFrY4A98v049VlYkAI1tMorPmqTosCK
         SXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DboFo6lP5YWVoeMCxmBIMLUHOg32UaVDr8KTBrRlO5s=;
        b=Z52u2mzKULZFyEmm55mNALvoiGW2JDpgATphgRaGP+75pR44EuWUoWHCI4/3bPxmzb
         Y8TDX3g8XSt7H42RT72BGTXE37PXcDEXa/7v66z0nUxbJZ3EMwBcr+PjUKil9d/mqAwU
         nq/fo/C4Z485VX/NtxFLKKGv77ro/ZqjHMV4Ai2nmikf1Nid9CRO9/+I9iueCbiktDVH
         khZ6LZNUPpsLxK/i88x8cBqZF3rGEWxJafjDzfK9YMkQ+pCTKaH365Ch5oBkyEA7m/0G
         rN0tPclKcAFb3FkzQs/fJAfkdfJp/3SNF+Xb+HanZJmaAyTfYpO3cct3ZJ+SX3zoEL18
         7CCA==
X-Gm-Message-State: APjAAAXIONsqT5tDEtCGZj/OlaUE/fSCEQLVn4qJKmTHXZud+sEWmH/n
        7nfo4uQ2fGkAL02AvrY30jXhUg==
X-Google-Smtp-Source: APXvYqzO42W2neJawRnNtbJgpU1LLPGAgMISH8GdI2E1CPKJKIKbXHzcM4aQkuL4+F4qqbDStVCjlg==
X-Received: by 2002:a05:6602:cb:: with SMTP id z11mr7173656ioe.4.1567722327766;
        Thu, 05 Sep 2019 15:25:27 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:3c19:faad:a3bb:990d])
        by smtp.gmail.com with ESMTPSA id g4sm7922978iof.56.2019.09.05.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:25:27 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:25:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t: use common $SQ variable
Message-ID: <20190905222526.GA29743@syl.local>
References: <xmqqmufipmfp.fsf@gitster-ct.c.googlers.com>
 <0598bbf4d0b2cb07ff6f06f904cbdd3f5a3ae1af.1567721303.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0598bbf4d0b2cb07ff6f06f904cbdd3f5a3ae1af.1567721303.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 03:10:05PM -0700, Denton Liu wrote:
> In many test scripts, there are bespoke definitions of the single quote
> that are some variation of this:
>
>     SQ="'"
>
> Define a common $SQ variable in test-lib.sh and replace all usages of
> these bespoke variables with the common one.
>
> This change was done by running `git grep =\"\'\" t/` and
> `git grep =\\\\\'` and manually changing the resulting definitions and
> corresponding usages.
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> [whoops, forgot to include the mailing list in the last email]
>
> Sorry, I wrote this patch up before I saw the email about leaving this
> as #leftoverbits. No point in letting it go to waste, though.

Thanks for doing this. I marked it as '#leftoverbits' in case anybody
hosting an Outreachy intern might be interested in having something
small for a newcomer to dip their toes into sending to the mailing list.

But, there's no shortage of other such tasks, I'd assume, so it's good
that you cleaned these up.

Both of your 'git grep' invocations look correct to me, so the patch
below looks like an obviously-correct result. Thanks.

-Taylor
