Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C431F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeDFV5S (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:57:18 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41126 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeDFV5R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:57:17 -0400
Received: by mail-qt0-f169.google.com with SMTP id d3so2752131qth.8
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 14:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=m6/Zwj1WNSZ1iKPChNUDdy77Aidj4mykYbH9UpHqV1g=;
        b=CilMYP5ZfIvXY17/Uh6TErsqnQ14QsNR02o+X8yAE4PfwmQu8hDWNtOIXoOUOEwQqm
         FKvctlc8j+zCcECfRrbVUIh6FpXdffAtuJCQlrbLmgNfAszCPLauvkZ87e1GUyPY7tew
         FnuSD6HjisYKpgvC8MZutwaESoKWICIzKLuib379080gZTDTbAplka6ffLca/xeY/tjB
         MCTf8UHfyiYFhk0KpbUEgXgNbSlrHs4T1PRtvlkIsk8Ji1rKOh5DrMcUkz984+uuYY4P
         uH7tyekN0swPhLvYFMhF7k3OBXwjP/qVTDsb8DnjNmoJOxLrtw595MStWUo5xkKF6EGa
         +YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=m6/Zwj1WNSZ1iKPChNUDdy77Aidj4mykYbH9UpHqV1g=;
        b=PEZ8yGv+EdpW/MkcJ6SfAtW+fCUQtAmadCkoZqiFhccN/vO+os3FthTfzcoaF83DXw
         HImj8/57cvof5WXlzkUWtvckTf9ZVFqyrQLkbV0sUCV+k0KupNAiEjXBBgploysOtADt
         Gmr+jqDGsY/SNISuU/sRN7fjwnZqFAK3i1nEmf2TeN9BrMrB43DQUjPKW+FUhiqkdPx1
         9i0ozOdIetnxHM59VtE/84iJYFDMChCJlV9mfEa22LiRxCvZYKx2Bx0uOAGPejeskty8
         24MnwZPJl18WkJViQdLa0XpA8dbO/er4BmNKDfdt1x9T3tPpkdtNoo3Ff9Nzbb8D7Q3x
         VaNw==
X-Gm-Message-State: ALQs6tDu5Z+AywkApceZKobSqkXgbIe6ByC65MVBQcccSQNe/LvgK1Ob
        2ZK3p84QLP8RclE0pnNsaxZxBg==
X-Google-Smtp-Source: AIpwx4/FsbHxv7bopxz75mGQKZfb0dkHeOStK0ibL/pTTEskm8MjDW4LPSO3EOXByEckpztBy13G1w==
X-Received: by 10.200.54.179 with SMTP id a48mr39911087qtc.123.1523051836463;
        Fri, 06 Apr 2018 14:57:16 -0700 (PDT)
Received: from [192.168.0.101] (70.15.201.38.res-cmts.sm.ptd.net. [70.15.201.38])
        by smtp.gmail.com with ESMTPSA id f197sm7380754qka.80.2018.04.06.14.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 14:57:15 -0700 (PDT)
Subject: Re: FREAD_READS_DIRECTORIES test fails for the wrong reasons
To:     Jeff King <peff@peff.net>
References: <82c91eac-9dc4-834b-4648-3c4ba45af80d@gmail.com>
 <20180406193301.GA11450@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Jonathan Primrose <jprimros@gmail.com>
Message-ID: <8ed8491f-9410-c509-5ef7-77638aa74038@gmail.com>
Date:   Fri, 6 Apr 2018 17:57:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180406193301.GA11450@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/06/2018 03:33 PM, Jeff King wrote:
> On Fri, Apr 06, 2018 at 02:06:50PM -0400, Jonathan Primrose wrote:
>
>> A while ago, the configure test for FREAD_READS_DIRECTORIES was changed
>> to (attempt to) check for a NULL result from fopen. Unfortunately, the
>> test will always fail - because it won't compile. The code snippet in
>> configure.ac translates to:
>>
>> return f);
>>
>> Either there's an extra ) or a missing (. A cast to int wouldn't hurt
>> either.
>
> Oops. This is due to my 3adf9fdecf (configure.ac: loosen
> FREAD_READS_DIRECTORIES test program, 2017-06-14).
>
> Neither I nor the original tester noticed, because we're on Linux, which
> needs that set.

I'm also running Linux, but somehow I ended up needing to check
config.log and saw the error. I don't remember why I had to check.
(I've been fixing the problem locally for the last few releases,
figuring someone else would notice. I also remove the 'rm configure'
from the distclean target in Makefile, just in case I decide to
rebuild later.)
>
>> I'd supply a patch to fix this, but I'm not sure what the results of
>> suddenly fixing the test would be. It seems to work well on my
>> machine, but I don't stress git much here, and it's just one machine.
>
> I think it should be fixed (and agreed on the "int" thing; the return
> value should be "f != NULL" or similar).

Ironically, most of the time I check config.log is because of the
missing cast to int. A few years ago I set this machine up as a
tri-arch system (x86, x86_64, and x32). Because of subtle errors
that appear when converting between int and pointer on x32, I
tend to use -Werror=int-conversion on all my builds, and I wrap
configure in a script that (among other things) checks config.log
for that particular error. Even though x32 isn't as promising
anymore (thanks to a few projects rejecting support patches),
there are very few packages that still trigger the error.
>
> I don't know autoconf very well, but is there a way to invoke it that
> will let us know if a test-program fails to compile at all? Obviously
> for probing the system compler/includes, "does not compile" is an
> expected possible outcome. But for tests like this it's really a
> tristate: yes, no, or something went horribly wrong.

I don't know if that's supported. From what I've seen in the docs I've
found online, it looks like the closest is a case for "I couldn't run
the program because I'm cross-compiling." You might be able to
determine that the compile and/or link failed by looking at some of
autoconf's internal variables, but it would be fragile.
>
> -Peff
>

Jonathan
