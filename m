From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/8] Documentation/notes: add configuration section
Date: Sat, 8 May 2010 22:21:59 -0500
Message-ID: <20100509032159.GC7958@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:21:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAx4g-0001GH-Ft
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab0EIDU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 23:20:57 -0400
Received: from mail-qy0-f195.google.com ([209.85.221.195]:44436 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0EIDU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:20:56 -0400
Received: by qyk33 with SMTP id 33so4251949qyk.24
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=L3aLt7SKuAFJm0a8W3RKQcq6oMFH/3DaktFXuS4atrY=;
        b=B8VU2ufAtoOCcOkdv17y1rk+0P6cL8nBDSZJACR0kE6ZOJOCcNjhRYCoZuCAmXE6CQ
         g3LGtX+PSQ4pq8yTxAWmIH1VmMzAoJewo/5jC+pt/7bSKnPzJdnBnkQ4XeGu15u8FGpP
         cZKVFB8nhlW3BFkqjr1+g+KvAnsQeUr448RTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Gu7nrZoCNry8D530wBdJFltjBwT7YvxoH2SnV++iwdkEusFYivlSoVME7uaBGM2/7l
         rqZCjcQsfCsUhBVseTmN7R/hKiGfuVR3HXtFEbCbry5VmjNtzcWhXLZc4ZZVpN8OdNSS
         0nztsUbdP+HLQxJRWqvbJT02Z68LXASwTSd7I=
Received: by 10.229.234.68 with SMTP id kb4mr1621762qcb.103.1273375255480;
        Sat, 08 May 2010 20:20:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f5sm2699307qcg.8.2010.05.08.20.20.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:20:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509031357.GA7926@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146694>

Copy the descriptions of configuration variables from git-config.1.
Once the descriptions have been ironed out, it would be nice to
refactor them to share text, but for now it is simplest to experiment
with separate copies.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is straight copy and paste.

 Documentation/git-notes.txt |   59 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 97b9d81..f561457 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -183,6 +183,65 @@ with 'git log', so if you use such notes, you'll probably need to write
 some special-purpose tools to do something useful with them.
 
 
+CONFIGURATION
+-------------
+
+core.notesRef::
+	When showing commit messages, also show notes which are stored in
+	the given ref.  The ref must be fully qualified.  If the given
+	ref does not exist, it is not an error but means that no
+	notes should be printed.
++
+This setting defaults to "refs/notes/commits", and it can be overridden by
+the 'GIT_NOTES_REF' environment variable.  See linkgit:git-notes[1].
+
+notes.displayRef::
+	The (fully qualified) refname from which to show notes when
+	showing commit messages.  The value of this variable can be set
+	to a glob, in which case notes from all matching refs will be
+	shown.  You may also specify this configuration variable
+	several times.  A warning will be issued for refs that do not
+	exist, but a glob that does not match any refs is silently
+	ignored.
++
+This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
+environment variable, which must be a colon separated list of refs or
+globs.
++
+The effective value of "core.notesRef" (possibly overridden by
+GIT_NOTES_REF) is also implicitly added to the list of refs to be
+displayed.
+
+notes.rewrite.<command>::
+	When rewriting commits with <command> (currently `amend` or
+	`rebase`) and this variable is set to `true`, git
+	automatically copies your notes from the original to the
+	rewritten commit.  Defaults to `true`, but see
+	"notes.rewriteRef" below.
+
+notes.rewriteMode::
+	When copying notes during a rewrite (see the
+	"notes.rewrite.<command>" option), determines what to do if
+	the target commit already has a note.  Must be one of
+	`overwrite`, `concatenate`, or `ignore`.  Defaults to
+	`concatenate`.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
+environment variable.
+
+notes.rewriteRef::
+	When copying notes during a rewrite, specifies the (fully
+	qualified) ref whose notes should be copied.  The ref may be a
+	glob, in which case notes in all matching refs will be copied.
+	You may also specify this configuration several times.
++
+Does not have a default value; you must configure this variable to
+enable note rewriting.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
+environment variable, which must be a colon separated list of refs or
+globs.
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
-- 
1.7.1
