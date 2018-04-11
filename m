Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8261F404
	for <e@80x24.org>; Wed, 11 Apr 2018 19:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756063AbeDKT4j (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 15:56:39 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33656 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754367AbeDKT4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 15:56:38 -0400
Received: by mail-qt0-f176.google.com with SMTP id p9so1072352qtn.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nhPgQLRftbTzzzDh8YMH7a6nJSDoa06oewAB/WBouJM=;
        b=ZO6RGFJvAqLvkNjtcBppwmdUGR77n/TwGfC4r33ofWusWAWbn4E36ovt9/wsFJ10y6
         FPiJuiLZBPLtABfWW41pahk/q3Rc5e/N8Zp8Gbmz8OfP4pLrDiPG+kigQib4vp1QgR7t
         tSmwlNFj57f0q8lZJZgmL0G5qsg0ZqJCjd3LhBDRevaP410l9ZGcFhZAypblfJTZjZ9d
         boFYBDLpboYxc2A1oB1+L7KS9fU2M0oJDvBdCJAxRjBLmcxRmZtoX3MORPp8sFIJS4DF
         X1a5SiBB1HbCIZJtaofUSYcfafjDK+quK+vmMGr0LckXZNOg+K9Dp8Zk39lZr8jf0BmT
         xF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nhPgQLRftbTzzzDh8YMH7a6nJSDoa06oewAB/WBouJM=;
        b=Efr3IzI39ALrbHLNgtoV11tmPyIkNdDw+71yOwUOU6CLDuLqxnrkcaK9rRaJOh7Mgu
         U8g/rlCKNeqwludSAAk7WNo5EjBNU3xOBUIhbKLjKs+ySyfr+lewp857A0nDJr04gEk6
         ShZ3PzvuODXPC/s53pTizIG8+Ysh6qafOCO16bsQ66qPBGhl316LQ9yLv6k7Y3CpsATY
         UvA6v9Ofedr+2sSFY+unaeHdTzLk5K44ywwA4igS1RETmYUBZICyJUu2q1Bas7muNgZH
         Sf5TMuvuvjgoEKO1jKAfzfcVKKEXATOPpX+yK+LcckXVx6G+35+iixe04mH6V7D/5kXx
         dGsw==
X-Gm-Message-State: ALQs6tC61OSHRcIqbuxspbtcNzBlHxb1RNUmAmtxZNvOFTg2zmmvs6tG
        /upTjJD8OzjN0SY3DkcP9lM=
X-Google-Smtp-Source: AIpwx4/6LmP3+D4R9NKmHEvwZIQTUxW0TIs+fWiguafnZnfWyMj/Nf+7v/DipcrcEcjOBJA5SYYXqg==
X-Received: by 10.237.39.67 with SMTP id n61mr9242503qtd.36.1523476597246;
        Wed, 11 Apr 2018 12:56:37 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b125sm1357528qkd.62.2018.04.11.12.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 12:56:36 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] fsexcludes: add a programmatic way to exclude
 files from git's working directory traversal logic
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
References: <20180410210408.13788-1-benpeart@microsoft.com>
 <20180410210408.13788-2-benpeart@microsoft.com>
 <CAN0heSpKzG93OcAAAoHQxURVGsHFWz6j494C+3bezHLTOovQHA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <082cda6c-eb9f-c853-c09b-e0d3bc04cb9c@gmail.com>
Date:   Wed, 11 Apr 2018 15:56:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSpKzG93OcAAAoHQxURVGsHFWz6j494C+3bezHLTOovQHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/10/2018 6:09 PM, Martin Ågren wrote:
> On 10 April 2018 at 23:04, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> The File System Excludes module is a new programmatic way to exclude files and
>> folders from git's traversal of the working directory.  fsexcludes_init() should
>> be called with a string buffer that contains a NUL separated list of path names
>> of the files and/or directories that should be included.  Any path not listed
>> will be excluded. The paths should be relative to the root of the working
>> directory and be separated by a single NUL.
>>
>> The excludes logic in dir.c has been updated to honor the results of
>> fsexcludes_is_excluded_from().  If fsexcludes does not exclude the file, the
>> normal excludes logic is also checked as it could further reduce the set of
>> files that should be included.
> 
> Here you mention a change in dir.c...
> 
>>   Makefile     |   1 +
>>   fsexcludes.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   fsexcludes.h |  27 +++++++
>>   3 files changed, 238 insertions(+)
> 
> ... but this patch does not seem to touch dir.c at all.
> 

Oops! Fixed in V2.

>> +static int check_fsexcludes_hashmap(struct hashmap *map, const char *pattern, int patternlen)
>> +{
>> +       struct strbuf sb = STRBUF_INIT;
>> +       struct fsexcludes fse;
>> +       char *slash;
>> +
>> +       /* Check straight mapping */
>> +       strbuf_reset(&sb);
> 
> You could drop this strbuf_reset(). Or did you intend to use a static
> struct strbuf?
> 

Good point, fixed in V2.

>> +       /*
>> +        * Check to see if it matches a directory or any path
>> +        * underneath it.  In other words, 'a/b/foo.txt' will match
>> +        * '/', 'a/', and 'a/b/'.
>> +        */
>> +       slash = strchr(sb.buf, '/');
>> +       while (slash) {
>> +               fse.pattern = sb.buf;
>> +               fse.patternlen = slash - sb.buf + 1;
>> +               hashmap_entry_init(&fse, fsexcludeshash(fse.pattern, fse.patternlen));
>> +               if (hashmap_get(map, &fse, NULL)) {
>> +                       strbuf_release(&sb);
>> +                       return 0;
>> +               }
>> +               slash = strchr(slash + 1, '/');
>> +       }
> 
> Maybe a for-loop would make this slightly more obvious:
> 
> for (slash = strchr(sb.buf, '/'); slash; slash = strchr(slash + 1, '/'))
> 
> On second thought, maybe not.
> 
>> +       entry = buf = fsexcludes_data->buf;
>> +       len = fsexcludes_data->len;
>> +       for (i = 0; i < len; i++) {
>> +               if (buf[i] == '\0') {
>> +                       fsexcludes_hashmap_add(map, entry, buf + i - entry);
>> +                       entry = buf + i + 1;
>> +               }
>> +       }
>> +}
> 
> Very minor: I would have found "buf - entry + i" clearer here and later,
> but I'm sure you'll find someone of the opposing opinion (e.g.,
> yourself). ;-)
> 
>> +static int check_directory_hashmap(struct hashmap *map, const char *pathname, int pathlen)
>> +{
>> +       struct strbuf sb = STRBUF_INIT;
>> +       struct fsexcludes fse;
>> +
>> +       /* Check for directory */
>> +       strbuf_reset(&sb);
> 
> Same comment as above about this spurious reset.

Good point, fixed in V2.

> 
>> +       if (hashmap_get(map, &fse, NULL)) {
>> +               strbuf_release(&sb);
>> +               return 0;
>> +       }
>> +
>> +       strbuf_release(&sb);
>> +       return 1;
>> +}
>> +
>> +/*
>> + * Return 1 for exclude, 0 for include and -1 for undecided.
>> + */
>> +int fsexcludes_is_excluded_from(struct index_state *istate,
>> +       const char *pathname, int pathlen, int dtype)
>> +{
> 
> Will we at some point regret not being able to "return negative on
> error"? I guess that would be "-2" or "negative other than -1".
> 

This function is modeled after the other is_excluded_from* functions in 
dir.c so that the return value can be handled the same way.  I don't 
anticipate any need for change but you're right, we could return some 
other "negative other than -1" if it was ever needed.

>> +void fsexcludes_init(struct strbuf *sb) {
>> +       fsexcludes_initialized = 1;
>> +       fsexcludes_data = *sb;
>> +}
> 
> Grabbing the strbuf's members looks a bit odd. Is this
> performance-sensitive enough that you do not want to make a copy? If a
> caller releases its strbuf, which would normally be a good thing to do,
> we may be in big trouble later. (Not only may .buf be stale, .len may
> indicate we actually have something to read.)
> 
> I can understand that you do not want to pass a pointer+len, and that it
> is not enough to pass sb.buf, since the string may contain nuls.
> 
> Maybe detach the original strbuf? That way, if a caller releases its
> buffer, that is a no-op. A caller which goes on to use its buffer should
> fail quickly and obviously. Right now, an incorrect caller would
> probably fail more subtly and less reproducibly.
> 
> In any case, maybe document this in the .h-file?

Great suggestion!  I was looking for a better way to ensure the buffer 
ownership transfer was robust.  I'll do both strbuf_detach() and update 
the header file.  Thank you.

> 
> Martin
> 
