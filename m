Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783B91F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 00:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdFJAkm (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 20:40:42 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36653 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdFJAkl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 20:40:41 -0400
Received: by mail-pg0-f46.google.com with SMTP id a70so31020623pge.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPXjIuGcb08sPS/9EwJMWgfcG1CUnaFiinYpvgOMW7U=;
        b=q0W1VQoIdogBcgIk/Yk+xg+pJiOC/0UmuyvH1tzfLTixKmvR6ZphGCnOf7GjzFjFNl
         5z0AlDzbGQap8Q36U/qUtbaiDn1Fkj97mbhdIk48/B38bFdkfgCGQ2bJ499ekGPiW9eT
         lELHqai0gKUMYVFQdufc/VinEHKW1LF2s3vqzRui7d6tirmTEywrQgCc6ZIS1HvW6mvN
         L1WO8v819U9OSOLfRh+BRgkN93OeCEIrpOrKhbOOvfOKClsqSgDXh8iVxhUXh8aJWZXM
         ojkXCcHMHhSigbp1PGxTqQkuvQWPwhMW8/Z9EY3Am3Up4H0608HHyIxrepG8h5cSbB0p
         8lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPXjIuGcb08sPS/9EwJMWgfcG1CUnaFiinYpvgOMW7U=;
        b=acv0eP6nXPv4McQw34gGxq0VMX0s4Pbb71OuwaaOeZ+SY81XluP+UtBOij/SkTYsn3
         ZUyLURyYp3iOOJzQzx9uaSYja37pB0MvKic9h9bNszP6kMj+Y9BK9Gd2J+Z6jP/73iGm
         I6379aUvhiWR78y+UuRhJ8S3xEXJwXBusQt9iPeu3Zhpn2AbKnqANm7UN2xA0GQlJTRY
         f2jfVTI3+EEaUxS09a/+FWxEj/+KMRW5DVujftKyzNtmo7sug1iZSQ2WX1cetn5qq/2r
         rG655DbNE5M5Dc3L1hLU/CuxBek2JI0zKzA2+lKo32cgp6Q61lNZ6eli7RDoihWYOTe5
         pc6Q==
X-Gm-Message-State: AODbwcAP2CW95WnbOJXwtfvOtVJalGYBqWWrRRjY7VuaSkvWWe2JSrN6
        CRvcFSh+JbIwkKgK
X-Received: by 10.84.238.129 with SMTP id v1mr43264488plk.102.1497055240819;
        Fri, 09 Jun 2017 17:40:40 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:4da7:e783:6b5b:e69e])
        by smtp.gmail.com with ESMTPSA id t20sm3900537pgo.29.2017.06.09.17.40.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 17:40:40 -0700 (PDT)
Date:   Fri, 9 Jun 2017 17:40:34 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170609174034.61889ae8@twelve2.svl.corp.google.com>
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
        <20170608234100.188529-1-bmwill@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  8 Jun 2017 16:40:28 -0700
Brandon Williams <bmwill@google.com> wrote:

> When I sent out my RFC series there seemed to be a lot of interest but I
> haven't seen many people jump to review this series.  Despite lack of review I
> wanted to get out another version which includes some changes to fix things
> that were bugging me about the series.  Hopfully this v2 will prod some more
> people to take a look.
> 
> The meat of the series is really from 04-15 and patch 32 which converts
> ls-files to recurse using a repository object.  So if you're pressed for time
> you can focus on those patches.

Thanks - I can see in patch 32 that one immediate benefit is that
ls-files can now recurse into submodules without needing to invoke an
extra process just to change the GIT_DIR.

Before I get into the details, I have some questions:

1. I am concerned that "struct repository" will end up growing without
bounds as we store more and more repo-specific concerns in it. Could it
be restricted to just the fields populated by repo_init()?
repo_read_index() will then return the index itself, instead of using
"struct repository" as a cache. This means that code using
repo_read_index() will need to maintain its own variable holding the
returned index, but that is likely a positive - it's better for code to
just pass around the specific thing needed between functions anyway, as
opposed to passing a giant "struct repository" (which partially defeats
the purpose of eliminating the usage of globals).

2. If we do the above, another potential benefit is that (I think) the
repo_config_get_.* functions would no longer be necessary, since we
would have a function that generates a "struct config_set" given a repo,
and then we just use the git_configset_get_.* functions on it. This
would also reduce the urgency of extracting the config methods into its
own header file, and reduce the size of this patch set.

(I was also going to suggest that you remove the "convert" patches, but
that is not possible - ls-files uses get_cached_convert_stats_ascii()
from convert.h despite not #include-ing it.)
