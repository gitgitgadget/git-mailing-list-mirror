Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0511F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeI0A25 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:28:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38987 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeI0A25 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:28:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85-v6so11292292pge.6
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q2B7SzCNYGNadmjehPRVpIJ/iWcb0LinOFCCejmok38=;
        b=jLfadO1G9+e+NP011Jw+3zseCqKvBRnRnAFt8Wy/mWOEuITXeS0KJDbRB2rbR1Aixz
         PIiNqtM3gD99t4C88/qE+PxJ2TyXLTjgDTf4PZMnkNOYxAF4qd2dJAHSRKde14Z9t2eu
         RfXb7kXvQERKQA+LIGX5PWLyYr5eojuTDhqt8bSznDHl9qQTjBl+iGh7FoFrcUoLb0Le
         XeR3xJroBFfaeU7WhqUW79iIjxZWsm7FhTsrhcwUj7neJhqALDs+tA9Jz2uIIptKLUKV
         U6XXZuLVok1QDDXcGYEeb2DEAr29RPUV8Po2//PNbar/tN4ZvLAo829/hGovoD4jRRSs
         s36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q2B7SzCNYGNadmjehPRVpIJ/iWcb0LinOFCCejmok38=;
        b=PHTP72i/sU0pW3228fA5/L/jyzgOb4qEClOFF1UYKIxjvleFecsAUaswAgVKXKbVKz
         mukjGm9vmgXEXjMOjXh7Vk1UekuiKo/onTojdF2rakp01nSg1sBnV+O3SJUk+4q1K3XL
         4CNUt+Nko8EUSwLuJ84Qh5E5aLyfrQEW98BMHEFt7SnPWk4y/BzuuD/vx2AsL1ihZrmd
         ztDHt2ytjwYeGewiadGc9DpHFdICv9Z7RxUwDqB46/3W9WCuH7/k3Wz+JFqhYJ2C/GOO
         OjrSV0g11T1S7qVu0ik5sZkHbqXUweia0O7PlER7BmACKFKi3JhPLJp934Cnf5XhmQ6r
         3qPQ==
X-Gm-Message-State: ABuFfogKhm9dh7xaVlUMyWHzz35DXQEbaU5I/Ka57IzByrDUZwZPDmhV
        mliP/b3y0Yy6qzr7Jn1WCpBOLg==
X-Google-Smtp-Source: ACcGV600l6Xl5F90TMaltsXJysD/noZR6t/qPp1gVIFyNmogNyl1Isq8kVmWrLXrrCQSG/L2i07GOA==
X-Received: by 2002:a63:cf4c:: with SMTP id b12-v6mr4746314pgj.418.1537985687004;
        Wed, 26 Sep 2018 11:14:47 -0700 (PDT)
Received: from localhost ([205.175.107.36])
        by smtp.gmail.com with ESMTPSA id x9-v6sm12143702pfd.31.2018.09.26.11.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:14:45 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:14:45 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Alexander Pyhalov <apyhalov@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t7005-editor: quote filename to fix whitespace-issue
Message-ID: <20180926181445.GC63889@syl>
References: <20180926121107.GH27036@localhost>
 <20180926161411.10697-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180926161411.10697-1-martin.agren@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 06:14:11PM +0200, Martin Ågren wrote:
> From: Alexander Pyhalov <apyhalov@gmail.com>
>
> Commit 4362da078e (t7005-editor: get rid of the SPACES_IN_FILENAMES
> prereq, 2018-05-14) removed code for detecting whether spaces in
> filenames work. Since we rely on spaces throughout the test suite
> ("trash directory.t1234-foo"), testing whether we can use the filename
> "e space.sh" was redundant and unnecessary.
>
> In simplifying the code, though, this introduced a regression around how
> spaces are handled, not in the /name/ of the editor script, but /in/ the
> script itself. The script just does `echo space >$1`, where $1 is for
> example "/foo/t/trash directory.t7005-editor/.git/COMMIT_EDITMSG".
>
> With most shells, or with Bash in posix mode, $1 will not be subjected
> to field splitting. But if we invoke Bash directly, which will happen if
> we build Git with SHELL_PATH=/bin/bash, it will detect and complain
> about an "ambiguous redirect". More details can be found in [1], thanks
> to SZEDER Gábor.
>
> Make sure that the editor script quotes "$1" to remove the ambiguity.
>
> [1] https://public-inbox.org/git/20180926121107.GH27036@localhost/
>
> Signed-off-by: Alexander Pyhalov <apyhalov@gmail.com>
> Commit-message-by: Martin Ågren <martin.agren@gmail.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>

Thanks. I find that the explanation of the regression is a helpful one,
and the changes below look sane to me.

Since I couldn't find any other style in the surrounding script that
needed matching against, this has my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
