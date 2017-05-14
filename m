Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B91720188
	for <e@80x24.org>; Sun, 14 May 2017 03:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdENDjd (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:39:33 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36118 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdENDjc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:39:32 -0400
Received: by mail-pf0-f173.google.com with SMTP id m17so47093325pfg.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vricVL6jv5Ytqe/utk7c64xA8PgaSUFEE+pL+b2ujio=;
        b=bTdZtHtfGMtTAQu4SMPsSFplv0B1niXdk7PtHyGj0QgYDNPTCaxSSRNAV27AtCBEmW
         2uzDWnu9o7sGYhgTFLHRuVzoGy2PTi6rO2oZZE/0Fn9jzEweZFpiGhhTq905cDYN00T5
         PoAr3zo8zDPL5laQvbBLh9BF/Rvh+nc96F/6UaxloIyAMX/3KgvvSIJpqCMMQih6qZMQ
         +wzRiDBxTgYlqmplYdeT1Rm+BD7DEskYyy8aSajt81umSaqVkJ7xLGAf2G8VnFyXJ/l0
         /M3aMiMUs4sYax6O4W6O0GL4vMxX0wnj4RqjMVQBG6hm1zhtZxsYbZfOSRODynf9nVWO
         Lxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vricVL6jv5Ytqe/utk7c64xA8PgaSUFEE+pL+b2ujio=;
        b=Dqd7UdjYF/AX8jp397tRRwS0ovZKll2xvZuwQ+572e7KhYqBxxcA4MIImg/yr42NlC
         IeqA1DGzfqaiKmU2Vu79ft6Q4H9G5ux0m/uaJAeIygNBN/BRuuwfhHO8QRSbZ/jD4SjQ
         H3PbCFIfAcWMr0PnkJB9OsdLSQpl3DWm6FhAomkNpkeVJLkb85xOdn1Yf680N5VO5z+Q
         IM0wKwh38j23aYNT58HBO4CZ/A7F4KYPOJImp/dV5mcxSUSjQoQvy/e5plIVDmpE5Vtj
         ZsQPrmFRVdCVp1oMhH7/fJKR9ndl1RHXzhCh3ui4lusVGGxsEis9UH/Z1duzSScElkS/
         +wLw==
X-Gm-Message-State: AODbwcDpYm034/xwgUZ0w6tH5JrqZhwiuUonQx4wFZaCvzFN7NVGc4kB
        Y06ZXcn5s4F/rA==
X-Received: by 10.99.97.68 with SMTP id v65mr11974498pgb.76.1494733172203;
        Sat, 13 May 2017 20:39:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:3:1ec0:f93c:462:46cc:5c0])
        by smtp.gmail.com with ESMTPSA id z68sm12324626pgz.14.2017.05.13.20.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 May 2017 20:39:30 -0700 (PDT)
From:   Brian Malehorn <bmalehorn@gmail.com>
To:     peff@peff.net
Cc:     bmalehorn@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 0/3] interpret-trailers + commit -v bugfix
Date:   Sat, 13 May 2017 20:39:22 -0700
Message-Id: <20170514033923.12870-1-bmalehorn@gmail.com>
X-Mailer: git-send-email 2.12.3.9.g050893b
In-Reply-To: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
References: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> As I said, I'm a little iffy on doing this unconditionally, but it may
> be the least-bad solution. I'd just worry about collateral damage to
> somebody who doesn't use commit.verbose, but has something scissors-like
> in their commit message.
> 
> If you were to switch out is_scissors_line() for checking the exact
> cut_line[] from wt-status.c, I think that would be a big improvement.
> We'd still have the possibility of a false positive, but it would be
> much less likely in practice.

Yes, you're probably right. Using is_scissors_line() was the path of
least resistance to fix my bug, but wasn't really the Right Thing.

I've made a new patch that uses the wt-status.c code to determine
scissors lines. "git interpret-trailers" now uses the same logic as
"git commit". This patch replaces the original 3.

And yeah, this is yet another heuristic in interpret-trailers aimed at
git commit messages. But it's hardly the first heuristic we've added,
and I'd say it makes more sense for interpret-trailers and commit to
parse the same format.
