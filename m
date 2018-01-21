Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBAF1F404
	for <e@80x24.org>; Sun, 21 Jan 2018 07:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeAUHqS (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 02:46:18 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:45546 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeAUHqR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 02:46:17 -0500
Received: by mail-qt0-f182.google.com with SMTP id x27so13695706qtm.12
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 23:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4OYnZTK2ZcfDA2VxqfjuEuH48ua+V08yooL0lrFJPJQ=;
        b=nqXLyhnA8oC6p7k/X+skEeydsmo7yHys7GvN+4fUEUr8DCfoibY1U8Yn2lQwPZcGg7
         lKmqHobcypOaEGBSt4K/RlehC8OKY5/4vNT+peQqZvVDjaS0d4ElHR32d1ZidiF6SyU/
         gc1Q4LV87MhnpxyjQLGZTii9rj+NqRTscLLDu1mPXsYHxCpW/alY+0VchqyGMiBpDqRG
         qaBSa86Z3+g936FueuOv89NjZp4l6R24iIy84akLGCA63thDaIe23K+le8hwfMbxq667
         vOggDNW1oVuZNu9CcR4Lg8jMNcMg2faGR/fJaal5la2hQVFarVXy2PhZ2Kp77iEMDvXB
         y8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4OYnZTK2ZcfDA2VxqfjuEuH48ua+V08yooL0lrFJPJQ=;
        b=PPXxkOheowdVst8MUoSCqxPaNuZAdRKA5fh9BDZfNAlQYPnDqphSrxhKwu8KCss1Ei
         jTja029fhUalFBx95hqpKYPa2FKHb2VZsyubq6sY7AszlTZRftc1eY1+FkQ8UITFDMo5
         t2rUl//tmC5CTysSLerAWE7WCGUzsZt1fda4z8/Iug1suYoy0zKHUNjez2F1n6M5UAZ2
         ykyBPItEy2zWE/lUt9a4IIpCaCFYCsSK50TbObWdglLKrDzYJ6ZfhVvmq+EN/IU4gq2r
         gliBkXd+8WUkFypPJ52xjhpQMvsnROFSbByD5Vwltmdz88y9C1OXW0qHisTcqLPbx3ET
         uP5A==
X-Gm-Message-State: AKwxyterjYXyRmzYAzAox82hU4GeT2o2IwzExyAMz8iGMtBhWxVptTij
        iU+jydxIODYYOCGNm0VOtsoDtOCPwm4XOW/xM+s=
X-Google-Smtp-Source: AH8x224cqZ9f2JMKYZRWeqLAoLJvjTYQqrRoEn1ReW0nHaqBiDo/mhxyC+yY7ndUUGEz8x5UNWC581t/BJ3fkY5vHJA=
X-Received: by 10.55.177.135 with SMTP id a129mr5299327qkf.112.1516520776242;
 Sat, 20 Jan 2018 23:46:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sat, 20 Jan 2018 23:46:15 -0800 (PST)
In-Reply-To: <xmqqa7x7oecq.fsf@gitster.mtv.corp.google.com>
References: <20180119041825.727904-1-sandals@crustytoothpaste.net>
 <20180120203324.112522-1-sandals@crustytoothpaste.net> <xmqqa7x7oecq.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 21 Jan 2018 02:46:15 -0500
X-Google-Sender-Auth: uAjWCpD9UVXlI3NDwipDCiN9eZg
Message-ID: <CAPig+cTW+vO7FWYViUrO-aV8pPL=KKhGf7Wkgh_51cbrxKZPEQ@mail.gmail.com>
Subject: Re: [PATCH] t: add clone test for files differing only in case
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 21, 2018 at 2:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> +test_expect_success 'clone on case-insensitive fs' '
>> +     o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
>> +     t=$(printf "100644 X\0${o}100644 x\0${o}" |
>> +             git hash-object -w -t tree --stdin) &&
>> +     c=$(git commit-tree -m bogus $t) &&
>> +     git update-ref refs/heads/bogus $c &&
>> +     git clone -b bogus . bogus
>> +'
>> +
>>  test_done
>
> Hmm, I seem to be seeing a failure from this thing:
>
>     expecting success:
>             o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
>             t=$(printf "100644 X\0${o}100644 x\0${o}" |
>                     git hash-object -w -t tree --stdin) &&
>             c=$(git commit-tree -m bogus $t) &&
>             git update-ref refs/heads/bogus $c &&
>             git clone -b bogus . bogus
>
>     fatal: repository '.' does not exist
>
> even on a case sensitive platform.

Yep. In pretty much any other test script, this would work (it was
developed in a stand-alone script), but t5601 (which nukes .git as its
first action) isn't the most friendly place.
