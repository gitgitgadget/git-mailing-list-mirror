Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD5620960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbdDMTD3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:03:29 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36028 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdDMTD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:03:28 -0400
Received: by mail-ua0-f178.google.com with SMTP id a1so38395145uaf.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p6adXcNtu9QdQa2frEfwsZYOe6UxOYaQVak8xVtKo+Q=;
        b=V1t2hx0TrjT89Ml4k9VY8g9tNgs4+ROXed3BiAAt+Hr+RGo6QX5vAZTr/rqf+dDYK1
         WibIF9w/BlRUvoz7cL1y3W7m5VH0JUffWjJs+4sO4sJp2Z4GdbuxSWYZno38af5eLLaO
         RYpDaUUQ2ocbiOqZD3D+aaDpBH2rOY0viJGCoaUHI+tBFaUkMPQcTqkezQ/hvS/c84wF
         6h5OgGQfJ+XDpIqWaGEUqI6QXNQsYnANrAAviPhWIr9n9zTLkCd2GnK5UbvKPnRPe0Cw
         kPsW82EZIQAPmBTqu1O/Hi3moiyNGNUZhb7Ldt03rTPhJWclG2GjOVvXl/Qafr7X+Vqv
         zkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p6adXcNtu9QdQa2frEfwsZYOe6UxOYaQVak8xVtKo+Q=;
        b=GX2OUrFpi0DcX9IHwO+WQ1ZXxtXbbUGqc74soNOO6oM/4Fwdr0qzpWeOP5+XK0Qg80
         hczp50tFTRlRMal8m3/DWP2bu7f3L8KCg139Iio71j9DJBc0Lbz7OwDnJ37hlWPDmNwQ
         zJb6Rt+Lrzk2FKHkik74n3flBiWzoKuHp5UFLMHQWVDK/qE2bZMEhKlXN6tL5TprOBFt
         7H1zQTYfTf0MsRgkiWDMNaKYsoeaeFO9gOn3kRxB0/WtN6O4Ht39I75yPh+w2BY5E24R
         N9dY2VqMdHSPwfOcJf00Lbrm90NIOeSd02jqsbHfHXNV3eTnVDK+dWyxN3D7ajeNTkLN
         ijdQ==
X-Gm-Message-State: AN3rC/4zq9NzoNz2bEp2OzVAnVtUDA4FjWPMihi9ENrnUiYQhBf+hN+U
        3+6Fwqx2tGb1nHXLDLq8CU6GVycZxw==
X-Received: by 10.176.74.80 with SMTP id r16mr1741686uae.39.1492110207205;
 Thu, 13 Apr 2017 12:03:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.23.211 with HTTP; Thu, 13 Apr 2017 12:03:26 -0700 (PDT)
In-Reply-To: <20170413175701.5ogpe7qbflbkgljm@sigill.intra.peff.net>
References: <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
 <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net> <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net> <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
 <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net> <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
 <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net> <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
 <20170413175701.5ogpe7qbflbkgljm@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 13 Apr 2017 21:03:26 +0200
Message-ID: <CAM0VKjmK0ib+sjf0sMPeiK7DrwHq1dJ58ZhDdp6HZsuQdb-eRw@mail.gmail.com>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test script
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 7:57 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 13, 2017 at 10:55:08AM -0700, Stefan Beller wrote:
>
>> On Thu, Apr 13, 2017 at 9:37 AM, Jeff King <peff@peff.net> wrote:
>> > Ah, OK, that makes more sense. I can detect it reliably by just checking
>> >
>> >   ! test -d $root/trash*
>> >
>> > in my stress-test after the test successfully completes.
>>
>> Would we want to report such an error from the test suite itself?
>> (My line of thinking is that this is a similar issue to broken && chains,
>> which we do report).

A broken &&-chain can harm the test's correctness by hiding errors.
The failing 'rm -rf $trash' during housekeeping, after all the tests
in the test script has been run and their results reported... not
really, I would think, though arguably it's a sign that something is
fishy.

> Yeah, I had a similar thought. I can't think of any reason why it would
> trigger a false positive, as long as we account for test-failure and the
> --debug flag properly. I don't think we can just drop the "-f" from the
> final "rm", because it may be overriding funny permissions left by
> tests.

FWIW, I used the following rather simple change during stress-testing
these patches (barring white-space damage):

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 13b569682..d7fa15a69 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -763,7 +763,7 @@ test_done () {

                test -d "$remove_trash" &&
                cd "$(dirname "$remove_trash")" &&
-               rm -rf "$(basename "$remove_trash")"
+               rm -rf "$(basename "$remove_trash")" || exit 1

                test_at_end_hook_
