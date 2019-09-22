Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967781F463
	for <e@80x24.org>; Sun, 22 Sep 2019 03:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfIVDLc (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 23:11:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35344 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfIVDLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 23:11:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so13321596qtq.2
        for <git@vger.kernel.org>; Sat, 21 Sep 2019 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JWk5whgWNZdDP2iNh9/FWwwNomacffKBOk6HdejI/0=;
        b=vYdJimmhroLxig/rr9A7XIQ5Hk9+4IPgYPlzNRJ0Efl9RjJOxVRnx7AYFoAY5i/IIs
         QYBSyWz12hzqzX+WWmSSfjeWjZkA+7I5cIPiW6iJmmDuhs2gGYHcL1AhWIsGWRTpzg6W
         yJahx7W1WaGCQKgz+BEVpWZjqxoUdbdU3mnqn5iSV6J51E53AwKW/zmS896xz6fSUdeh
         rWY1mPkADbC0JJKULHW0hxblCGTaETjOdGmEzO66OtiBytRuPcmDkMoqTQ7dLzQzY6dt
         YDdmgkY5G2yJyB+x4SULbwQMQDGq6xtaDoYG3IM9hmCMfkV5zsJ9u/gwXpth9JGzMY5u
         KLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JWk5whgWNZdDP2iNh9/FWwwNomacffKBOk6HdejI/0=;
        b=mnXL87XDj4ZEJCYcYylicX9q6h03Vt9kc5jDObok1gnmzYPiVFz5cyh1iCElXlLSef
         DjF4SMqzhWhP5tbuscAl/8C+OKSQcn9Iy5eQi44oB86ai4gYgwq7YRZPR7G8O25I+KUd
         WZDvNKFwpefz1ieUSrOh1my3AU6awvXYqmcXcqE4AEoiyIbDa74YQgksAcMm60geyQ39
         sbYt+EPdCntPHVyGcJvpKIPhRiZctUTNYmxZcpoWGK85kbJIb4CnCnBwqQKg0t4UGQpJ
         TtHBLopokub5SJKZF6Nnm+uiydrltFoA+lsn8Lb2BLuQzjstYg0H7d1N57QJaGJJew6m
         /iPw==
X-Gm-Message-State: APjAAAV6+rgPQnUvCQJRjoxUj+r4buGxj8UFWYvse96RcHnCqTIuOyPq
        u4fogTcD4z3Z3Mza19l3yk267DDoSXKh7Q==
X-Google-Smtp-Source: APXvYqyG711UbmHtK9ynnt/IgF3MkhHR5xdV3o1OqSbeaRyWMNDkf5uXvDJDftxgalA4OiQ8xg5KtA==
X-Received: by 2002:ac8:4597:: with SMTP id l23mr11589552qtn.284.1569121890507;
        Sat, 21 Sep 2019 20:11:30 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:54bf:e7df:e363:e72])
        by smtp.gmail.com with ESMTPSA id j5sm3226669qkd.56.2019.09.21.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 20:11:29 -0700 (PDT)
Date:   Sat, 21 Sep 2019 23:11:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] git-config --add allows values from stdin
Message-ID: <20190922031128.GA76333@syl.lan>
References: <20190917133135.190145-1-git@zjvandeweg.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190917133135.190145-1-git@zjvandeweg.nl>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZJ,

On Tue, Sep 17, 2019 at 03:31:34PM +0200, Zeger-Jan van de Weg wrote:
> When adding or updating configuration values using git-config, the
> values could all be observed by different processes as these are passed
> as arguments. In some environments all commands executed are also all
> logged. When the value contains secrets, this is a side effect that
> would be great to avoid. At GitLab we use Rugged/libgit2 to circumvent
> this property[1].
>
> The following patch allows a value to be set through stdin when the user
> passes a `--stdin` flag.

Interesting. I had thought some time ago about making an interactive
line-oriented 'mode' for using 'git-config(1)', which would allow
callers to add/delete/fetch multiple variables using only a single
process.

This would satisfy a more general use-case than yours: particularly my
idea was grown out of wanting to specify or read many configuration
entries at once when using a tool built around Git, such as Git LFS.

I had not considered tying '--stdin' to the '--add' (implicit or not)
mode of 'git-config(1)'. It is an interesting idea to be sure.

On the one hand, it lends itself to other modes, such as '--get'
combined with '--stdin', or '--unset' in the same fashion. One could
imagine that each of these would take either a key/value-pair (in the
case of '--add') or a set of key(s) (in the remaining cases). The most
desirable aspect is that this would allow for a clear path to this
series being picked up.

On the other hand, tying '--stdin' to a particular mode of using 'git
conifg' seems overly restrictive to me. If I am building a tool that
wants to fetch some values in the configuration, and then add/unset
others based on the results using only a single process, I don't think
that a mode-based '--stdin' flag gets the job done.

One happy medium that comes to mind is a new '--interactive' mode, which
implies '--stdin' and would allow the above use-case, e.g.:

  $ git config --interactive <<\EOF
  get core.myval
  set core.foo bar
  unset core.baz
  EOF

(An off-topic note is that it would be interesting to allow more
fanciful options than 'get', e.g., 'get' with a '--type' specifier, or
some such).

I'm not sure if anyone actually wants to use 'git-config(1)' in this
way, but I figured that I would at least share some things that I was
thinking about when initially considering this proposal.

> [1]: https://gitlab.com/gitlab-org/gitaly/blob/8ab5bd595984678838f3f09a96798b149e68a939/ruby/lib/gitlab/git/http_auth.rb#L14-15
>
> Zeger-Jan van de Weg (1):
>   Git config allows value setting from stdin
>
>  Documentation/git-config.txt |  5 ++++-
>  builtin/config.c             | 23 +++++++++++++++++++++--
>  t/t1300-config.sh            | 11 +++++++++++
>  3 files changed, 36 insertions(+), 3 deletions(-)
>
> --
> 2.23.0
>

Thanks,
Taylor
