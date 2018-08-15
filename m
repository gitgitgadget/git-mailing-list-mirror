Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FA8F1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeHOXeR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:34:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37473 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeHOXeR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:34:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so982845pfo.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f3HfojQf0FtauCV4PoCwF2JpJLu7jQZaB5e8QcPl0qM=;
        b=dw2n4HLHx2aS1v6ubdV0MajhNSNidfu8lwggrzCjbKQ9+drC42sF48Avlazq0t/PwR
         stJBnVKHH698iV6I4rQRP+/jGQylprwgoVlvz/xHR8FjOUGqjoe3WuBNNq3qbEqrvBXD
         Fm8Kycgk8wBVPnjj08CWwYnSEnkPpnzXlhRhFZhomtcMA1N0TmUtPKhVKnuBCnWgzGea
         goujp1Aph7FVLCHG2189G7+PQQ1E+PWPKJ6wwVRgUCmcTZ0pGhTDbm+1sWG5lY1ITyMk
         TqxMENBlJXS/DtrYO1oIJR12CKSr+JOkiF2j1oEftoDjVHWc7m32/nNDYIx1KN4FSnh6
         SGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f3HfojQf0FtauCV4PoCwF2JpJLu7jQZaB5e8QcPl0qM=;
        b=KgaA7qMV/StypoNphvDk5903xqqpygS9FdxR3Q9DennYWnqgRrNEHqRntaXlxIujfT
         jGIDr20C6ef4/OuwTWE8TO9/if7xZOpOmgiPLl6gkd3xMmjDtBtpZelXPQ9y9iA6G79X
         XAAVwEF2rV0rhNkKJr05P4yKjrcxvHhMvAWeDJzpOfmJeh+X8c4a+NpdFoiUCVqcxhbd
         VugiJqX6xYfEC4qyFC7nNDm4gFbLZMu/if4pzo6NmSTTVegXuK67GyvtNSfPqJCJFbD/
         hDhuO2RYdIAh10AClbritoLA+a6bbJ9wS7uUmbLKntgFeG8ycRNRM9cmDov/oNgDU2Im
         Myrg==
X-Gm-Message-State: AOUpUlFqRsgaj9EcaamNNmN3e96SsczMn9HS10qa9fTU9iQjZ23tGgue
        3JQKyyPh+NConuxR7Enl2rE2mLqP
X-Google-Smtp-Source: AA+uWPy+mY2czuClZWoL3nPbzjittKJos1bTdL/UMvpjiyh2KxtQIYQa2rsvtvAmU4AoTfywMzA05w==
X-Received: by 2002:a62:b0c:: with SMTP id t12-v6mr29275106pfi.36.1534365632322;
        Wed, 15 Aug 2018 13:40:32 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 22-v6sm39400819pfl.126.2018.08.15.13.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:40:31 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:40:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCHv4 6/6] Remove forward declaration of an enum
Message-ID: <20180815204030.GC181377@aiede.svl.corp.google.com>
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
 <20180815175410.5726-1-newren@gmail.com>
 <20180815175410.5726-7-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815175410.5726-7-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> According to http://c-faq.com/null/machexamp.html, sizeof(char*) !=
> sizeof(int*) on some platforms.  Since an enum could be a char or int
> (or long or...), knowing the size of the enum thus is important to
> knowing the size of a pointer to an enum, so we cannot just forward
> declare an enum the way we can a struct.  (Also, modern C++ compilers
> apparently define forward declarations of an enum to either be useless
> because the enum was defined, or require an explicit size specifier, or
> be a compilation error.)

Beyond the effect on some obscure platforms, this also makes it
possible to build with gcc -pedantic (which can be useful for finding
some other problems).  Thanks for fixing it.

[...]
> --- a/packfile.h
> +++ b/packfile.h
> @@ -1,12 +1,12 @@
>  #ifndef PACKFILE_H
>  #define PACKFILE_H
>  
> +#include "cache.h"
>  #include "oidset.h"
>  
>  /* in object-store.h */
>  struct packed_git;
>  struct object_info;

Not about this patch: comments like the above are likely to go stale,
since nothing verifies they continue to be true.  So we should remove
them. #leftoverbits

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
