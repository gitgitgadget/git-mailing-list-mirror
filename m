Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A267C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEECB613CD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 09:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbhI2Jxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 05:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhI2Jxj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 05:53:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4CC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 02:51:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id me1so1225045pjb.4
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lDRpdBWf7EYhffR8XEPUuMXpklpgl1lxS3EJTwOc5wg=;
        b=TGHTO1xcr+zbxYgunWu96mF1QtrOiRfw+m3mpLLXY8yI7FWZfTk6hGq9YsK5jHUQvC
         jw6FcHeifqRxFKY+fznnXpk8mrE/F1t2g/EDXZMeZ5AmgNucRuZjtMXL+KKVW0COJCR8
         s8BwiNgfXvNNRZP+m5xbIca2AaBJ34BPhMr7MkONf0+fUPpEoByQQUpHKvreYyEPpTvw
         K7Z2Lu9aHd6A27dVEfDRirk76lzikyZkeucnTMaYqLxmX/hV4HOS2UKQ9NTxSL1aDcoW
         pfZc4MYiFhyUoSV4JBtYkufkpxruZiZWBfjsM4fjd7hcUYsz0lpTzHz259aKJXXFXToi
         IPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lDRpdBWf7EYhffR8XEPUuMXpklpgl1lxS3EJTwOc5wg=;
        b=8Ey6FFJ6xJ3sS1CgdFlXBjRzdO21iUe1ohg9BLqG2ayBMEBkheyqIT/WWq60SYKVgJ
         BeC0fZ5Dwir1IHnYoLJKPehPK1OK8sh1XDv6abErSY5Jc7G3Yoosnc+dvRSS00Yc6MHq
         EM9G2Tk7rQu4kW6C7FL07bL+5woOKA6rwIM17JD7Ki4GGTawRS1OcWUEjKDTwMn25x/f
         gDbdHHfvUhwrEeUCkaIogwj4Oqyrg8RQOu67oV7nm5cF8Pv4L/+HaEiSfJshCGxjABAz
         tWrpjAXjrlNALBc8I2ptyFQ6tZv3k1ctWEh7x/90rd5U5UUebdqTWZrGx+HDfK0Hv6sQ
         oLVg==
X-Gm-Message-State: AOAM531CqBBa6tQNI3Cwdgyx/xBRvobjKZ4iQv+qiqVx2R6fqHaZ/Rup
        uQqHXMjzLfiEizWGB3QPcy3tXRyJ9JKykA==
X-Google-Smtp-Source: ABdhPJwY7SM9ifNIbd7k3ktEAmiy2Uspio6LjHWvcUxC1rraDRBKs3mP77F3Rg2rZAtHEfi5qwCyJQ==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr5462601pjb.80.1632909117714;
        Wed, 29 Sep 2021 02:51:57 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-59.three.co.id. [116.206.28.59])
        by smtp.gmail.com with ESMTPSA id d5sm2247825pfv.87.2021.09.29.02.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 02:51:57 -0700 (PDT)
Subject: Re: [PATCH] blame: document --color-* options
To:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
 <20210925121817.1089897-1-bagasdotme@gmail.com> <xmqq5yulregh.fsf@gitster.g>
 <fe78329d-07a7-bdf3-2bda-13def35f3de3@gmail.com>
 <4078bebf2da14e5f8fc80a5ac7918151@ncp-e.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c3603f8a-f75e-37f0-0517-c9a04c21e18e@gmail.com>
Date:   Wed, 29 Sep 2021 16:51:54 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4078bebf2da14e5f8fc80a5ac7918151@ncp-e.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/09/21 19.38, Dr. Matthias St. Pierre wrote:
> Thank you Bagas for adding the documentation. I think the only that disturbed Junio is the use of the word "metadata",
> which is used internally, but not in the official documentation aimed at the git user.
> 
> Starting from your patch, I added some suggestions for alternative wordings.
> 
> Regards,
> Matthias
> 
> 
> 
> commit ae2c59b7c76d9201d68aeb21b0ce57f2845732a1
> Author: Bagas Sanjaya <bagasdotme@gmail.com>
> Date:   Tue Sep 28 10:11:23 2021 +0200
> 
>      blame: document --color-* options
> 
>      Commit cdc2d5f11f1a (builtin/blame: dim uninteresting metadata lines,
>      2018-04-23) and 25d5f52901f0 (builtin/blame: highlight recently changed
>      lines, 2018-04-23) introduce --color-lines and --color-by-age options to
>      git blame, respectively. While both options are mentioned in usage help,
>      they aren't documented in git-blame(1). Document them.
> 
>      Co-authored-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
> 
> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 117f4cf806..1560f2b6df 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -136,5 +136,15 @@ take effect.
>   option.  An empty file name, `""`, will clear the list of revs from
>   previously processed files.
> 
> +--color-lines::
> +Color lines differently if they belong to the same commit as the preceding line.
> +This facilitates distinguishing code blocks introduced by different commits.
> +The color defaults to cyan and be adjusted using the `color.blame.repeatedLines`
> +config option.
> +
> +--color-by-age::
> +Color lines depending on the age of the line. The `color.blame.highlightRecent`
> +config option controls what color is used for which range of age.
> +
>   -h::
>   Show help message.
> diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
> index e05d520a86..a1cf36fc89 100644
> --- a/Documentation/config/color.txt
> +++ b/Documentation/config/color.txt
> @@ -9,8 +9,8 @@ color.advice.hint::
>   Use customized color for hints.
> 
>   color.blame.highlightRecent::
> -This can be used to color the metadata of a blame line depending
> -on age of the line.
> +Used to color line annotations differently depending on the age of the commit
> +(`git blame --color-by-age`).
>   +
>   This setting should be set to a comma-separated list of color and date settings,
>   starting and ending with a color, the dates should be set from oldest to newest.
> @@ -25,10 +25,9 @@ everything older than one year blue, recent changes between one month and
>   one year old are kept white, and lines introduced within the last month are
>   colored red.
> 
> -color.blame.repeatedLines::
> -Use the customized color for the part of git-blame output that
> -is repeated meta information per line (such as commit id,
> -author name, date and timezone). Defaults to cyan.
> +color.blame.repeated
> +Use this color to colorize line annotations, if they belong to the same commit
> +as the preceding line (`git blame --color-lines`). Defaults to cyan.
> 
>   color.branch::
>   A boolean to enable/disable color in the output of
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index 3bf5d5d8b4..cfdbad030b 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -11,8 +11,8 @@ SYNOPSIS
>   'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
>       [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
>       [--ignore-rev <rev>] [--ignore-revs-file <file>]
> -    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
> -    [--] <file>
> +    [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
> +    [<rev> | --contents <file> | --reverse <rev>..<rev>] [--] <file>
> 
>   DESCRIPTION
>   -----------
> 
> 

I can't apply the suggestion patch above. You sent the patch with 
S/MIME, right?

Next time, whether you post patches here, learn to use git format-patch 
and git send-email. Send patches in plain text only, *no (S/)MIME, no 
links, no compression, no attachments*.

Please resend your suggestion patch using git send-email, keeping in 
mind the guidelines above.

-- 
An old man doll... just what I always wanted! - Clara
