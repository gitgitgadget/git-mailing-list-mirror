Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14E431FC44
	for <e@80x24.org>; Mon,  8 May 2017 17:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbdEHRVI (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 13:21:08 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36146 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbdEHRVH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 13:21:07 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so6997171pfg.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FTqjrPId3zF0qxrvpou/z0JAWw+ovJjNgqW+f8HVSmc=;
        b=eyPj2xq8SMJlYLZsWEHc/g3fa8pJl804XiUg4rO31qOKiBWtDbAiWo8qeAbooxB2/T
         bQJcJI3kDsb52oiHVQlvrDPZciPwOVoequKSZW34G1IlyGfb/iGDlq4AOz3lAlL2uKsD
         ebL5J6rceF7srqWJZXRs5OxwEUcigjgZoq5hdKheiFaeI8eePmRN/8wrJHT4wnBPk/30
         EC3KNRMe8WYETu9xWZLq9+x/bx9khVbgNSeDmSzsU9aVSi5hqTJbQwQFq5RhZNIWIpij
         j1zgGwbF9VGDfbvJKEe5JtflbixnI4+0Qebx5InyiFAC/MbAowW8smkXs/61k6DcEp3h
         DgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FTqjrPId3zF0qxrvpou/z0JAWw+ovJjNgqW+f8HVSmc=;
        b=hATuEffYCEZ3A1MOi1T6x6TJLOXtpCW+Z/xdd8QAccgUcS9AAWA1WLYYddLS3M72jt
         pdA4ussCeJ7inoaUP3blMfFCWX5VIvC5BhbiUuGk3n8ZEjdH7vGLEoaRKj1lo7wmmRcP
         3h6Tw/0xBP0Mt5jFwP+TK31BJWMMNIWI28FJaBhXKj6F3lpgHDN6+INNkBNc7iNf2Fb5
         f0nsSzxgFDxf24KZbjFT3V2UgHAPgUfnNWJUL6inGfOxnHiiqF34nq8aEeVAYRCTUaTz
         yp44Uei5RpczLk0EQB0GtWas+omntMecrmglK/euQldhnjnnSolcdaJRzsvou7R30iut
         dblQ==
X-Gm-Message-State: AN3rC/57Oq7+hQqCTizPLQzN1bCTBjsNhk+iSzTt1HLY++RrcajCcL1n
        RdHDnfEZ4mACujSXkr15RT1D/6T4mj1/
X-Received: by 10.98.204.87 with SMTP id a84mr29152457pfg.6.1494264066342;
 Mon, 08 May 2017 10:21:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Mon, 8 May 2017 10:21:05 -0700 (PDT)
In-Reply-To: <504208edac024b2dba0c1743dc86683e@AMUSATLWP20005.alereinc.com>
References: <504208edac024b2dba0c1743dc86683e@AMUSATLWP20005.alereinc.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 May 2017 10:21:05 -0700
Message-ID: <CAGZ79kaLMHWth_t7LBpvtAKJQvseS34+RCKoedeqFosUxOiaPg@mail.gmail.com>
Subject: Re: Questions about validation/verification done for Git Software
To:     "Robertson, Todd" <Todd.Robertson@alere.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 10:14 AM, Robertson, Todd
<Todd.Robertson@alere.com> wrote:
> Hello,
>
> I'm a Sr. Software Quality Assurance Engineer at Epocal Inc. in Ottawa, Ontario,
> Canada.  We are a medical device manufacturer that is required to comply with
> the Food & Drug Administration's (FDA) regulations.
> I'm in charge of what is known as Non-Product Software, essentially any piece of
> SW that is used in the day-to-day work of creating our products.
> Part of complying with the FDA regulations is to ensure that all Non-Product Software
> has been validated.
>
> Some of our engineers are planning on using your software "Git" for their software
> development processes (latest version) to replace our current software "SVN" and I was
> hoping you could answer some questions for me?

How is svn validated for you?

> Are you able to provide me with a copy of your Test Plans and/or Test Cases for the "Git" product?

Tests are found inside the t/ directory in your copy of Git[1].
[1] obtained e.g. via "git clone https://github.com/git/git"

Note that these are just tests; nothing formal attached.

> Is the software FDA certified?

I am not aware of that.

Checkout https://git-scm.com/ and for legal questions contact
https://sfconservancy.org/ (via https://git-scm.com/sfc)
