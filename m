Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4155E1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 16:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfJKQRN (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 12:17:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38165 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfJKQRN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 12:17:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so10787296wmi.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbcuKOAwVi4CZqwZa09bkBPm/Cd2lVaugl7U66QceNY=;
        b=s0CM2Wc8Ghig8FSgTNHtCaJh0wU6RYciZrVCN0D8L5guctGdo8R6LfmQjutQ+OTd4+
         EKIq54QUjxy6HLkGLHVUX6Cx/sWB73jEXniF9iMi0VdeVkBx0Ej9m6V9oQ3Creom9vBc
         imZjmveoxIIJ45PLov7qE3JYd8Fl+kxn48P9fXfM7hNDNmtAYA7CzPHCHbumGLMiODqx
         Bi1p1UXKWIB+QEwVx0gLv4xVRMrE10VweK08u3oUrlDuI06m853wFTvSSUScQTiTmS5q
         HiJCQAQGEcZm2bMO579oAedrVvaOF+uwpQgt+q8KDGJ/vtz2PS03WrPmfBYp2nX3UhSU
         AedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbcuKOAwVi4CZqwZa09bkBPm/Cd2lVaugl7U66QceNY=;
        b=eZ85BqA5P50Y85uVgkfvG531jA3iL9Hdt2gUp+7vfp0OvyHJEoEpTZPRyrFg0nb7Ov
         977kgGPkuZTFqOQcJeG5xj7TWlbxFshATWjnko86QETVtDO1J3IUKiDIfLx9or86kqxG
         vrCTKaqwMHBx5m2PuGjYscaU4UN9X+c0wHMATqCxyvTcAXNGoeYyb0zRBLZz8lI98n71
         OYZGRT7NJKpONTfM2CC2PajU2ItR7trRQ4O+9XRLehJ3/jRsry6DGIB7ps9G2Z2zbgA6
         6GyUlpaBd6ZfK6ku1K17IAVIIqluKHJFlrbtCVC54H4nQ9NIu7NZKhKoa7WDE+7ipRAD
         Z2IQ==
X-Gm-Message-State: APjAAAXRTPPdz+9ZvRWXkfO/TE2Z3GbgbzXJEOF7C/vXmGkAiqam/36Q
        NI9IC6BRaUlgTFV2TqBlTmM=
X-Google-Smtp-Source: APXvYqzotyfP9GtOu7eQAszg0fvJlU7RoLU0si7MJu6sS0joFezmMY7yRZsEVQWT8aOsgnj9EzygFg==
X-Received: by 2002:a7b:c924:: with SMTP id h4mr4019794wml.46.1570810631153;
        Fri, 11 Oct 2019 09:17:11 -0700 (PDT)
Received: from szeder.dev (x4db30d3a.dyn.telefonica.de. [77.179.13.58])
        by smtp.gmail.com with ESMTPSA id y14sm13713849wrd.84.2019.10.11.09.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:17:10 -0700 (PDT)
Date:   Fri, 11 Oct 2019 18:17:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] format-patch: create leading components of output
 directory
Message-ID: <20191011161707.GN29845@szeder.dev>
References: <b172eba0b748c3f0f638786a5cfba905aca385cc.1570782773.git.bert.wesarg@googlemail.com>
 <20191011144650.GM29845@szeder.dev>
 <CAKPyHN0s8Rc8Sbp7ubyJ5cTDC5oh4Re+wqyTUWUo+3HgpKfECg@mail.gmail.com>
 <CAKPyHN22-SnZ2_o1MO6EXuWk7S2AAWGQSjxu0OrhDq4pw=ap=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKPyHN22-SnZ2_o1MO6EXuWk7S2AAWGQSjxu0OrhDq4pw=ap=g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 05:47:44PM +0200, Bert Wesarg wrote:
> > > > +test_expect_success 'format-patch -o with no leading directories' '
> > > > +     rm -fr patches &&
> > > > +     git format-patch -o patches master..side &&
> > > > +     count=$(git rev-list --count master..side) &&
> > > > +     ls patches >list &&
> > > > +     test_line_count = $count list
> > > > +'
> > > > +
> > > > +test_expect_success 'format-patch -o with leading existing directories' '
> > > > +     git format-patch -o patches/side master..side &&
> > >
> > > The previous test case creates the 'patches' directory and leaves it
> > > behind, and this test implicitly relies on that directory to check
> > > that 'format-patch -o' can deal with already existing directories.  So
> > > if the previous test case were to fail early or were not run at all
> > > (e.g. './t4014-format-patch.sh -r 1,137'), then that directory
> > > wouldn't exist, and, consequently, this test case would not check what
> > > it was supposed to.
> > >
> > > I think it would be better to be more explicit and self-contained
> > > about it, and create a leading directory in this test case:
> > >
> > >    mkdir existing-dir &&
> > >    git format-patch -o existing-dir/side master..size &&
> > >    ls existing-dir/side >list &&
> 
> one question: How about removing this directory first, just to be
> sure, that mkdir does create a directory?

I'm not sure I understand...

Do you mean that a previous test might have already created and left a
directory with the same name behind, and then this 'mkdir' would error
out and thus fail the test?  If yes, then you're right with your
nitpicking on my nitpicking ;)  Though instead of 'rm -rf'ing that
directory I would suggest 'mkdir -p' to simply ignore it if it were to
exist.

