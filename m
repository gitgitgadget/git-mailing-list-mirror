Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E8A1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeDTTeS (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:34:18 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34095 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDTTeR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:34:17 -0400
Received: by mail-qt0-f193.google.com with SMTP id a25-v6so11078351qtm.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EzfH7igpRlsBFKBsVumIIUIZOz0/4E+zkrXWu8Q1EuM=;
        b=hEgCky9q4D9pikumsrOdRrPmmAXNTJA6hXM0WYPCU4Z49HdPfaIfKKfELHh/qo692n
         oFSbu7NeEVw2gHJQGKmMwXPn+K6OwrHepPKRPfW6bQQ33znO5Uspcz6HcXLn3y6hLSm6
         AUhJCjb0+YAoZyo3N1NMoNXqM/lxiQiq++OXQe+xIl22MhEj6KD+rgPCmD06QTdDOPge
         Y6eKvetx+nXrYCbpYiE+goXzjQ65m5BO/i8pGB9J//Ij5nA2EB9dEeZMa3TQSsSVYO+A
         Bfzgtz8BHgNF6hpvzlhJ4CXhiUdrxik2LRUF0Iemh7QXjSINkPONZgj4oxWoAfjpKSlx
         JQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EzfH7igpRlsBFKBsVumIIUIZOz0/4E+zkrXWu8Q1EuM=;
        b=Nv9AuVXmsplniuSats3ZB1E//i5ZOEcWJuGpYtqYbedRzkYLEKUiWyVOqdMqUgw8Fe
         UE0NwYIComdL4AOKJtlp/2YI7AN3xgVJUblLnvjKvO94CLXW4uU7v1WxU0dFHyRgIXd2
         SZqrM7DwAozRlpybn33DGpj22AZoq6LLEbMbWTCDWIPKTpBIclIFwLvqJypnPGkkztXP
         45GFSZ/9XS6BYrRlKpUgBEI68tkyFfLfqWBneAm6b0RDu3+IPFMr3bVIVkDsW9+Hf10s
         oEUPNHgdRLt5dJiD9uJc97dnjmZjijCIl1y3dsKKTkzxf3xGDAm/kgKJiZl4an6QnWjw
         0tqQ==
X-Gm-Message-State: ALQs6tAmMArmEZ4Is8M/0Ac70G9JtaY5dJTh2fj38N437OLe6vcnlzyG
        ZfHQYXcV8Na0U4O8tFhATkrbWp635AVIoyYxB10=
X-Google-Smtp-Source: AB8JxZpV29QKhdrO8jYAcZE2inMTrUnaaY3Lgkk2P26Syrk0CpCjfN1Cs2Aq5hdZAXMhxYqsbhBGm9f0PeELwHwxdEQ=
X-Received: by 2002:ac8:3267:: with SMTP id y36-v6mr12505671qta.25.1524252856750;
 Fri, 20 Apr 2018 12:34:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 20 Apr 2018 12:34:16 -0700 (PDT)
In-Reply-To: <4f87b8ea2c47b45107e2ba1cdd6d04a66fea0d16.1524226637.git.johannes.schindelin@gmx.de>
References: <cover.1524226637.git.johannes.schindelin@gmx.de> <4f87b8ea2c47b45107e2ba1cdd6d04a66fea0d16.1524226637.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Apr 2018 15:34:16 -0400
X-Google-Sender-Auth: xeRtnY6Vm45-j-2cfaHEey0ke6c
Message-ID: <CAPig+cQSbNVJgxa1VPnzOjQ2DkMAG36VVqnjg53CmC4wU_Q8AA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sequencer: leave a tell-tale when a fixup/squash failed
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 8:18 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> In the upcoming patch to clean up fixup/squash commit messages even when
> skipping a final fixup/squash that failed with merge conflicts, we will
> need to have some indicator what happened.
>
> As we need to remove the message-fixup and message-squash files upon
> failure, we cannot use those. So let's just write an explicit amend-type
> file, containing either `fixup` or `squash`. The absence of that file
> indicates that the we were not in the middle of a fixup or squash when

s/the we/we/

> merge conflicts were happening.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
