Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EECE20248
	for <e@80x24.org>; Thu, 11 Apr 2019 21:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDKV2e (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 17:28:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38960 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDKV2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 17:28:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so9222807wrn.6
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v9y1OHl6dVjxRrCBUQdAWKYzy7pxO/CU28bfr5zUIoo=;
        b=LTkyU8ScFtRJPO5VX4giDUuxnTvAPC00xsRaxPGBTnar+/3t1AV3Ih16nWxQL2eBRg
         kwnY4lv6PPNn0eanA7gK5kwHmI8W5tFYZ0jehluFTbX09G81Xbs0VeFhJRvjdbjL6LrI
         fSfn80+jrYtFdQG2SiDygpwE/1MoJ4dSUUPuiATx/dF+YhX9HAwcUPhPgHZDo+zmxaej
         pNyW41RuF/+Vss1zDYZNyiz7RWFkU7ssQCsLXXe01zwPRy+aPFCyqNCyhYL1RRC6r54N
         XL8QdDC4jtdwAKHzAFSnURm154zcS6KxBDn30wQuy/ULwqYxYiy/LsGoHEqCVW3B43Ka
         p8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v9y1OHl6dVjxRrCBUQdAWKYzy7pxO/CU28bfr5zUIoo=;
        b=MinxripOKdzmRDig6MgtccoO3hR2DmvA2QUrxBQRfbKBwq7EzA+V9y/4ymNw/MeRpe
         uHNlaob3sviLh/sqJ97zoAQqDIAhD2phMBlN1OWzsSaJy+508QrVf8+BwSxc8FQ2x8CN
         jCU+SEdjunF/SoM14pZCGAf9DvxbkY2pG8UXV+UWDPKHZsuHR6fFn7QhLWEO/ZgEpPLr
         NWV2igHvU3tC9qUmyoqbwfX29vZHt7VtE5Wggs8QU9QrEAmSNJSkoSSQuI5OXe5svjEy
         R1AujZLo3KeiSMl+4EKFEEO3tnG0V2IgBc+m/tFjZ7l52OMCEqW9xUeAEm/ZNY4C32Ml
         dyaw==
X-Gm-Message-State: APjAAAXF2hYEZvd1JF0W4OBXtO5vojS4zVjE18/cNK2FKKwGQoNsRLgf
        89jmGL5f4od3M9HvzakxOhaIcA6A
X-Google-Smtp-Source: APXvYqwYFB8wMX6Hetgf/jp+WDxKfJmffDdQdwnmKGKHo5SZ+omlZqNo/1Uc6q/Gw0ZsJU1CWTQCaw==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr34562062wrn.273.1555018112453;
        Thu, 11 Apr 2019 14:28:32 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id a6sm32163431wrp.49.2019.04.11.14.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 14:28:31 -0700 (PDT)
Date:   Thu, 11 Apr 2019 22:28:30 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-files: use correct format string
Message-ID: <20190411212830.GF32487@hank.intra.tgummerer.com>
References: <20190407184751.28027-1-t.gummerer@gmail.com>
 <20190411041823.GA17699@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411041823.GA17699@sigill.intra.peff.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Jeff King wrote:
> On Sun, Apr 07, 2019 at 07:47:51PM +0100, Thomas Gummerer wrote:
> 
> > struct stat_data and struct cache_time both use unsigned ints for all
> > their members.  However the format string for 'git ls-files --debug'
> > currently uses %d for formatting these numbers.  This means that we
> > potentially print these values incorrectly if they are greater than
> > INT_MAX.
> > 
> > This has been the case since the --debug option was introduced in 'git
> > ls-files' in 8497421715 ("ls-files: learn a debugging dump format",
> > 2010-07-31).
> 
> I didn't see any comment on this, but it seems like it must be obviously
> correct, since as you note we do define those fields as unsigned. I'm
> really surprised that -Wformat doesn't catch this, though. I wonder why.

Good point.  A bit of digging led me to -Wformat-signedness, which
should catch this.  This turns up a lot of errors in our codebase.  I
didn't go through to see how many of them are actual errors, and how
many are false-positives though.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65446 describes how the
option can lead to false positives, e.g.

    printf ("%u\n", unsigned_short);

might turn up an error.  From a quick test this seems to work
correctly with gcc 8.2.1 that I have on my machine though, so the
issue might be fixed in newer gcc version, even though that bug report
is still marked as new.

Maybe it's worth going through the warnings at some point to see if it
would be possible to turn -Wformat-signedness on.
