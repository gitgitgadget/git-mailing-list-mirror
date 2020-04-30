Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7204FC83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A602076D
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 14:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7MmcYJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgD3O0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgD3O0s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 10:26:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA81C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 07:26:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so2810414pgl.9
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EkQmkodmXqHPp+yfD5YvXC2GuWAC8ZjStq2nTAPT7/s=;
        b=R7MmcYJo4xXhDyD9OylFEYHgfJnFURrFm8vwj4DaQqGVEIQSqWNQk0ph/+RvO69V95
         aNsMBkZF1VWCDnvklPtCvpxKFej5eYnHcpQr4/bITW3nwze7vv6PfXEBu/Ph6EcVyWm6
         3KwZK+jRvSmOSCtAX9yF1QKvgzrfWhaozoBv7ElfjTMfSQxxMFJjDmLSc6cFy/LzCsnu
         F5LqDM271cgsJRLYY8Af61DNIS1zA4Di16XkxIflpa/Aj73/Sw+IT21JJqU5x8DLd/el
         5Orrxzqgj4WbXfQ3l7SA7XPPw/izGiqOiPLMCVzDYJEFybX3Dqw6zPwVV/HlNh2xWf9g
         T6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EkQmkodmXqHPp+yfD5YvXC2GuWAC8ZjStq2nTAPT7/s=;
        b=HFl0oYigglEyeDNMkdYsbTESeJ43uEVhVE7xNfqSOgkYS5U67ABTBtpqKKg6V7Gk13
         6FrUpxNhbiE3u7W4at1YpaqRn1p/dKsteEO2QWL92qROloX+ohiSu79gPSYoFwNTYmEZ
         e0452kRrP32jqt/23HeHDPpo7mz8PXF4qUILxYKNzpFVeTMBRiLBCiXuZwPzlh9GfJdI
         rM5JErcHo45jeb0Ss3LWJJ4+Yk3UZVJ6o3Re2FiiQ0WOXFchDOn7Ck0TwEPv5lCyTFSU
         av8pAtgNXvrMk57sRRXjb4gE6lvNMUyqmxmuH0pMrxtbBNvowDIRYliM5aCwiBpYBSFb
         YZZQ==
X-Gm-Message-State: AGi0Puap/zFP9GkB5Onu9+mq3o26+bGNdIW8CT5dnDHywGEC2H3NmfVm
        hh6wqPMnj6Us6WCVu5B/WlFi7v673ZFefQbp7hzB2zwS
X-Google-Smtp-Source: APiQypJhUvbgBEELX1Zb4QjVl6ZCy/cEqSAyvHhcHwdp/84RgeQYEVc/Dz7UCylCkkzKn4YcNNE0PLMZGDupQMhQw0o=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr3379628pgb.74.1588256808242;
 Thu, 30 Apr 2020 07:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200407184823.GA3932679@smile.fi.intel.com> <20200408011830.GA6549@camp.crustytoothpaste.net>
 <CAHp75Vfuuth05wn-0x_AZa_LFSmQMHB6LGM5b4KNMoaxce1S-g@mail.gmail.com>
In-Reply-To: <CAHp75Vfuuth05wn-0x_AZa_LFSmQMHB6LGM5b4KNMoaxce1S-g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Apr 2020 17:26:41 +0300
Message-ID: <CAHp75VceVXMsTRAd9iW8D6-uqVR1Z6A9Crgsvyv_-KaSx7JR9Q@mail.gmail.com>
Subject: Re: subtle bug in git-am
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        git@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 8, 2020 at 12:29 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Apr 8, 2020 at 4:19 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On 2020-04-07 at 18:48:23, Andy Shevchenko wrote:

> > > What I would like to do is to apply patch from one repository to another with
> > > same files but *different directory structure*.
> > >
> > > When I try to change directory in the target repo to the folder of files, I run
> > > git-am -p5 my_cool_patch.patch.
> > >
> > > Instead of the expected result (files and their contents is the same!) I got
> > > fileXXX is not in index.
> > >
> > > So, I think this is a bug, because -p<n> use in git-am makes little to no sense
> > > without above feature.
> >
> > So if I understand correctly, you're expecting git am to apply relative
> > to the current directory in the repository.  I have also expected that
> > behavior in the past, and found it surprising when it did not.
> >
> > What git am does is apply relative to the root of the repository.  If
> > you'd instead like to apply to a specific subdirectory of the
> > repository, you can use the --directory option to specify to which
> > directory your patch should apply.
> >
> > This is the behavior of git apply, which underpins git am.  However,
> > outside of a repository, it _does_ apply relative to the current
> > directory, since there's no repository root to consider.  I, at least,
> > found this confusing, but that's how it works.
>
> Thank you for the prompt reply with useful information. I will try it
> whenever I will need similar flow again.

Today I have needed something similar and I checked proposed w/a and it works!
Thanks!

-- 
With Best Regards,
Andy Shevchenko
