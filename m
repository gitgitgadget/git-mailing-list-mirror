Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A83A1F51C
	for <e@80x24.org>; Fri, 18 May 2018 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeERTZS (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 15:25:18 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43795 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeERTZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 15:25:16 -0400
Received: by mail-yw0-f195.google.com with SMTP id r202-v6so2742889ywg.10
        for <git@vger.kernel.org>; Fri, 18 May 2018 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cKpAeqq2Jd4KGlFd8vlVMGkp7hpRVdEbgfN6uVWnO+o=;
        b=C4NaO6YuXDNUhTQvcsYMOZO8WkpiuOxKXKnHw3IwZbCGIFW8jxDk38nUy5CWdkEdeK
         DtKx/0rKrMWdIDnc9SPwClg7YTbikBJouUXthr82C+px6dDQ2EZmTfrc4Mc7yYsqcK7S
         x6Q2DEPjE1DE2/w0I5qxCY7FLHTxZQgeKt3ym8SJqlLlX3qC2pCPHmPB388y1YDsxhgK
         bYNYBl91nzjz/an0qqFZB7J/5DEFmMDRlZGyXJBCZYxDCk+c3YiH9eDw1mF+1IdVkCLo
         U2pt7DQGv1H9umUr4XYUCzVSFdrwjr8B795pSLf8zZVLhEE4fI0RUoSzOb4N8FD+ve6j
         dxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cKpAeqq2Jd4KGlFd8vlVMGkp7hpRVdEbgfN6uVWnO+o=;
        b=RQVZK2YzDp7wwptbkewwZyeofLK3gn0IVOYE2xVFrpgicfS0aRTn69EC/cI4b1uvSq
         guEFI8JHfUm1l/QXvwpdQUDW5DDCr3qaAL5EsZnKCmM/AxmDekHk4BdCWdC9fWTEsADE
         /wQ1FUCNixOCIs4oXm+PvA11ygD8zRybFEjtqTtOCOhb/rAKCxT8LtGn/5EiLtMtYJ57
         WUE4AsoK7gGW549XooijD9JJdPyrTSAUdnXS2RZu+Rc+VvfvPbzotMbCJZ7O6MtMryjn
         wEQT1UhLpF6llEEvFRAF9xym0FKlWktUVlaHJanCG60MLUrSufsNgr9v6OOn6FyaTubJ
         TRAA==
X-Gm-Message-State: ALKqPwfQDO96FqEXJNiafGgPhe91FTTZ8ECy0PIBvuArijYLRYezHaJR
        x+GZwhaiqN16Q1TTFC7rwDo6JSsGH/wtXT9dd9qDcw==
X-Google-Smtp-Source: AB8JxZpIhXsTp/IBZLhqN/Zv0n/N3fDGPzwUVo7VLZh2YNh51YBsa0QxBg3vucYTnzgUhgApcjq+7IIZASH5za/B8w8=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr5484020ywe.500.1526671515411;
 Fri, 18 May 2018 12:25:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Fri, 18 May 2018 12:25:14
 -0700 (PDT)
In-Reply-To: <20180518040006.GA31451@ruderich.org>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com> <20180517194653.48928-7-sbeller@google.com>
 <20180518040006.GA31451@ruderich.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 May 2018 12:25:14 -0700
Message-ID: <CAGZ79kZ8VCAjxz36LDfKwZ9pvQSQwqkh_gijqxJQ57UG6zYHdQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] diff.c: decouple white space treatment from move
 detection algorithm
To:     Simon Ruderich <simon@ruderich.org>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 17, 2018 at 9:00 PM, Simon Ruderich <simon@ruderich.org> wrote:
> On Thu, May 17, 2018 at 12:46:51PM -0700, Stefan Beller wrote:
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index bb9f1b7cd82..7b2527b9a19 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -292,6 +292,19 @@ dimmed_zebra::
>>       blocks are considered interesting, the rest is uninteresting.
>>  --
>>
>> +--color-moved-[no-]ignore-space-at-eol::
>> +     Ignore changes in whitespace at EOL when performing the move
>> +     detection for --color-moved.
>> +--color-moved-[no-]ignore-space-change::
>> +     Ignore changes in amount of whitespace when performing the move
>> +     detection for --color-moved.  This ignores whitespace
>> +     at line end, and considers all other sequences of one or
>> +     more whitespace characters to be equivalent.
>> +--color-moved-[no-]ignore-all-space::
>> +     Ignore whitespace when comparing lines when performing the move
>> +     detection for --color-moved.  This ignores differences even if
>> +     one line has whitespace where the other line has none.
>> +
>>  --word-diff[=<mode>]::
>>       Show a word diff, using the <mode> to delimit changed words.
>>       By default, words are delimited by whitespace; see
>
> Hello,
>
> I think it would be better to specify the options unabbreviated.
> Not being able to search the man page for
> "--color-moved-ignore-space-at-eol" or
> "--color-moved-no-ignore-space-at-eol" can be a major pain when
> looking for documentation. So maybe something like this instead:
>
>> +--color-moved-ignore-space-at-eol::
>> +--color-moved-no-ignore-space-at-eol::
>> +     Ignore changes in whitespace at EOL when performing the move
>> +     detection for --color-moved.

That makes sense.

Stepping back a bit, looking for similar precedents, we have lots of
"[no-]" strings in our documentation. But that is ok, as we the prefix
is at the beginning of the option ("--[no-]foo-bar"), such that searching
for the whole option without the leading dashes ("foo-bar") will still find
the option.

So maybe another option would be rename the negative options
to "--no-color-moved-ignore-space-at-eol", such that the documentation
could fall back to the old pattern of "--[no-]long-name".

Initially I was tempted on not choosing such names, as I viewed all
this white space options specific to the color-move feature, such that
a prefix of "--color-moved" might be desirable. Turning off one sub-feature
in that feature would naturally be --feature-no-subfeature instead of
negating the whole feature.

I also cannot find a good existing example for subfeatures in features,
they would usually come as --feature=<option1, option2>

Undecided,
Stefan
