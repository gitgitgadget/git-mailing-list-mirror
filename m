Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F15F6201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 22:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbdF3WiD (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 18:38:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33137 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbdF3WiC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 18:38:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so18433943pfh.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n9ull35YGipVfa4iqhX/LEYZhhbqP7d9coQFLjC/oPk=;
        b=YvYa0ZLwXprtIQVdqTBFuiaZckv+aea2DBjTwPJI8KnVligLp3oLzUWdRAxdsA97st
         yBhjBmMYbpyQMZvrCd/P3NwMT47Ix8euvYpVNQ7lYisVvxXD+kKjpudC8AUa8KRDqi3N
         RMeLMcvdLdDW1Yuok0p5ljxbbyxjETShxLiu0M4Pe8XsZOQgbn7Iu8NYxRiPxQxKStuU
         4EB+88n6YMDRA5NLTGCkRj26sRWGaQJBZf0kxt3wIwkC9eweuphZtQISRo/tsRUWBhOp
         COvZJMZivAIaXU+kxdVcm87hirkrrg/uotwBpGNgc7QGdSDMQhuk2TfXGJ+kryfkYpIT
         7gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n9ull35YGipVfa4iqhX/LEYZhhbqP7d9coQFLjC/oPk=;
        b=LRvte9iJPt05yliK6xRMpSQf5uILbWQexJBKGvuJUcSwj5yDuZGUzkjOjGBz7q+uXw
         OFiz8owMvO2WlVa+6rp29NqfRlLFsJGg1S1XMmO1CFm0+ErfVGEPUcrKaSpwCcdQdASc
         YGr8N6adz/oCWP2C6XaOr4N5zwuy2UGQugaZuq7KmuHQNFt8B/MEU0OMPpMCBuzH+U/n
         F0f9DD5pNItgrqLPQE5C9BsDQAy0xAlsuZjWGrGEVN0GNaYEhc/+KIbXPYSQxGHvPtHw
         mHLKX/EeAQFqyGHnDxuZydt0LQACShMGvYPzvqoEot70mD2wr4H/RBGMTNzxHJTFrf2H
         kkfg==
X-Gm-Message-State: AKS2vOxdTz8Rchb+80q/2XHi+L+jyuF62UL5RpTLGJpUc/vM3bGi0/al
        puLcLwcc+wZ4RA==
X-Received: by 10.84.217.148 with SMTP id p20mr27030591pli.148.1498862276868;
        Fri, 30 Jun 2017 15:37:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id q67sm22636919pfi.81.2017.06.30.15.37.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 15:37:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 1/5 v3] submodule--helper: introduce get_submodule_displaypath()
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
        <20170630194727.29787-1-pc44800@gmail.com>
Date:   Fri, 30 Jun 2017 15:37:55 -0700
In-Reply-To: <20170630194727.29787-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sat, 1 Jul 2017 01:17:23 +0530")
Message-ID: <xmqqfuehp0e4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Introduce function get_submodule_displaypath() to replace the code
> occurring in submodule_init() for generating displaypath of the
> submodule with a call to it.
>
> This new function will also be used in other parts of the system
> in later patches.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> The patch series is updated, and is based on 'master' branch.
>
> This patch series contains updates patches about
> Introduction of the function: get_submodule_displaypath()
> (This patch wasn't posted in the last update by mistake)

I was wondering what that thing was while reading the previous
round.  Good that it now appears in this round of the series ;-)

Thanks.


