Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D914E207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750777AbdEBBfI (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:35:08 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33868 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdEBBfH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:35:07 -0400
Received: by mail-pf0-f179.google.com with SMTP id e64so44200803pfd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4mexPiHzn/EFFWPeSpogxnFYa/oxWEFSrNAhL6+8WdI=;
        b=pQRaWo6KWs7LNWZRSwSdIG3+gBnc0ksgT1yMAOCxIgL5PNyN2l9FkkDy+2zJ9I6FZ0
         O9atmS+cTvGC/D4UEQalqPRWyyKfcyHJNQjdFPzdNusaSnGUXALwWIiWblEuHJ+/0Fq1
         KA0Ey16yRVtGTkBzg1ALX+IU2ndKeWLi74A1lmTegIuf6anJZzi9qhn8A8ic8Ag5mVYE
         IQYD4VssQcwHLdV1I2gvUGhm0a2PRYKfvinbcaKMj9t01cqAION4bMdd9RJ7zMs9wRYR
         /NPAbtmotdPCvYX4gHAOmM6QhqLWd0X1iDeQrGfekIWYVHXd9U5j24gHO9ibXC0Y4RiX
         LK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4mexPiHzn/EFFWPeSpogxnFYa/oxWEFSrNAhL6+8WdI=;
        b=MU5mBNbaIj7mwAljyl0g+1N2hL8lEFvEo1IOD69X20kemhjm2JivGukhIyx3YtPh0Z
         CLrB2NtYndRlbr64YyZq9uIKD7k7Ca1fZ+6LSTzLw1XiyN+inXdC04aem4KlUbwWDLk2
         oU7y1dfAj+S73hXGJT8pSzzsDJndWlKyJxhBFPttP/WPH0LMDl1gSS8+UGKzgste28y7
         nX307zEv/v9MVUfFwxYo0SJQ/vcBuNXoSrPxo6ADvD883MV/1c10pJfFmIE4DoZ/libp
         6n72eLHFaHAc/2afC3n+A+Z3lcryUMLu6lDfX9Ey3WDQMMHMUu0fNKCF5NQRJMNnmNq5
         Gqfw==
X-Gm-Message-State: AN3rC/6YvnvsWdL9MVZjpJ7p9kFcSKWgviuSR6Xji9/b52zvUX+N7BB9
        6JCStpPswXb6CA==
X-Received: by 10.84.218.205 with SMTP id g13mr20725102plm.38.1493688906360;
        Mon, 01 May 2017 18:35:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id x21sm31490588pfa.71.2017.05.01.18.35.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:35:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, jrnieder@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 0/5] Some submodule bugfixes and "reattaching detached HEADs"
References: <20170501180058.8063-1-sbeller@google.com>
        <20170501182405.GG39135@google.com>
Date:   Mon, 01 May 2017 18:35:04 -0700
In-Reply-To: <20170501182405.GG39135@google.com> (Brandon Williams's message
        of "Mon, 1 May 2017 11:24:05 -0700")
Message-ID: <xmqqbmrcf3cn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I don't know why submodules were originally designed to be in a
> detached HEAD state but I much prefer working on branches (as I'm sure
> many other developers do) so the prospect of this becoming the norm is
> exciting! :D

The reason is because the superproject already records where the
HEAD in the submodule should be, when any of its commits is checked
out.  The tip of a branch (which one???) in a submodule may match
that commit, in which case there is nothing gained by having you on
that branch, or it may not match that commit, in which case it is
unclear what should happen.  Leaving your submodule on the branch
would mean the state of your tree as a whole does not match what the
checkout operation in the superproject wanted to create.  Resetting
the branch would mean you may lose the history of the branch.

Thinking of the detached HEAD state as an implicit unnamed branch
that matches the state the superproject checkout expects was
conceptually one of the cleanest choices.

But all of the above concentrates on what should happen immediately
after you do a checkout in the superproject, and it would be OK for
a sight-seer.  Once you want to work in the submodules to build on
their histories, not being on a branch does become awkward.  For one
thing, after you are done with the work in your submodule, you would
want to update the superproject and make a commit that records the
commit in the submodule, and then you would want to publish both the
superproject and the submodule because both of them are now
updated.  The commit in the superproject may be on the branch that
is currently checked out, but we don't know what branch the commit
in the submoudule should go.

The submodule.<name>.branch configuration may be a good source to
learn that piece of information, but it does not fully solve the
issue.  It is OK for the tip of that branch to be at or behind the
commit the superproject records, but it is unclear what should
happen if the local tip of that branch is ahead of the commit in the
superproject when checkout happens.

By the way, how does this topic work with the various checkout modes
that can be specified with submodule.<name>.update?


