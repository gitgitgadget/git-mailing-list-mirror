Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6DF11F859
	for <e@80x24.org>; Tue, 30 Aug 2016 10:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758069AbcH3KqZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 06:46:25 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38473 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758037AbcH3KqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 06:46:24 -0400
Received: by mail-wm0-f41.google.com with SMTP id o80so28562123wme.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+GMRfzdzvPZwrddW4niwF6dk0xGuVf7cCWr85TJS/oA=;
        b=DMCaivihBNJ9ws9X1G4EbtuN1TEIQoKuKEM8v2siuf9HOAS8Ub2Z83vhy8tuo1SFEv
         21lX6OGFiua8JLpdxrk/NwPrvKIVup/NXfJElgNoI6UNAR4TdlsAKfwBXL3uUyEZsw87
         zlooKxZj6ux9oQH2bNz943RMaHwZQE2HbBgu24tNZcivuTRBGE8anmvnr9ENNt0KLfFs
         1HLjI5WxO4T3KucY/A7VhrbHxGjizBYFGozPcO/3o7lDiFcN3Z6kRnHZTopTv4nlMcYV
         VXxurYVm652YOJbIw2wZpHAemzPcaVYd+zrR9zQHATg5MP3L7EgABdI8ohkaiHEtxa6U
         25dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+GMRfzdzvPZwrddW4niwF6dk0xGuVf7cCWr85TJS/oA=;
        b=R82iz59Wp4JUChSBdGj9Ze6aZf8LV9sTP8EclfxOWNANCHpI52Nl+vUtrnOFsOdH2h
         gU0eYG2+sLyKWxFS7gBe5sSCECW6QxQU72Tn62WhkJXWaGvsTrBaZGwboJoe+l2QdvpE
         PpumFDwicHNw6DiZ6QoJNV4/2/WMt1RgLyil4OLCtdOykJ6jeQe1Lh/E/QrjPqaWMDB1
         TSpmotHaRPyqe02XuO59OmcPrTdZY8Znal4YUUCKKzD2Xl6wVAB8OJvOW7Lv8yKW5cRn
         1bjSOOFMj4h0Y6Y52xH5yZ62AhFO3FJQhbMi4g400+03xUFmcAW66NMacxx0BilQFN0R
         ci4g==
X-Gm-Message-State: AE9vXwMMmyu287LC19MS6ACOy6iuIwIc8qQKa0Y05INnlXZKj/jwtd+BSiGLbj3Scxb8rQ==
X-Received: by 10.28.151.77 with SMTP id z74mr3025064wmd.117.1472553982795;
        Tue, 30 Aug 2016 03:46:22 -0700 (PDT)
Received: from [192.168.1.26] (afz108.neoplus.adsl.tpnet.pl. [83.25.155.108])
        by smtp.googlemail.com with ESMTPSA id b203sm3291632wmh.20.2016.08.30.03.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 03:46:22 -0700 (PDT)
Subject: git blame <directory> [was: Reducing CPU load on git server]
To:     Jeff King <peff@peff.net>,
        "W. David Jarvis" <william.d.jarvis@gmail.com>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
 <CAFMAO9yUMY5dqw-oWpKG1H-xska1AtDyt31_WaeJDyTieQLChw@mail.gmail.com>
 <20160829213101.3ulrw5hrh5pytjii@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <9fe5aa9b-5ba8-2b9a-7feb-58e115be3902@gmail.com>
Date:   Tue, 30 Aug 2016 12:46:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160829213101.3ulrw5hrh5pytjii@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 23:31, Jeff King pisze:

> Blame-tree is a GitHub-specific command (it feeds the main repository
> view page), and is a known CPU hog. There's more clever caching for that
> coming down the pipe, but it's not shipped yet.

I wonder if having support for 'git blame <directory>' in Git core would
be something interesting to Git users.  I once tried to implement it,
but it went nowhere.  Would it be hard to implement?


I guess that GitHub offers this view as a part of the home page view
for a repository is something of a historical artifact; namely that
web interfaces for other version control systems used this.  But I
wonder how useful it is.  Neither cgit nor gitweb offer such view,
both GitLab and Bitbucket start with summary age with no blame-tree.

-- 
Jakub Narębski

