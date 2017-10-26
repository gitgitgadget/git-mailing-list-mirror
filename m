Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D749202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 17:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbdJZR7j (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 13:59:39 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:44451 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbdJZR7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 13:59:38 -0400
Received: by mail-qk0-f180.google.com with SMTP id r64so5384530qkc.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uRm9HNCnvNgDdBOGImSnohPqqsnX+e5IE+otQjH04pk=;
        b=eUpZOe2v/BkSXD9JrdAb5kZNdntx/6Zvv+EPE00MraHDJevG9rdEIYmQWBhHvMj3cF
         flxZFVZirIMG03C+Chqt3LEw6pyhY6//g8SjIuhva/9sof7ci5OiAAAiRRFV1g/xRbvg
         3CHHp9MnYlNXGASrFDOD7T423qcPBWdhGqFWebrW2zOAbQ5B66lUqWPDejqB0LLPD0f4
         WZyhpl6pr185oINKy0DZAPzEWxaHOJRnmoF0RLROJbb5/QraZ4VzM1uyR2K0sUlOed3B
         JnxgL3G21S/Wqwi/aEVlUyd/uolNq9BmuS67NUY6qNlk6Tbait5AFyh/2q8QWf58C6sW
         0cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uRm9HNCnvNgDdBOGImSnohPqqsnX+e5IE+otQjH04pk=;
        b=ZhUeJelcqX2V7oTheQ+tLj0f16Asl9EBZ5NpjfJ1Hq0FDjlm7gZFBORr5hPtqXqoy7
         yahSil38TLcX6QlVMLtaDRdg33KH/AUGAyvm7Bf7QVhC1gGjZCGS+9Cnsvfuwa+dWtG4
         HnABGAEoyu92Nr6anFksBQh+nnjP1ClKNgt3lWA10bnxMcyxZFsEJ8fgcvZM+wnkgU+Q
         Ptcgj9Dq71vTH9PILXBcV331dtO04sliyrsKe/oz4/Rg7xjQ+dSQJkzm1xhFR90a4QLx
         poaHqJnXMyavID/hwdnRwnFrCaNksHoTh8+B3JI9mQ1fpLZE4YTB/OwnDVP2ckYsXuMg
         Jyyw==
X-Gm-Message-State: AMCzsaUsl+X+7KsxFmvt7GDzmz4A6RRWs9UwsB20KXcEzcRqo7y5eoOQ
        jRMIE7XeaEgEl6IGW/Xka2s4iu4m/z/JXOw0YhtOnRGN
X-Google-Smtp-Source: ABhQp+QxzSClkvhxacaucxaX0/b5Xs8MI4E2uovNxRG3kUz9nDmcXtrN02YLaDdUJqc0BY0ExnoLZZCvjV7zdIDLGao=
X-Received: by 10.55.125.196 with SMTP id y187mr9961762qkc.180.1509040777572;
 Thu, 26 Oct 2017 10:59:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 26 Oct 2017 10:59:36 -0700 (PDT)
In-Reply-To: <CA+P7+xp2S9U1y0ENj0Z=B6-DY3XWKCg16xCCzVjHDLwAcMbGZQ@mail.gmail.com>
References: <20171025224620.27657-1-sbeller@google.com> <20171026072213.p6llaqrbdss7nbu4@ruderich.org>
 <CA+P7+xp2S9U1y0ENj0Z=B6-DY3XWKCg16xCCzVjHDLwAcMbGZQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Oct 2017 10:59:36 -0700
Message-ID: <CAGZ79kZ5o6SjSa2C4rSY3ExEstThXziK7zzF93Y7uT1udE6+Yg@mail.gmail.com>
Subject: Re: [PATCH 0/2] color-moved: ignore all space changes by default
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 1:42 AM, Jacob Keller <jacob.keller@gmail.com> wrote:

>>
>> Hello,
>>
>> I'm not sure if this is a good default. I think it's not obvious
>> that moved code gets treated differently than regular changes. I
>> wouldn't expect git diff to ignore whitespace changes (without me
>> telling it to) and so when I see moved code I expect they were
>> moved as is.
>>
>> And there are languages where indentation is relevant (e.g.
>> Python, YAML) and as color-moved is also treated as review tool
>> to detect unwanted changes this new default can be dangerous.

That makes sense.

>>
>> The new options sound like a good addition but I don't think the
>> defaults should change. However unrelated to this decision,
>> please add config settings in addition to these new options so
>> users can globally configure the behavior they want.
>>
>> Regards
>> Simon
>> --
>
> Even languages which are indentation sensitive often move blocks of
> lines between indentation levels a lot. I personally think the default
> could change.

A safe default for such languages would be when the
change in whitespace across lines is taking into account, i.e.
when lots of lines are copied, but all of them miss two tab indentation,
then it is probably fine to color it all the same. However if there would
be a couple of lines in that moved block of code that have
a different indentation than most other lines, this could indeed
change the program flow in python.

So ideally we'd compare the whitespace delta across lines.
Note sure if that is easy. Maybe instead of ignoring whitespaces
completely we'd rather make up a "white space delta", e.g. by using
word-diff between the old and new line, and then keeping a hash of that
space delta for each line. The move detection would then also compare
the hashes of adjacent moved lines.

> However, I would suspect the best path forward is leave the default
> "exact match" and allow users who care and know about the feature to
> change their config settings.

I think that is what I'll do for now as it seems simple enough.

Thanks,
Stefan
