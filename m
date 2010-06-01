From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/checkout: clarify description
Date: Tue, 1 Jun 2010 02:25:23 -0500
Message-ID: <20100601072523.GB27593@progeny.tock>
References: <20100530084153.GA5447@progeny.tock>
 <20100601061046.GA7360@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tomas Carnecky <tom@dbservice.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 01 09:25:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJLqv-00022H-Qg
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 09:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab0FAHZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 03:25:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49747 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0FAHZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 03:25:27 -0400
Received: by iwn6 with SMTP id 6so689760iwn.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c9PF5sJ5K7aBGEcTBoatxmrVEDLUbJJsHMbO4kWttqc=;
        b=kHdjyzNMviT7JxWDVbMtzkN/LLjmLBX/zUJoHYwgyhgsin8U8oQqMu26ZIrJFL3kMT
         yem6wFZ+I+XBblfH5xYJ2aDvx4A0jDZAeE/AbpDEsadaGzntyfqQf2MmFiiP10Rbv1R4
         jlk35KIlTaEL+qYOy8+ye+xoIZaFmJb9fYaCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a8CbLbnSh8bnBc11nutmWCErf7V+qWn7Ucykm9bZ7ICeN3NcvR3KPoYKv9sYDSsG6Z
         6x4jc560jqg/jWwbOYpBpaGB9Q3h1efuCeD/DKu5MuOvlS/DzE8ZUYoUKo6gAb57v0vn
         RsOTCxeyOMm2kZin9igi2jfQGfCE/oE7v0KVM=
Received: by 10.231.184.1 with SMTP id ci1mr7281791ibb.39.1275377125355;
        Tue, 01 Jun 2010 00:25:25 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm30099951ibg.6.2010.06.01.00.25.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 00:25:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100601061046.GA7360@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148086>

Jeff King wrote:
> On Sun, May 30, 2010 at 03:41:53AM -0500, Jonathan Nieder wrote:

>> +Retrieves files from the index or specified tree and writes them
>> +to the working tree.
[...]
> How is this first paragraph helping?

Ideally, one should be able to read the first sentence or two of a
manual page to tell whether this is the right command to use.

But in this case, the sentence I added is just misleading.  How about:

  Updates files in the working tree to match the version in the index
  or the specified tree.  If no paths are given, 'git checkout' will
  also update `HEAD` to set the specified branch as the current
  branch.

Surely it is possible to do better:

 . Wording is not so great

 . Either this page or git-branch.1 would be a better place than
   the glossary to explain the HEAD reference and its role in git.
   So there should be some reference here of the form (see the
   "CURRENT BRANCH" section below) or similar.

 . The description leaves implicit why copying files from the index,
   updating the index and work tree to match a commit, switching
   branches, and getting a quick summary of unregistered changes
   deserve a single command.

   Yet for some reason it feels natural that they share one.  Is this
   force of habit from rcs co and its derivatives, or is there some
   common theme that would be simple to explain?

> In 76cfadf, I split this into
> 
>   git checkout [<branch>]
>   git checkout -b <new branch> [<start_point>]
>
> I wonder if we should do the same here (the distinction is that
> <start_point> is treated differently from <branch>, especially with
> respect to creating a detached HEAD).

Reasonable.

> Might it be easier to understand if we say "in this form of the
> command" or something like that? Since we are now listing each form in
> turn, the user can presumably figure out which form they are trying to
> use.

Good point, thanks.

-- %< --
Subject: Documentation/checkout: clarify description

git checkout can be used to switch branches and to retrieve files from
the index or an arbitrary tree.  Split the description into
subsections corresponding to each mode to make each use easier to
understand.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-checkout.txt |   50 +++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4505eb6..e337628 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -15,33 +15,41 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-
-When <paths> are not given, this command switches branches by
-updating the index, working tree, and HEAD to reflect the specified
+Updates files in the working tree to match the version in the index
+or the specified tree.  If no paths are given, 'git checkout' will
+also update `HEAD` to set the specified branch as the current
 branch.
 
-If `-b` is given, a new branch is created and checked out, as if
-linkgit:git-branch[1] were called; in this case you can
-use the --track or --no-track options, which will be passed to `git
-branch`.  As a convenience, --track without `-b` implies branch
-creation; see the description of --track below.
+'git checkout' [<branch>]::
+'git checkout' -b <new branch> [<start point>]::
 
-When <paths> or --patch are given, this command does *not* switch
-branches.  It updates the named paths in the working tree from
-the index file, or from a named <tree-ish> (most often a commit).  In
-this case, the `-b` and `--track` options are meaningless and giving
-either of them results in an error. The <tree-ish> argument can be
-used to specify a specific tree-ish (i.e. commit, tag or tree)
-to update the index for the given paths before updating the
-working tree.
+	This form switches branches by updating the index, working
+	tree, and HEAD to reflect the specified branch.
++
+If `-b` is given, a new branch is created as if linkgit:git-branch[1]
+were called and then checked out; in this case you can
+use the `--track` or `--no-track` options, which will be passed to
+'git branch'.  As a convenience, `--track` without `-b` implies branch
+creation; see the description of `--track` below.
 
-The index may contain unmerged entries after a failed merge.  By
-default, if you try to check out such an entry from the index, the
+'git checkout' [--patch] [<tree-ish>] [--] <pathspec>...::
+
+	When <paths> or `--patch` are given, 'git checkout' *not* switch
+	branches.  It updates the named paths in the working tree from
+	the index file or from a named <tree-ish> (most often a commit).  In
+	this case, the `-b` and `--track` options are meaningless and giving
+	either of them results in an error. The <tree-ish> argument can be
+	used to specify a specific tree-ish (i.e. commit, tag or tree)
+	to update the index for the given paths before updating the
+	working tree.
++
+The index may contain unmerged entries because of a previous failed merge.
+By default, if you try to check out such an entry from the index, the
 checkout operation will fail and nothing will be checked out.
-Using -f will ignore these unmerged entries.  The contents from a
+Using `-f` will ignore these unmerged entries.  The contents from a
 specific side of the merge can be checked out of the index by
-using --ours or --theirs.  With -m, changes made to the working tree
-file can be discarded to recreate the original conflicted merge result.
+using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
+file can be discarded to re-create the original conflicted merge result.
 
 OPTIONS
 -------
-- 
1.7.1
