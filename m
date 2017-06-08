Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EAA1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdFHWcl (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 18:32:41 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35568 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdFHWck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 18:32:40 -0400
Received: by mail-pf0-f175.google.com with SMTP id l89so21725148pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 15:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kGjbQm3Oo3A4BA60UyY70d+pF48nr5EhKJjypqNauGQ=;
        b=gqkgi8ywfDdinq5Z/5Zr7hrC2TjIEa4/vlx1Yt/4OAOaRJOIXJwjVv2WBWIlNMyTNP
         pf49HjYir4/JcuD5dLMoaquU4NJpQbZUwCZ4J3JTSaJFxiFaU409ljR/y6N5AcgFOv1f
         mZk+l4w02dA6eVWs624x759VND73K9PKcr6zI1lr+3LtNQY/G4pjgw1lU/HKgKc2az4z
         9I2h2F9kmA/NOaCHwU5ZsFbRNmF6HzNk9CiS8g4jt6/kB6r4uSdCNbU7pGD6yT+5yyzd
         ZOyezcFQUKMAaK5xHeu+YoCcZ4lS2MG9pKg7fbiL2KOET8AyExb51ujThSSLaM6aWQMT
         X5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kGjbQm3Oo3A4BA60UyY70d+pF48nr5EhKJjypqNauGQ=;
        b=VkyJJUDZO0wzpcuyf1gxGzrEgnCI30QdgLWIe/I4vNZocP7GfTLGvpfHbAg4DATnXU
         PYZ7bz4AXJg4TFbgNOUCqCNZzF24SD6a2xTZGnR7anntBrQURcf0wgWV0+djG+TEgiSA
         R7DP0WbNt95NgBb6U7gyeCVVE6TShaQ9ASPpIgTioXcnyr9N3fY7grEIJ4Gwro5hInsF
         TrXiwBy7Qz8xmoHi1H2ipIPc4ThKfYBFzLPFQxt+CiCfgprBY9Or6PfLWBeYv6GkxyNw
         xsf5vIqPa2c3zU8LIomzV7dvnrv9J/X2cOaOF0RVoVqkRN4sfSKKQlwl9pqZGslwz/qw
         9qoQ==
X-Gm-Message-State: AODbwcDeXdMkdIEWzAESOL2w2ppEH3q94uqfblZ8rYVmB+0JQROSEht0
        B3LnyxCAnYINqV9/
X-Received: by 10.99.146.86 with SMTP id s22mr35835314pgn.85.1496961159809;
        Thu, 08 Jun 2017 15:32:39 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id r86sm11465950pfi.77.2017.06.08.15.32.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 15:32:38 -0700 (PDT)
Date:   Thu, 8 Jun 2017 15:32:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] Avoid problem where git_dir is set after alias
 expansion
Message-ID: <20170608223237.GB121539@google.com>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Johannes Schindelin wrote:
> 
> Changes since v1:
> 
> - 1/8's commit message clarifies why the other early return in
>   discover_git_directory() does not need an equivalent resetting of
>   git_dir.
> 
> - 3/8's commit message fixes awkward language (thanks, Brandon!).
> 
> - the `worktree_dir` variables/parameters have been renamed to
>   `cdup_dir` to clarify that they only get populated if the search for
>   the .git/ directory determined that the current working directory
>   is a subdirectory of the directory containing .git/.
> 
> 

v2 addresses some of the comments I had with v1, so everything looks
good to me.

> Johannes Schindelin (8):
>   discover_git_directory(): avoid setting invalid git_dir
>   config: report correct line number upon error
>   help: use early config when autocorrecting aliases
>   read_early_config(): optionally return the worktree's top-level
>     directory
>   t1308: relax the test verifying that empty alias values are disallowed
>   t7006: demonstrate a problem with aliases in subdirectories
>   alias_lookup(): optionally return top-level directory
>   Use the early config machinery to expand aliases
> 
>  alias.c                | 33 +++++++++++++++++++++-------
>  builtin/help.c         |  2 +-
>  cache.h                |  7 +++---
>  config.c               |  7 +++---
>  git.c                  | 59 ++++++--------------------------------------------
>  help.c                 |  2 +-
>  pager.c                |  4 ++--
>  setup.c                | 13 +++++++++--
>  t/helper/test-config.c |  2 +-
>  t/t1308-config-set.sh  |  4 +++-
>  t/t7006-pager.sh       | 11 ++++++++++
>  11 files changed, 70 insertions(+), 74 deletions(-)

-- 
Brandon Williams
