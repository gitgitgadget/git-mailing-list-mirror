Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50513C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiCJNN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiCJNN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:13:29 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC33C736
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:12:26 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id q11so6340902iod.6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JB6iO5Hu3ip+GDp1D1mqwJy/mxUZCwlhB9N9y5XWIk0=;
        b=Nxmz55xYQ/CtcwDS0E77XcflBBauzO8fh/T0WtPQUe6G8C3V3h+x14pDDl/OvXxAxT
         CipUlzluX4bchrtbJJRbMHu2hTkjoRcEEiJHD2uQ+5fTT2ZHUxUw3THkD061GyFUwDbJ
         7L2dr6zLeUCG4q37/d4ZNHA7MuhO713GFXvMb06q4CpvpiEbvr59XHUt1ijLRJ/DsmYu
         lWXl04N2EAcXeabndRAEC/VFY54ELeLTStVigy1osBNlO4p8lNiO+zjni2i35ii1/IAn
         edsTlfaGlOOFaOMe7A/k0K309J03r8WVtpw3sY6OaIaZzSh/JDTGfoWvjBt+Luu9CSEt
         GYjA==
X-Gm-Message-State: AOAM5333zy2EwX+7BSqvH7Jd4WIjBnDQUTnZVb6RHCWeSCPPuPmlUzG1
        UJBjg98vxpCNWzXU5j0YN7VOhslhJYE/vL5bQGw=
X-Google-Smtp-Source: ABdhPJyKfOmsBRLeqfvkxYJ5Yth+pf2q/nKIeHIrWuNBV2im6CdMkTC4cfgiscRrGzHoeQfb8E3bV6F2jFCJehsEBDI=
X-Received: by 2002:a05:6638:1655:b0:319:a174:6ba0 with SMTP id
 a21-20020a056638165500b00319a1746ba0mr4037078jat.195.1646917945822; Thu, 10
 Mar 2022 05:12:25 -0800 (PST)
MIME-Version: 1.0
References: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
 <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
 <d204419925e7a4486d9a66a8a0f807a77be6d1b7.camel@gmail.com>
 <xmqqee3bm2b8.fsf@gitster.g> <f5be5b264f30f689546db3883b4b64c88ba00cb3.camel@gmail.com>
In-Reply-To: <f5be5b264f30f689546db3883b4b64c88ba00cb3.camel@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 10 Mar 2022 14:11:49 +0100
Message-ID: <CA+JQ7M9HUMK8=b0+uxN9Kwx1VSH3OnxvdYTdw4ZoT9COHhJdeA@mail.gmail.com>
Subject: Re: git notes question
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What I was asking was just if there was a way to not use these default
> strings.

Forgive me but I'm somewhat perplexed as to why you want to change it.
Is there a specific use-case where this is a problem or is it a
personal preference? Maybe you have a good reason and my imagination
isn't stretching that far.

> Well, this would be surely nice. For now, I will just remove it by hand
> or script something to do it before calling git-send-email.

Here's a simples sed that changes Notes: to setoN:
  sed '/^---$/{N;N;/^---\n\nNotes:$/s@Notes:@setoN:@}'
