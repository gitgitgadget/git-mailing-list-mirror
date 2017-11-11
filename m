Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1391F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 16:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbdKKQwm (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 11:52:42 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:56398 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdKKQwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 11:52:41 -0500
Received: by mail-vk0-f51.google.com with SMTP id g11so7829051vkd.13
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 08:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=yS71xLJP7dCKs1Y7inaPkas90AaiCwEPdSLUbI5tifI=;
        b=KE8HXmWurbgYfjIRxphhJl1CqkbzWimTElf3Y3/UECeUt5ZYMdA2JNWGyPLkKXL0C5
         JE9w4GIuaG+ly1VZrOwoakVppvkMm/g9nza9VHBxG/cDHS06hjz0d8rB4WCnBk9D41ry
         yTpzonL3LXLlL0phZ09VmqWX1swpofwmYFRvdKhFg4iv1Zacfx87CoBt/3gUQLbThYw8
         cNOHM9JFN7xHXeSbfMw7AT8a6fCWoR32fN1qcRZckwVaE929ROMu/cewrgUF6xY/uWaH
         axM0bZyyJiREfa88vu1jHgBwKJah7P9DAZYQuhZA1f1gTE5YHXbXOxtsDigj1AJk81ni
         DaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=yS71xLJP7dCKs1Y7inaPkas90AaiCwEPdSLUbI5tifI=;
        b=CxMXBJohF78mV6Ef8qQhtQcpT2vJh7kfg8DdFgrMP8USdFH3KDX8q2voa/wQ3JtRPH
         cDc4Ufp2iXkeQJQmyiFMZbM7jAcVcgHe3mzqN1OfQ8UMw9iGt3eOZAsAL6OBM/OVTvZa
         cyQD1URMPuBa+PZWzxx69YOLpAzEX33RF3WuQG59Tm0S17gvhVOw5300Hey4tPWQS35P
         VnoHlO5yD+WEQafGs6lKKRNnljPsfzMTbu1T1sxiPueX2MzUrITjql19ikLZQzdxufD+
         67P4xtbQovR8UoyLNXu7f/oSOiAvgJjQ4jAX5dZjBxRzjZWQ6lfFnpLuaGU1HPrwaQpS
         ACSg==
X-Gm-Message-State: AJaThX5+x/hejbJx9D2PiRc8rrEBsXGZ0FPur15C+j+q5FBE1s0JgMzM
        EY+sG1krX3JuhdwGco1EHUEchdYggS+bGRQ3Kfs=
X-Google-Smtp-Source: AGs4zMa8Yp4yGnTWkbW+Lzoon1hriW2ho3h4s4CDCf2dxqWDqi/LNa2M7/FErOcDEhJsWVUa98A5S/zFYb5QYZ3LxlE=
X-Received: by 10.31.238.138 with SMTP id m132mr3037248vkh.114.1510419160539;
 Sat, 11 Nov 2017 08:52:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Sat, 11 Nov 2017 08:52:40 -0800 (PST)
In-Reply-To: <20171110222156.23221-5-newren@gmail.com>
References: <20171110222156.23221-1-newren@gmail.com> <20171110222156.23221-5-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Nov 2017 08:52:40 -0800
Message-ID: <CABPp-BG+AzbR7K=qOGMHV=E_y7YL7son_+STAxd2-2t+qF+8XQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] Add testcases for improved file collision
 conflict handling
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 2:21 PM, Elijah Newren <newren@gmail.com> wrote:
> Adds testcases dealing with file collisions for the following types of
> conflicts:
>   * add/add
>   * rename/add
>   * rename/rename(2to1)
<snip>
> ---
>  t/t6036-recursive-corner-cases.sh    |   8 +-

The changes to t6036 were supposed to have been squashed into a later
commit in this series; I apparently flubbed it and squashed it into
the wrong commit.  Will fix together with whatever other feedback I
get on the series before re-posting.

>  t/t6042-merge-rename-corner-cases.sh | 210 +++++++++++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+), 4 deletions(-)
