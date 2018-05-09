Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A671F424
	for <e@80x24.org>; Wed,  9 May 2018 20:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964796AbeEIUkO (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 16:40:14 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:45496 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935279AbeEIUkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 16:40:14 -0400
Received: by mail-vk0-f44.google.com with SMTP id 203-v6so22666701vka.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dwiyEhRPQbKvArFhAsLvQn1PrtkxxlEURn86n46xbt8=;
        b=EpxOWOeSAUwLErdVlRiVObHxL5BtpNq9IcEQMzhvRDspW+qVmYBw7BPiUE/e5GQIxV
         dsaShVo4yEa5mdOoCyisDpJLhJwM+xm2TL/faOj1rYTfjphzP2DUcV/cl0AxtCGITI/3
         0CuGoG5KB7+TbRGHwqUr/w0aS2pMdhxhPIePZOG6GqryXpEKQ5LKl+fC5btOtr3e+T2q
         0SH2DIQyY9sRg1pwN3kgyifmvSZfz2EjhYcwxn76Yj7IIMfPVd10x1v9EAvHDcJd6ry0
         pDJ+wjooX4Zeq+V5OorE2+mzXDCn3iayYuSxu7vhqiqIsMt9UrhsRoi/2huifFXgpTTe
         WGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dwiyEhRPQbKvArFhAsLvQn1PrtkxxlEURn86n46xbt8=;
        b=acz8yOdhFFqfT/WTXqzeanGIDRyenVvJ2b32Q4MusAB8iIho4qjtkBFYlOX0nXuPhc
         2myGuRUlvqM5rOG12OEKDyxIReWAU1PkhfinjaxLVbtENU8kslaL7MMoanbj1RIkj/k6
         KOp+c0KSBTnPxBFEOCrzsFRVC7NnSLQYO5lmI6pe9AgZUDr6Xi4SUuSzUYtCcZtpXkH9
         iu/E3KspDWUY5DF1d5WEiKEeyziNadulwtDb8FQa3tZpUfxfQl9kCKTvdtCZ7mcbn1Mu
         6YA/l6ChsJIiBB+9Hhbidpp73jJOeZIB2Fa7f2KMdK5RGiWS1LQY0L0boVbHNfwBi3ql
         B8hg==
X-Gm-Message-State: ALQs6tBtyWrgE8VV5x/eW2e/C41iYhWq1bW2XZzEuw4wS/FzNXsdWpuP
        iCZ/LY/LcSZDB59b4j9E6hq3/sYim0WaY91E+Q0=
X-Google-Smtp-Source: AB8JxZpE0GP8hP7LdQ4RvgxHOpuf5NTz3+55IpujqkGoux3LQKZnWl3/FK2jx+dXkeB/HdJa5y1uxMK/GHIPjJm+zbQ=
X-Received: by 2002:a1f:a50e:: with SMTP id o14-v6mr38089879vke.89.1525898413424;
 Wed, 09 May 2018 13:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Wed, 9 May 2018 13:40:13 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805081651150.77@tvgsbejvaqbjf.bet>
References: <20180507120407.4323-1-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1805081651150.77@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 9 May 2018 22:40:13 +0200
Message-ID: <CAM0VKjmOfCNBoUh89Pr9UOSqNfuWayA3T8Fa-HySkH-icE1zYQ@mail.gmail.com>
Subject: Re: [PATCH] t6050-replace: don't disable stdin for the whole test script
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 10:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 7 May 2018, SZEDER G=C3=A1bor wrote:
>
>> The test script 't6050-replace.sh' starts off with redirecting the whole
>> test script's stdin from /dev/null.  This redirection has been there
>> since the test script was introduced in a3e8267225 (replace_object: add
>> a test case, 2009-01-23), but the commit message doesn't explain why it
>> was deemed necessary.  AFAICT, it has never been necessary, and t6050
>> runs just fine and succeeds even without it, not only the current
>> version but past versions as well.
>>
>> Besides being unnecessary, this redirection is also harmful, as it
>> prevents the test helper functions 'test_pause' and 'debug' from working
>> properly in t6050, because we can't enter any commands to the shell and
>> the debugger, respectively.
>
> The redirection might have been necessary before 781f76b1582 (test-lib:
> redirect stdin of tests, 2011-12-15), but it definitely is not necessary
> now.

That doesn't seem to be an issue in a3e8267225 (or in any other
commits touching t6050 since):

  $ echo foobar | ( ./t6050-replace.sh ; read input ; echo $input )
  *   ok 1: set up buggy branch
  *   ok 2: replace the author
  * passed all 2 test(s)
  foobar
