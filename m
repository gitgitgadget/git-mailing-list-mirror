Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECDC41F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 09:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408779AbeKWTwv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 14:52:51 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33179 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393651AbeKWTwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 14:52:51 -0500
Received: by mail-wr1-f42.google.com with SMTP id c14so5945138wrr.0
        for <git@vger.kernel.org>; Fri, 23 Nov 2018 01:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurrell-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GrKMi6RVF27M8v89nePRQoEF7zdVvnYySx/ArPI1kD4=;
        b=v+PK/jgwvNxT2bn+9B+BKrAQ0j9gpv8K75d3YyvEKXdHC4QzYkWopeskpAc+8tra71
         If0taoEhHGr+e+xGgQ5PxEJFnkPq007LoTHZfHaIzynUOPyFu2S6BckUrTJh83axOBy+
         Hli+EAWJr9gJ0sYJ3htDBrpWd36svt/BNsAeRQdzJIYWQcjuKWckTsTDB86tapaFsyTn
         112RLZbmrAX2rToAJ1vqIox7JMukurP7hgV6owLi8y2w3bouR0oSd10ucADbYKU0bYhy
         Z+Vxwn2UtjHAL8+iOUUvV6poSSvgCq1LtZhafaTo9BejX4cbom15hpS9I5xzJDtGY/vI
         gqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrKMi6RVF27M8v89nePRQoEF7zdVvnYySx/ArPI1kD4=;
        b=HGf9WBunRYtErLQ/FM37gEf31flsvy2T+XIckVb0yVO0SUpoTb/uIPJ/PotygF7iCS
         vCjEvMrKNoYW1szXu0li39n6vLoYTajSgXeYTvMcBIB4BRTT/ihDszdfN/n8txLLg9dA
         iCONloHx3CXHg0U7eq+t7pu7Ugl0bbvVpjD03sJmNLoxNBWOu0CpNBDvMJzuOiloUj4x
         s6LvroCTUiunwmM/JQKgaL21Vch49ls0ewqjB9IaYAr6sewSI6yRWaxJxuOhlXCEiPai
         ETHt05BB/qtIxUD3hMI75iqN3PBCrFPL8krZdE5ePpJr57S0rTUy2fGduojzQtmQ1Kdn
         Vxrw==
X-Gm-Message-State: AA+aEWZfjo6iIJEPi1dKyXa/cXL3UOdgx1zKyNWx+ERrojzeEcGvvYMl
        19KDfCYuVYi3c6GiDygzZ0kZp5JJ6Iw=
X-Google-Smtp-Source: AFSGD/X0ThBYAoC8ReuJs6X3gmzwq+S86fc1qRsdeFEGBq6/u2+XG5BCUI9XfFOA6yVVc4X+esPjFA==
X-Received: by 2002:adf:8421:: with SMTP id 30mr13375197wrf.153.1542964166819;
        Fri, 23 Nov 2018 01:09:26 -0800 (PST)
Received: from localhost.localdomain ([194.224.154.179])
        by smtp.gmail.com with ESMTPSA id s8sm9805585wrn.44.2018.11.23.01.09.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 01:09:26 -0800 (PST)
From:   Greg Hurrell <greg@hurrell.net>
To:     git@vger.kernel.org
Subject: Document change in format of raw diff output format
Date:   Fri, 23 Nov 2018 10:09:07 +0100
Message-Id: <20181123090908.43445-1-greg@hurrell.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181122160154.GA28192@sigill.intra.peff.net>
References: <20181122160154.GA28192@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> On Thu, Nov 22, 2018 at 11:58:36AM +0100, Greg Hurrell wrote:
> 
> > diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
> > index 706916c94c..33776459d0 100644
> > --- a/Documentation/diff-format.txt
> > +++ b/Documentation/diff-format.txt
> > @@ -26,12 +26,12 @@ line per changed file.
> >  An output line is formatted this way:
> > 
> >  ------------------------------------------------
> > -in-place edit  :100644 100644 bcd1234... 0123456... M file0
> > -copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
> > -rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
> > -create         :000000 100644 0000000... 1234567... A file4
> > -delete         :100644 000000 1234567... 0000000... D file5
> > -unmerged       :000000 000000 0000000... 0000000... U file6
> > +in-place edit  :100644 100644 bcd123456 012345678 M file0
> > +copy-edit      :100644 100644 abcd12345 123456789 C68 file1 file2
> > +rename-edit    :100644 100644 abcd12345 123456789 R86 file1 file3
> > +create         :000000 100644 000000000 123456789 A file4
> > +delete         :100644 000000 123456789 000000000 D file5
> > +unmerged       :000000 000000 000000000 000000000 U file6
> >  ------------------------------------------------
> 
> Yeah, this looks like an improvement.
> 
> I think in general that we'd continue to show 7 characters now, just
> without the extra dots (though it's auto-scaled based on the number of
> objects in the repo these days, so it's not even really a constant).

That's funny. I looked at the output on (what I thought was) a small
repo and it was showing me 9-character abbreviated hashes. I guess I
just got lucky. Tested on a basically empty repo and 7 does look to be
the default.

> PS As you noticed, "git log" we don't promise that git-log output will
>    never change between versions. For machine-consumption you probably
>    want to use plumbing like "git rev-list | git diff-tree --stdin",
>    which produces unabbreviated hashes.

Thanks for the tip. My mistake was thinking that the `--raw` made the
`git log` output somehow more plumbing-ish, but I've gone ahead and
switched to using git-rev-list plus git-diff-tree instead.

Anyway, patch follows.


