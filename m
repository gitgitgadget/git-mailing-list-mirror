From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 02 Oct 2006 00:34:15 -0700
Message-ID: <7vhcynxjbc.fsf@assigned-by-dhcp.cox.net>
References: <efc2no$eti$2@sea.gmane.org>
	<20060926213236.79160.qmail@web31815.mail.mud.yahoo.com>
	<7v64f9hku2.fsf@assigned-by-dhcp.cox.net>
	<200610012041.15296.jnareb@gmail.com>
	<7vd59b27c4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 09:34:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUIJu-0005sl-Vi
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 09:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWJBHeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 03:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWJBHeS
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 03:34:18 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25006 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751333AbWJBHeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 03:34:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061002073416.IMOO12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Oct 2006 03:34:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VKaA1V00P1kojtg0000000
	Mon, 02 Oct 2006 03:34:11 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vd59b27c4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 01 Oct 2006 11:56:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28219>

Junio C Hamano <junkio@cox.net> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> ... That means that we cannot distinguish really well (at 
>> least color) between tree and blob entries.
>
> Do we even say links are blue and underlined by forcing that in
> our css?
>
> Doesn't leading drwxr-xr-x mean anything?
>
> Why is making the distinction important in the first place?

Anyhow, I was too tired to sleep after an unscheduled day-job on
Sunday X-<, and whipped this up for fun.

-- >8 --
[PATCH] gitweb: remove UNIXy mode bits from tree display

and replace it with an image icon for cuteness ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 gitweb/gitweb.css  |   20 ++++++++++++++++++++
 gitweb/gitweb.perl |   21 ++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index eb9fc38..c4aaf7c 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -211,6 +211,26 @@ td.selflink {
 	padding-right: 0px;
 }
 
+td.executable {
+  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANAQMAAABIJXY/AAAABlBMVEX///+UAN7OszyBAAAAAXRSTlMAQObYZgAAACVJREFUCNdjYGBgYGdgMEhgUFBgYGJgcBKAIiAbKAIUB8oyMAAANBcCqbivEbgAAAAASUVORK5CYII=);
+  background-repeat: no-repeat;
+}
+
+td.folder {
+  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANAQMAAABIJXY/AAAABlBMVEX///+UAN7OszyBAAAAAXRSTlMAQObYZgAAAB1JREFUCNdjYGBgkGFgUGJgcPzA4CCABdV/ACoBAFTTBQ822ZerAAAAAElFTkSuQmCC);
+  background-repeat: no-repeat;
+}
+
+td.regular {
+  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANAQMAAABIJXY/AAAABlBMVEX///+UAN7OszyBAAAAAXRSTlMAQObYZgAAABtJREFUCNdjqD/A4JDA4BDA4FDB4MCBHdX/AACO5wbfUNnbqwAAAABJRU5ErkJggg==);
+  background-repeat: no-repeat;
+}
+
+td.symlink {
+  background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANAQMAAABIJXY/AAAABlBMVEX///+UAN7OszyBAAAAAXRSTlMAQObYZgAAACVJREFUCNdjYGBg4G9gMEhgUFBgcBAAIQYYYlFg4ElgkG8AKgEARSsDX750+Y0AAAAASUVORK5CYII=);
+  background-repeat: no-repeat;
+}
+
 td.sha1 {
 	font-family: monospace;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7e4ec8d..8c54a5d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -567,6 +567,23 @@ sub age_string {
 }
 
 # convert file mode in octal to symbolic file mode string
+sub kind_class {
+	my ($type, $mode) = @_;
+	$mode = oct $mode;
+	if (S_ISDIR($mode & S_IFMT)) {
+		return 'folder';
+	} elsif (S_ISLNK($mode)) {
+		return 'symlink';
+	} elsif (S_ISREG($mode)) {
+		# git cares only about the executable bit
+		if ($mode & S_IXUSR) {
+			return 'executable';
+		} else {
+			return 'regular';
+		};
+	}
+}
+
 sub mode_str {
 	my $mode = oct shift;
 
@@ -1651,7 +1668,9 @@ sub git_print_tree_entry {
 	# the mode of the entry, list is the name of the entry, an href,
 	# and link is the action links of the entry.
 
-	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
+	my $kind = kind_class($t->{'type'}, $t->{'mode'});
+	print "<td class=\"$kind\">&nbsp;</td>\n";
+
 	if ($t->{'type'} eq "blob") {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
-- 
1.4.2.2.g91c5
