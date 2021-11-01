Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC3C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 15:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DECD60FE8
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 15:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhKAPhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhKAPhf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 11:37:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB2C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 08:35:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so28725884wrg.5
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fQLaZToYu0ggusxvN2yBmjdcXn6+yOLLIBHfc+6ah2k=;
        b=G5OG4FS2F9j5+MdqkfMOd1tHyEVH6OuY+PC+r9WrO51K7mplofjxzXmLhqWD6EFmZP
         1Fa9nWROeJMz1pphvttPKxdKW2VRP2IVgzjuCWoL5ptG67aEB1+R/zSyloXSkDT3My8S
         iduLpJPADYBmG0anDmFkmwgv6USHukE+cPNJ1dt9ty7j3bR1UjzOFMP0uiIhkN0uwdXU
         e9MN6ruEgCT8cBUg0WR7w+wh51YHZr7puP0RCumos83ATI9xO3mPEGUaIP4keVeYhDQK
         rgOEcB7+UhmbvOpoPPy4PQCWtBEvybR2NlzLJ1peISTgiIx7KAuJrhFFa/YrxbuimuQ+
         mMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fQLaZToYu0ggusxvN2yBmjdcXn6+yOLLIBHfc+6ah2k=;
        b=pocZj/++LVQElbvVnbOlbILs1TQoSHWkg3iA/XWlw1djfWeDNNuWr+33SUFEctGfuK
         QNoWVaFnAR1CPRpDf0i1raJmNxVU2V+63vDRRGTX69sfEMWnRQvDZ1tC9C1eb7up66Fw
         vqaFFlCxGPsel2M6cTtINjTwsJdDq50wbgmn8uDaInx6+VqPyVej7TSpB/3WUIDDS81a
         EFnHaWXjsVojyewlk2gqWK0FAHUdgQKaUMtZ0rE8G3xWd8E86Pf533pCYJM2mUximhu1
         GWTDKzqLU5SHoZX3+csJDRQdgt8iAz+FP9AI7KaoHsIe5GuBHZ0POSSBLb1JQmORknvj
         NnNA==
X-Gm-Message-State: AOAM530K1CIQuVlI8bsFeRznRwmAJYXGW9lsqk6eN8XQpzBNU1xNJiNq
        JH5zS4pYFtjQDDrw95Isvpo=
X-Google-Smtp-Source: ABdhPJw4o1Y3uwdE4Oa1myJ3jKGDOhcChLrSQm26C+WQt97c2SClfs7L598kbFhYBSXjJPN8OoyocQ==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr11041596wrv.427.1635780900183;
        Mon, 01 Nov 2021 08:35:00 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id p188sm12941625wmp.30.2021.11.01.08.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 08:34:59 -0700 (PDT)
Message-ID: <918977fe-4e87-8a2d-c337-6b57b83ae8dc@gmail.com>
Date:   Mon, 1 Nov 2021 15:34:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Document positive variant of commit and merge option
 "--no-verify"
Content-Language: en-GB-large
To:     Alex Riesen <alexander.riesen@cetitec.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
References: <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari> <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
 <YXlTpzrY7KFqRlno@pflmari> <xmqq4k92w7do.fsf@gitster.g>
 <YXpFTJTo0pKhM7xG@pflmari> <YXpZddOixrJDd//s@pflmari>
 <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com> <YXrFaJXbuSuwfhQ7@pflmari>
 <7be2fde3-69b2-1da7-bb94-7c181490f626@gmail.com> <YXv7CW4QHQOzFla6@pflmari>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YXv7CW4QHQOzFla6@pflmari>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 29/10/2021 14:45, Alex Riesen wrote:
> From: Alex Riesen <raa.lkml@gmail.com>
> 
> This documents "--verify" option of the commands. It can be used to re-enable
> the hooks disabled by an earlier "--no-verify" in command-line.
> 
> Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
> ---

This version looks good, thanks for documenting these options

Best Wishes

Phillip

> Phillip Wood, Fri, Oct 29, 2021 15:32:16 +0200:
>> On 28/10/2021 16:44, Alex Riesen wrote:
>>> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
>>> index a3baea32ae..2268787483 100644
>>> --- a/Documentation/git-commit.txt
>>> +++ b/Documentation/git-commit.txt
>>> @@ -174,9 +174,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>>>    -n::
>>>    --no-verify::
>>> -	This option bypasses the pre-commit and commit-msg hooks.
>>> +	By default, pre-commit and commit-msg hooks are run. When one of these
>>
>> As I suggested yesterday I think this would be better if it kept the "the"
>> from the original text as you do below for the merge documentation -
>> s/default, /&the /
> 
> Updated:
> 
>      -n::
>      --[no-]verify::
> 	    By default, the pre-commit and commit-msg hooks are run.
> 	    When any of `--no-verify` or `-n` is given, these are bypassed.
> 	    See also linkgit:githooks[5].
> 
>>> --- a/Documentation/merge-options.txt
>>> +++ b/Documentation/merge-options.txt
>>> @@ -112,8 +112,9 @@ option can be used to override --squash.
>>>    +
>>>    With --squash, --commit is not allowed, and will fail.
>>> ---no-verify::
>>> -	This option bypasses the pre-merge and commit-msg hooks.
>>> +--[no-]verify::
>>> +	By default, the pre-merge and commit-msg hooks are run.
>>> +	When `--no-verify` is given, these are bypassed.
>>>    	See also linkgit:githooks[5].
>>
>> This text looks good. It would be nice to be consistent when documenting
>> "--verify" and "--no-verify" so that documentation for commit and merge both
>> have either a separate entry for each option as you have for commit or a
>> shared entry as you have here for merge. I'd be tempted to use this form in
>> the commit documentation.
> 
> So I did.
> 
> Regards,
> Alex
> 
>   Documentation/git-commit.txt    | 5 +++--
>   Documentation/merge-options.txt | 5 +++--
>   t/t7504-commit-msg-hook.sh      | 8 ++++++++
>   3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index a3baea32ae..b27a4c4c34 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -173,8 +173,9 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>   	(see http://developercertificate.org/ for more information).
>   
>   -n::
> ---no-verify::
> -	This option bypasses the pre-commit and commit-msg hooks.
> +--[no-]verify::
> +	By default, the pre-commit and commit-msg hooks are run.
> +	When any of `--no-verify` or `-n` is given, these are bypassed.
>   	See also linkgit:githooks[5].
>   
>   --allow-empty::
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 80d4831662..80267008af 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -112,8 +112,9 @@ option can be used to override --squash.
>   +
>   With --squash, --commit is not allowed, and will fail.
>   
> ---no-verify::
> -	This option bypasses the pre-merge and commit-msg hooks.
> +--[no-]verify::
> +	By default, the pre-merge and commit-msg hooks are run.
> +	When `--no-verify` is given, these are bypassed.
>   	See also linkgit:githooks[5].
>   
>   -s <strategy>::
> diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
> index 31b9c6a2c1..67fcc19637 100755
> --- a/t/t7504-commit-msg-hook.sh
> +++ b/t/t7504-commit-msg-hook.sh
> @@ -130,6 +130,14 @@ test_expect_success '--no-verify with failing hook' '
>   
>   '
>   
> +test_expect_success '-n followed by --verify with failing hook' '
> +
> +	echo "even more" >> file &&
> +	git add file &&
> +	test_must_fail git commit -n --verify -m "even more"
> +
> +'
> +
>   test_expect_success '--no-verify with failing hook (editor)' '
>   
>   	echo "more stuff" >> file &&
> 
