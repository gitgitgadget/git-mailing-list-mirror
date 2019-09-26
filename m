Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093931F463
	for <e@80x24.org>; Thu, 26 Sep 2019 20:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfIZUfN (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 16:35:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44297 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfIZUfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 16:35:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so151100pfn.11
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 13:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/0T2Ps1zO5Y3xj5VN/jDgQcB2RQbLeG6kV5LxBlj0I=;
        b=k0j2Or1cdgri/eXkD1MCk6yxccABYmqqdzykAQ5pSSPWb6BXKhIi7Y/cbiTmco43Fl
         uaSxakt2/7i5ZDLgnjaPLQdQz2G1GMX6ao8T2qZFVxcFN68QqocSciLXfVXm60Ua2UUR
         mjD6Eix1STF2NLiCCtrE2wWDaj+pm8i3UpEwv5OZo9GJe3tyTq9wFE96+JRrOWQRkLls
         tAPWezOjhP3nZ23FwJNWISRY0nVacphQi/+LXq6eyX7BfOaExMr+CdQ5Fv+qXBqrgxNj
         jfyQErKTKwJkfddZFUYZxW5LThRiMlLCw0sZMgR6QHcxA70nkW4xTNOhUbQAGPG/MlyN
         Qviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/0T2Ps1zO5Y3xj5VN/jDgQcB2RQbLeG6kV5LxBlj0I=;
        b=hMOdlz+wq1gGzyszJxWwRNhyVVwdp9UOXb0WQClEsjy2rvSwKcTR/4C5+zzweai8ca
         fkvlCdRdcNqEiYamJLTCqUGIB0OTMdM4mG3DajBY8396ygmaBA5p5N2DSUW8kE5sB7JX
         yZDymw6swl7wHd+BkP3B/+XDKZCecFOq/CZL5ptu+Uu16KYrJvbXAG39tsSxcEzC9Uu1
         XIirAwZgKEzTBWiFC59c/ToZz37Fp2sFkW71+9jQC2g/yRc29Jm/PihMlQmxT/X3LO4U
         5QzTIMJeiDa58dvL5dVPf7ELat++m+ncWve9yqATvrviisxHiCPqZ0zu/aWcT8hjHtcE
         UGfQ==
X-Gm-Message-State: APjAAAWfZg5lKQlMmM3dNaOkxDhvUa5CIrilKal7xcUgIlIpmw2B7323
        I5rpeUCOGHUB5n8udySnoGRIE2LL
X-Google-Smtp-Source: APXvYqxS49zqZ4YfgP4kqUBuHiu2MMvMus9jDrdNyPz6hoSE5gJj2NtnudTTF6M5imfSxwXd9cA6OQ==
X-Received: by 2002:a17:90a:9a81:: with SMTP id e1mr5627806pjp.95.1569530112187;
        Thu, 26 Sep 2019 13:35:12 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id f6sm2583561pga.50.2019.09.26.13.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 13:35:11 -0700 (PDT)
Date:   Thu, 26 Sep 2019 13:35:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [BUG] git is segfaulting, was [PATCH v4 04/12] dir: also check
 directories for matching pathspecs
Message-ID: <20190926203509.GA61514@generichostname>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
 <20190917163504.14566-5-newren@gmail.com>
 <20190925203919.GA89135@generichostname>
 <CABPp-BHyjVSD6_S_dYgPiXM=GVEpT97FqJJearzg4hvKHXfNVA@mail.gmail.com>
 <20190925215530.GA9013@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925215530.GA9013@generichostname>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 02:55:30PM -0700, Denton Liu wrote:
> Looks correct to me. I don't see why this wouldn't reproduce. I'll send
> you more information if I figure anything else out.

I looked into it a little more and I think I know why it's being
triggered.

When we checkout 'todo' from 'master', since they're completely
different trees, all of git's source files need to be removed. As a
result, the checkout process at some point invokes check_ok_to_remove().

This kicks off the following call chain:

	check_ok_to_remove()
	verify_clean_subdirectory()
	read_directory()
	read_directory_recursive() (this is called recursively, of course)
	match_pathspec()
	do_match_pathspec()

Where we segfault in do_match_pathspec() because ps is NULL:

	GUARD_PATHSPEC(ps,
			   PATHSPEC_FROMTOP |
			   PATHSPEC_MAXDEPTH |
			   PATHSPEC_LITERAL |
			   PATHSPEC_GLOB |
			   PATHSPEC_ICASE |
			   PATHSPEC_EXCLUDE |
			   PATHSPEC_ATTR);

So why is ps == NULL? In verify_clean_subdirectory(), we call
read_directory() like this:

	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);

where we explictly pass in a NULL and it is handed down the callstack. I
guess this means that we should be expecting that pathspecs can be NULL
in this path. So I've applied the patch at the bottom and it fixes the
problem.

I was wondering if we should stick a

	if (!ps)
		BUG("ps is NULL");

into do_match_pathspec(), though, so we can avoid these situations in
the future.

Also, I'm still not sure why the issue wasn't reproducible on your
side... I'm not too familiar with this area of the code, though.

-- >8 --
diff --git a/dir.c b/dir.c
index 76a3c3894b..b7a6de58c6 100644
--- a/dir.c
+++ b/dir.c
@@ -1952,7 +1952,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
                        if (subdir_state > dir_state)
                                dir_state = subdir_state;
 
-                       if (!match_pathspec(istate, pathspec, path.buf, path.len,
+                       if (pathspec && !match_pathspec(istate, pathspec, path.buf, path.len,
                                            0 /* prefix */, NULL,
                                            0 /* do NOT special case dirs */))
                                state = path_none;
