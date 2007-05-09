From: "Joshua Ball" <sciolizer@gmail.com>
Subject: svn user trying to recover from brain damage
Date: Wed, 9 May 2007 10:30:18 -0500
Message-ID: <92fdc3450705090830t64c8f5b9r4af277807dfe834d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 17:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlo7r-0003sU-29
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbXEIPaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbXEIPaW
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:30:22 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:3890 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbXEIPaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:30:20 -0400
Received: by nz-out-0506.google.com with SMTP id o1so233361nzf
        for <git@vger.kernel.org>; Wed, 09 May 2007 08:30:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dP4A3k45qNFbf9grMi5GI6bnZuQwXL+qI9WJ+Uy9bO+uJV/dXp3duF62yTlIubnQoRE9S+Mt8rZc5iB4Mkn0LSfo7otPNDDU7wAoRT7PbcgOs/hWOPDVxuV7S2sosryJiAhQa77A4/eg9b2uccQ5aiWhv1e1LUtdjGmOyfCNDwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gXEv5Nj0qncrHqhZ4ZAuWqv89tanVJnE6r8GewjQqUer9MqIH8hYNQRQZ3GrA4rSpfvyO1EpPXezWvicA0zKbRqOcQRWunqPWhcVCUwDuDXtIV2L1j3EwzpA2cqMDKSf5CVrCwNxTtKqilek0zUDOYnR5KD9qR5lVAiqJyCRu4o=
Received: by 10.115.17.1 with SMTP id u1mr235974wai.1178724619243;
        Wed, 09 May 2007 08:30:19 -0700 (PDT)
Received: by 10.115.14.13 with HTTP; Wed, 9 May 2007 08:30:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46729>

Hi all,

The git page says that this mailing list is for "bug reports, feature
requests, comments and patches". Is there a mailing list for new users
crying out for help? If so, forward me there.

OK, I'm feeling very frustrated right now, so let me just say that git
documentation sucks. All the documentation I can find anywhere falls
into two categories:

1. Tutorials for people brand new to version control, with just enough
information for them to "obey the rules", but completely empty of any
information that could help them exploit the real power of
decentralized version control.
2. Technical documentation which assumes pre-obtained knowledge.

Now that I've insulted you and am probably not on your good side...

What the heck do these terms mean? The glossary on the Git wiki was
unhelpful (I'll explain later). BTW, what is wrong with the wiki?
(Particularly the excessive [grayed-out text [no match, add rest:
"used by any common UNIX command. The fact that it is a
mispronunciation of "]]. Is this some new kind of spam, or a buggy
wiki feature?)

HEAD
HEAD REF
working tree
object
branch
merge
master
commit (as in the phrase "bring the working tree to a given commit")

While the Git wiki does in fact define all of these, it doesn't answer
any of my questions about those terms:

Is there a difference between HEAD and the working tree?
Does HEAD change when I cg-switch/git-checkout?
What is an object? Is it a set of patches? A tree snapshot?
What the heck is a branch? (Why does it have so many different
definitions? I feel like every time I come across "branch" in the man
pages, it means something different.)

More on branches: The wiki says that a group of commits linked
together form a DAG. Does that mean every fork/clone/branch-create
possibly doubles the number of branches. So if I fork and then
remerge, do I have two branches?

A -> B -> D
A -> C -> D

Would D be the head of this branch? If so, then heads do not uniquely
identify a branch?

Is there a standard revision notation? (Where my definition of
"revision" is a tree snapshot. In SVN, it would be identified by a
number.) `cg-diff -r A..B` works fine if A and B are branches, but how
do I diff from an older revision to a newer revision? Can I diff
between two revisions which haven't shared the same parent since 2006?

What about the master branch? Is there anything special about it? By
special I mean, do any of the git or cogito commands implicitly assume
that you are working with master? If git is truly decentralized, then
wouldn't master be on an equal footing with all other branches?

What is a merge? My understanding of merge comes from the SVN book,
where it was described as diff+apply. Diff takes 2 arguments, and
apply takes a 1 argument (if the patch is implicit). However, cg-merge
only appears to take one branch. (There again a use of the word
branch! Wouldn't commit or revision be a more accurate term?) Why does
cg-merge only take one argument? Even if I use the -b switch, I'm
still only up to two arguments. Where is the hidden argument?

Lastly, the most important question of all, which may answer many of
the questions above:

Can you fill in the missing pieces, making corrections where
necessary? (recommend unispace font)

Command     |   Reads               |   Writes
cg-fetch    | remote branch         | corresponding branch in local respository
cg-commit   | working copy          | HEAD
cg-update   | remote branch         | working copy AND HEAD
cg-merge    | branch & working copy | working copy
cg-diff     | arguments             | STDOUT
cg-push     |                       | remote branch (usually origin)
cg-pull     | remote branch         |
cg-restore  |                       |

Perhaps the Reads column should be split into two, like ReadInfo and ReadSafety.
ReadInfo would say which revision/branch/commit/object is being read for actual
content, while ReadSafety is only read to make sure that nothing will be lost
after running the command. (e.g., cg-update reads the working copy to make sure
that you are not in a partial merge, but once it knows that it is safe, it
ignores the contents of working directory. I may have this totally wrong.)

On cg-fetch, is the remote branch necessarily remote? Or can you fetch
from local
cg-switch-branches? What does "corresponding branch in local
repository" mean? Does cg-fetch touch your working copy?

What is the difference between cg-restore and cg-seek?

Please reply even if you can only answer one of my many questions! If
I can grab just one fact and say about it, "This is truth", then it
gives me a rock to stand on amidst all the term-mashing out there.

In the words of Dijkstra, "Since breaking out of bad habits, rather
than acquiring new ones, is the toughest part of learning, we must
expect from that system permanent mental damage for most ... exposed
to it."

May you lead me to a quick recovery. Hail to decentralized version control.

Josh "Ua" Ball
