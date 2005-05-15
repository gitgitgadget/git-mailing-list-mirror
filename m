From: Wink Saville <wink@saville.com>
Subject: Re: README rewrite
Date: Sat, 14 May 2005 23:50:46 -0700
Message-ID: <4286F146.2090302@saville.com>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 08:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXCp6-0001KN-Mi
	for gcvg-git@gmane.org; Sun, 15 May 2005 08:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVEOGl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 02:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVEOGl7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 02:41:59 -0400
Received: from adsl-66-218-52-146.dslextreme.com ([66.218.52.146]:60431 "EHLO
	saville.com") by vger.kernel.org with ESMTP id S261534AbVEOGlw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 02:41:52 -0400
Received: from [192.168.0.18] (unknown [192.168.0.18])
	by saville.com (Postfix) with ESMTP id DC348F1A37
	for <git@vger.kernel.org>; Sat, 14 May 2005 23:36:09 -0400 (EDT)
Received: from 127.0.0.1 (AVG SMTP 7.0.308 [266.11.10]); Sat, 14 May 2005 23:50:46 -0700
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <20050515044941.GB7391@tumblerings.org>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Zack Brown wrote:

 > Hi Petr,
 >
 > This patch is a complete rewrite of the Cogito section of the README file.
 > Commands are explained in detail, with a quickstart section at the top and a
 > full command reference below.
 >
 > Signed-off-by: Zack Brown <zbrown@tumblerings.org>
 >
 > README: needs update
 > Index: README
 > ===================================================================
 > --- 4ef3de6ae44888d83e8c00326ddcc9f40cbd12e2/README  (mode:100644)
 > +++ uncommitted/README  (mode:100644)
 > @@ -1,164 +1,656 @@
 > -	GIT - the stupid content tracker
 > +                Cogito
 >
 > -"git" can mean anything, depending on your mood.
 > +Cogito is a version control system layered on top of the git
 > +content-tracking filesystem. This document first describes some quick ways
 > +to get started using Cogito, then goes over each available command one by
 > +one.
 >
 > - - random three-letter combination that is pronounceable, and not
 > -   actually used by any common UNIX command.  The fact that it is a
 > -   mispronunciation of "get" may or may not be relevant.
 > - - stupid. contemptible and despicable. simple. Take your pick from the
 > -   dictionary of slang.
 > - - "global information tracker": you're in a good mood, and it actually

<snip>

 > +
 > + - random three-letter combination that is pronounceable, and not
 > +   actually used by any common UNIX command.  The fact that it is a
 > +   mispronunciation of "get" may or may not be relevant.
 > + - stupid. contemptible and despicable. simple. Take your pick from the
 > +   dictionary of slang.
 > + - "global information tracker": you're in a good mood, and it actually
 > +   works for you. Angels sing, and a light suddenly fills the room.
 > + - "goddamn idiotic truckload of sh*t": when it breaks
 > +
 > +The GIT itself is merely an extremely fast and flexible filesystem-based
 > +database designed to store directory trees with regard to their history.
 > +The top layer is a SCM-like tool Cogito which enables human beings to work
 > +with the database in a manner to a degree similar to other SCM tools (like
 > +CVS, BitKeeper or Monotone).
 > +
 > +Git is a stupid (but extremely fast) directory content manager.  It
 >  doesn't do a whole lot, but what it _does_ do is track directory
 >  contents efficiently.
 >
 >
 >

Zack,

Good improvements, especially for neophytes like me who don't read enough and get confused 
when cg-init has the word DEPRECATED in its help:)

Questions/Suggestions:

1) How do I actaully apply the patch supplied in the email, where readme.patch was the 
contents of the email. I tried as below, but that didn't work.

    wink@tuxws cogito-0.10 $ cg-patch < readme.patch
    patching file README
    patch unexpectedly ends in middle of line
    Hunk #1 FAILED at 1.
    1 out of 1 hunk FAILED -- saving rejects to file README.rej

I "read" the patch and would like to suggest some additional information regarding cg-pull 
and revisons. My understanding is that it pulls the new "change sets" from the "parent" to 
my repository. I then should be able to compare the differences as per:

   "Using cg-pull is useful for a variety of purposes, for instance if you want
    to construct a diff against the latest version of the upstream sources, but
    don't want those changes to disturb your ongoing work. cg-pull will update
    your .git directory with the history you need to construct your diff,
    without merging that history into your tree, potentially breaking your
    changes."

But I don't know how to cg-diff after the cg-pull? Well as I was writing this it dawned on 
me that if I did a cg-pull I should try:

    cg-diff -r origin

by golly it worked.

So it appears a "cg-diff" with no parameters will show me the changes between my working 
tree and the "HEAD of my repository" and appears to be the same as cg-diff -r HEAD. 
("working tree" appears to mean the contents of what I "see" and therefore includes my 
uncommitted changes and "Repository" refers to contents under .git. Is that correct?)

A "cg-diff -r origin" gives me the differences between my "working tree" and my "origin's" 
current state (as defined by previous "updates" plus any unmerged pull's and there could 
be several pulls without merges).

Is the above correct?

Another area of confusion for me is what are revisions I think I understand what "origin" 
and "HEAD" are but how would I reference others? For instance how to cg-diff between the 
HEAD and the revision before HEAD (or the one 3 days ago or ...)? Can "tags" be used as 
"revisions" (i.e. as "-r tag-xxx").

Actually looking in the repository I see that "origin" appears to be a "branch" not a 
revision, what is the relationship between a branch, tag and revision's? I have some 
experience with subversion and in subversion they are actually all the same, simply the 
state of a "sub-tree" within the repository at a particular "time". That time is defined 
by the repositories current revison number which is incremented after each succesful 
commit to the repository.

Cheers,

Wink


-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.11.10 - Release Date: 5/13/2005

