From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] rebase -i: reword in-editor documentation of "exec"
Date: Sat, 15 Jan 2011 20:01:32 -0600
Message-ID: <20110116020132.GB28137@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jan 16 03:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeHwD-0003y4-Qu
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 03:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab1APCBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 21:01:43 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58567 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab1APCBn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 21:01:43 -0500
Received: by ywl5 with SMTP id 5so1317822ywl.19
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 18:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SzJ++4omGS4cyL7wVID1gRg3MjvFKgdA5RMQEF8uSKk=;
        b=g4kjvkSg+a7Ry9cXc2QwbNfDCIi/OtZz++WHhnqKTgzZafLYdO3lir2VENtzyTKOMn
         3ws4ZItfpZc+NXgemhFVZK77ATJ1HET71iCHGSWsnIrBZ+h4PmdIpzgE6YLuV9uLgj7A
         YZtdbAhn6f4vAecyxy4cJsCmdUnIBYNHsV9Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HyRb1XYCol6vomZAJMeZi7ZhdRV/9kgAaDKartoQ5jUWKOEdiGhapq+0uWYBHYdVE7
         Qvrg1UYX2ah7Uet30TWA/y1CAMV+riFL+NIq8CC6+JvQaQyr8eV8RwQ4L0siyh5DawTT
         ESm+vPT9m53+0o9ZB9qGYPTL6aE4BttrvUsLs=
Received: by 10.150.228.20 with SMTP id a20mr2829246ybh.422.1295143302462;
        Sat, 15 Jan 2011 18:01:42 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id v6sm1322653ybk.20.2011.01.15.18.01.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 18:01:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110116015941.GA28137@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165151>

The argument to the "exec" insn represents a command to be passed to
the user's shell.  (At first I misread the description as meaning it
should itself be the name of a shell.)

While fixing that, format the description to more closely parallel
the descriptions of other commands.

Before:

 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but [...]
 #  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.

After:

 [...]
 #  f, fixup = like "squash", but [...]
 #  x, exec = run command using shell, and stop if it fails
 #
 # If you remove a line [...]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
It would be nice to say "stop for amending if it fails" (or similar)
to make the relationship to the edit insn clearer, but it is not clear
how to make room for that.

 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a5ffd9a..09aeecf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1021,7 +1021,7 @@ first and then run 'git rebase --continue' again."
 #  e, edit = use commit, but stop for amending
 #  s, squash = use commit, but meld into previous commit
 #  f, fixup = like "squash", but discard this commit's log message
-#  x <cmd>, exec <cmd> = Run a shell command <cmd>, and stop if it fails
+#  x, exec = run command using shell, and stop if it fails
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
-- 
1.7.4.rc2
