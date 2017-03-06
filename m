Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5711720133
	for <e@80x24.org>; Mon,  6 Mar 2017 22:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754406AbdCFWc2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 17:32:28 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35025 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbdCFWc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 17:32:26 -0500
Received: by mail-pg0-f52.google.com with SMTP id b129so71086035pgc.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 14:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s3Y9TruTymqwEUjJZ0T5w8f8qmkwavzwn+spIWO5ptQ=;
        b=IExFnVDX1v28s5RZ023Fp5n2iBFvVtJ+pURKXTSK0rlqx/AUjvnLrVbxUUwf70SdMN
         ks7jMDdMoLn8zXWZbA8hbUUlxY5L2HTzgiLqu9wgd1kyDGeEPNYTsMSJfKRxqCNQz3oG
         e+tJvJJOu8qQw1QIdjgYHzxqWKtKdqslZzhrMwj7y0KUHvsg+IiG7dB+3LQQAuV1++ZO
         /JOhiXBX2zH8S2Xxo1tIf5AKET6MpEiwFcbJIAoRMxYzBweL2KTbRdWGxZUgC/SvFigd
         UqoPQ/sW7jps0mC2GUwiUc1VnUGztFh2rYQMdH2C4Xmznom7PqGV0QOAXDTPBqSZwzsH
         i+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s3Y9TruTymqwEUjJZ0T5w8f8qmkwavzwn+spIWO5ptQ=;
        b=lCm6hGZa77wxs6nhBcWPM0v1dsbA/7jUUyCtdBr43o1Rp6S6Qx8bKiUe6XvaH+kMXL
         0Z4mSFAvmT44LTOcYW54FHfU61u7q0KqS29kg/aURrYrbAbF6RzvKeTEM50nYeZW8aju
         91PwuaanxyH7mnzoep55beI80AFiC5reAymKcELdTzmTiBKyvs+P2hnbqdGnlTeRbFIY
         5HV5gZhatmZ9Oe3MpFACYmhO4LKTEaeTcKuu+Ip0Du5Q5Sags4KqXCusSrNO/J2vSVGD
         kx8X1Q/+e2PSCMnWvMR8oeGfnRNA8P0zekkRsJgciJC77UIDVjt9B7wiAik+Q0QmVY5u
         B/pg==
X-Gm-Message-State: AMke39nCEWNNyezkvXfa2PVVThdI8BwbCdgWiFB7TsNWH4TziLG7RKrHPkXuWyqZAu6WVWPNJJKG0ldD811dV4OF
X-Received: by 10.84.128.74 with SMTP id 68mr29673957pla.111.1488832254220;
 Mon, 06 Mar 2017 12:30:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 6 Mar 2017 12:30:53 -0800 (PST)
In-Reply-To: <20170302021135.GA26453@starla>
References: <20170223225735.10994-1-sbeller@google.com/> <20170302004759.27852-1-sbeller@google.com>
 <20170302004759.27852-4-sbeller@google.com> <20170302021135.GA26453@starla>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Mar 2017 12:30:53 -0800
Message-ID: <CAGZ79kbffqxq-D_PBGLYQqz9M1jgighutp8WPYmeTBhdfkuKnw@mail.gmail.com>
Subject: Re: [PATCH 03/18] lib-submodule-update: teach test_submodule_content
 the -C <dir> flag
To:     Eric Wong <e@80x24.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 6:11 PM, Eric Wong <e@80x24.org> wrote:
> Stefan Beller <sbeller@google.com> wrote:
>>  test_submodule_content () {
>> +     if test "$1" == "-C"
>
> Use a single '=' for portability in sh.  It's also a good idea
> to prefix variables with 'x' or some such, since "$1" could be
> "-n" or some other supported switch for test(1).
> So, something like:
>
>         if test x"$1" = "x-C"
>
> ...or use a case statement.
>
> On Debian systems, I use the "checkbashisms" from the
> "devscripts" package to find and avoid bash dependencies.

Thanks for review as well as the tip for using
checkbashisms,

I'll resend this series with this fix as well as another fix
in git-submodule.sh

Thanks,
Stefan
