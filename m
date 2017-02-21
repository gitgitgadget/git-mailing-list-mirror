Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501BE2021B
	for <e@80x24.org>; Tue, 21 Feb 2017 07:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdBUHSj (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 02:18:39 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35895 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdBUHSh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 02:18:37 -0500
Received: by mail-pg0-f67.google.com with SMTP id a123so14045759pgc.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 23:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mRLrXYW0fTiNyBXrMXBZBs+F62nWeSgbqNPCnMij9Sg=;
        b=M+pFYk8Dy5kF86PxgVEv31/8iudgqBiLO6cuRXH9Fk1htnHyvHcltBTesKdINWyYtH
         xy8RIedm9kuGLU/Zz3pOihGeMcz+6e4JnqpGCQdpJTct9GR545CW+5ETOq5LzXFwxksd
         27HFxec42p7kNEuahqVenWs2y6e9/u1UXGlj1zcqnxmcGvLCyrZ3EUXG42F4eK5Y6cjo
         8M29Ai9+Pv63obpx6ZyLWvmFz1J3wFaZHdqqB+6hrw47Qxu6Hx65v+Mh0k45W48eSVLP
         Com4snTTSzhjrjcXv2fqWYUPor7WQQH8EU0FWFfpn4xE60JgT92A/kn63VPDEf92pkqF
         +1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mRLrXYW0fTiNyBXrMXBZBs+F62nWeSgbqNPCnMij9Sg=;
        b=oJbJaAAz2oJPheoJgB+8Anapv9ky5M3ju1cJsCFIsKSiEOfmmG+t6wBXlfjH+pWstj
         soDnJbD4E9UyrPTExMpBOPyOdMC1EAPMVVICKwlrHPeGU+P5oLlTlj6PTcc9LsN4K9V0
         e+dMydyUxIer88y6hsPeRg86iqT+yeoMTdwFQ/eMSKrkkWY5IwvYo6ciBTrpIwkrWCJ9
         MyPTDERdxWvzSOqzTcUTB2I0t+PyO6PyxISzWzUjVft0jAU+DIWdh3uuVZpV03cvMW4l
         uhk11ozvMFO/hvGMnw4K3DpQoLp+OQ2Vw2EqKYh+bQiVYw8W3cFMXwuFLOPfU5W7L8Op
         CqTg==
X-Gm-Message-State: AMke39nL1bei/Nuv5igUh+h6Nvto4j4qvgqgZfiXYalpel70CboJymc1iMnKn7ps5TKyOA==
X-Received: by 10.84.143.195 with SMTP id 61mr37741085plz.46.1487661516829;
        Mon, 20 Feb 2017 23:18:36 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id s26sm38993189pge.33.2017.02.20.23.18.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 23:18:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] delete_ref: support reflog messages
References: <20170217035800.13214-1-kyle@kyleam.com>
        <20170221011035.847-1-kyle@kyleam.com>
Date:   Mon, 20 Feb 2017 23:18:35 -0800
In-Reply-To: <20170221011035.847-1-kyle@kyleam.com> (Kyle Meyer's message of
        "Mon, 20 Feb 2017 20:10:31 -0500")
Message-ID: <xmqqr32sggfo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Kyle Meyer (4):
>   delete_ref: accept a reflog message argument
>   update-ref: pass reflog message to delete_ref()
>   rename_ref: replace empty message in HEAD's log
>   branch: record creation of renamed branch in HEAD's log

These looked reasonable.  I had to resolve conflicts with another
topic in flight that removed set_worktree_head_symref() function
while queuing, and I think I resolved it correctly, but please
double check what is pushed out on 'pu'.

Thanks.
