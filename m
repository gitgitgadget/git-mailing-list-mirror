Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9CDA20248
	for <e@80x24.org>; Tue, 12 Mar 2019 17:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfCLRyJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 13:54:09 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:55573 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfCLRyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 13:54:06 -0400
Received: by mail-it1-f178.google.com with SMTP id z131so5850547itf.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bt8Unwxk6WJ2RCVbue/6hcC1xrWXjQXl8UHeMRD6KZo=;
        b=tOT3/BT08fTHBZCJyZwCPVnyQpOBohnsKT3mImvjTY5ocnIT17GrUb512Iy4pnsG4F
         QSPZIL97rBmQagRhU4shE/t2WWHTUyHMctTXxJ2Myi2ikIJ9mTFbTw/ZzlQVq+6iZrPv
         /XTK3HEcyf6AUE9OBtDlroFEhbjb+gHmsnqDqSZM5hHhmuGicz4M1kU1YhnGiAmlQszD
         MJuWmQg7UwhjZReVOURUKEikd7nrWJ7uESdBYVIczweRg61sJ4UT0MQlGMH+/D7y4+Zm
         PV9y0M0MS/Pe5lYN3MazU9Pgsa37kL8EJ5FQSfXCJFbpsx1Xwuaxk7lUoDwaVw/v1QTu
         SsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bt8Unwxk6WJ2RCVbue/6hcC1xrWXjQXl8UHeMRD6KZo=;
        b=cYob3n+2VqaWBKlSg/M/OQCgxKhV8Yr3nbI9QYCCrqM89KVPc3bKmChFAcxtv8Kgzh
         QVkzZ+2Yuwpy4MB3A37kfW28ibCnXPry6Q4+KVyxd42EFr1jatocu93HMxNT9V5pH7L2
         fpyPtt8NdUPPHwFqmYtU0WY40YcN9LjcqzlHBkpejR9uo+RlNAlmrZfBI2m3mR3TgW70
         4BYkQGB/+lvToWCuJnzEd+4evbJZhyJefQ+q/8F6XV1Bj4DsyaF/3Fa4Ek1FfGi08Kqq
         mgr+4d325mrVpD3ekgKD4MkhKbkJuAa9bvJ1CWpz5Kk20SjCbh+tTUKIJTu2PZRfCg0e
         7ESg==
X-Gm-Message-State: APjAAAV2cBSDVXQCUJYwsLq5jZcqDXrReBD2TQ2dk2gLrM60+O1Ri61S
        cwt8WZk7Sz6+IKrORvMz8lNy0e7Q5HhsHhVdQwGt9EBT
X-Google-Smtp-Source: APXvYqz+NJiZx21kpLbCzazlKlgXanL/ZTWMl5V54C5UBbZ3iRHkPDb59nYUj5SB8OTf0dJU4Y4Nq7LSiPJjOpXyX+w=
X-Received: by 2002:a02:5545:: with SMTP id e66mr20423296jab.99.1552413245636;
 Tue, 12 Mar 2019 10:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1903121317020.16391@localhost.localdomain>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 12 Mar 2019 10:53:54 -0700
Message-ID: <CAGyf7-F2wCB7D_JGzd7USaTV0YfmOuFG2Z6GkWVM-JqWKaagQA@mail.gmail.com>
Subject: Re: why does "git revert" commit even if i try to bail with ":q!"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 10:23 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   never noticed this before ... when i do a regular "git commit" and
> enter my "vi" edit session and change my mind, i can bail with ":q!",
> regardless of what i've set up as a commit message, and i'll see:
>
>   Aborting commit due to empty commit message.
>
> however, i was just playing with "git revert" and, after i ran:
>
>   $ git revert <commit SHA>
>
>   again, simulating that i changed my mind, i just typed ":q!", but
> the revert went ahead, anyway. i tried again, this time completely
> deleting all the lines from the commit msg (as the template
> suggested), but the revert *still* completed after typing ":q!".
>
>   it was only after deleting all the lines and using ":wq" that the
> revert was cancelled:
>
>   Aborting commit due to empty commit message.
>
> that seems ... inconsistent. am i misunderstanding something?

When you're doing a fresh commit, the .git/COMMIT_MSG is "empty". It
has whitespace and comments, but no _usable_ lines. So when you :q!,
the commit is aborted because nothing Git can use as a commit message
was saved to the file and so it's still "empty".

When you use git revert, though, it writes a valid, usable message to
the file ("Revert <subject>\n\nThis reverts commit <sha>"). When you
:q!, that's still in the file. Since the file isn't empty, the commit
moves ahead.

Git doesn't actually _know_ you quit vi with :q!. All it knows is the
editor process completed with 0 exit code, and the message file isn't
"empty". If :q! made vi exit non-zero then you'd see that the commit
(or revert) got canceled because the editor failed (I don't know the
exact message off the top of my head).

An easy way to confirm this behavior would be to run your "git
revert", and, in the editor, delete all the contents, then :w and :q!.
You'll see that the revert is aborted due to an empty message. Or you
could do a normal "git commit", type a message, then :w and :q!.
You'll see that the commit still runs. So the difference between the
two is that one starts with no usable commit message, and the other
one does.

Hope this helps,
Bryan
