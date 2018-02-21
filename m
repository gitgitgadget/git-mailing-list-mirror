Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65C61F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeBUS6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:58:48 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33115 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeBUS6p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:58:45 -0500
Received: by mail-wr0-f195.google.com with SMTP id s5so7450546wra.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TFjq/zgk/ooVyZFFASiWXZuHlB6uuJ5nBKB6Dvyzzl8=;
        b=TLMl9oMcqVdV6aPAUJ9coiP+4IAC9NtUzO00FDiNFwx1090lAPcLXWefRva1AURMf2
         t6CWgn0q2yMcr1cP+WyCsJPtKnRUuZlURoMoUxFCR+XwWLuHaVHG5nT5JaI/UyMq5c1Q
         TSPUMIdqqLuVv1sR2oIutazixyD2rn8Kr9L41O8SWqqoJXxvy0DN/9eDlIUR4+UnH5aW
         seshqoNOW9XYqnD8JbXHLhSTMDPKryu9VtezJMy4qECDRcGPqLR4vQFFmxm+eU37oED3
         EFC7mjbyIS03ODm0qvFeoolURFqpaOuu+4R4+0EQmwrse61AIjIukc6xJQnzwC8JhQ2L
         CUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TFjq/zgk/ooVyZFFASiWXZuHlB6uuJ5nBKB6Dvyzzl8=;
        b=iW1RFNYd78msT7ww/fBNOek+3gwMFAVVmSkL/pcb5hfL3Gmdafi0PEZeNLvuQWRnAv
         3UilraLau1as5wVScKHvoVPIeBBrWdNariu3zDr0hXwwBYbW7AKiR1PhvMcRD3kC41tj
         ixUy0Zg3i5tgA9LaWnr+ko/y6Tsr96/Uo5Q1Z8R8JT7fYvpy7ckkFOG1n7hVl07/xsNS
         BOjtN+uA/XyZf46pPErxqfrLCauQ4PiGtjD3cTaMTXVgsiIPQnJGF6EdrjNTVnVXSAIq
         xinj+LSIfyGil3doBDjYbq88wrPKtorCkpX7XQzEQqRkbEtftzdx0v31MlzkOihdBaW0
         v1Hw==
X-Gm-Message-State: APf1xPDQmNtTBy4YiqFLH5LXwHbYJUywGgyu60DNnVx1DU1KvKwBKix0
        qqnol0adr06hheW3u9TzVUg=
X-Google-Smtp-Source: AH8x227QMzvXNamRtynE4DVijIoIG4QmaXDuAH0dYOqLVlUiEyx1VQ2tTs819yvyWo0C4wl1GV7w/g==
X-Received: by 10.223.176.151 with SMTP id i23mr4004229wra.234.1519239524212;
        Wed, 21 Feb 2018 10:58:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g52sm3435605wra.20.2018.02.21.10.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 10:58:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 03/13] commit-graph: create git-commit-graph builtin
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-4-git-send-email-dstolee@microsoft.com>
        <xmqqvaer1ga1.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 21 Feb 2018 10:58:41 -0800
In-Reply-To: <xmqqvaer1ga1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 20 Feb 2018 13:51:18 -0800")
Message-ID: <xmqqd10yyxsu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> +int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>> +{
>> +	static struct option builtin_commit_graph_options[] = {
>> +		{ OPTION_STRING, 'p', "object-dir", &opts.obj_dir,
>> +			N_("dir"),
>> +			N_("The object directory to store the graph") },
>
> I have a suspicion that this was modeled after some other built-in
> that has a similar issue (perhaps written long time ago), but isn't
> OPT_STRING() sufficient to define this element these days?
>
> Or am I missing something?
>
> Why squat on short-and-sweet "-p"?  For that matter, since this is
> not expected to be end-user facing command anyway, I suspect that we
> do not want to allocate a single letter option from day one, which
> paints ourselves into a corner from where we cannot escape.

I suspect that exactly the same comment applies to patches in this
series that add other subcommands (I just saw one in the patch for
adding 'write').

