Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143111F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIQXUD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 19:20:03 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:37028 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXUC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 19:20:02 -0400
Received: by mail-wm1-f49.google.com with SMTP id n11-v6so10628061wmc.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NcHVzUyjJT1VnUOOyn9qA1hWsT6eBqcsGfe1nIsftoQ=;
        b=cW1QJMpiA3BPIENYj0IkITTQtsoEy+DX0yy/23b+rhSPWAUjttBTrqKWnGFtOanJ0x
         kfk2nhF2xzzfbmevEHxfwaZWT94612BMEgoZj8wLOEhII31FkkiGH5APNJXB8XGGw40k
         IYvt/jlxm4ZLpPvybpd50OER5wxwyJ8Nv/Ayg9GV2ncQeHfdmrpLUE/I0QwGOzJJBal5
         APi+c1p+r68xO7VLLBQu8QvCMCrnd6exCyFx8Kb7DlpZ623V2vnBoxfuAmbiAlQXt/5K
         HrGvF7hHvVdf/eTHHUv+/P2fynwXpba8o2sQaj+249sxvg0NRNxL4z6R+38yFK1Xz2FE
         4EmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NcHVzUyjJT1VnUOOyn9qA1hWsT6eBqcsGfe1nIsftoQ=;
        b=R7b2GCGrOCcEqQ0VGNlcp9bZINIlw51pGVRIciH0RmfbLT73okDTwStuzhfeFYjNLV
         fRyRTm9CPiu/T9bc1vUXmA7S0kZ1hvFhOtRWAMh0ubs6/5N1Mv5WBYQWt7XtANSfwrZ7
         qmSkn5EFz8wvVcyEaWXF2BSvZnD8qDEDA4EavIWaWQEHVBTIISh29EH3Tm2hr5GWMQDO
         cAVrQZLfbNI6kPgJh98wA5hrWW/PxSRz0Kmh2188u0Q6RArV0nhIhvyegI+cFZdpuvbE
         8RxSmk9lseQTE1R6v7FXpe7KYAt1PeeKQmwPT6QcvZGMSMTVha6AADed+cQZIDwK6cCT
         pCCw==
X-Gm-Message-State: APzg51BnwhpVr8AgmyRxdDM7YzxDhd/nRaWPWOR1cDUtMLnRDJxHLS3j
        vKXV5m6+p6UTbuFgaouWLR4=
X-Google-Smtp-Source: ANB0VdYNlwukmCgMtvE4imOtrS3WaaIhuy78SynhpwmEe8s3v0U3Ed2qi9icJ2IuAcv+kJIoFCgHaQ==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206-v6mr12713843wmg.74.1537206696195;
        Mon, 17 Sep 2018 10:51:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l12-v6sm13793275wrv.29.2018.09.17.10.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:51:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DXT8rF_WYE3C0ak7E8_8j=kRS+Yhi1pZjKd5Rr4OsM_A@mail.gmail.com>
        <20180917023912.GC22024@sigill.intra.peff.net>
Date:   Mon, 17 Sep 2018 10:51:35 -0700
In-Reply-To: <20180917023912.GC22024@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 16 Sep 2018 22:39:13 -0400")
Message-ID: <xmqqo9cw6mhk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> >  What's the donness of this one?
>> >  cf. <20180717201348.GD26218@sigill.intra.peff.net>
>> 
>> This topic has stayed in 'pu' for a long time. I thought it was
>> concluded that this was a good change? Jeff, Jonathan?
>
> I read over the thread again. I don't think I actually have any
> complaints about the patches as-is. There was some discussion from Junio
> and Ævar about the third one. I don't have a strong opinion. My
> experience has been that "gc --auto" is garbage anyway on the server
> side, but I think Ævar's experience is that it's reasonable for small to
> medium sites (which seems plausible to me).
>
> The message-id quoted there is my "this looks good". I mentioned a few
> possible nits, but I think it would be OK with or without them
> addressed.

That matches my reading of your position.  I tend to agree with
Ævar's recommendation to postpone 3/3 and use 1 & 2 for now.

By the way, people shouldn't read too much into the messages
referred to in "What's cooking"; they are not "these messages point
out all the issues that block the topic".  It's just "I am aware of
this thread, which readers would hopefully find a good starting
point to form their opinions".

Thanks.

