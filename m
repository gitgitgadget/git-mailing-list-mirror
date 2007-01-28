From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sun, 28 Jan 2007 02:34:52 +0100
Message-ID: <20070128013452.GA11244@moooo.ath.cx>
References: <20070127062826.GE14205@fieldses.org> <20070128002246.GA10179@moooo.ath.cx> <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 02:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAywr-0005oZ-Br
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 02:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbXA1Be5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 20:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbXA1Be5
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 20:34:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:60190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932257AbXA1Be4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 20:34:56 -0500
Received: (qmail invoked by alias); 28 Jan 2007 01:34:55 -0000
Received: from pD9EB8A68.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.104]
  by mail.gmx.net (mp038) with SMTP; 28 Jan 2007 02:34:55 +0100
X-Authenticated: #5358227
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38009>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> I dunno. I really think that editing the config file is actually simpler.
> 
> The "git repo-config" thing is really usefull from scripting, and for 
> general automation, but maybe it's just me - I find human-readable ASCII 
> files that you can put comments in etc just *nice*.
> 
> I think the whole notion that you have to use a tool to edit 
> configurations is asinine. It's good to have a tool for automation, but 
> it's bad if that's the only way to interact with the system.
> 
> The first time I had to use AIX, and realized that they do everything with 
> some crazy system management tool, and that you can't do anything by 
> editing files in /etc, I realized that IBM was totally incompetent when it 
> came to UNIX.
> 
> I mean, do people _really_ think that it's easier to do black magic 
> scripts like
> 
> 	git repo-config --global user.name "Your Name Comes Here"
> 
> (which not only looks scary, but means that the user will never learn 
> about the git config file at all), or just somebody saying:
> 
> 	"Fill your .git/config file with
> 
> 		[user]
> 			name = Your Name Here
> 			email = your@email.example
> 
> 	 and be happy"
> 
> I'm just saying that the second example seems to not only be more 
> human-friendly, it actually teaches people something that "git 
> repo-config" never did. 
> 
> Maybe most users will just do what they are told without thinking about 
> it, but then some users will look at that and say "Ahh, there's a 
> .git/config file, I wonder what else I could do there.."

Good point, otoh the git-repo-config manual page is actually the one
documenting .git/config :).  Therefore I think the manual should
mention git-repo-config(1) for information on .git/config with the
first use of the config file (actually the second because the first is
in part 1 which is only a list of commands).

Later in the manual git-repo-config is used to read (-l) and edit the
config file, perhaps there should be a short sentence that there is no
difference to editing .git/config directly.

---
user-manual: mention git-repo-config(1) with .git/config

---
 Documentation/user-manual.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 87c605f..509a867 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -603,7 +603,8 @@ $ cat .git/config
 
 This is what causes git to track the remote's branches; you may
 modify or delete these configuration options by editing .git/config
-with a text editor.
+with a text editor.  See gitlink:git-repo-config[1] for more
+information on .git/config.
 
 Exploring git history
 =====================
-- 
1.5.0.rc2.g18af
