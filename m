Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5355E20954
	for <e@80x24.org>; Wed, 22 Nov 2017 18:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbdKVSGB (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 13:06:01 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33317 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdKVSGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 13:06:00 -0500
Received: by mail-qk0-f194.google.com with SMTP id 78so17889250qkz.0
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sIXS+yj1XR8/HrjFimYCby2los16NYIPaUW0pt6ekOM=;
        b=kMqpDhpKrcJ8pTWcqivSSX87Jb304U5SflFVl3gp5kmifP11qyZsYhlWTqTxNwTUDc
         4h2pOUe7oEu26Tdl5qePX4xJJscZYvZoSAgIE5t+9xvHdUuMMUADW8Uzt43Q6JZJXWuk
         pRNvgEKTAMDnBx3xRo39SPTlLtFubNkmMimS004oJpBEuuMz27FsoUqHbQ/A3ZvCjQ9k
         OoiTvlH8gctwd0xdX8d9YAC+uIh211s3wrff4JbYNiZObAkEIoIMX694/byrXeHexWe1
         2/8DQz9Nxs/ngs3z/ShihoMDt32mZqCbJNtPTVD5aIiiMm+xyYi1ZvyahQPTCAeqa0f3
         sifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sIXS+yj1XR8/HrjFimYCby2los16NYIPaUW0pt6ekOM=;
        b=ZQuBTGmYvFdJ/ucixpV6w23T9AbRZ/hhl1HfuevNvRNMMzziUgbauX3PlxoC4YMVwg
         d2SyxMkQKS7JrqCHDW8sln77BXeHiLb4zvh6tlB1muiLXwbjwPZ6adMVXDgKSB2wS1Oh
         0QLc71H1W+kVUo8H4kgGK4I1Q0HgLtZM4D42TkTAw8DIBimSlJ2JknMBjQp2ttf/+yY4
         S9fybNDNzpu8Rzcjr0W7Cb71VC5FMzg7ymqDgTTveo3xR7LpWE4F7ASGh79YhY9jvI97
         mh2ICzaiX1e/aOqbWx7LgiD07/760T10w2cOwemLefj6nkH3r4ym+k13N2fq4Nd2d2SW
         /AFQ==
X-Gm-Message-State: AJaThX5W9K9QDMum4g6gCT8fL7cHKYLxEYxAkNKSLsxe/X7KpPPsajJW
        AzhSXUACHbvJM5SsXZfjhiEyWbEPMV6wS8FwraRoFg==
X-Google-Smtp-Source: AGs4zMbxvRy9X+m28ARjwJ5exQ/9euuql8pkPVMXAcm2AMqwfBa6Azn1wLUBZmyGu2b5pelKM5eTJBWH7sP6oC0rjZY=
X-Received: by 10.55.97.209 with SMTP id v200mr35189894qkb.71.1511373959647;
 Wed, 22 Nov 2017 10:05:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Wed, 22 Nov 2017 10:05:59 -0800 (PST)
In-Reply-To: <fee60b19-bc8e-bbd8-9f5d-347b2f941b2e@gmail.com>
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com> <fee60b19-bc8e-bbd8-9f5d-347b2f941b2e@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 22 Nov 2017 13:05:59 -0500
X-Google-Sender-Auth: hYcNBTplFowfc6HEQxm6oHEsx3E
Message-ID: <CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com>
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 12:09 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Wednesday 22 November 2017 03:07 AM, Eric Sunshine wrote:
>> [1]: Excerpt from:
>> https://public-inbox.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/
>>
>> Other information which would be nice to display for each worktree
>> [by the 'list' command] (possibly controlled by a --verbose flag):
>>
>>     * the checked out branch or detached head
>>     * whether it is locked
>>          - the lock reason (if available)
>>          - and whether the worktree is currently accessible
>>      * whether it can be pruned
>>          - and the prune reason if so
>
> It would nice to see this information. It would be very useful but 'list'
> doesn't seem to be the right sub-sub-command to give such information. Maybe
> there should be a new sub-sub-command named 'info' or something to give such
> information?

I'm perfectly fine with having 'git worktree list' provide this extra
information; that was the intention from the start. The "quick"
summary of all worktrees provided by 'git worktree list' is exactly
the sort of place where you're most likely to notice something
unexpected, such as the missing worktree directory. And, this extra
information doesn't have to be noisy:

--- 8< ---
% git worktree list
giggle     89ea799ffc [master]
../bobble  f172cb543d [feature1]  locked
../fumple  6453c84b7d (detached HEAD)  prunable
--- 8< ---

And, the verbose case:

--- 8< ---
% git worktree list -v
giggle     89ea799ffc [master]
../bobble  f172cb543d [feature1]
    locked: worktree on removable media
../fumple  6453c84b7d (detached HEAD)
    prunable: directory does not exist
--- 8< ---

An "info" command you speak of might also have value, but that's
orthogonal to this extra information that 'git worktree list' could
provide.
