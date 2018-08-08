Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632271F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeHHWMy (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 18:12:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36865 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbeHHWMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 18:12:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so3053820wrr.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gMFhhybj88YqSI/I/L/s+Y5D5bINgEC7lp7QYq+Yeoc=;
        b=a9efy4UmKELVhw98+PXunhP07+W8xvbKPN5kYQlMDplVbIfKAaqKwOM2sG8QcH+BA3
         bFADiv2Q9cjdEqrKCgeoKsmwBk6kdCuBVTtXKLvMK4uHqtbuz0QKSf05otTcPq2J313V
         1GkFm8PKj2guPO+QjowPeqhGFzgWmUv5kpJIQPBADHTTwvag+0mDRGAtYUxEef153Dtv
         KceUzVgzIEWq9TeBFktz4KCK6duiH/cS/xpicWbg7hSyxWgbaGRLtv1BADjobnePJvy7
         GAkkLEniOa8bNfVzpecgG5JXxZm3PIKtIP7LSFQmZUwgV/zmzFmEz+X1WbjcVuSPJkNT
         /AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gMFhhybj88YqSI/I/L/s+Y5D5bINgEC7lp7QYq+Yeoc=;
        b=JHO56WrFmu5Ta3WfVYFTBlQU0fsWdCoL3LTJauDhj/QvsA/s4jtFr34bX75wOGbTLQ
         jZ1GVqYSoZvXvaMMsZhGLcwPc9D2OiYMq4nskeJ36/eLAzlDxEEc6XeThx2IbVqZIRaZ
         OKddVllqksviKMf+ozyQn5NBSPI+lRfkjr2Eb8ejyXrVvq9jh3kldAQ150sUMndRMilx
         8RI8uYGGpUVdm15uTMU9dx5FUBWiQITUZkN1/2ycMwXaKu2efBApisHF7DjYdcJJVBPX
         gUJ9pmJnh2soOVzApGgrcI9n/mzyXBUN5wDSRW+unVKr36dEHmU2PC/DjgNcQxqOup8f
         T0Qw==
X-Gm-Message-State: AOUpUlFwNAxkXo19m7IIDv63xVCjefCTdIocx5jpD6tESVHFGnIBP2C7
        Y5trI5lKPIDAZj1V7zSkQTg=
X-Google-Smtp-Source: AA+uWPxembdQsmg0k8U0OJ8198MtFpUq7TY31BEoKJSrjKRB1R7YKT7a3onPo3fADaQXnATqcmzVUw==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr2875264wre.12.1533757900894;
        Wed, 08 Aug 2018 12:51:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 8-v6sm11160113wmw.34.2018.08.08.12.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 12:51:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] pull --rebase=<type>: allow single-letter abbreviations for the type
References: <pull.14.git.gitgitgadget@gmail.com>
        <d2ba1e6bef9d6d4eabc8eaa60435dcae1105fd07.1533410586.git.gitgitgadget@gmail.com>
        <87sh3qrn6d.fsf@evledraar.gmail.com>
Date:   Wed, 08 Aug 2018 12:51:39 -0700
In-Reply-To: <87sh3qrn6d.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 07 Aug 2018 21:28:42 +0200")
Message-ID: <xmqqmutwfxh0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> -	else if (!strcmp(value, "preserve"))
>> +	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
>>  		return REBASE_PRESERVE;
>> -	else if (!strcmp(value, "merges"))
>> +	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
>>  		return REBASE_MERGES;
>> -	else if (!strcmp(value, "interactive"))
>> +	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
>>  		return REBASE_INTERACTIVE;
>
> Here 3 special cases are added...
> ...
>> +test_expect_success 'pull --rebase=i' '
>> ...
>> +'
>> +
>>  test_expect_success 'pull.rebase=invalid fails' '
>>  	git reset --hard before-preserve-rebase &&
>>  	test_config pull.rebase invalid &&
>
> ...but this test is only for 1/3. I haven't run this, but it looks like
> the tests will still pass if we remove --rebase=p and --rebase=m.

Good eyes.  It's not like that parsing these three is implemented
with one thing; in other words, it is not hard to break one without
breaking the other two.




