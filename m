Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB5B208EC
	for <e@80x24.org>; Tue,  7 Aug 2018 07:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbeHGKDh (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 06:03:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33390 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeHGKDh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 06:03:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so7459710pgv.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g0wNlGGibkmpS/5727uoCtvwgaLmdnjcaIGtyZNbmL8=;
        b=trg9W0mv17XsyycDJMKUTysgtaq7gEqWo/q5SIfJz6eiWiXvFkOXHpTXcYnGUgk9i9
         eI6Fpd2GqdNP+v5yXkIXHJ7mfTbqd6XztolyFKqkqPI4g0ESQDcYxoKiSLZ8/yY5+JJc
         9cvYm5dkoZ8TJNf67Wa80LBY2VPOHA0Hszp9xHGgytp6Z1IWgzkyjtPldshJz79mAAth
         z7MG9SUOaDbP7BQ7hbWYEe8msZCtzAPU4ddVsr4Z0j7b52xooEzKI5o32li7Kjb8CNbi
         yzZpZSirrFgKtg3pkBNq8yJuXakHv7cHBfqqUpsVrDmvsVAdnaT5y7VphRQjPIPgmWYp
         nAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g0wNlGGibkmpS/5727uoCtvwgaLmdnjcaIGtyZNbmL8=;
        b=Jw2FwXsV3waCbUov/mz5vQS0QFSnegyQS8F+0yse5Tc67RREliTFxQ/4wazptWwsWC
         YmAl8t7qK3vhkoea/ncpf9jSToBO4W559q74pzr88vmF44uw4CwzGBK3Cf9jRP+L7Rt/
         qxRt3P7lMKCoG7V20mVC/nUDvv25VAx3fY0dxvBSBwOsuwc+GFsX/7Vx2UpDcoTvoX4j
         lbMQE8T6PpJ5hsP/uzY9EGU4KHP5tSBEl/BxC4jikR+koFgc0FclqOE8Si2CxFsEoNr6
         ScbyMshjKCN7WZEp0gfUVgGjWeVWRhiHAUh9Ha+XLnZtl9oXfXKX95eQkRF3T/y2X3lU
         VB+Q==
X-Gm-Message-State: AOUpUlGgVq79Ab1prldcXDYtEQLL5o2sZIxoE8JBhY7RrcCphCFlMI5V
        vtP+EYIgoiycwK7NSO1HLDjL2996oZcwphmWtHE=
X-Google-Smtp-Source: AAOMgpcpZq4q0LBBXRM8taHsIcAT9JbQgWDYPIClfmuV/d2xKaIvd1kNp9VvHys/cq9cRIF/TSQL+5MKN2JrXXCNSOE=
X-Received: by 2002:a62:43c8:: with SMTP id l69-v6mr20797801pfi.196.1533628231280;
 Tue, 07 Aug 2018 00:50:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:3541:0:0:0:0 with HTTP; Tue, 7 Aug 2018 00:50:30
 -0700 (PDT)
In-Reply-To: <20180806152524.27516-1-newren@gmail.com>
References: <20180803231407.10662-1-newren@gmail.com> <20180806152524.27516-1-newren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 7 Aug 2018 09:50:30 +0200
Message-ID: <CAN0heSqNFJm7cJ8SpTXLVi_0CFR5fphAT0D34a1k5i8d5T9E_g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Simple fixes to t7406
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 August 2018 at 17:25, Elijah Newren <newren@gmail.com> wrote:
> Changes since v1:
>   - Simplify multiple tests using diff --name-only instead of diff --raw;
>     these tests are only interested in which file was modified anyway.
>     (Suggested by Junio)
>   - Avoid putting git commands upstream of a pipe, since we don't run under
>     set -o pipefail (Suggested by Eric)
>   - Avoid using test_must_fail for system binaries (Pointed out by
>     both Eric and Junio)
>
> Elijah Newren (2):

I'm not sure what's up with the count of 2 vs 3.

>   t7406: simplify by using diff --name-only instead of diff --raw
>   t7406: avoid having git commands upstream of a pipe
>   t7406: make a test_must_fail call fail for the right reason

The subject of the final patch doesn't quite match its content anymore.
The problematic test_must_fail is dropped, so it can no longer fail.
Maybe something like "t7406: fix call that was failing for the wrong
reason", or just s/test_must_fail// in what you have.

Martin
