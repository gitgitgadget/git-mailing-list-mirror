X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 10:32:46 -0500
Message-ID: <20061117153246.GA20065@thunk.org>
References: <20061116221701.4499.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 15:34:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061116221701.4499.qmail@science.horizon.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31699>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl5jE-0005Ex-1E for gcvg-git@gmane.org; Fri, 17 Nov
 2006 16:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933675AbWKQPeB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 10:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933676AbWKQPeB
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 10:34:01 -0500
Received: from thunk.org ([69.25.196.29]:60080 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S933673AbWKQPeA (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 10:34:00 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1Gl5mX-0007sx-Oa; Fri, 17 Nov 2006 10:37:34 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1Gl5hu-00072E-Ca; Fri, 17 Nov 2006
 10:32:46 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

On Thu, Nov 16, 2006 at 05:17:01PM -0500, linux@horizon.com wrote:
> I know it took me a while to get used to playing with branches, and I
> still get nervous when doing something creative.  So I've been trying
> to get more comfortable, and wrote the following to document what I've
> learned.
> 
> It's a first draft - I just finished writing it, so there are probably
> some glaring errors - but I thought it might be of interest anyway.

This is really, really good stuff that you've written!  Have you any
thoughts or suggestions about where this text should end up?
Personally, I think this information is actually more important to an
end-user than the current "part two" of the tutorial, which discusses
the object database and the index file.  Perhaps this should be "part
2", and the object database and index file should become "part 3"?  

It might also be a good to consider moving some of the "discussion"
portion the top-level git(7) man page into the object database and
index file discussion.  Right now, the best way to introduce git's
concepts (IMHO), is to start with the part 1 of the tutorial, then go
into the your draft branch/merging with git, then the current part 2
of the tutorial, and then direct folks to read the "discussion"
section of git(7).  Only then do they really have enough background
understanding of the fundamental concepts of git that they won't get
confused when they start talking to other git users, on the git
mailing list, for example.

It would be nice if there was an easy way to direct users through the
documentation in a way which makes good pedagogical sense.  Right now,
one of the reasons why life gets hard for new users is that the
current tutorials aren't enough for them to really undersatnd what's
going on at a conceptual level.  And if users start using "everyday
git" as a crutch, without the right background concepts, the human
brain naturally tries to intuit what's happening in the background,
but without reading the background docs, git is different enough that
they will probably get it wrong, which means more stuff that they have
to unlearn later.  

> * Git's representation of history
> 
> As you recall from Git 101, there are exactly four kinds of objects in
> Git's object database.  All of them have globally unique 40-character hex
> names made by hashing their type and contents.  Blob objects record file
> contents; they contain bytes.  Tree objects record directory contents;
> they contain file names, permissions, and the associated tree or blob
> object names.  Tag objects are shareable pointers to other objects;
> they're generally used to store a digital signature.

Hmm... this assumes that you've read the Git(7) discussion first.
There is enough information here though that maybe you don't need to
say "as you recall".  It might be enough to give a quick summary of
the concepts that are needed to understand the rest of your tutorial,
and then point to git(7) Discussion section for people who need to
learn more details.

> * Remotes files
> 
> Note that branches to fetch are identified by "Pull: " lines in the
> remotes file.  This is another example of the fetch/pull confusion.
> git-pull will be explained eventually.

Maybe we should change git so that a "Fetch: " line in the remotes
file works the same way as "Pull: ", and then recommend that people
use "Fetch: " in order to reduce confusion, as opposed to simply
explaining it away as "yet another example of the histororical
fetch/pull confusion"?

Thanks,

