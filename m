Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486B91F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbeHOUNJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:13:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36523 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUNI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:13:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so1961519wmc.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iE9fALD92E51AXQUYTpHJ7griD93L56Ch9Mkd7KCd3A=;
        b=PFNGLv/3qM/OtSVE74DWQLja+bPvn1354Gii5ZTY6iOQY16j4WU2mSUOSkQoSZv7UA
         D3oId1sJ//bkf6lcfHUyNTuafAPDhWWm0RuiLMzSyGohHk/M1ZBWMBuZ+d+mmycL4aiG
         I07NGMzIuP1Woh2cmb/U3LxllcLb8OjSK2aFATXyMIhFB0LrNvMAKg0rTXPy7rIs6Qb6
         0CsADyn+kRBqdBvyDpm3adUGb6wmav6YjHacrj0XSUJfBM96q86deaZLdKc1NCnS2HD4
         Y5Dt8j5zySxS9LmDZxZJa+hGlZVsGxlNhlb4GPkvdGknB/OoIvjfJX20Gc2J3muU/r/G
         qrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=iE9fALD92E51AXQUYTpHJ7griD93L56Ch9Mkd7KCd3A=;
        b=KSYtbgwTVV3HXiOo8jKxbF8UFMKX3MLMnGbVmR8uVJGq6MnRhYrz02ctehTfBfndFU
         nD+CCpSvJZ48PUrDzcIwAnB8GJq2ymJSWHa5rEYRz9nPOxOKBIfNGIt2l4u3gKZIkyFl
         sKER4RfLk+RNRuAZQ/GZNhXqSJx3kOku0QT+ZDMkpqUJBOxcMzxMIJO4hJgJUtZD2r2n
         Rb73xlHaCm7xZ6k3z7L8URzscMIaWKvni3vcA+Ll3t0/b6PZrAmk5krruvhR7N8TXe2o
         9+gbRE0pZrTnrzDRRvFbBFEGuxQJLnJq7vObtrSOefna0+5SRx5gjvgjx6/6gtOhKNHu
         CnKg==
X-Gm-Message-State: AOUpUlHnBoJMlcgDE6C7SMKtiSAVW3LSt1bnPhpwFHQUNROenv6urWFd
        nj7QxpZMPXrXfwQXRo9Ac3OuBW/1
X-Google-Smtp-Source: AA+uWPya8J+ErCnPcmfe8ua2E3qCzdqwxVIy9ajCpkjVv7AoHCHJoowYi7mO3gwGa1Q/93KHNOn+Sg==
X-Received: by 2002:a1c:8b86:: with SMTP id n128-v6mr12703205wmd.42.1534353605895;
        Wed, 15 Aug 2018 10:20:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m129-v6sm12806916wma.1.2018.08.15.10.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 10:20:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] branch.c: remove explicit reference to the_repository
References: <20180815162308.17747-1-pclouds@gmail.com>
        <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
        <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com>
Date:   Wed, 15 Aug 2018 10:20:04 -0700
In-Reply-To: <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 15 Aug 2018 18:52:36 +0200")
Message-ID: <xmqqtvnvim2j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Aug 15, 2018 at 6:48 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Wed, Aug 15, 2018 at 9:24 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>>
>> The patch looks good, but since this touches multiple .c files, I
>> think I'd s/branch.c/branch/ in the subject line.
>
> It is about removing the_repository from branch.c though. As much as I
> want to completely erase the_repository, that would take a lot more
> work.

I do not think this is about removing the_repository from branch.c;
it is primarily about allowing create_branch() to work on an
arbitrary repository instance.

I also do not think remove_branch_state() function belongs to
branch.c in the first place.  The state it is clearing is not even
about a "branch".  It is state left by the last command that stopped
in the middle; its only callers are "reset", "am --abort/--skip" and
"checkout <another-branch>".

