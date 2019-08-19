Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D89D91F461
	for <e@80x24.org>; Mon, 19 Aug 2019 16:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfHSQJn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 12:09:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50505 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfHSQJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 12:09:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so82958wml.0
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 09:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4c9S9DuIyjAMBdX+xyJJO9FKvTfxA5+18YeHOlM+x6o=;
        b=IunDVCrhUWZIW6l1e31VOcofirAbTtvkz04SQjNF6pXmCnjaMe93Wn7TV4VFwHzA4y
         YzIyMfZbalSv/9/zhEOVm0yDgjzxWfDxDIqTDqzxo9CEEbMVpnc5Fn06P7T1SRVnA3RQ
         00N68/I5QjVSwOiYTRSns+4f4Idc1eltj14JG2+/vNt82Mx3WrQVaJQIXTpZy5jDtn1r
         3GAWCKL5M5q67G+OZ4vMB87FjcLDEdmOSxpNBPculYpJmVYay6ej0n8+JHHxVHEovD7k
         GV3neBEuu0N1t0p6CHz8x4PK+XpIVvUni6QaHSP9CLCCLuXZnTKBFPj3IJ3+uqA4Ytav
         pxig==
X-Gm-Message-State: APjAAAW0sJDwEZSfNF2jChkDQkdsMwpAhg8BzVBnHth2kyc0lmNaXI9p
        zDLV8ZntR9i0KlwjSv66vY9qJdKOeqkqBBJ2W08=
X-Google-Smtp-Source: APXvYqzGS6T/4x0wLzEguqXKs7QQOimwKUbA83XoFD0W32WcmSUlDfI8m7oskdG7t/Hs4DDp8qQ8U69ZJYEUo4Rq7Gg=
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr20823463wmh.129.1566230981796;
 Mon, 19 Aug 2019 09:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.312.git.gitgitgadget@gmail.com> <3c3b4599e5a82824fdaa88a76fccd7a57ca3c3b9.1566206300.git.gitgitgadget@gmail.com>
In-Reply-To: <3c3b4599e5a82824fdaa88a76fccd7a57ca3c3b9.1566206300.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Aug 2019 12:09:31 -0400
Message-ID: <CAPig+cS+Wt1Bskhj+3hTw=W56zXfZ8w-G4dXEmQr-BBUMpEicQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] sequencer: simplify root commit creation
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 5:18 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Adapt try_to_commit() to create a new root commit rather than special
> casing this in run_git_commit(). The significantly reduces the amount of

s/The/This/

> special case code for creating the root commit and reduces the number of
> commit code paths we have to worry about.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
