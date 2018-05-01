Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6AD21841
	for <e@80x24.org>; Tue,  1 May 2018 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeEAKnC (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 06:43:02 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35606 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeEAKnB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 06:43:01 -0400
Received: by mail-lf0-f67.google.com with SMTP id y72-v6so2049702lfd.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vQt5/elC4Ojnbwu9+CkknTbQnwCLWEeTieUtl4fl4Jo=;
        b=kJXNQANFOxNN12/TC3OzVZAaB0Ej7ozy7S0fAFN9exJPeQMpvfX6veJ9EOGQNf4jVz
         mdvyW0Cu/SGTTWNLBjbFnqJr2umDQZoLb7GxjXo3YsDDlhCBclEJeG3cDf31uF1/WnGB
         LAsidkdE1CwdkyLrSX8mES7kRN9eArW3M/pudB0qFClA623K6TceJ4QveTOeZDxddurF
         iEwPXzqfVk3GOvqOIy2MLSAA0qxY45Nu+17hPRkwEQdIloUhgD5o5hOwDyeEDrujZjjq
         FL4SCez7KwA0882ix9fsRbEw5Z1DLWIKMWZ/ywLVEna75d7xlGy+B8KLQrLsmOpt/nT7
         eU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQt5/elC4Ojnbwu9+CkknTbQnwCLWEeTieUtl4fl4Jo=;
        b=V59gxh8aYL5mvnyBJEr6heMvg15xLuF0NwmnEYC1aV8Oo8bUYtbLYzcxSwOp8MeP/Z
         zYaSLldcJ00kUxrma5c85P3s8zIzmjkV2myr10TBdfxrpabtmCig5P+wmPONB65Oserz
         ahUuRdW1GL/k0ZDBjp9pTnkpoC8hMuLQKRjViDPHZEL1s1rlj5/r8egU34J0dDvR3uai
         0KqCLLtuLhDL4vBOa77DK1HfCPj8vgB7Nydn8pmDKt0yY4psjTev8FOZJwo4UPCQkGVo
         fN8OdmajwjN0ct7iUFPKkPLtfbuY2AhtTvC4ygj9zAm9pXjGDD68eSYS8wpXG+wh9Y6j
         O0CQ==
X-Gm-Message-State: ALQs6tC9FuPCHUhc5FaQ8Rf2b6KIltvaG56pioAjJxRXqBfU4FDiNNmm
        I4Zk2tB6FYxyhdT3R4yrbPk=
X-Google-Smtp-Source: AB8JxZr3iAvvatgtUpaL+Y6BmISFcbu7ziAZF7MJenUzCb/KUQqKapa0Ga12UtP3uUCOHyPqF5TYlA==
X-Received: by 2002:a19:a90e:: with SMTP id s14-v6mr10084847lfe.10.1525171380331;
        Tue, 01 May 2018 03:43:00 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o192-v6sm627880lfe.12.2018.05.01.03.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 03:42:59 -0700 (PDT)
Date:   Tue, 1 May 2018 12:42:57 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 39/41] Update shell scripts to compute empty tree object
 ID
Message-ID: <20180501104257.GG15820@duynguyen.home>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-40-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423233951.276447-40-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:49PM +0000, brian m. carlson wrote:
> Several of our shell scripts hard-code the object ID of the empty tree.
> To avoid any problems when changing hashes, compute this value on
> startup of the script.  For performance, store the value in a variable
> and reuse it throughout the life of the script.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  git-filter-branch.sh               | 4 +++-
>  git-rebase--interactive.sh         | 4 +++-
>  templates/hooks--pre-commit.sample | 2 +-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 64f21547c1..ccceaf19a7 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -11,6 +11,8 @@
>  # The following functions will also be available in the commit filter:
>  
>  functions=$(cat << \EOF
> +EMPTY_TREE=$(git hash-object -t tree /dev/null)

All scripts (except those example hooks) must source
git-sh-setup. Should we define this in there instead?
--
Duy
