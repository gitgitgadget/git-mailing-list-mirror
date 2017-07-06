Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DE6202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 16:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdGFQXE (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 12:23:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34299 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbdGFQXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 12:23:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so796154pge.1
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=REp5rx0xWiWvyf0FUgLy1OZ8UjFG6X2AhAWI+Qdo5vI=;
        b=I3kiSjyT/7yqwrPJMUO9UZ9LKX6a9YiV+DjZm6mvwrWJWY4WSqW2L+A/0RO5qrFxcZ
         26ezinTwAaKNoKlE8aybdMKj3M07deZoAhF2O4mVcuiiBkbOEpmPGkpjWEO5RBSMIaGb
         wcYvdiC1iEzl/ut7cmph8P0pqPE87wTr+y0tVmLwG0YC3K9ySjo5/OeWU/Ja8/V4Tw7t
         3gUkQU8hjMsxi81LtkfsYX3RFcURN0Uu1OziYjo1ltpyHuchN0IeslFDLduezc4aJFco
         xiRrln5FHDr+zc6HRxgFgbQg4Qp9HkdNXnqqXwBSTiBuhUq+jItlAjAVKiRYmhR8HusV
         07GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=REp5rx0xWiWvyf0FUgLy1OZ8UjFG6X2AhAWI+Qdo5vI=;
        b=NzX7CNV+xHg5hqKZb7Km7U6y/ulP3yJjDY1Ap76i46PiYCUrj/knZJEz/S+auHdRWQ
         SaiaRw0E3+/nT0VanAeV5pC08tu2lqH+/3EAVmWNVLqDPMDZhO7Lc29DX/4isKhzIkXu
         qjDCFgXgifHDQIkH1SH7dGYEOJo/jYogFd0cYzKTVofWbuqUMKA3kx7/Eif0B0Ajwoon
         g/DsVGe947CsjGSzjdcJH47XeT+GvMSx94AqFLicbMmsguiXe7YdHw4ut45kb2H8R9WZ
         J0J42neMebC11OP00HCIPAR85URST+CE5nprHyVMd9gTYmaotiKANWdKJ8jfUtTv4N6c
         rxyQ==
X-Gm-Message-State: AIVw113ebGZcnNQibvovzatcNRdUglpjUDX6AxQOGtJightj2W8VledJ
        PtpIypUY7EmZqQ==
X-Received: by 10.84.216.71 with SMTP id f7mr29148390plj.266.1499358183362;
        Thu, 06 Jul 2017 09:23:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id j29sm1169025pfj.68.2017.07.06.09.23.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 09:23:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] t5534: fix misleading grep invocation
References: <936f43ce2c993e545deaee5e196c018933375214.1499254650.git.johannes.schindelin@gmx.de>
        <xmqq1spukfyw.fsf@gitster.mtv.corp.google.com>
        <22feab0a-ca75-2aea-1ec9-2f71fe40c9d0@grubix.eu>
Date:   Thu, 06 Jul 2017 09:23:02 -0700
In-Reply-To: <22feab0a-ca75-2aea-1ec9-2f71fe40c9d0@grubix.eu> (Michael
        J. Gruber's message of "Thu, 6 Jul 2017 11:20:06 +0200")
Message-ID: <xmqqk23lfsbd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Junio C Hamano venit, vidit, dixit 05.07.2017 18:26:
>
>> The invocation this fixes is not just misleading but simply wrong.
>> Nicely spotted.
>
> In addition, the patch makes sure to catch any rev-parse failures which
> the original invocation shove under the rug.

Yeah, good thing that this got fixed ;-)

