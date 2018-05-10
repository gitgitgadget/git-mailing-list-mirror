Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C4E1F42D
	for <e@80x24.org>; Thu, 10 May 2018 09:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934786AbeEJJnX (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 05:43:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40120 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934366AbeEJJnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 05:43:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id j5-v6so3203615wme.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VEJouQz7n50N/afAnZ3dynlZit0DcMUGxDXjlbVfndQ=;
        b=rUPunJgDr1qZuIoFF195OMriKiDhyNnPvdGhfB0fJUfx3gLYH0UwmsRyGdPvf7a7Ke
         ygHZLb0VaMRx1lKS9d/M9jOXgJ7j4KTGtSHAE52p2oufvnZK9JWQ/zlsCjUopN84AkmC
         hRgsO9HSHul+Ph09BwoXgKB5w4SCenj8zBzsdM7OeHvgRyEH3UAy8YfzAYbUWSNJE0GH
         nuRB9iHWMq4z1xbrLAUnaieb6UwgjYaJWMlX0AmDzB9pvDTX/1Mtji+H36Oi3lP9PENh
         8bU5dtIIDees2a5cZdFHyevi69etTSmhc4TZPVL2FNLGpqVS5qln5kCsMhUoLY5fneo/
         lFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VEJouQz7n50N/afAnZ3dynlZit0DcMUGxDXjlbVfndQ=;
        b=IfWeUI7BHn85a41tbF289vOHoNSEAZAxWR2VlPeDyZcqToHXzaZGOVPGJtk9GKvjrg
         +1apfdPZ0L68UHhjIPuzYEKtG4GqJthiSqdnplKtl5Hg9iwUicANe09lT/XsJG4yxM2k
         Gdkl5kdM3AxDIXv8dpnUsfkkLyYVrCHYgx4zHSx/TqNW/N1BSaTkOKP+VK+wvcTBMLU5
         trzaj7Y6nKXo6drCli5Lc7DmQKBE7GDURaU2BKP//AzaM+/3x7O+A0KMoV+KfCn1GQih
         DdAMOTaA4qac5in8ucwd2SleAGOnqYA6rtGKpx5Vyj6nbmA5ajnV7B92l3BCk/QRjT2v
         7m4w==
X-Gm-Message-State: ALKqPwfMz8Li+573C6XHkVG1TjXhdvBtGSl4xZ4Y0kSuZ0gR+wD4KLnY
        xbKMbsNPG2F085jkejF4E80=
X-Google-Smtp-Source: AB8JxZr9DYKtTM0qh+cWXHedJTSybOfevf1TnfP4OmN+Vw063VRQrsRmiUrMgR/DMDCwNlWhl5KG6w==
X-Received: by 2002:a1c:e006:: with SMTP id x6-v6mr725480wmg.80.1525945401372;
        Thu, 10 May 2018 02:43:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t189-v6sm704754wmf.22.2018.05.10.02.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 02:43:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luis Marsano <luis.marsano@gmail.com>
Cc:     git@vger.kernel.org, Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 1/2] git-credential-netrc: adapt to test framework for git
References: <20180509213634.5198-1-luis.marsano@gmail.com>
        <20180509213634.5198-2-luis.marsano@gmail.com>
Date:   Thu, 10 May 2018 18:43:19 +0900
In-Reply-To: <20180509213634.5198-2-luis.marsano@gmail.com> (Luis Marsano's
        message of "Wed, 9 May 2018 17:36:33 -0400")
Message-ID: <xmqq7eobkfrc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luis Marsano <luis.marsano@gmail.com> writes:

> until this change, git-credential-netrc did not test in a repository
> this change reuses the main test framework, which provides such tests
> specific changes

Sorry, but I cannot quite parse what the above is trying to say.

> - switch to Test::More module
> - use File::Basename & File::Spec::Functions
>
> Signed-off-by: Luis Marsano <luis.marsano@gmail.com>
> Acked-by: Ted Zlatanov <tzz@lifelogs.com>
> ---
>  contrib/credential/netrc/Makefile             |  4 +-
>  .../netrc/t-git-credential-netrc.sh           | 31 ++++++++
>  contrib/credential/netrc/test.pl              | 73 ++++++++++++-------
>  3 files changed, 78 insertions(+), 30 deletions(-)
>  create mode 100755 contrib/credential/netrc/t-git-credential-netrc.sh

Will queue, but may need to make the log message
readable/understandable.

Thanks.
