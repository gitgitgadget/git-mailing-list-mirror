Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5391F404
	for <e@80x24.org>; Thu, 18 Jan 2018 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeARLAH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 06:00:07 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:40293 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbeARLAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 06:00:06 -0500
Received: by mail-pg0-f42.google.com with SMTP id g16so7207293pgn.7
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 03:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oxNwSE/tAoOM2dA+bcocLVSMzQS4tyXuyTQE/2RFoFM=;
        b=GJSaVh2vptJJYrJn8x3evVHDCs2R75hGtUxXkIupqViZtkR4uZJXtVDhXbmWwxxPXx
         XYJbwbrLdPry9BqDwjHovG7gerXFCl6AnlqJSHaspG3XJjITv+Vn4VlE7jTtSAtTZr/2
         A3eU4EdmgUzL94aOXu1iYjBc/O4JmZsZcrZ13sh6RpaTNwDTerADYm1T6Z4e4Vkjdp0J
         0WnpAi37Jjp/FamU+2K/hbZVAopPUyOs4AsqEMRBxsRx/eqfJTNUn2crl9j/WvwUFnrP
         Jhw7Iz4/dpV06ybnigI3/cadHo4xTq+B64RdaPHsa6nh9xIHJohF4D04wYZtbOfAGqj6
         DcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oxNwSE/tAoOM2dA+bcocLVSMzQS4tyXuyTQE/2RFoFM=;
        b=qvNuTmMjSslMiIQkUKHoMGsS8GYYuEOv/5ai3hapzVy+Q3ZlovOv+D3SCiepkq0uZQ
         M3xdnW4En3eDqS3plRYS87xV66DuXIUcRv9jjTa8ncT7O7MBNl8zOS94ndJw4bLYb/uU
         ODGfA0gsF/Wp/3VQWLYrlGrZ1VjCcz4cnwaCAGL6nqhLxGADaOcCmdcVyr/pgg4P4iuZ
         aDD9sfzG66RL4dFkSPa8maUWsXY9ypPkIkniK37ZAWn91fnbK+Ee/HTm8+2aW49E8BFg
         dTbZq6QD8dbn9kqG2qwcu8hNXiqRvN3rpboXQ9IiRk/c4tDPQuKRGeui7yuQS2DYle8+
         rf7A==
X-Gm-Message-State: AKwxytfzkTALD16QxUcoBJ+fcVGj62Sax8TmvGzsq7inKl4Mk/0aYVEb
        3gyqLd5J8qkg1my1Qste/XKyvYC6DpI+BXoSGtg=
X-Google-Smtp-Source: ACJfBouf49JsDR0XhblNqdhblhwx267AZyByRuakGd/S68QDXlNCsKrVQbM+usCwh//Q/MQ1q3o5ecRjGCHDHCV3n7o=
X-Received: by 10.101.76.199 with SMTP id n7mr13028685pgt.388.1516273205612;
 Thu, 18 Jan 2018 03:00:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.163.48 with HTTP; Thu, 18 Jan 2018 03:00:04 -0800 (PST)
In-Reply-To: <20180117180801.31049-2-chrissicool@gmail.com>
References: <20180117180801.31049-1-chrissicool@gmail.com> <20180117180801.31049-2-chrissicool@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 18 Jan 2018 12:00:04 +0100
Message-ID: <CAN0heSqxmLoh33i65JPhyQbmPaAcJcwrTCO+ZD4eb+qh8Pf8+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] send-email: Support separate Reply-To address
To:     Christian Ludwig <chrissicool@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Ludwig <chrissicool@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 January 2018 at 19:08, Christian Ludwig
<chrissicool@googlemail.com> wrote:
> In some projects contributions from groups are only accepted from a
> common group email address. But every individual may want to recieve
> replies to her own personal address. That's what we have 'Reply-To'
> headers for in SMTP.

s/recieve/receive/

> Introduce an optional '--reply-to' command line option. Unfortunately
> the $reply_to variable name was already taken for the 'In-Reply-To'
> header field. To reduce code churn, use $reply_address as variable
> name instead.

"To reduce ..." no longer describes the patch, since v2 actually
performs that refactoring in patch 1/2.  "Unfortunately ..." is
correct, but seems less relevant now. Except:

I suppose that a non-git.git patch which uses $reply_to could start
misbehaving now that this series changes the meaning of that variable.
Just thinking out loud, it could make some sense to take patch 1/2 for
sanity, but to then *not* re-use $reply_to for a new purpose, but to
actually take your v1-patch as 2/2. Or, this potential problem can
perhaps be ignored (except in the commit message?)..

> Signed-off-by: Christian Ludwig <chrissicool@gmail.com>

"From:" and "Signed-off-by:" are different. Not sure if that's ok.

Martin
