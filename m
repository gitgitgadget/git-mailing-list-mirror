Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D461F51C
	for <e@80x24.org>; Tue, 22 May 2018 01:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeEVBAM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 21:00:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44725 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeEVBAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 21:00:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id c22-v6so6412650pgn.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uyj2J6XaYqFQxCS3uM3T9Njmx+RDZWuUXIXbjpRFeN8=;
        b=EyMwRCpoTWmP/DmKWexgL5oaQ/hRJFlXiSinDK4bkpulRfGDa72m8R4hpMTpxveVxS
         72f3vvxJEzg4AP5QKRyotxnuWtoD6rTjqtDjyL386gZOqsmw7qZa8UjO9iDCAvCWh4KM
         Rx9rJoBVSpZJDdxayjaxkFP84HfySGzxbseKW1nTKpGtzk4I6sGyJ3uJ2D+HpaHKXwu5
         EQfFLlt+v8W8Tl0coJY4Ttpy5fxNOvjjrnxt1pW5jOpDo81UonMSQQ0Zbed6Mhy27b6M
         eGugjyp74rf24HxlQco1RI9d6mNSUYNS9Xi61gOh6BH5+zNnrw0dL3jp6PyFmB5M0fP+
         KklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uyj2J6XaYqFQxCS3uM3T9Njmx+RDZWuUXIXbjpRFeN8=;
        b=VoKCVU4g8rwPAEJ+884g/dzT6xwTQGsHxfeo89HTVJ78SkRxjj0SjiQigoZGIdhgSy
         eZOLX6Oc7KJYpZpYBUC6thW5xr5vQQW0isUQ8Um1Ai93cnmmI/RiESLRK/6D1ln9GLgW
         jkkSdDgtY9+xbsJ9RocKBojoPqHbrsyu9u9W8qG8whfpunwwXecXdGDMdkdmBgaVETUv
         HgycDI+/vvVy/Lv4I8RjpwkLGX04Huw+3zBgdBDRj2/ro43HNS+dy80Kf/cKwVVZAivQ
         Jk64VJFrHQVzfd91biDgsrEfVaI/qvdDDaKLEPQ08A5XdVKfsJk8lXdSpRfrKy9iwDd0
         GZDg==
X-Gm-Message-State: ALKqPwfMkMWJRZSgmLpmu9bt3khgxugBWH8vdiqe8c+94D0zcR7qjD5w
        4Dj3DHE8UZNSHBfH0cpjnYs=
X-Google-Smtp-Source: AB8JxZqdr/KhJwdW2Rj9AdG3H3Cbinwr2PP9hwiJbRpjgl+Q0IHnQDeXvMjXw88YD32KzmFE90HUEQ==
X-Received: by 2002:a62:4387:: with SMTP id l7-v6mr21796925pfi.55.1526950810555;
        Mon, 21 May 2018 18:00:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e15-v6sm18864712pgt.50.2018.05.21.18.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 18:00:09 -0700 (PDT)
Date:   Mon, 21 May 2018 18:00:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, daniel@haxx.se,
        git <git@vger.kernel.org>,
        Anton Golubev <anton.golubev@gmail.com>
Subject: Re: [PATCH 1/2] remote-curl: accept all encoding supported by curl
Message-ID: <20180522010008.GI10623@aiede.svl.corp.google.com>
References: <20180521234004.142548-1-bmwill@google.com>
 <CAGZ79kZiyi_1nxvfLttD6HPyV66Wz3pLnuAe=L7FB9ak05dGAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZiyi_1nxvfLttD6HPyV66Wz3pLnuAe=L7FB9ak05dGAQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Mon, May 21, 2018 at 4:40 PM, Brandon Williams <bmwill@google.com> wrote:

>> Configure curl to accept all encoding which curl supports instead of
>> only accepting gzip responses.
>
> This partially reverts aa90b9697f9 (Enable info/refs gzip decompression
> in HTTP client, 2012-09-19), as that specifically called out deflate not being
> a good option. Is that worth mentioning in the commit message?

More specifically, it mentions the wasted 9 extra bytes from including
"deflate, " on the Accept-Encoding line.  I think the extra bandwidth
usage will be okay. :)

[...]
>> -       curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
>> +       curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
>
> Looking at the code here, this succeeds if enough memory is available.
> There is no check if the given parameter is part of
> Curl_all_content_encodings();
> https://github.com/curl/curl/blob/e66cca046cef20d00fba89260dfa6b4a3997233d/lib/setopt.c#L429
> https://github.com/curl/curl/blob/c675c40295045d4988eeb6291c54eb48f138822f/lib/content_encoding.c#L686
>
> which may be worth checking first?

By "this" are you referring to the preimage or the postimage?  Are you
suggesting a change in git or in libcurl?

Curl_all_content_encodings() is an internal function in libcurl, so
I'm assuming the latter.

Thanks,
Jonathan
