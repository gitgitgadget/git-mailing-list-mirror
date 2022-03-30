Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39F5C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 18:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350376AbiC3SsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350667AbiC3Srs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 14:47:48 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE88A55AC
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:46:01 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id kd21so14652872qvb.6
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+8XQzZffecRtOUeQpznh+0KndrhvI9sceZTSFBW92k=;
        b=McIPwBvdzXiGDm+5UNZkPzWFyB/rHUHXK40XkaW5drZ9e5PH2OBbFuHUegmWMJiXeA
         OqSVX/c0jmih3F+EOIPU6y7o5E4QCtFj4arrFPbdgovISWKoabDZu8fzXnkY21yxgyTo
         fhN/yZEYG/li8vCfCceppLZSdYTl+M/Fq+UBn1sg4dybrCQdPq55WjogzxQGA/lHPtm7
         tegD4SNOCGqPOXmL5smHio2KkpWO1fHm9Q/hH8f1V6P0MK0xdYgbGO845RLiNEnBNhW5
         0kqC5+Y/EL728GNxu/KkhEVSXtNAcLYg8HPdtmPzzljdHFV6YWuo7hpQa0ksRP5AAfvU
         yaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+8XQzZffecRtOUeQpznh+0KndrhvI9sceZTSFBW92k=;
        b=hBHOrn2juYk4zoHg1fbrudEE0qa13yHy4QDfH4BM10e7uy21Yf33ikksPA3unQfXxm
         UNfkK0u+g2K75jhwOM35maQNaQzyROAsFY+KSkA/73fRJqRXcuQ0WSAMM1ewirGCTwdE
         CyEj+WBMY2CaIKUGFL/Qa89pQ0u08oVEo56qKEO6BbXii01pokQGdJcCM9U6QdWtFhom
         6eU1i17IVfLVIs1sJbWm7DHEMETipVUQu0S9639q1ySLGOzUuWPsCPCuKb20SkesrUK7
         3U6GQg0VUfyjQjxPPcgBWcGOuI5x5GPBHuOdhJfn2mbAF3IOOg+mHwHJU6uYxzXpkxRT
         u8zQ==
X-Gm-Message-State: AOAM5331ysu6Daw5DEgdj2KjOzXG/iQlEXAo4LVXoD9ui27M8FsNQEAR
        uNZYl3ieI7285t0pTrY24Ks8ElVxB4UDRg==
X-Google-Smtp-Source: ABdhPJxqrZjxPpX8djcRLlryzQdWgJZpx1JM1mQUfSoenJ/dH8MjTV1jdyrKyOW8Pgxkq7/3b/6n+A==
X-Received: by 2002:a05:6214:c29:b0:441:2777:b8bd with SMTP id a9-20020a0562140c2900b004412777b8bdmr861018qvd.37.1648665961055;
        Wed, 30 Mar 2022 11:46:01 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id r17-20020a05620a299100b00680b43004bfsm10145003qkp.45.2022.03.30.11.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 11:46:00 -0700 (PDT)
Subject: Re: [PATCH v8 5/5] mergetools: add tools description to `git help
 config`
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com, rogi@skylittlesystem.org,
        bagasdotme@gmail.com
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220329224439.290948-1-greenfoo@u92.eu>
 <20220329224439.290948-6-greenfoo@u92.eu>
 <da6472b4-65e6-a3ca-8d8b-892afb6f0fac@gmail.com>
 <YkSij31hyi29g7v2@zacax395.localdomain>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <de847041-acad-2a01-6a4f-36ed7318e01c@gmail.com>
Date:   Wed, 30 Mar 2022 14:45:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YkSij31hyi29g7v2@zacax395.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fernando,

Le 2022-03-30 à 14:33, Fernando Ramos a écrit :
>> This commit is authored by you but is missing your sign off.
>> Also, I did not give my sign-off on this patch (that can't be assumed,
>> it always has to be expressively given).
> 
> I see, sorry. As this patch is a verbatim copy of the one you provided in the
> last message I thought it was not appropriate to put my name on it (as it does
> not contain any line created by me)... but now I know that in these cases the
> right thing to do is to squash into the commit being commented on and add a
> "Helped-by:" note. Right?

Yes, right. :)

> 
> I'll fix this in v9.
> 
> Just to double check, please confirm this is what you want me to do:
> 
>   1. Squash 5/5 into  3/5

yes. 

> 
>   2. Update the commit message to:
> 
>      2.1 Explain that the description is also added to the output of `git help
>          config`

Yes. For example, this is how I would phrase it, be free to copy 
(maybe as the second-to-last paragraph?):

Note that the function 'show_tool_names', used in the implmentation of
'git mergetool --tool-help', is also used in Documentation/Makefile to
generate the list of allowed values for the configuration variables 
'{diff,merge}.{gui,}tool'. Adjust the rule so its output is an Asciidoc
"description list" instead of a plain list, with the tool name as the item
and the newly added tool description as the description.

> 
>      2.2 Remove your name from "Signed-off-by:"
> 
>      2.3 Keep you name in "Helped-by:"

yes and yes.

> 
> Thanks!
> 
> 
> PS: I must confess this whole process of sending patches to the git mailing
> list brings me back memories from "Asterix: The 12 Tasks" [1] :) :) :)

Yes, it can be hard. I prefer using Gitgitgadget most of the time [1].

[1] https://gitgitgadget.github.io/
