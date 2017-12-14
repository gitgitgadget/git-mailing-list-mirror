Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA581F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbdLNVE6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:04:58 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:39058 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdLNVE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:04:57 -0500
Received: by mail-it0-f68.google.com with SMTP id 68so14234882ite.4
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 13:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jMowfmfPsPOd0ARLS5r7Tri/c5XHI3VCSO0ToXeBGiA=;
        b=TH/M91KhLQY9K3euQB+ybkubgcMq/tPSl5+nPJtMthdtoLhssTXGhBuLz8gG1D0B34
         rGD3UEJX6ZUsxKDAhcZdkwwTB9jfvbhx52h2m4adN6uF+8lyRBn4g+I9jA9yDgZ4/Ooi
         oXxIup+sfQFggtft35vybjdWQwvl+gBePAg8n5WAF9ZoXvokYtEEVxuO7h8YbTjYS+Nu
         q+xOlzX1HOkTWKyu0C2DzexmQSQz+w6jytkpXAfFTwn6BhD7uc8kxfwMG2YxJkO57SRk
         aUcBJoKTHuzLi3L0N7U6aMmLa6VIxfJE8g4XA5YTcYKcJVNvpdCqp705bUTOYyifkUE3
         5dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jMowfmfPsPOd0ARLS5r7Tri/c5XHI3VCSO0ToXeBGiA=;
        b=qxYmqAm4h71qPIPul3n2BxbLFbtHGNfoRCVi700ID3wboEve30DaaY55oSp6pdvyAp
         EBPpd9BbQb3aisCGhZFhsHdOQeoWF5chZ6kWQqXtPFhlm6TO9QpsdMZX5OII/UEM/3bt
         I5tMEIYb+CnwY2SS8pIXeF8cPUgJEqMSk+6jvexJAGI64kMI7OdJrtEStp+mwgM6K4e5
         URVYM8uwlNJjljTbKR8k3C+Ba9BqdJNe+rpqWNFSSMKJ5B9I1f8Y3Zfec1D3C4Wz+VtF
         SIhbye8uUr0xCXiyyumherT/upIqOencREe8LraZOaMxKqSBKQQfJg0a5iYl+iWxR5AP
         7ZRw==
X-Gm-Message-State: AKGB3mLap2tK37Qf7PinbjskPpXfLIBDboaznyWYR8hl5ucPc3jMj+XH
        R4Mm4H0RUF3a+WpYyj2L460=
X-Google-Smtp-Source: ACJfBosm3KBZJwYtfGXwzqoda2YC4j7Qm62yr917v12dTHy711YzxU2xzjfWTiBps0jtyxycpF9LSA==
X-Received: by 10.107.16.82 with SMTP id y79mr129303ioi.200.1513285496769;
        Thu, 14 Dec 2017 13:04:56 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d128sm2681235iod.35.2017.12.14.13.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Dec 2017 13:04:55 -0800 (PST)
Date:   Thu, 14 Dec 2017 13:04:53 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
Message-ID: <20171214210453.GB32842@aiede.mtv.corp.google.com>
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> * sb/diff-blobfind (2017-12-12) 1 commit
>   (merged to 'next' on 2017-12-13 at 9a27a20c5f)
>  + diffcore: add a filter to find a specific blob
>
>  "git diff" family of commands learned --blobfind=<object-name> that
>  allows you to limit the output only to a change that involves the
>  named blob object (either changing the contents from or to it).
>
>  Will merge to 'master'.

Sorry, I should have replied about this a long time ago: I love this
option but I am not sure that --blobfind is the right name for it.
If we can think of a better name quickly then it would be nice to
change it before people start relying on it, so I'd rather hold off
on merging this to 'master' for the moment.

That said, if we don't have any better ideas for the option name
within a few days then my objection goes away.

I'll reply in the patch thread.

Thanks,
Jonathan
