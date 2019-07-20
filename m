Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A191F461
	for <e@80x24.org>; Sat, 20 Jul 2019 12:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfGTMvd (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jul 2019 08:51:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36455 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfGTMvc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jul 2019 08:51:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so27199958wme.1
        for <git@vger.kernel.org>; Sat, 20 Jul 2019 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M0TJWNxAnDX0bg+Ifeap64CsH/Sd5cbaIxpqa3fZhN4=;
        b=WcwPZLeGr641bbbuJEW1nhvrcyU2dQWU40ip/+mN73xk7HtjsKaohm0ZKa+5z6RK5G
         arY6yWZ1Xql4PHAKnkZFHOig0XTGYV/guoaXufdpYA5rd+1oa+ysp9a1n9rxiujLTEV9
         PYrvcNIgyJ+c9I6Px5DAy/WHLvegVNx3ZrAx2Wt0ayhVkFIikOlYSIEqiJlkUub24lmk
         nMJ//OlmGzm1CbCy2Gt6v2ZfwRI/hVPkHQNz8RksyTq0iUYBBRv4GxvPYP4Qmuh6aNVx
         86C0Owy+20i0mRp0ikffo7py4e915H+Y1KrV83P5QfJwTRhamO6T8iUiNDrJgvlofBP/
         PNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M0TJWNxAnDX0bg+Ifeap64CsH/Sd5cbaIxpqa3fZhN4=;
        b=MdGdv0DTN3mkiZAgqL6UwsVNWTr2wUrFWjIX/e9b9rYQFqSshT1B7QHn2MNqv2WK/y
         392QTpT07TmgwzhohssLPGNozlPsEH5Aea6kPOs7Ao2+1Bvv8cIngFd4HRjizl8IH0OA
         cBtoV+8UjJnM9DZDFQ/RKyQVXwGclmDw0gk66FW7+8lymEu5xyNC3AnlxUlgcTLDAEBB
         QB2sUFGx02fBvVPLz+N/eBrVWzjEfqZHgXyYO6lHR/HVzr8+bsG3LX3jxAn3xQ3qovLC
         LBXbhdl6mJJ09YFCD3XXk+yJ5yf17bha3hi6Y+fxuy6VracorPYxwchoQU7BQnU5FUe8
         B9ug==
X-Gm-Message-State: APjAAAUgzHqFhy330/nVF9ekDDiigqfLAONKdY4VKB21AHyApviqT4RN
        BvoyjHnSEp/UB2tAHKyoZi4=
X-Google-Smtp-Source: APXvYqzYDHtc7o/IgzsEkrzXCRa+AceJxlJ0ppR6ivFacIsKPV3EuovTav+OaMnL6w38DvU4ndbPIA==
X-Received: by 2002:a1c:1f4e:: with SMTP id f75mr52113168wmf.137.1563627090751;
        Sat, 20 Jul 2019 05:51:30 -0700 (PDT)
Received: from szeder.dev (x4dbd64a2.dyn.telefonica.de. [77.189.100.162])
        by smtp.gmail.com with ESMTPSA id 15sm24290823wmk.34.2019.07.20.05.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 05:51:29 -0700 (PDT)
Date:   Sat, 20 Jul 2019 14:51:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     cclauss via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        cclauss <cclauss@me.com>, Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 1/1] Travis CI: Lint for Python syntax errors and
 undefined names
Message-ID: <20190720125127.GK20404@szeder.dev>
References: <pull.290.git.gitgitgadget@gmail.com>
 <ad1fdb86ae42378d10584deb58115adf11de8ef7.1563545933.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad1fdb86ae42378d10584deb58115adf11de8ef7.1563545933.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 19, 2019 at 07:18:55AM -0700, cclauss via GitGitGadget wrote:
> Several things were changed between Python 2 and Python 3.
> There are a few Python 3 incompatibilities to work on.
> Here we are making changes to make the code run on both Py2 and Py3.
> We are doing this because the end of life of Python 2 is in 167 days.
> We are using print() function because legacy print statements are syntax
> errors on Py3.
> reduce() was moved in Python 3 and raw_input() was removed so we make
> changes to avoid NameErrors being raised at runtime.
> We are also putting flake8 lint tests in place on Travis CI to avoid
> any backsliding on future pull requests.

It seems to me that this patch does too many things at once, and
perhaps it would be better to split it into a couple of smaller
patches that do only one thing, e.g.:

  - use print function instead of statement in 'hg-to-git' (which
    constitutes the bulk of this patch),
  - do the same in 'contrib/fast-import/import-zips.py'
  - import 'reduce' and fix 'raw_input' in 'git-p4'
  - and once all that is done and the linter runs clean, add the
    linter job to Travis CI.

This would ease the job of the reader, now and in the future, and it
would better stand out that ...

> diff --git a/git-p4.py b/git-p4.py
> index 3991e7d1a7..9faee25db2 100755
> --- a/git-p4.py
> +++ b/git-p4.py

> @@ -3968,6 +3970,7 @@ def renameBranch(self, branch_name):
>                  break
>  
>          if not found:
> +            sync = P4Sync()

... this change is not mentioned in the commit message.

Is this something the linter complains about?
It doesn't look like a Python 2 vs. 3 compatibility fix to me, so it
might deserve a dedicated patch.

Cc-ing Luke for this bit.

>              sys.exit("gave up trying to rename existing branch {0}".format(sync.branch))
>  
>      def findLastP4Revision(self, starting_point):
> -- 
> gitgitgadget
