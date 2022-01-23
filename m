Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA45C433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 17:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiAWRbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 12:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiAWRbW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 12:31:22 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023BCC06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 09:31:21 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id s12so17155439qkg.6
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WVPIlNatdERkwxjn5qP2PdptQmIWAXpYzS7unGQVmws=;
        b=gNBcMjSXTymm9YLjz2KKB+q+cxVyc+EiyC+xUr94XQYui+3+Un6rfmDc9+K4JYDEsV
         HQzkepwE+jCYkngL8+Uc8Uod7p27p5bnbbY2GFcpie2nuytxwfyXvuqmD+cMcPfrQ7E5
         rtMrgsJSv7rfpYobbNgY9j49gUh/NRw/AlsdDwF5hjqCxJnbwNOTs+7wctmj9+GaCwUY
         eBGyBCTYU7H0pEreu4hE03t+x4YilaXZX2H/us3Jbd7Fj4hOX3UezBPM5yd/Qds88d1Q
         m9+QLFTyMPaKchEOnVTpbcmyVKBO8AXmzpIxROZJaLQ2v10nfmkYVE24lbAxwJgiVVtM
         rdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WVPIlNatdERkwxjn5qP2PdptQmIWAXpYzS7unGQVmws=;
        b=KvEQxJwUYVb6WDXNkuPz3rjr0pY+UAmN0zrLLKy8NWC3JXwcF9cKwRa4yRwmS82I5c
         VVrvw5hkqtp9pr7rmGIXgjfOE2ReJlZRlk7/T06NHYtyFLGzA1xYS2YsenaYqyDcsxtd
         lH1wsrgHw+8zf7yBVoHtNsX64e9VEhAmTDuZld5moz53zfdwJ2rv+eRE02YQdzArvSXL
         rMso6NDu3+3KuUPiqx9Vl+r6GQOGNylgQNDI7ApdTTnrf/pD/3BMhGawaJA/Nry9bjHX
         7/tKe4jT4vVgEXt0IGMWngDY+hFCgNtxPkffFbUX3OFWkCearvtxWTA6ity5xzldzz5J
         EC1Q==
X-Gm-Message-State: AOAM530xBdtuTZzHQg0b3MaMY8AZGpWAPB4Yo4lmPYFoxeT/WVIkEK30
        3EC8NSqWjGOLFw4dIfXY1YIv8SmpenU=
X-Google-Smtp-Source: ABdhPJw4uATB4T3ljkm8IHypxGM6vC90CK1w2cyzZ9mP9HFi2aLyFQQnO5l6BcHLW9cKMEqdtwCNJw==
X-Received: by 2002:a05:620a:4503:: with SMTP id t3mr8703787qkp.525.1642959080738;
        Sun, 23 Jan 2022 09:31:20 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id j19sm6265342qko.121.2022.01.23.09.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 09:31:20 -0800 (PST)
Subject: Re: Some sub-commands can't be completed by TAB key.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
 <5373af01-eeae-fb66-e9f7-41f2a022b275@kdbg.org>
 <CAGP6PO+GMi6jqRZ5HWxES5GDYkEDHoXOOZ+VvDkm0sC4nxkT4Q@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <5a30ac1f-d414-0976-cd08-7b059117af41@gmail.com>
Date:   Sun, 23 Jan 2022 12:31:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAGP6PO+GMi6jqRZ5HWxES5GDYkEDHoXOOZ+VvDkm0sC4nxkT4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hongyi,

Le 2022-01-22 à 19:38, Hongyi Zhao a écrit :
> On Sat, Jan 22, 2022 at 10:47 PM Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Am 22.01.22 um 09:42 schrieb Hongyi Zhao:
>>> I find that there are some  sub-commands can't be completed by TAB key:
>>>
>>> $ git <TAB>
>>> add               cherry-pick       fetch             latexdiff
>>> [...]
>>> As you can see, there are some sub-commands which are not listed in
>>> the above list, for example, the following ones:
>>>
>>> $ git ls-remote
>>> $ git ls-files
>>>
>>> Any hints for this problem?
>>
>> Tab completion is only available for user-facing sub-commands
>> ("porcelain"), but not for sub-commands intended for scripting
>> ("plumbing"). The intent is to make tab completion more efficient during
>> day-to-day work on the command line. For example,
> 
> But there are so many git sub-commands, so if the plumbing feature is
> supported, it will facilitate user to check the availability of some
> sub-commands.

If what you want to do is "check the availability" of some sub-command,
you can simply do 'git <subcommand> -h', for example, and see if Git recognizes
the subcommand. 

If you mean discovering Git commands, you can use 'git help -a', which will list
all commands, including pluming commands.

If you want to customize the Bash completion so that some select plumbing 
commands do appear in the tab completion, you can use the config 
'completion.commands' [1]. Setting it to "ls-files ls-remote ls-tree"
would then give you your desired output below.

> 
>>    $ git l<TAB>
>>
>> arrives at
>>
>>    $ git log <cursor here>
> 
> I see the following:
> 
> $ git l<TAB>
> latexdiff   log

This would mean you have a 'git-latexdiff' command somewhere in your PATH.

Hope that helps,

Philippe.

[1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-completioncommands
