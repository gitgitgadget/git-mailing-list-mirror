Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0822F1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 18:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeBTSVH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 13:21:07 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38959 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbeBTSVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 13:21:06 -0500
Received: by mail-wr0-f193.google.com with SMTP id w77so17072821wrc.6
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 10:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=29Mp9gMkWMwU9tKtv7AK8j539LoKV8OV2fLpR34q7cc=;
        b=Knb+jYAVzh2pjg9HPNMIt3rmUyvXFlDXikMhLyYB0EIw6uNjFXHY2iJvoP/KrNPql7
         YSoiKUYtjvBrMw60SBp0WT5Ndrq7ArdA9BRqFDKFNaYCVKFWC+gJN48tH96mxFSvJIRu
         HNR/xjz4d1DRy2rVTel/bUYMbwKkDXV/LfpMQQDBp1DC4bZ0o5z7kZhnYGBUChGnQB6h
         WkEfrlIo8UTAee0kB3JQggFhboSp/Urwoir/3yEY/JxGShV+VHi1CG+xJEqE4/81flbs
         Hup3sXMgk/xQVU7Euhj6IpIWdCs+JoACvNoQPWSafuGjagAHCUml5+X131yHDm1ODqSY
         UVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=29Mp9gMkWMwU9tKtv7AK8j539LoKV8OV2fLpR34q7cc=;
        b=TcnW22WRdnGnDCW68U1dvM5iFUeyys+ckdJl2+1G4sUgtJbuxl0MBB2wznJYrNuM0T
         0CRzw1lyKNg9DiZsRlYrXhi1GivsdKzU+p2RjWlss7Vn70t5YX0yExJlxbMw/hz0s0sB
         3O2RL3c+X8hTioWsDNpmcZzhpZ485nRmBYheQljbY0y3PhKtpKzX+LaqOh3gfe2B9KhE
         uFMqpZqxAWqqnyZZfWoPHyYo8kjFvmtNqsQRo/4AvH36f4SMEakIQ3jJgQR0tymuohBY
         mXkv06fkAIFHaRCa4xEPBY/vY0AOifQBja5zg3Ou2nXkpFC8l55PpXpuxNk584P5ru7R
         1fDg==
X-Gm-Message-State: APf1xPB7rRnHp4eJsng+fQCzFSeeJOmJ1As26xIr3pVysGOfZSXpTMcw
        9XlAFtEIfM5Sk6qBBTvajPg=
X-Google-Smtp-Source: AH8x2262t5lmiX+6oVKKjR1yZF4nooZ/v1GHoFnf/bdveiAwDoi1gXHwHpqyMAoBpbOyEVTmT2iuBA==
X-Received: by 10.223.178.26 with SMTP id u26mr500367wra.63.1519150864527;
        Tue, 20 Feb 2018 10:21:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 137sm19929639wml.3.2018.02.20.10.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 10:21:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/9] add -i: add function to format hunk header
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180219112910.24471-1-phillip.wood@talktalk.net>
        <20180219112910.24471-2-phillip.wood@talktalk.net>
Date:   Tue, 20 Feb 2018 10:21:03 -0800
In-Reply-To: <20180219112910.24471-2-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 19 Feb 2018 11:29:02 +0000")
Message-ID: <xmqqbmgj4j5c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This code is duplicated in a couple of places so make it into a
> function as we're going to add some more callers shortly.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  git-add--interactive.perl | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 964c3a75420db4751cf11125b68b6904112632f1..8ababa6453ac4f57a925aacbb8b9bb1c973e4a54 100755

This is quite a tangent, but please refrain from using full object
name on the index line.  Because it does not add much value in the
context of patch exchange for project of this size to use more than
7-12 hexdigits each, the only effect of doing so is to push the mode
bit far to the right.
