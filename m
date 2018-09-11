Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E2A1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 19:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeILAbs (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 20:31:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37405 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeILAbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 20:31:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so27177602wrr.4
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=01an5OFyp2eNAcs8X6ncwWCVjQjgr5IBP91QKV90KkU=;
        b=jGaXuh/44B4cAt25ztQd51Dc3c9wGAlMFER01OVhHZI7t8MZZX7Xwjqv381rpnSRv4
         Zr0YlagsNbAMgafoz+wocV6cN2xv0UGMz95DtIIt/o0dV585b3U7NxVWhXL1MWaCVqNv
         u1TWkPddlDk6mSHbKNDa0bD6Pg7cug5RujR5Do14pbaSHnNwQFTBVqAqS23QFTKfuAGa
         2ClppF6wzMh4iRY+sr9zqXNMZF+5HaGP7XWsuOowlhxkmgpSXXwc77OvbJaHXoeCbwjM
         O0PC/uzVHDO1czIwCJmwf6WuX/3qYCgoULSLR6A9Es0ZDmmvjmA3JSKCdjl9nSl9b6Gk
         iqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=01an5OFyp2eNAcs8X6ncwWCVjQjgr5IBP91QKV90KkU=;
        b=M6yRV/0M/bAw6He5HEofFihZl4T56RmIkDqq0JZc9IB9GPtiEvTtZQb5UOZ3j5o+bF
         /FPCVfjs+v1OxQnT2cJ5rEv+giQrC2uh/RzmAKmHiRWXa+x/Ennjm/fRMQ98Bu8kQQi8
         w6HWpohq0lbmBu/MYBoOgl7OBl8iXEwWg8jliumspuycA/Gkjwwgibc20DQr8LlDBZCb
         3NIkv+N5JqVNCByUw45y/+HTi+iMOryTnBIOY1umevZ8nhicD4SVlz8qMpYt2yH2QDPY
         7wvv7UOPTHqG69iDZICAbyp3KkMU24yFbT+no38c5PyiSw8YIOZAirT3vhqU4oTp6vxz
         2iPg==
X-Gm-Message-State: APzg51D5rSudEaF0IrjvCRwmUzUPa/wKztWrpXHDXkt1db/4eZR+ojlI
        kZEUmNBkM5L2AOXOHEcmEIeV/i3e
X-Google-Smtp-Source: ANB0VdaoKiyFEJjX5YCdT7B1TQrV80ZpPxAZEgLcGlPBCy8wojp6zzQuRNe38sxhTq35jQ3YjLfz9w==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr20646350wrq.156.1536694260928;
        Tue, 11 Sep 2018 12:31:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r30-v6sm27094854wrc.90.2018.09.11.12.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 12:30:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] string-list: remove unused function print_string_list
References: <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
        <20180911184850.24891-1-sbeller@google.com>
        <xmqq1s9zq1gm.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 11 Sep 2018 12:30:59 -0700
In-Reply-To: <xmqq1s9zq1gm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Sep 2018 12:27:21 -0700")
Message-ID: <xmqqworromq4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> The helper function stayed unused for 3 years. A removal of that function
>
> I think it stayed unused for more than that before the previous
> proposal to remove it was written (I do not bother going back to my
> earlier message that identified which exact commit this was
> introduced at).  It has stayed that way for 3 more years since then.
>
>> was proposed before[1], but now time has proven we really do not need the
>> function.
>>
>> [1] https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> I'll add a blank line before the sign-off.  Is this an example that
> our "where is the existing trailer?" code misbehaving?

I am still curious about this one.

In any case, I've reworded the above around "3 years".

    string-list: remove unused function print_string_list
    
    A removal of this helper function was proposed 3 years ago [1]; the
    function was never used since it was introduced in 2006 back then,
    and there is no new callers since.  Now time has proven we really do
    not need the function.
    
    [1] https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
    
    Signed-off-by: Stefan Beller <sbeller@google.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
