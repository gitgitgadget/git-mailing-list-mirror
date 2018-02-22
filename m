Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CBE41F576
	for <e@80x24.org>; Thu, 22 Feb 2018 06:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeBVGv0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 01:51:26 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:53017 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbeBVGvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 01:51:25 -0500
Received: by mail-it0-f66.google.com with SMTP id o13so5079057ito.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 22:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Zc6KJqGrj0V5Vi2I4VLJe8phG8ylOBwAq6pTEnhb4E=;
        b=C+0bBbMLucPayHxmfqd2s7wakpbgUlglGuIyIWZ3kQwAxfC5Ds0hlb7nJ5Q+Jri8p3
         bjOSJfE+KsVtYV6a3eSLH1ctGXs3dhcp8o/ZG/KlHS31yUUlf3tFzeIzIsH+UnxwKRqk
         /maNq4HMn0J7b3l12wVERdyt6UtesTRUmjiF33oH8JcElWH3DB9g61MhHmVJpF3IvqAs
         XqpZidbzzGm0Qw4mQexgOcVLz/bJoXzaqla4XYf27KLi4DPdn0xJ9mGuDoAfk3Rdrhr6
         HVzakRs2vztpeo27a0aBFGgYmsWz1mTyQ4AQqsCnRgwioT3syN7Iwb+/sPgcgN5U1XEp
         FtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Zc6KJqGrj0V5Vi2I4VLJe8phG8ylOBwAq6pTEnhb4E=;
        b=nZIqpngS4lk0JmN81EYP0wrqVWMcIjRqYTCnwYV4d99rP4bPFx8g536WJbC5z0d4zT
         m/5oXw5AHB3BuesNG5DIFnx5XuEwoPZXHjW7MIDBg/vN5k8q7i6nu0m0E9DuRKmB7pBM
         QbKrpGd12p5WfZzIdlRCLHENEWXoXH6zgK+s4s/JJvTerQeNKT/YH2krChX5aetHySPI
         AXGrJ+rB5dOVglE0Y6P1A1fpeE7HgfY8f3mWms9ErrsPANTaUvloCeRqW7vCLWBqXW6O
         T59sR2Fgzciu/sneLA8PZhqgMe8ob9IoVeI/o7zqEj1nbZxeOt/q1EUEab3egk9BKRlX
         Fc2A==
X-Gm-Message-State: APf1xPC3lZAdOC+4dkczsO9rk7Qw+//dJF+ab/cG7Aw73vI/jF3NNYyu
        eFvBB+Kcah0Yth5TVRfbC+9JS0iy
X-Google-Smtp-Source: AH8x225hGQhe7vs37QLeTA2icsmlEEAoRTOsN2sK2kIcyf0B8roGgfUpwJXVbQUF3eV6SepnPxNxWg==
X-Received: by 10.36.73.18 with SMTP id z18mr6916667ita.132.1519282284946;
        Wed, 21 Feb 2018 22:51:24 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 83sm13067553itj.3.2018.02.21.22.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 22:51:24 -0800 (PST)
Date:   Wed, 21 Feb 2018 22:51:22 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH 13/27] sha1_file: add repository argument to
 prepare_alt_odb
Message-ID: <20180222065122.GE133592@aiede.svl.corp.google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-14-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-14-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> See previous patch for explanation.
>
> While at it, move the declaration to object-store.h,
> where it should be easier to find.

Which declaration?  It looks like prepare_alt_odb is already in
object-store.h.

[...]
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -717,7 +717,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  	} else {
>  		fsck_object_dir(get_object_directory());
>  
> -		prepare_alt_odb();
> +		prepare_alt_odb(the_repository);

Patch 2 added a #include of "repository.h".  Good.

(I checked because with the definition of prepare_alt_odb as a macro,
the function call would compile correctly even if the_repository
weren't in scope, but we want to include what we use as a matter of
style/maintainability.)

[...]
> --- a/packfile.c
> +++ b/packfile.c
> @@ -890,7 +890,7 @@ void prepare_packed_git(void)
>  	if (the_repository->objects.packed_git_initialized)
>  		return;
>  	prepare_packed_git_one(get_object_directory(), 1);
> -	prepare_alt_odb();
> +	prepare_alt_odb(the_repository);

Also good, since patch 3 added a #include of "repository.h".

[...]
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -23,6 +23,7 @@
>  #include "sha1-lookup.h"
>  #include "bulk-checkin.h"
>  #include "repository.h"
> +#include "object-store.h"

Should this #include have been added in an earlier patch, since the
file both uses and defines prepare_alt_odb, which is declared there?

The rest looks good.

Thanks,
Jonathan
