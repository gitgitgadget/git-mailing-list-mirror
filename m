Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA91C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbiCJSTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245382AbiCJSTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:19:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033213CA26
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:18:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e24so9270508wrc.10
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RSIuwMQ9qIT+YEJS23dIK7H3DG9njdb8PytLr7z5C8Q=;
        b=AIO9LS2bUvinyQkRnLC4C7nRqbEVTrPfh2k+Dm4gAQSK9z/zR8fAIZTckN0kJIXdGH
         Slt9WN8uTQmadxZdMswrHt4rqBAdLcjr69H7yil1wKo4wYSxdnEir+WemJWswGiZ/gg7
         7ifDnviASAc7g8BSGuU2aHp3z/3Z3FtUJyTwp9ueGOo7Hno5YwuE1NhhZKubE9mm4AcR
         40E2TVcHm6pnMm0IT/FFk6P9Yv8gdXsbzyUxBT62K+UHJyWNk2O/Hvzix3FCmcXE9m5V
         BsSMfNQe05xTb8djtxkW5Mbb/tPbFrUrqciJeQBj9AryBxQxOhlHUBNJRIb9XfrutGDx
         eOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RSIuwMQ9qIT+YEJS23dIK7H3DG9njdb8PytLr7z5C8Q=;
        b=JwXq3As+yHLI4uSIb/6cND77OIiBfprrjPKBtoGLp2vc7DgDB2UYttbBsR7hJMgpBw
         55Nv8xOx3hD3+VFzneS7rIXvNGkTjKDttzP0a6Ugc4RTVrzVv+tFz+j6MKfTwgg+PN+N
         10TDgJ8MHBqm5voZg/z9T10oPX62R8gS3rl2vYvnPiR+dZYn8voBe4Ja/ebQ4XzcVbtg
         zvvpnBt7gJrIFZDyRrtuFP6XYeYO6JlNFsza3I3gexxcS+OMGtNV1xlfeamuUFbIOuX+
         JwrPnzsX3Wbsg/wpSDCWPNvWsEII439C2F7DB+yE9GS8ulwEYkrBXKBFGebxSozt0dpk
         nW9A==
X-Gm-Message-State: AOAM533ntdP/T9tt6doFNHeSq4qOtMvYDPU/NEPeNW/3W4QBdSEBRCV3
        g0lphu5p0uVtDyXgaD9YpiI=
X-Google-Smtp-Source: ABdhPJzuIAgiTq5iuOPjkx8pLkFvevAJkaCmVPeUMxWW4iNaWNWdCRjYESQyS83qAom/mexmTCS5iA==
X-Received: by 2002:a5d:4578:0:b0:1ed:bf30:40f3 with SMTP id a24-20020a5d4578000000b001edbf3040f3mr4498058wrc.669.1646936313185;
        Thu, 10 Mar 2022 10:18:33 -0800 (PST)
Received: from [192.168.1.201] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.googlemail.com with ESMTPSA id m14-20020a05600c4f4e00b0038181486018sm6061294wmq.40.2022.03.10.10.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 10:18:32 -0800 (PST)
Message-ID: <a1e51433-71b1-b32d-0475-192b83bac43a@gmail.com>
Date:   Thu, 10 Mar 2022 18:18:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] builtin add -p: hopefully final readkey fixes
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com>
 <xmqqilsmlo31.fsf@gitster.g> <xmqqzglyk89e.fsf@gitster.g>
 <93d197db-c52c-101b-bdb0-3b4c9b073705@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <93d197db-c52c-101b-bdb0-3b4c9b073705@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/03/2022 13:28, Phillip Wood wrote:
> Hi Junio
> 
> On 09/03/2022 23:37, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> $ git checkout --detach pw/single-key-interactive
>>> HEAD is now at ac618c418e add -p: disable stdin buffering when 
>>> interactive.singlekey is set
>>> $ git am -s ./+pw4-v2-add-p-single
>>> Applying: terminal: use flags for save_term()
>>> Applying: terminal: don't assume stdin is /dev/tty
>>> Applying: terminal: work around macos poll() bug
>>> error: patch failed: compat/terminal.c:397
>>> error: compat/terminal.c: patch does not apply
>>> Patch failed at 0003 terminal: work around macos poll() bug
>>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>>> When you have resolved this problem, run "git am --continue".
>>> If you prefer to skip this patch, run "git am --skip" instead.
>>> To restore the original branch and stop patching, run "git am --abort".
>>> $ exit
>>
>> I think I figured it out.  A merge of pw/single-key-interactive into
>> a recent tip of 'master' wants the "return 0" in the preimage below
>> to be "break" in compat/terminal.c
>>
>>
>>> @@ -397,12 +433,7 @@ int read_key_without_echo(struct strbuf *buf)
>>>            * half a second when we know that the sequence is complete.
>>>            */
>>>           while (!is_known_escape_sequence(buf->buf)) {
>>> -            struct pollfd pfd = { .fd = 0, .events = POLLIN };
>>> -
>>> -            if (poll(&pfd, 1, 500) < 1)
>>> -                break;
>>> -
>>> -            ch = getchar();
>>> +            ch = getchar_with_timeout(500);
>>>               if (ch == EOF)
>>>                   return 0;

Looking more closely that should be "break" not "return 0". I think what 
has happened is that I accidentally based these on an old version of 
pw/single-key-interactive which did not contain 24d7ce383a ("terminal: 
always reset terminal when reading without echo", 2022-02-22)

Sorry for the confusion

Phillip
