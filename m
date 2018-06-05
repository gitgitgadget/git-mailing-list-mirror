Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623411F403
	for <e@80x24.org>; Tue,  5 Jun 2018 10:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeFEK7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 06:59:43 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:43025 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeFEK7m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 06:59:42 -0400
Received: by mail-ot0-f173.google.com with SMTP id i19-v6so2234456otk.10
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F0j6jgM8D2ZFgBkGNtm4N/OIlIiAY4tYCHLQ04RqerM=;
        b=b20ZpL1X6xj0w9zfDjm/N5kY/0XcXlyUGOXlOM59RRfvndDMmT24GLx2pOWNxtkr0I
         fMoRpZTMNLz6lyI65DfUP4aeSBDEs9l3Y14BSqWqEutq/uLNnBWu5yYSyczFRD2cuhkV
         3T3lfcdaapfTTxmaGilSyd8EfZtrT4Mrz9s00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F0j6jgM8D2ZFgBkGNtm4N/OIlIiAY4tYCHLQ04RqerM=;
        b=V4pge+4ts/yuqhPPLZ1wQi+AoG9UtIdA3ago+vnsejxQ7jJcy6pSCi8M+WvZZtKzSw
         M+Ih4WJ7wT8fYPYWLMDp1aCdWkEBmqEJAzlOWiqd8NU26gZ4T3oYjiWoLplVStC4bueS
         aU2jg20bn1M0MGRNHz9/KYu0wHR2fR9c5GAW6GuSJUkFQIx7ieqO0OhkjK61olCEVlL/
         XTsi6rDdkg9EDReOpeS4gBybnEHqj9VOfqgFJ5cbmY2mWSsco7GCR8KvHmHy4VSyLOhH
         /hQYgNMJZMvpZ9522XboWxG7BvjImkIHUIvLzw29jjRb2ALVptcMrusfkn8zdC3SLPhh
         Al8w==
X-Gm-Message-State: APt69E1/DyUL4pcSA2FUiggNRlpTbX/iLpgSENkPpRqXtjjkO/jCM77s
        rlCGQhB+NBIZB7lkfAltcQ7SceNf6KD5XK4jZhA03A==
X-Google-Smtp-Source: ADUXVKLynKpBA3jcWlW1O6ppCy7nA04BAvJiQ6BNQDyK9pg8w5t0/8RM6QP7vhFRuslUEH1HgTCozUC/tYMczfwBNtI=
X-Received: by 2002:a9d:1f3b:: with SMTP id x56-v6mr7128987otd.369.1528196382200;
 Tue, 05 Jun 2018 03:59:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 03:59:41 -0700 (PDT)
In-Reply-To: <777690205.383623.1528195798488@mail.yahoo.com>
References: <20180605085524.10838-1-luke@diamand.org> <20180605085524.10838-2-luke@diamand.org>
 <777690205.383623.1528195798488@mail.yahoo.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 5 Jun 2018 11:59:41 +0100
Message-ID: <CAE5ih7_01ZixwnFP2kGN9Y5M26MyNai82USUr2UfunL3Ubztdg@mail.gmail.com>
Subject: Re: [PATCHv1 1/1] git-p4: better error reporting when p4 fails
To:     Merland Romain <merlorom@yahoo.fr>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 June 2018 at 11:49, Merland Romain <merlorom@yahoo.fr> wrote:
>
>> @@ -91,6 +93,13 @@ def p4_build_cmd(cmd):
>>         real_cmd = ' '.join(real_cmd) + ' ' + cmd
>>     else:
>>         real_cmd += cmd
>> +
>> +    # now check that we can actually talk to the server
>> +    global p4_access_checked
>> +    if not p4_access_checked:
>> +        p4_access_checked = True
>> +        p4_check_access()
>> +
>
> Just switch the 2 lines 'p4_access_checked = True' and 'p4_check_access()'
> It seems to me more logical

Like this:

+        p4_check_access()
+        p4_access_checked = True

You need to set p4_access_checked first so that it doesn't go and try
to check the p4 access before running "p4 login -s", which would then
get stuck forever.

>
> Romain
