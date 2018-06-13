Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CBA81F403
	for <e@80x24.org>; Wed, 13 Jun 2018 15:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935973AbeFMP4a (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 11:56:30 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36838 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935694AbeFMP43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 11:56:29 -0400
Received: by mail-wm0-f52.google.com with SMTP id v131-v6so6398687wma.1
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WgRdjh4pOo5fyI9a+daEn3lSpMy4zKiIF2L4SJHNqik=;
        b=Eiso2e+fePWf9W9oQj/Ck+aQBVjIdTqqQ+kKXp5+UoTWHg7YKH4TyBv2w5OiXaxIur
         TcMtg+VQPQSf+V6Y6LvHqE+B/HRXPiuKa+6uD8oFvzrfA8oAd6/vf44rJlBrUI5Ft92v
         Eby7ARereqEL2LCDnJwGAOZ8qcoXvlxTl8S4+Oz6ebtLuPJFJC2M0JumXcy9j8sausb3
         UIX9zrBIT39H7R+X7Kpe1dQu68IhrKZRM7ioph3ApEzTZQbGkZsnWW+6UBjUrIA10Er3
         W3B6b3W/2p+ppRj8yE0kMIEhJxOodItoXhZNG4MPI06jvlVt5uIrh6peZxKuGGu2bopy
         LYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WgRdjh4pOo5fyI9a+daEn3lSpMy4zKiIF2L4SJHNqik=;
        b=KGgOv1uVaSzASg4VcGRoST/6TegffdGLQ8gFYPlkCw0qiTEwWZ3AWT3KgHGL3bcz4s
         n4gDpkYYXCpFm9HPTQOIQxFcCEciRDMHEHcpnsKwicKS+K55ZEWMNkcB8qa0vfp4m1fL
         fTkgarWn0pIAhmLg+D5sRkLEv+pVrM91P0NEjq3EtzmEq9dp9L2pvYtdtM7mKPyYdCiN
         CTEls4lczluIcefuCZvLp3sgZlaPisrCvESs7PEtFe7+MoonIEwLTYBr8Vo+thUps0xb
         2XRXgsylfM7gtmh+AV8T/LUxBX9L877wRLnw1Uprf+7dr23faZVZEJlQg+m29rDYo7YK
         x9Vw==
X-Gm-Message-State: APt69E1rAI2SIBvugSpKETPndMq/no803IqsV9OZL8iILX86ow5ut47n
        5W0nLWZiTpH3pkFBaY9Xdog=
X-Google-Smtp-Source: ADUXVKJ8LFPSSL6SrhWYxuEoF1R7sAHL9PAVLPAN+Z3+x+9aaPbzkiUf0wkmMq+I0HohvRbLtTUkHg==
X-Received: by 2002:a1c:ee06:: with SMTP id m6-v6mr2734926wmh.70.1528905387587;
        Wed, 13 Jun 2018 08:56:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 84-v6sm3980853wme.16.2018.06.13.08.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 08:56:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2018, #03; Tue, 12)
References: <xmqqbmcf90uf.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZn_i4=w2fUdCgOjqeEY1SnnP6kqmExZKC3-aKK45x88g@mail.gmail.com>
Date:   Wed, 13 Jun 2018 08:56:25 -0700
In-Reply-To: <CAGZ79kZn_i4=w2fUdCgOjqeEY1SnnP6kqmExZKC3-aKK45x88g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 12 Jun 2018 14:13:47 -0700")
Message-ID: <xmqqy3fi7k9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> A tl;dr summary for -rc2 that hopefully should happen in 24 hours:
>> the following four topics
>>
>>  jk/submodule-fsck-loose-fixup
>>  sb/submodule-merge-in-merge-recursive
>>  jk/index-pack-maint
>>  sg/completion-zsh-workaround
>>
>> are planned to be merged in -rc2.
>
> It would be nice to have
> https://public-inbox.org/git/20180609110414.GA5273@duynguyen.home/
> included as well, but as it is not yet a proper patch, I can
> understand why we err on the cautious side.

At this point, only clear fixes to regressions between v2.17.0..master
would be eligible for the final.  Is the one you are pointing at a
breakage during that timeframe?

Thanks.
