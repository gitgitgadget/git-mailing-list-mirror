Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6EF1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 19:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfBSTHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 14:07:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42801 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfBSTHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 14:07:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so9847364wrg.9
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NPQ4rTv8fQk+oLSAACmSqclYBFW2p7SsHYYmokVmkqc=;
        b=BUQgdWNF7fqTGGmUzgK8GCX0POK6HeeK5xuRWk4YmSdL5bptO5eU2BejwMnZeWY2M2
         REjXDB6/IbAIbttkWzrtUJr49PBNCiLsFrYRBbv/cdwuIpTkV4tv+pk6eGK+jLQiPmrY
         XcjIa+O+4Nwu9BO5m5KsFX6mTHolgElGztd2FgTwc9URe7uvGhBn72oFAeQV8JtUDu3B
         T39IxfqoiiAdd7fskk91sQW532lo4qAOaUd4yML1IydW03IoXgH+jw7dtzhD7Fj4MSm1
         8Ol1emSMONLgL6u2v7QBOh/h047W3ZXYQg8jgR7cNvcUP2YgsiO0fXPVM5a/5oVoa05f
         phNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NPQ4rTv8fQk+oLSAACmSqclYBFW2p7SsHYYmokVmkqc=;
        b=LTIIN33CEKZcVKxwoQ0TXtjH4fyIGv90c2oj6lr95wzjk/Ykvn9HHazzoTc7tLCUbf
         8FR4tAbU1SdPO3l5UaAnWc0AtIhgbPywAIigL9bcEBCF3y79RAt5UArfMCmrgb+mukY6
         NUwC48q7lmUl0enQg4IiWWSqVS3Ge580k15oyAKkhQaWIcAEmtmGWPQnfMN6u+WBUJno
         wMmvwa4Cch+So/KEOqKnhPMiUsOb1IeZlpdqTHa6CtCEfELM60I9V1GWiuKjCCvbvRhS
         /tFwbwUUwLHyJjBBZqMoXCGnbLWLc+EV/xsIGy8j72ca+zmZpGZHSJM6yy4sCs08KFw9
         hLsg==
X-Gm-Message-State: AHQUAuYR+ZU/E/6r4XFrWoC5NDpDjYKRAi2bpMhV/cli3tRIUXDmLr4Q
        8Z1Gr5YdMQWCvSgCZYyKEQw=
X-Google-Smtp-Source: AHgI3Ib2bLWGu1v+efjogE3DelOIpw9b2v5DhvgMDzSBi5e0FqSokdMMQZm8QzDH32dNhzFTgKvPRg==
X-Received: by 2002:adf:b601:: with SMTP id f1mr8010958wre.158.1550603255497;
        Tue, 19 Feb 2019 11:07:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4sm3638082wmi.3.2019.02.19.11.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:07:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
        <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
        <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
        <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
        <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
        <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com>
Date:   Tue, 19 Feb 2019 11:07:34 -0800
In-Reply-To: <CABPp-BGkJOgKqE_vHsA1fkjQ80U10Hv7-HCvScq7WOgj1UF9=Q@mail.gmail.com>
        (Elijah Newren's message of "Tue, 19 Feb 2019 06:42:29 -0800")
Message-ID: <xmqqsgwj1ts9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Overall this looks good, but there's just one part that confuses me.
> Here you seem to suggest that if you pass --source but neither --index
> or --worktree that both the index and working tree will be written to.
> Why are "restored" changes considered ready for commit?  That seems
> confusing to me (and was one of the bugs of checkout, IMO).  See also
> second half of https://public-inbox.org/git/xmqq1s6yezk3.fsf@gitster-ct.c.googlers.com/

As long as worktree-only mode does not lose track of a
previously-untracked path in the index (perhaps use the i-t-a bit),
I do not have a strong objection against making the worktree-only
mode the default.

