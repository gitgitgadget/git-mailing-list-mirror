Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D03720960
	for <e@80x24.org>; Thu, 13 Apr 2017 21:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbdDMVfu (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 17:35:50 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35464 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbdDMVft (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 17:35:49 -0400
Received: by mail-pf0-f182.google.com with SMTP id i5so33690857pfc.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L0Mgp43tqsb+ORq8y9ejknqEmvbl5SlzmaDnTswMJWI=;
        b=i0Onh0dCNqriqF9Ccz8UgEbJMXJ6CeD+8xHIxkRAvmZiN6ttQc20/Jc/VkeEO9yOi4
         DgnT+9409QRInBHv/k2OKAqPvQuKpBJ99+gVBAhhJgve2+q4B0rUHNlGTSjOE6Vp2Ew2
         tcVC339OkmfIZSKUzhLiV+JY97EgH6UGg92NGXxtTVWXZhnUtXiHW+szP1IqqqsiK1No
         EyhACiUGBKZWAOeUNIK+Skglkf8PVtNAvH46CHDOEC0B1bmGEf8lZ5tGKv/5/MryJMFx
         QtW6aVFm8imBZYnW6AMf+puAyu7dgaxDIOjhO7FrqdOAdW7affeX6FZtsOPyD32T5/0V
         IbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L0Mgp43tqsb+ORq8y9ejknqEmvbl5SlzmaDnTswMJWI=;
        b=bUUX0mYexzqHN91p2GhjC4sdiLoZvjh9AvLq/WXSr2BCGddfZWgWtFcSblREDiwzRq
         IL0XMajJbt4rmsq0jF8KXAa8YINQt8thv+Vf8RLKrJQenXvx66oxVnH9wakv3G+TA95E
         /H20Qw408Lm1LAZCeZDGoTo8LK8iWLWIIO0hY7+Z/7VrY5qnNp/Y5tftvtPnr4IkGFt6
         1u3voAiMO13hq9UhYnA4MapV2BrbKoK/nRhtp+z3dlauASOSQZIZdLG40LCEZ5/7faal
         rZrS+ZHAHnHrsZd1vcabo9aZ091yhlPGyxgmAjGAdvdDtLnrvK7L7WfMBvGdDK+C0Y3l
         cOpQ==
X-Gm-Message-State: AN3rC/49eBF0PpOYSzD43ryDYAa/rBYSwo/tDHohOefB9xD7C1+VwUEc
        oRzNYsllX/y1DCZS
X-Received: by 10.84.222.139 with SMTP id x11mr5524984pls.112.1492119348239;
        Thu, 13 Apr 2017 14:35:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id m69sm44192385pfc.33.2017.04.13.14.35.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 14:35:47 -0700 (PDT)
Date:   Thu, 13 Apr 2017 14:35:46 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/6] t5550: use write_script to generate post-update
 hook
Message-ID: <20170413213546.GA115420@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413183252.4713-2-bmwill@google.com>
 <20170413204358.GA10084@aiede.mtv.corp.google.com>
 <20170413205947.GA32659@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413205947.GA32659@starla>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Eric Wong wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Brandon Williams wrote:
> > > The post-update hooks created in t5550-http-fetch-dumb.sh is missing the
> > > "!#/bin/sh" line which can cause issues with portability.  Instead
> > > create the hook using the 'write_script' function which includes the
> > > proper "#!" line.
> 
> > This would allow later patches to regress a previously supported
> > behavior.
> > 
> > I agree that it's silly to test that behavior as a side-effect of this
> > unrelated test, but I don't think we want to lose the test coverage.
> 
> I was about to write something similar about this regression.
> The new execve-using code should handle ENOEXEC as execvpe does
> and probably a new test for it needs to be written.

Would it be enough to upon seeing a failed exec call and ENOEXEC to
retry a single time, invoking the shell to attempt to interpret the
command?

-- 
Brandon Williams
