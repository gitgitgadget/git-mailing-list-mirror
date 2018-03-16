Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A349E1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeCPVlW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:41:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42978 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:41:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id s18so12898027wrg.9
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=v6O6ySyEUgKhuKD9lyQ6TPP+U352Y2Flpxv+nOj9fQs=;
        b=AUoOAnMB4Fl3B8DrIKe1Qld1cVpwcfGxdUBfWDfUwDmTjMk4apLP41tA9mhCMQ6UiZ
         wdGIxJ+FhbwXL6qiqk/CCBSTFJK3SDbF22FLly96WpWWzE37/0BfOuZphfXi83AOBtGd
         zTJqPnSxrEoVLQpKNc+8bq1V3pVyWUAFrUa8OnMs8P1IWDJO3rEUZ1P9xuE9caLTSb25
         C4gZBCSSfGbSCJPADScRXiYq66rFtTuZdVxo4OKrwqFmu3BXgTL1aatYDb4pXMjYCNvL
         3QlJWDyzaxCTsPpOL6lQa7eJVG4pUZCmnDwEoEDhF17r9ouKGGb1YNgqmkxApubh0EgC
         DFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=v6O6ySyEUgKhuKD9lyQ6TPP+U352Y2Flpxv+nOj9fQs=;
        b=tn7weYln+ATFTbJeoTIwuo+JHcKa+9IEOBifPMtFkZNb4Eeu1Gk6KRNzSme7bdy3FY
         6pIxBU2mE10z68fAi8Ki0mBrBVYB8t7Wqp3qCmCJmq0BOYoXDaZIaryD6smIJT1pFOU7
         UVNI8Jwly/REDQzNhUwYfEoK8E4OCir6kKRHWBa/I/GhCb5lxqZ0uiGJ18Pvp9gLVHpb
         DC1bg0lD9Xo1z3XqVXjjtp8Ds9rKTB9KZRne96Vidfn+5xSAHxZrlNZyExM665bx5Gla
         TAV90tbIIWL1MllYMPpugi0kaqg3HNXiPJ5qtWjlB1F5siFUJiiYq21T9CvCILYT7K54
         WbrQ==
X-Gm-Message-State: AElRT7F4hQHXHvBDXl4XwvCLk0fDNGxbsb8NlMeFPqNejhA+kb9/lKD6
        ZJn2KdcQ8STp1llbSQ/IcbQ=
X-Google-Smtp-Source: AG47ELtcDSaYdpEeeLTvWYvb18hPklo5B0GofTcegDGZpiMPga6Bm5KshuDnI2V8xTIjtNVqg2ugVQ==
X-Received: by 10.223.226.1 with SMTP id j1mr2842537wri.13.1521236479608;
        Fri, 16 Mar 2018 14:41:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 59sm1681903wrj.5.2018.03.16.14.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:41:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: use --compact-summary instead of --summary
References: <20180316200648.18256-1-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 14:41:18 -0700
In-Reply-To: <20180316200648.18256-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 16 Mar 2018 21:06:48 +0100")
Message-ID: <xmqqlgerzojl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> For reviewers, a couple fewer lines from diffstat (either cover letter
> or patches) is a good thing because there's less to read.

I can certainly accept that there may be some reviewers who share
that view, but me personally, I would rather have them outside the
main diffstat section, so addition and removal of files that are
rarer events do stand out.

I guess people would not mind an option to use it, but they can
already say "git format-patch --compact-summary $upstream..", so...


