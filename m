Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E0B1FF40
	for <e@80x24.org>; Thu, 22 Dec 2016 00:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936701AbcLVAAc (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 19:00:32 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:61642 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936642AbcLVAAb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 19:00:31 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1cJqo7-0000iP-Dh
        for git@vger.kernel.org; Thu, 22 Dec 2016 01:00:27 +0100
Received: by mail-qt0-f173.google.com with SMTP id c47so220969972qtc.2
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 16:00:27 -0800 (PST)
X-Gm-Message-State: AIkVDXLF0DzvkeqlUx2uT+16w6+lvPBq9T4b0RxX4XQiO79ePqWMjcQ9oXCPRGyOuKcQiYERTLz8arowcQ3J3g==
X-Received: by 10.200.57.89 with SMTP id t25mr8157330qtb.196.1482364821425;
 Wed, 21 Dec 2016 16:00:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.170.79 with HTTP; Wed, 21 Dec 2016 16:00:21 -0800 (PST)
In-Reply-To: <CAM+g_NtsSaiZdy2Pq0gR9AaO6xiNnGSUbj5yd-uW3S80roEGCg@mail.gmail.com>
References: <CAM+g_NtsSaiZdy2Pq0gR9AaO6xiNnGSUbj5yd-uW3S80roEGCg@mail.gmail.com>
From:   Johan Herland <johan@herland.net>
Date:   Thu, 22 Dec 2016 01:00:21 +0100
X-Gmail-Original-Message-ID: <CALKQrgekuu4d5EFLpT=sH+qCJSJdb9O0Zttw348UXffGDuwFzQ@mail.gmail.com>
Message-ID: <CALKQrgekuu4d5EFLpT=sH+qCJSJdb9O0Zttw348UXffGDuwFzQ@mail.gmail.com>
Subject: Re: config for `format-patch --notes`?
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2016 at 1:18 AM, Norbert Kiesel <nkiesel@gmail.com> wrote:
> Hi,
>
> I use `git format-patch master..myBranch` quite a bit to send patches
> to other developers.  I also add notes to the commits
> so that I e.g. remember which patches were emailed to whom.  `git log`
> has an option to automatically include the notes in
> the output.  However, I can't find such an option for `git
> format-patch`.  Am I missing something?

I assume you mean _config_ option here (format-patch has had a --notes
command-line option since v1.8.1). AFAICS, there's no config option
that corresponds to the format-patch --notes command-line option.

You can easily alias or script your way around this, e.g.:

  git config alias.fp 'format-patch --notes'

This creates a 'git fp' command that does what you want, I believe.

Alternatively, if you need more control/automation of the resulting
patches, you can write a script to edit the output files from
format-patch. Currently, I don't believe there is any format-patch
hook available to automatically trigger such a script, but, again,
that can be achieved with an alias.

If you believe a config option would be a useful addition for more
users than yourself, I am sure the community welcomes patches adding
a format.notes config option.

> Another nice option would to to somehow include the branch name in the
> resulting output.  Right now I use either notes
> or abuse the `--subject` option for this.

From git-config(1):

    branch.<name>.description
        Branch description, can be edited with git branch
        --edit-description. Branch description is automatically added
        in the format-patch cover letter or request-pull summary.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
