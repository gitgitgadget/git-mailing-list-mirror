Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF14C1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 15:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbeDKPvv (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 11:51:51 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33043 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeDKPvu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 11:51:50 -0400
Received: by mail-vk0-f45.google.com with SMTP id d201so1380992vke.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p41/2Kg/LtDNJaMijj+tZqQYUkMN8VSFsSuaahQgGw8=;
        b=P487/4ubaTsMWWgSq7dIxYKoqSSLfm5GVQUHGc6gBurgazqW9zzzO0eWwC3aaqMEmK
         ZO+jHR2gPfxurhY31g6qqJau+qi/1+jLAy4M71YfoECLNLC9Ji4XwFAynsM51TsGzwjV
         k+Ww0sRadFVp5aYnHInBPw840RWltbLsDMxuMfO40t5EnCQ/QKw8DWxGQ8tPzuWvTMYs
         XUapy9uaFyPXuAeOJGVVUCBtXm0bNfzRiuvtamvOVEd02Z6fjpTY3GcdqAvj5UQT8MqG
         R9aM8/3DJau003t/8LtO2gifQzBkLjwotZpdW1iYQZMip8+glL5qt+oKaxpWpArnecDr
         k7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p41/2Kg/LtDNJaMijj+tZqQYUkMN8VSFsSuaahQgGw8=;
        b=H/hS1mi7JySe12WQgbDJyy3mN6sFgB6WQGk954QURiehC4RJhf2I2OOPWXuuh9xFwa
         rNqnuYzWrrWl70656P48rBucypv+e6vsXHJ/jnq3uou//6Mt5uhRJTfLWI70TuzSFN1c
         DRYJzglSu2UXSCsg1V8MHZxb7CmIRdfIa0YXzu7/Qmgn01yfXOLvFUz0+P1gSLmDpRwC
         3EvNbidh/AFX+nvJ5zKW1u3J/Lfkva2y4FHOVR1AEukA6d7SD77Lv7u4SN3wsmljU8At
         kRo1S5yLhtPzzQD1cT6WweeHm4MD5AQgKdCSVMpTq3hjIqpSyGRDOxl/kaGptT2OE32R
         NioA==
X-Gm-Message-State: ALQs6tD1kiPWr9wCXEAH3vVzpwk+OQaYU1IbaYXa0lIrOIUbmjYlRc/N
        rEiWFzWFhWDpg1+Uysc5Mgcw6Npzw9JiYUd+v64=
X-Google-Smtp-Source: AIpwx4+/kadSarmtXWf42RzJQZsBlKD777nsHz/kTsvlc6uEZtHvPkTV00d+h62qwbl3mLsqHiaqJmrk/ajWYeJUhzc=
X-Received: by 10.31.115.140 with SMTP id o134mr3775263vkc.106.1523461909996;
 Wed, 11 Apr 2018 08:51:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Wed, 11 Apr 2018 08:51:48 -0700 (PDT)
In-Reply-To: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Apr 2018 08:51:48 -0700
Message-ID: <CABPp-BHL4P0RxQ6OAuDSev9BXVM0uKTYD3M4JGTQvSwcBv4K0Q@mail.gmail.com>
Subject: Re: [Git] recursive merge on 'master' severely broken?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It appears that a topic recently graduated to 'master' introduces a
> severe regression to "git merge" when it merges a side branch that
> renames paths while the trunk has further updates.
>
> The symptom can easily be seen by trying to recreate the merge I
> made at the tip of 'pu' 29dea678 ("Merge branch
> 'sb/filenames-with-dashes' into pu", 2018-04-11) that I'll be.
> pushing out shortly.  The side branch renames a file exec_cmd.h to
> exec-cmd.h (an underscore changed to a dash) without changing any
> contents, while the branch being merged to has made some changes to
> the contents while keeping the original pathname.
>
> A clean automerged result should leave the identical contents from
> HEAD:exec_cmd.h in :exec-cmd.h in the index, which is what happens
> when using Git v2.17.0 proper, but with today's master', there are
> content changes that cannot be explained--the merge is simply broken
> and worse yet, the command pretends that everything went well and
> merged cleanly in that path.  Overly clever tool that behaves in a
> buggy and unexplainable way is bad enough, doing so silently is
> unexcusable.

I agree, that is _really_ bad.  My sincerest apologies.  I'll dig into it.
