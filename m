Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913AE201A4
	for <e@80x24.org>; Mon, 15 May 2017 03:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756974AbdEODs4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 23:48:56 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33105 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdEODsz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 23:48:55 -0400
Received: by mail-wr0-f173.google.com with SMTP id w50so72388619wrc.0
        for <git@vger.kernel.org>; Sun, 14 May 2017 20:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ihalo0Z1CTxVYTdI/kQ9cnl0ZcRAAe3MaXZdoxYWlag=;
        b=BygRh+JVUd6RF9Hc4p6N3QqziHlPt6AKjSonWtWJ9wXKiKSJrsTN6NKtrEJpESfnNX
         XRIe1es9PhLz6iwHsUTxpczqoejc9zifD4S3lMdEWfhMlabmMMYY1uuqQCqLPeZclayx
         fIEYGsVpltSLdSmPkPjkyN7cW0+KsoUb47R6n/aTUHjn0OWIxTzyMiIqGUEialTi7jRO
         xLNTV3AiStapEtOSjidUm7bmRBfC6gAZZnl4spqWYBky63F+Ej5mE9MWrNrx9FHA/YxW
         aamvfQstfHrlND4+qZ1o5ANBWnDXMKj2dC00fqDRg6vD+mQ9lY0oMX0JblTmxIZ1hvXH
         j9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ihalo0Z1CTxVYTdI/kQ9cnl0ZcRAAe3MaXZdoxYWlag=;
        b=MZRB6emyuycGFkYBe2/97uReRAupaFzZQDrP4ZsAN9NQm5cv9bSz1akmGG3QBxdC9E
         EhVtGJlUd4nFMFlKBXhBiprVI+/PdR1PldAWx1xFRhS/gBrGR5snEdzROTnXHgbFhHf9
         30O/LRkfjUu632qwD05BvPxo2SzdNRv+sT0/rcSoKJ5DYVxZIPlP78kVv6Z7STDXKG7X
         I+CpfNLJkLJ+WcHncBuD4IRx7n8qagTV7AzdM/Ki4DZQNnhKOZXTxQ4NaCI12+WEZLaS
         kafEj4gS+B7iFL7003pwxKaKddoQ4O69mvzGETs5tyYeSiXHCX2ReMyXOCsnMV3dO5rG
         Xp5Q==
X-Gm-Message-State: AODbwcCSlGxr7SHYV4YTEruGtsgNuNCmFMz5wIkkMEQ7iQN8E+mnSZq3
        JXaUmG0i0tnnfhfuUYMB4Dm1xq4uSw==
X-Received: by 10.223.176.163 with SMTP id i32mr2994852wra.32.1494820134159;
 Sun, 14 May 2017 20:48:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.100.213 with HTTP; Sun, 14 May 2017 20:48:33 -0700 (PDT)
In-Reply-To: <xmqqy3tyx2x5.fsf@gitster.mtv.corp.google.com>
References: <20170512221221.406645-1-sandals@crustytoothpaste.net>
 <20170514180058.842315-1-sandals@crustytoothpaste.net> <xmqqy3tyx2x5.fsf@gitster.mtv.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 14 May 2017 21:48:33 -0600
Message-ID: <CAMMLpeSpgfOFLV_WE6yQzp2aKta9DEt+Z5gDGDhwrEDzfqtwBg@mail.gmail.com>
Subject: Re: [PATCH v3] builtin/log: honor log.decorate
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-14 20:35 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> The recent change that introduced autodecorating of refs accidentally
>> broke the ability of users to set log.decorate = false to override it.
>> When the git_log_config was traversed a second time with an option other
>> than log.decorate, the decoration style would be set to the automatic
>> style, even if the user had already overridden it.  Instead of setting
>> the option in config parsing, set it in init_log_defaults instead.
>>
>> Add a test for this case.  The actual additional config option doesn't
>> matter, but it needs to be something not already set in the
>> configuration file.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>> Changes from v2:
>> * Add a test.  I tested that the config parsing both works with
>>   additional options and also can be overridden from the command line.
>
> Thanks, all.
>
> Will queue with Acked-by by Alex and Reviewed-by by Jonathan.

That sounds great, thank you.

-Alex
