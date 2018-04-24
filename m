Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E0D1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 02:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeDXCJm (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 22:09:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42570 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932816AbeDXCJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 22:09:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id s18-v6so46210040wrg.9
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 19:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oSnZetND67lhiqSQQq4/DXVPhRrKGRiZsi/3qfKp//I=;
        b=Maoh67PucKQYeCnZFUYbOERihQMfLAU6BtukM9XJWsBUtolbwV4fspn1XR2lAaHOUt
         E297PzMesTReRPZUvKDIXeKeuNU5khU05dXAl5RK0rxUQCwDBo8kUc3CjtHEmqDiM62E
         JxSlLkBx1eh6TC7wFtSjF+1dA60gxlcdiKWG7FCADl4GmE96HY5FFVuhBqopPJMSaOgg
         P3KeummvEXT/dRe0m5VuMCFcBE+3V8wAN/cs11zDheqOr8ao6V8GGF9Q2STRSFhY6APU
         at/gTu4o54KAnJ4lpQT+G8VGRmP2SlfPygxAzkLPhGJBfiYYGZecOB7lCGFLDzoltnI+
         WaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oSnZetND67lhiqSQQq4/DXVPhRrKGRiZsi/3qfKp//I=;
        b=m+OMOl5xa8KdXKgelpaqaH7Ehe4F0fYaAQ0dGjxnr4hv4/gxIYrzX+YQN+VQsPGuca
         3foPsn9D4P3U6JqxcvvLK89v569c9kcHBe7q2liD8XzPE2sY91YmAp3E82Txt/m2hjfc
         LF+rCbr72jMqJA7WjLKTY5siLgSa5cvhEFMEcKKA42ZKX/sO3bs9VgeWAFqu3DojdhUv
         9qpjS7dnqeE8cSCovx8drHUuhn7nnRIS0ZrLTtUmCNsenm9UmLfmuiUastxusOmnCZch
         yQALs2CQ5fpqP/A+T0SZrleUPeJalPAVbcom1DiLvp1ci30a6EIc1Qj4gCBQMQkhHUiA
         8j0w==
X-Gm-Message-State: ALQs6tAGlwWPq5oSXPmTGfbepFbag3KEtkP4aPHHqJeW7wPy+RcdJD8H
        5cfav8KNMjUYoaIkre3nFr8=
X-Google-Smtp-Source: AIpwx4+RNsL7MeiYMClDKSxjHKOi+lTZJxbsk+hszrHzsc/6DkvWykXxX3s+OMEa7uZVg6acnV0nZA==
X-Received: by 2002:adf:bb0d:: with SMTP id r13-v6mr15440926wrg.201.1524535775838;
        Mon, 23 Apr 2018 19:09:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 16-v6sm3026929wrt.20.2018.04.23.19.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 19:09:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH 0/3] Colorful blame output
References: <20180424000900.175235-1-sbeller@google.com>
Date:   Tue, 24 Apr 2018 11:09:33 +0900
In-Reply-To: <20180424000900.175235-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 23 Apr 2018 17:08:57 -0700")
Message-ID: <xmqqmuxt73tu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is a revamp of
> https://public-inbox.org/git/20180416220955.46163-1-sbeller@google.com/
>
> Junio had some issue with that version, as it would collide config and command
> line options. This is fixed now by introducing another option.

Heh, that sounds as if the series was rerolled unnecessarily, only
because I had unreasonable complaints.  I was hoping that issues the
series had were fixed, and my involvement was merely that I happened
to be the one who pointed out first.

In any case, will replace and take a look at it.  Thanks.

>
> Thanks,
> Stefan
>
> Stefan Beller (3):
>   builtin/blame: dim uninteresting metadata lines
>   builtin/blame: highlight recently changed lines
>   builtin/blame: add new coloring scheme config
>
>  Documentation/config.txt |  27 ++++++++
>  builtin/blame.c          | 129 +++++++++++++++++++++++++++++++++++++--
>  t/t8012-blame-colors.sh  |  48 +++++++++++++++
>  3 files changed, 200 insertions(+), 4 deletions(-)
>  create mode 100755 t/t8012-blame-colors.sh
