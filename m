From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH v2] Remarks that tags need to be pushed explicitly
Date: Fri, 10 Jun 2011 22:39:43 +0200
Message-ID: <20110610203943.GA50937@sherwood.local>
References: <7vk4cx7mst.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:40:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV8Uo-0006hg-AV
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab1FJUjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:39:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65230 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab1FJUjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:39:53 -0400
Received: by bwz15 with SMTP id 15so2486469bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R5KSen9+7FltuEyqLNRZ4jsRwm7TA1OEK50Yj69JGIE=;
        b=U+RaQ9Sn+x6ad7E4RO8xUAERlEjtG28Xk+jrsVsLkbKIznDF9qb6YfxPP8v0Y4t6L0
         XUNSI5ZYK3bjUw7AXg/djjZFOu+BgTJcl0GA/BR5I29NUMMufPsaGtoWbjDQ2bW5l9UZ
         06u2dFwNMRE8GpW2mkJoeTMog8NrlMls2Q0ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        b=VaGuuPPjFHa9dQQaEqsc9DoZ2p37ZmjWD2CmuBLhXstTkbNxPsQMKTjg24SYR5qKRy
         onow2d8WWUTBIa0FxW8YYDr0+R0h+ukNIBgTG3S9p2VUrAKMwP/wAJLyz//2mUckUKc8
         9ZjhA1Oj0zocGBEzNxoduUHa+ACI/OWmP2+qE=
Received: by 10.204.47.68 with SMTP id m4mr311906bkf.54.1307738391055;
        Fri, 10 Jun 2011 13:39:51 -0700 (PDT)
Received: from sherwood.local ([89.204.153.249])
        by mx.google.com with ESMTPS id g2sm2900389bkz.23.2011.06.10.13.39.47
        (version=SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 13:39:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk4cx7mst.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175627>

Well here is a somewhat more sophisticated version of this tiny
documentation patch.  I believe this is a good thing now for
newbie users who have not yet created any git(1) specific synapses
(except for the term "branch-related <refspec>", but "any valid
<refspec>" is a bit misleading since you will see nowhere that
"ref/tags/*" is not a valid <refspec> unless you know this is
a logical thing; heroes may know at a glance).

I don't like gitworkflows.txt as a direct link after tutorial and
tutorial-2.  It's much too specialized in my eyes.  What is really
missing here is a tutorial-3 which only talks about, and gives
myriads of examples for pull/fetch and push, including easy
configuration examples and corner cases (like "ref/tags/*").
Maybe in six month or a bit later i have gathered enough knowledge
to be able to write that in theory.  :)

P.S.: And please forget that 'tag --autopush' idea.  Not even
'tag --autopush-to=REMOTE' seems to be sensible to me anymore
(because it's much easier to script that locally than to support
that in git(1)).

Have a nice weekend (if you can).
--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments

-- >8 --
An updated patch of the try to smoothly integrate some more
easy informations about pushing of tags.

Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---
 Documentation/git-push.txt    |   10 +++++++---
 Documentation/git-tag.txt     |    4 +++-
 Documentation/user-manual.txt |    6 +++---
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 88acfcd..e3af6da 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -55,7 +55,7 @@ you can tell git to update the <dst> ref even when the update is not a
 fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
 EXAMPLES below for details.
 +
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+Use of `tag <tag>` is identical to `refs/tags/<tag>:refs/tags/<tag>`.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
@@ -340,8 +340,8 @@ The default behavior of this command when no <refspec> is given can be
 configured by setting the `push` option of the remote.
 +
 For example, to default to pushing only the current branch to `origin`
-use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
-the ones in the examples below) can be configured as the default for
+use `git config remote.origin.push HEAD`.  Any valid branch-related <refspec>
+(like the ones in the examples below) can be configured as the default for
 `git push origin`.
 
 git push origin :::
@@ -371,6 +371,10 @@ git push origin HEAD:master::
 	`origin` repository. This form is convenient to push the current
 	branch without thinking about its local name.
 
+git push origin tag v1.5::
+	Push the `v1.5` tag to the `origin` repository.
+	Short hand for `git push origin refs/tags/v1.5:refs/tags/v1.5`.
+
 git push origin master:refs/heads/experimental::
 	Create the branch `experimental` in the `origin` repository
 	by copying the current `master` branch.  This form is only
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index d82f621..a4cd4c3 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -27,7 +27,8 @@ Unless `-f` is given, the tag to be created must not yet exist in the
 If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
 creates a 'tag' object, and requires a tag message.  Unless
 `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
-in the tag message.
+in the tag message.  Tag objects are shareable and can be pushed upstream with
+linkgit:git-push[1].
 
 If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
 are absent, `-a` is implied.
@@ -260,6 +261,7 @@ include::date-formats.txt[]
 
 SEE ALSO
 --------
+linkgit:git-push[1].
 linkgit:git-check-ref-format[1].
 
 GIT
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f13a846..168e530 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -643,9 +643,9 @@ $ git tag stable-1 1b2e1d63ff
 You can use stable-1 to refer to the commit 1b2e1d63ff.
 
 This creates a "lightweight" tag.  If you would also like to include a
-comment with the tag, and possibly sign it cryptographically, then you
-should create a tag object instead; see the linkgit:git-tag[1] man page
-for details.
+comment with the tag, possibly sign the tag cryptographically, or publish the
+tag in a shared repository, then you should create a tag object instead; see
+the linkgit:git-tag[1] man page for details.
 
 [[browsing-revisions]]
 Browsing revisions
-- 
1.7.6.rc0
