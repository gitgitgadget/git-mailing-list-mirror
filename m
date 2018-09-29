Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16511F453
	for <e@80x24.org>; Sat, 29 Sep 2018 18:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeI3BJh (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:09:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37414 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeI3BJg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:09:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so8701012ljk.4
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a94kCq3k0gleMykGV4S6kEWjcFu4crXCWJupg7CdrFA=;
        b=Ek1jn4Nr61fHqw+Jsv0igD2jqAXQcQFL3MoLXU6D1erQOPNR/jwNT462jJG1ce1FUZ
         0Dj70zIfgq+bVgHzmbxqjpREiEm/0JF2rHwYiLCgvFdSPnoUzIIZ1/SURqFgnELtcNwo
         73Rol8beBkaghyD1YE8WHf7gv32R2RWqIWlN5wlFiFDuZuQmkBM713QbRAp0k/8vwEwf
         49QMTz7wkMBgdZ5FfLWqwzkMIafo68/2u2mOmaiDqnHEu0uUuHOAqEuLCv37MRk6WMCf
         0m5D+2QNKmtJheYQ5JsRgfvfQ/tBmPAOTC4i2nfbJ72N5YHD4RZ/q+gk2o58UBPeeA6X
         d+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a94kCq3k0gleMykGV4S6kEWjcFu4crXCWJupg7CdrFA=;
        b=juxwpPyidZDAt7sH+InRa4bYl8dyyjmgzd98GI75OKQuOV8Tk1tqKXXLWlKziHyeTP
         qZKvyRtcGdW/wuKTyaGV6ZGGIA6StK5wJth8/B0/Ag0bjZwcyAr0jw6l7zUzxn9/jLrF
         S5I6bfMBnabEEHutUgQysr6O4WOGZmoDsa+KnPLteC/8qpLvzV1Lx9f61U9PNVzg5nZD
         61M+aQBlfx77oZqjFCnOhN4MzmQmVjXEW8eNRZRNUhXJ/7o6tYCeGWNHvvVfy5QWkzzh
         IGs7LAwY7cbD8FuGRsnUCN8wkEsy76lTKZlExD3IXg4q2ZnJKdXKWUhb8VjxfuIb8WTZ
         SXUg==
X-Gm-Message-State: ABuFfojjn12KZcLICNJndmow8S52Fm1R2LXBo38dw1yZ8R0B2FtyK+0A
        hsdsIErjCvpK8O9JeDl31yE=
X-Google-Smtp-Source: ACcGV60o1vheOZNWPHJPD8O9XznUZKysiwUCc2O3Axu7eaHM4rw2cwcUVPN1JZn4N09k/d8EPmL2XA==
X-Received: by 2002:a2e:5614:: with SMTP id k20-v6mr2208991ljb.48.1538246406289;
        Sat, 29 Sep 2018 11:40:06 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z3-v6sm1697801ljb.71.2018.09.29.11.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 11:40:05 -0700 (PDT)
Date:   Sat, 29 Sep 2018 20:40:03 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] fsck: check HEAD and reflog from other worktrees
Message-ID: <20180929184003.GA20362@duynguyen.home>
References: <20180922180500.4689-1-pclouds@gmail.com>
 <20180922180500.4689-8-pclouds@gmail.com>
 <CAPig+cTcaS-J5CwNo5RqeZiJYQ9OTt+Qzo08tdDjvZNaVSK2OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTcaS-J5CwNo5RqeZiJYQ9OTt+Qzo08tdDjvZNaVSK2OQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 04:41:32AM -0400, Eric Sunshine wrote:
> > +       grep "main/HEAD: detached HEAD points" out
> 
> This message doesn't get localized, so no need for
> test_i18ngrep(). Okay.

Don't remind me. I started to mark all strings in fsck for translation
and faced the reality that I would need to change a lot to
test_i18ngrep :(
--
Duy
