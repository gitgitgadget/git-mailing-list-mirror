Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD9C20323
	for <e@80x24.org>; Fri, 17 Mar 2017 04:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbdCQEIp (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 00:08:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36385 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbdCQEIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 00:08:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id r137so4016550pfr.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mj0NgG6P/PgZxtFoSGWC+zWxtizbJ+5+wkbr3CBWg0c=;
        b=f5w4rXy9307h1zWnnclyEi4GOFYnkX6ymC4K8TcUval1vkKik8BIZEjTdHx3RJnH0w
         Chy7M1atvVcDuUSQ7v47g4y/CBKSq06ELkWp3eDcuQWzB/TPuWsHJreTCQ2icT8TQF07
         AbiHm0b7lZlit0/+fhV+f38yZeI8fpVYrbUgmEslnNcXxpGCy0CKT9I6ftWMv1k3Oil8
         0YSZK2v7jWNvL7jK7YuRYr8J36RyE1h2pBa91Cmng3RQPANxOfiQJS4ngUoLv5kGvs8C
         5TDUlH8oLxB6hJcwJcnLLffDNShMbww5VbsHrGhFj0oGSjL/P95fRmHTkRX24or9M/Y3
         yLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mj0NgG6P/PgZxtFoSGWC+zWxtizbJ+5+wkbr3CBWg0c=;
        b=B+JNaUF9qRziyxWbypn4AtL7Qtug7oo+QISYwAKheTSTlukHv8FNhBPNyd5ovklPvQ
         CNjfufmaoelgFLAcbAiryaINi0XkzpdX3y8bEuNFwGTbvL0D2PGjpY7EnC0znqEsmufs
         LNtXdv9EA4k843lQabF3guI739+UyyrCRbIkkvxrjRIzX6oRQiqoj72xrFLhBzPZRmAv
         +1E6WOtpCGKNRo+Bb1A6ZN/KOLF33W8nnZt8LzoBO9SH4SlFqhoD+5L5/7heKN0qD3VG
         1Y4EXhjqof3beRExU/TjudcMr14dFW+XyISWgfIqaOcJ2Nl0YxFcv8TfB3728oYXiDXs
         NB+w==
X-Gm-Message-State: AFeK/H0k1W4EXMt8CBM0WjzAF3jXPIk5r7tgrSXiJbTegc7Dk/G63uaae8OGMeLJlvDeFA==
X-Received: by 10.84.231.141 with SMTP id g13mr11545419plk.157.1489723630852;
        Thu, 16 Mar 2017 21:07:10 -0700 (PDT)
Received: from [10.33.249.33] ([132.188.112.190])
        by smtp.gmail.com with ESMTPSA id c11sm13258366pfe.68.2017.03.16.21.07.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 21:07:10 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] name-rev: favor describing with tags and use committer date to tiebreak
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170315225045.15788-3-gitster@pobox.com>
Date:   Fri, 17 Mar 2017 12:07:06 +0800
Cc:     git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
Content-Transfer-Encoding: 7bit
Message-Id: <9AE7ADCA-97F9-4857-AC55-76C4BD822C25@gmail.com>
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com> <20170315225045.15788-1-gitster@pobox.com> <20170315225045.15788-3-gitster@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Mar 2017, at 06:50, Junio C Hamano <gitster@pobox.com> wrote:
> 
> "git name-rev" assigned a phony "far in the future" date to tips of
> refs that are not pointing at tag objects, and favored names based
> on a ref with the oldest date.  This made it almost impossible for
> an unannotated tags and branches to be counted as a viable base,
> which was especially problematic when the command is run with the
> "--tags" option.  If an unannotated tag that points at an ancient
> commit and an annotated tag that points at a much newer commit
> reaches the commit that is being named, the old unannotated tag was
> ignored.
> 
> Update the "taggerdate" field of the rev-name structure, which is
> initialized from the tip of ref, to have the committer date if the
> object at the tip of ref is a commit, not a tag, so that we can
> optionally take it into account when doing "is this name better?"
> comparison logic.
> 
> When "name-rev" is run without the "--tags" option, the general
> expectation is still to name the commit based on a tag if possible,
> but use non-tag refs as fallback, and tiebreak among these non-tag
> refs by favoring names with shorter hops from the tip.  The use of a
> phony "far in the future" date in the original code was an effective
> way to ensure this expectation is held: a non-tag tip gets the same
> "far in the future" timestamp, giving precedence to tags, and among
> non-tag tips, names with shorter hops are preferred over longer
> hops, without taking the "taggerdate" into account.  As we are
> taking over the "taggerdate" field to store the committer date for
> tips with commits:
> 
> (1) keep the original logic when comparing names based on two refs
>     both of which are from refs/tags/;
> 
> (2) favoring a name based on a ref in refs/tags/ hierarchy over
>     a ref outside the hierarchy;
> 
> (3) between two names based on a ref both outside refs/tags/, give
>     precedence to a name with shorter hops and use "taggerdate"
>     only to tie-break.
> 
> A change to t4202 is a natural consequence.  The test creates a
> commit on a branch "side" and points at it with an unannotated tag
> "refs/tags/side-2".  The original code couldn't decide which one to
> favor at all, and gave a name based on a branch (simply because
> refs/heads/side sorts earlier than refs/tags/side-2).  Because the
> updated logic is taught to favor refs in refs/tags/ hierarchy, the
> the test is updated to expect to see tags/side-2 instead.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

A quick bisect indicates that this patch might break 
t9807-git-p4-submit.sh 8 and 13. I haven't looked into
it further, yet.

https://travis-ci.org/git/git/jobs/211948406#L2152
https://travis-ci.org/git/git/jobs/211948406#L2460

Non-JS: https://s3.amazonaws.com/archive.travis-ci.org/jobs/211948406/log.txt

- Lars
