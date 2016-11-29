Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0341FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 12:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbcK2MIt (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 07:08:49 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36283 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbcK2MIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 07:08:47 -0500
Received: by mail-yb0-f193.google.com with SMTP id d128so961198ybh.3
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UOoHJUpR56Lh5/uZN0ym/INAPv0XnoRs+Nv8gMJlKX4=;
        b=F5EkapGK/5ehyFusvocXGFKqlgXRBP1TDZhYhBeJla9RjvZn1nMDHRMnUfSN6ZZBUw
         /IC6lm27ws1wd8jKwG8a/Pu21GVgiRRQ3uRIKkFBB1jZjaLW2pv8W2bG9D2DrmT8kJgU
         z7UzTTLUgt7jJLTG0otDyFhFux1VCmZc9chdv9Q/7WRYaRweum4kiZKFxgyJuLQDOG0g
         uuEk+Xi2l+ah8mUAHJk++NW+9vqiQBXe0xbKKvI4/LovTW9XxAkuCjqNmMGjoDdTezbO
         qJLcZ+v3TfEOvOS082zgzgYJ9dVD3iMYj+2Dx4nfB1QXCPVSuhsoKPsrDb4aaifVNpo+
         YiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UOoHJUpR56Lh5/uZN0ym/INAPv0XnoRs+Nv8gMJlKX4=;
        b=HE9rSrt4WE/zM05oifr0p6PCZ8zV06PhU88PmRmiK0Uar7eq1TTmicHj3meiP0Lmhs
         i2+e828jb0WYbMxQmYgsZE8WrsUhtLh449aCgVrO665hQuBPVUsF12ZiY4zbymy1Nh2j
         /k50SYpjNV8Aiv89/v9xQa6xVAHQeccPDzNTsuErggAM++UucKLLuwWULiPUqod3GKzC
         w1+xDAejws/wNkJEzB+NNzveeNcAH454ty5eiqAl7/ZBAhYwBMQP1gyP0zmgCrvMS7+P
         dYkR3qT0GUhpAUYW839lPmJPjP8LP1+pF46jarfmf1HhssL6sZUzMMpn2AjZ3glrcsLK
         TM6Q==
X-Gm-Message-State: AKaTC011aLdVnJyRiuuVdqnAXxzELaHRp9TqtgBoXAb3q5kKIQBpLYyf4/EOZi9hFIvp8XY0W8Dm+AhugnW2eA==
X-Received: by 10.37.161.197 with SMTP id a63mr3700122ybi.163.1480421326954;
 Tue, 29 Nov 2016 04:08:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.162.39 with HTTP; Tue, 29 Nov 2016 04:08:16 -0800 (PST)
In-Reply-To: <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
References: <20161112022337.13317-1-pclouds@gmail.com> <20161128094319.16176-1-pclouds@gmail.com>
 <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com> <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 29 Nov 2016 19:08:16 +0700
Message-ID: <CACsJy8DQDPzZGJXLpTVHVFUeupPpp5e=b9z4m7xceJWrxPfF3Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] git worktree (re)move
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 3:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Does this round address the issue raised in
>>
>>   http://public-inbox.org/git/alpine.DEB.2.20.1611161041040.3746@virtualbox
>>
>> by Dscho?

It does not (and is sort of expected), quoting from the commit message

    copy.c: convert copy_file() to copy_dir_recursively()

    This finally enables busybox's copy_file() code under a new name
    (because "copy_file" is already taken in Git code base). Because this
    comes from busybox, POSIXy (or even Linuxy) behavior is expected. More
    changes may be needed for Windows support.

I could "#ifdef WINDOWS return -ENOSYS" for now, which would make it
build. "git worktree move" won't work on Windows of course...

>> Even if you are not tracking a fifo, for example, your working tree
>> may have one created in t/trash* directory during testing, and
>> letting platform "cp -r" taking care of it (if that is possible---I
>> didn't look at the code that calls busybox copy to see if you are
>> doing something exotic or just blindly copying everything in the
>> directory) may turn out to be a more portable way to do this, and I
>> suspect that the cost of copying one whole-tree would dominate the
>> run_command() overhead.
>
> Please do not take the above as me saying "you must spawn the
> platform cp -r".

For the the record this was my first move but it will make it much
harder to handle errors, and there's no native "cp" on Windows.
-- 
Duy
