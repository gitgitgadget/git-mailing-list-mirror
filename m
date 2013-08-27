From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] Add gui.displayuntracked option
Date: Tue, 27 Aug 2013 10:31:57 +0100
Message-ID: <87d2ozqy2a.fsf@fox.patthoyts.tk>
References: <20130821032913.GA6092@wheezy.local>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 11:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEFie-0006aP-Qs
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 11:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab3H0Jho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 05:37:44 -0400
Received: from know-smtprelay-omc-3.server.virginmedia.net ([80.0.253.67]:35104
	"EHLO know-smtprelay-omc-3.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133Ab3H0Jhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 05:37:43 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2013 05:37:42 EDT
Received: from fox.patthoyts.tk ([94.171.229.22])
	by know-smtprelay-3-imp with bizsmtp
	id HlXy1m00A0VeUS601lXyyq; Tue, 27 Aug 2013 10:31:58 +0100
X-Originating-IP: [94.171.229.22]
X-Spam: 0
X-Authority: v=2.0 cv=LIo+2+q9 c=1 sm=1 a=qXJDgLqI18Q8M6O+O33hhA==:17
 a=F0HhOJWMmYsA:10 a=pC8yDgTbiwYA:10 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10
 a=FP58Ms26AAAA:8 a=7B4l3Zdro00A:10 a=xwstyAmMAAAA:8 a=Rf460ibiAAAA:8
 a=ediF8IzPCTW2nER-oMEA:9 a=CjuIK1q_8ugA:10 a=VtOIwHTqQ30A:10
 a=bS_fLWxKKjy1KCcf:21 a=7s7msmrSfe939qm7:21 a=qXJDgLqI18Q8M6O+O33hhA==:117
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 1FA1D20070; Tue, 27 Aug 2013 10:31:57 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <20130821032913.GA6092@wheezy.local> (Max Kirillov's message of
	"Wed, 21 Aug 2013 06:29:13 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233080>

Max Kirillov <max@max630.net> writes:

>When git is used to track only a subset of a directory, or
>there is no sure way to divide files to ignore from files to track,
>git user have to live with large number of untracked files. These files
>present in file list, and should always be scrolled through
>to handle real changes. Situation can become even worse, then number
>of the untracked files grows above the maxfilesdisplayed limit. In the
>case, even staged can be hidden by git-gui.
>
>This change introduces new configuration variable gui.displayuntracked,
>which, when set to false, instructs git-gui not to show untracked files
>in files list. They can be staged from commandline or other tools (like
>IDE of file manager), then they become visible. Default value of the
>option is true, which is compatible with current behavior.
>
>Signed-off-by: Max Kirillov <max@max630.net>
>---
>Hi. I've been using git for some time and have collected a
>number of changes which might worth sharing.
>Please consider adding them to the upstream.
>
>Thanks,
>Max
>
> Documentation/config.txt |  4 ++++
> git-gui/git-gui.sh       | 14 ++++++++++----
> git-gui/lib/option.tcl   |  1 +
> 3 files changed, 15 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/config.txt b/Documentation/config.txt
>index bbba728..7a786b2 100644
>--- a/Documentation/config.txt
>+++ b/Documentation/config.txt
>@@ -1277,6 +1277,10 @@ gui.diffcontext::
> 	Specifies how many context lines should be used in calls to diff
> 	made by the linkgit:git-gui[1]. The default is "5".
> 
>+gui.displayuntracked::
>+	Determines if linkgit::git-gui[1] shows untracked files
>+	in the file list. The defaulit is "true".
>+
> gui.encoding::
> 	Specifies the default encoding to use for displaying of
> 	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
>diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>index 89f636f..42c35ad 100755
>--- a/git-gui/git-gui.sh
>+++ b/git-gui/git-gui.sh
>@@ -898,6 +898,7 @@ set font_descs {
> 	{fontdiff font_diff {mc "Diff/Console Font"}}
> }
> set default_config(gui.stageuntracked) ask
>+set default_config(gui.displayuntracked) true
> 
> ######################################################################
> ##
>@@ -1536,18 +1537,23 @@ proc rescan_stage2 {fd after} {
> 	set buf_rdf {}
> 	set buf_rlo {}
> 
>-	set rescan_active 3
>+	set rescan_active 2
> 	ui_status [mc "Scanning for modified files ..."]
> 	set fd_di [git_read diff-index --cached -z [PARENT]]
> 	set fd_df [git_read diff-files -z]
>-	set fd_lo [eval git_read ls-files --others -z $ls_others]
> 
> 	fconfigure $fd_di -blocking 0 -translation binary -encoding binary
> 	fconfigure $fd_df -blocking 0 -translation binary -encoding binary
>-	fconfigure $fd_lo -blocking 0 -translation binary -encoding binary
>+
> 	fileevent $fd_di readable [list read_diff_index $fd_di $after]
> 	fileevent $fd_df readable [list read_diff_files $fd_df $after]
>-	fileevent $fd_lo readable [list read_ls_others $fd_lo $after]
>+
>+	if {[is_config_true gui.displayuntracked]} {
>+		set fd_lo [eval git_read ls-files --others -z $ls_others]
>+		fconfigure $fd_lo -blocking 0 -translation binary -encoding binary
>+		fileevent $fd_lo readable [list read_ls_others $fd_lo $after]
>+		incr rescan_active
>+	}
> }
> 
> proc load_message {file {encoding {}}} {
>diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
>index 0cf1da1..2177db6 100644
>--- a/git-gui/lib/option.tcl
>+++ b/git-gui/lib/option.tcl
>@@ -159,6 +159,7 @@ proc do_options {} {
> 		{c gui.encoding {mc "Default File Contents Encoding"}}
> 		{b gui.warndetachedcommit {mc "Warn before committing to a detached head"}}
> 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
>+		{b gui.displayuntracked {mc "Show untracked files"}}
> 		} {
> 		set type [lindex $option 0]
> 		set name [lindex $option 1]

Looks fine to me. The Documentation part of the patch will need to be
sent separately to the git project later when this is merged in as
git-gui is managed in a separate repository. It also has a typo in
'default'. I'll make a note to forward this part of the patch at
request-pull time.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
