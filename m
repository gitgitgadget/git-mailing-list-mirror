Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB971F453
	for <e@80x24.org>; Wed, 13 Feb 2019 22:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395122AbfBMWhw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 17:37:52 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33153 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfBMWhv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 17:37:51 -0500
Received: by mail-wr1-f47.google.com with SMTP id i12so4413744wrw.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 14:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/UuO8fiOS4bQxOBXKgz7+LZucg/7sarn+dB6JnWEtVI=;
        b=CEZ9NRwTMPVnSSfbLdOejcXshYU+AnFaFRYM1xxyoj66wEoh+lreiROGbZWOxVw7NZ
         SbRcvt9zcHUcmsWAUcyxSUwCnFP2InPZV2pW0go3d+9VbAh6jOdgknWqFpEhlMHYiB6c
         96StUO+CHbrM7WSZ8Le18mVLJ8z4AFS9Rp2m/+ve5oKIU5AWNFDYBbqRQj/JXWMbUvbd
         k7yZX2+hRfFBRH0ogNo+/7dmKwArKc6rTsJ0p3KI6wJJpq3rF3CZNcUmGxizTWPjvaY6
         NQ/PsCTNS8uvAVBuyIw0uGVsX0FD9mNzv98hdCkPUh/xgfSdBLm65NotzutxcQ2FWq6u
         ORBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/UuO8fiOS4bQxOBXKgz7+LZucg/7sarn+dB6JnWEtVI=;
        b=HSj1UzoyT0dNKDJCepZTNJwCMfkvJYqDMCCMyjfgbxRyDx/hc7Uk081UfPFd85Zr+Z
         nonA6WQMHf9bMcVla+csGie5JvasVS2HL4ErmMI1+0eebzZvA3QoZnF1Z8sHNQte/h4U
         eYsprXeGZSyF7jF/aS/Or8aljlcAO5w0+SZWBjj70g3ybXftmV0BrBO2kbD/OYUuvqj+
         JWWBSRDWnTgb1a3bZNJdIpsaihdpVs2O2z1VzXDhqEw2JNELhTLsODqZKDgRPBvAKIwQ
         JrzZmSGdflakI/PRvCnlBYrgJol46fCw/MmkZkmYbK0UFKXL7r4sKt0PvUK3nNWoZefB
         ynZA==
X-Gm-Message-State: AHQUAub++JAkSsHrgAPe2XFf4l6/BiWqpx6m0CxNKYw9cS0V2E7gCRJu
        cgI/UNM8wh8ccT15onG+vPI=
X-Google-Smtp-Source: AHgI3IYD3jkXirzWf8zyZ33pv0vTkQFzrMwUGk6q50QclnkxNp0dxDB+Bvk83gxe7byuzJmGAOiU7A==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr290365wrh.132.1550097469871;
        Wed, 13 Feb 2019 14:37:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z3sm374998wmi.32.2019.02.13.14.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:37:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and committer idents
References: <20190204184850.10040-1-williamh@gentoo.org>
        <20190205195212.25550-3-avarab@gmail.com>
        <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
        <87k1iekkea.fsf@evledraar.gmail.com>
        <20190206000413.GA734@whubbs1.gaikai.biz>
        <xmqqwomdqzik.fsf@gitster-ct.c.googlers.com>
        <20190213164322.GA3625@whubbs1.dev.av1.gaikai.org>
Date:   Wed, 13 Feb 2019 14:37:48 -0800
In-Reply-To: <20190213164322.GA3625@whubbs1.dev.av1.gaikai.org> (William
        Hubbs's message of "Wed, 13 Feb 2019 10:43:22 -0600")
Message-ID: <xmqqwom39uwz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Hubbs <williamh@gentoo.org> writes:

> I am writing back onn this thread because I'm not quite sure of the
> status. v5 of the patch seemed ok, but there were some changes discussed
> that would have created a v6. The v6 changes though were never really
> clear. I'm not sure whether I am supposed to be doing something more or
> whether I'm waiting for you. ;-)
>
> Can you write back and let me know?

In general, unless I ask you to wait, a contributor would almost
never be waiting for me.

I think Ævar's v6 was not up to par, but I thought that v5 from you
(which is in 'next') was good enough to cook in 'next'.  The topic
will not be moving out of 'next' until the final 2.21 is released
anyway, so if anything, I'd say the ball is in his court to update
his version after the release, when your v5 may have a chance to be
kicked out of 'next' and replaced _if_ there is a better version by
then.

