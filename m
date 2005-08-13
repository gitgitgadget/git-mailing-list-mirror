From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add SubmittingPatches
Date: Sat, 13 Aug 2005 02:08:57 -0700
Message-ID: <7vslxep5jq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 13 11:10:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3s0o-0004wt-Qd
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 11:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVHMJI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 05:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVHMJI7
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 05:08:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20440 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932138AbVHMJI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 05:08:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813090859.DKAP17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 05:08:59 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Not that I have stricter patch submission standards than ordinary
projects, I wanted to have it to make sure people understand
what they are doing when they add their own Signed-off-by line.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/SubmittingPatches |  130 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/SubmittingPatches

3de1a21da62e2ad89bfb25f742384b9af496e4e0
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
new file mode 100644
--- /dev/null
+++ b/Documentation/SubmittingPatches
@@ -0,0 +1,130 @@
+I started reading over the SubmittingPatches document for Linux
+kernel, primarily because I wanted to have a document similar to
+it for the core GIT to make sure people understand what they are
+doing when they write "Signed-off-by" line.
+
+But the patch submission requirements are a lot more relaxed
+here, because the core GIT is thousand times smaller ;-).  So
+here is only the relevant bits.
+
+
+(1) Make separate commits for logically separate changes.
+
+Unless your patch is really trivial, you should not be sending
+out a patch that was generated between your working tree and
+your commit head.  Instead, always make a commit with complete
+commit message and generate a series of patches from your
+repository.  It is a good discipline.
+
+Describe the technical detail of the change(s).
+
+If your description starts to get long, that's a sign that you
+probably need to split up your commit to finer grained pieces.
+
+
+(2) Generate your patch using git/cogito out of your commits.
+
+git diff tools generate unidiff which is the preferred format.
+You do not have to be afraid to use -M option to "git diff" or
+"git format-patch", if your patch involves file renames.  The
+receiving end can handle them just fine.
+
+Please make sure your patch does not include any extra files
+which do not belong in a patch submission.  Make sure to review
+your patch after generating it, to ensure accuracy.  Before
+sending out, please make sure it cleanly applies to the "master"
+branch head.
+
+
+(3) Sending your patches.
+
+People on the git mailing list needs to be able to read and
+comment on the changes you are submitting.  It is important for
+a developer to be able to "quote" your changes, using standard
+e-mail tools, so that they may comment on specific portions of
+your code.  For this reason, all patches should be submitting
+e-mail "inline".  WARNING: Be wary of your MUAs word-wrap
+corrupting your patch.  Do not cut-n-paste your patch.
+
+It is common convention to prefix your subject line with
+[PATCH].  This lets people easily distinguish patches from other
+e-mail discussions.
+
+"git format-patch" command follows the best current practice to
+format the body of an e-mail message.  At the beginning of the
+patch should come your commit message, ending with the
+Signed-off-by: lines, and a line that consists of three dashes,
+followed by the diffstat information and the patch itself.  If
+you are forwarding a patch from somebody else, optionally, at
+the beginning of the e-mail message just before the commit
+message starts, you can put a "From: " line to name that person.
+
+You often want to add additional explanation about the patch,
+other than the commit message itself.  Place such "cover letter"
+material between the three dash lines and the diffstat.
+
+Do not attach the patch as a MIME attachment, compressed or not.
+Do not let your e-mail client send quoted-printable.  Many
+popular e-mail applications will not always transmit a MIME
+attachment as plain text, making it impossible to comment on
+your code.  A MIME attachment also takes a bit more time to
+process.  This does not decrease the likelihood of your
+MIME-attached change being accepted, but it makes it more likely
+that it will be postponed.
+
+Exception:  If your mailer is mangling patches then someone may ask
+you to re-send them using MIME.
+
+Note that your maintainer does not subscribe to the git mailing
+list (he reads it via mail-to-news gateway).  If your patch is
+for discussion first, send it "To:" the mailing list, and
+optoinally "cc:" him.  If it is trivially correct or after list
+discussion reached consensus, send it "To:" the maintainer and
+optionally "cc:" the list.
+
+
+(6) Sign your work
+
+To improve tracking of who did what, we've borrowed the
+"sign-off" procedure from the Linux kernel project on patches
+that are being emailed around.  Although core GIT is a lot
+smaller project it is a good discipline to follow it.
+
+The sign-off is a simple line at the end of the explanation for
+the patch, which certifies that you wrote it or otherwise have
+the right to pass it on as a open-source patch.  The rules are
+pretty simple: if you can certify the below:
+
+        Developer's Certificate of Origin 1.1
+
+        By making a contribution to this project, I certify that:
+
+        (a) The contribution was created in whole or in part by me and I
+            have the right to submit it under the open source license
+            indicated in the file; or
+
+        (b) The contribution is based upon previous work that, to the best
+            of my knowledge, is covered under an appropriate open source
+            license and I have the right under that license to submit that
+            work with modifications, whether created in whole or in part
+            by me, under the same open source license (unless I am
+            permitted to submit under a different license), as indicated
+            in the file; or
+
+        (c) The contribution was provided directly to me by some other
+            person who certified (a), (b) or (c) and I have not modified
+            it.
+
+	(d) I understand and agree that this project and the contribution
+	    are public and that a record of the contribution (including all
+	    personal information I submit with it, including my sign-off) is
+	    maintained indefinitely and may be redistributed consistent with
+	    this project or the open source license(s) involved.
+
+then you just add a line saying
+
+	Signed-off-by: Random J Developer <random@developer.example.org>
+
+Some people also put extra tags at the end.  They'll just be ignored for
+now, but you can do this to mark internal company procedures or just
+point out some special detail about the sign-off.
