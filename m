Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15CEF1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935833AbeCSTVd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:21:33 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53807 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935727AbeCSTV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:21:29 -0400
Received: by mail-wm0-f53.google.com with SMTP id e194so17195435wmd.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=vvLNbv/Ud9pHZAXl+gCIvEj92GIXuL3/9w50gn0tcxM=;
        b=KadkWF/GiixAqC7MvDCv5wmAnD550BXinPlVwz/w5gcMCytwR/6fFqD/epQYyzN0l2
         whcPfg6QYSLydHART2tKF3svUFdIT83Gg6UMaRqzGYysXoZEuaY5+RkfmLMSfGziRJEC
         7FPzYnSRHKOpDHxPkgntsZRcskFIXkOW3D+NpKD/0j87dqvvonctNSelThAulUNf/7sB
         ipe99+xrji9dzXE5GPMizJGAoWSuNwY4kiq6iPirPwRrGQGnaqNWNeUOVPK+DUCF/Lo4
         IR48acnT+jaWx2APfRfhtFFqZ3zIn7tx9EHdA8RO0s0ooc1WlbLS1W9xVmcYDnBw4T+n
         g0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=vvLNbv/Ud9pHZAXl+gCIvEj92GIXuL3/9w50gn0tcxM=;
        b=oBzHVnIr35LSr/eWQSa7SdeXi1CbopDpsrNcp6GGqVzaF6zoGdLg/8zkWgIw0SR3ul
         jbErscY2BJkcnjS1BS1niB9WTZ5PBJfal8j4ODRwYFplUDSc9uoSrdvv2Kyox91mnSOD
         EOBdR9PkKhXXsaiGoBOw/ed+OO6MDo00L23obLPIq5rdoS1fZXJHD1Z6rjhFeXkio/ot
         8ZuPiU5chrE+dWPJewQW/CTARsHDunrbQyaWtvpghGKKH18FybccVsipXwONVcFchjBE
         pZkwDvQmDyvMvPqNuoKMSvCAMrPiMEjTfolXZfc/Eaiyis2PFeF8ecUi/MtTr1SUYCHQ
         GXvA==
X-Gm-Message-State: AElRT7EMO+/LnMaeSjb1bfl3+sZtjGDN1ZzZLhxeDUb+IlN8I9+dXa8E
        eT4mGoAFit6XCtUMR1gkuGE=
X-Google-Smtp-Source: AG47ELsqI/phjFfEClf3fv1p+xbxCL2qZdn48vrnrQ1le72xW40DkzczDZ9LMlDvegmzwArA+GJj4A==
X-Received: by 10.28.45.9 with SMTP id t9mr9390330wmt.20.1521487288208;
        Mon, 19 Mar 2018 12:21:28 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id q6sm968840wrc.30.2018.03.19.12.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 12:21:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-3-dnj@google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180319025046.58052-3-dnj@google.com>
Date:   Mon, 19 Mar 2018 20:21:25 +0100
Message-ID: <87y3inc1my.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 19 2018, Dan Jacques jotted:


> +# BEGIN RUNTIME_PREFIX generated code.
> +#
> +# This finds our Git::* libraries relative to the script's runtime path.
> +sub __git_system_path {
> +	my ($relpath) = @_;
> +	my $gitexecdir_relative = '@@GITEXECDIR_REL@@';
> +
> +	# GIT_EXEC_PATH is supplied by `git` or the test suite.
> +	my $exec_path = $ENV{GIT_EXEC_PATH};
> +	if ($exec_path eq "") {
> +		# This can happen if this script is being directly invoked instead of run
> +		# by "git".
> +		require FindBin;
> +		$exec_path = $FindBin::Bin;
> +	}

I think it would be more idiomatic and more paranoid (we'll catch bugs)
to do:

    my $exec_path;
    if (exists $ENV{GIT_EXEC_PATH}) {
        $exec_path = $ENV{GIT_EXEC_PATH};
    } else {
        [...]
    }

I.e. we're interested if we got passed GIT_EXEC_PATH, so let's see if it
exists in the env hash, and then use it as-is. If we have some bug where
it's an empty string we'd like to know, presumably...

> +
> +	# Trim off the relative gitexecdir path to get the system path.
> +	(my $prefix = $exec_path) =~ s=${gitexecdir_relative}$==;

The path could contain regex metacharacters, so let's quote those via:

    (my $prefix = $exec_path) =~ s/\Q$gitexecdir_relative\E$//;

This also nicely gets us rid of the more verbose ${} form, which makes
esnse when we're doing ${foo}$ instead of the arguably less readbale
$foo$, but when it's \Q$foo\E$ it's clear what's going on.
