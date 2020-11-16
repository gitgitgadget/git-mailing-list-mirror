Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF110C8451C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9793E20855
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgKPMWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 07:22:33 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:44440 "EHLO
        coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgKPMWc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 07:22:32 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
        by coral.adamspiers.org (Postfix) with ESMTPSA id 3D8DC2E6D6
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 12:22:31 +0000 (GMT)
Date:   Mon, 16 Nov 2020 12:22:30 +0000
From:   Adam Spiers <git@adamspiers.org>
To:     git mailing list <git@vger.kernel.org>
Subject: git-log: documenting pathspec usage
Message-ID: <20201116122230.eyizwe2bmqkmftch@gmail.com>
X-OS:   GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I just noticed that git-log.txt has: 

     SYNOPSIS
     --------
     [verse]
     'git log' [<options>] [<revision range>] [[--] <path>...]

and builtin/log.c has: 

     static const char * const builtin_log_usage[] = {
             N_("git log [<options>] [<revision-range>] [[--] <path>...]"),

IIUC, the references to <path> should actually be <pathspec> instead,
as seen with other pathspec-supporting commands such as git add/rm
whose man pages are extra helpful in explicitly calling out how
pathspecs can be used, e.g.:

     OPTIONS
     -------
     <pathspec>...::
             Files to add content from.  Fileglobs (e.g. `*.c`) can
             be given to add all matching files.  Also a
             leading directory name (e.g. `dir` to add `dir/file1`
             and `dir/file2`) can be given to update the index to
             match the current state of the directory as a whole (e.g.
             specifying `dir` will record not just a file `dir/file1`
             modified in the working tree, a file `dir/file2` added to
             the working tree, but also a file `dir/file3` removed from
             the working tree). Note that older versions of Git used
             to ignore removed files; use `--no-all` option if you want
             to add modified or new files but ignore removed ones.
     +
     For more details about the <pathspec> syntax, see the 'pathspec' entry
     in linkgit:gitglossary[7].

Would it be fair to say the git-log usage syntax and man page should
be updated to match?  If so perhaps I can volunteer for that.

Regards,
Adam
