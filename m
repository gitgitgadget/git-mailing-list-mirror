Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B8B1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfGXWSU (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 18:18:20 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45707 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfGXWSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 18:18:20 -0400
Received: by mail-qt1-f202.google.com with SMTP id l9so42636000qtu.12
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RLgYzM6qi1wjCTuw3NnQ6sSkU5WEbQEMhA73dNRMKxI=;
        b=Ytr7/J6SlWxxL1tMfzUCCJmatXALVcvrQbIu0laA/jI8o1txqTu8fEZ6XiSxioLFro
         NdgvrhgTqw4eISyYUEQihGjUY9uAJEk2pmPX2vmavUtJ2/Scc/66ANNFX2kviJ/nf/ro
         DuwXrp5QH/tOME/u/gLZFmQl0n8tlT6XkLUoMuiAz8zDt4oQHi/f/LEImz/KGnFBKKOW
         p5v1qTt2QHKoIV3SS4TiUaYovDeKWACkxbhyHwDhiB481vkTY0V7WGIe90JPWnfpvFAj
         VaM1Ey2xjf4b0EzHgngLKIPPduMPetGNjhZm00T4uNuhihz9vd1QCzoIW5HFtkORg4aF
         WPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RLgYzM6qi1wjCTuw3NnQ6sSkU5WEbQEMhA73dNRMKxI=;
        b=SSV25hPP54On3SU3aXK+aBzdxD29NY54g+rVC4ljU9JG8wsjhz7ydcFNlqafHGHAtC
         pO9hSoG40hJEkEONa1YVgMzw02WbNGgBQ0IlTY5C/XjPpW0yzB9Mgz4I5ZxFIK4C65Ez
         nvuEY7YAgCAuFxz7hL0bXMs6iiBZOuL09Ls2S3nJWqDMDmyf0Fqllgf2Xz4iGXFf6jaC
         EfcMk0NuHx0XMWnJUGveiBd//Evc7bGBzVYkiXMK6Wg0Di3Ak+IfLoqWDjFZwaRQkf3j
         OZZ9U+tUhne1vfUSizThb9+lgE+bQrgmnjqx8MSzPEFhvflfJP8V+/E9m3eR85xyCi14
         3XWQ==
X-Gm-Message-State: APjAAAWOzc7W0Lee2zjuOUK5R9IafGAP+1KOEvbnbBjkh6m9WXmNZ9P9
        fRhohL27Fh9VHjdW8j/XEqEA6vr0f0BQdCnKXqJ0
X-Google-Smtp-Source: APXvYqwekauFJM+8QGgRkurVaG0gfJEKhY6DNF0JrMy8Yg1O9lJdKEdJr6aMe945MKdvD+MPYrGM+FruiKOs9xhUiSyo
X-Received: by 2002:a0c:ffc5:: with SMTP id h5mr60887714qvv.43.1564006699096;
 Wed, 24 Jul 2019 15:18:19 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:18:15 -0700
In-Reply-To: <52bf9d45b8e2b72ff32aa773f2415bf7b2b86da2.1563322192.git.steadmon@google.com>
Message-Id: <20190724221815.187788-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <52bf9d45b8e2b72ff32aa773f2415bf7b2b86da2.1563322192.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: Re: [PATCH] submodule: plumb --filter to cloned submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> When cloning a repo with a --filter and with --recurse-submodules
> enabled, the partial clone filter only applies to the top-level repo.
> This can lead to unexpected bandwidth and disk usage for projects which
> include large submodules.
> 
> Fix this by plumbing the --filter argument from git-clone through
> git-submodule and git-submodule--helper.
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>

Sorry for not catching this earlier. The cloning itself might work, but
I don't think we support partial-clone submodules right now. In
particular, anything that operates on submodules in-process like grep
(which either adds submodule objects as alternates or calls the
object-loading functions using a different struct repo) will not work,
because we only support lazy loading on the_repository. So if we want
this feature, there is some other work that we will need to do first.
