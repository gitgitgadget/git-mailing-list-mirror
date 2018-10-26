Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412BD1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 00:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJZIog (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:44:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34572 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeJZIog (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:44:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so11061018wrt.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 17:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=42uW2PAuqJY16esjUJoXja72tP24FyD5pFQOMgAxgos=;
        b=jaKhno8rb5OY5NpiFofcmVtyM8rJsqFdlzo1RuXFclbEpYheRkUZy6ZRQVF04TY/h9
         ihfDnhedt/VCgwGbihqlxz0fWCvOJaUockJCYI3qFA8rWWwaLYu9aq+zU9bU2Q+7d5AC
         S/O5XOrcKdXybAjBgObULZUy0UYwL/urQXHLnc2eB6vsbI6JHhUToq4GobJLXOq/QEK1
         lC+1xvmH8mpMmBIhsGVwI+b94DnKemEgh7PEoDLgKpu1cPsW9pO6xj1NcNnS53z+q1HV
         9jo/MEP4QTHzyqvSldc0MR+HspfDFmHjMpiWkQzthaCkkQUICIt0WqLzyTz2vjtlq2bz
         rNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=42uW2PAuqJY16esjUJoXja72tP24FyD5pFQOMgAxgos=;
        b=B6zSeMBHz14nk+AHCO0jRlNlJjNRlsCgOd1v4b9jvl6HckerhKSNQlc21UENgLaowD
         X9SOhyGxG5/lL4HDZ1fFT9K3vdmZcGPc+wbyUCGcOU9fopZy3/5EtjSJC5FPHrgxxBzQ
         eUwH9MiauhwZe5CKCOh3o4XFzXpR2z8ajEoIQOWpIDpddBs2WUUUlbEIe2G2423ufj/4
         2VLtIR84ReA1eoIaIppe18RAHd7HytYoV4bA28MeNnLHTBxUAJ2gy91rYf+vrdiqnr7M
         kMGyMHMaKxindRLm8my7/oyezthoG67ji6N5dO1viS+3YacNmraI7JaIUY92Pn/LQXxs
         PZPA==
X-Gm-Message-State: AGRZ1gL218Ik8bfxqoMZJx5KmzpZ8t33b3fZCPxxghBEt8/D0u50eJWt
        hkCQFuONBgX8hHU2zaeMhPFth/m5WJo=
X-Google-Smtp-Source: AJdET5cI6GGG5mi24rxeBIFIrNdPLeHTsCDbwgaOpGH+AvgYnby6602H+MB3d26MpEyYynZam0JlDQ==
X-Received: by 2002:adf:9589:: with SMTP id p9-v6mr3802038wrp.270.1540512590550;
        Thu, 25 Oct 2018 17:09:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l140-v6sm4968292wmb.24.2018.10.25.17.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 17:09:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: no longer use containers
References: <CA+xP2SYtBGoxyV+hfjvYeEVU6XuvoZubC+-ffdubRgee=JtWXA@mail.gmail.com>
Date:   Fri, 26 Oct 2018 09:09:48 +0900
In-Reply-To: <CA+xP2SYtBGoxyV+hfjvYeEVU6XuvoZubC+-ffdubRgee=JtWXA@mail.gmail.com>
        (Sebastian Staudt's message of "Thu, 25 Oct 2018 19:41:45 +0200")
Message-ID: <xmqqo9bhfu0j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Staudt <koraktor@gmail.com> writes:

> Travis CI will soon deprecate the container-based infrastructure
> enabled by `sudo: false` in ce59dffb34190e780be2fa9f449f842cadee9753.
>
> More info:
> https://blog.travis-ci.com/2018-10-04-combining-linux-infrastructures

Thanks for posting a patch that would serve as a good discussion
starter.  This is not a criticism on your patch, but more is a RFD
to those who helped our use of Travis by contributing to .travis.yml
and ci/.

Don't we need to do some other things so that we can run in vm
environment, rather than in container environment, before doing this
change?  IOW, aren't we doing in .travis.yml something we can do
only in container but not in vm (if there is any), and if so,
shouldn't we be rewriting that something so that we can run in vm?

I know ce59dffb ("travis-ci: explicity use container-based
infrastructure", 2016-01-26) only added "sudo: false" without doing
anything else (e.g. adding things that are only available to those
who run in container), but if we added stuff that are not usable in
vm environment after that commit since then, we need to adjust them
so that we can migrate to the container-based environment, no?

To me, removing that "sudo: false" line seems like the least thing
we need to worry about.  After all, they say that whether we have
"sudo: false" or not, the CI jobs will start running in vm
environment and not in container.  So if the rest of .travis.yml is
ready to run in vm environment, we do not have to do anything ;-).

In short, my question to Lars and SZEDER is, are we already prepared
to be thrown into a vm environment?

If the answer is "yes", then I think removing "sudo: false" is
probably still a good thing to do for documentation purposes
(i.e. showing that we knew we are ready to go through their
migration).

Thanks.

> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> ---
>  .travis.yml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 4d4e26c9df..8d2499739e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,7 +1,5 @@
>  language: c
>
> -sudo: false
> -
>  cache:
>    directories:
>      - $HOME/travis-cache
> --
> 2.19.1
