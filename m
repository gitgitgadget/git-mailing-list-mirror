From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH v3] Docs: Clarify the --tags option of `git fetch'
Date: Thu, 22 Sep 2011 07:23:55 -0000
Message-ID: <686c38876d5a4ad6bfac67ca77fe9bb3-mfwitten@gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
            <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
            <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
            <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
            <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
            <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
            <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
            <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com>
            <7vfwjpyzds.fsf@alter.siamese.dyndns.org>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 09:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6dji-0006hh-Bz
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 09:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab1IVHaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 03:30:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41702 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab1IVHaO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 03:30:14 -0400
Received: by bkbzt4 with SMTP id zt4so2204905bkb.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=1Dm+Fhm4Pgk2B/fnDDAQus5w1tgc8nYCt+XtBxsqDB0=;
        b=oKqik67/KvpV/0BA0ojl6FAzrJyjZpalti1zDPDGIlU6q5t4Dc1zYMqnpi/Fy8Z7yO
         jD/RcsEtJBdf6eqaLktp0n845WyrRFnU6zYc3wNtNgAQp46bAefMAMDp0G8X5BrStlna
         Y+LOHeU9uAtD4cIjXLrTmhDNQWBg+lM+VumIE=
Received: by 10.204.139.72 with SMTP id d8mr1210823bku.347.1316676612747;
        Thu, 22 Sep 2011 00:30:12 -0700 (PDT)
Received: from gmail.com (saito.countshockula.com. [65.183.151.13])
        by mx.google.com with ESMTPS id t18sm7248429bkb.9.2011.09.22.00.30.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 00:30:11 -0700 (PDT)
In-Reply-To: <7vfwjpyzds.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181887>

On Wed, 21 Sep 2011 21:28:15 -0700, Junio C Hamano wrote:

> I expect the readers to, and I hope the documentation to help them to,
> understand the following three basic facts and rules before diving into
> descriptions of individual options, such as the paragraph we are
> discussing:
>
>  * "git fetch" command serves two purposes:
>
>    (1) It transfers objects the repository the command is invoked in does
>    not have from the remote repository. The objects transferred are the
>    commits that are necessary to complete the ancestry chain of _some_
>    history, and data (i.e. trees and blobs) associated to use these
>    commits.
>
>    (2) It optionally can update the local refs (e.g. branches and tags)
>    with copies of the refs taken from the remote repository.
>
>  * In the above, the user needs to tell the command two things. One is
>    "where the remote repository is". The other is "what refs to fetch and
>    (optionally) how to store them". The latter "what to fetch" also
>    determines what that "_some_ history" above is (i.e. everything
>    reachable from the refs that are fetched).
>
>  * "What to fetch and how to store" have a default, recorded in the
>    repository configuration file, that is used when the user does not give
>    that information to the command from the command line. If the user does
>    give that information from the command line, that default is not used
>    at all. IOW, the command line overrides the default.
>
> With that understanding, the _only_ thing that "--tags" description needs
> to talk about is that it is an explicit way to give that "what to fetch
> and how to store" information from the command line. It instructs the
> command to fetch all the tags from the remote repository and store them
> locally.

For at least the near term, this patch may do a pretty good job of
achieving those goals without having to change too much; I do some
careful maneuvering to avoid mentioning refspecs until quite late
in the description.

8<-----------8<-----------8<-----------8<-----------8<-----------8<-----------

See the discussion starting here:

  [PATCH] Clarify that '--tags' fetches tags only
  Message-ID: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/180636

Suggested-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/fetch-options.txt |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 39d326a..4cc5a80 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -56,14 +56,29 @@ endif::git-pull[]
 ifndef::git-pull[]
 -t::
 --tags::
-	Most of the tags are fetched automatically as branch
-	heads are downloaded, but tags that do not point at
-	objects reachable from the branch heads that are being
-	tracked will not be fetched by this mechanism.  This
-	flag lets all tags and their associated objects be
-	downloaded. The default behavior for a remote may be
-	specified with the remote.<name>.tagopt setting. See
-	linkgit:git-config[1].
+	Most of a remote's tags are fetched automatically as branches are
+	downloaded. However, git does not automatically fetch any tag that,
+	when 'git fetch' completes, would not be reachable from any local
+	branch head.  This option tells git to fetch all tags (and their
+	associated objects).
++
+The 'git fetch' command is often supplied with a default set of branch
+heads to fetch, but using this option tells 'git fetch' to ignore those
+defaults.
++
+This option is merely a shorthand for writing the refspec
+`refs/tags/\*:refs/tags/\*'; that is,
++
+	git fetch origin --tags
+	git fetch origin --tags frotz
++
+are equivalent to:
++
+	git fetch origin 'refs/tags/*:refs/tags/*'
+	git fetch origin frotz 'refs/tags/*:refs/tags/*'
++
+The default behavior for a remote may be specified with
+the remote.<name>.tagopt setting. See linkgit:git-config[1].
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-- 
1.7.6.409.ge7a85
