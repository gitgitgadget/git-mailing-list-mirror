Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BCF3201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 19:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbdBUTm1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 14:42:27 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:37738 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdBUTmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 14:42:25 -0500
Received: by mail-it0-f44.google.com with SMTP id 203so55820729ith.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 11:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3LgkAwxrOrJmfibbQp/4fh2uxRXP4bby7pjmhwkl49Q=;
        b=Nuyce2hn2S8JnpZQHKxu0ukCLT9b8zTY07YOV8UGisWMOn9N2b6ci0g2VqAx2BAi1s
         07PfDoPUKukLUIsPOjbJVg8n2SY2SrZo8Nn+cG4lC/DiHi/ifujkCUh9EuHJFwICeyrv
         LutkvU9csHbGtu9WVVJ8Tnd4OBwd+BncN0yyDJi/EpzmGgx5Jcz5zI/I3j1E+XV3smGX
         oFOkFMUwSsBHfFPiNLf72ZetnRwTCyZE0BU8RhR6KbQDndAw7keo7guCNpicVp3sLMSU
         jEKSzHv5LuE8eOHXMYJH89XQ5JkmRFJkkMOlt5IUrebCsjRccLnQTbQM+/6q5O3sHkSH
         9YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3LgkAwxrOrJmfibbQp/4fh2uxRXP4bby7pjmhwkl49Q=;
        b=oZ9x2wXwY7UhoczqDG0KZ4WS77gNUt0Jj8YAg8P/8Ji39yGJ/nCOIdg8BddGwy1I+K
         E7tRm1z5w/PdmYNfHEer2M/mGXCkxlma73Suukxy+i2ay6OMTlLW1PsciQzr4dJ+ODmI
         ERJya7kQc901URkgasIXX3WsP00oYiV3k4Bfw3KJBza7SVJ41xVE9y6WmvHC7n0P0Hy5
         yYAv/+Qhp3rlx2vJL+9c5i6zrjeFTN8iSLHmGuUWHD07XegQGi+EI5wQhBarvk7qHkUs
         DCZ+ar4054qzH0+9Jt/IiX8Phl/CbGgWBGq5Zj7EOouiJdzcU+Ye0NWhOdc/XyR/N0hg
         Xlyw==
X-Gm-Message-State: AMke39lQWV9Uo1xDaJB+tWc/fAqFhVg/nmfkL+blQQs3civtw/qcxL7VzcRVa12L2Ya+owAA4+qSE3CTFd85zOLn
X-Received: by 10.107.37.148 with SMTP id l142mr20090204iol.159.1487706144233;
 Tue, 21 Feb 2017 11:42:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 11:42:23 -0800 (PST)
In-Reply-To: <CA+P7+xozip8TuvyUe9vAPYLAg=QFieExhOyR7a0pgGFhiuO3jw@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-7-sbeller@google.com> <CA+P7+xozip8TuvyUe9vAPYLAg=QFieExhOyR7a0pgGFhiuO3jw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 11:42:23 -0800
Message-ID: <CAGZ79kZyFfC9Xx-p8dpoAFFpz48BqmftpMonuxeiKg1sV68iuQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] update submodules: add submodule config parsing
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 10:24 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> Ok so this function here reads a recurse submodules parameter which is
> a boolean or it can be set to the word "checkout"? Why does checkout
> need its own value separate from true? Just so that we have a synonym?
> or so that we can expand on it in the future?

I think eventually we want all the commands that touch the worktree to
be able to cope with submodules.

  Now what should e.g. git-revert --recurse-submodules do?
  yes == "checkout" means we'd revert the superproject commit and
  if that commit changed any submodule pointers we'd just "checkout"
  those states in the submodule.

  For revert you could also imagine to have
  git-revert --recurse-submodules=revert-in-subs
  that would not repoint the submodule pointer to the old state, but
  would try to revert $OLD..$NEW in the submodule and take the newly
  reverted state as the new submodule pointer.

As I want to focus on checkout first, I went with "yes == checkout"
here (or rather the other way round).
