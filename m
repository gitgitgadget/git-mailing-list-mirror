Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE5E1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 13:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeH1RJV (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 13:09:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38265 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeH1RJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 13:09:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so1987465wmi.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sOscyE3JDlPds0Rl3kimmqPHBG8iF8q9rnYkEwCWb1w=;
        b=WmiQtMfAKtETI9HtVldhYdKEtj5U3QBPkMbvcRmnFUpD0ce6a5J0pBn+Vu2Xb86eq2
         ijs28SFEFzMiei8L0ghTsZN16AD3YJsFRauhf+PK9xZ72an8q07CHws3xhiBQIqLx0I2
         DiAuLFNIixHIiKziscLhhYhHKi7JIH1D/OsbblGjYk1wA5F3zONV9qjnXALtcCkzN0DK
         xtxve8AaDkuRK4BbakzcZiFBwUaRcfxOVicf2+UFFXa4U/Pxno6NKxY0pe6D6RtP7Wbl
         ln5+ComsU+5BrRez2Dux/x2sNsi1MJaKIZ4m7EosFx2aG8UQkNpvX1/0uw5CV8kg896j
         AboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sOscyE3JDlPds0Rl3kimmqPHBG8iF8q9rnYkEwCWb1w=;
        b=M5Lu/JW54HUuez5eDY6mChI8SIxbed2QbfimNN6StwU/5xgP0RHybA965HXrFxxBmC
         OKb/4fvnT8NTsxV3Sx4d/+oQfRqbzdRV6wa85zPo7APFDYqO4Xxskf52mW1NRODaamnN
         dUO9I+GxxCQNtF13W93IMKXJOk8kYwzA/opsjTmFl9bFZyQ6fCdRXSWsvA/c9RfQb/Wg
         j6jy5UsdKx1zgo444QLzhfZsY3YqVcmTE2nfP5kUPNM1K2Pm5FrkwA8s2rNXq+nGZYFO
         ddm659MalatBw25fTi1/YbFTVZo/cbjBz2eAaS8etB3gguvDEcQgaYkJLK4UQW6L+/ph
         xJZQ==
X-Gm-Message-State: APzg51BDkO9Yuy1zd2v3hmgMBjwISFmN8Ipv3FJnXwkZ75RgatsHQh/T
        nwNb+a8ucsML/+qu2WIMePtMVLb2F30=
X-Google-Smtp-Source: ANB0VdaQ7PCLFjVkMzJiXRT6qnfAPuQ5hlM0erR5DtN54OrX+mVGqbHAWGQTqUuvodR0kC7wmlXQEw==
X-Received: by 2002:a1c:1943:: with SMTP id 64-v6mr1317521wmz.89.1535462261114;
        Tue, 28 Aug 2018 06:17:41 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id j66-v6sm2208848wrj.28.2018.08.28.06.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:17:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nikolay Kasyanov <corrmage@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: A rebase regression in Git 2.18.0
References: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com>
Date:   Tue, 28 Aug 2018 15:17:39 +0200
Message-ID: <87in3ueiks.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 28 2018, Nikolay Kasyanov wrote:

> Hi,
>
> I’ve found something that may be a regression in git rebase implementation in 2.18.0.
> First I spotted it on macOS but I can also confirm it happening on Linux.
> Git 2.19.0.rc0.48.gb9dfa238d is affected too.
>
> In order to trigger it, a repo layout similar to the following is required:
>
> files/
> 	file1
> 	file2
> 	file3
> 	file4
> 	file5
> project
>
> Let’s call this state baseline. Then, in a branch, let’s edit project file and move file3 to nested/files subdirectory, here’s the final layout:
>
> files/
> 	file1
> 	file2
> 	file4
> 	file5
> nested/
> 	files/
> 		file3
> project
>
> Let’s get back to master and also edit project file to cause a conflict. After that trying to rebase the branch upon master will cause the following git status output:
>
> rebase in progress; onto baf8d2a
> You are currently rebasing branch 'branch' on 'baf8d2a'.
>   (fix conflicts and then run "git rebase --continue")
>   (use "git rebase --skip" to skip this patch)
>   (use "git rebase --abort" to check out the original branch)
>
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
>
> 	renamed:    files/file1 -> nested/files/file1
> 	renamed:    files/file2 -> nested/files/file2
> 	renamed:    files/file3 -> nested/files/file3
> 	renamed:    files/file4 -> nested/files/file4
> 	renamed:    files/file5 -> nested/files/file5
>
> Unmerged paths:
>   (use "git reset HEAD <file>..." to unstage)
>   (use "git add <file>..." to mark resolution)
>
> 	both modified:   project
>
> All renames except file3 are invalid and shouldn’t be here.
> Here’s how the output looks like produced by an older Git version (git version 2.15.1):
>
> rebase in progress; onto baf8d2a
> You are currently rebasing branch 'branch' on 'baf8d2a'.
>   (fix conflicts and then run "git rebase --continue")
>   (use "git rebase --skip" to skip this patch)
>   (use "git rebase --abort" to check out the original branch)
>
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
>
> 	renamed:    files/file3 -> nested/files/file3
>
> Unmerged paths:
>   (use "git reset HEAD <file>..." to unstage)
>   (use "git add <file>..." to mark resolution)
>
> 	both modified:   project
>
> Here’s a ready-to-use repository: https://github.com/nikolaykasyanov/git-rebase-bug.

Thanks for the test case. This bisects down to 9c0743fe1e
("merge-recursive: apply necessary modifications for directory renames",
2018-04-19) first released as part of 2.18.0.

I have not dug to see if the behavior change is desired or not, that
commit changed the results of a bunch of test cases, maybe it was
intended. Elijah?
