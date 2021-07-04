Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4ECC07E98
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 00:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3268B615FF
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 00:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhGDArl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 20:47:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48429 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229529AbhGDArk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 20:47:40 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1640j3hj021772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Jul 2021 20:45:03 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4512E15C3CEB; Sat,  3 Jul 2021 20:45:03 -0400 (EDT)
Date:   Sat, 3 Jul 2021 20:45:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: The git spring cleanup challenge completion
Message-ID: <YOEEjwbMPRmWOmrM@mit.edu>
References: <60df97ed24687_34a92088a@natae.notmuch>
 <C19D6C61-D62A-4344-BA1C-A532EB4FEFFE@gmail.com>
 <60e0a9707e09a_2f7208f2@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e0a9707e09a_2f7208f2@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 03, 2021 at 01:16:16PM -0500, Felipe Contreras wrote:
> Atharva Raykar wrote:
> > I can imagine aliases like 'co' only adding to the overload of
> > information if an instructor is not careful. FWIW, I have never seen a new
> > user complain about the length of the typing, it's usually with the plethora
> > of unintelligible (to them) options that each command has when they open the
> > Git man pages, which adds more fear.
> 
> This is one of the reasons I suggested to split git into two binaries:
> git for normal users, and git-tool for all the plumbing not many humans
> use.

It might be that the answer for the problem Atharva has described
would be for someone so include to create a new front-end to git ---
call it "sg", for simplified git", or "gt" for git tool (different
from the "git-tool suggested by Felipe), etc.

It could be an extremely opinionated subset of git's functionality;
for example, it could be one where the index is completely hidden from
the user, so you never need to type "sg add" when modifying a file,
but only when adding a new file to be under source code management
(e.g., that "sg commit" would effectively imply "git add -u ; git
commit"), and so on.  Since the index doesn't conceptually exist in
the sg interface, then "sg reset" would only have the meaning of "git
reset --hard", etc.

By definition this simplified front-end to git would have a subset of
the functionality of "full git", but that's OK.  The whole goal would
be to make something super newbie-friendly --- the equivalent of a
"Mac OS-like" interface, that perhaps doesn't have the power of
someone who opens up a shell and uses tools like awk or perl, but is
good enough "for the rest of the human race".

Note that this doesn't have to be an official "git" ccommunity
initiative; anyone could try to create such one of these things (and I
believe a few things exist already).

Making it a non-goal that this "user friendly" front end doesn't have
to have the full functionality of git, and its main goal is to allow
the use of different user interface design choices made by git, might
be much simpler than trying to change git, which would require having
the argument over which functionality is used by "normal users", and
which features should be exiled to "git-pull" as being "fringe"
features.

						- Ted
