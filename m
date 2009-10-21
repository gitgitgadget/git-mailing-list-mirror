From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] modernize fetch/merge/pull examples
Date: Wed, 21 Oct 2009 19:21:23 +0200
Message-ID: <20091021172123.GB27495@localhost>
References: <200910201947.50423.trast@student.ethz.ch> <alpine.LNX.2.00.0910201912390.14365@iabervon.org> <20091021030608.GA18997@atjola.homenet> <7vk4ypb71j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 19:21:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0esR-0007n0-2I
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbZJURVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 13:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbZJURVY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:21:24 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:57616 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbZJURVX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 13:21:23 -0400
Received: by fxm18 with SMTP id 18so8009272fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Qb2K6qcSqCaVGnxPUvuUD6wZmubvKPyDiEvuNNdEktQ=;
        b=UXwjMUF8NrRax0kgwnKFfItoi9Lm7/jIdlKI8OO0MPyXqQKbz7k4OCj/5snAtBZJaH
         LOX85VLO6ubVBCCH9A1qnRPmTOOxemcmA4/6sljQlRwkRSjjQbDTFALPRa3BkijNBmLh
         gy2Gi4ifhJ97okVbjVKt9q3YRzXuxkp4GbC8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=oTFJMmrwuw6+dIwTrrs39mt1CI92/DiO3Nv3iW3uH2wLh8d1zB1BOlsnJkte/cWBrE
         7iikXpifUF7S1fRn0fpkfy3AuITu/l7LqKtcYKsTyl7Q6YmKGYjuzGjqKMdhDYhkjJ0v
         8EOqeUZHEzBvR0xX3C5FdFY2+2QqvEyGB6NhY=
Received: by 10.204.32.146 with SMTP id c18mr8173317bkd.88.1256145687065;
        Wed, 21 Oct 2009 10:21:27 -0700 (PDT)
Received: from darc.lan (p549A742E.dip.t-dialin.net [84.154.116.46])
        by mx.google.com with ESMTPS id 9sm557552fxm.34.2009.10.21.10.21.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 10:21:26 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N0esF-0007VA-TI; Wed, 21 Oct 2009 19:21:23 +0200
Content-Disposition: inline
In-Reply-To: <7vk4ypb71j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130941>

The "git pull" documentation has examples which follow an outdated
style. Update the examples to use "git merge" where appropriate and
move the examples to the corresponding manpages.

Furthermore,

 o show that pull is equivalent to fetch and merge, which is still a
   frequently asked question,

 o explain the default fetch refspec.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
On Tue, Oct 20, 2009 at 11:22:16PM -0700, Junio C Hamano wrote:

> For example, I am in favor of deprecating the "pull $there $src:$dst"
> notation. 

A first step in that direction.

Clemens

 Documentation/git-fetch.txt |   29 +++++++++++++++++++++++++
 Documentation/git-merge.txt |   33 +++++++++++++++++++++++++++++
 Documentation/git-pull.txt  |   49 +++---------------------------------------
 3 files changed, 66 insertions(+), 45 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d3164c5..c76077d 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -37,6 +37,35 @@ include::pull-fetch-param.txt[]
 
 include::urls-remotes.txt[]
 
+
+EXAMPLES
+--------
+
+* Update the remote-tracking branches:
++
+------------------------------------------------
+$ git fetch origin
+------------------------------------------------
++
+The above command copies all branches from the remote refs/heads/
+namespace and stores them to the local refs/remotes/origin/ namespace,
+unless the branch.<name>.fetch option is used to specify a non-default
+refspec.
+
+* Using refspecs explicitly:
++
+------------------------------------------------
+$ git fetch origin +pu:pu maint:tmp
+------------------------------------------------
++
+This updates (or creates, as necessary) branches `pu` and `tmp` in
+the local repository by fetching from the branches (respectively)
+`pu` and `maint` from the remote repository.
++
+The `pu` branch will be updated even if it is does not fast-forward;
+the others will not be.
+
+
 SEE ALSO
 --------
 linkgit:git-pull[1]
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index d05f324..2a41d62 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -212,6 +212,39 @@ You can work through the conflict with a number of tools:
    common ancestor, 'git show :2:filename' shows the HEAD
    version and 'git show :3:filename' shows the remote version.
 
+
+EXAMPLES
+--------
+
+* Bundle branches `fixes` and `enhancements` on top of
+  the current branch, making an Octopus merge:
++
+------------------------------------------------
+$ git merge fixes enhancements
+------------------------------------------------
+
+* Merge branch `obsolete` into the current branch, using `ours`
+  merge strategy:
++
+------------------------------------------------
+$ git merge -s ours obsolete
+------------------------------------------------
+
+* Merge branch `maint` into the current branch, but do not make
+  a commit automatically:
++
+------------------------------------------------
+$ git merge --no-commit maint
+------------------------------------------------
++
+This can be used when you want to include further changes to the
+merge, or want to write your own merge commit message.
++
+You should refrain from abusing this option to sneak substantial
+changes into a merge commit.  Small fixups like bumping
+release/version name would be acceptable.
+
+
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 7578623..de2bcd6 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -131,54 +131,13 @@ $ git pull origin next
 ------------------------------------------------
 +
 This leaves a copy of `next` temporarily in FETCH_HEAD, but
-does not update any remote-tracking branches.
-
-* Bundle local branch `fixes` and `enhancements` on top of
-  the current branch, making an Octopus merge:
-+
-------------------------------------------------
-$ git pull . fixes enhancements
-------------------------------------------------
-+
-This `git pull .` syntax is equivalent to `git merge`.
-
-* Merge local branch `obsolete` into the current branch, using `ours`
-  merge strategy:
-+
-------------------------------------------------
-$ git pull -s ours . obsolete
-------------------------------------------------
-
-* Merge local branch `maint` into the current branch, but do not make
-  a commit automatically:
+does not update any remote-tracking branches. Using remote-tracking
+branches, the same can be done by invoking fetch and merge:
 +
 ------------------------------------------------
-$ git pull --no-commit . maint
+$ git fetch origin
+$ git merge origin/next
 ------------------------------------------------
-+
-This can be used when you want to include further changes to the
-merge, or want to write your own merge commit message.
-+
-You should refrain from abusing this option to sneak substantial
-changes into a merge commit.  Small fixups like bumping
-release/version name would be acceptable.
-
-* Command line pull of multiple branches from one repository:
-+
-------------------------------------------------
-$ git checkout master
-$ git fetch origin +pu:pu maint:tmp
-$ git pull . tmp
-------------------------------------------------
-+
-This updates (or creates, as necessary) branches `pu` and `tmp` in
-the local repository by fetching from the branches (respectively)
-`pu` and `maint` from the remote repository.
-+
-The `pu` branch will be updated even if it is does not fast-forward;
-the others will not be.
-+
-The final command then merges the newly fetched `tmp` into master.
 
 
 If you tried a pull which resulted in a complex conflicts and
-- 
1.6.5.1
