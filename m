Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBCAC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 13:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiF3Nfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiF3Nfk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 09:35:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B202873D
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 06:35:37 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i3so1738444oif.13
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ralvS8GsbtiK+jf3v1e5FfVTPeog0u0txGx+Blw6LXE=;
        b=HLMG0qBNeRGVB2PI8fLp/ledfT3SxARzxRvUn3msH4U4aX3LBgJsY0C6N3fO6ovbYO
         g/WfbF3VBEh2uErZu/3SdNakHSI25piPltnZYqkNsF1omoHM9mqNJgdTOQ0lqu5Df736
         M9fYoF6WZnH23GjNBS5ZoJytcowhNt+V0DWUWmpk2gDFbk3Ylxvg4stAGJ5AyYunKwJk
         7r38EjKPoG0XEgY3+nxSvJi3pLu9cRsOicb3po+HPUvrkhEmfo1TdUcPNR2BqIqpiyMX
         6jjeqgSmsqiKTIdAEBGkGnTABrv7KxPVUcl0u+fk86csUCwReQF5yN2DMSZ9TRQcBt++
         hvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ralvS8GsbtiK+jf3v1e5FfVTPeog0u0txGx+Blw6LXE=;
        b=HAJlXAX21iQSk5vvOBfoUuIL4zAM74/1IJqlmQON3WYpq+Q0IAjr3PW57/va5afpVq
         ISwa1v/jXkMMaCh6eIkd7lJA86Avlujhz8JABQzDoR344Llac7mFUojvhqUL2QBNOCyX
         TNMCqHngsvHW4CZMOR28I9ddc5cCFo3wJPtDGgJXb+6aYPE79jI6dLDCIOtDe4EdSSap
         tb9JY8X1QWEkO3gRXk2Hc2b4EH/L8Tjie0z36VEFp+LwR8dLl1iye+mE6m8yXMQw5Om/
         6tM46V/djyGvnWk4ZmgunHdDdCT7/d93025/vw3So1LGeqU1wv6AE+vLCiVv6y+W/svH
         hyyg==
X-Gm-Message-State: AJIora/8nIJl4t5vAE1RDs5YQbbEtIl0QRvsPSx9LEW9bCEfb7WSDOn9
        +ccbbXC4Kzp+BRcneA/XRJJq
X-Google-Smtp-Source: AGRyM1v97jL7jNCpJi93YvLXYtHU5wIInR3aSbfXsfgkQUZS7KVfUr7dkPYibsOqArYWJjGTc8FVpA==
X-Received: by 2002:a05:6808:1488:b0:335:bd56:ec79 with SMTP id e8-20020a056808148800b00335bd56ec79mr3074366oiw.5.1656596136405;
        Thu, 30 Jun 2022 06:35:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:700e:35b2:9f26:ff32? ([2600:1700:e72:80a0:700e:35b2:9f26:ff32])
        by smtp.gmail.com with ESMTPSA id n2-20020a4aa7c2000000b00420c4e021e8sm10850442oom.38.2022.06.30.06.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 06:35:35 -0700 (PDT)
Message-ID: <b0c596d6-f4aa-9575-4d79-64bd112d0baf@github.com>
Date:   Thu, 30 Jun 2022 09:35:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/8] branch: consider refs under 'update-refs'
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
 <f27d563b-d011-9983-8f7d-52232b052608@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <f27d563b-d011-9983-8f7d-52232b052608@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/30/2022 5:32 AM, Phillip Wood wrote:
> On 28/06/2022 14:25, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> +int sequencer_get_update_refs_state(const char *wt_dir,
>> +                    struct string_list *refs)
>> +{
>> +    int result = 0;
>> +    struct stat st;
>> +    FILE *fp = NULL;
>> +    struct strbuf ref = STRBUF_INIT;
>> +    struct strbuf hash = STRBUF_INIT;
>> +    char *path = xstrfmt("%s/rebase-merge/update-refs", wt_dir);
> 
> I think it would make sense to introduce rebase_path_update_refs() in this patch rather than later in the series

The biggest difference is that rebase_path_update_refs() only
gives the path for the current worktree, while this method needs
to read the file for any worktree.

There is likely some opportunity to create rebase_path_update_refs()
in a different way that serves both purposes.

>> +
>> +    if (stat(path, &st))
>> +        goto cleanup;
> 
> What's the reason for stating the file first, rather than just letting fopen() fail if it does not exist?

Not sure what I was looking at that gave this pattern, but you're
right that it isn't necessary.

Thanks,
-Stolee
