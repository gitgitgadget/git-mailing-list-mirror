Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194F01F404
	for <e@80x24.org>; Sat,  1 Sep 2018 22:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeIBDAM (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 23:00:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40723 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeIBDAM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 23:00:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so3645215qkd.7
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EVcqjzTu4cs9n8sZfMjX8GQlGOR/sTiITlEFWSWWWvo=;
        b=o5jmlZKc7+EoRdp95JvQ8etY0gKlp7emT+1DdgVnc8x/B4MQNMuOvJMV3boUGl5fjS
         BwJyic+h3Q3Aw5luu8ONKWCp/kX8rFGgKjqV6v4AVRTL7tKGx/hOs0xRoZh+Sm/xgnf0
         LdKKLcQeOnIZ3qIhiwRVVRfSrpSWs4oVovi+P+gUMGcvPrALpDhDFRAGNY+1MoTnJy2l
         57huxuQJFWagRrmnxjHwrWnP3pigMmXHR2zukg+rkPS3xrIr3r6twMEfQF4zFSCMJgzX
         WD3d1RGwR/3WZ74+tB8oR+tsODutjB4cglTlyvZdcJnEbMTLxMXs1Mvq/jlXJia726Yd
         1R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EVcqjzTu4cs9n8sZfMjX8GQlGOR/sTiITlEFWSWWWvo=;
        b=DKikJIaBpG9XjNC7GMxPOf9UqhsDXItfx+PfWJg4D0vipfyCW5i5HV8Xg3E7yifEuB
         MXsedjZGQNTVVKXU05us1MZyzfTmWwCcN2fS5MKFGNcg78wlu1U9/EaU4qjJOF2x3xmQ
         EiVxUBOG1M2P4WT7lAwZvJILLiwBsNAgRBM+F+wLAY7zAfKJGQFel7JtcYM/AnZPHyrK
         Xkyta6jZLMG8csjNh6P2rgoRfF/4viN1Jj9GdbAbTJ3J0plnowVOu+PG2gn43zvUnvJ4
         oXTaJXWOjL1e20o/L83aqjh7e5KaCjg2234qxgfhxlM37+3OJvxzxgKPezcXpuFV7yIg
         sWfA==
X-Gm-Message-State: APzg51BADXFJ323aeHAGtwSS7fi5wwgDez8d+3MGEejiXiM/IiBfQ/74
        m6xcyczXh0z65EgTmiox4Qs=
X-Google-Smtp-Source: ANB0VdZ8+Klk1l0Fl7r6ZoqGiiJ0CBDHl+ci6HKkLbFEl1FnuNUXNPnNijTLWHz0pQ3EJ5kgNvCbjw==
X-Received: by 2002:ae9:e105:: with SMTP id g5-v6mr2521970qkm.264.1535842002372;
        Sat, 01 Sep 2018 15:46:42 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f23-v6sm9159245qtc.65.2018.09.01.15.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 15:46:41 -0700 (PDT)
Subject: Re: [PATCH 2/4] t5310: test delta reuse with bitmaps
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180901074145.GA24023@sigill.intra.peff.net>
 <20180901074813.GB25461@sigill.intra.peff.net>
 <20180901080316.GA25852@sigill.intra.peff.net>
 <87va7parmi.fsf@evledraar.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ececf0e9-f569-dd07-9ab1-dc65ebb0a814@gmail.com>
Date:   Sat, 1 Sep 2018 18:46:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va7parmi.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/1/2018 4:29 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> B.t.w. for Ben or anyone else who knows about the fsmonitor part of
> this: I've long been running the whole test suite with
> `GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all prove ...` (also along with
> GIT_TEST_SPLIT_INDEX=) after all the main tests pass as additional
> stress testing.
> 
> It's not documented under the "special setups" section. So I was going
> to add it, but I see that in 5c8cdcfd80 ("fsmonitor: add test cases for
> fsmonitor extension", 2017-09-22) it's documented that you should also
> set GIT_FORCE_PRELOAD_TEST=true, is that needed for GIT_FSMONITOR_TEST?
> Or is it yet another mode, and if so to be combined with fsmonitor in
> particular, or stand-alone?
> 

I was unaware of the "special setups" section until recently so if you 
would add the fsmonitor information that would be great.

I added the GIT_FORCE_PRELOAD_TEST as when I went to test fsmonitor I 
realized there was no way to manually override the default behavior and 
force preload to happen. I added tests into t7519-status-fsmonitor.sh 
that use this capability to test fsmonitor with and without preload to 
ensure they play nice together as I had to add logic into the preload 
code to mark cache entries as clean for fsmonitor.

GIT_FORCE_PRELOAD_TEST should probably be added to the "special setups" 
as well so that the entire test suite can be used to exercise that code 
path.

Ultimately, GIT_FSMONITOR_TEST and GIT_FORCE_PRELOAD_TEST can be used to 
test their respective code paths using the test suite.  The challenge is 
that the number of potential combinations (including split index, 
uncommon pack modes, etc) gets large pretty quickly.

>> There may be a larger lesson about tracking code coverage, but I don't
>> know that most general code coverage tools would have helped (any
>> overall percentage number would be too large to move). A tool that
>> looked at the diff and said "of the N lines you added/touched, this
>> percent is exercised in the test suite" might have been useful.
> 
> This would be very useful.
> 
