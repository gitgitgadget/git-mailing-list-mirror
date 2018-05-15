Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0ED81F42D
	for <e@80x24.org>; Tue, 15 May 2018 08:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeEOILW (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 04:11:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35948 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeEOILS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 04:11:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id n10-v6so19675708wmc.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zosDjjQDvzpBgeC9LeVXx2NpVpOL4gRCtpxhYQpYgJ4=;
        b=h3qYv2fn4XTmk8M6PV/N3ckS43XKnIbnNh27UOFgB8HVfC/lgFlPVvBYtp5rdfQoez
         1oh7ebmJaSXWyWsjalhRMmb7765cm62GhcdHK7y8QfzkWlimg1tIPWDlIjQyOHLRTbvH
         gzQ9tbD00TUZ6gX/xo5SCmhTDgqIjTzTfy0+h8crYPfgRZoNsQWExpfusMJIQTZwadfM
         0wcz7lpIyKMBZKyuncLxB7LqpPtydYEsrY+6iQtI+6+TmKZU039GVyezl5Ah/e6fUDRT
         NBMwO5aUqiAfDAVGBNZnr1WUrLOh7x2VQwsm2p/t4D21Cy8kS8dyVREv7DRTy7i8XUQa
         C63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zosDjjQDvzpBgeC9LeVXx2NpVpOL4gRCtpxhYQpYgJ4=;
        b=F5fvI01ux559NtpvIimIo3m4OWF5nCPrL1huqg2MHcI9+z6tNPmIN2xfBQ8UY2QsbD
         RAnLI/Ftvx2/0oD7E4TuyIAsye2TkJ7dA7IzHLK06D37SuKjjUp2cPW3SYK5eJlLvu5Y
         SFt2Z39hNrKX0htYvaVutRRs8yHjaldfZTk1IdkxzG+lY6vcfXJqhXMIHkn6Oox5fhjD
         Uu/Wv6Oep/ItPSLKQvE/2MHtrW+m6zZ4hiyxHAKcOFKgQwwMNLzRBaKcq04MEyKiVgZI
         CU2jPfdOCHCuOEjbo0C654bczjFdov4ZK3y38pW01qSSl29cTulRRFhjBcJfzDSPPSwr
         Zd2w==
X-Gm-Message-State: ALKqPwdX3cYfuhtPGHXnqzTOJzU7QJohqQMFZsBYHz8CmrQIe30HRSCc
        vusAwmVuAuaq5IgXbpAjqDThlrhq
X-Google-Smtp-Source: AB8JxZrHqGkWWL/bOCOrCdbcLwNW2D2feTWLaVvlWSqGc16nu+mXX3f/tKORFZoSqP7wRXLFz7eQdg==
X-Received: by 2002:a50:d311:: with SMTP id g17-v6mr16418092edh.160.1526371877640;
        Tue, 15 May 2018 01:11:17 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y63-v6sm6065555edy.63.2018.05.15.01.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 01:11:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 35/35] submodule: convert push_unpushed_submodules to take a struct refspec
References: <20180514215626.164960-1-bmwill@google.com> <20180514215626.164960-36-bmwill@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180514215626.164960-36-bmwill@google.com>
Date:   Tue, 15 May 2018 10:11:16 +0200
Message-ID: <87k1s52va3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 14 2018, Brandon Williams wrote:

> Convert 'push_unpushed_submodules()' to take a 'struct refspec' as a
> parameter instead of an array of 'const char *'.
> [...]
> diff --git a/submodule.h b/submodule.h
> index e5526f6aa..aae0c9c8f 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -100,9 +100,10 @@ extern int submodule_touches_in_range(struct object_id *a,
>  extern int find_unpushed_submodules(struct oid_array *commits,
>  				    const char *remotes_name,
>  				    struct string_list *needs_pushing);
> +struct refspec;
>  extern int push_unpushed_submodules(struct oid_array *commits,
>  				    const struct remote *remote,
> -				    const char **refspec, int refspec_nr,
> +				    const struct refspec *rs,
>  				    const struct string_list *push_options,
>  				    int dry_run);
>  /*

Why do you prefer doing this to having this on top?:
    
    diff --git a/submodule.h b/submodule.h
    index aae0c9c8ff..c3f206ce17 100644
    --- a/submodule.h
    +++ b/submodule.h
    @@ -1,5 +1,6 @@
     #ifndef SUBMODULE_H
     #define SUBMODULE_H
    +#include "refspec.h"
     
     struct repository;
     struct diff_options;
    @@ -100,7 +101,6 @@ extern int submodule_touches_in_range(struct object_id *a,
     extern int find_unpushed_submodules(struct oid_array *commits,
                                        const char *remotes_name,
                                        struct string_list *needs_pushing);
    -struct refspec;
     extern int push_unpushed_submodules(struct oid_array *commits,
                                        const struct remote *remote,
                                        const struct refspec *rs,
