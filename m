Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7B7C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 16:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJCQxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJCQx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 12:53:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3797A24093
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 09:53:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f193so10182745pgc.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc53ZZwotATbBC/dwarBOjhvfSYgiEJcR5bE+lc0yLE=;
        b=P8CPNeIzfzJziPN5o47U0haySdOod2cFBZCt6s7wCJunoyKyKNBhch1KDS0WRtjFor
         KTW9GYF42d8hBXyqJkhkMlqCU+DoTL0hhP7nmyV527oC+/CmY3GyvZ8g0CvY+p4c8nJw
         v5pMwRS7DF1jmGxtfIo5VCr4Yk6IYPt5B4vVyvzn1JN9vHP6U2X0SZ33OEs/y8AnEnpV
         30oiZoP6EbVBtgNgyuL/4gljDR0XJAvzATV9z7l3i18aRKAghkHKekBSYDBG38SCzQFx
         ZY409fUDXlIBZfEWIS6XJRkvDja7RdW4mkEw6xd2x8wcsPF9sWyrJDhXjx5z60WPKgmJ
         xVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yc53ZZwotATbBC/dwarBOjhvfSYgiEJcR5bE+lc0yLE=;
        b=b6UrfbHJJOfioqthZXd8JEzncyJnDIG0BXufLt/lpxi45c14EKSrGekmHErKJbP3we
         a3/44bWtNY5nsmb9UUv4Qwx3a+s15Cw6FVKj6Z7jxovtbvoAHcf8VEZHII6rAz6q9tAi
         sC5Dzli5b3NSTocaIkcCB/RBmrU8+TDvRoD26+ssKN3swg6YxtXvj/80sYdil/3bD8fS
         9mXmkQfc3OoGnlvU7QB8oz2vlZkjsVfqzwX9Pa7SktQGiyETom7noFr04063fPO2Xown
         pTEKI9HS7ZONc4S0S/z3Vqi0WBlFvqgAnEVnws2dmq5rHLzQeKXzrUT8YegtwTVi0u+z
         QdfQ==
X-Gm-Message-State: ACrzQf2MCY5veX86wznML9Xz7BYULU4hA0/q5FVuVZ4BHhP/tFV3vc7x
        DfZv8aqYl9I6KNSmfOcwsHE=
X-Google-Smtp-Source: AMsMyM7u4LDxw4/hzp/6cy5+dXfWaBmz9NlgliWSU2tGHiIwvutHnDFt6HQ7OZvvN5FfUbECQzGvMg==
X-Received: by 2002:a63:1f5f:0:b0:440:5310:4b0e with SMTP id q31-20020a631f5f000000b0044053104b0emr18593246pgm.293.1664816006687;
        Mon, 03 Oct 2022 09:53:26 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b00176b63535ccsm7409657plg.193.2022.10.03.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:53:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alastair Douglas <alastair.douglas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report
References: <CADTs3HEn8JQzfWGP-rq_BBLvwGD163=c2i_7vFK17g+wAVec+Q@mail.gmail.com>
Date:   Mon, 03 Oct 2022 09:53:26 -0700
In-Reply-To: <CADTs3HEn8JQzfWGP-rq_BBLvwGD163=c2i_7vFK17g+wAVec+Q@mail.gmail.com>
        (Alastair Douglas's message of "Mon, 3 Oct 2022 16:28:06 +0100")
Message-ID: <xmqqill0voft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alastair Douglas <alastair.douglas@gmail.com> writes:

> I have found no solution to the issue below. Apologies if it has
> already been addressed.

Thanks for a report.  

The solution is to remove "[pull] rebase = preserve" and replace it
with "[pull] rebase = merges", I think.


> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Have an existing git config with rebase = preserve
>
> What did you expect to happen? (Expected behaviour)
>
> Merges to be preserved when rebasing, without a warning about an option I am
> not using.
>
> What happened instead? (Actual behaviour)
>
> I received a warning as though I had used the option on the command line:
>
> warning: git rebase --preserve-merges is deprecated. Use
> --rebase-merges instead.
>
> I didn't do that, so I can't follow the advice. There appears to be no
> alternative config setting for the new option.

It sounds like splitting hairs, but I agree that the message is
misleading.  I think whoever wrote the message meant that "the
feature that is triggered by giving the --preserve-merges option to
the command" was deprecated.  IOW, they did not mean that only the
command line option was depreated, implying that it is not
deprecated to trigger the same feature by setting a configuration
variable.  Both forms of the use of the same feature was deprecated
about the same time.

I also suspect that they were hoping that the users will read the
instruction based on these command line options and understand that
it also applies to the configuration variables.

