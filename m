Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033901FAE2
	for <e@80x24.org>; Tue,  6 Mar 2018 22:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeCFWYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 17:24:54 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:39360 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbeCFWYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 17:24:53 -0500
Received: by mail-wm0-f44.google.com with SMTP id i3so1093967wmi.4
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UhtUvvzFGONxDlOXIxpW6lQtTnX1Dfm0oU007wspQWM=;
        b=TSQh2gb7N9hR5EaEXWD2E2PGi/LxxTCAoneILNBkEd4YT8WE4xh9IJSAiF4Fgo2vyC
         FMQ0FUWADEO/+Z/aR51KzVzbi7bwSJ1EI4tSK2tolHWh4dIGsBeOzmIvUNM8lcbN9WpC
         6HXTA847iWpI2Q2cxnINmJC6Tr0UVJblMNvPG/41PRccIPVgrdwvtEWJv3wcvhjrywcg
         XC7mOhvvzQUGya1Oh6sLi5hOcotlEWKbzkR3J0Z4NveYNcgzy3umWhtSyhQCuQzJpAZU
         PZtEcTfc6NIH9NnQgB5HsvtftGgGImsW6HE0AxUuTnP/D/ESyE0ZMNEvNXoRXZdLz5j/
         +qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhtUvvzFGONxDlOXIxpW6lQtTnX1Dfm0oU007wspQWM=;
        b=i3cBH1HYotpEpJPYJ9pVPNV9aSGULgoGpWWUvQW5sHMkYFvs6L+5yRlME13Taa/tZK
         Mk05MIuH9bkUZw0ZE/lTaLMl7XzpTfxzE5p6HBqG3++ZtqMRP703QH4utoD30hQJD276
         p7YQkyOcC9+Hw6bhNfzWPDbq6NTgwQMoKNGUUyj6J11T5sZrqgeMoYl8axz6cT0eRvFT
         ldArsNMtHBD7ctI818zNcluy/DO+DIq+t1JnK/Hmar/EybwRqKvbx3WpSbkF2m/HrEIS
         AKJBDwiJFF+z7sCLhKDqS/rG4vuS9zqoG0kFGCQ2X9vN3pRWkuvqxpCS1j6TSNTVz3Y8
         3YgQ==
X-Gm-Message-State: AElRT7ElS2v1j+IuNR9LtI+oVPpA61lOguS94RZDfXhSWmzwGFUOGujF
        Qx17yE7iqegaZsyvBz1AgEeWlyKG
X-Google-Smtp-Source: AG47ELtPKXYV8jWmrTFBFL49VCg6/i90BqXodppXyxExieb+PxbYPIq3WYFKf0mAMz6KeFN4sxrpmg==
X-Received: by 10.80.222.207 with SMTP id d15mr15832087edl.76.1520375092297;
        Tue, 06 Mar 2018 14:24:52 -0800 (PST)
Received: from ?IPv6:2001:a62:81d:ab01:a179:2207:8321:ce13? ([2001:a62:81d:ab01:a179:2207:8321:ce13])
        by smtp.googlemail.com with ESMTPSA id z4sm4453478edm.44.2018.03.06.14.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 14:24:51 -0800 (PST)
Subject: Re: [PATCH 2/2] git-svn: allow empty email-address in authors-prog
 and authors-file
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <20180304112237.19254-1-asheiduk@gmail.com>
 <20180304112237.19254-2-asheiduk@gmail.com>
 <CAPig+cQTpbj6q_s_pX2HjmpYF4W+5wKH7YLQQdZTiMPfK4G2Ng@mail.gmail.com>
 <CAFhHFBysKuDO9H4yJtnC6MJ+Jih5q4RsfwHTCsRXhXknapp4xg@mail.gmail.com>
Message-ID: <426e019a-cfb2-0e3a-b9b4-9d94f4f79312@gmail.com>
Date:   Tue, 6 Mar 2018 23:24:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFhHFBysKuDO9H4yJtnC6MJ+Jih5q4RsfwHTCsRXhXknapp4xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.03.2018 um 10:37 schrieb Andreas Heiduk:
> 2018-03-05 2:42 GMT+01:00 Eric Sunshine <sunshine@sunshineco.com>:
>> On Sun, Mar 4, 2018 at 6:22 AM, Andreas Heiduk <asheiduk@gmail.com> wrote:
>>> ---
>>> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
>>> @@ -1482,7 +1482,6 @@ sub call_authors_prog {
>>>         }
>>>         if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
>>>                 my ($name, $email) = ($1, $2);
>>> -               $email = undef if length $2 == 0;
>>>                 return [$name, $email];
>>
>> Mental note: existing behavior intentionally makes $email undefined if
>> not present in $author; revised behavior leaves it defined.
> 
> But only if the data comes from authors-prog. authors-file is unaffected.
> 
>>
>>>         } else {
>>>                 die "Author: $orig_author: $::_authors_prog returned "
>>> @@ -2020,8 +2019,8 @@ sub make_log_entry {
>>>                 remove_username($full_url);
>>>                 $log_entry{metadata} = "$full_url\@$r $uuid";
>>>                 $log_entry{svm_revision} = $r;
>>> -               $email ||= "$author\@$uuid";
>>> -               $commit_email ||= "$author\@$uuid";
>>> +               $email //= "$author\@$uuid";
>>> +               $commit_email //= "$author\@$uuid";
>>
>> With the revised behavior (above), $email is unconditionally defined,
>> so these //= expressions will _never_ assign "$author\@$uuid" to
>> $email. Am I reading that correctly? If so, then isn't this now just
>> dead code? Wouldn't it be clearer to remove these lines altogether?
> 
> The olf behaviour still kicks in if
>  - neither authors-file nor authors-prog is used
>  - only authors-file is used
> 
>> I see from reading the code that there is a "if (!defined $email)"
>> earlier in the function which becomes misleading with this change. I'd
>> have expected the patch to modify that, as well.
> 
> I will look into that one later.

I don't want to let that slip through the cracks: The `if` statement
still makes a difference if:

 - neither ` --authors-prog` nor `--authors-file` is active,
 - but `--use-log-author` is active and
 - the commit at hand does not contain a `From:` or `Signed-off-by:`
   trailer.

In that case the result was and still is `$user <$user>` for the author
and `$user <$user@$uuid>` for the comitter. That doesn't make sense to
me but doesn't concern me right now.
