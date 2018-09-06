Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4A0F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 20:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeIGBPZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:15:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56068 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeIGBPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:15:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so12644091wmc.5
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vcikC54sHQL6ZkUjv08jm7s8/vGT/uFUEfzaBjqFJfU=;
        b=b+ajQRvPFMkWlxlZFplcoMEbjjfbwlIh4f4iXvSkGEBEWUeMej3lKs4BpI11LvaYwO
         NSiYD3PjXv5gzYl0vCPJvLfD3gFggWTSjqWTczACaxytYEKii6xcn0bmfZGrrsCVOhL2
         71HY7LAu9nOxe75cHQewp2wsFrEop4WVqEZs4eAUcvReoFENw9DEscsk+ZcpWg5m0S1Q
         LNuYsGo+1T2RA6D9UAc3gjBLQzt28xhOyL7JL/qFBYtKDjFzcQ5LF0XsXvdM1D6LAfQG
         baAUzfqn4Xu7/Ida8yDbA4SIT5WCIJsnXZO3aiZWMcX2d8UoBRNI7AzqMkXjfA/mLF1s
         r7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vcikC54sHQL6ZkUjv08jm7s8/vGT/uFUEfzaBjqFJfU=;
        b=kIr6Eeqwx9bAecL3wMXCSR7UgTNNimyyAisjS5mZiilS1uXp1S5yMCOo542m2tvvBF
         /Op5yV96RVR+aSxyrOblI93XlT3IGbeEhHJsyLuMksIjwxeID8Y0IBdBT8auv+BzK4F4
         b2lHB9Tj/QY+FKw33qVDKwuANh1Af2eeoHxTHzd4xFqYJxvMMfeds4eUS5a/1YETGv6G
         wxXHel0NWPeao0tf/mjXuadkIGAKT9BOWlngpgrJ9ekT43KIR4TgkMaLvXEQZQeK5KIy
         JsAVMFzGpSAuwfmDP47LDKcmf/kDpdzfy+5kXMbYfvBeLAI/UI93ajF2YYomWd5Qmjrf
         rM9A==
X-Gm-Message-State: APzg51DydEJNPFqzkMSpnuhUbbuUV/+gElGgAlXoSZK7qDheJq947glG
        DDC2kfcSUKvrAtbCIPF+MtM=
X-Google-Smtp-Source: ANB0VdYazFKNpI9XcxkIX6AdTgickNtjzvfpCyLY6x/GsR7flmCoUWLJg6oZ2jB9NYv/RSLg8+c2wA==
X-Received: by 2002:a1c:501:: with SMTP id 1-v6mr3470101wmf.140.1536266293449;
        Thu, 06 Sep 2018 13:38:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x16-v6sm7698092wrm.69.2018.09.06.13.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 13:38:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/18] builtin rebase options
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
        <xmqqmusuz9ql.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 06 Sep 2018 13:38:11 -0700
In-Reply-To: <xmqqmusuz9ql.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 06 Sep 2018 12:50:10 -0700")
Message-ID: <xmqqin3iz7ik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I've rebuilt the collection of topics up to pk/rebase-in-c-6-final
> with these two updated series twice, once doing it manually, like I
> did the last time, and another using "rebase -i -r" on top of the
> updated pk/rebase-in-c-4-opts.  The resulting trees match, of
> course.

Just to clarify, "trees match" means "'rebase -i -r' gave us the
correct result" ;-).

> I guess that is the answer to a question you asked earlier, which I
> haven't answered so far because I didn't have a good grasp of where
> my preference was coming from when it was asked.  Now I know, so...

In case the question was unclear it was "is there a reason why you
do not want to use rebase -ir?"

If "cherry-pick" did not lose notes, I would have preferred to do
this kind of rebuilding dependent chains of topics without using
rebase at all, but that is a different story.
