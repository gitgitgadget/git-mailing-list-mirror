Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79284201A7
	for <e@80x24.org>; Thu, 18 May 2017 04:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbdEREKX (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 00:10:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36815 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbdEREKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 00:10:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so4179848pfb.3
        for <git@vger.kernel.org>; Wed, 17 May 2017 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XRcorp1q63rhBjVm/sxk8Rf4D5VE1j05ZeyY5HuEuTo=;
        b=piE9P7I793JoD0Sgynm1SNbl8iNTVsVPY7jbZ6Z8bkPa+5KVyKQBW/VEVVa01bvl/r
         JVR7GIFKYWtI6BVRleGhrIxB3GYoZD9sqaaqG0RAxi4suqIS98zYES40hFnjPONYBPBf
         28DuH9Qa+Fus7K4vAbpf362QV3fWh29l/EtG7bUONSb62Jd7/+9f/6Mq7CjA0JKG6evw
         jD6lpNZqDnttcbCsy5otyKmdLLz2bgjNHN2F/y9Ptm+HtJxVm1wVfzLmyXWbmGB2iE50
         mUEIESB5UvYhMdVxpKYLe/bzl7YaEzMqcerchG4AD/Gq18qoaMWix4qSJzbTN+kZoNeK
         3ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XRcorp1q63rhBjVm/sxk8Rf4D5VE1j05ZeyY5HuEuTo=;
        b=qqXZvqY+V1oAe5iGKZRNSi/C9xuRFpyI2CieV+GesVTSQOn1Dful6yrXikR06LXo1l
         +q6sr5ug/9UbxSCnKz+5MqA7Fr4/iOBsEPVu6RUmkGaLSuOqs55fICSQy4IoUjuwCi5Z
         tdYmpS8k9KHOiiV+uDiD8zor2lGjHL78lB50HcsTEFDsLP1dQW9F4O3yMJvOGhuhKV+W
         yu0OU9DG9ZUcQrPR6qMulip36r0ha1A3ijQeiRhmMvCiEmGaoZ2/vK4qPny/hv4oQ/m+
         5oyObhkb9iP7+y1S1/c5iUWd3ZgRl8bLpc5AvyIZjZ0LENvowzcz/O5ljTCsa1YTSR6+
         mSFg==
X-Gm-Message-State: AODbwcA2hnjnz5/z4coLr/XS6brYTMt3IJpLKtLvi2Zut15YQLTTEYxT
        wtrYgfjBZbQCSA==
X-Received: by 10.98.69.68 with SMTP id s65mr2253831pfa.178.1495080622184;
        Wed, 17 May 2017 21:10:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id q28sm5565978pgc.0.2017.05.17.21.10.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 21:10:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 01/23] t3600: clean up permissions test properly
References: <cover.1495014840.git.mhagger@alum.mit.edu>
        <bb244c72ec6e6ab56171d82f7379a75c4eb5481f.1495014840.git.mhagger@alum.mit.edu>
Date:   Thu, 18 May 2017 13:10:20 +0900
In-Reply-To: <bb244c72ec6e6ab56171d82f7379a75c4eb5481f.1495014840.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Wed, 17 May 2017 14:05:24 +0200")
Message-ID: <xmqqa86avm8j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The test of failing `git rm -f` removes the write permissions on the
> test directory, but fails to restore them if the test fails. This
> means that the test temporary directory cannot be cleaned up, which
> means that subsequent attempts to run the test fail mysteriously.
>
> Instead, do the cleanup in a `test_must_fail` block so that it can't
> be skipped.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  t/t3600-rm.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 5f9913ba33..4a35c378c8 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -98,8 +98,8 @@ embedded'"
>  
>  test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
>  	chmod a-w . &&
> -	test_must_fail git rm -f baz &&
> -	chmod 775 .
> +	test_when_finished "chmod 775 ." &&
> +	test_must_fail git rm -f baz
>  '

Obviously a good idea.

In this case it would not matter very much, but I think it is a
better style to have when-finished _before_ "chmod a-w ." that
introduces the state we want to revert out of.

