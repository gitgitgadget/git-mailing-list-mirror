Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5E31F517
	for <e@80x24.org>; Wed,  6 Jun 2018 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933529AbeFFRWY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:22:24 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34760 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeFFRWX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:22:23 -0400
Received: by mail-yw0-f193.google.com with SMTP id b125-v6so2130802ywe.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0Xj/hYypQP9nvYicnbR7kzoBgcjmiaGQFTovb+Dr7zQ=;
        b=TJnhiUbPZgvnxY9o5oA228Na8St15hngZX0uIFyhYW4GTTx7JSp2oue44NEyvqjtT+
         yIwONf0QRGdybAQQv1LMHBA5YLUG1q6hq1CLImJV/aLDopSPx0wNEGLom9xyRMIGLglR
         dl1ZylAKTmUuPvSPmYoL+gauoCpQJL/7IClfWCBOiMRBoTMCPz4z+WjFEtR80pOFPiCX
         Nh0QV2UFcN4lh8xrad6RJxl1KEgk6U0EsfLTo0pA3N4wRKzsrut5GPsmIL9SBUaF0ui0
         FdP2LIdrp7uhINCSq953qyENtawgE3W9LfuVYJ4aHncp38MGKYwDA0DPYLKLKlSTnwqo
         8uUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0Xj/hYypQP9nvYicnbR7kzoBgcjmiaGQFTovb+Dr7zQ=;
        b=qoxKQ+dK2KxSTfPtD4Rs1a8cVKBhF2B7oU45IY5jp5tyqfauE30N5taAb9vTgjoNhD
         K5soBzjdpJGUB6vF2W2x9wrbfBvox98AvrXcsAMSQpkjSS4D8bRHSEb/KNQbJP8A4AbQ
         zLGSutkt1GcG7x2+LSnYO/xQpegPDwWjiB6Tr4yYFGYdCyAaO+0OHJL5J5HB598DdjAc
         7HCSrR3omFGYJGR3508a4jqTkrhBVp9a83luRLCSRm2D9M92oh2RwzOuT426VeVOC3Ma
         fl+rEL8/ZKhQKIZU4OA3DNlfzPG2FQux9Br8EL+Mt/o/V4aG6goGUwcT98dUoSfEM2t5
         mSHA==
X-Gm-Message-State: APt69E1BcfTdCZUZEN2pcpz5Gt2UqpRyJhtaFvhZvlZytqyIQC1yCEFh
        FN1Tuch5ejR/kk6tA4gTXMgXJPUAo6PmXvVuXgwObA==
X-Google-Smtp-Source: ADUXVKLcyzUfwLrMcq82614DazV3OJ0Mnmzbff4ZiehAzCPID78wLFpC6WTnthNX8czZq2lLCyEhCoHqY4F/vsdMU4Y=
X-Received: by 2002:a81:3c0d:: with SMTP id j13-v6mr1803641ywa.16.1528305742763;
 Wed, 06 Jun 2018 10:22:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 10:22:22 -0700 (PDT)
In-Reply-To: <CA+dzEB=7tGeXduxdKrJpDpXrmNbb_ZnYg=CmByJ7J-w-iiyxsQ@mail.gmail.com>
References: <20180604201742.18992-1-asottile@umich.edu> <CAPig+cSzJ=2Zz7jRNB7sK7FyZ+YwdAFseCTSDbM_m4E8K9WxHA@mail.gmail.com>
 <CAPig+cRyv=JuGo+OfULuvbLrqRxoYZyBZDrSJrt5F8YRwzNn6w@mail.gmail.com> <CA+dzEB=7tGeXduxdKrJpDpXrmNbb_ZnYg=CmByJ7J-w-iiyxsQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jun 2018 13:22:22 -0400
X-Google-Sender-Auth: KLIlE6hC-ikJ8XB8DDfGvra1cXI
Message-ID: <CAPig+cSm7My9r8KN1vNyssendf_v_nMARDAq6ALA=X7nZ+spkA@mail.gmail.com>
Subject: Re: [PATCH] config.c: fix regression for core.safecrlf false
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 1:18 PM, Anthony Sottile <asottile@umich.edu> wrote:
> On Wed, Jun 6, 2018 at 10:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jun 6, 2018 at 1:15 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Mon, Jun 4, 2018 at 4:17 PM, Anthony Sottile <asottile@umich.edu> wrote:
>>>> +       for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
>>>
>>> Simpler: printf "%s\n" I am all CRLF | append_cr >allcrlf &&
>>
>> Or even simpler:
>>
>> printf "%s\r\n" I am all CRLF >allcrlf &&
>
> Yeah, I just copied the line in my test from another test in this file
> which was doing a ~similar thing. [...]

Thanks for pointing that out. In that case, it's following existing
practice, thus certainly not worth a re-roll.
