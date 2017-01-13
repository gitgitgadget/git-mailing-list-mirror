Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075C520798
	for <e@80x24.org>; Fri, 13 Jan 2017 09:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdAMJQc (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 04:16:32 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37078 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdAMJQb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 04:16:31 -0500
Received: by mail-wm0-f48.google.com with SMTP id c206so61869417wme.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 01:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KpMMnj63cVDDau7XOaI/cabNZ12W5CmCpGw7NlKHiM4=;
        b=RF3gkyyqkpjjoreffaxkyT0HMZULNA+r+80aF5EHFLQFvnCbcQwAT+/7wmvmA0dBGe
         eDPp3RFnmnAdDu/rurnBHurRX3rI+ztdVDeBDb0VBJzO0W3smRtk3cUqd9luXd7smIjX
         LXmRbeEesecT2YAfpej9Dlr4HDln+g9uzDVSOPFbbOYSfQk1oL450ZgrEOGWHSfeCWI8
         MTv5OrIFiUOTB3ghXteua54XKDKK8YC7XHpHhUWc3Ek3j8l2MH0dEnvkuUZW+MREoZQd
         pRR1/KilldpTYcNxuOlO2plncf5G+fGufvrNCQjBZNvTPKOmChZRf9VdN8JJq7sdRjOA
         GAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KpMMnj63cVDDau7XOaI/cabNZ12W5CmCpGw7NlKHiM4=;
        b=Hef0Mv/YC2qIiyBqdPX+VNhvRg9tTgfwBnXYRsfGdNUPe+TI5YYQ/WJ/sojPF9cljM
         1R9cRMvXLyJUcOYKhDmHgktBsf4SRRD5nxAK4r5UaNOardU5ShY36PCrn0Y6j2E9mlzA
         tYnp6FZ6yNRe155fFr4hpD4ErBz7lzd88f62uScyHkQ85OVxQUyzoHH+67E8XIrf1WVs
         4UOI9CmQd4TyuEziy8S2iarIE6SxAhT7eF6ao3s0riyGld25dqSGh4qQjVYJz0eTlKv+
         R9qNmYRbzLLpQ5WZRe3L1sNNfPIo5QYLTOHF9GR887H6lBWJQszlqUrmCxzJCO5c8Z0x
         G6ig==
X-Gm-Message-State: AIkVDXIP/AhDKKEyrFqa4HUTf2xPHn2K9WgmlOOxfuNU+ays5qLszVxYxZDuv0QzdYZvWXwgcXV4UEvtrXNbvA==
X-Received: by 10.223.160.172 with SMTP id m41mr10860019wrm.31.1484298990134;
 Fri, 13 Jan 2017 01:16:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.94.71 with HTTP; Fri, 13 Jan 2017 01:16:29 -0800 (PST)
In-Reply-To: <1483825623.31837.9.camel@kaarsemaker.net>
References: <CAEBDL5Uc39JagdmXUxfxh1TPSK3H5wxoTfjK-pfLRYjciBnHpA@mail.gmail.com>
 <1483825623.31837.9.camel@kaarsemaker.net>
From:   John Szakmeister <john@szakmeister.net>
Date:   Fri, 13 Jan 2017 04:16:29 -0500
X-Google-Sender-Auth: WV_CwhpGxp_DHpqumDQ97Jlhmoo
Message-ID: <CAEBDL5WKsMT7XHdX1gAWW3-WaJo7p7R60uogWZEuBCYGsu+s5Q@mail.gmail.com>
Subject: Re: "git fsck" not detecting garbage at the end of blob object files...
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 7, 2017 at 4:47 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Sat, 2017-01-07 at 07:50 -0500, John Szakmeister wrote:
>> I was perusing StackOverflow this morning and ran across this
>> question: http://stackoverflow.com/questions/41521143/git-fsck-full-only-checking-directories/
>>
>> It was a simple question about why "checking objects" was not
>> appearing, but in it was another issue.  The user purposefully
>> corrupted a blob object file to see if `git fsck` would catch it by
>> tacking extra data on at the end.  `git fsck` happily said everything
>> was okay, but when I played with things locally I found out that `git
>> gc` does not like that extra garbage.  I'm not sure what the trade-off
>> needs to be here, but my expectation is that if `git fsck` says
>> everything is okay, then all operations using that object (file)
>> should work too.
>>
>> Is that unreasonable?  What would be the impact of fixing this issue?
>
> If you do this with a commit object or tree object, fsck does complain.
> I think it's sensible to do so for blob objects as well.

Also very good information.  Thanks Dennis!

-John
