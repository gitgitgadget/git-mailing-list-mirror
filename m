From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Document git aliases support
Date: Wed, 7 Jun 2006 22:11:34 +0200
Message-ID: <20060607201134.GC2609@pasky.or.cz>
References: <20060607184350.31338.46653.stgit@machine.or.cz> <7vzmgog5ce.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 22:12:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo4NN-0005x6-5K
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 22:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWFGULY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 16:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWFGULX
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 16:11:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30679 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932407AbWFGULW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 16:11:22 -0400
Received: (qmail 11868 invoked by uid 2001); 7 Jun 2006 22:11:34 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmgog5ce.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21457>

Dear diary, on Wed, Jun 07, 2006 at 08:58:57PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index c861c6c..ad9ec3e 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -91,6 +91,13 @@ core.warnAmbiguousRefs::
> >  	If true, git will warn you if the ref name you passed it is ambiguous
> >  	and might match multiple refs in the .git/refs/ tree. True by default.
> >  
> > +alias.*::
> > +	Command aliases for the gitlink:git[1] command wrapper - e.g.
> > +	after defining "alias.last = cat-file commit HEAD", the invocation
> > +	"git last" is equivalent to "git cat-file commit HEAD". You cannot
> > +	override even existing command names with aliases. Arguments are
> > +	split by spaces, the usual shell quoting and escaping is supported.
> > +
> 
> "even"?  How about: "alias that hides existing command names are
> not used to avoid confusion"?

Oops, that "even" was not meant to be there. I have rephrased it a bit.

---

This patch ports and modifies appropriately the git aliases documentation
from my patch, shall it rest in peace.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/config.txt |    8 ++++++++
 Documentation/git.txt    |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c861c6c..91615c1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -91,6 +91,14 @@ core.warnAmbiguousRefs::
 	If true, git will warn you if the ref name you passed it is ambiguous
 	and might match multiple refs in the .git/refs/ tree. True by default.
 
+alias.*::
+	Command aliases for the gitlink:git[1] command wrapper - e.g.
+	after defining "alias.last = cat-file commit HEAD", the invocation
+	"git last" is equivalent to "git cat-file commit HEAD". It is not
+	allowed to redefine existing command names using aliases to avoid
+	confusion and troubles with script usage. Arguments are split by
+	spaces, the usual shell quoting and escaping is supported.
+
 apply.whitespace::
 	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See gitlink:git-apply[1].
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 24ca55d..e474bdf 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -21,6 +21,9 @@ link:everyday.html[Everyday Git] for a u
 "man git-commandname" for documentation of each command.  CVS users may
 also want to read link:cvs-migration.html[CVS migration].
 
+The COMMAND is either a name of a Git command (see below) or an alias
+as defined in the configuration file (see gitlink:git-repo-config[1]).
+
 OPTIONS
 -------
 --version::

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
