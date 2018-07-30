Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37721F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeG3Smc (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 14:42:32 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46596 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3Smb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 14:42:31 -0400
Received: by mail-yb0-f196.google.com with SMTP id c3-v6so5019942ybi.13
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elksT9mAAdlGfvEgOiG/l4y7B2XcVTErMshsxQ0sDp0=;
        b=r33FK7LsodTpf7TieRtfjhlmOFq+RwfgvLQUKSoo8AdD8QU1rCYUjaEaZncpJY/Bke
         X3+h9LeWf/oKzQzMJUyalo9v1JrGG2YuHssCYhS2TO6ikzGxy1WKkeegcDrZxeDK4C/f
         wMm94Rp2seOTWN11bgo9hyzySe9shAoOnhzzfFrBYJtcP3fPnhk4xPUFUaXjyJU9ZPeh
         8SIz438qNBU76D0c6sk5EZQVm8J2WEPXiSucy+9mZp66La3bNSXiveQ5I3CCRLqAC+7p
         MVY8VXgDJbIZxCZEuTso3a3yTj5Gq8DyyHe1aOdtEqnXzd0R+dw5yvh9f7Ak1T9QcIl8
         Vx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elksT9mAAdlGfvEgOiG/l4y7B2XcVTErMshsxQ0sDp0=;
        b=V864+Ry5fv8IwKHj9N/lpiPDBJBu7QcR0oXTV6z3lCiVNiemuTLij2loV8ykmGtI4e
         2WQxGOkHfpe5iyjdBOB/z5EAxKbPmbx4n05SrmeJLiXk72AcVnpfD6FsYH9B4B5EfhjM
         PLZia7gE75n91F0lqqHGjvPcJJl3i001UacjkTNg0iJzFM3fmNSutTlMe8TmFmB0dCw2
         wXdpG2Esf4eXyUe9XWOpgMzK+yxqTalwBZ6WErHIDaEOxTkqJH1tPgNy9eL1kAmml2F1
         AxadF6iJKnd9gMC3wpszmujKpAGB53nPakIQPRnpGI+RelyoWlvYvNJc8XKRUaq406/S
         hmBw==
X-Gm-Message-State: AOUpUlHDhCecPzMVbHw1gzl9D/EV4ylU+bZEHdk9g9SdYaONf1qf4Nh2
        0bZO/E206wybfS1Lj/ePZz0X2NgOoScXAKHSKIDlXg==
X-Google-Smtp-Source: AAOMgpeRsR24DqaOJYmqJGy+uPVi15E8e69zD5BIJRNqnnB4yMugo6rBd9KZMYkahSdwbcDEWk7DpelNWQrT5vDFFtE=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr9824999ybb.292.1532970396012;
 Mon, 30 Jul 2018 10:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.11.git.gitgitgadget@gmail.com> <20180718152244.45513-1-dstolee@microsoft.com>
 <86y3ds6b40.fsf@gmail.com>
In-Reply-To: <86y3ds6b40.fsf@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Jul 2018 10:06:25 -0700
Message-ID: <CAGZ79kbAocJU2oqVCr9Dzhy2Qi-iESYGU6z2LbtFF89obaBgqw@mail.gmail.com>
Subject: Re: [PATCH] DO-NOT-MERGE: write and read commit-graph always
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I wonder though if all those changes to the testsuite shouldn't be
> merged.

I think Stolee doesn't want this to be merged after rereading
subject and the commit message.

Thanks,
Stefan
