Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC68C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 04:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B6B22AAC
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 04:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgLXEWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 23:22:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56468 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726350AbgLXEWv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 23:22:51 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BO4LsRH018764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 23:21:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6C28B420280; Wed, 23 Dec 2020 23:21:54 -0500 (EST)
Date:   Wed, 23 Dec 2020 23:21:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mike McLean <stixmclean@googlemail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Git Feature Request (Commit Message editing directly from
 interactive rebase control file)
Message-ID: <X+QXYhSnuIOdeeCv@mit.edu>
References: <CAM0jFOfx+vxvUAqZqnxeOvGmn0F0Q6vyTKWPjtsSh1bmq__SsQ@mail.gmail.com>
 <CAM0jFOfvNFva98PNjO33HW3Y4+L1SufvEHQYzwGLHgOkfhmUDQ@mail.gmail.com>
 <X+PbbVNIspvJx/yE@camp.crustytoothpaste.net>
 <CAM0jFOfA2HH9gC0RRX52NSEPGcsCg_7fhVUYt8cmM8G5=nhtpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0jFOfA2HH9gC0RRX52NSEPGcsCg_7fhVUYt8cmM8G5=nhtpg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 24, 2020 at 12:17:26AM +0000, Mike McLean wrote:
> These seem fair concerns.
> 
> Detailed multi-line commits are something that I know exist, but I've
> never seen much need or use for, personally, and no project teams I've
> ever worked on have used them.
> But if that's the declared preferred-approach then I agree that this
> feature would be actively detrimental to that and thus is not
> appropriate.

The preferred approach is a single line summary of the commit,
followed by a body of text explaining the "why" of a commit.  In some
cases, the "why" may be several paragraphs explaining a one line
change.  For example, in this commit, see how much explanation was
given for a single _character_ change:

https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=5a3b590d4b2db187faa6f06adc9a53d6199fb1f9

Having detailed messages is critically important; since even the
commit author is not likely to remember all of the details of a
particular change a even few months later --- and when examining
changes that was made by others, sometimes years latter, context can
be critical to understanding what was going on.

Certainly, if I were reviewing some public git repository belonging to
someone who was interviewing for a position at $WORK, and they had one
line commit descriptions, I personally would consider that to be a
signal that their software engineering skills might be lacking.
Having good commit descriptions is right up there with having good
regression tests and having a second engineer do code reviews (which
include reviewing the commit description for sufficiency) as part of
basic software development practice.

Cheers,

					- Ted
