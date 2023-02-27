Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243AC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjB0S5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 13:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0S5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 13:57:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904A722DDE
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 10:57:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p6so6946753plf.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJBKNAS2z7XLaak2Uc5Sr75KQNWHwCECKHbgBNlwIqA=;
        b=NwI0oQhP2i7mK1W1qACSky85uFxxg7N4EvJ5pISyMlsqp5dPr2m9E7nvkxn3I6CibT
         ue2wCS0ak6ESlssjXbOsUVo7FhesH//fh9XBhTLvqM7uWEdEc5gHDN9mHpYVyCHkFip7
         D0JHRvSO2GyFbvVloyb64IAMDsiMR8dUyc8GooAw1UXfnm5CfkY6dI0cyrlCpBeukeSF
         bDl2rx2z04LdQf3q+osiGme7CAduLZhSx3UVm6t9SUpN7yrqQT+FuQ2lXPqDWNcDVSrU
         GqVy54DmQLeTJcwlyjZEvA9EFYyJROA79st6bEEl+xJ7nxKGDaqbEX+P+tB4h9yMpzkT
         9k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJBKNAS2z7XLaak2Uc5Sr75KQNWHwCECKHbgBNlwIqA=;
        b=1W3j0TVqn7QmF5QFsjjdpFiGm58UJ4QjhmtR5wSydHt80oyrg7L7MmtBP2SwHubfvO
         1RyGg/XaYnc8EZiUYK8s6z+i8X0LcSBxHTt8liKop8B9wiLvOiolqH960Ul0KjzpsHzD
         xnU1UjRBZnxFexWf081uKaOB8vr2QLS/aqFTpOmK5mnr0LrcCPXtn9reK985q7Y7i5Dj
         rehnJy+jfnOH/GluzfvWc5dhAaLaESdDtGdI8DhW08qP7aP978KvtHdJaeDVvax8q4C0
         IdiIfadSaXPBCI73gTEpNuusZO0WDT8j5Lz4hqhqyJ+2bnFe5fpoSOaHC2iTHnAjeV/T
         oT2Q==
X-Gm-Message-State: AO0yUKX8yDPl447eKjXWYsdm6Jt0oBmQSL9oTYjMTiVzY/te5rZTr5Ca
        Si83bBMNFDwR/yr6yEWTEH/++XktvoA=
X-Google-Smtp-Source: AK7set9Iy+xAAjhEdumjz0hg2uTF5030y1795Gh+bsSY0/DoshyDqz4qQH5G7wkQCmRgJEux0eaOZA==
X-Received: by 2002:a17:902:e842:b0:199:2a89:f912 with SMTP id t2-20020a170902e84200b001992a89f912mr33257651plg.20.1677524254977;
        Mon, 27 Feb 2023 10:57:34 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id v24-20020a17090331d800b00192c5327021sm4972525ple.200.2023.02.27.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:57:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2023, #05; Fri, 24)
References: <xmqq1qmeyfps.fsf@gitster.g> <20230226081545.M216523@dcvr>
Date:   Mon, 27 Feb 2023 10:57:34 -0800
In-Reply-To: <20230226081545.M216523@dcvr> (Eric Wong's message of "Sun, 26
        Feb 2023 08:15:45 +0000")
Message-ID: <xmqqa60zszq9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> [New Topics]
>
> Any feedback for <20230212090426.M558990@dcvr>?
> ([PATCH v2] fetch: support hideRefs to speed up connectivity checks)

Ah, that one slipped through the cracks, it seems.

Thanks for pinging; queued.
