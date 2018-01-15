Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D461F406
	for <e@80x24.org>; Mon, 15 Jan 2018 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbeAOVQm (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 16:16:42 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35552 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeAOVQk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 16:16:40 -0500
Received: by mail-ua0-f175.google.com with SMTP id g16so9428176ual.2
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=KM3+p01zuOm1PO43TW0LSSwn9xmxRBzOuJnMKvWJCgY=;
        b=s/0JEfjWISEQGN1BtHXczFXd/kfGktXX1pMm2yyXkRKSVuimDrsSi3SrCw8iEO9n67
         /9fVqaex/vxHq1c+R9pKPK+GVO3th1PVhKzVYqQ2ByOo3zpN1GbTVORkP0D68L3RkiHg
         1+b8Uyzo0jtALoqwtxcaQ316Ef8lC/Nk9fOGr+tc8+cjd+BE7aiIwwyL2knA4FPj62l2
         ZKhQZznm2WO0uzC7WhHYubzX6oYXLavBV/FRrdMZWPQqpiz+TXDZlcsGNAkE4n9VJLAN
         Ev+gG9YkNaL1OGDXByq0tcd25h60vLW0GjTXZB4/eAFQlUzIz/lk7s3iUVmtIh0Xt96k
         DRWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=KM3+p01zuOm1PO43TW0LSSwn9xmxRBzOuJnMKvWJCgY=;
        b=ZJm+COEPOpszOTuuZMGmoWgvnpi+pOSEJ+KwcmDPMttgz5Z8q41GbPJc1r+efj1wEl
         2QVUs2/YHofMkMrOVMKfVbUJo5MxvmkaoD7mlsRhlb3C0RaH4TdX0xkX6HxX2EbuAU1E
         +4LrdTgOp4v5NwFqeJ7qE40c3pM/pNbpEXoa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=KM3+p01zuOm1PO43TW0LSSwn9xmxRBzOuJnMKvWJCgY=;
        b=nbv5LpRo1HYNmMFpSY8VAf1wBvds/3jlQ0TN6UGGCeV8Jr9zfBfPv9qEJL0b1Mut+X
         6d4u+iVO4EsTPppCLkZP/S57khZl/Cw7jJ/25RwEeWuSLENtPk2XT7upA46CQahtGjVL
         NrAhkd7Cal9Wl/U46MZ8en1dYzmvM3OVJLuHrzOKD6gNtHYx5gambdIzp+idww3EYbE9
         EWwV9aBxZBh5kQ8YogaBc7+S3UDhrIJ8PcxprpqgsM9PT9L/O7kSeZ5IuxhCXhxkwk+I
         okkjiKaMYE+tGZNP8L6SGmTJ1OiBopVtIGEukvBfSEJQUoliVMTyeRK8a223RqIVQAdt
         DAyw==
X-Gm-Message-State: AKwxytcM5+7CX3tzL8ZgEp9HWqa6RAPMzdErlE9CWk5ghjPXKyh4wzoy
        s9Jab9Gr1ohZMpQS3hew/fBqrxTEvSTECW7C+c/wk60V6nA=
X-Google-Smtp-Source: ACJfBos8SAQpfVMLiFU2Ir891S/TaDgBQcliRw6NDUaRmGmf9SdyE7xciYpaeXuF69dqJYlNTgP/BijmhOp/3mFPGMo=
X-Received: by 10.159.36.136 with SMTP id 8mr2179211uar.55.1516050999305; Mon,
 15 Jan 2018 13:16:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.37.66 with HTTP; Mon, 15 Jan 2018 13:16:18 -0800 (PST)
From:   Michael Giuffrida <michaelpg@chromium.org>
Date:   Mon, 15 Jan 2018 13:16:18 -0800
X-Google-Sender-Auth: ixUj16isOqlLNqLHcGv3PzpN-So
Message-ID: <CACi5S_39wNrbfjLfn0xhCY+uewtFN2YmnAcRc86z6pjUTjWPHQ@mail.gmail.com>
Subject: [BUG] git remote prune removes local tags, depending on fetch config
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git remote prune <name>` should "delete all stale remote-tracking
branches under <name>". I was surprised to discover, after some
troubleshooting, that it also deletes *all* local tags that don't
exist on the remote, if the following refspec is included in the
remote's fetch config:

    +refs/tags/*:refs/tags/*

So, if `remote.origin.fetch` is configured to fetch all tags from the
remote, any tags I create locally will be deleted when running `git
remote prune origin`. This is not intuitive [1], nor is is it
explained in the docs [2]. Is this behavior obvious to someone with a
better understanding of Git internals?

I did find a better way to automatically fetch tags (using tagopt
instead of adding the fetch refspec). However, the refspec doesn't
seem "wrong" in itself; in particular, `git fetch --tags` used to be
considered equivalent to specifying the refspec
"refs/tags/*:refs/tags/*" -- implying that this is a sensible refspec
[3]. So I wouldn't expect it to "break" the behavior of another
command.

[1] https://stackoverflow.com/q/34687657/1327867
[2] https://git-scm.com/docs/git-remote.html#git-remote-empruneem
[3] https://github.com/git/git/commit/c5a84e92a2fe9e8748e32341c344d7a6c0f52a50
