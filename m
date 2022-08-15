Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C947FC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 13:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242832AbiHONWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 09:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiHONWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 09:22:43 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B11704B
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 06:22:42 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a13so225927ild.3
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CwJ0tcjDh2W+f9BOOhdYk92ITFtWlq9GjgtWkFafXrQ=;
        b=eQZ5jyJyoGB38H5d0cS90SMlZbhd3pmhMAsFnFUXNcmGFxA4OexiRi2w840a95p5cR
         uI1JFlvFpliXbnuPMIKQU0vFdGxexat3jaKslDOuiYQUipu6eVQ9T5O39y5+cNwYC7Cw
         0Vt+cZxYYIPExocsd1TaascudcSKgHXEpdmliVw3FZ+/7l7vIA+BVh43bjXBftyE75nf
         7VyxH+xtGTDD+EyOp0YoSOtXTaVff8QE3MAvfkxDWgivQWLdbXWXGh27x9a7ms0PKZeT
         ZQewFwrb04DIEiN8bLdp/f7K2ABru0ja4cLeg0Ws7JxvogStHxzjqLuLNC09OYgWeTiF
         JyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CwJ0tcjDh2W+f9BOOhdYk92ITFtWlq9GjgtWkFafXrQ=;
        b=2pzU8kv7l1gfkmp2Y4m7DqSqkUYHXWf3qpAKLf9Z04fdKvsSe7zsWND3S4j5/P5Zrm
         wbhwGLWxmzIC/BdkDnQVmGKS15kDznAsk/rcU1sjffInUDA+dNV+AJG0dtaEaVkIDmFK
         RuVpJzEeUCuZmYGM1Hwjh4oKPm8sTeiw3Wqjik0Eh4j92Z3lmZjkSF+esmJFYyPofXR+
         6WoIkSCbMjDCLRvcMch8pkZWmyRAKWSCHK17ih5o3lzD3IrEdiOfUDdPGJQiKBpDVkxv
         QUFEzGsKikaEaNcGfFa64fOTQ+G/3IxXvcjsxiZdSlC22oHWM4hzUAqH0HcjySXuFHUX
         w+jw==
X-Gm-Message-State: ACgBeo2bTscwyMn+EoKPkMH78C7meoIAkKEI9J2rpBEhT0aVdd+HrUvt
        HOFdPId1Y1iqlqoxogkIOflC
X-Google-Smtp-Source: AA6agR7XBcLn8W5i5gmxCgZf+xtyG79QYg/OT9DuxvvNp/9wyAmnzjbzv2IN4ZKisaQBtwJ/7qGjKg==
X-Received: by 2002:a05:6e02:170f:b0:2e5:f418:8d6a with SMTP id u15-20020a056e02170f00b002e5f4188d6amr20032ill.126.1660569761759;
        Mon, 15 Aug 2022 06:22:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:dc96:39f4:9d7d:e4b1? ([2600:1700:e72:80a0:dc96:39f4:9d7d:e4b1])
        by smtp.gmail.com with ESMTPSA id a65-20020a021644000000b003428d4edc70sm3300005jaa.176.2022.08.15.06.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 06:22:41 -0700 (PDT)
Message-ID: <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com>
Date:   Mon, 15 Aug 2022 09:22:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: git maintenance broken on FreeBSD
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Renato Botelho <garga@freebsd.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
 <YvZnQFVMZZmz9TIX@danh.dev> <YvcdskzUkocUv/d7@pobox.com>
 <xmqqczd4ag8f.fsf@gitster.g> <YvfFUuuydtYeuvRx@danh.dev>
 <xmqqsfm08382.fsf@gitster.g> <Yvfg7WwL8oCdxqzQ@tapette.crustytoothpaste.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yvfg7WwL8oCdxqzQ@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2022 1:35 PM, brian m. carlson wrote:
> On 2022-08-13 at 17:26:05, Junio C Hamano wrote:
>> Does FreeBSD offer choices of cron implementations other than Vixie,
>> just like some Linux distributions?  If somebody on a non-FreeBSD
>> platform happens to choose to use Vixie, then they would presumably
>> have the same problem, so a compile-time switch, whose default is
>> hardcoded based on the target platform, would not work very well.
>> The default will be wrong for some users, and users can later choose
>> to switch between different cron implementations.
> 
> I'm using Debian unstable, and I'm using Vixie cron.  I believe that's
> the default implementation.  However, I could also well use cronie,
> since that's available in Debian as well.  So, yeah, I think this is a
> thing to consider.
> 
>> Configuration knob can be used as a workaround, but in this case, I
>> am not sure if it is worth doing.  What's the downside of securely
>> opening a temporary file and write whatever we are currently piping
>> to a spawned "crontab" command and then giving the path to that
>> temporary file to the "crontab" command?  Wouldn't that give us the
>> maximal portability without that much code, no?
> 
> I think we should try to provide an option which works across at least
> the versions on a particular OS.  The temporary file seems like a nice,
> portable option, so I think we should just do that unless there's some
> practical objection.
> 
> If Derrick doesn't get to it this next week, I can send a patch.

I agree that the tempfile approach makes the most sense in terms of
what we can do within the Git codebase.

I won't be able to get to this change this week, so I'd be happy to
review one of yours, brian. Be careful to test manually when making
this change, because our tests don't actually interact with the system's
crontab and instead verify the interaction using replacement commands.

Thanks,
-Stolee
