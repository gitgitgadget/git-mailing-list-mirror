Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9F6C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 23:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIMXAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 19:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIMXAt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 19:00:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBF16B161
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 16:00:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c19so7747113qkm.7
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date;
        bh=V2ygG8CrwPY5yi9ybLVjqJRI/QSFULGJTuccAFeu1dM=;
        b=zKTI6O6X/7kyki5nl9zYzOjExaPbcR4/Ae1aDababTBD4C6p0XUNnNooNIm6PnpTbz
         fbeHXhMB97YouAQPHauLK9vj3IMIHHphfmwh5YUrn62QbitB3/NeDlxLcPD5nqu4RQEU
         BRSb7FLe21oDQLFryd4LHUHcxcr4f/hJc6ml17qX/nnYnpvrKQrG1ajx3i8j6oojZ0le
         uSLCEeQarcxAvI5VxPYvPSUnNr/dPegAPVcN9lqgQicV+Iq2hJKWsgHGXhXwSuB1BWjO
         +vyOnB+rJBC+KvFj+t/ApvOk85m6Iz9bp+GWzA4Y1sasprtcWtXoI/QYtJxYsJ1Bp0ge
         7IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=V2ygG8CrwPY5yi9ybLVjqJRI/QSFULGJTuccAFeu1dM=;
        b=g8nS0ITxpdt2bQW9vnqvYtfbGudYYe78jyce9M2uAd7C93Yyqh8yaWZ/sl6/8OSm5I
         RJlkkwKF9QRbs4beKS4c6plBs7fLKEVL2TOxlUNc1LWyS4oAcSL5aKi2I2M7aTsvXKWj
         hbl8RY19ODqh0Z48Kck9WvHUGscIJzCFTPmxAgNcyFSn2wcpSElMzHni45DIK5efgL9J
         v9G1WSQPQR1AupSsQZM1fFTSTvtm8EEHvPDoU5VmihzE/YuQ8kzxn8NPjAWe4gJUXKdn
         p91B8UanuCRQgThx5yKuXEztxFqOqYIq3tex4WB8mJjj9ZlXWckGXh7RN6jTKT88neFc
         MtyQ==
X-Gm-Message-State: ACgBeo3/aE2cny+RayKFMV8aul2TwrXj07qQOGFs+WdAycIqgeHUvG+3
        wKij+WAn/ei81ke6fINn0qASiwhqhvvCxg==
X-Google-Smtp-Source: AA6agR6zkmpT75dliq/n0F1mjVYqCtPLalIzVeZQEnz1bhGxl4mzSQRQlu/geAuzU7gwDSY0umwl7g==
X-Received: by 2002:ae9:ed43:0:b0:6cb:e245:2950 with SMTP id c64-20020ae9ed43000000b006cbe2452950mr19170136qkg.261.1663110045749;
        Tue, 13 Sep 2022 16:00:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a2a1600b006b9bf03d9c6sm620837qkp.104.2022.09.13.16.00.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 16:00:45 -0700 (PDT)
Date:   Tue, 13 Sep 2022 19:00:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: Git / Software Freedom Conservancy status report (2022)
Message-ID: <YyELnLai0jXsnt3W@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been a few years since we had the last big update on the Git
project's activities at Software Freedom Conservancy. So, we're long
overdue for an update.

This email will serve as a report on the project's activities at
Conservancy for the year 2022.

The previous report (from 2018, whose format I'll try to stick to here)
can be found at:

	https://lore.kernel.org/git/20180306231609.GA1632@sigill.intra.peff.net/

# Background

Git is a member project of the Software Freedom Conservancy. The Git
project joined Conservancy in 2010 so Conservancy could help us manage
our money and other assets, and provide legal representation for
trademark matters. Conservancy doesn't hold any copyright on any of the
project's code. Similarly, being a member project at Conservancy does
not grant Conservancy any influence in the project's development. The
technical direction that Git takes is up to us.

Interested readers can take a look at a more full picture of what
Conservancy does for the Git project at:

  https://sfconservancy.org/projects/services/

A "Project Leadership Committee" (PLC) represents the Git project at
Conservancy. The PLC currently consists of Junio C Hamano, Christian
Couder, Ævar Arnfjörð Bjarmason, and myself.

# Financials

The most recent data that I have a copy of is from the end of March,
2022. So the numbers below aren't totally up-to-date, but they should be
good enough to get a rough picture from.

We have ~70k USD in our account, up ~40k from where we were at in 2018.
Here are some top-level ledger numbers gathered since 2018-03-07 (the
date of the last report). Note that this is all double-entry, so
negative numbers are good.

           $-45,962.81 Income:Git
           $-43,590.05   Donations
            $-2,332.22   Royalties
               $-40.54   Currency Conversion
             $5,512.23 Expenses:Git
               $134.97   Bad Debt
               $514.43   Banking Fees
             $3,852.63   Conferences:Travel
               $113.22     Per Diem
                $12.88   Currency Conversion
               $825.00   Filing Fees
                $59.10   Hosting
  --------------------
           $-40,450.58

Most of our money comes from donations. About 5% of it comes from
royalties, most of which are from Amazon affiliate links on git-scm.com.
Our royalty program with Packt Publishing (who publish Git-related
books) ended in 2019, which accounts for the "Bad Debt" expenses. We
give 10% of all incoming money to Conservancy's general fund (these
numbers are after that 10%).

We spent some money in 2019 and 2020 on sponsoring travel for to the
Contributor Summit and Git Merge ($3,852.63, to be exact), but spent $0
in 2021, since no Git Merge was held. This year we sponsored one GSoC
student's travel to Git Merge, and I expect to continue this trend in
the future.

# Trademark

We hold a trademark on the term "Git" in the space of software and
version control. The report from 2017 has a good overview of the details
there:

	https://public-inbox.org/git/20170202024501.57hrw4657tsqerqq@sigill.intra.peff.net/

In response to some discussions we had with folks at Conservancy,
Christian brought a discussion to the list about rethinking the way we
treat our trademark in the future, particularly with respect to
enforcement.

See his recent email to the list for more details there:

	https://lore.kernel.org/git/CAP8UFD3WQ64FuXarugF+CJ_-5sFNBCnqPE0AEBK-Ka78ituKTg@mail.gmail.com/

# Travel Budget Allocation

Like I mentioned above, we sponsored travel for one GSoC student to
attend Git Merge and the Contributor's Summit this year. The process has
been somewhat ad-hoc, at least in the past, but the PLC formalized this
process a little bit more rigidly in 2018. The report from that year has
a good overview of the details.

Similarly, that whole procedure is (still) open for comments and
suggestions. Our main focus is to make it possible for new contributors
(particularly ones who have participated in programs like GSoC and
Outreachy) to attend Git Merge (and, specifically, the Contributor's
Summit) where it wouldn't otherwise be possible.

# Conclusion

That's all for this year. I'm hoping to make this a somewhat more
regular thing, or at least do it once a year (probably around the time
of the Contributor's Summit, when most of the folks who will be
interested in the details here will all be in the same room).

I'm happy to answer any questions on the list, and I'll propose a
session on it at the Contributor's Summit tomorrow, in case folks want
to discuss this further in person.

Thanks,
Taylor
