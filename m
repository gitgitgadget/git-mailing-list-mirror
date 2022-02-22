Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C3BC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 21:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiBVVYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 16:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiBVVYh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 16:24:37 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABB7C683D
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:24:10 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id o5so3021517qvm.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wWcC8MTej79Rm5DCyNZaDkUZ6SBgwvRrZC2OxgWfphQ=;
        b=OtZeognlHG6FLguHtitvgvjCqs71aONZ3as+6ZEgjAGc7AO/sFKzTA5laoPQ5QnLYM
         niwVEZSktJosoUDrGBxulDAbMOsiyy/1ltTUeCcGYixD2o4M8MAasEFzI4sxJ5rZNyFq
         Mogu0HUGPzLcwd8KeCWXobjzAO0J2geOguyuVfvKkzWTy/pSn/j/n2v494UyG2ylFUMd
         xDBHbykIHaQa4mE5zZq23bZn3qhny4BN0C9TcQKgvVDKnro1TBeobcZz3dnQgnsMHGD2
         VP2QS7Jwp6rMRKr0R7qOQFo8FQDqgTZHasYVyynJNajOPgZJx77A1NKKB4nUydSTVHS+
         R2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wWcC8MTej79Rm5DCyNZaDkUZ6SBgwvRrZC2OxgWfphQ=;
        b=r9/DVAUnVQ+SOz/VGXxCxW2PMFiZFARbyHGdAmmgAx82crXdtxnxCiN/1lZTSquGh+
         A64IQF3MBmqWJLglLuZrsXj5TFDoUsknx2Ijq07GC57940M4Kzmf6L/YBcf7MPmrrZ1v
         RrMmWauAR/fTVjlOeu6Zztc+tq6VtD7gyxXxdH6raMr9TL+25w3mv6NCnUEUNUYpk0gs
         LpT9t5VUkH/PdPXtkDMDLYrIprTOidthjrsj/woR5ayJrk3mstcEvHlLmJyfx1qES9i3
         +7zgtggC4MOMYXbTkK7Ccc8dGLNhOHNsi7xQQ6Ek9Xc1VdX2hhco0CCNCipkiWLFQ/ti
         CuCA==
X-Gm-Message-State: AOAM530e2o8Hzw3w8tOHaQVYpdDAGzHMhniQHej0nJr6jmRz66sxPbmg
        wpbuJs0HhALEoIzyK0PvuEcF
X-Google-Smtp-Source: ABdhPJx13s9DmlIfsPl3Jw7eGjj2/4/CtRi7MlPl6MezXzqHB73z41bgLW3OJPphCzqUuIOBjXx4WQ==
X-Received: by 2002:a05:622a:1007:b0:2d6:5ac4:6b78 with SMTP id d7-20020a05622a100700b002d65ac46b78mr23949303qte.668.1645565050068;
        Tue, 22 Feb 2022 13:24:10 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j67sm496833qke.9.2022.02.22.13.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 13:24:09 -0800 (PST)
Message-ID: <a55c22f9-fe74-c154-af79-91c87ae5ac8c@github.com>
Date:   Tue, 22 Feb 2022 16:24:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 08/11] worktree: use 'worktree' over 'working tree'
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com,
        newren@gmail.com, jn.avila@free.fr
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
 <65a0cd527118578c98a6862460caa86ecb49735a.1645489080.git.gitgitgadget@gmail.com>
 <YhU+V+k/tp5B+NEP@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YhU+V+k/tp5B+NEP@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/22/2022 2:49 PM, Taylor Blau wrote:
> On Tue, Feb 22, 2022 at 12:17:57AM +0000, Derrick Stolee via GitGitGadget wrote:
>> Helped-by: Taylor Blau <m3@ttaylorr.com>
> 
> One more small fixup, this should be: s/m3/me.

!!!

I don't know what was going on with me when making these updates
that I introduced so many typos. Sorry for that.

-Stolee
