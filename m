Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE181F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeHJAHm (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:07:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41417 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHJAHl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:07:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id q129-v6so6757200ywg.8
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6nEWn4jkFtt7XyJEmnqgBP1JFK4oLKv5Gg7kwynmNo=;
        b=LSE+vEE5c/LhZc27q4kiWcPUTQV7xgHzCbvqixiWt6sPhnqe4gDsmb+e4rhuehetos
         5VW4waJGEg7VgkIHl7WGRporoaDsSmSJyHXSmIvITXJ+BNRT0icUIeXayGaP/uyOHedU
         TJcls/FHRsHPhjbD3gN4MGWRNoxZjHO3gMcpWDiHxjWgv+ker+GK6qC4qn9qAYPzCs6p
         8g87VBHcEA+EyUAaqYMVxEroZqilvqq3OlHjJ7JWOLOwk6VYdaizaQsz5dyePbUgdR5m
         f1tfN1tucijYnWpuKdpvuq6q9p17APg49Tt2cGNORikVQO4UL5TUhI+sOvP9pcMiD3rN
         57QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6nEWn4jkFtt7XyJEmnqgBP1JFK4oLKv5Gg7kwynmNo=;
        b=of6i2Copjl3E4J+52fqHqnUj1ImtzsZjhv0JAYLKkfT9lzPZGOtFj+cyICYK5NE0wq
         zBe7CmH9EmGxID2P0u1vIodaiweT16Zz/C9EEcrQraI1Jn0Ya/uJmWUepZsNal7tTVXh
         lZYntfgknPZdN/M6IcZv0StZcukK2U/JA4Ah2wVqXp6wBHfAIoo/uIj4us4NENf+ofxH
         jlhnTnQgcbWzZCa9uZDoArkWe/s9YYslKtjU80iu0F1DKJrjOJ22FUQmi8cq6h/aMzSM
         s+lmNMExa2Quky+iP9LUBj1zuUfImkD6No09XiuaEO9qexPEfCO0vuTDdwamlqBNQV0m
         w/Rg==
X-Gm-Message-State: AOUpUlGfouflT/fzeKL1OL6OPDNTbMjAU96ac2IemEDQRPQivnr91gzu
        AOaRKFR2NchLMANmljF0PVv1VUp9ZVuFbMKyV9Y7Gw==
X-Google-Smtp-Source: AA+uWPwctYr604Ol0Dkbx0LIlGLWLWja35AlrR/hI0DX2tv97Z59WYAb1vA102CSamelR6vaqspc0PykbJWtwUDtJYs=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr2097775ywk.345.1533850856676;
 Thu, 09 Aug 2018 14:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com> <20180808221752.195419-2-sbeller@google.com>
 <xmqq7ekzb5qj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7ekzb5qj.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Aug 2018 14:40:45 -0700
Message-ID: <CAGZ79kZ-0R4qnZ7LMhncenOeoec3z+kNmt2_VqBKRiDXxKm6fQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] string_list: print_string_list to use trace_printf
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 2:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > It is a debugging aid, so it should print to the debugging channel.
>
> Who says?

The comment in the header file?

  /**
   * Dump a string_list to stdout, useful mainly for debugging
   * purposes. It can take an optional header argument and it writes out
   * the string-pointer pairs of the string_list, each one in its own
   * line.
   */

>  In-tree code may say so, and I do not think any in-flight
> topic up to 'pu' uses this to produce non-debugging output, but I do
> not think it is healthy attitude to assume that you can take over an
> existing function and change what it does unilaterally.

That is reasonable, as usual, and given the recent fallout of the
object store refactoring I have these concerns on my mind, too.

But for this instance, I do not see any risk of accidental collisions with
other series in flight:

$ git log -S print_string_list origin/pu --oneline
4f665f2cf33 string-list.h: move documentation from Documentation/api/
into header
d10cb3dfab9 help.c: rename function "pretty_print_string_list"
c455c87c5cd Rename path_list to string_list
1eb056905a2 include $PATH in generating list of commands for "help -a"
70827b15bfb Split up builtin commands into separate files from git.c
27dedf0c3b7 (tag: v1.0rc3, tag: v0.99.9j) GIT 0.99.9j aka 1.0rc3
8e49d503882 C implementation of the 'git' program, take two.

> As there is no in-tree or in-flight user, I think it makes sense if
> the proposed change were to rename it to trace_string_list().  If
> there weren't any print_string_list() and we were adding a debugging
> aid to use trace_printf() to dump these, that would be the name we
> would use anyway.

Good call. I'll rename and send separately (or might even drop this
patch completely; this patch is not used in the patches to follow;
it is more a "FYI: here is a thing that I found helpful for debugging,
unlike the existing function, which I found unhelpful and actively
harmful")
