Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9210C1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 22:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbdKHWgt (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 17:36:49 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:56652 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752718AbdKHWgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 17:36:48 -0500
Received: by mail-io0-f179.google.com with SMTP id m81so7716074ioi.13
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DfaDlxtqWL9gH8KwSralxVDvV+oDeatr8UW+ndSxAY=;
        b=kvX//mdM0GmNyKQo20EYFyFYbfqKo6QJlVsLbJusk5GWu7uI+WfgerwCBFfQpWJSX5
         GhhRm+uK4cyg3AaGNSqfrFQid/HFgwG7dS8VQ9Kq4nhvOtrLiMIpHu0d9LBnYrFgU9DU
         VLLb9/MG6y+IGct+0zKgNQ6jIgi3qdhCvbX6ZugI3oIBBcnpmBSi6fjDmXiVK+2LZasD
         mHGg7+ZfOihlttQ7CSJztxBV7976sJhZOPDqsYhh0tmWnxxsAccHdBu6re8TxoG8+lPy
         pl2HPUInTtpoyKJIOjeUDn+n5fFQ/YVySKv7O57DH1/ocYGH0CXybpp/5+UT6/xZ8NHt
         kL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DfaDlxtqWL9gH8KwSralxVDvV+oDeatr8UW+ndSxAY=;
        b=SYk+sJRshkv3/fSvWOdaRWLon1qUpidWqkS+Iyy0VIZeKX6MVWkRA2/DHtb061Bh0k
         IiYGpbWQIRwxXRBtClzt82YAel+DZVEvjDzU28C1jwC6Sysb+rGOMjAwuLF7nk3PjPaA
         GTW2SFnFxHR5ew3IagaPXqNscxOWW+RVEsU2MmgmuUvx196BbhHonBfs0Vp+TGHqmrC+
         h2e4pe2e74FKTjo2VMqlU02foyivYFMIQfD10LUfuRIaj+MVN1I2zTXzl8pNaeUzjLHf
         p15zxgSWWUKv8zYG0QyIV3bIPMnH2oNNCK5Se67ZyiMD2K3WpWIn+15toB0IUeGbjmgM
         dJkQ==
X-Gm-Message-State: AJaThX5V1bHmMEC6i7uFc599vR4Tb3f3tBQ1lZJXHk/88KJyEcP5SXyN
        bYEhvOGAPAtCp7ipEUCnHgfDywg5rdg=
X-Google-Smtp-Source: ABhQp+Riw6k7xot+flPeIhzqgh4vntixNlssVMGUzVF7YTf26qQE91oXHvbwTny/atuOmPcXrXMw2A==
X-Received: by 10.107.175.28 with SMTP id y28mr2787898ioe.216.1510180607635;
        Wed, 08 Nov 2017 14:36:47 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:8df4:1665:e9bb:1ae7])
        by smtp.gmail.com with ESMTPSA id f184sm2737421ith.2.2017.11.08.14.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 14:36:47 -0800 (PST)
Date:   Wed, 8 Nov 2017 14:36:46 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] git-status reports relation to superproject
Message-Id: <20171108143646.2e1870a82360072557094e01@google.com>
In-Reply-To: <20171108195509.7839-1-sbeller@google.com>
References: <20171108195509.7839-1-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  8 Nov 2017 11:55:05 -0800
Stefan Beller <sbeller@google.com> wrote:

>   $ git -c status.superprojectinfo status
>   HEAD detached at v2.15-rc2
>   superproject is 6 commits behind HEAD 7070ce2..5e6d0fb
>   nothing to commit, working tree clean
> 
> How cool is that?
> 
> This series side steps the questions raised in
> https://public-inbox.org/git/xmqq4lq6hmp2.fsf_-_@gitster.mtv.corp.google.com/
> which I am also putting together albeit slowly.
> 
> This series just reports the relationship between the superprojects gitlink
> (if any) to HEAD. I think that is useful information in the current
> world of submodules.

The relationship is indeed currently useful, but if the long term plan
is to strongly discourage detached submodule HEAD, then I would think
that these patches are in the wrong direction. (If the long term plan is
to end up supporting both detached and linked submodule HEAD, then these
patches are fine, of course.) So I think that the plan referenced in
Junio's email (that you linked above) still needs to be discussed.

About the patches themselves, they look OK to me. Some minor things off
the top of my head are to retain the "ours" and "theirs" (instead of
"one" and "two"), and to replicate the language in remote.c more closely
("This submodule is (ahead of/behind) the superproject by %d commit(s)")
instead of inventing your own.
