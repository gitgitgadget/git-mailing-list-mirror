Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE8320373
	for <e@80x24.org>; Mon, 13 Mar 2017 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbdCMTpD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:45:03 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32987 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdCMTpB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:45:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id r45so7539184qte.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q+SMiumXh3PUDb/RBR6Fus7B3KS5PSVkVxxImuXfs4c=;
        b=S0n/PgwJqha6WCtOIA622K6zItZCn5mIx+2NtgSrdCs4EfbleQJJgzuurZe0LXz+U0
         UMnxqexTeHw902d4Kxnj0ijXJF/KmEkgvfizXMrwRCB227HJCvDvWYHZkY/AvazLfh9M
         7RVa76Ht20I5puhhuLg7PRiRiP751fDdZ3rt5Nc056fqdufLLTmbMObnI2+hiEbm6m4U
         TiFXE7o6yH0vRJ15GaS4jmU5QJBEAk43k7Rttz14GqfGUCO3l2pXjNYRsEydoqu5LZLp
         /mxkQcmaQ7zqQOEd3mS7xdl6zwXhaRRMNKxtVv8vsyq02KaYA29/UxJNfXkAkERZM61D
         kFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q+SMiumXh3PUDb/RBR6Fus7B3KS5PSVkVxxImuXfs4c=;
        b=kPtpyrp9V0XIn/fioQ+MGypCee7pHEhm5T/Lc5AyB1aOWzwEjNAo2tXAt9xXZNVAt5
         7DGOmHRrXXckqgJgzkWihu/2blg6rKtsMvzWnNd1GF4MByokAkb9DiH7dmqFUgLi9dlH
         sYEqb7O8viOpsjrJZODewgGMNvGKKtwc8mXL5ITVIiYsOjsx56X/bGB+1LhcFsm66fZn
         gcK3/3D4SG7UhTFoNpAOSD+vyKoqVa1XzjQzh3jDFUS4qWGgd6xmVqcoxCcIlPL1wfDW
         WwgUwqt5o803YC7bQLownCqXXh99HUVSG66fUxVBc/Ozh9GT5mVJ80IeJVNRUUUYPF03
         mpDg==
X-Gm-Message-State: AMke39nymxQMBimMPg2oA1Z7TYCGMJz9aTBv0su+UdcDJHOSttT/tSZ+twsimMUbZxotjA==
X-Received: by 10.200.45.135 with SMTP id p7mr33321331qta.141.1489434299967;
        Mon, 13 Mar 2017 12:44:59 -0700 (PDT)
Received: from dhcp-ccc-4425.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.gmail.com with ESMTPSA id c144sm12867170qkg.8.2017.03.13.12.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 12:44:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC][PATCH 1/3] path.c: Add xdg_cache_home to get paths under
 XDG_CACHE_HOME
From:   Devin Lehmacher <lehmacdj@gmail.com>
In-Reply-To: <20170313184837.wnluuyflbx63cwlm@sigill.intra.peff.net>
Date:   Mon, 13 Mar 2017 15:44:58 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <96F783CD-F784-4B40-81A9-5AD48A9395AA@gmail.com>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
 <20170313172232.96678-2-lehmacdj@gmail.com>
 <20170313184837.wnluuyflbx63cwlm@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And one final note. I notice that we return NULL if the user has no
> HOME. But I'm not sure most callers are prepared to handle this. E.g.,
> if you have no ident set and no HOME, then we will pass NULL to lstat().
> On Linux at least that just gets you EFAULT, but I wouldn't be surprised
> if it's a segfault on other systems (probably at least Windows, where we
> have an lstat wrapper that calls strlen on the filename).

Right now we check the return value from these two functions and if it
is NULL we instead use some other configuration location.

That said I agree that this could lead to unexpected behavior in some
scenarios.

Devin
