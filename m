From: Johan Herland <johan@herland.net>
Subject: Re: [WIP/RFC 13/13] Documentation: Preliminary docs on 'git notes
 merge'
Date: Sun, 25 Jul 2010 21:02:52 +0200
Message-ID: <201007252102.52632.johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
 <1279880104-29796-14-git-send-email-johan@herland.net>
 <4C4AA297.4090605@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 21:03:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od6TT-0005qR-I5
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab0GYTCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 15:02:55 -0400
Received: from smtp.getmail.no ([84.208.15.66]:42076 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469Ab0GYTCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:02:54 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6400A5TNKTWAB0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 25 Jul 2010 21:02:53 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2F6251EA554B_C4C8A5DB	for <git@vger.kernel.org>; Sun,
 25 Jul 2010 19:02:53 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 11DA41EA3FA9_C4C8A5DF	for <git@vger.kernel.org>; Sun,
 25 Jul 2010 19:02:53 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L640043TNKSK020@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 25 Jul 2010 21:02:53 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <4C4AA297.4090605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151779>

On Saturday 24 July 2010, Stephen Boyd wrote:
>   On 07/23/2010 03:15 AM, Johan Herland wrote:
> > +-X<strategy>::
> > +--resolve=<strategy>::
> > +	When merging notes, resolve notes conflicts using the given
> > +	strategy. The following strategies are recognized: "manual"
> > +	(default), "ours", "theirs" and "union". "ours" automatically
> > +	resolves conflicting notes in favor of the local version (i.e.
> > +	the current notes ref). "theirs" auto-resolves notes conflicts
> > +	in favor of the remote version (i.e. the given notes ref being
> > +	merged into the current notes ref). "union" auto-resolves
> > +	notes conflicts by concatenating the local and remote versions.
> > +
> 
> We use both "auto-resolves" and "automatically resolves" in this
> paragraph. Perhaps it's better to use one term throughout?

Agreed. I'll squash the following into the next iteration:


...Johan


diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index f4ad4cc..9228349 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -90,8 +90,9 @@ merge::
 	notes ref (called "remote") since the merge-base (if
 	any) into the current notes ref (called "local").
 +
-If conflicts arise (and a strategy for auto-resolving conflicting notes
-(see the -X/--resolve option) is not given, the merge fails (TODO).
+If conflicts arise (and a strategy for automatically resolving
+conflicting notes (see the -X/--resolve option) is not given,
+the merge fails (TODO).
 
 remove::
 	Remove the notes for a given object (defaults to HEAD).
@@ -146,12 +147,14 @@ OPTIONS
 --resolve=<strategy>::
 	When merging notes, resolve notes conflicts using the given
 	strategy. The following strategies are recognized: "manual"
-	(default), "ours", "theirs" and "union". "ours" automatically
-	resolves conflicting notes in favor of the local version (i.e.
-	the current notes ref). "theirs" auto-resolves notes conflicts
-	in favor of the remote version (i.e. the given notes ref being
-	merged into the current notes ref). "union" auto-resolves
-	notes conflicts by concatenating the local and remote versions.
+	(default), "ours", "theirs" and "union".
+	"ours" automatically resolves conflicting notes in favor of the
+	local version (i.e. the current notes ref).
+	"theirs" automatically resolves notes conflicts in favor of the
+	remote version (i.e. the given notes ref being merged into the
+	current notes ref).
+	"union" automatically resolves notes conflicts by concatenating
+	the local and remote versions.
 
 -q::
 --quiet::



-- 
Johan Herland, <johan@herland.net>
www.herland.net
