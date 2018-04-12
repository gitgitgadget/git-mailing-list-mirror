Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881361F404
	for <e@80x24.org>; Thu, 12 Apr 2018 20:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeDLUqi (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 16:46:38 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33499 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeDLUqh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 16:46:37 -0400
Received: by mail-wm0-f45.google.com with SMTP id o23so4554611wmf.0
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=s23z1S2p/i/vRmK20pS7DupxfFP50Q3Ay3smmvZY80c=;
        b=DlAFwwOA+UGG9nPSHveT5+L5ueRmIwoBKAtl5bigePq3hBaBHUpnHUUSlDGMtVENrG
         mnfXqrHAFmzj/M/wL4PBgpwvenzA6Nrv09wEG0MRX12vU3RifA5xBnqi/33fAJNgxZUJ
         4wevy0Rkx7IAMqmpUvQ7tWqiGFJjONeNuKS09HqKSBZoXNwzB3l6/yzrnyogecY0jCk4
         arUYv4N9j53d3N+s/0YzbNxcBsGZ0abItEI432vbEFOsumvgziDtQV7QocxCCEVC2Gh8
         49OiXfvR1Gpbe+aYbQTPpr+6mH7JmB3xh9wqLPTddMnbVsATsryQyJzcr5ang/qZIp/Z
         svYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=s23z1S2p/i/vRmK20pS7DupxfFP50Q3Ay3smmvZY80c=;
        b=jwWG3JlbuEawBj8bNCy/5EuRWn9UuPnjfR8uxE4uk2COuf9BGZpvDUnwhYf8vQfdzE
         qVNxo75ecgpOE9JtTlja2hf9wQtCZsrmjBubSijEEjGFDdE405JijakvSkxawTB3/Car
         1OwSC50ZpQWp72OkrBEByXVb3S9Lv35bI6yHcx3pCfw7uHLYKig1fxDOQk6I3rmr/7J2
         IBRfyjshfCnXGh0svVFEvxKtdgYlfo8Jdd/FgGG9cLWFqyfgJ/Z0lOps1WK35jf3a/hb
         Wu0czdeY+XFEC7T5UZArG8dOrjR81q9Bw2UgF9wmxuVW5FfXMARirDnrhUPqsS7VLQy5
         KyqA==
X-Gm-Message-State: ALQs6tAk4d43YIObTQsGK4LkBUWOt2Npsd06DesBIOqZ4OMZy09HU51F
        +lLi5G2n5tEiIOLN0TPD9wIrpOjf
X-Google-Smtp-Source: AIpwx493AP0xiBlrWLhM10cG+Sm0uj/BKFpA3vlp/08G4X8B/zeSUYrodk4rf4utp0/S3vIzqu99dw==
X-Received: by 10.80.139.184 with SMTP id m53mr17217897edm.6.1523565996404;
        Thu, 12 Apr 2018 13:46:36 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id t11sm2419536edh.46.2018.04.12.13.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Apr 2018 13:46:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Cc:     git@vger.kernel.org
Subject: Re: File versioning based on shallow Git repositories?
References: <hbf.20180412fvfi@bombur.uio.no> <87d0z4b6ti.fsf@evledraar.gmail.com> <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no>
Date:   Thu, 12 Apr 2018 22:46:34 +0200
Message-ID: <87k1tcf905.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 12 2018, Hallvard Breien Furuseth wrote:

> On 12. april 2018 20:47, Ævar Arnfjörð Bjarmason wrote:
>> 1. Create a backup.git repo
>> 2. Each time you make a backup, checkout a new orphan branch, see "git
>>     checkout --orphan"
>> 3. You copy the files over, commit them, "git log" at this point shows
>>     one commit no matter if you've done this before.
>> 4. You create a tag for this backup, e.g. one named after the current
>>     time, delete the branch.
>> 5. You then have a retention period for the tags, e.g. only keep the
>>     last 30 tags if you do daily backups for 30 days of backups.
>>
>> Then as soon as you delete the tags the old commit will be unreferenced,
>> and you can make git-gc delete the data.
>
> Nice!
> Why the tags though, instead of branches named after the current time?

Because tags are idiomatic in git for a reference that doesn't change,
but sure, if you'd like branches that'll work too.

> One --orphan branch/tag per day with several commits would work for me.
>
> Also maybe it'll be worthwhile to generate .git/info/grafts in a local
> clone of the repo to get back easily visible history.  No grafts in
> the original repo, grafts mess things up.

Maybe, I have not tried this with grafts.
