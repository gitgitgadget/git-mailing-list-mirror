Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3C81F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeHWA4w (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 20:56:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40744 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeHWA4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 20:56:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so3595452wme.5
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+SsQl0zqwxxGHK7FqbG4DzQBoMFwfE0HI3ZjYivYtZs=;
        b=j2dQ2qEoOgC1z7O/9r7cOAfCWGCnRyjZhpfSQkRQhAAsYwYMjil4VhUaIzG/c1l3su
         WLN8Vzzp/6ZLgqUBVA9QPnOUXY95AIcwZb2vMNje8QixaksV9022FxNxSAKbUEXDbzH8
         JjEcf+GqSJ96nGnLA25+pgolF6aVTMN0dVMniTXJz7RTWa1q7Qryd6ZWCmSNWDAhN1rK
         iIN0uZX8ZIIUeQ0OMGK3dbgGMOJaDL8vP0pw3WgJhJrfLz8C/8i7xpVSE2D22QrJIU1q
         1ca72W6jp+s2aG0FsVeicI9+Bj2HtHvPm0qFZVywO3LMlY6KYkqT/Po7RjH/IDBgueRU
         CMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+SsQl0zqwxxGHK7FqbG4DzQBoMFwfE0HI3ZjYivYtZs=;
        b=KYUnaKcuEGx/3CfzL9gKElKBzW899X5gkmzZ3M1lDWje91+h2uBMKBQt4EKjIesKZr
         ZdDExp6opQu9YbUfSDpPYBtbdOu3jrTtZf5CZ8jD8qa1HAHar1XGLDJ1eZtZx6mQHDqy
         kQC1AyMaGOplGjnz7O0RphvjvMvMDfRm1/uOMuc8Qq6Mgyse7yIP2HV4RTYbBM4WOhQK
         gnTjltrtzmMnSjObpqPdbMRzsPsk/0X0aDtO9M2eaJNwJAWtEFxc9ioqWjK1btKg07y/
         UrlMovq0C+RLgx6Q+HH0T8NwNlkqgqhlr6oyhZdm4gJTL4IymUVXrG8PVuz8FSC2tKT6
         XmdQ==
X-Gm-Message-State: APzg51Aex5m5qGdUCEn+G35+nD6y+FHU9j8zOKuZQZmqFE1te+Ul0gtG
        QSBUjtWhpXjlFAJfHEoigV4=
X-Google-Smtp-Source: ANB0VdYBzyNQzoiiALXBYK9o1U7xK6UyauUe3tGyNmzUo+bgYLS8yFCS9rl05xhJFcBwip0cbYMLeg==
X-Received: by 2002:a1c:82c8:: with SMTP id e191-v6mr3141082wmd.35.1534973416824;
        Wed, 22 Aug 2018 14:30:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q1-v6sm2036877wrw.42.2018.08.22.14.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 14:30:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v6 18/20] rebase--interactive2: rewrite the submodes of interactive rebase in C
References: <20180731180003.5421-1-alban.gruin@gmail.com>
        <20180810165147.4779-1-alban.gruin@gmail.com>
        <20180810165147.4779-19-alban.gruin@gmail.com>
        <nycvar.QRO.7.76.6.1808222310220.73@tvgsbejvaqbjf.bet>
Date:   Wed, 22 Aug 2018 14:30:15 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808222310220.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 22 Aug 2018 23:14:43 +0200 (DST)")
Message-ID: <xmqqzhxeks2g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I made this same mistake over and over again, myself. For some reason,
> John Keeping decided to use the singular form "revision" in 1e0dacdbdb75
> (rebase: omit patch-identical commits with --fork-point, 2014-07-16), not
> the plural.

Perhaps we should give a synonym to the option?  Renaming it to the
plural form may keep the existing usage working as it would be the
unique abbreviation, which may be a way to reduce the mistake.

>
> So you will need to squash this in:
>
> -- snipsnap --
> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> index fb0395af5b1..7600765f541 100755
> --- a/git-legacy-rebase.sh
> +++ b/git-legacy-rebase.sh
> @@ -145,8 +145,8 @@ run_interactive () {
>  	test -n "$autosquash" && autosquash="--autosquash"
>  	test -n "$verbose" && verbose="--verbose"
>  	test -n "$force_rebase" && force_rebase="--no-ff"
> -	test -n "$restrict_revisions" && \
> -		restrict_revisions="--restrict-revisions=^$restrict_revisions"
> +	test -n "$restrict_revision" && \
> +		restrict_revision="--restrict-revision=^$restrict_revision"
>  	test -n "$upstream" && upstream="--upstream=$upstream"
>  	test -n "$onto" && onto="--onto=$onto"
>  	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
