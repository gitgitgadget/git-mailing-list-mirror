Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3AD1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 19:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754375AbcKQTBZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 14:01:25 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34256 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753383AbcKQTBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 14:01:24 -0500
Received: by mail-qt0-f181.google.com with SMTP id n6so141284071qtd.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 11:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1pNWFHYKZFYkZ20mbpIoPqGBt4/FAnevPVLUfMk47xk=;
        b=Kr3QaStqpsphjIlL+R3qex/rusY22Q9Ui0jEnyxUu7pH8y02gZEp2eD30bROKSzt8+
         fFKAPtu0ToBnh8bi6s+x37urPlepaIpA8Hec14AB9CDH/6kLWrB/QOiUX4/LKwPCizEE
         JttS2dmMHTjVRx435rxMTGV/slMKeusZ8YPxVnSQb7BeNWZxjLWVibXKEZCr10khWhYd
         1IFZh3cTHM71u98n78d07GqZ4JEN1H5i11vbstnA1+wFuwuWoJa4q9pGopu+OkZStbyV
         tkgJJb1egdIJIhpLyFD3piz6VbUgYVjjPi1HD9QBIQQ/KazCZ4kfMOOiRLVQLL5huXi6
         ghtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1pNWFHYKZFYkZ20mbpIoPqGBt4/FAnevPVLUfMk47xk=;
        b=T3TkUOlUPJFOjH4q+4teo0r3WKX25Y3eRwvhXQGvCgYkQc8v7Wst3RuUI75bTX5wLF
         XLn555sDWQaE9gFT/9FxfiQvKMRQoSf3J62qauN6O5E0ptZLVOHxrfS+R+7NugT/xvuG
         IqYF59balYPzEKiRqyvNPBbNyN5aGYRLJQkAkk7t9Oee1R8g1ClWb1D89+5rOo00Yx/z
         2E5F3cvK01UZJy+waPA7+izCKSS2CwnRQz9N4JqvUjYJ+1Ml0//+d4l9oiMSN+wLVMpQ
         F3WQw0N9Ta7A8Fk+6UfAeF4keyPDKF3aGI0XfXV/vTvGKV1LiK3OdIYvi8iRljPSXVGE
         Z/xw==
X-Gm-Message-State: AKaTC02t8NiQsCruBha2ZUnuRkaktoV0Q/L/h9uo4rfjk3mllrUEWBe45OXDry5HhfSGZWxmY1FadxAyzm7ytHCT
X-Received: by 10.200.50.53 with SMTP id x50mr3279961qta.207.1479409283566;
 Thu, 17 Nov 2016 11:01:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 11:01:23 -0800 (PST)
In-Reply-To: <1479408364-150268-1-git-send-email-bmwill@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com> <1479408364-150268-1-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 11:01:23 -0800
Message-ID: <CAGZ79kYC51zC4nF3crtuJXK7uwK=Lh9X8LnRke5C87Vo46Gb+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] bug fix with push --dry-run and submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 10:46 AM, Brandon Williams <bmwill@google.com> wrote:
> v2 of this series is just a small cleanup of removing a nested sub-shell from a
> test and rebasing on the latest version of
> 'origin/hv/submodule-not-yet-pushed-fix'
>
> As stated above this series is based on 'origin/hv/submodule-not-yet-pushed-fix'

an interdiff to v1 would be nice :)

Now t5531 is inconsistent in style,
how much time would you estimate to add a commit to refactor
that test to follow the style with excessive use of -C for
all the other tests and avoiding subshells there, too?
(It's mainly Windows that benefits from such a refactoring immediately,
but consistency is a really nice feat for the long term code health
of the Git project)

Apart from one nit (and this refactoring decision/consistency discussion),
the series looks good!

Thanks,
Stefan
