Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CAA01F461
	for <e@80x24.org>; Sat, 24 Aug 2019 17:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfHXRt5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 13:49:57 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37462 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfHXRt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 13:49:57 -0400
Received: by mail-ed1-f54.google.com with SMTP id f22so19152880edt.4
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CGoFtMTKjRlc9VQv14CuqiOrUXTmFeyWOJyZxlsfE3U=;
        b=ncEErdWDukv+SuEeCHqp/rqek3qGFCqaW4iFWp+auxkUZUCShowxtduR339ZXnmR3x
         7lOsx09R+UXW3xWAHestNM2K8g/sVcshdRnO2zHcvcuIDMnKt1QuGW4b9dU/916vJYtc
         5QfSSKcG35VLnPjhRhZ5T+FrhXQCmUWL643xMBA/d86N9BnVIt/07VuDJ3LLVMSJgYMs
         9+rplo4N7+Nxt/D7/09QLineiTp6p8bvWXojfKcXffBH9Dx6OEXgfOjHVAwwiG9FOKAV
         OXxGkhtJwYOOXSUv1RBflSfoO+y+n8vsGvNHCv8klaAzStXrx+JmMK1Vr00ahaEDjm8m
         HwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CGoFtMTKjRlc9VQv14CuqiOrUXTmFeyWOJyZxlsfE3U=;
        b=M6NgpGgPys0dYjgb5Exzju6cmzMnegIKrb9DiLCk6qD4fkG0dhLGMgvhwmlhhIhF7B
         tWXA6p8B7oMMb1ZM1xmWx12WrDCD5yHujLwe5XE4wkL7fiDLGH8SQB1B8OxNE5MbHrFA
         xMn5hcTOio/TlnHPyiIMeBVaP/Sxn3UEUJQWvaLze5Nsn3gjRu10c8U9hTbmbvO3viaw
         bDeAJyL+MXfNlxaL7eoy3LSNq5f+8WirRx3OK2jDkzZ2Mu5fcgHqnf+CxYAewIQTsEeH
         uExnxe/pES2f/cShXgGn0aSs5Y0PhlVNkYLz5TPl46yxW75CA32deVxCIgsXuk7P5Qnc
         62xA==
X-Gm-Message-State: APjAAAVFkPD8wyVLejcYGKKP8doCo/wssD/+tGwRWFBfzSOtbk4E6zxa
        Dh/7sLlLQpiiqUxH6tP7KLw=
X-Google-Smtp-Source: APXvYqxII1/lsy75f63mN/GgRnenv037EMlHtEz21zAdKxX8CK6E9xAzkpyEfTmIIz/jflF6mxzriQ==
X-Received: by 2002:a50:ccd4:: with SMTP id b20mr10783542edj.241.1566668995393;
        Sat, 24 Aug 2019 10:49:55 -0700 (PDT)
Received: from instance-template-1.europe-west6-a.c.vaulted-journal-250706.internal (169.120.65.34.bc.googleusercontent.com. [34.65.120.169])
        by smtp.gmail.com with ESMTPSA id a16sm1371856ejr.10.2019.08.24.10.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Aug 2019 10:49:54 -0700 (PDT)
Date:   Sat, 24 Aug 2019 17:49:52 +0000
From:   Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190824174952.GA688@instance-template-1.europe-west6-a.c.vaulted-journal-250706.internal>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
 <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
 <20190823082900.GG20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823082900.GG20404@szeder.dev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 10:29:00AM +0200, SZEDER Gábor wrote:
> What I wonder is whether we really have to remove crud from the user
> name if it comes from the configuration.

Yes. If the primary use of removing crud is to remove quotes from a
quoted name (as in `From: 'Foo baz Bar'`) why not directly removing
pairs of quotes around the name and leave crud _inside_ the name?
