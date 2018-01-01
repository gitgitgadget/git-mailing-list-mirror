Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72BCC1F404
	for <e@80x24.org>; Mon,  1 Jan 2018 15:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeAAPdM (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 10:33:12 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63497 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752212AbeAAPdK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Jan 2018 10:33:10 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jan 2018 10:33:10 EST
X-AuditID: 1207440d-973ff70000000c05-9e-5a4a530c4a08
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 15.5E.03077.D035A4A5; Mon,  1 Jan 2018 10:26:05 -0500 (EST)
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com [209.85.223.177])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w01FQ3ah011298
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 1 Jan 2018 10:26:04 -0500
Received: by mail-io0-f177.google.com with SMTP id q188so22544202iod.1
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 07:26:04 -0800 (PST)
X-Gm-Message-State: AKGB3mItf0ixLIbTkVQ6xgoe/44Y+BYEaR+K8WC9h3pe0TKQ729O7hxU
        3C1tN2PLkCf/naEQXzLbS6wNTTt2vy3z8kUpL48=
X-Google-Smtp-Source: ACJfBov07w+IQCQ1Y8uJ1PloNZpeIHQ1Job0ncpO5bF/RGiSLalebr42+ntIVxb4eRPNFpS2o8hnXg7hDKYtdClzugE=
X-Received: by 10.107.6.9 with SMTP id 9mr57600541iog.200.1514820363647; Mon,
 01 Jan 2018 07:26:03 -0800 (PST)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.108.143 with HTTP; Mon, 1 Jan 2018 07:26:02 -0800 (PST)
In-Reply-To: <20171208112222.GA6094@sigill.intra.peff.net>
References: <20171208112222.GA6094@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Mon, 1 Jan 2018 16:26:02 +0100
X-Gmail-Original-Message-ID: <CAMy9T_HiK-DkJRrNUCK+9ffcOcEgd9qc_F2taO8--jv9gQrs5A@mail.gmail.com>
Message-ID: <CAMy9T_HiK-DkJRrNUCK+9ffcOcEgd9qc_F2taO8--jv9gQrs5A@mail.gmail.com>
Subject: Re: [PATCH] refs: drop "clear packed-refs while locked" assertion
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqMsb7BVl8P+9hUXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDK+nX7NVLBFrOLx0VXsDYw9gl2MnBwSAiYS916uYeti5OIQEtjB
        JNG3qpsVwnnCJNF9dw8LhDOBUWL/vFdMEC3lEkfnLGSDsIsklrfdYYGwCyROrLrKCmLzCghK
        nJz5BCwuJCAn8WrDDUYI20viwoFuoF4ODk4BK4lL89whwpYS/05fAitnE9CVWNTTDLaKRUBF
        YvHy88wQ4xMl3p1YxQwxPkBizqxNrCBjhIFGntzpAxIWEZCV+H54I9gmZgEtic0/v7FD2JoS
        rdt/s09gFJmF5LhZSFILGJlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVmluilppRuYoSE
        Nu8Oxv/rZA4xCnAwKvHwagR5RgmxJpYVV+YeYpTkYFIS5fX09IoS4kvKT6nMSCzOiC8qzUkt
        PsQowcGsJMJbqwhUzpuSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk9Xg4BBouXjy
        IJMUS15+XqqSBK9gENACwaLU9NSKtMycEoRSJg5OkEU8QIsuBgLV8BYXJOYWZ6ZD5E8xWnJc
        uHPpDxPHgT23gOSzma8bmIXAhkqJ8zaANAiANGSU5sHNhKWwV4ziQO8K82aArOYBpj+4qa+A
        FjIBLfxzHuSz4pJEhJRUA6NPUQ7LBGXp3zaNX3a/jL+iy32y90GP/o1sW41zvbsEDtoaF2hd
        4ys/zm13XqTOa/exrefvbNcJ0n1u52GWlT0v1333X7f4hP6JU8PLGQu2G4Rk2147Vs7O+cnx
        itb/WpWP8578TnWb39zI8yjS75vYBYaq1GOevdcN/YLzltm55O0qzV24TomlOCPRUIu5qDgR
        AAmjGbw8AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 12:22 PM, Jeff King <peff@peff.net> wrote:
> This patch fixes a regression in v2.14.0. It's actually fixed already in
> v2.15.0 because all of the packed-ref code there was rewritten. So
> there's no point in applying this on "master" or even "maint". But I
> figured it was worth sharing here in case somebody else runs across it,
> and in case we ever do a v2.14.4 release.

I forgot to respond to this. +1

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

> -- >8 --
> In clear_packed_ref_cache(), we assert that we're not
> currently holding the packed-refs lock. But in each of the
> three code paths that can hit this, the assertion is either
> a noop or actively does the wrong thing:
>
>  1. in rollback_packed_refs(), we will have just released
>     the lock before calling the function, and so the
>     assertion can never trigger.
>
>  2. get_packed_ref_cache() can reach this assertion via
>     validate_packed_ref_cache(). But it calls the validate
>     function only when it knows that we're not holding the
>     lock, so again, the assertion can never trigger.
>
>  3. lock_packed_refs() also calls validate_packed_ref_cache().
>     In this case we're _always_ holding the lock, which
>     means any time the validate function has to clear the
>     cache, we'll trigger this assertion and die.
>
>     This doesn't happen often in practice because the
>     validate function clears the cache only if we find that
>     somebody else has racily rewritten the packed-refs file
>     between the time we read it and the time we took the lock.
>
>     So most of the time we don't reach the assertion at all
>     (nobody has racily written the file so there's no need
>     to clear the cache). And when we do, it is not actually
>     indicative of a bug; clearing the cache while holding
>     the lock is the right thing to do here.
>
> This final case is relatively new, being triggerd by the
> extra validation added in fed6ebebf1 (lock_packed_refs():
> fix cache validity check, 2017-06-12).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  refs/files-backend.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f21a954ce7..dd41e1d382 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -99,8 +99,6 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
>         if (refs->packed) {
>                 struct packed_ref_cache *packed_refs = refs->packed;
>
> -               if (is_lock_file_locked(&refs->packed_refs_lock))
> -                       die("BUG: packed-ref cache cleared while locked");
>                 refs->packed = NULL;
>                 release_packed_ref_cache(packed_refs);
>         }
> --
> 2.15.1.659.g8bd2eae3ea
