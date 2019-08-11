Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7311F731
	for <e@80x24.org>; Sun, 11 Aug 2019 09:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfHKJyl (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 05:54:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35928 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfHKJyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 05:54:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so8309142wrt.3
        for <git@vger.kernel.org>; Sun, 11 Aug 2019 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rn7K/7CndzxYisLuR0Q5TjAadleNhk/ZulxXeKfa8f8=;
        b=FBO+wRWVgjkStr1svBZU5FEI5SSTP1HthmjDoZ2mfMVWfLHE0jtadeymy+SqccoHns
         225+7R0fWxwr4tOQKT9IcVKIvg55efOYcfqocz5N6/pO7lPvYjNkXLkAZVB3EhNmW0BX
         doy7UIKWrjWCpZnUkJ9pCH3aQ3Hb/DtrclsXXtosnoVm+Dc8m3tGJW786mMjt3Vmx+pz
         fwWjsAP05xGWQNpqx4E4OOzjxegKAbcqBT4NkZJQ9lRpDt3ugacruNXb8l6bqB3oeWVp
         F2m6l5hdtpY9/+rJ2IARW8PbwlJ75qmfzdg8yreDRMaSYOehLGRNn2sjvDIVR35MrLXf
         Rajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rn7K/7CndzxYisLuR0Q5TjAadleNhk/ZulxXeKfa8f8=;
        b=b+gEziX/ZzAaR+290Cj0WTNAyt5bXP2mJGuzfhP0ZNJRGkUUIOExrVJZubtByYsONp
         H4UaWJpk4DTbxO/hY77WTi1MOwmJ9nsmryBOdoseS5lvnLaKmjSDNG67ywm6Lp6clf5C
         9VZG6MZCQlTFPidg1qQg8w3jyPAeXBGbzN/iBc8p0JSzr07Eubt2Ak6Kj0BSkApQcrFQ
         c/xVgtfWOuTM3RFgbDc02yx+ysIuvgoJU9IgxKAfMCAh+1h9hKvGOPKwpYN8+GfVHqT8
         2hP7cY2j4FpIIDgg42z5kUjZPancIETTOEOjl504jsVHc8ip/Iv9mu8OlTGDdApHnXKM
         8nBQ==
X-Gm-Message-State: APjAAAX+yi+6pNkwFY7dD8GTkvOMqYJAUJY7wJFe+8ZWu8DyqK1DL4dx
        jZtURLRcGvOkQah4u/NdGWY6XTlY
X-Google-Smtp-Source: APXvYqx96gYOieeqOW5fVUKtl3Z7UwLNhMitKsl2cg/qwFi0Lm9kpsyzNY0p1gsakR3qfTB1SzRXNg==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr35760702wrv.128.1565517273251;
        Sun, 11 Aug 2019 02:54:33 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id y6sm12361053wmd.16.2019.08.11.02.54.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 02:54:32 -0700 (PDT)
Subject: Re: Incorrect behavior from git checkout --patch
To:     Dave Kaminski <davekaminski@gmail.com>, git@vger.kernel.org
References: <CA+zjYZsojm0QgHBC3GFb2NeZR1aK3Uh7vO4ojBzsMKVvP6X+Tg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a243aa2f-b237-db8e-0cac-cb3f776fdbd2@gmail.com>
Date:   Sun, 11 Aug 2019 10:54:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+zjYZsojm0QgHBC3GFb2NeZR1aK3Uh7vO4ojBzsMKVvP6X+Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dave

Thanks for the bug report. I've tried to reproduce it on the latest 
master, version 2.22.0 and 2.20.1 and am unable to do so. I thought it 
might be related to a bug I recently fixed[1] but it does not appear to 
be. I've appended the files I used below just in case I made a mistake 
translating your patches to files that can be used with git checkout.

Best Wishes

Phillip

[1] 
https://github.com/git/git/commit/1b074e15d0f976be2bc14f9528874a841c055213#diff-588be9a03d1f7e33db12f186aad5fde9

pre-image

block_one {
line 1
line 2
line 3
2 4 6 8
line 4
line 5
line 6
2 4 6 8
line 7
line 8
line 9
2 4 6 8
line 10
line 11
line 12
}

block_two {
line 1
line 2
line 3
2 5 6 9
line 4
line 5
line 6
2 5 6 9
line 7
line 8
line 9
2 5 6 9
line 10
line 11
line 12
}

post-image

block_one {
line 1
line 1.5
line 2
line 2.5
line 3
2 4 6 8
line 4
line 4.5
line 5
line 5.5
line 6
2 4 6 8
line 7
line 7.5
line 8
line 8.5
line 9
2 4 6 8
line 10
line 10.5
line 11
line 11.5
line 12
}

block_two {
line 1
line 1.5
line 2
line 2.5
line 3
2 5 6 9
line 4
line 4.5
line 5
line 5.5
line 6
2 5 6 9
line 7
line 7.5
line 8
line 8.5
line 9
2 5 6 9
line 10
line 10.5
line 11
line 11.5
line 12
}



On 10/08/2019 21:12, Dave Kaminski wrote:
> I am observing git checkout --patch making changes to the wrong lines of a file.
> 
> This is with a clean install of git version 2.20.1 on a debian docker
> container (image tag 10.0 which is also "latest" as of this writing).
> 
> With a diff that looks like the following:
> 
> diff --git a/file.txt b/file.txt
> index 868aa22..ea4d786 100644
> --- a/file.txt
> +++ b/file.txt
> @@ -1,35 +1,51 @@
>   block_one {
>   line 1
> +line 1.5
>   line 2
> +line 2.5
>   line 3
>   2 4 6 8
>   line 4
> +line 4.5
>   line 5
> +line 5.5
>   line 6
>   2 4 6 8
>   line 7
> +line 7.5
>   line 8
> +line 8.5
>   line 9
>   2 4 6 8
>   line 10
> +line 10.5
>   line 11
> +line 11.5
>   line 12
>   }
> 
>   block_two {
>   line 1
> +line 1.5
>   line 2
> +line 2.5
>   line 3
> -2 5 6 9
> +2 4 6 8
>   line 4
> +line 4.5
>   line 5
> +line 5.5
>   line 6
> -2 5 6 9
> +2 4 6 8
>   line 7
> +line 7.5
>   line 8
> +line 8.5
>   line 9
> -2 5 6 9
> +2 4 6 8
>   line 10
> +line 10.5
>   line 11
> +line 11.5
>   line 12
>   }
> 
> doing a `git checkout --patch -- ./file.txt`, splitting the diff into
> hunks, and discarding all of the hunks that begin with numbers, e.g.
> 
> @@ -22,3 +32,3 @@
>   line 3
> -2 5 6 9
> +2 4 6 8
>   line 4
> 
> the expected state of the file in the working directory is this:
> 
> diff --git a/file.txt b/file.txt
> index 868aa22..9ab67a1 100644
> --- a/file.txt
> +++ b/file.txt
> @@ -1,35 +1,51 @@
>   block_one {
>   line 1
> +line 1.5
>   line 2
> +line 2.5
>   line 3
>   2 4 6 8
>   line 4
> +line 4.5
>   line 5
> +line 5.5
>   line 6
>   2 4 6 8
>   line 7
> +line 7.5
>   line 8
> +line 8.5
>   line 9
>   2 4 6 8
>   line 10
> +line 10.5
>   line 11
> +line 11.5
>   line 12
>   }
> 
>   block_two {
>   line 1
> +line 1.5
>   line 2
> +line 2.5
>   line 3
>   2 5 6 9
>   line 4
> +line 4.5
>   line 5
> +line 5.5
>   line 6
>   2 5 6 9
>   line 7
> +line 7.5
>   line 8
> +line 8.5
>   line 9
>   2 5 6 9
>   line 10
> +line 10.5
>   line 11
> +line 11.5
>   line 12
>   }
> 
> but instead the actual state of the file is this:
> 
> diff --git a/file.txt b/file.txt
> index 868aa22..76fe65d 100644
> --- a/file.txt
> +++ b/file.txt
> @@ -1,35 +1,51 @@
>   block_one {
>   line 1
> +line 1.5
>   line 2
> +line 2.5
>   line 3
>   2 4 6 8
>   line 4
> +line 4.5
>   line 5
> +line 5.5
>   line 6
>   2 4 6 8
>   line 7
> +line 7.5
>   line 8
> +line 8.5
>   line 9
> -2 4 6 8
> +2 5 6 9
>   line 10
> +line 10.5
>   line 11
> +line 11.5
>   line 12
>   }
> 
>   block_two {
>   line 1
> +line 1.5
>   line 2
> +line 2.5
>   line 3
>   2 5 6 9
>   line 4
> +line 4.5
>   line 5
> +line 5.5
>   line 6
>   2 5 6 9
>   line 7
> +line 7.5
>   line 8
> +line 8.5
>   line 9
> -2 5 6 9
> +2 4 6 8
>   line 10
> +line 10.5
>   line 11
> +line 11.5
>   line 12
>   }
> 
> See the changes between "line 9" and "line 10" in both blocks that are
> not correct.
> 
