Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125EAC6FD1F
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 10:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCKKeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 05:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCKKeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 05:34:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88780115DFD
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 02:34:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j2so7232723wrh.9
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 02:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678530863;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PYpupYllZqV9YAvqf6YoNpLyfVEHUrU7nDEjUf1dzc=;
        b=hMnDrUl4cxgYGz9LUy6UTuwMHp4SA72qvs78iOCQLXRKkBK5RX8+sZUjDRqHkPKVw6
         pmI18ZoougKIM07ScNOxFtQhFiq3UYyqqPdXtFGaa3GL98CjqgUDfcr3Gc48ZWoxajb4
         lT4AEryZOcZw94rhjpHGIO0QoCeyMsdzOLh9qO4m8TDY22c2x840bnNOnwPWuNcKcoRO
         ysWEyWqeCZHUCrdgLgzBf7QbVXNy1tn7lgUWVjXUU0UN9khj5f3HJhDpC/SM69qrwXx6
         esjLdwNFqc0qBTftneu7rUIJ34ZrlTZpplZaGSO++gcwVYBVFL5XTgIqzjcAq2KsI0BA
         i7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678530863;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PYpupYllZqV9YAvqf6YoNpLyfVEHUrU7nDEjUf1dzc=;
        b=bNkmubJ0qYHbomLOha8t7Du+XMCb4XHNvKz52JeWz4XhYBa8U/ndckwJZEdnp/I9db
         /sLuydvFTv4cn1cQPaNltREeZIlEYO0eZdZDMvHcuenMULs9HkOo0xE5inPFE7Z9RIZ9
         NZ1EwPjOBL7NzxzrvqxTu6bteB6k0fukFDk2POQ3DpbduON2RNeWIfQGaJ8ZLyKlaAyI
         eqGmqc76KagO6KRCKPIQJhPVh/PBKPLNuKd+9RTkAt/TiQjXj3T9OcX5k49EnqqMt2b4
         ahLlnx+FwLlsctoId9QVGJ0xoO6E4jZG4A6UJdENuL6lVZIOrKLtP8dYlhfbAN7aOIUo
         fa7A==
X-Gm-Message-State: AO0yUKXfKarllJXnkHUROER7SqUs0J5WpUA4REc/iOqFXT9FyaqLzwds
        8VDuT9acLlHu9us7X4A2BOAAqfea1gA=
X-Google-Smtp-Source: AK7set/fUMk9j9vbOdc659UNgdys4xZ15aJhLovm6h6Eb0ZSGez7ibOB2s23/CpM81xo4d7tVcv2Lw==
X-Received: by 2002:adf:fbc7:0:b0:2cc:4d13:908d with SMTP id d7-20020adffbc7000000b002cc4d13908dmr18065212wrs.11.1678530862974;
        Sat, 11 Mar 2023 02:34:22 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6844000000b002ce3b31753fsm2125543wrw.26.2023.03.11.02.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 02:34:22 -0800 (PST)
Subject: rj/branch-unborn-in-other-worktrees (was What's cooking in git.git
 (Mar 2023, #02; Tue, 7))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4jqww660.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <877b6f9d-bab6-1343-42d0-3e17e3d0a9c5@gmail.com>
Date:   Sat, 11 Mar 2023 11:34:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4jqww660.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-mar-2023 14:25:11, Junio C Hamano wrote:

> * rj/branch-unborn-in-other-worktrees (2023-02-22) 3 commits
>   (merged to 'next' on 2023-03-06 at 6ee0ec72ae)
>  + branch: rename orphan branches in any worktree
>  + branch: description for orphan branch errors
>  + branch: avoid unnecessary worktrees traversals
> 
>  Error messages given when working on an unborn branch that is
>  checked out in another worktree have been improvved.

s/improvved/improved

> 
>  Will cook in 'next'.
>  source: <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>

This series needs a re-roll, which I haven't done yet, sorry.  Some
unwanted behaviour was introduced in the current state of the series
which needs to be reverted.
