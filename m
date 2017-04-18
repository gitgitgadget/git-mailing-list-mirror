Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220B1201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757173AbdDRTUx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 15:20:53 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33564 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755548AbdDRTUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 15:20:52 -0400
Received: by mail-pf0-f174.google.com with SMTP id a188so1117428pfa.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VQFIGsvo3vIL5ki4TxhbXahIzgAd9YcHUJbeS2F4aoQ=;
        b=Vfv6R+HEzpLWUJ3cgoqC607xAso3n7BJjw2UUhVXsupkeXsW5TQFvxMbtP+DghhDLI
         pkk6ZAjMbJ/BHW89TG8pOClAKfQmw2ZiUvLcYLs04lzIElQclfZItsvBLKQOE7/zbjBM
         iRr9QQGEihOGCiI+Op9WmJXKDKLVPLtMEnsyq+Vv+jXtthMjz9EsPdz2UOv6yZWXzv0m
         ksseS0D7slqQJh5TW+NcJaINyvnwb6SR0qKSNZXNz4a/TzHNXfa+3Eo0pS1WZE4IywOT
         9P6CsTx0Nw14TAF31F2wLqubfF2mW2l52uBYm9Ep8lXPzY0hrYOcrEEAa/UBAZKouNxC
         SpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VQFIGsvo3vIL5ki4TxhbXahIzgAd9YcHUJbeS2F4aoQ=;
        b=S66JIEl34QhJgpgnpEz6EXoxXBV+OM3JGr+6DrPwYIce9CCTAa+7QPtYWtKHGiwVsA
         zZlt6wJKrhbqbudpc74MndwhPHfjKGrEtbNiO9azTZISwJBix9QM9NZt+4/TRAF6l7Nr
         ed9BLdGiwiW+WvZfUJyINq3gMR5zVTVNREj0KEuwrWMQ8ZRejT216aklf1aMa2KWnWmI
         gbV4o6a0Olf7MZ+5lljScDKVpyaoVggC0iRaH1d6dLe/KnGNV41GvH8LB/1iKcwkceAu
         pH3f0cKJACXjHdOV+AZ/PKNvj8AuOkvClJ0hpceuPKJOWAty2ayE7tIhxZ43r7ppiBQX
         IZKA==
X-Gm-Message-State: AN3rC/43uKQugQ4rTpQjgbVik3uSoOg5ZbadaybURxH/wUpdhzhpge/I
        MwYaNPCr56kccw7GAmeeVNF28Viv4KhZ
X-Received: by 10.99.56.66 with SMTP id h2mr20079811pgn.40.1492543251591; Tue,
 18 Apr 2017 12:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Tue, 18 Apr 2017 12:20:51 -0700 (PDT)
In-Reply-To: <55524921-3295-90e6-6473-ae1289eeeb75@gmail.com>
References: <20170411072637.57369-1-larsxschneider@gmail.com> <55524921-3295-90e6-6473-ae1289eeeb75@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Apr 2017 12:20:51 -0700
Message-ID: <CAGZ79kbwQYCLXzVMr3wZsx3vA2zBMisqySt7SRQsnU_mQDB4gg@mail.gmail.com>
Subject: Re: [PATCH v1] travis-ci: add static analysis build job to run coccicheck
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 6:31 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On 2017-04-11 09:26, Lars Schneider wrote:
>
>> Add a dedicated build job for static analysis. As a starter we only run
>> coccicheck but in the future we could run Clang Static Analyzer or
>> similar tools, too.
>
>
> Just FYI, some time ago someone (I don't recall who) signed up Git with
> Coverity's free scan service for OSS projects:
>
> https://scan.coverity.com/projects/git?tab=overview
>
> Maybe it makes sense to at least link to this page, too?
>

yeah 'someone' is a good description. I accidentally took it over when
it looked stale. Now I have a cron job to upload the pu branch there
each night. (Which is one of the downsides of that service: Git is so
large measured by lines of code, such that we're allowed only one scan
per day. I wonder if that could be circumvented by each contributor having
its own fork, but let's not go that way)
