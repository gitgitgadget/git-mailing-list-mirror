Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3671F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427041AbeCBRHZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:07:25 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33672 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425940AbeCBRHX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:07:23 -0500
Received: by mail-wr0-f195.google.com with SMTP id v18so10163304wrv.0
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CGRMKx3H9SYwF53XTmTWRfc4k1aSL78CNUdSahm9kNA=;
        b=ke5EWV0Xcgo53vdG1chU38n2WSwpBVQAmR3cEUkPG5Y8j7tyoBIZZ+PjBQJNtUrn4f
         1OCpR3wr1v4ntybnMWGqzFhyFS9g4R5NldUmxkFBpkFJfySvlZ3eeX4cBQSdkQUZiUdh
         zAwE3/Ukydld81OmPOs/Xhmwx0wn+ppnmyh5Y1eVZhsJZjBT0rv64z4hu+0dpwBEX+uq
         iwqloWpK5/XmbLIPJUr5qouE6w8ggLY787UT8+zujjA0olhojbWXKvbA5VhVbIvMnbka
         uEPuCGk9/5AYa6B0lFmQHjJYAr8NSn0wfc/IAqm9P95aKTedvqkpGEMyOmJOCpx1cFCL
         +DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CGRMKx3H9SYwF53XTmTWRfc4k1aSL78CNUdSahm9kNA=;
        b=qKDQI7f1w8Lz6pp6eU2bsLaFn7j4b4J0bJSzI0QZAdbksyasaDvwb7jfKITmIFpSMl
         sz8l33Q2124MkPlOsucJ4kDUzCI8LlrUwJO28qfv/2LjrsirJuYjdKsM7nmTEeJcNCnE
         1pIDJQGxizBULoN2NCbrq36GlAX5RIQamtjQlEs097WsS4/c8IZf/g4pqeBhz11cStZj
         4QlhCKNhSxnvKqncSUfohtcuHJ1LmYaUN2HWlKia+xPCfKy3tsrp3T7kUBMEJ1KFN9dR
         kXPtNRuOI7QxoDH0wUh4UJ5FK+S/stmPWlPegJeL4ZlD8oOKNVPVF6q43rhXo+PTLb9g
         G3qw==
X-Gm-Message-State: APf1xPC1EmMZo+74eMHi/KVvPJpUentnJBLPTqI6eo4/SoqhCkl9C5zD
        LXMM384F05E8ROlboAdKjypEolC35xQ=
X-Google-Smtp-Source: AG47ELs8eAJ1g/nURwPP9HA+BiQjKu+0YPcjTR0V9525QGBhmFSv8+cvA11EMRxQrLhw0T6js6Yghg==
X-Received: by 10.223.143.76 with SMTP id p70mr5437008wrb.87.1520010442347;
        Fri, 02 Mar 2018 09:07:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z73sm10354627wrb.50.2018.03.02.09.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 09:07:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2018, #01; Thu, 1)
References: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjmRT-vdyxsXTk1FB4BMLc8z6968kapqyqx5djKof5hQFg@mail.gmail.com>
Date:   Fri, 02 Mar 2018 09:07:21 -0800
In-Reply-To: <CAM0VKjmRT-vdyxsXTk1FB4BMLc8z6968kapqyqx5djKof5hQFg@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 2 Mar 2018 17:33:00
 +0100")
Message-ID: <xmqqwoyucsom.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Thu, Mar 1, 2018 at 11:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * sg/travis-build-during-script-phase (2018-01-08) 1 commit
>>  - travis-ci: build Git during the 'script' phase
>>
>>  Stalled for too long without any response; will discard.
>
> I still think this is a good change as-is and it does make checking the
> results of Travis CI builds easier.  The issue Lars raised in [1] is in
> my opinion a non-issue [2] in practice and Lars hasn't yet disagreed
> with that.

OK, so I simply misread the discussion and did not realize that it
reached a conclusion?  If that's the case, good ;-).  Thanks.

>
> Not sure what else I could say what's no already in the commit message
> or in my response in [2].
>
>
> [1] - https://public-inbox.org/git/5DE3FA05-2347-4BE7-8A1A-A6E5FEEC7C2B@gmail.com/
>
> [2] - https://public-inbox.org/git/CAM0VKjnSzoc+E408ifKCg+qPTaGRNL3e3JVdRN573kdcBSzbHw@mail.gmail.com/
