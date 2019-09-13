Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6F01F463
	for <e@80x24.org>; Fri, 13 Sep 2019 19:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbfIMTLG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 15:11:06 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:32779 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388992AbfIMTLG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 15:11:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id u31so393946uah.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6MNriMX9upDL9bKaqLk2vhUfPZYMXmABmCqjyTj6FQ=;
        b=OH5otnNXjOiqqMcbcuTJXE4aPY27xqRnQdmI9XWti21KRCMnmoEzG6ccAsEpEvHTwj
         2WbHRQPf2Ry+ChsOpHWxJZvMwvTmqaaZtsBRIj+fSXokE4BdGUgFchX2zQ1iwFx+tlJ6
         jSwNT6Um+AihOM9yCYCF9IlbkKJdlOeFEAdOA+xihfVxzbMBUzwJUNOht0D/0ZqOESON
         28MrUFNhwzALpfQWjR/e3NUFbh0qOD+ZCQHj2T6u952cY3UWkGpNrbikpaI2zuTcsjtO
         BcEBinEVMSPBHYkb/jY2w+cpCiiRWPSD9uPPG1fLLTuZXH9UJVTZuHNRPCmLFgf1C7PO
         7MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6MNriMX9upDL9bKaqLk2vhUfPZYMXmABmCqjyTj6FQ=;
        b=rRI5lzAdXW/PVbu6yozliqdgJW5WcPcINHp6boEm0eaBvV4vTVdB1ccv+9hexOysom
         7B9NuLL+rNBnXZooSDF7poe+r4UL5siEWOBTLsGlDNFB/0iNKU9pja807zEiqVkxHdB6
         /5vmvBOOurmPN9CjlcFwsnp5a0MPX6fnGGmuAx7GwdOa42OMd8PhwF3IW20+3brPvdVq
         Hx4itFxvWhwcMR3/NC5gV3jtsH5BIwTK4OuKD0BLn35zj7y81+uw+HXL9OhfoVOg2HJX
         C+pj6TvALqpgzjYGbPtW7Of261oTWn2BopTXadJ4yl8FnuSRNi0WzJyYBFvKfafiZcD3
         T35A==
X-Gm-Message-State: APjAAAWBjPADrwDBYoi70uICOL57/uH+DgzFTOiog5/Kjn/x/AjRofqA
        fftKVG47o/Swu+VrfHxa/KfmHWRUJIQpYsB44rc=
X-Google-Smtp-Source: APXvYqz7+76FMQynevyJ4zCN60T/8W16vs1S0haaGJKxH/zd0s3ohiPa7jZjF2O2CWkLb0ksb7aPxmy/Py7qnsT5b/c=
X-Received: by 2002:ab0:4a83:: with SMTP id s3mr1952848uae.95.1568401865315;
 Fri, 13 Sep 2019 12:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190905154735.29784-1-newren@gmail.com> <20190912221240.18057-1-newren@gmail.com>
 <20190912221240.18057-2-newren@gmail.com> <xmqqblvodo1v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblvodo1v.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Sep 2019 12:10:54 -0700
Message-ID: <CABPp-BG1Hvr6joYh-qT6B-8iEetGtj2pE5Mo-gVjdDRre=yrag@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] t7300: add testcases showing failure to clean
 specified pathspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > +test_expect_failure 'git clean handles being told what to clean' '
> > +     mkdir -p d1 d2 &&
> > +     touch d1/ut d2/ut &&
> > +     git clean -f */ut &&
> > +     test_path_is_missing d1/ut &&
> > +     test_path_is_missing d2/ut
> > +'
>
> Looks like d1 and d2 are new directories and the paths we see in the
> test are the only ones that are involved (i.e. we do not rely on any
> leftover cruft in d[12]/ from previous tests).  If so, perhaps it is
> easier to follow by starting the tests with "rm -fr d1 d2 &&" or
> something to assure the readers of the script (not this patch, but
> the resulting file down the road) about the isolation?  The same
> comment applies to the remainder.

Makes sense.

> Also, you talked about tracked paths in the proposed log message; do
> they not participate in reproducing the issue(s)?

If there is only one directory which has no tracked files, then the
user can clean up the files -- but confusingly, they have to issue the
same git-clean command multiple times.  If multiple directories have
no untracked files, git-clean will never clean them out.  I probably
didn't do a very good job explaining that although I started with the
case with one tracked, that I view the case without any as the more
general case -- and that solving it solves both problems.  I could
probably make that clearer in the commit message.  (Or maybe just add
more testcases even if slightly duplicative, I guess.)
