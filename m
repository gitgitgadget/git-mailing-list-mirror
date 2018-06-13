Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF7C1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 16:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934859AbeFMQse (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 12:48:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53657 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934747AbeFMQsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 12:48:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so5864575wmc.3
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2mqNEhZuOzMDQzr66Lpx6ZI+1eKzhNPBMcBVelfhBy0=;
        b=t+sWrGk8UA3RY1xIL3Fft5c9t+AMwBK2qgbbxckeDEROS0gCZ/hZ/DDWtTl3GFIBy/
         7QaDF0XjrK8Mvolc6fBYz/h/hVwsU+N1r/6Bqd4E+fR9M0kmdyaEz9e4slNdNEDmH795
         TP48/iXNE/f5lMdsZr1sh8NQ7t/QKTu6/1GuVFJkL/BhOUWrRNfCqmrCkYtIk8+rMfLN
         WdhqYNw7/mHerHDpSZPLQyIIgTPrpX3+CgmrkwrtvpzqBC5GmCjfMaD/D/jupIlf0rMf
         BaWoCf+Otjits5h7oYS/eRQa0+rW4Ls3NZOSPvEG66kNqJYvzGh6Uu8jKiBUQ/PKnCjG
         1vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2mqNEhZuOzMDQzr66Lpx6ZI+1eKzhNPBMcBVelfhBy0=;
        b=ilswqRv4FBMs3jnV2s8g5RLkm2sYWX1FsH6rw/st6+Wtz0TImjgmCPRuRdIGH/zj2u
         yhhLeRa51VLqQoavJn+zAbeJJIiSUtfgKlte/WQglRY7ZDXZ4ZKm925MwYvMQhIWUrWB
         /dRgSND+hB/zC3if10mpfvDGkOQcZn2xpayhIj3snUMg0en6uVp+zR5XonIzygNUYoPq
         qNke5A53OAHJOKfKxRgURTroT2jeNyXCiaYN68lx0u5S0joKN/ZgSfeWG9v42y5lCMVa
         cThuoAQivp5IRLluNOKm8gOEq34ClOdNKcRsVP8XhHZxwbyH9RZ3gvls38QGWXkYRNop
         4xvQ==
X-Gm-Message-State: APt69E0GTnFvgavbbnGC6SBdsuUp6LEXOniEY1dc3WzG5HSA0Z0q6Vzp
        xLHNgDVYm7rbNzM9rM4gbVMTz+qM
X-Google-Smtp-Source: ADUXVKIM5CHobgDJXfmXaFQlLXmPA3tLdSOvSlTYDBvnvU8q5EcuNDNUjgI9EuR70aC7ajRytcRn1g==
X-Received: by 2002:a1c:448b:: with SMTP id r133-v6mr3809219wma.55.1528908512146;
        Wed, 13 Jun 2018 09:48:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b16-v6sm4479355wrm.15.2018.06.13.09.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 09:48:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-credential-netrc: remove use of "autodie"
References: <CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com>
        <20180613074810.5358-1-avarab@gmail.com>
Date:   Wed, 13 Jun 2018 09:48:30 -0700
In-Reply-To: <20180613074810.5358-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Jun 2018 07:48:10 +0000")
Message-ID: <xmqqpo0u7hup.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Per my reading of the file this was the only thing autodie was doing
> in this file (there was no other code it altered). So let's remove it,
> both to fix the logic error and to get rid of the dependency.
>
> 1. <87efhfvxzu.fsf@evledraar.gmail.com>
>    (https://public-inbox.org/git/87efhfvxzu.fsf@evledraar.gmail.com/)
> 2. <CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com>
>    (https://public-inbox.org/git/CAHqJXRE8OKSKcck1APHAHccLZhox+tZi8nNu2RA74RErX8s3Pg@mail.gmail.com/)
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  contrib/credential/netrc/git-credential-netrc | 1 -
>  1 file changed, 1 deletion(-)

Even though this may not be all that release-critical, let's queue
it so that we do not have to remember to dig it up later ;-)

Thank you very much to all of you involved in the thread.

> diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
> index 0b9a94102e..ebfc123ec6 100755
> --- a/contrib/credential/netrc/git-credential-netrc
> +++ b/contrib/credential/netrc/git-credential-netrc
> @@ -2,7 +2,6 @@
>  
>  use strict;
>  use warnings;
> -use autodie;
>  
>  use Getopt::Long;
>  use File::Basename;
