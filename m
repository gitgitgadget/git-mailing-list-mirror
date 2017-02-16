Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5A01FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933126AbdBPSBt (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:01:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33626 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933001AbdBPSBq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:01:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so2569613pgj.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 10:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wulVVrO6DTj0KqJY8JtmdvDwwO0p138Ftst0MXS0+2M=;
        b=NC9VXTD11bBfAcPrSZjn4MUGli1GTfuhkLVmSV7jphuCMsVhF3E0AovdV4jJIFLeIY
         pM9A1X8+AQvSpd0YT/lNBpzzOv0DRBRdTkq6JicNhW9qDp3iCgScuIFbLpxcGNMxlRcS
         sPnRQd+CD+1RzaHWUHq7RB8f9Naw6OCO1wDSPh5wKbxdZJTL/i8KePo240+fBcZvkZpe
         xje9mNl8Wg9yOOtFX5COUsR/Vvaufq/jsDZEm9rXMpEhKVBEMiwKXd6N0XqhqGkFQlw+
         74/8SLbrgpL2Hh9AoTIQfJO957sTjPxk5TEhno5QdLvANExdX30kRsiDH3AxwVWCE0nD
         FcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wulVVrO6DTj0KqJY8JtmdvDwwO0p138Ftst0MXS0+2M=;
        b=nJjiCqNFUGEeApAUVm4gY8+l3LBqz1dN5nSJhuCirPuacC1KQ981qJab/TMuBKes5L
         Qdy/cC3tqqUfY95WqzvNlcwdaOdOvDrC3QQEcsIS2gS22rqiqvmDJj7SN0fVCaKusFbv
         7fCqQ5v3QQmGQ+QZWehaG0TyVx/INjon4Tg84oG/86Iz+zATUi0F0N78y9NbEnaoeJdj
         tsk7DeOd8v1phvL0bNhrG268wfPn6+pm4LjhaNi6Qw3/tIOcrXqNLjnhMasj9MVq8fMY
         tyVx2QIOmtT7u0Q6ODKe7T5pZPQW8u8fgD5z2ii8uEGu2EKumnsBB/sfOLi5iD//I2vc
         sdnA==
X-Gm-Message-State: AMke39komtNh5tTqmPWBo1zo+8NokZkypEY0w5QopvSap/5HomzNuFZcvVhI5qOQFwQXwA==
X-Received: by 10.84.162.204 with SMTP id o12mr4953778plg.132.1487268106248;
        Thu, 16 Feb 2017 10:01:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id z4sm14942321pge.49.2017.02.16.10.01.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 10:01:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
        <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702141545380.3496@virtualbox>
        <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org>
        <alpine.DEB.2.20.1702151312330.3496@virtualbox>
        <0275af7b-eb7a-1094-a891-674300175e56@kdbg.org>
        <alpine.DEB.2.20.1702161753050.3496@virtualbox>
        <d1c65a34-3809-ee76-5e00-69ba715e0093@kdbg.org>
Date:   Thu, 16 Feb 2017 10:01:44 -0800
In-Reply-To: <d1c65a34-3809-ee76-5e00-69ba715e0093@kdbg.org> (Johannes Sixt's
        message of "Thu, 16 Feb 2017 18:55:41 +0100")
Message-ID: <xmqq1suyypyv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.02.2017 um 18:10 schrieb Johannes Schindelin:
>> On Wed, 15 Feb 2017, Johannes Sixt wrote:
>>> I do not see how dup2() causes a change in stdio state. I
>>> must be missing something (and that may be a basic misunderstanding of how
>>> stdio is initialized).
>>
>> It appears that dup2()ing fd 2 resets that stdio state.
>
> OK, thanks. It's surprising, but so be it.
>
> Thank you for the quick fix!

I am happy to see two Windows folks being happy.  I tentatively
marked this as "undecided" after merging it to 'next', but let's
have it in the -rc2 and final.  Two people familiar with Windows
agreeing that there is no longer mystery why it fixes, after seeing
that the update fixes a regression, is a strong enough sign to me
that including it is better than leaving it out.

Thanks.
