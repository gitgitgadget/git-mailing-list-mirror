Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC0BC20446
	for <e@80x24.org>; Wed, 18 Oct 2017 21:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdJRVZx (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 17:25:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55495 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdJRVZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 17:25:51 -0400
Received: by mail-it0-f65.google.com with SMTP id l196so7586169itl.4
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=omH9Xo1nK3GB1X6aBQdMicX87HPKNpp04C+zWr5XpIc=;
        b=Trg3MKwmNkqOny8D1XscN/0IprzpgrG2VqcxH/lAi8lpPxaau+a514DNUm0zY7q01r
         4RgzHBvzVufWsKhmLOMrrkIq0+ekEf/SyPQuEQ7sCzzMxvrzaxKveYgEjh/C8EzyWncy
         1SKTTGzyxudBe9Xzh03I0OYIaO/xMpO7d68Alsq76C+SBcoTGRRdLTWmTOJRNi0hUVNG
         9D23DX36GeFs69KbE8GaKldNiDYA6ab6hhtSLn/SI2h//1oeDvFk5a7ORYwk12Mcvi7B
         X2hBQGNXeK+1bJnlJbPPsj3tG2doE+gnhHi9DkilFq+Xo16vchY8nVMlYI+H3xJMQQms
         Q4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=omH9Xo1nK3GB1X6aBQdMicX87HPKNpp04C+zWr5XpIc=;
        b=tGqNOmKXAxIWg1F+kURCfxVxT2ziD76oaKeg3i48fIC/Ub533oo+VYhftpS5PNdkjx
         o/JytKM1g4lXL8pz2Q/HRpMacucvVyo9A/6PWHwpZr6O9s/uKHcdoJLPoMhM6k5qSG/O
         O6DrPD67FpqPndF5lA7gR6117LUoRDoNTRu3WUu12OsgaApWCjKIAoXL1tfxSzcrRszR
         VpXJypfEMQcehkyexRr4YSU1lLvfXGO5J0ktvDsTjFq76IHBFR0hHs8mGCR3O7FKOfDR
         cz87zXfBlo9ifl06vBTPCw2D+VFca3XQ/0HpaAsrkGyteOtU5CQiAa1jc9GEWpnYqQLI
         w8Iw==
X-Gm-Message-State: AMCzsaW1LrJiA9PJK2tkn8HtWqfI7zlyrB/rBr2H0oI48WOk40mhUnBo
        AuIuC6EVgCusq9o6KYyLORp7JJPeDpxj61eutjen6Q==
X-Google-Smtp-Source: ABhQp+TNhTEtVxKWtFDX7A+C/lOhe+oxX/w2roGLzghC3kxym1H1xbjQSiCRrRb7fbBR6/mcssnaNQ8Xi2BpQbuW7zo=
X-Received: by 10.36.205.2 with SMTP id l2mr11381477itg.63.1508361950466; Wed,
 18 Oct 2017 14:25:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Wed, 18 Oct 2017 14:25:49 -0700 (PDT)
In-Reply-To: <20171018105801.GF19335@alpha.vpn.ikke.info>
References: <CAP8UFD3tG3fOgftFJAB4mKD2N+uAH0aac4RmFmdXZ=ORHmKzQQ@mail.gmail.com>
 <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
 <20171018105801.GF19335@alpha.vpn.ikke.info>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 18 Oct 2017 23:25:49 +0200
Message-ID: <CAP8UFD2D7hUVkE=5bpk7sn8DnUgtwZmj-Q4xHCej279LJvMKyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] perf/run: add '--config' option to the 'run' script
To:     Kevin Daudt <me@ikke.info>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 12:58 PM, Kevin Daudt <me@ikke.info> wrote:
> On Sat, Sep 23, 2017 at 07:55:56PM +0000, Christian Couder wrote:

>> diff --git a/t/perf/run b/t/perf/run
>> index beb4acc0e428d..1e7c2a59e45dc 100755
>> --- a/t/perf/run
>> +++ b/t/perf/run
>> @@ -2,9 +2,14 @@
>>
>>  case "$1" in
>>       --help)
>> -             echo "usage: $0 [other_git_tree...] [--] [test_scripts]"
>> +             echo "usage: $0 [--config file] [other_git_tree...] [--] [test_scripts]"
>>               exit 0
>>               ;;
>> +     --config)
>> +             shift
>> +             GIT_PERF_CONFIG_FILE=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")
>
> Is the idea of this construct to do some kind of normalization?
> Otherwise it seems to just result in $1 again.

Yeah, the idea is to get a full path when you are given a relative path.
