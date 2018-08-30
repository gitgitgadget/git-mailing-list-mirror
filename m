Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4C41F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeH3XdZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:33:25 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:41977 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3XdY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:33:24 -0400
Received: by mail-lf1-f44.google.com with SMTP id l26-v6so8110273lfc.8
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dTKRZsxgGjtg00ZUFGUhQrM3U0SFutpxQoWkjZLQ23E=;
        b=R9sfDKp1hanFAjICiZhh+77a72lmzkVMpH2+kOCXjpScyjP7mf8rMhv4eyeuZx5i9k
         LbKrR+5dyE7y6foJfuaBgIb4Q7EFxmCnh/k6rmZDKtRQSSu5B6eS6xI6zSXMAo5whp70
         geQezbYhoyrYCi5tgS7W1sXP8wIMXBxNuCBCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dTKRZsxgGjtg00ZUFGUhQrM3U0SFutpxQoWkjZLQ23E=;
        b=MnUXKCYQf9DSvJ4X5dD/1IBchDNCUGRrOpfrDXYWtHFw/Jir7VrjmmcFWLLdzVMBEa
         kiiuJ6VujDNeZtRn1INE+vtMWQm9jGjaax3aZ95NP49KxlHhUd/QzFM/tpJxsjky0cJI
         rGTq56EcMFjUAMpMICjHeZrjcCtjdkhbHgopvY9yFa6rwcF6V9e9qKXzzGJy/vA7c1zj
         x3f+xARP32fgeRSbuyd+mLgge/ZBzG1zeLE9/MTdkz90gUYhJP5jTvgPvD0vbMrfcK4X
         Nd7840+n9h5qFHu9c3fnBrRdkO1QB5HUNN96FfelPGs2td7WG4STKW5U8L03tW/uzLfC
         Pumg==
X-Gm-Message-State: APzg51BnFvEy5AQycjZR1dOEGCtS08cuEOtY0HTi/sORcDZp/M12rmJ2
        Kwkq43bJzHQkWFs9RG1/83LJOfB6qAv42O68
X-Google-Smtp-Source: ANB0VdaxZTyg9wImt42HPmKDrmdy4XlpWAd0tzFVXc/NwK+O8KYruxJBqBg5r47OzabXUEI4P2pQ3A==
X-Received: by 2002:a19:d98f:: with SMTP id s15-v6mr8776398lfi.103.1535657379968;
        Thu, 30 Aug 2018 12:29:39 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id t15-v6sm364270lft.41.2018.08.30.12.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:29:39 -0700 (PDT)
Subject: Re: feature request: allow commit.email config setting
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <0f66ad7a-2289-2cce-6533-a27e19945187@rasmusvillemoes.dk>
 <CAPig+cTnvDfYaDh7JSXXGGA=+DE4WAiuTZEKpxv67u1_OyT-qA@mail.gmail.com>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <cba5b445-2208-7a01-5ea6-7a3590cef50e@rasmusvillemoes.dk>
Date:   Thu, 30 Aug 2018 21:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cTnvDfYaDh7JSXXGGA=+DE4WAiuTZEKpxv67u1_OyT-qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-30 20:13, Eric Sunshine wrote:
> On Thu, Aug 30, 2018 at 7:26 AM Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
>> I can set GIT_COMMITTER_EMAIL in the environment, but that is
>> rather inconvenient, since that means I have to remember to do that in
>> the shell I'm using for that particular project, and I can't use that
>> shell for other projects. So it would be really nice if I could set
>> commit.email = $private-email in the local .git/config for that
>> particular project.
> 
> Aside from modifying Git itself to support such a use-case, another
> (perhaps more pragmatic) approach would be to use a tool, such as
> direnv[1], which automatically sets environment variables for you
> depending upon your current working directory, or just use some ad-hoc
> shell programming to achieve the same (for instance, [2]).

Thanks for the hint! I've actually had "git" as a function in my .bashrc
for a long time, for implementing a ~/.githistory to help remember the
sometimes rather complex git invocations, and keeping track of the
context ($cwd, current branch, etc.) they were used in. It should be
trivial to hook the environment settings based on $cwd into that. The
only problem is that that gives me much less incentive to work on
implementing the config support in git, but if I'm the only one with a
use case, that's probably just as well.

Rasmus

