Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27962036B
	for <e@80x24.org>; Thu,  5 Oct 2017 10:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbdJEKrS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:47:18 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:47013 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdJEKrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:47:17 -0400
Received: by mail-wm0-f54.google.com with SMTP id m72so1303668wmc.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 03:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i+UHtLjigLcq6lQ+5dK9SsDTxO7T4J8GtHNuZmj8VkM=;
        b=WiRXQSqswXmly3Qr2UUh+3eaE2PoWrdtEBkeZ34dOOqbxosZPYLYEFScSGrvCAFqTT
         oleN7FqlpgSgST0hrVHnu9TrqgomnD1TrggowntORQmY1CBRQt/48fbh6W6NIRWF/TC8
         ON73FjWDSUyZEW3E0C3Jy6EKtd35DHwFdaVrsxGTvfKmmxXEf7upLa8lmCtL5rSNH7W+
         8aSolHzZt3q2amLcN6wK5PXcwCmQMboG4+WadIDtxn4LWmVUvARPvWz+uE3YcZow3QiO
         TlsFTZhMIZfBLdN3zM/07xTDg56WAqSl/Dkgimslb6KICbbbN+YL/hEr+2KwV6CwZppN
         2obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i+UHtLjigLcq6lQ+5dK9SsDTxO7T4J8GtHNuZmj8VkM=;
        b=iQMDMYhjTIX/ta3Z9xc82doERSEnFfPV4y7IFIBV6eENmpkWkCh2RNRSyLQ3FmnQeu
         FxJ0jhPMpgVPGARULJEicmp3gWBYB5ZXdpZbOJJBNpD3zJjOWTqOQ+4q+QJOZykSm1Rm
         PsNSbMtBlccRnzx4m2tB2uVlKJEfai/w2669v9+oOgLsfryyzVDMhjUWYd5cvAxclSm1
         Myiuu1v1l5F3DKvtECvs89Kwm71JrmVVxt/TMnwbjF3oRvIhCFrfs9vaIYgiATJ6qSLs
         TBfeUxbMr99CK5Vlxtarn5f1BRsdTmJWXJSfHJ/x3c5uD36bZtZWVYnDUfK3AioF4ukc
         j3iQ==
X-Gm-Message-State: AMCzsaUCLLbjEWZeur5I91xXWiIcJ0VRp+TMqd8ics4lgVqkbGHruuOP
        dY9Dxuut+zZy7oqraCzW1RE=
X-Google-Smtp-Source: AOwi7QAAmGAVaiYSRYao2tJtJG1LCyhL/hZXE4aBlGCNnGgp9F1BEMS/qNr+L22ChtKMzab1eKlsXA==
X-Received: by 10.28.206.205 with SMTP id e196mr20242692wmg.149.1507200436418;
        Thu, 05 Oct 2017 03:47:16 -0700 (PDT)
Received: from [10.32.250.38] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 10sm15795254wrt.59.2017.10.05.03.47.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 03:47:15 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: lstat-ing delayed-filter output, was Re: playing with MSan
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171005034632.kzsspk7wsuk23kf2@sigill.intra.peff.net>
Date:   Thu, 5 Oct 2017 12:47:13 +0200
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BC2435F-B7CD-4B82-B5BD-69B4195EF728@gmail.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com> <20171003234153.pmslizidgbifl6en@sigill.intra.peff.net> <20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net> <20171004193005.GD30301@hank> <20171005034632.kzsspk7wsuk23kf2@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 05 Oct 2017, at 05:46, Jeff King <peff@peff.net> wrote:
>=20
> On Wed, Oct 04, 2017 at 08:30:05PM +0100, Thomas Gummerer wrote:
>=20
>>> So I dunno. This approach is a _lot_ more convenient than trying to
>>> rebuild all the dependencies from scratch, and it runs way faster =
than
>>> valgrind.  It did find the cases that led to the patches in this
>>> series, and at least one more: if the lstat() at the end of
>>> entry.c:write_entry() fails, we write nonsense into the cache_entry.
>>=20
>> Yeah valgrind found that one too, as I tried (and apparently failed =
:))
>> to explain in the cover letter.  I just haven't found the time yet to
>> actually try and go fix that one.
>=20
> No, I just have poor memory. :)
>=20
> The obvious fix is that we should check the return value of `lstat`, =
but
> the bigger question is why and when that would fail.
>=20
> The case triggered by t0021 is using the new "delayed" filter =
mechanism.
> So at the time that write_entry() finishes, we don't actually have the
> file in the filesystem. I think we need to recognize that we got =
delayed
> and didn't actually check anything out, and skip that whole "if
> (state->refresh_cache)" block. It's not clear to me, though, how we =
tell
> the difference between the delayed and normal cases in that function.

Oh. Great catch!


> But I think this lstat could also fail if we are checking out and
> somebody else racily deletes our file. This is presumably sufficiently
> rare that I actually wonder if we should just bail with an error, so
> that the user knows something funny is going on.

That sounds good to me!


I tried to address both issues here:
=
https://public-inbox.org/git/20171005104407.65948-1-lars.schneider@autodes=
k.com/

Cheers,
Lars=
