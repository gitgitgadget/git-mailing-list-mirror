From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Thu, 29 Nov 2007 02:48:22 +0100
Message-ID: <200711290248.23239.robin.rosenberg.lists@dewire.com>
References: <200711282339.59938.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:46:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxYU9-0003aH-Ev
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761523AbXK2BqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 20:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761173AbXK2BqP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:46:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:2542 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1761260AbXK2BqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 20:46:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3A28D14744E0;
	Thu, 29 Nov 2007 02:36:55 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20494-07; Thu, 29 Nov 2007 02:36:54 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 7B9C0A149A4;
	Thu, 29 Nov 2007 02:36:54 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200711282339.59938.jnareb@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66491>

onsdag 28 november 2007 skrev Jakub Narebski:
> I'd like to add Git to comparison table of SCMs at Better SCM
> Initiative site:
>   http://better-scm.berlios.de
> 
> To do that, I need to fill in infomration about Git.  Most
> of questions / items didn't give much problem, but there
> are a few on which I would like your input.
> 
> (Yes, I know that such SCM comparisons are usually biased towards the
> idea of what are most important features of a version control system.
> Nevertheless...)
[...]
> 4. Repository Permissions
> 
>    Is it possible to define permissions on access to different
>    parts of a remote repository? Or is access open for all?
> 
> "Partial (?). It is possible to lock down repository
>  (access to branches and tags) using hooks."
> 
> I don't know if it is possible to do finer level ACLs, i.e. if it
> is possible to lock subdirectories or files in Git.  Although for
> distributed SCMs ACL doesn't matter much: check diffstat and merge or
> not from trusted people.  We have "network of trust" (BTW. Karl Fogel
> in OSSBook recommends 'soft' control of access control to repository,
> on social rather than on technical level).

I think what is most interesting here is access to content for which git has
just about nothing worth mentioning, Just admit it. "Truth in advertising".

I did start doing this so here's my version (pre-msysgit). Please try to bring up the defintion
of "atomic" again with the author. I did complain a little but nothing happened. The issue is
that Clearcase is listed as having "atomic" commits which is not true for any usable definition
of atomic in SCM context. With the definition in use there I think CVS should be considered
having atomic commits too, at least I've never seen a half-committed file there.

% svn diff
Index: src/comparison/scm-comparison.xml
===================================================================
--- src/comparison/scm-comparison.xml	(revision 290)
+++ src/comparison/scm-comparison.xml	(arbetskopia)
@@ -71,6 +71,9 @@
             <impl id="ls-sync">
                 <name>LibreSource Synchronizer</name>
             </impl>
+            <impl id="git">
+                <name>Git</name>
+            </impl>
         </implementations>
         <timestamp>
             $Id$
@@ -182,6 +185,13 @@
                     needs to be up-to-date before doing a rename/move operation. 
                     This operation will be committed directly.
                 </s>
+                <s id="git">
+                    Yes (or no depending on interpretation). Git typically detects
+		    renames and copies based on content regardless of whether the
+		    committer indicated the fact. The detection is content based
+		    rather than file-id based. There is explicit rename too, but
+		    it is not used much.
+                </s>
            </compare>
         </section>
         <section id="copy">
@@ -236,6 +246,10 @@
                   limitations in Windows environments)
                 </s>
                 <s id="ls-sync">No, copies will start there own history.</s>
+                <s id="git">Yes(or no depending on interpretation). Git detects
+			copies and moves based on content. It does not track
+			history on a file-id based scheme.
+                </s>
            </compare>
         </section>
         <section id="repos_clone">
@@ -288,6 +302,11 @@
                   Yes, but is not documented and its based on the dataflow feature of the
                   LibreSource Synchronizer.
                 </s>
+                <s id="git">
+                  Yes. This is a fundamental part of using Git. A Git user typically always
+		  has a full copy of the entire repostory (well compressed) that is initialized
+		  using a clone command.
+                </s>
             </compare>
         </section>
         <section id="push">
@@ -331,6 +350,7 @@
                 <s id="cmsynergy">Yes, as long as you have the (more expensive) Distributed package.</s>
                 <s id="clearcase">Yes, using Clearcase Multisite.</s>
                 <s id="ls-sync">Yes, it's what we call a dataflow.</s>
+                <s id="git">Yes. This is a fundamental part of using Git.</s>
             </compare>
         </section>
         <section id="permissions">
@@ -417,7 +437,8 @@
                   multi-platform environments.
                 </s>
                 <s id="ls-sync">Permissions are set for the whole repository or branch.</s>
-            </compare>
+                <s id="git">No, but bad changes can be reverted before they are published.</s>
+	</compare>
         </section>
         <section id="changesets">
             <title>Changesets' Support</title>
@@ -490,6 +511,11 @@
                   Partial support. There are implicit changeset that are generated on
                   each commit.
                 </s>
+            	<s id="git">Yes. Actually Git is snapshot based which means Git records
+			the full state in every commit, which means that any two
+			commits can be compared directly very quickly, although the
+			repository is typically browsed as a series of change sets.
+                </s>
            </compare>
         </section>
         <section id="annotate">
@@ -534,6 +560,9 @@
                     Yes locally without any server connection with the standard graphical
                     Java client.
                 </s>
+            	<s id="git">Yes. It can also detect the origin of copied and moved source
+			lines.
+                </s>
            </compare>
         </section>
     </section>
@@ -610,6 +639,12 @@
                    It is possible to commit only a certain directory. However, one must
                    check out the entire repository as a whole.
                 </s>
+            	<s id="git">No. However it is possible to commit only selected 
+			changes in the working tree rather than everything. Subproject
+			support makes it possible to split large projects into several
+			repositories and link them. Related repositories need not be
+			checked out or cloned.
+                </s>
            </compare>
         </section>
         <section id="tracking_uncommited_changes">
@@ -659,6 +694,10 @@
                   Yes, with the Synchronizer Studio (default Java client) or with the
                   standard diff command (diff -r . .so6/xxx/REFCOPY/)
                 </s>
+            	<s id="git">Yes. In addition commits are local and will not be seen
+			until he/she decides to publish them making it possible to
+			track multiple versions locally before publishing.
+                </s>
             </compare>
         </section>
         <section id="per_file_commit_messages">
@@ -714,6 +753,7 @@
                   for a per-changeset message.
                 </s>
                 <s id="ls-sync">No. Commit messages are per changeset.</s>
+                <s id="git">No. The same message applies the the commit as a whole.</s>
            </compare>
         </section>
     </section>
@@ -828,6 +868,11 @@
                   documentation. Installing and getting started with the GUI is very easy
                   though. (update/commit-next-next-next-finished)
                 </s>
+            	<s id="git">
+		  There a good tutorials manual pages and a supportive community.
+		  Basic usage is simple, but advanced usage requires understanding of
+		  what makes git different.
+                </s>
             </compare>
         </section>
         <section id="ease_of_deployment">
@@ -950,6 +995,10 @@
                   LibreSource repository web page. 
                   (links: create workspace, update, commit, studio...)
                 </s>
+            	<s id="git">
+		  Very simple to deploy on Unix-like systems. Windows installs
+		  is not fully developed yet. Installing in cygwin is simple though.
+                </s>
            </compare>
         </section>
         <section id="command_set">
@@ -1048,6 +1097,13 @@
                   Basic commands available (commit/update), but it's really simple to
                   use the GUI. Ant task are also available.
                 </s>
+            	<s id="git">Basic usage could be considered similar, but trying
+			to use Git like CVS would be counterproductive since many
+			cases of CVS usage is by design not possible in Git. The
+			number of command is large. ~140 but only ~20 commands
+			are typically used and less than ten will do for casual
+			users.
+                </s>
            </compare>
         </section>
         <section id="networking">
@@ -1152,6 +1208,13 @@
                 <s id="ls-sync">
                   Good. Use of HTTP to get through firwalls. 
                 </s>
+            	<s id="git">
+		  Excellent. Normal usage is off-line, but networking is
+		  used for sharing changes Networking including ssh, 
+		  a special git protocol http and mail can be used to share
+		  changes, both incoming and outgoing. Mail can be used
+		  via IMAP and mbox files.
+                </s>
             </compare>
         </section>
         <section id="portability">
@@ -1249,6 +1312,11 @@
                   Excellent. Clients and servers work on any Java 1.5-compatible
                   platform. (Windows, Linux and Mac OS X )
                 </s>
+            	<s id="git">
+		  Very good for POSIX compatible environments. A non-cygwin
+		  port for windows is underway. There are some graphical
+		  tools available for windows in cygwin.
+                </s>
             </compare>
         </section>
     </section>
@@ -1323,6 +1391,7 @@
                   Yes, without diff features but with a better awareness support.
                   (allow to know at any time on each version each one is working on) 
                 </s>
+                <s id="git">Yes. gitweb</s>
             </compare>
         </section>
         <section id="availability_of_guis">
@@ -1421,6 +1490,10 @@
                   is automatically launched from the repository web page and 
                   another one which is an Eclipse plugin.
                 </s>
+                <s id="git">
+		  A number of good GUI's are availble for basic usage, 
+		  but typical usage is command based.
+                </s>
            </compare>
         </section>
     </section>
@@ -1501,7 +1574,8 @@
               additional licensing.
             </s>
             <s id="ls-sync">QPL - The Qt Public License (OpenSource)</s>
-        </compare>
+            <s id="git">GPL</s>
+       </compare>
     </section>
 </section>
     </contents>


-- robin
