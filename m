Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 450FF1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 22:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbcLFWnK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 17:43:10 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:32892 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcLFWnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 17:43:09 -0500
Received: by mail-io0-f193.google.com with SMTP id j92so9960904ioi.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 14:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vECwBjDdyHRTedB3SP1Pm9IXcWDxiB2yrgcw8QuZCaI=;
        b=TKuK3mas3XF4yLWexO2uwAx903Esl4xfzaEM1/07vthV91/U8YL5bc544mywJ5IbMR
         Lm1btzTWWrADwGwHqSoEWir2KoVv5Z3BQQ1XjKHs5WRxNJIvMkUjzthtXG60qzmUCF8g
         qy20juYjTL49WktkN7JQiARgFv4Tp/qDl2/oLcQodDMnD8e2PpZCji+aVExgvnGZu05g
         TPBTz4pE1jbNkd3pKkz5W3vOulrV5N3JprkQqJPyTVOer8Tw1LKCn+G01gu0qF1oechO
         cqsXcFkS6eYJ2qX9zlFVRjkRCTEdU4k9HWmRVWoq0Uvo7ddRTzIxKAHI7pkgU3MHuboy
         q1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vECwBjDdyHRTedB3SP1Pm9IXcWDxiB2yrgcw8QuZCaI=;
        b=VB7v+V19L5Jdrl1/GdwcVO7HOBO2QkiGOxlbaYQijtGNWgKDuMiF+Y8CY4JSvksiWL
         VxElEeQmPIHxcyKmF75AXbUss+K240baLhia0aogqrQLE/O+ynGQtwiWm3f686pD3yKz
         i3kWZWePMStLaQScvj6t8J8p55ESUZFMwzu4Fv/6yOO7g2OkE2HbKIwHXXssY8Z3wWYg
         Dszsyb6GZ2UHOUg7XvCD5Hp4szP/AHlA9CoXfXb0ay9D+NaBRPxyU0Hm+Khm5xJ4ik7w
         ALvZ5pUGVcCiwFpnw/NIYyYQ1PqqkNslit/BjcEXlAGujvbAhyjq2WjNYa0QYCvwG6mB
         euYA==
X-Gm-Message-State: AKaTC01+/QhpgQoPFJlSvhAKALR03I0+y5GufYhGF26UuG0W4+jKA6F2/FCPNzng9/cARhzLQNrStgXE89cMRA==
X-Received: by 10.107.141.211 with SMTP id p202mr53256690iod.47.1481064130323;
 Tue, 06 Dec 2016 14:42:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 14:42:09 -0800 (PST)
In-Reply-To: <c49a6151-0827-cae5-0569-8f05515be0f9@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b18-b81203b0-122f-4244-bfb2-9fac8ae71767-000000@eu-west-1.amazonses.com>
 <c49a6151-0827-cae5-0569-8f05515be0f9@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 04:12:09 +0530
Message-ID: <CAFZEwPMW5jD=bJy25qb36PfCazy=2=C10aDh-CL+ijhbkePZkA@mail.gmail.com>
Subject: Re: [PATCH v15 22/27] bisect--helper: `bisect_log` shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Fri, Nov 18, 2016 at 3:17 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 493034c..c18ca07 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -858,6 +858,23 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
>>       return -1;
>>  }
>>
>> +static int bisect_log(void)
>> +{
>> +     int fd, status;
>> +     fd = open(git_path_bisect_log(), O_RDONLY);
>> +     if (fd < 0)
>> +             return -1;
>> +
>> +     status = copy_fd(fd, 1);
>
> Perhaps
>
>         status = copy_fd(fd, STDOUT_FILENO);

Sure!

>> +     if (status) {
>> +             close(fd);
>> +             return -1;
>> +     }
>> +
>> +     close(fd);
>> +     return status;
>> +}
>
> That's weird.
> Either get rid of the if() and actually use status:
>
>         status = copy_fd(fd, STDOUT_FILENO);
>
>         close(fd);
>         return status ? -1 : 0;

This one seems better!
