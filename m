Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537A220281
	for <e@80x24.org>; Mon,  2 Oct 2017 18:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdJBSx0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 14:53:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51005 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdJBSxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 14:53:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id u138so12328376wmu.5
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0rBCG5ODCGkDyXIcyie9QWO3q77swEzqfwkBlKsw1UQ=;
        b=kF3cjddgWC6WkgA2ymmTD7kJL5ypUIKir+K/EbFJcYqIQOY87+hQMXsRnYoTnC3/OG
         L4dG4KXaQYeCGP7KFimZsrf1n8qp8hd1gcnvOZ4RD0mXVJBb0P5vlogiYUbJhDWSMq1T
         zBXw4aClE5G4C8OkW79cFqfElk+ycBOZUqIODj8pDmbE4FQJLG9eDriZufiz+r77ZP3x
         pqlsx2ewptKRTv4lXJ+NihtY3ry39Gq5pOaFHW+3YRmRSxIT7N6i0QMw5X1XTwMTk9km
         5E9DRaZ7wCKMXx4gTf2uW7z6ykLm9ddAVeQRuQTMMRLHfcpdnkEp7Tk7Udthkza8xEQd
         d6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rBCG5ODCGkDyXIcyie9QWO3q77swEzqfwkBlKsw1UQ=;
        b=O2ATnrJG0KNa1OtYVvwIuD7HomM5LF7ycob4nyoS87bv8SChoHVdgahBlWQVU5RwFL
         GfGnTe0fki28Cqv9NRIbjNnVC9iDFUOZUxZ+A7ThiYZzCd+Zhy3S7H2QGKXNKLfWZfYM
         0m2EGjf3OExurT2F7TACD1NSMEAkBtNXtHDoP+u58vJyRC/WgqaYfRcYXF2ISW5NuCnr
         mvHhcU9185KODQ0tTQ4VcGBSTZfe9bvQLCAUaHlXdUIK/RHxI/VqHQ5X0DjijnFBiKmG
         PtM7H4WHMJttMvAwaVcWKFvpxPqNpXWAm/ac4xVlIN3jY45g30low+gaaKuZ2EVKpYSS
         NnYA==
X-Gm-Message-State: AMCzsaVPa6Gv0VvO3qc5Q7AHMkMNIAfz9MIvkGyuBL5oOURj8RCvHMAD
        AWDQOK6Eg5YYC4Kp9L2jmgw=
X-Google-Smtp-Source: AOwi7QBf1d1s3+Fg6fHpyEEK6Lc6KCG9GeAGnswwLowSl8js4C/zTl6fE8UrkLDEBDOBT9zkO506+w==
X-Received: by 10.28.86.67 with SMTP id k64mr12133055wmb.143.1506970403995;
        Mon, 02 Oct 2017 11:53:23 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 69sm13824590wmp.11.2017.10.02.11.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Oct 2017 11:53:23 -0700 (PDT)
Date:   Mon, 2 Oct 2017 19:54:15 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Tsvi Mostovicz <ttmost@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git add -p stops working when setting color.ui = always
Message-ID: <20171002185415.GB30301@hank>
References: <CAB2yay8LLeNbqR4kkTwF1U+oarVDRxgkV4uGXuYcO8mAQmhWQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB2yay8LLeNbqR4kkTwF1U+oarVDRxgkV4uGXuYcO8mAQmhWQQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/02, Tsvi Mostovicz wrote:
> Hi,
> 
> When setting "color.ui = always" in the last few versions (not sure
> exactly when this started, but definitely exists in 2.14.1 and
> 2.14.2), git add -p stops working as expected. Instead of prompting
> the user, it skips through the prompts and doesn't allow selecting a
> hunk.

This is a known change in behaviour (for more information see the
thread at
https://public-inbox.org/git/86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com/).

> 
> Don't know why I had color.ui = always set in my .gitconfig.

Can you set color.ui = auto instead?  That should give you colored
output on the terminal, while not breaking git add -p.

> git version 2.14.2.666.gea220ee40
> 
> Thanks,
> 
> 
> Tsvi Mostovicz
> ttmost@gmail.com
> www.linkedin.com/in/tsvim
