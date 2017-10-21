Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13347202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 02:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbdJUC4m (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 22:56:42 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:56629 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbdJUC4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 22:56:41 -0400
Received: by mail-pg0-f68.google.com with SMTP id m18so7971717pgd.13
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=dcXwMFCVga3dQ+RZ9byoH9O1EklHyQv9F4QjPi29mlM=;
        b=sT3lMwlCRfe3MLYEo7aavudLyp203MRwaSTpIbWzBjaOmZ5cRmJjTkTLadEcKdXviE
         uh4aurnrTGSRZwhHnapUdtGdIJKuP0nBDOsXmbtKIi6b5MLu6uv9LRnQVHQwZJ4eTSKZ
         qd6tLLAEX0ZgKCjVTjOScE2Er5AwLIWTWiboLG0MMKRHftIl9pfxpvdy9hsjbm+SxZv/
         0iZGATiT9OY9/1q12E/Ed6j9HpMrMA6XVmaAUMcaqE/2/HQZIeEw8xeuYBMLBrSUk56j
         NoWKA1MQpH8F+qxcwuQq2MLtiOjzU01CUEpKVkQWXNtTqE272DjmUnmldhbuhR1H7fgL
         6Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=dcXwMFCVga3dQ+RZ9byoH9O1EklHyQv9F4QjPi29mlM=;
        b=QL/4gZugBjQ1MdljMyrH0Hhh3/Z2LQZXyrOgo1mW+r3/GcyE1Y1JStR+LP/Hiu8m45
         qUMjBNGewmCdDZaIinn8pXQ8mnZEKJJoY6eGo9gg7ddAYl9oRPZzagzz8Z03G6ctPv28
         tNhvof60Pkj2W1Gmql1+oEg13TEhXZbsVOr/z6SLBgLh8X1J34GNW87q5KTkgH58W/hs
         DRUM+Jpjc0gY8xy6fuSZ4mBjp3/sM01C+sDcNksNFdu3VpC/0BJzOtwlc9de4LQit2gF
         oUIqED6jkwx4nKrYdhvX/86ut6lKLSjKMfvCKi634lowZCuexjQrX2m0daUsKEf2nIVL
         +xVQ==
X-Gm-Message-State: AMCzsaU9sPypzbjF1powZMzXKwS/OjXOSwZ6eOTWAP5tax94PPJRSw/6
        V5yW/Qavod3DWG9PQWkMT8Q=
X-Google-Smtp-Source: ABhQp+SCuYmgj53k06y1fn0cmejRkynyBvcedmpqmNgBCku6Iq/OHnlFQVhPEu4wtli/IRiH4ahL6g==
X-Received: by 10.101.86.9 with SMTP id l9mr5888649pgs.297.1508554600845;
        Fri, 20 Oct 2017 19:56:40 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id v14sm3077360pgc.78.2017.10.20.19.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 19:56:39 -0700 (PDT)
Message-ID: <1508554594.2516.7.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/5] branch: re-order function arguments to
 group related arguments
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kYLX+mXaWA-ZGnCWE7UBoZ2N76_MHQ6tB7+yGYDBRXUCA@mail.gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-3-kaarticsivaraam91196@gmail.com>
         <CAGZ79kYLX+mXaWA-ZGnCWE7UBoZ2N76_MHQ6tB7+yGYDBRXUCA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 21 Oct 2017 08:26:34 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-10-20 at 14:50 -0700, Stefan Beller wrote:
> On Mon, Sep 25, 2017 at 1:20 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> > The ad-hoc patches to add new arguments to a function when needed
> > resulted in the related arguments not being close to each other.
> > This misleads the person reading the code to believe that there isn't
> > much relation between those arguments while it's not the case.
> > 
> > So, re-order the arguments to keep the related arguments close to each
> > other.
> 
> Thanks for taking a lot at the code quality in detail.
> 
> In my currently checked out version of Git, there are two occurrences
> of create_branch in builtin/branch.c, this patch converts only one occurrence.
> 
> (So you'd need to convert that second one, too. Oh wait; it is converted
> implicitly as the arguments are both '0':
>     create_branch(branch->name, new_upstream, 0, 0, 0, \
>         quiet, BRANCH_TRACK_OVERRIDE);
> )
> 
> This leads to the generic problem of this patch: Assume there are other
> contributors that write patches. They may introduce new calls to
> `create_branch`, but using the order of parameters as they may
> be unaware of this patch and they'd test without this patch.
> 
> As the signature of the function call doesn't change the compiler
> doesn't assist us in finding such a potential race between patches.
> 
> I am not aware of any other patches in flight, so we *might* be fine
> with this patch. But hope is rarely a good strategy.
> 
> Can we change the function signature (the name or another order
> of arguments that also makes sense, or making one of the
> parameters an enum) such that a potential race can be detected
> easier?
> 

I don't have a great interest in keeping this patch in case it might
conflict with other patches. Anyways, I guess we could avoid the issue
by making the last 'enum' parameter as the third parameter. It pretty
well changes the order by moving the flag-like parameters to the last
but it doesn't change the signature very strongly as you can pass
integers in the place of enums. (I guess that also obviates the
suggestion of making one parameter an enum)

So, the only way around is to rename the function which is something I
wouldn't like to do myself unless other people like the idea. So,
should I drop this patch or should I rename the function?


-- 
Kaartic
