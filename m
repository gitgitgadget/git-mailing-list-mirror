Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4679E2082F
	for <e@80x24.org>; Sun, 25 Jun 2017 21:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbdFYVyr (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 17:54:47 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35013 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdFYVyq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 17:54:46 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so46303452pfk.2
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xzHcoEShFJ7NIqBq8UPYBEYnXOLn5ue+vDwWX6jzOC0=;
        b=P58Tqgu31nQXoAjBjSquspLbvUjWgy8r3dA3/vc8mwIN2bNH+7dHkOINV+nF+XWc/8
         cwWqVEHLJitxGD/e+LYRaFpsTV/2MHVr8HyAtSMFA8at5+vTMkOxBQkCvnTGPoSQ9Nf0
         nN8gG6nSWynHFLv+4rys2Ed7aU3sfsMqFC7UDisui92OQbCGxuxDCcft+G6uIuehh5NX
         ZRDSQANJUvOSK64YSOLafkpMFxsfth0etpB97tMhK2agZnIJK3A38OU3vutbuU8O1mw/
         3PqngFBvi88SVquvAhbB5GksWJPPgsWSIqDbASXnJxkaKWi1EKvecUBMnk9Lz6VPXPeK
         4yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xzHcoEShFJ7NIqBq8UPYBEYnXOLn5ue+vDwWX6jzOC0=;
        b=Ve1v8R/DNPp3dQIAHMVFCQfoj+RTxwF3kR0UiRKNMUFxagXwZvuXICg3tGZ+YjO2XW
         GPXoP+x7x+2pTNAVcZiRWpye1fQP2igyVmqhgFbkp3OilZLjR7P4uCACEtWOpwEG2juI
         ckNp0DOcmCW7QcYf2bHrQiTxzHO53c/O2H84xAx43rpqfgEh9ZhWTmi+jqwQcXNbaPub
         ba9gZjWtL1RVbk1PybiACIB/Il2Z+bd/Lsjn18M0fhhpP0lIDbrx1mzbk/yVZasyeGjP
         stZrlAZb//7pR0D2aPpLiC4mrzN5dP1VAHwdzqdvzyDdXNnxVwJaUvWwhoH1PATZwD5C
         GBGA==
X-Gm-Message-State: AKS2vOzjSSrWedgqpbhf0jdpyutyh8fM/g/0bu8KoLmdsIJym8kflC6R
        RejFDqaJ/iW1wQ==
X-Received: by 10.84.224.134 with SMTP id s6mr20443240plj.263.1498427686034;
        Sun, 25 Jun 2017 14:54:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:644d:1257:a024:dc49])
        by smtp.gmail.com with ESMTPSA id 73sm19919645pfx.93.2017.06.25.14.54.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 14:54:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Getting first tag per branch for a commit
References: <CAGHpTBLP9MiYr2ZoUOaGjGMC+aO_EKYO6SwNLfAu6QFSRnPatQ@mail.gmail.com>
Date:   Sun, 25 Jun 2017 14:54:43 -0700
In-Reply-To: <CAGHpTBLP9MiYr2ZoUOaGjGMC+aO_EKYO6SwNLfAu6QFSRnPatQ@mail.gmail.com>
        (Orgad Shaneh's message of "Sun, 25 Jun 2017 17:06:41 +0300")
Message-ID: <xmqqy3sf7mxo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Orgad Shaneh <orgads@gmail.com> writes:

> What I'd like to have is a way to tell the first tag per branch (or
> per merge) that the commit appeared on.

> I think that this can be done by filtering out tags that are connected
> to already listed tags by first-parent link.

Yes.  When one tag can be reached by another tag, then the former is
definitely an earlier tag than the latter.

A trivial way to compute it would require O(n^2) invocations of "git
merge-base --is-ancestor".  Alternatively, I think you can perhaps
use "git merge-base --independent".

Having said that, one thing to keep in mind is that a single "first
tag" may not exist at all.

Consider this topology:

          o---X-------.                topic
         /     \       \
 ---o---o---o-------o---N---S---o---   maint
     \           \   \           \
      o---o---o---M---o---o---T---o--- master

where a topic branch was forked from the maintenance track, which is
periodically merged to the master branch.  That topic branch has the
commit of interest, X, which first gets merged to the master branch
at merge M, which eventually gets tagged as T (i.e. a new feature
release).  But (wall-clock-wise) after merge M is made and the
change is tested in the context of the master branch, but before the
release T happens, the topic may be merged down to the maintenance
track at merge N.  Then eventually the tip of the maintenance track
is tagged as S (i.e. a maintenance release).

Topologically, T and S cannot be compared and they both contain X,
so the question "what is the first tag on 'master' that has commit
X?" does not have a single unique answer.  Both S and T are eligible.

You could define various heuristics to tiebreak among these tags.
You may be tempted to compare timestamps of S and T.  If they were
equal, then you might want to compare timestamps of M and N.

But you'd need to accept that fundamentally there may not be a
single "first tag".


