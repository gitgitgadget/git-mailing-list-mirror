Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1001F453
	for <e@80x24.org>; Sat, 29 Sep 2018 11:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeI2RrJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 13:47:09 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35074 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeI2RrI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 13:47:08 -0400
Received: by mail-wm1-f41.google.com with SMTP id o18-v6so4472544wmc.0
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VbI/g3T/wzKMn7J4QWQIhCngc3eeUKlusCJiII7pqXY=;
        b=fgTVAUnoPNrZ+sTla5J3uny95CIZODMMU8CNCcVO6v826lhDoztZbSkPtlGjlWOVkl
         GikDSIpxxYBOdTqucynfXLVfx0ywWP++NYVabS49GkN/wjozFPj2aP4zilktz2n0B9OG
         LOvrA9MFyeyyWvRoJHr6ANPnWfvdT0/gmVAXhMGxZvTWw1yukb1b2YbpScoiS43CJec0
         sTNinM+fzD7InXy7H4Zct/poj9W++Behr3N9DO1SaV09b9a++RrCCvcQ8Zc9LhkCsIPw
         PG9WCBabYAyfjHlrdt6coHZR1TsjT2XIIAO+7qAzMja0HG4MpvxxZ4xMIGfadnENdDze
         +Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VbI/g3T/wzKMn7J4QWQIhCngc3eeUKlusCJiII7pqXY=;
        b=OHZRFNOos6bg+fGHjc6hll5iqrWpzobqf+LQbo2FFpu6wyxUJsk9CCmcL+HYr91s4I
         hYvZ2YIFcnHarMxEu6FrAfV/qNRQ0rZuEF+863eTC1x8DBcp5qyfyBpnyMyTAw2cLAIW
         kQF+MdGTw263zUtqGamjfAG0laZcOb3nf3NemRWMJDTRQyuKBem7GOO3G+TII9n7g4Kf
         agLjMm3551mTI8SJsY966kErHH60EoMGgDo3aAI9VjcAamjNksJQsaAFUqCVcVI700Sn
         02jNlERpEZOtZdTJkFBVf8+x3cl8E6MdDg2nCvwnxf9JiEyYsYXSDO0m3GlClzRwOF8Y
         IcVQ==
X-Gm-Message-State: ABuFfogI6HhbB24WY47xHxir4GXDyHBVHl2/dit3Gi1yahhewLOK80Pe
        W07/SJGQi4B70kQQb2iyql4=
X-Google-Smtp-Source: ACcGV631KYkN8opOHzPqFTRgs9uhhqo8gedlFtpfdGw8NUWc7lk4VRxigvqM6oVQ7lnNZ9zNRuESMg==
X-Received: by 2002:a1c:f210:: with SMTP id s16-v6mr4459451wmc.36.1538219943030;
        Sat, 29 Sep 2018 04:19:03 -0700 (PDT)
Received: from localhost (x4db14438.dyn.telefonica.de. [77.177.68.56])
        by smtp.gmail.com with ESMTPSA id 204-v6sm6006795wmh.25.2018.09.29.04.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 04:19:02 -0700 (PDT)
Date:   Sat, 29 Sep 2018 13:19:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Git for Windows for Unix?
Message-ID: <20180929111900.GH23446@localhost>
References: <87va6rhqup.fsf@evledraar.gmail.com>
 <20180927160523.GA112066@aiede.svl.corp.google.com>
 <87tvmaj4fq.fsf@evledraar.gmail.com>
 <20180927162623.GB112066@aiede.svl.corp.google.com>
 <87ftxtieeg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftxtieeg.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 09:57:11PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Another way to look at it, which is closer to what I was thinking about,
> is to just view GFW as some alternate universe "next" branch (which by
> my count is ~2-3k commits ahead of master[1]).

> 1. $ git log --max-parents=1 --pretty=format:%s v2.19.0...v2.19.0.windows.1|sort|uniq|wc -l
>    2346

This command is missing a

  grep -v -i -E '(^fixup!|^squash!|mingw|vcxproj|msvc|win32|vs2015|windows)'

from the middle of the pipe, then it's "only" ~1500.

