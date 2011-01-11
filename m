From: "Philipp Marek" <philipp@marek.priv.at>
Subject: [RFC] Support for arbitrary tags in commits
Date: Tue, 11 Jan 2011 13:23:32 +0100 (CET)
Message-ID: <74b0628dffbd2bc0adabe5e8b0a10960.squirrel@webmail.hitco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 13:31:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcdNL-0004c0-SN
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 13:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510Ab1AKMay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 07:30:54 -0500
Received: from vps.hitco.at ([84.200.20.238]:53981 "EHLO vps.hitco.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab1AKMax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 07:30:53 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2011 07:30:52 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by vps.hitco.at (Postfix) with ESMTP id 10A6E9C68017
	for <git@vger.kernel.org>; Tue, 11 Jan 2011 13:23:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vps.hitco.at
X-Spam-Flag: NO
X-Spam-Score: -4.282
X-Spam-Level: 
X-Spam-Status: No, score=-4.282 tagged_above=-999 required=6.31
	tests=[ALL_TRUSTED=-1.8, AWL=0.117, BAYES_00=-2.599]
Received: from vps.hitco.at ([127.0.0.1])
	by localhost (vps.hitco.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u+Wn5AuWQijT for <git@vger.kernel.org>;
	Tue, 11 Jan 2011 13:23:32 +0100 (CET)
Received: from webmail.hitco.org (localhost.localdomain [127.0.0.1])
	by vps.hitco.at (Postfix) with ESMTP id E2F819C68001
	for <git@vger.kernel.org>; Tue, 11 Jan 2011 13:23:32 +0100 (CET)
Received: from 86.59.100.100
        (SquirrelMail authenticated user flip)
        by webmail.hitco.org with HTTP;
        Tue, 11 Jan 2011 13:23:32 +0100 (CET)
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164932>

Hello everybody,

I'd like to attach some additional data to commits.

The best way I've found (so far) is to put an additional header line in the
commit header that references an additional blob.


Currently I've found "tree", "parent", "author", "committer", and so on; git
accepts additional lines before the "\n\n" separator (and the commit message),
so that's where I'd like to put the line.

"git fsck" allows that, too; only "rebase -i" and similar don't know about them
(yet), and discard them.


Now I want to ask:
 * Is this acceptable?
 * If yes, I'd try to provide a patch to make "amend" and similar keep the
   header-lines (by collecting them in order - obviously with editing commits
   a header could exist multiple times).
 * Perhaps there should be an option for "git-commit" that inserts arbitrary
   header lines?
 * Is there some documentation for the commit-file format so that this can be
   written down?
 * How should namespace-issues be handled?
   I can imagine that multiple people want to put data there, how should the
   tag be allocated?
   This could be solved by the previous point, ie. there's some page that
   header tags should be registered at to avoid collisions.


Thank you for all feedback.


Regards,

Phil


-- 
Versioning your /etc, /home or even your whole installation?
             Try fsvs (fsvs.tigris.org)!
