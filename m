Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D04AC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 07:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiCVHN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 03:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiCVHNY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 03:13:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0B4261E
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 00:11:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so14712043plg.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 00:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kMtqRrTTLfyRKZifejE3O81jssjW5KuF1ryrn7xWLgY=;
        b=Ao9avZjwBMzShuqSJfNyFNklOjQT63kjcdWX0rZgrTcMEpXKB/Y0vxftKKbrdJ57F4
         h5NnsL6Z5NfeaK+6QboQlEj0C5cDjl2UvuKaljHAUQF/cAzH0sg7dh/ZEVL6CWi0+yX9
         cj08ibbSXrGny+LKEm4EkDFnSSBsFPRNgfEY8gMCvcxsM0Rg/o0Ee2CPViJ9tep1/764
         WaKMY0EGNB8JUixk/j/2JQU4r3OMV/+2MNICy2/BT8Zvp39KHcqAuomgVnaddFtnq2ES
         fmFDgnGdao3IyM2GGN2lMOrsdoDWc0cx/cyck6GcKAAmyj27CZg5uSkK89wye8SRF85S
         os0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kMtqRrTTLfyRKZifejE3O81jssjW5KuF1ryrn7xWLgY=;
        b=OTmZSmDmwRCMn6iW1/FSfNLfZ1Vf8dK8Dm+92ycl0N32ofM6lv7NxPqEPKi71eedYM
         ZBdmMg+Gyy1FTJc2rJ266jstLHzu4bBY5KUkrB7E0Kk3qM3SMyRMOwZvT3oro6rkgVQ0
         wV0vyU3D6y20yPIEI2aTUeNMVVpyM3+EEDUn8DntNsZX58IVgIfpZqMa+Tw+q5wCy7Pv
         zdWuu0ELi2tmoJPUIj58TLeK9nSZo4N87ZVlVNtPuBpcP0gjcuHaP312YcAGEb+57uCm
         ZaM8j2cLB49jnnR2EKsxOnhFZr9jqUsy5djqAarKltRpZHoJqjUa4AI0OetSiBRJCR9w
         VzkA==
X-Gm-Message-State: AOAM533Z+hb5eYv46QvXjUkmZTqCPscqjVMQ6GYY6Jkm54+xCZ4eZ0d9
        3wKaqPiOA7LoihgCSHyCAcJfADe7Ztcd7Q==
X-Google-Smtp-Source: ABdhPJxaktHURULrdHZEgD1wz0tyoIVjTTDuqdvsgT4T0hyniAy+uw2VKkVPT+pTcutNaJ0JvExEBQ==
X-Received: by 2002:a17:90b:4c44:b0:1c7:1326:ec90 with SMTP id np4-20020a17090b4c4400b001c71326ec90mr3275810pjb.87.1647933117588;
        Tue, 22 Mar 2022 00:11:57 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-49.three.co.id. [116.206.28.49])
        by smtp.gmail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm7023006pfg.89.2022.03.22.00.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 00:11:56 -0700 (PDT)
Message-ID: <93d4b801-491c-694e-704c-fbe68f90b660@gmail.com>
Date:   Tue, 22 Mar 2022 14:11:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation: simplify synopsis of git-repack(1)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <20220312113136.26716-1-bagasdotme@gmail.com>
 <xmqqsfrlvfs8.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqqsfrlvfs8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/22 02.00, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> Simplify SYNOPSIS section to only mention [<options>...] placeholder.
>> Redundant options list can now be avoided for aesthetic and clarity.
> 
> The "git cmd --help" output is meant to be readable and useful, so
> clarity is good, but I do not know much about aesthetics.
> 

Sorry for the long delay. I wish I could just say "for the clarity"
here.

> More importantly, the above does not answer a lot more important
> question.  Is it just loss of duplicated information that this
> commit brings in?  Isn't the motivation that "not all options are
> listed in SYNOPSIS section, and/or some options listed there are not
> described in the body text and are not supported"?  And instead of
> trying to keep them in sync, the author chose to simplify SYNOPSIS
> and have readers look options up in the body text, no?  These two
> would make a good pair of "what problem do we solve?" and "how we
> choose to solve it?".
> 

Indeed not all options are listed in SYNOPSIS, and in my previous attempt
at [1], I followed suggestion from Shaoxuan.

>>   [verse]
>> -'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
>> +'git repack' [<options>...]
> 

> Unlike commands with multiple "operation modes", "repack" does one
> thing and only one thing, so a single-liner "git repack <options>"
> may work well.

OK.

[1]: https://lore.kernel.org/git/CAJyCBORGGbn6d5UYMdRnfrbn9OONcgMMxaCyJ4qUoQY3+s8-uQ@mail.gmail.com/
-- 
An old man doll... just what I always wanted! - Clara
