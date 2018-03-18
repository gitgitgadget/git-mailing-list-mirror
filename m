Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A161F404
	for <e@80x24.org>; Sun, 18 Mar 2018 01:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeCRB0u (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 21:26:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51397 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeCRB0t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 21:26:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id h21so9412874wmd.1
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 18:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9IoeSRxOkdTwKu4GAKWTeDRtovC2OTV/pq76yJpfLQk=;
        b=gJ9/ZzdgjY0NWpRNuvIOeJBXsQe2iw2e7UUSaAOH0tn50aHFy1YzGsepZXbXj2A4wc
         gSn9A11qXkI4l+uA0sdIxM085ZBZf4M9tNlui3nu8YgviFlqJjqtC7jVaiQKiQz76mMy
         9IhuCwnOfXQ6iOV7xvZj3A4LONc95oiQqE9SqjvQjwVJDIcuh3WAXAuEuSPCNm79AOnd
         a4AJ9zetl15SrU3GY+VZQ9x7zXTupPuVNy9E4F0aIOUJT1+cxkySHOhpiW4s2YOTLOmp
         lMFkKJv8VSnqrR9/cIL4M1/+6K31ocgdq4JzGqlaxez9eJKphQp8ITrAfnjDOTY6dlYu
         i0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9IoeSRxOkdTwKu4GAKWTeDRtovC2OTV/pq76yJpfLQk=;
        b=eOrP7+toaPfitxTuDawILvD008wDNA5aOMeSdn0o3F0dp6qWZFyUyIBnZhvsCUfDXM
         GsRU4oo8GDf+Jk7PblqCyvJOnz5bO5I6KMGDz42vS0fgXaB1EfTVZSB8nU5E310OZzK/
         q2VnekKHEHayocWIWEk1PJNWkmYGqoM5ItETWKgajVQx6Lo5Wr4hCXah88PPMgu44jpD
         qEulHOnSHiykhoLjnTmEwJ+/axxJ1lUD+a402ZgdVeX/Oe4UvAfu5W1wThaol60Av+hK
         h4ME5fa+j1fIybbN2Vmy41CS9mSaMngi5+WCAEr+UqMxlqKdCqntlf7t1N+Dg5kI41SS
         QgkA==
X-Gm-Message-State: AElRT7HkDC4fE5G8/1ClotPMa5O0RKfVV52l+acDQdO/Lq3BCazITcCp
        F+1mVxNFGq78ZXlJIfmRVzc=
X-Google-Smtp-Source: AG47ELtmv8Si8caC2nR0NX5btDYpsr6svoYa2GiFqsTTqyIPuUPH3GPBur4SshjUupApQc0HEgAeaQ==
X-Received: by 10.80.158.43 with SMTP id z40mr7996657ede.7.1521336407902;
        Sat, 17 Mar 2018 18:26:47 -0700 (PDT)
Received: from localhost.localdomain (x590c49b4.dyn.telefonica.de. [89.12.73.180])
        by smtp.gmail.com with ESMTPSA id l91sm6184209ede.50.2018.03.17.18.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Mar 2018 18:26:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Clemens Buchacher <drizzd@gmx.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, manlio.perillo@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 2/2] completion: simplify ls-files filter
Date:   Sun, 18 Mar 2018 02:26:18 +0100
Message-Id: <20180318012618.32691-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.103.gbdc5836ed3
In-Reply-To: <1521274624-1370-2-git-send-email-drizzd@gmx.net>
References: <1521274624-1370-1-git-send-email-drizzd@gmx.net> <1521274624-1370-2-git-send-email-drizzd@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> When filtering the ls-files output we take care not to touch absolute
> paths. This is redundant, because ls-files will never output absolute
> paths. Furthermore, sorting the output is also redundant, because the
> output of ls-files is already sorted.
> 
> Remove the unnecessary operations.

You didn't run the test suite, did you? ;)

First, neither 'git ls-files' nor 'git diff-index' produce quite the
same order as the 'sort' utility does, e.g.:

  $ touch foo.c foo-zzz.c
  $ git add foo*
  $ git diff-index --name-only HEAD
  foo-zzz.c
  foo.c
  $ git diff-index --name-only HEAD |sort
  foo.c
  foo-zzz.c

Second, the output of 'git ls-files' is kind of "block-sorted": if you
were to invoke it with the options '--cached --modified --others',
then it will first list all untracked files in order, then all cached
files in order, and finally all modified files in order.  Note the
implications:

  - A file could theoretically be listed twice, because a modified
    file is inherently cached as well.  I believe this doesn't happen
    currently, because no path completions use the combination of
    '--modified --cached', but we use a lot of options when completing
    paths for 'git status', and I haven't thought that through.

  - A directory name is repeated in two (or more) blocks, if it
    contains modified and untracked files as well.  We do use the
    combination of '--modified --others' for 'git add', and '--cached
    --others' for 'git mv', so this does happen.

Note also that there can be any number of other files between the same
directory listed in two different blocks.  That 'sort' that this patch
is about to remove took care of this, but without that 'sort' the same
directory name can be listed more than once even after 'uniq'.
Consequently, the subsequent filtering of paths matching the current
word to be completed might have twice as much work to do.

All this leads to the failure of an enormous test in t9902, hence my
rethorical question at the beginning of my reply.


I have a short patch series collecting dust somewhere for a long
while, which pulls a couple more tricks to make git-aware path
completion faster, but haven't submitted it yet, because it doesn't
work quite that well when filenames require quoting.  Though, arguably
the current version doesn't work quite that well with quoted filenames
either, so...
Will try to dig up those patches.


> Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e3ddf27..394c3df 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -384,7 +384,7 @@ __git_index_files ()
>  	local root="${2-.}" file
>  
>  	__git_ls_files_helper "$root" "$1" |
> -	sed -e '/^\//! s#/.*##' | sort | uniq
> +	cut -f1 -d/ | uniq
>  }
>  
>  # Lists branches from the local repository.
> -- 
> 2.7.4
> 
> 
