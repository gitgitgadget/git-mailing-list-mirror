Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6407720248
	for <e@80x24.org>; Thu,  4 Apr 2019 12:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDDMLH (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 08:11:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40894 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDMLG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 08:11:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so3124505wmi.5
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JulnGkEwtWJI3ic5JISTxR2L7cQx0s+HW4TFvRKqCZY=;
        b=tTuqrw6nXsRdbc1TZuO1FnilQFhhSXxLj3aaqKdvTPjzem5Yu6IW++QoYpPyvwbQmz
         krvr+OjPcFyDs42nhxlY6Jjbp+teWnyjPOYRZHETotQ8mkBCNJbTVUQiCRVLP8iD8YrW
         fQj57Ol7DXHhnokflKEJnbqx+ZxzK9q4Yn6lwaejYvQSEN3O/xWdb7z0Q4RqRovgdrTb
         U80n064pyUvN3/BqK72mBSt1OVLB1w/DwwlSVPi9fj/MNAYuMlO4/ZzCf9ofNXlIZlIm
         gELOLXmy7UfqYCclX5reY5Hts03w+w5LHRruNrEXtrFKL/ORArFnkXzW95kkOKBhcZY5
         bQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JulnGkEwtWJI3ic5JISTxR2L7cQx0s+HW4TFvRKqCZY=;
        b=GAqeRb7D/rp4HxFUATGsh+dk/30S1M0Kba/CzpCuC3wVr9QnCEwkwe0cz65Q2h5p/B
         x652dtVUAJvLfGTB+jBbrXl94zZplJVsGH9c/9HKaCvVIW8pwZC8dkc9b10KTVbckKiI
         HtB84c748h3WX15JvEzolwAdQQcENPt/hKG4ojpjZT+ndxjmz0Eobtj52zwKYWKw9GW2
         6rTMHWLp1HxpngG/VPa15Evz3QZrIstEmP5YGP7yypICUxE6Es7LvNHKhJ35N9SWzNhm
         5NxEnUqKrrAjJBCKoQG2PUVRiEVjT9i4hMzg1WM9QkokjWLH9o9YHtWHnkDblRAxbd3/
         CpUw==
X-Gm-Message-State: APjAAAVZspD0WZPHvfvLHxdVSgPBqYkS2MgHs0P1ccjftbtoevKRlHqw
        YJjIUWsiGr149+PaN5OSakPwHJpPf9u5p4f+G7M=
X-Google-Smtp-Source: APXvYqxvTZFNulc8SH48ZLUTRo9PME7GXHw9o7D55C5tzRSeTxqMIts157x85Uy3Ge5IQo3LXxzVQdPfHmUKF3rSllM=
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr3850402wmd.22.1554379865109;
 Thu, 04 Apr 2019 05:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPzUpa3c9PSfJNo6rzUOt-bDUDYrcn9JcHgSGW43KuRYg@mail.gmail.com>
In-Reply-To: <CAMknYEPzUpa3c9PSfJNo6rzUOt-bDUDYrcn9JcHgSGW43KuRYg@mail.gmail.com>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Thu, 4 Apr 2019 15:02:33 +0300
Message-ID: <CAL21Bmnm0Pk9mHzetSx0_GDcUc0SJZ5giWoFUdTMLCZ+KutEVQ@mail.gmail.com>
Subject: Re: [GSoC] [RFC] Unify ref-filter formats with other --pretty formats
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D1=81=D1=80, 3 =D0=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 22:54, Kapil Jain <=
jkapil.cs@gmail.com>:
>
> Reference: https://git.github.io/SoC-2019-Ideas/#unify-ref-filter-formats=
-with-other---pretty-formats
>
> I have spent some time with both pretty.* and ref-filter.*
>
> First off, we are aiming to reuse ref-filter, so avoiding any sort of
> re-implementation is recommended.

It is recommended, but it's normal situation to re-implement something
as a middle step.

>
> Now, coming to pretty.* and ref-filter.*
>
> suppose, a function named xyz() in ref-filter.c seems like it could be
> reused in pretty.c.
> since ref-filter doesn't use any struct of pretty.c. The xyz()
> function in its original form is not useful for pretty.c.
> So now, in order for the xyz() function to be useful in pretty.c.
> Function xyz() should be using structs of pretty.*
>
> now, if we make xyz() use the pretty.* structs, then its
> re-implementation and not reusing. its like keeping two different
> functions one for ref-filter and another for pretty.*.
> which is what is already happening.

It's OK as the middle step. Another approach is to add using
ref-filter structures and continue using existing ones, so that you
have 2 duplicating flows of data. Reuse ref-filter logic, and then in
the end of the patch delete duplicating logic from pretty. Both these
approaches could be useful, choose any of them or design your own way.
I deleted so much code that I wrote, I advice you try not to afraid of
it. It's OK to make something and then rewrite it several times. The
only thing that matters is the final result.

>
> please provide any starting point for reusing ref-filter. i don't see
> any in pretty.*.
> reusing ref-filter specifically in pretty.* is not the motive. please
> point out any file in entire code base, that you may feel can reuse
> some ref-filter logic.
