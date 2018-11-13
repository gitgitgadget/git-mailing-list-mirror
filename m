Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13C01F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbeKNEJN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:09:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35720 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731883AbeKNEJN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:09:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id n4-v6so6403057plp.2
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xhkM3TAZtymHS/1QZBC1aC7uyodrAA+Dp4FlMh7/ENc=;
        b=nrggg2Jioan76azX3h2zIuw5vUClzTMW7TtThz9kCLJgs6iOQTO4bd1g7RPw+dQN8b
         KAR0enbUfnaRPe0EQ+rbY378Wide7g2aR4v+Rpc7E9o8OIPjO52odLKE74Zm82+V8G3A
         O8tgq32fc+R6yM4S9IOfOiFngYSuXko2ARaj6fbYxxn2AYF0WBBTtm1/anfXiNYPtDL8
         E404WfMZjiUln3x5oHy1voufSVxa19aXwHHamHSzMDrMs98U/RV/ZFZmeWtHRspXoKgh
         8sP9h/ca0la5U9Jh+wdcjK2p/v5BxjvXnNI0MYoRvPbnf0E8mR/08VBW3SxLTP1elRHR
         Yj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhkM3TAZtymHS/1QZBC1aC7uyodrAA+Dp4FlMh7/ENc=;
        b=cjr6bIU3gl7LsobMPRxU2W+1/77OiNPSWYwm72Qdngv7SI0b48G/HL842wdIuuPYHD
         Q/RdlPSr8vmknOIfIyWGeR2EB7HYUr0crFV0QWj8KdIxtMxX3iUmEAnz7t3doJzu3S7f
         N+xqZ/12DzRstzoR5QSkDZ0cGYcCCc7FSMEHQnJrCxXInfFwYzKFob2+VtWnAMeg8/U9
         HXyMKKzuFJOOF3CdluBS555Itg5VwRkjJqWBwdoBZXcvGj90AmLvquNJ2S+RhjfkHSZE
         7gIvIxYLdCEIRF3Up4g+D0KVokyn6XINOHTM1XqQz6AwzFyXlbSJaOzaN/6uwn7KIRFX
         tdYQ==
X-Gm-Message-State: AGRZ1gKPBSeRKqXEAAuYBKymv2MHXpUPvdT5XtObgIXJVAXsbtRUGtry
        1FYEH+lGPj+UE9qGVND3J5JbrSNl
X-Google-Smtp-Source: AJdET5fHckDT52vMj9Ysowhkrx1bNZu90yj6IKrTSBO+10axtK20T5aYtujSSDihpYq+AgpeBjYpWg==
X-Received: by 2002:a17:902:bf47:: with SMTP id u7-v6mr3187134pls.10.1542132599384;
        Tue, 13 Nov 2018 10:09:59 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id o1sm25072210pgn.63.2018.11.13.10.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 10:09:58 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:09:56 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
Message-ID: <20181113180956.GA68106@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <xmqqpnv9zsu6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnv9zsu6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Junio C Hamano wrote:

> Then removing the message is throwing it with bathwater.  First
> think about which part of the message is confusiong and then make it
> less confusing.
>
> How about
>
> 	hint: ignoring an optional IEOT extension
>
> to make it clear that it is totally harmless?
>
> With that, we can add advise.unknownIndexExtension=false to turn all
> of them off with a single switch.

After having slept on it, this doesn't seem like a good fit for the
advice subsystem.  The advice subsystem provides hints about suggested
actions for new users to understand what to do about a condition.  In
this example, the message is not suggesting a particular user action
--- instead, it's describing state, which would seem to be a better
fit for tracing, as in the patch 3/3 I sent.

Am I understanding correclty?  Can you give an example of when a user
would *want* to see this message and what they would do in response?

Thanks,
Jonathan
