Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C8E1F461
	for <e@80x24.org>; Sat,  7 Sep 2019 00:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391367AbfIGAde (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 20:33:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34337 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbfIGAdd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 20:33:33 -0400
Received: by mail-vs1-f66.google.com with SMTP id r17so5254306vso.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+82Qh5cj1oLRmemfjPZQnPgJalTO9ndCXaH/wO69bLQ=;
        b=V+iqoWYAdp8cNBRS/gfIj7QDgktIwB7hEVZ3STC2+Wqe00ipcvSZq71KKzCuJe+Ucl
         BapWnuy3+JOmevxySduxr41sGnW58rGA+V21V2vHn8iyj0u/h9ov/l1eDGIUaM8/9wOZ
         valfYyGeEhtCENejeoQ7gQz/eh1LTS+g+BUoDMZ1JhGGR8yhRtDNqGeqa0pJbk1EkL95
         IOkUeZhzkKCKKxxO9E7T2sSkwP61fSZbCU7Y/e+SQbEj5wK7Dx0gw42xySgMFpClHWF+
         C4D4T05mRohHX/PH0D5GcUaltBbxEEGYLLr1HBJAxXboqOV7hcB8W97SByyeHBV1Y/gB
         Fwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+82Qh5cj1oLRmemfjPZQnPgJalTO9ndCXaH/wO69bLQ=;
        b=bi8xwJm0GVxc8zcJOJI/3AtUNDgkXq5twwCywtEIe0Tj+GQCKsYNsRLAXUKhHrv3UE
         0i1KToHPwLOtvMWnovHFt4vwOiJrfaV/41s557dRlJonKMHb1pH1BcSjlc21XZo5RuWG
         1X1tG+9gTGxbgWkQb+mdCh+8ywghPcdHXVk3f9KiBlsDXDxwoV5iHlWQH1nWHIIi+f+K
         gHvbbK+Td4LS59hRNTPDDPv9ZNulYsoFa/96fhza3sU4iPwtPYFPiF0LeRC3HqltRB8h
         NQe+HohbVlhnEA+XK/GTX0LqBdXEeKhOakdRsAwZ8cftDkrm5ZR4FdO6GUUFHR9VGDrn
         qy5g==
X-Gm-Message-State: APjAAAVJPWyDwe/MoSJNIFjwlcr7AQhQnQQBta3jm5nQHetSULnAJvis
        sBgZbKTRZKecj6ZmVbCkXkv6Q1k4RTJ5WzX03m8=
X-Google-Smtp-Source: APXvYqzfWyDl7pqqoH0yd66VcJ3/xglUK+wOEfyXzf/BsIWhF5oN2MSUNk0jR5XwUsarh7yCBXQEk4pagA0zCO6lZyk=
X-Received: by 2002:a67:e98c:: with SMTP id b12mr385738vso.53.1567816412575;
 Fri, 06 Sep 2019 17:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190825185918.3909-1-szeder.dev@gmail.com> <20190905154735.29784-1-newren@gmail.com>
 <20190905190126.GA32087@szeder.dev>
In-Reply-To: <20190905190126.GA32087@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Sep 2019 17:33:21 -0700
Message-ID: <CABPp-BE51REGkEWSO1Dm-TS=vsY2BpoDCtOh1B2CNAaQBFk+ug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] Fix some git clean issues
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 5, 2019 at 12:01 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Sep 05, 2019 at 08:47:23AM -0700, Elijah Newren wrote:
> > This patch series fixes a few issues with git-clean:
>
> >   * Failure to preserve both tracked and untracked files within a neste=
d
> >     Git repository reported a few weeks ago by SZEDER[3].
>
> Wow, I didn't expect a 12 patch series to fix that issue...
> Thanks.

Well, to be fair, only the last three patches were about that issue.
The first 9 were about the other issues.  It's just that your testcase
reminded me of my old series and gave me another nudge to dig it out
and see if it helped with your problem.  I had to rebase it and look
back over it, and then found it didn't help with your problem, but by
then I had refamiliarized myself with the code so...

> > Elijah Newren (12):
> >   t7300: Add some testcases showing failure to clean specified pathspec=
s
> >   dir: fix typo in comment
> >   dir: fix off-by-one error in match_pathspec_item
> >   dir: Directories should be checked for matching pathspecs too
> >   dir: Make the DO_MATCH_SUBMODULE code reusable for a non-submodule
> >     case
> >   dir: If our pathspec might match files under a dir, recurse into it
>
> Nit: no capital letters after the '<area>:' prefix.

Gah, I should know that any patch series I submitted from a year and a
half ago probably made that mistake.  I've mostly trained myself out
of it now, but I certainly hadn't back then.

Thanks for pointing it out; will fix.
