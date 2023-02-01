Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B7CC636CC
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 01:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBABeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 20:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBABd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 20:33:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA3577F7
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 17:33:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so16187157edb.7
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 17:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l40BLPNaaQilvf2eZ6DtwfT+PCw9z85iOyJoYsi9PwU=;
        b=c/oKD9Vfdz3lXGhLo0woTENOTlu7TTB/jKMVTglsEPRlV6/ftZ8QPkX0UUqMEtNJfK
         oGHSI47CFEYp8miUNHYn7C2BCp7YE86GVmIA+WAvnVqYCct64qujQ5jX0fL71j5Yp/+B
         FRcJdAvpy+9VksK7SjtEdY4VoC63Ue73VbpGoTCH9PEOiFpy9tJObQVKYTvRdC2/A8m0
         xzYIHJJh1PpenMNzJXkCSXO1Yu0sNg91VTVa7wHV4djlCPBb+fOXXg4vpwLt7yl7crh+
         JvSi9IdQsemCPQcOfT6NMn8HkI2N4f5knBbclXR0NgDQwi+3YRbFYcEk1n3bvUyk+Ugr
         pEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l40BLPNaaQilvf2eZ6DtwfT+PCw9z85iOyJoYsi9PwU=;
        b=uMwCgH/1yuJC7YUAA0iL7cgsapya15y4+CPPQLj1cjebPeaOTrPotVZGdh0lCqgPtJ
         HCXh5Naz8D3MqDJGuORgRoEQyPbrYN/VUQ8hPoXChksUfm/pTrapkrjZXMT77eAlNnwt
         kxiBc0t/+zDfVoh8Lv8WMF8d/P4Gz4nH4uR7DCljqjkT3tf5CNc3Ivx14UFchEX0LayG
         KNe74YM85sGaMwFo7A037pN91v754AAjNK37gLOyj+JhozaHI1lVfyVpmfXjClJVoIFX
         JOqwLy+1Zc5D0kK25xJhVXmgRg4MvKh7a/dZMndsO7iBX2FYJn0RBO9zYgdDtCQtguzv
         ZPLQ==
X-Gm-Message-State: AO0yUKU2Ze9wenqbZZDFsvBp7r0J1SZetiAVTmATygLR3M5vISfGzxFX
        Z8e4uTOOK+iETXATrIhnI1A=
X-Google-Smtp-Source: AK7set9D+zZ/JBTVBHYnFJUeDHPVHa7p3DOL3Iy8nQuUW7mipmdXgXnbzxFf0PmV5CXDXzFehe5XNg==
X-Received: by 2002:a50:a682:0:b0:483:21d8:87af with SMTP id e2-20020a50a682000000b0048321d887afmr156168edc.24.1675215231706;
        Tue, 31 Jan 2023 17:33:51 -0800 (PST)
Received: from [10.43.18.179] ([216.24.213.49])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090605c400b0084d242d07ffsm9227650ejt.8.2023.01.31.17.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 17:33:51 -0800 (PST)
Message-ID: <8d72f484-6a72-87f9-44f1-3a38471201db@gmail.com>
Date:   Wed, 1 Feb 2023 02:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Inconsistency between git-log documentation and behavior
 regarding default date format.
To:     Rafael Dulfer <rafael@dulfer.be>
References: <793c8116-f7ea-eef2-6979-231c3e94639a@dulfer.be>
 <9c3428f6-a254-13b4-046d-6e20ef602aef@dulfer.be>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
In-Reply-To: <9c3428f6-a254-13b4-046d-6e20ef602aef@dulfer.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/01/2023 16:09, Rafael Dulfer wrote:
> The Git documentation 
> <https://www.git-scm.com/docs/git-log#Documentation/git-log.txt---dateltformatgt> states that if no date format is given (or --date=default is given), the date format is similar to rfc2822 except of a few exceptions, of which those listed are:
> 
>    * There is no comma after the day-of-week
>    * The time zone is omitted when the local time zone is used
> 
> However, if we were to compare the two date formats, you can see another 
> difference:
> 
> git log --default  ->  Tue Jan 24 11:03:47 2023 +0100
> git log --rfc          ->  Tue, 24 Jan 2023 11:03:47 +0100

It seems that options in these samples were mistyped. They are missing 
the "--date=" part:


     $ git log -1 --date=default  master | grep 'Date:'
     Date:   Sat Jan 21 16:35:14 2023 -0800

     $ git log -1 --date=rfc2822   master | grep 'Date:'
     Date:   Sat, 21 Jan 2023 16:35:14 -0800

> 
> With the default, the month and day-of-month are switched around. From 
> my own quick investigation, this behavior occurs because of the 
> statement found at date.c#L266 
> <https://github.com/git/git/blob/56c8fb1e95377900ec9d53c07886022af0a5d3c2/date.c#L266> wherein the month is inserted before the day-of-month. I am unsure which behavior is exactly intended and whether this discrepancy was known, but it would probably be a good idea to have a note of it in the documentation.

Indeed, the description of the option (which comes from 
Documentation/rev-list-options.txt) doesn't describe all differences
between --date=default and --date=rfc2822.

A fuller list could be:

     * There is no comma after the day-of-week
     * The time zone is omitted when the local time zone is used
     * Day-of-month and month are switched around
     * Time-of-day and the year are switched around

CC'ing Peff, who wrote the list of exceptions in add00ba2de (date: make 
"local" orthogonal to date format, 2015-09-03).
