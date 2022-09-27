Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBADC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 22:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiI0WCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiI0WCG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 18:02:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6EC161CFC
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:02:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r7-20020a632047000000b00439d0709849so6427556pgm.22
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=w/Uu3kevqcuYK6OeYNtAz9bIAFOAKNk5xCLcMRQQgVs=;
        b=U5RGYHFZYgHDelg7T0B1Wc4Nx3tqtutd/54xmRsDkJ6Nvd1GzA+oH5wM5uZtTGuY8e
         qXhU9kXq/7Zn7R+CqsSNX0WdEzzxPDBkrOGaVEbNGIesjF6ZDirpVu+aHRS/jUorsvl2
         G3/uFdWIKo37GK+aH8An8q1Su9U5fzB0+7CM+Mw9P5VNS+x3G+3zNC+070Hzb7NDA73b
         l9S+swSt1wK1l/PHUQYVu6HyPHPn6Wh/aOGc9m1O0CcRguJNP3CyYi1zhhkmLmwfsQiP
         sAud73DU1REuezWXzRg0MbyeUkHsSIgPvXv61e0HRYWgKdtWok7kbBgqzgJNB5jnJaJB
         eTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=w/Uu3kevqcuYK6OeYNtAz9bIAFOAKNk5xCLcMRQQgVs=;
        b=GvS3JMb50pVbvd9yOLfJMfvNi7SawrP5p7hbA29C+bgIlaBeiY6Vo+9Q+KsNkU5pTW
         Z5O5Ctm4GPVT8Zn80fNaOeHw9ng+E3bg+N6cOtHuHXZDOfeiFAO6y4JXI0Y05eAhdOYD
         vv1L5Hw02AxKgPWFYwHAgHtEkIcEzG7x6ZnLBozPR78EEvr1HOuQljI2VCsd+GNSvCvD
         RIVW2dJGvIOuR+BDFS+FSI2fSNkrAcSGzdF1R9Ej0OAwCYcmd8y+GDtyD5fH0K1spNAS
         mDw96u1+ZlrzfhgmAVIMi4i2dw14gX/Nzd6yYiWfkza4XdC0Xs1k1x9VLUBT2G4wUZ00
         nUdw==
X-Gm-Message-State: ACrzQf3G8QwEpSejKlOr7Vq9Esy2nITXV6fO7h+weqEQe9n2GjOmQg/r
        kwbtDCV3ADN5UcTTYEin0Oi1T8K2v7pFFQ==
X-Google-Smtp-Source: AMsMyM5bFxDWGbbGmig6ixxjn+uSjd52l1eDBUUsKMtDS3b6kaGWPN+1AMzNcNv3vRBsayxftdwBSkZxy4S36A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:2c4f:b0:203:70c0:9c0d with SMTP
 id p15-20020a17090a2c4f00b0020370c09c0dmr6632656pjm.21.1664316124330; Tue, 27
 Sep 2022 15:02:04 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:01:54 -0700
In-Reply-To: <xmqqr0zxah7x.fsf@gitster.g>
Mime-Version: 1.0
References: <kl6lfsgdn4oe.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqr0zxah7x.fsf@gitster.g>
Message-ID: <kl6lbkr0mq7h.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Join us for Review Club!
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> [2] http://tinyurl.com/gitcal 
>>   Note that the gitcal event is a little out of date; it should say
>>   say "Please contact Josh Steadmon <steadmon@google.com> _and_ Glen
>>   Choo <chooglen@google.com>...".
>
> I can make that happen, but do you really want both of them to be
> contacted? 

Yes, I'd prefer that both of us get the email in case either us is
unavailable. In the longer term, if Review Club is more of a
project-wide effort instead of Google-specific (which I really hope will
happen :)), we'll find a better approach than "email all admins".

>             Also do you (or Josh) want a write access to update
> these details?  You two clearly have a demonostrated need to such an
> access.

Yes, giving both of us write access sounds very helpful, thanks!.
