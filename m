From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] Documentation/notes: simplify treatment of default
 display refs
Date: Sat, 8 May 2010 22:32:24 -0500
Message-ID: <20100509033223.GF7958@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:32:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAxFY-00049I-Qd
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab0EIDbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 23:31:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46686 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0EIDbV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:31:21 -0400
Received: by gwj19 with SMTP id 19so1374484gwj.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3mEfGKg4WpuyEr9OsFYDMH4GxwdszS8C6C6H2d8Bhc4=;
        b=U55l6E5zVpR8Rk22DkhYGwIlgDDS+rtEbl98BaNlmb3PoK/tybrlaRzSuiJ07zD0Ia
         B+r1UsUuK4fC7ZOIH62ns4MuZ7vDPIbu1aZ9PC6DN3sUAQR4oTJRVmTyX30/6pDx5bxG
         4Jzq4UGZflPHKa75WfQGMBQLpqblVAkTfj9PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e9bNg4Ce+dSAdo/4sqRSvo1E57j3I71u83zw+mCYHRPdozgFsXNHA2Bgo+RoEiQ38F
         7WhZd4pir3YXeR6DAYwIS2vqjwEp2w5NEZHwn1rKikEQ8MABdemkRNKx5RCjylDcvNLb
         ZRqdzfsgc39bBHeDZ+a0X8Vt5xEj4SRJ7GJZ8=
Received: by 10.150.63.17 with SMTP id l17mr6113687yba.115.1273375880625;
        Sat, 08 May 2010 20:31:20 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2581625yxe.3.2010.05.08.20.31.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:31:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509031357.GA7926@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146697>

The main description of display refs for notes should be in
git-log.1, where there is a chance to give a leisurely description
of all the ways they can be set, what they are used for, and so
on.  The description in git-notes.1 is only meant to be a quick
reminder of how notes are used.

So simplify it.

Also add an entry for GIT_NOTES_DISPLAY_REF to the environment
section.

Cc: Thomas Rast <trast@student.ethz.ch>
Cc: Johan Herland <johan@herland.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-notes.txt |   36 +++++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 28ac862..7856b28 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -35,8 +35,8 @@ message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
 "Notes:" for `refs/notes/commits`).
 
-To change which notes are shown by 'git-log', see the
-"notes.displayRef" configuration.
+To change which notes are shown by 'git log', see the
+"notes.displayRef" configuration in linkgit:git-log[1].
 
 See the description of "notes.rewrite.<command>" in
 linkgit:git-config[1] for a way of carrying your notes across commands
@@ -196,21 +196,13 @@ core.notesRef::
 	command line.
 
 notes.displayRef::
-	The (fully qualified) refname from which to show notes when
-	showing commit messages.  The value of this variable can be set
-	to a glob, in which case notes from all matching refs will be
-	shown.  You may also specify this configuration variable
-	several times.  A warning will be issued for refs that do not
-	exist, but a glob that does not match any refs is silently
-	ignored.
-+
-This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
-+
-The effective value of "core.notesRef" (possibly overridden by
-GIT_NOTES_REF) is also implicitly added to the list of refs to be
-displayed.
+	Which ref (or refs, if a glob or specified more than once), in
+	addition to the default set by `core.notesRef` or
+	'GIT_NOTES_REF', to read notes from when showing commit
+	messages with the 'git log' family of commands.
+	This setting can be overridden on the command line or by the
+	'GIT_NOTES_DISPLAY_REF' environment variable.
+	See linkgit:git-log[1].
 
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
@@ -250,6 +242,16 @@ ENVIRONMENT
 	Which ref to manipulate notes from, instead of `refs/notes/commits`.
 	This overrides the `core.notesRef` setting.
 
+'GIT_NOTES_DISPLAY_REF'::
+	Colon-delimited list of refs or globs indicating which refs,
+	in addition to the default from `core.notesRef` or
+	'GIT_NOTES_REF', to read notes from when showing commit
+	messages.
+	This overrides the `notes.displayRef` setting.
++
+A warning will be issued for refs that do not exist, but a glob that
+does not match any refs is silently ignored.
+
 
 Author
 ------
-- 
1.7.1
