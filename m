Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B363C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 20:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95D260EFE
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhKDUOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhKDUOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 16:14:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C8C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 13:12:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t11so11451604ljh.6
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okkLL1rQMQ25r0ojgok0J3+P9eBmgFm9RH3D/ifVe28=;
        b=WGL76+oFM3V5wM4IYqotTmjMLVtBoWsrIICT58f9Ox02V6Pn8ltxv+a0LtpQTODfrI
         DPvhK8kVCZH3kzV+jPTfBbpAThbhYdTMC3hPtvxm5BapssudqIZ/4wCWyOnxrSL2ntgx
         5blph7kFi/CUZoFHlURDEfXdIIfh6TQoNhvkJtrlEYzuSo3w9grBHaoKLv5JjyT9ZgHC
         DUMnL63sMvxZIbpdGntjYYoA9k5XONNvpzbSL1vL4nQvc8EdvarUBKdsQ7SfEQzAk3mr
         hA3LKm61B1TIr7+ZWdT143E5seUPPNOVTG/kk77IhBiBhja3fvc2bO7cdL2aMCVVJsyQ
         x9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okkLL1rQMQ25r0ojgok0J3+P9eBmgFm9RH3D/ifVe28=;
        b=R16Cj4sr8JRR1596HRNrWLnHom4nDFhJkBK3SM3nazdb4QFkZtPpRgFQ1aVeRoBz6Q
         0GCzJZ/LON9E5yBck0SY5aqUNiUJQ84CZDhqBUIS/zp9GnJprxPTeqKyXqB0aIxGaFML
         lGs5PgViTwVLIzt7x+8rZcG+PDGZHyDCCPUBg+aF2padOIn9iACzHWEQrszNgG65B+q9
         JzuvTUHxxp5HHVpRyABZApL27TJlP2O+souE+qeSmnrMdoj3iF6bmgwdgg8k2VuwrR3d
         yfQjXjVLStKIZfC7ifRPPXDZwDAUXHBnY7eTEThEeSmQgR5aYxbKclU62pJK0dwDjsXb
         44AQ==
X-Gm-Message-State: AOAM532My7uCXegttYFi++CzCBclViKC9afXmrD7a4UXHBdMNOmPhlBI
        gPP5Oj+k+y8B8E6dX/ywbrbHJPN6NtwwGsAXpPlAI9VIoFgKng==
X-Google-Smtp-Source: ABdhPJwyD9IX/DgKacuseJfboxvTmeet3PBKYJM8m8ZbrEAVzq7jTH22si+AnZtBMrDJzixBmkswziD5EAEwNfqUvJs=
X-Received: by 2002:a2e:bc0c:: with SMTP id b12mr13167537ljf.54.1636056733981;
 Thu, 04 Nov 2021 13:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <YYQtjWSb+z4taphX@kitenet.net>
In-Reply-To: <YYQtjWSb+z4taphX@kitenet.net>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Thu, 4 Nov 2021 17:12:02 -0300
Message-ID: <CAHd-oW6q67u=XGCGK=n25Kjph+ceuqPHLxQ0LH=Vydn4xctZ-A@mail.gmail.com>
Subject: Re: surprising value of LARGE_PACKET_MAX
To:     Joey Hess <id@joeyh.name>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 4, 2021 at 4:08 PM Joey Hess <id@joeyh.name> wrote:
>
> The docs don't say what the maximum size is, so I assumed I could make
> it as large as the length header allows, which I think is a natural
> conclusion to draw from the documentation. But looking in git's source,
> fff0 is the maximum:
>
> #define LARGE_PACKET_MAX 65520
> #define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
[...]
> Perhaps the best thing to do would be to document it in
> Documentation/technical/protocol-common.txt

Could it be that you consulted an older version of this file? The
current [1] version of the doc says:

"The maximum length of a pkt-line's data component is 65516 bytes.
Implementations MUST NOT send pkt-line whose length exceeds 65520
(65516 bytes of payload + 4 bytes of length data)."

[1]: https://github.com/git/git/blob/master/Documentation/technical/protocol-common.txt
