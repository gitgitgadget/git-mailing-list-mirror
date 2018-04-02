Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B081F404
	for <e@80x24.org>; Mon,  2 Apr 2018 18:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDBSOB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 14:14:01 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46253 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbeDBSOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 14:14:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id d1so14965253wrj.13
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sy71toaqoJ4vp34xYQkAeHwmAk1dM2nQMhYIzouKgyI=;
        b=Of2K98X/yq/tJRzsLFtdIyoC93UycTW7aE0P863LllzxUPRqaQDaMOfbcql+DH0XTL
         Mo0y0ubOq+p/wxuwm7aaSrVQVmVE5WFhoTuRvAjAzfhwChvsdmHPegDjFv/MYZUByjCm
         RgGQ9kTvv4Gmd84Vp8wbfVgpuU/7XGWjQLycS/aXlf/5FYzq82YXPQ5rkf93wQXFc3/X
         TdRj3eoBUh5v4SU6VKIZFRVtuzsqJYgbjE3Rs/RMlP2b0JxX4YriQgspgU8FgWdBL4Od
         OzpNHEE1KZ5LHr9OVXyJzM66UHUQUmEsaCB7vYU4tyGrxPpAbYhhQ+hDuTJbxLT4IlDy
         SeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sy71toaqoJ4vp34xYQkAeHwmAk1dM2nQMhYIzouKgyI=;
        b=CAcH2hWMvUmummLJIkGlRyihnumU7JKCTMdPV0olp0tI76My/gwwb8+oqBjdEsUTkF
         xvVu0ORiZ5l47/6UjLJRjenpaAgGRUelFOjTYxdAYFUexmP4fFDC8vQynHnsZ9ue4d6N
         YAK0J3kaCJiWDL1oEv1MiQT4U4BaMyzfLVUn/kO2eEgrL2r+avkwtVsBgRQWOgtrM6UY
         lQCyXQbYWVwCFaUgc3thN0sHeLotlxrN5KyxqCTxDmrSyjuHRRNaYNQZLFE0c+I7lZVt
         i7tW8+GbR0Mk5sgEwbPwp5EBKTrKi1v+mt9bxd4B4OX1wfOtV/DAW3xXoH0F5GDqOL01
         MVIQ==
X-Gm-Message-State: AElRT7GRGXehc5ab0PDm1RqR+JNMXKv82sxt4ABLjiNn7plxstQSmAFg
        OSIi5ZokOgC290vPmhvx8nQ=
X-Google-Smtp-Source: AIpwx4+xSY4+hTKbwhRQePOhoo1Xs0KhoLzbYmu1m51aPGcfgsmQByjIgT3yS65gTcP2Pld78pxMYg==
X-Received: by 10.223.144.69 with SMTP id h63mr7143377wrh.218.1522692839067;
        Mon, 02 Apr 2018 11:13:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a205sm832617wmf.18.2018.04.02.11.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 11:13:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lyubomyr Shaydariv <lsh.dev@ukr.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] graph.c: log.showRootMark to indicate root commits
References: <0102016283000c69-b09d1499-8a50-45a7-9f41-01be648398bc-000000@eu-west-1.amazonses.com>
        <xmqqk1tpze1x.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 02 Apr 2018 11:13:58 -0700
In-Reply-To: <xmqqk1tpze1x.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 02 Apr 2018 10:57:46 -0700")
Message-ID: <xmqqfu4dzdax.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lyubomyr Shaydariv <lsh.dev@ukr.net> writes:
>
>> When log.showRootMark is set, root commits are marked with
>> the at sign (@).
>>
>> When log.showRootMark is not set, root commits are marked with
>> the asterisk sign (*). This is the default behavior.
>>
>> Signed-off-by: Lyubomyr Shaydariv <lsh.dev@ukr.net>
>> ---
>
> So the idea is when you have a history like this:
> ...
> and that would work well with --left-right automatically (as you
> would just do the same thing as you would to a normal asterisk).

There was some discussion a while back on making root commits more
apparent in the graph view, e.g.

https://public-inbox.org/git/1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com/

