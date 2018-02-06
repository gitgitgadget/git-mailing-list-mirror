Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396081F404
	for <e@80x24.org>; Tue,  6 Feb 2018 17:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeBFRww (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 12:52:52 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:44368 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeBFRwv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 12:52:51 -0500
Received: by mail-yw0-f177.google.com with SMTP id x62so1927612ywg.11
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 09:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6M2c0oS3eXRH0L1zLT0DQxMa8YY3oiMDcAtbF4H0o7g=;
        b=H0iL436KmJV+PTgHD8AfDDsOnvLaeuipHDbydMC13aXjeVy6MHQ84rsmS7yIKi/VGl
         zFfuHSOd1mAM8IbC+LAFgqAYqlhkBm0qeGwFRV3qXdpa7dhvpPxmpYRKyJKEkmQlRs4v
         AdXeHHAmRqWMiCw9afZdhUriKYj+O05lNXnAfZu2F20KjF4P04KPgKY3iIT+ixdk81On
         8Ce4iT8rvCDcDjxmoT49sMMBkoruHIf0PtDC2GmxcGSW/sDYwwM9c7Yiilxwzo0tOOFZ
         RzWPOAi8aGs1dSyrDF3o128I91Z8IKakxvm8kYdRGq5YUNMfjiLXksjKZyEMAOaFKZ1j
         wPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6M2c0oS3eXRH0L1zLT0DQxMa8YY3oiMDcAtbF4H0o7g=;
        b=m1gE77kL0IsJUNbjiiyOqfpecpIt4QN0HvE8/nfEyYPri/qBqP/BcQ6FnTIIHnP2gR
         59cLVVNmAaeuIX5tkyngfvDwAHv6bXXuucEGlnA03HQqEFby8a6ivY2GQyisdivFSdRL
         /OrtF1ZiEpD+Ol4ovwydccwLC+1j1nU9UPMG9qOfQ0z/338dCXRmlAkOZhQ5Lq44wspZ
         ZGpb7z8bnsSWmJF8iLric0se1ulnIxn7qb6bpO+ePuw11vFQpgrQKjWqWxJUqIDWmkYw
         kEONB9Q4ban2GW0DEntlSZX0cq18nwKbwme3LLbaFA6t21c0Wm2pest97Szi3XqWU7E8
         Kglg==
X-Gm-Message-State: APf1xPAURXPY2IdgA95fdQWM7sooQ9mMxF4F116DZZ1A1TcbbSyDtTc4
        aNU+RsC1SB2rfY+s1TN6cvHXk8tfs1M/RqKB+AaVyx0P
X-Google-Smtp-Source: AH8x2244uPcrdvo2RhT1r9zLD+Enxdw5/80e3qqHp3e5JYuKm00c9reZrtaLpWNSVa0WnmXkeaq9M9VFNvwiX6zu1ec=
X-Received: by 10.129.11.8 with SMTP id 8mr1978631ywl.156.1517939570392; Tue,
 06 Feb 2018 09:52:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 09:52:49 -0800 (PST)
In-Reply-To: <CAPig+cT6EmN=PFP9MUQG_J2QFoj8EH3TuXN8w64dYUKYiypX+A@mail.gmail.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-22-sbeller@google.com> <CAPig+cT6EmN=PFP9MUQG_J2QFoj8EH3TuXN8w64dYUKYiypX+A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 09:52:49 -0800
Message-ID: <CAGZ79kZ8GxrLRWV9HaXkC8fGG+ZFzLwy2gJGjw1t1MdTP=39DQ@mail.gmail.com>
Subject: Re: [PATCH 042/194] object-store: move alternates API to new alternates.h
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 8:52 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 5, 2018 at 6:55 PM, Stefan Beller <sbeller@google.com> wrote:
>> This should make these functions easier to find and object-store.h
>> less overwhelming to read.
>
> I think you mean: s/object-store.h/cache.h/

Probably both.

At the end of the series the object-store.h has grown a bit, such that
we'd want to have specific things outside of it. Alternates are a good choice
as they are coherent on their own.

I have given up on cache.h and its readability, but moving things out of there
helps of course. And that is what the patch does.
So I'll change that.

Thanks,
Stefan
