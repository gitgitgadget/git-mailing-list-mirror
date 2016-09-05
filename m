Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF621FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934325AbcIETJZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 15:09:25 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:34407 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbcIETJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 15:09:24 -0400
Received: by mail-it0-f41.google.com with SMTP id i184so25320958itf.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FvD4V4dcQWDFIlnAlhZy+Ux2UwWIgLE7ppHUchB0eDg=;
        b=PT8IX2zTUdJ+PQkSOKCYq0mzL4ysVbjl+ds0QTQ6mJdTGs3vrzXZ7aphUFiy1e/2z3
         7s8dVhm0ErP3Nml7GXLSbQQxzjcEOgzsl0qkdtxDt8dkX8j4nj8TjxaffdRD6MxPevig
         guuYgYsEWYTEzNbE81jmnRHiJKiB5ftjBWibhegWdKLVBLgaM7U/+g+N0+RDGEoWrQsA
         eMBQqCnrG2g0H/XZpCGkRJ2kNOtW4rNqWgCkP4TwRPQYxeI6rGybY/g4+ZMgwQXe2e7m
         nunO5YIQQqnqDrIXboy4Sy5feTgIaDSkBIhXWeAiMGt5lMy4LcPl4mZBYnbhI1MY5dIM
         lETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FvD4V4dcQWDFIlnAlhZy+Ux2UwWIgLE7ppHUchB0eDg=;
        b=YG1qz+vQfrmoegD8jq6kE/1mB8pSfLVTQ8Ha2cs4eLmkVMbZnDr8UVFTtpoUi0pEx9
         Yvm31TvAaKTmgeuHtlipR2OInoJDrn97XZv5QRMJHBE4m0u80U4klTN/0XAh0dG1hCiK
         qYoIYHukktlaXhVhOJcD9yEFHzyz3cRXYw8Ngi9je+ihaxX8uOOcF0NVwUKVdcCFHSYn
         tOCRFLtTO7Q+taPHrXaMtvfxUpUQ4uQdBlA4kNc08w/ZvXDSxgoAFvgVGEAyWjoTffYq
         BPaUOMLHDuVy2/g2cspNIEzFkHo+WPUAhT/Wp9BhmNialzwaiT3aL827mzF6tjwF/Efa
         iiFg==
X-Gm-Message-State: AE9vXwNdPY8YOoDEI+3yhU1kugyS03pJeywEeQOZy/GB1OSqya8BkHf0M8gKzNBgm21RPlUQG4heAh/edoCwQg==
X-Received: by 10.107.20.11 with SMTP id 11mr784227iou.70.1473102563625; Mon,
 05 Sep 2016 12:09:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.15.28 with HTTP; Mon, 5 Sep 2016 12:09:23 -0700 (PDT)
In-Reply-To: <CAPig+cTsCDpCQ9j82OEa13YBYswDKfYd_dc1QbxRSRk3wiOhHw@mail.gmail.com>
References: <20160905102444.3586-1-gitter.spiros@gmail.com>
 <20160905102444.3586-4-gitter.spiros@gmail.com> <CAPig+cTsCDpCQ9j82OEa13YBYswDKfYd_dc1QbxRSRk3wiOhHw@mail.gmail.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Mon, 5 Sep 2016 21:09:23 +0200
Message-ID: <CA+EOSBki1E8HJ1DMuAuQaB6sBcUjvQLA5xUWdF9G+6+HRQUD7g@mail.gmail.com>
Subject: Re: [PATCH 3/4] t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL
 environment var
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-09-05 15:43 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Mon, Sep 5, 2016 at 6:24 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> Use the new GIT_TRACE_CURL environment variable instead
>> of the deprecated GIT_CURL_VERBOSE.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
>> @@ -263,15 +263,18 @@ check_language () {
>>                 >expect
>>                 ;;
>>         ?*)
>> -               echo "Accept-Language: $1" >expect
>> +               echo "=> Send header: Accept-Language: $1" >expect
>>                 ;;
>>         esac &&
>> -       GIT_CURL_VERBOSE=1 \
>> +       GIT_TRACE_CURL=true \
>>         LANGUAGE=$2 \
>>         git ls-remote "$HTTPD_URL/dumb/repo.git" >output 2>&1 &&
>>         tr -d '\015' <output |
>>         sort -u |
>> -       sed -ne '/^Accept-Language:/ p' >actual &&
>> +       sed -ne '/^=> Send header: Accept-Language:/ p' >actual &&
>> +       cp expect expect.$$ &&
>> +       cp actual actual.$$ &&
>> +       cp output output.$$ &&
>
> What are these three cp's about? They don't seem to be related to the
> stated changes. Are they leftover debugging gunk?
Yes, i am very sorry. My bad. I will repost. Thanks


>
>>         test_cmp expect actual
>>  }
>>
>> @@ -295,8 +298,8 @@ ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
>>  '
>>
>>  test_expect_success 'git client does not send an empty Accept-Language' '
>> -       GIT_CURL_VERBOSE=1 LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
>> -       ! grep "^Accept-Language:" stderr
>> +       GIT_TRACE_CURL=true LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
>> +       ! grep "^=> Send header: Accept-Language:" stderr
>>  '
>>
>>  stop_httpd
