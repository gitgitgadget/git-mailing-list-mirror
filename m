Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39851F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbeGLUe6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:34:58 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36511 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732391AbeGLUe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:34:58 -0400
Received: by mail-vk0-f67.google.com with SMTP id y9-v6so17060665vky.3
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Qr2GzYyds6BCFFalsi+a4ne9BHXhtlnN6GPe1warjVY=;
        b=H/cEm+VDUkBQx6SkimvqzaTE5QuH45FhznR/Fq4tko0ufJ5/z7mWClOibEzn1CX2ZX
         MZg6IgDwPOyZeLGPlHFOAyYLaXWPU6X8ifZsbLC/pNZPn1SOX2qKNeA5CgRbQ6lRyuUi
         Ib7l2JF2HNvv03i0wugmLqna2wcCi463XxlzaYDeS5f0WwZMLalA9UYs8u7R0Vq/ukju
         cGIXMKHR/AMp6zwO1eT3Uh0SkvdjkeLbUgAhDa8jmOJxunSbrtUy7wCfDoc94Fwq76fx
         I8okxJ7GXPYRNqQc1o1EADOxpwH3eyEHz7lG212W33iBgIEPJ5qSyKmd6MnxwzkRulXh
         L9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Qr2GzYyds6BCFFalsi+a4ne9BHXhtlnN6GPe1warjVY=;
        b=rqrBh8UYvzwQGrVGxKvWnldO0kAmv35sh1uTNiFs/90BitIv7LROWE97qlZQGfaqfj
         FXYZEg5dFx/+XaXpIpdD2qUX0eNKOrAo8+pCGNMl+mAgrIzFPyIy+Fk4ELlUvjWtbmVY
         t72m66hfwDOITmyMxxSDv7sok3+X71FcNnZ+LSG065JyPM0GZPBNVGDkj6HNAnFoG55h
         HnGETuPtINBoG2VsKJpfwjw1bya8YDNk/HgJfwScBU5poKmyhAaYwsk4kADeveMIK//b
         NyN8MUYdG2AErtRs8EJyugbrTVC1TqQmFT4n29KS2aNDzxJg9+QRHUhgTltrIentSqeI
         E/sA==
X-Gm-Message-State: AOUpUlHR3JWPApb29ldFw9JfBlRPtRyCvM3EdqXEwng+fkJ5md2xma0p
        mPW7ybTYbNz4zDpnd0t6hKwR8aoesS9YkyRWSonvmw==
X-Google-Smtp-Source: AAOMgpfeWko7aa3guKRWWR1ZG96Tvorh7aacuxa8VBlS1+MIPhGb60qJGFYfV3NMsxdPq9naKNYnWNdUf3c3beHCoyY=
X-Received: by 2002:a1f:dc85:: with SMTP id t127-v6mr2248735vkg.120.1531427028092;
 Thu, 12 Jul 2018 13:23:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:3a98:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 13:23:27
 -0700 (PDT)
In-Reply-To: <CAPig+cQWA+sE3iH89kQGWgS+0HQDK-V5++S0+F6_dpfOCfXxDg@mail.gmail.com>
References: <86a7qwpt9g.knu@iDaemons.org> <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com>
 <CAPig+cQWA+sE3iH89kQGWgS+0HQDK-V5++S0+F6_dpfOCfXxDg@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 12 Jul 2018 13:23:27 -0700
X-Google-Sender-Auth: k8I57UCmmb0vAj6ch4XBxczy1N0
Message-ID: <CAPc5daXRCtSSQTNxUz3DOL-sp=pgNKb13htmQaHR8KAjuUm3tg@mail.gmail.com>
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Akinori MUSHA <knu@idaemons.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yup ;-)

On Thu, Jul 12, 2018 at 1:16 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jul 12, 2018 at 4:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>> I _think_ the right and safe way to fix taht is to do something like
>> this:
>>
>>         test -f .git/rebase-merge/author-script &&
>>         (
>>                 safe_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL ... &&
>
> s/safe_unset/sane_unset/
>
>>                 eval "$(cat .git/rebase-merge/author-script)" &&
>>                 test ... &&
>>                 test ... &&
>>                 test ...
>>         )
