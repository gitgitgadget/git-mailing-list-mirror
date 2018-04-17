Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900B71F42D
	for <e@80x24.org>; Tue, 17 Apr 2018 18:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDQSdj (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:33:39 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:44298 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeDQSdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:33:38 -0400
Received: by mail-pl0-f52.google.com with SMTP id s13-v6so5219147plq.11
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jkObz/0WMXA4QrbtptOFAjQiiGtnhcLFTwkcdjs04BU=;
        b=QvNtqAbhAlCQm5SvhWM1vjtqOxMWlS/ItYJsbnHy9zM4IsaLyH1Ny7nAt9TgTaZowy
         LdzY4E8qxhA6LovupdNskwhvAclEeTSusyCRJbd4rfltraw08R+PA6hbd53OwKdeP4zA
         SXmouHLv67LJctKsyAd4FKAFdXVxfPGl0C5K7zmyE/QZ1FT0mEA509LU3Ba3qjWJl1fL
         zUQzGyOUzcy2o9IpDiNzeIBj8G1R8hN5SwLIhT5ECdL4GJT5tBu91E7IKjA/8cO7W8Be
         s21/3TrJsBeBmJjkmrYvDp2coT/goCTJHBRBihEkAOh0Ljg0kXGLY3W/Vo3MbNSn9zt7
         QkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jkObz/0WMXA4QrbtptOFAjQiiGtnhcLFTwkcdjs04BU=;
        b=chVrcugsSMvwX3CzGRBKZcHDahl9BBwLh+DHkUR3byvw2N0JbbooVZogrBNP7y/7F6
         EACThbPDSVPONc0r+2XtngKKMNU81ibxZTpvfeKS1GnLZKIHdJ7s5oyj2G/tu9gKMn8P
         sqwyunJhFLWEabEx/fEXjw0CHlz2ubxb0DHyqTil7w+d+qTC8lieyetGZ1WgQ3HJs2oR
         VI9riNcldJa6eohC7xB8rUbwhyRAoOoD9IKUbPpagWYRkNDrcje1BrLopLYFdD9nwZme
         ztQmv4i5i5gg7Tg0bwdwmRqmCl3HEnf3LAl1Ouu7ivadXnfUB6ubci0lNuQ7XjRyNTbe
         TujA==
X-Gm-Message-State: ALQs6tA0mUs0cUTSlb/udOUg7XUFCrFqG+5UWnC98wzRL4Fmqcwf8B+9
        yxM8NGR5RBlkndDXLb8Mwj1lLwVk2u+CMg==
X-Google-Smtp-Source: AIpwx49mKzOCw3CdDWDm4ghrf8jHM7h2FsOaQypJ6ESaGS+ogAHpzvHKDOjGjMgjEsXoiNl4PuyJdg==
X-Received: by 2002:a17:902:6045:: with SMTP id a5-v6mr3025206plt.138.1523990017619;
        Tue, 17 Apr 2018 11:33:37 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:bded:dd28:4ed6:df43])
        by smtp.gmail.com with ESMTPSA id s7sm22894389pgq.48.2018.04.17.11.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 11:33:36 -0700 (PDT)
Date:   Tue, 17 Apr 2018 11:33:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Message-ID: <20180417183334.GA9802@syl.local>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net>
 <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
 <20180417001212.GC14631@genre.crustytoothpaste.net>
 <xmqq604qwqbj.fsf@gitster-ct.c.googlers.com>
 <CAE=pOyE5oqtPZLQ7d9EHU3uPC2eG+2_6APFirRvHqywE=4dGpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=pOyE5oqtPZLQ7d9EHU3uPC2eG+2_6APFirRvHqywE=4dGpg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 12:08:20PM -0600, Ben Toews wrote:
> On Mon, Apr 16, 2018 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> If we just want to add gpgsm support, that's fine, but we should be
> >> transparent about that fact and try to avoid making an interface which
> >> is at once too generic and not generic enough.
>
> [...]
>
> My motivation with this series is not just to "add gpgsm support"
> though. I've been working on some other CMS tooling that will be open
> source eventually. My goal was to distribute this tool with a wrapper
> that emulates the GnuPG interface.
>
> To me, this series feels like a good stepping stone towards more
> generalized support for other tooling.

I agree with Ben's assessment. A stand-in tool for gpgsm support will
not be useful without a way to configure it with Git. I think that
treating this series as ``add support for _gpgsm-like tools_'' is
sensible, and a reasonable compromise between:

  - More generalized support.
  - No support at all.

Thanks,
Taylor
