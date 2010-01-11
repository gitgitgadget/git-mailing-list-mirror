From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/6] Documentation: merge: add an overview
Date: Mon, 11 Jan 2010 02:30:28 -0600
Message-ID: <20100111083028.GB23806@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
 <20100110044949.GA8974@progeny.tock>
 <7vskaefp2v.fsf@alter.siamese.dyndns.org>
 <20100111021322.GA8480@progeny.tock>
 <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
 <20100111041318.GA9806@progeny.tock>
 <20100111082123.GA23742@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 09:31:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFfv-0000d9-6Y
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab0AKIab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 03:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691Ab0AKIa3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:30:29 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:47540 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab0AKIa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 03:30:27 -0500
Received: by ywh6 with SMTP id 6so21249392ywh.4
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 00:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=a060GRgSpTuDab0GiHeRcvs0UzLFHce/4s3SeLdCOLc=;
        b=q71SPtLnA61yv9r5PuJ22wtL8TDeXsQ9CijJgNDg3jIH5Mcdxc+J9Qb8qdskX3a3YJ
         lDbjcoQO5HT7qxydttxHK7oIwWel20H+En4WzK6Vj+ysY/+3t+R2Lp8VG8YLjicunMyS
         y84/rICZAFLeuxnZAy+ZatszmGkWDzJCmCRd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dqD9AzRrqjtYcx/Qbk8xccUmdB73kwKwDkRxuzelXTNe8hD387DGW64PrKb0we3ww3
         pFF3kRPNiyVuuYa5r33t1PwL8Tl7Twsu4Uzag0EanHiP+RPbKqNOHqIncZ2OrX5QimN6
         snpdfS0geVwbW5IPEce5XdZDn2l7gfUByA1wE=
Received: by 10.90.17.2 with SMTP id 2mr5524683agq.100.1263198626885;
        Mon, 11 Jan 2010 00:30:26 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1363452iwn.5.2010.01.11.00.30.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 00:30:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100111082123.GA23742@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136619>

The reader unfamiliar with the concepts of branching and merging
would have been completely lost.  Try to help him with a diagram.

The diagram comes from the 'git rebase' manual page.

Cc: Petr Baudis <pasky@suse.cz>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>,
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Does this tell enough of the story?

 Documentation/git-merge.txt |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 394ad0a..fe190e2 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -14,8 +14,31 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This is the top-level interface to the merge machinery
-which drives multiple merge strategy scripts.
+Incorporates changes leading up to the named commits into the
+current branch.  This command is used by 'git pull' to incorporate
+remote changes from another repository and may be used by hand to
+merge changes from one branch into another.
+
+Assume the following history exists and the current branch is
+"`master`":
+
+------------
+          A---B---C topic
+         /
+    D---E---F---G master
+------------
+
+Then "`git merge topic`" will apply the changes from `A`, `B`,
+and `C` to the work tree, and if they do not conflict with any
+changes from `master`, will store the result in a new commit along
+with the names of the two parent commits and a log message from the
+user describing the changes.
+
+------------
+          A---B---C topic
+         /         \
+    D---E---F---G---H master
+------------
 
 The second syntax (<msg> `HEAD` <remote>) is supported for
 historical reasons.  Do not use it from the command line or in
-- 
1.6.6
