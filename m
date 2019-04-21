Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720E720248
	for <e@80x24.org>; Sun, 21 Apr 2019 05:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfDUFim (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 01:38:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54809 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDUFim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 01:38:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so10619333wml.4
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 22:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wiOzS696FrLDw3RghCmSmq3ZvytEdPy8ZlY0qi27dZA=;
        b=eh2MYTnTz9d0D0eDeSmPXbiBgyrVbtbNaAKyqvY4hho2sqVFBy4uAB4OsWFEJeoc7E
         udyh7MHoo0Ag56D5fvQU2gZ4P8qgLCFL7Uqq1Fmmhm3dTRXsK5f5jA76TMy4+E5+Yy89
         VgwjAhZDOoyrKXgzcC0gnf+NOT08SZBwI8KcQOQhxFlzwLgVkgul7LRY4wunN8RL/ieD
         5HdY0igJjTxgkqOX+qKuKmXkDnPytQ1TZoOeAqCeFnfTpcqvtK8Kc63ER73VNRkxgaFL
         jTZMKVVM9MLoliF8zr1kBZKM6Xf9tMXkJr+IGhxWxHXQ5jtnMkLvtSaAjYK5PdOMqivD
         lpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wiOzS696FrLDw3RghCmSmq3ZvytEdPy8ZlY0qi27dZA=;
        b=MEWk/elyuQxgt899Yz79BDLUOCOTANeGTCg4imODh1aXepdIiTWYpyKjaI8ayPbg73
         yaT1aRA6AhmWjA9oaxZY7VJ7n0MCTCJhKp8LPYSm1XYyJfLS+Ekxgff7Si05Fqu4UHf4
         ULUuT9or1wHccPQMs86n+mRs19eOeZmLzZ+JRRdTnj4acoFdw9Su0RD0SccN/i0zj98e
         q4FZcpdV9EafnFjRWkj6a3bDXNl5iZz4IU2vepcepxR/iuMeE2vQpGsGsvTsUA76gNny
         q4y3WggnL9NqZ7xa+3ayLX2IsYwGdhTDwKywCeyKjOiKg5Qg+lHXL772ILdSFaGQ3tdK
         Jzxg==
X-Gm-Message-State: APjAAAVvHVcEStwvYYgbgyxeTheRtpnZq9aSd92G/Yb/vtCDlSFxjTHy
        4ZY8PFSH1H01evTDPUNpW5M=
X-Google-Smtp-Source: APXvYqxo7pouz/WXlYZHamxmBmtdR9M2tQhzXmgavxPJTnnOyEHCF6riffzrgxs0NTIMEd0kwbLiZw==
X-Received: by 2002:a1c:dc43:: with SMTP id t64mr7634264wmg.19.1555825120230;
        Sat, 20 Apr 2019 22:38:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n18sm4790367wrt.16.2019.04.20.22.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 22:38:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: Re: [PATCH v2] Give git-pull a --reset option
References: <20190421040823.24821-1-alexhenrie24@gmail.com>
Date:   Sun, 21 Apr 2019 14:38:38 +0900
In-Reply-To: <20190421040823.24821-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sat, 20 Apr 2019 22:08:23 -0600")
Message-ID: <xmqqftqbdijl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> A common workflow is to make a commit on a local branch, push the branch
> to the remote, check out the remote branch on a second computer, amend
> the commit on the second computer, force-push back to the remote branch,
> and finally submit a pull request. However, if the user switches back to
> the first computer, they must then run the cumbersome command
> `git fetch && git reset --hard origin`. 

Doesn't anybody sense there is a larger problem if such a workflow
is "common" in the first place?  In that sequence, when you come
back to the first repository there is no guarantee that what you are
losing is exactly what you are willing to lose and nothing else
(i.e. your earlier WIP you sent to the second repository, which was
further polished, making the earlier WIP you had here irrelevant).

If the last "recovery at the first repository" step were "pull --rebase",
at least you would realize that you have the earlier WIP locally
that either

    (1) conflicts with the more polished work that have been
        accepted at the upstream, in which case you can tell the
        rebase machinery to drop that earlier WIP _after_ making
        sure that it is only that stale WIP you not only are willing
        to but actively do want to lose that is getting discarded.

    (2) replays cleanly on top of the updated upstream, which hasn't
        accepted your pull request made from the second repository
        with the more polished version, in which case you'd realize
        that you may have to work on the topic further.  And you
        have a chance to inspect what you ended up with before using
        "reset --hard" or "rebase -i" to discard what you no longer
        need.

At least, I think the longhand this attempts to replace, "fetch"
followed by "reset --hard origin" is better because of two reasons.
It is more explicit that the procedure is destructive, and more
importantly, it can allow to have (and we should encourage users to
make a habit to have) an extra step to inspect what the user is
about to lose with "git log origin.." after "fetch" but before
"reset --hard".

So I have a moderately strong suspicion that "git pull --reset"
promotes a wrong workflow and should not exist.
