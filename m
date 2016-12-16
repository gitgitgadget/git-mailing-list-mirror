Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2271FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756199AbcLPTfI (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:35:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36793 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbcLPTfH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:35:07 -0500
Received: by mail-io0-f195.google.com with SMTP id b194so12920743ioa.3
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 11:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0yjpjnf9n3hngLbeNSOKEN423kpvgitM5xw2LKw35+k=;
        b=pmjd9ruhWDDWulPMEw75LNAlK3zhgnCiCl2JL7ijOWfCyiFwtONV2hpUlkwVDnScSR
         GLI9YMLXyNQx7+QaP0yuQlkS5OAMhawO8vnuG2lqOmNusUN5lZGhuOBS4bGuHkcW/o/r
         DSfl9+ImSxBIsNkyqESFEuOuBaqCggS7mXU8zkZGMPgNnLe3AvtBBxT7NbaFzUS2Uwn/
         ty8jlMzic24AXe3A10HHOaJBdw4lP9WSQe3BDod4QRz6ZeQvgzPr/paPIHTyJXLXnPwL
         WvfcwNDYnZW8/PbiZHNJccGRQ/4t1D9vUJZhfH60/FARO4ovru2Nu/lIpFqcJAzy8lXx
         4SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0yjpjnf9n3hngLbeNSOKEN423kpvgitM5xw2LKw35+k=;
        b=Tp9DlcihePj/HrZdEy6+91Ls2ISnOA/hg9LC6Ws+TZnBwXiLDT2n5NopI+I683L77R
         TgeDJRpAzXZx7U2iz7foZEScpQ6dsEOTQxgUcfLkAus5YIqLrzjuf0S9KdjBkmJ9Pobb
         BmevlqPUyooigdgD7YBUBfYF9bdP6TL5HLUSqF9VZwfyLbkdvCsD9LV6ulasOkjLmzpo
         9pbsdRFgHeLUrTZx1kXF+WcjG7xdaFyyzRqsWvBsK3A1GEldjkLlaRAjfvPC3vskFAbd
         t2XpC7fl27HKzr/rnteBQJ3KnvnK42pvoKuXVVk9fZfujJ3AHS66rAXQolUtdy9JUrjb
         WP1g==
X-Gm-Message-State: AIkVDXJmbpbv1s5Oev+xlTP84enXqd95lh8Z+n5MY7oSN4rVKF4H8GVAoiLd8yTEdhcEJCtxBfJD1IUAAG74Sg==
X-Received: by 10.107.53.165 with SMTP id k37mr4594238ioo.74.1481916906422;
 Fri, 16 Dec 2016 11:35:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Fri, 16 Dec 2016 11:35:05 -0800 (PST)
In-Reply-To: <a4c7fec8-0e84-eb53-ca22-c369ce3facfa@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ab6-bda8420e-9a63-47d7-9b99-47465b6333d9-000000@eu-west-1.amazonses.com>
 <a4c7fec8-0e84-eb53-ca22-c369ce3facfa@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 17 Dec 2016 01:05:05 +0530
Message-ID: <CAFZEwPMwviof5jNvQnxFZYdw324XpbLSQ9mzEQjrCW-K4A+GCA@mail.gmail.com>
Subject: Re: [PATCH v15 08/27] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Thu, Nov 17, 2016 at 5:17 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index d84ba86..c542e8b 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -123,13 +123,40 @@ static int bisect_reset(const char *commit)
>>       return bisect_clean_state();
>>  }
>>
>> +static int is_expected_rev(const char *expected_hex)
>> +{
>> +     struct strbuf actual_hex = STRBUF_INIT;
>> +     int res = 0;
>> +     if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
>> +             strbuf_trim(&actual_hex);
>> +             res = !strcmp(actual_hex.buf, expected_hex);
>> +     }
>> +     strbuf_release(&actual_hex);
>> +     return res;
>> +}
>
> I am not sure it does what it should.
>
> I would expect the following behavior from this function:
>  - file does not exist (or is "broken") => return 0
>  - actual_hex != expected_hex => return 0
>  - otherwise return 1
>
> If I am not wrong, the code does the following instead:
>  - file does not exist (or is "broken") => return 0
>  - actual_hex != expected_hex => return 1
>  - otherwise => return 0

It seems that I didn't carefully see what the shell code is (or
apparently did a mistake in understanding it ;)). I think the C
version does exactly what the shell version does. Can you confirm it
once again, please?

Regards,
Pranit Bauva
