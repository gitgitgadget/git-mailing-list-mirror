From: Marius Storm-Olsen <marius@trolltech.com>
Subject: GitWeb: Adding fork visualization based on objects/info/alternates
Date: Sat, 26 May 2007 20:31:01 +0200
Message-ID: <46587CE5.1030501@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 26 20:58:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs1TF-0008Qc-MU
	for gcvg-git@gmane.org; Sat, 26 May 2007 20:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbXEZS6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754716AbXEZS6T
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 14:58:19 -0400
Received: from esparsett.troll.no ([62.70.27.18]:58958 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbXEZS6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 14:58:17 -0400
X-Greylist: delayed 1627 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 May 2007 14:58:16 EDT
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 97ED96001D
	for <git@vger.kernel.org>; Sat, 26 May 2007 20:31:06 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP id 3DCE16002F
	for <git@vger.kernel.org>; Sat, 26 May 2007 20:31:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070326 Thunderbird/2.0.0.0 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.0
OpenPGP: id=34EB4437
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48482>

Hi,

In an effort to tidy up the project list, and given that the
current fork support in GitWeb doesn't exactly fit my
structure (where forks are in subdirs of parent repo, and has
to be first level down; alas no seek unlike when not showing
forks), I set out to add fork support based on
    objects/info/alternates
of each repo. The result can be seen here:
    http://chaos.troll.no/~marius/git/forks_collapsed.png
    http://chaos.troll.no/~marius/git/forks_expanded.png

I doubt you'd want it in the mainline, as you can't turn the
feature off; it's just like another column which you can sort
by. If you do not sort by the 'fork' column, the forks will
still be colored with the first level color, but not ordered
under it's parent repo.

Just wanted to feed back what I did so others can get
inspiration, tweak it, and add it to their own gitwebs.

It cleans up the project list real nicely though.

Later!

--
.marius

--------------------------------------------------------------

>From a3659e21447181717b8b9edec319fe78f5643bdd Mon Sep 17 00:00:00 2001
From: Marius Storm-Olsen <marius@devil.troll.no>
Date: Sat, 26 May 2007 18:25:41 +0200
Subject: [PATCH] Adding fork visualization based on objects/info/alternates.
  1) All projects which have alternates are colorized
  2) When sorting based on forks, the forks are shown in
     a tree-like structure, which is collapsed by default.
     The user can expand each node to see the fork projects.
---
 gitweb/closed.png        |  Bin 0 -> 496 bytes
 gitweb/gitweb.css        |   23 ++++++++
 gitweb/gitweb.perl       |  137 +++++++++++++++++++++++++++++++++++----------
 gitweb/gitweb_scripts.js |   55 ++++++++++++++++++
 gitweb/open.png          |  Bin 0 -> 497 bytes
 5 files changed, 184 insertions(+), 31 deletions(-)
 create mode 100644 gitweb/closed.png
 create mode 100644 gitweb/gitweb_scripts.js
 create mode 100644 gitweb/open.png

diff --git a/gitweb/closed.png b/gitweb/closed.png
new file mode 100644
index 0000000000000000000000000000000000000000..ae630014d068e541f2b4d6b24617a4d6c896bd62
GIT binary patch
literal 496
zcmV<M0T2F(P)<h;3K|Lk000e1NJLTq000gE000gM1^@s6A4o0H00006VoOIv0RI60
z0RN!9r;`8x010qNS#tmY3ljhU3ljkVnw%H_000McNliru*995~FB_u49)$n^0ewkC
zK~#9!y^_yL8(|d1&!n>$0-=kVw~$cm3%Km_NZqH<g<E|G%~;xkwuTxKIwpgOAeeL#
zu&vPPBF2yih0dREa_@IP7eb%}T1D`z?&fz6oO6MP$aO1TskFR$Z!iphn(=sScHg>p
zH?VEn>Gis1FzB0$iyvk<9GacVwzu-)`OANCmg6{2eZTeF%H;q6ni(R3LZN_8r+u`!
zwN?Jw3%mu;vMl@Lq(cBOBSMnIP^m(aBp@a@j)Q(bXt?ff`P=z-e-7sJ`DdQ@Whx>_
zRSK0VL~(>9Nf5^|q9}q=DYVuI!(V>wu=aX1x~ki=Sr!9;7=dODB7$ZOCIT~qnUQ4~
zqCXKvqf1swDFCnmKtw<@0&4~lftWyidovS)AZWCYI~$Y9v_3C2mwRH*6SamIxium}
zw|jP4t$tp+o?f>W))3JwMqtFufoAilvA_56uY?6qYheJ$vJ3|YpBnGqeRwmOOuhd;
mfMr?stMxU%SX^4gW9SCp%l`C>LXp`30000<MNUMnLSTX$t<ll|

literal 0
HcmV?d00001

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 9f0822f..ca9a77a 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -214,6 +214,29 @@ th {
 	text-align: left;
 }

+.folder {
+	background: url(closed.png) no-repeat;
+	float: left;
+	height: 14px;
+	width: 10px;
+	padding-right: 3px;
+}
+
+tr.fork, /* All forks higher than 10 will use this one */
+tr.fork1 { background-color: #ffffc0; }
+tr.fork2 { background-color: #ffffa0; }
+tr.fork3 { background-color: #ffff80; }
+tr.fork4 { background-color: #ffff60; }
+tr.fork5 { background-color: #ffff40; }
+tr.fork6 { background-color: #ffff20; }
+tr.fork7 { background-color: #ffff00; }
+tr.fork8 { background-color: #ffc000; }
+tr.fork9 { background-color: #ffa000; }
+
+tr.alternates {
+	color: #a0a0a0;
+}
+
 tr.light:hover {
 	background-color: #edece6;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3921cb..65984dc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -72,7 +72,7 @@ our $logo_label = "git homepage";
 our $projects_list = "++GITWEB_LIST++";

 # default order of projects list
-# valid values are none, project, descr, owner, and age
+# valid values are none, fork, project, descr, owner, and age
 our $default_projects_order = "project";

 # show repository only if this file exists
@@ -1282,6 +1282,16 @@ sub git_get_project_owner {
 	return $owner;
 }

+sub git_get_project_alternates_list {
+	my $path = shift;
+
+	open my $fd, "$projectroot/$path/objects/info/alternates" or return;
+	my @git_project_alternates_list = map { chomp; $_ } <$fd>;
+	close $fd;
+
+	return wantarray ? @git_project_alternates_list : \@git_project_alternates_list;
+}
+
 sub git_get_last_activity {
 	my ($path) = @_;
 	my $fd;
@@ -1909,8 +1919,9 @@ EOF
 		print qq(<link rel="shortcut icon" href="$favicon" type="image/png"/>\n);
 	}

+	print "<script src=\"gitweb_scripts.js\" type=\"text/javascript\"></script>\n";
 	print "</head>\n" .
-	      "<body>\n";
+	      "<body onload=\"collapseAllRows();\">\n";

 	if (-f $site_header) {
 		open (my $fd, $site_header);
@@ -2928,6 +2939,7 @@ sub git_project_list_body {
 	my ($check_forks) = gitweb_check_feature('forks');

 	my @projects;
+	my %forkProjects = ();
 	foreach my $pr (@$projlist) {
 		my (@aa) = git_get_last_activity($pr->{'path'});
 		unless (@aa) {
@@ -2942,6 +2954,12 @@ sub git_project_list_body {
 		if (!defined $pr->{'owner'}) {
 			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
 		}
+		my @altPaths = map { $_ =~ s=\/objects$==g; $_ }
+				   git_get_project_alternates_list($pr->{'path'});
+		if (!defined $pr->{'alternates'}) {
+			$pr->{'alternates'} = join(":",  @altPaths);
+		}
+
 		if ($check_forks) {
 			my $pname = $pr->{'path'};
 			if (($pname =~ s/\.git$//) &&
@@ -2954,6 +2972,12 @@ sub git_project_list_body {
 			}
 		}
 		push @projects, $pr;
+
+		if ($#altPaths + 1) {
+                    foreach my $altPath (@altPaths) {
+		        $forkProjects{$altPath}{"$projectroot/$pr->{'path'}"} = $pr;
+		    }
+		}
 	}

 	$order ||= $default_projects_order;
@@ -2966,6 +2990,15 @@ sub git_project_list_body {
 		if ($check_forks) {
 			print "<th></th>\n";
 		}
+		if ($order eq "fork") {
+			@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
+			print "<th>+</th>\n";
+		} else {
+			print "<th>" .
+			      $cgi->a({-href => href(project=>undef, order=>'fork'),
+			               -class => "header"}, "+") .
+			      "</th>\n";
+		}
 		if ($order eq "project") {
 			@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
 			print "<th>Project</th>\n";
@@ -3006,38 +3039,21 @@ sub git_project_list_body {
 		      "</tr>\n";
 	}
 	my $alternate = 1;
+	my $isForkOrder = ($order eq "fork");
 	for (my $i = $from; $i <= $to; $i++) {
 		my $pr = $projects[$i];
-		if ($alternate) {
-			print "<tr class=\"dark\">\n";
-		} else {
-			print "<tr class=\"light\">\n";
+		my $isFork = ($pr->{'alternates'} ne "");
+		my $rowColor = "light";
+		$rowColor = "dark" if ($alternate);
+		$rowColor = "fork" if ($isFork);
+
+		# If we're in fork ordering and this is a fork, we will not output this node
+		# since it has/will be outputted as a fork (child node) of another project.
+		if (!($isForkOrder && $isFork)) {
+			git_project_body($pr, $isForkOrder, $rowColor, "$i", $check_forks, \%forkProjects, "", 0);
 		}
+
 		$alternate ^= 1;
-		if ($check_forks) {
-			print "<td>";
-			if ($pr->{'forks'}) {
-				print "<!-- $pr->{'forks'} -->\n";
-				print $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "+");
-			}
-			print "</td>\n";
-		}
-		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
-		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list", -title => $pr->{'descr_long'}},
-		                        esc_html($pr->{'descr'})) . "</td>\n" .
-		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
-		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
-		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
-		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
-		      "</td>\n" .
-		      "</tr>\n";
 	}
 	if (defined $extra) {
 		print "<tr>\n";
@@ -3050,6 +3066,58 @@ sub git_project_list_body {
 	print "</table>\n";
 }

+sub git_project_body {
+	my ($pr, $isForkOrder, $rowColor, $parentNode, $check_forks, $forkProjectsRef, $indent, $indentLevel) = @_;
+
+	# Get the forks keys for this project
+	my $forkHash = $forkProjectsRef->{"$projectroot/$pr->{'path'}"};
+	my @forkKeys = sort keys (%$forkHash);
+	my $forkLevel = "";
+	$forkLevel = "$indentLevel" if ($indentLevel && $indentLevel < 10);
+	print "<tr class=\"$rowColor$forkLevel\" id=\"$parentNode\">\n";
+
+	if ($check_forks) {
+		print "<td>";
+		if ($pr->{'forks'}) {
+			print "<!-- $pr->{'forks'} -->\n";
+			print $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "+");
+		}
+		print "</td>\n";
+	}
+
+	# Add a folder anchor if this project has forks and we're in fork order
+	my $forkToggle = ">";
+	if ($#forkKeys + 1 && $isForkOrder) {
+	    $forkToggle = " onclick=\"toggleRows(this)\" class=\"folder\">";
+	}
+	print "<td><div class=\"tier\"><a href=\"#\"$forkToggle</a></div></td>";
+
+	print "<td>$indent" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
+	                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+	      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
+	                        -class => "list", -title => $pr->{'descr_long'}},
+	                        esc_html($pr->{'descr'})) . "</td>\n" .
+	      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
+	print "<td class=\"". age_class($pr->{'age'}) . "\">" .
+	      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
+	      "<td class=\"link\">" .
+	      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
+	      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
+	      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
+	      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
+	      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
+	      "</td>\n" .
+	      "</tr>\n";
+
+	return if (!$isForkOrder || !($#forkKeys + 1));
+	my $siblingCount = 0;
+	for my $key (@forkKeys) {
+		my $forkProject = ${$forkHash}{$key};
+		$siblingCount++;
+		git_project_body($forkProject, $isForkOrder, "fork", $parentNode."-$siblingCount", $check_forks, $forkProjectsRef, $indent."&nbsp;&nbsp;", $indentLevel+1);
+	}
+}
+
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
@@ -3315,7 +3383,7 @@ sub git_search_grep_body {

 sub git_project_list {
 	my $order = $cgi->param('o');
-	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
+	if (defined $order && $order !~ m/none|fork|project|descr|owner|age/) {
 		die_error(undef, "Unknown order parameter");
 	}

@@ -3419,6 +3487,13 @@ sub git_summary {
 		print "<tr><td>$url_tag</td><td>$git_url</td></tr>\n";
 		$url_tag = "";
 	}
+	my $alternates_tag = "ALT";
+	my @alternates_list = git_get_project_alternates_list($project);
+	foreach my $alternate (@alternates_list) {
+		next unless $alternate;
+		print "<tr class=\"alternates\"><td>$alternates_tag</td><td>$alternate</td></tr>\n";
+		$alternates_tag = "";
+	}
 	print "</table>\n";

 	if (-s "$projectroot/$project/README.html") {
diff --git a/gitweb/gitweb_scripts.js b/gitweb/gitweb_scripts.js
new file mode 100644
index 0000000..79f43dc
--- /dev/null
+++ b/gitweb/gitweb_scripts.js
@@ -0,0 +1,55 @@
+// Javascript based on the SSTree project
+// http://sstree.tigris.org/
+
+function toggleRows(elm) {
+    var rows = document.getElementsByTagName("tr");
+    elm.style.backgroundImage = "url(closed.png)";
+    var newDisplay = "none";
+    var thisID = elm.parentNode.parentNode.parentNode.id + "-";
+    // Are we expanding or contracting? If the first child is hidden, we expand
+    for (var i = 0; i < rows.length; i++) {
+        var r = rows[i];
+        if (matchStart(r.id, thisID, true)) {
+            if (r.style.display == "none") {
+                if (document.all) newDisplay = "block";     // IE4+ specific code
+                else newDisplay = "table-row";              // Netscape and Mozilla
+                elm.style.backgroundImage = "url(open.png)";
+            }
+            break;
+        }
+    }
+
+    // When expanding, only expand one level.  Collapse all desendants.
+    var matchDirectChildrenOnly = (newDisplay != "none");
+
+    for (var j = 0; j < rows.length; j++) {
+        var s = rows[j];
+        if (matchStart(s.id, thisID, matchDirectChildrenOnly)) {
+            s.style.display = newDisplay;
+            var cell = s.getElementsByTagName("td")[0];
+            var tier = cell.getElementsByTagName("div")[0];
+            var folder = tier.getElementsByTagName("a")[0];
+            if (folder.getAttribute("onclick") != null) {
+                folder.style.backgroundImage = "url(closed.png)";
+            }
+        }
+    }
+}
+
+function matchStart(target, pattern, matchDirectChildrenOnly) {
+    var pos = target.indexOf(pattern);
+    if (pos != 0) return false;
+    if (!matchDirectChildrenOnly) return true;
+    if (target.slice(pos + pattern.length, target.length).indexOf("-") >= 0) return false;
+    return true;
+}
+
+function collapseAllRows() {
+    var rows = document.getElementsByTagName("tr");
+    for (var j = 0; j < rows.length; j++) {
+        var r = rows[j];
+        if (r.id.indexOf("-") >= 0) {
+            r.style.display = "none";
+        }
+    }
+}
diff --git a/gitweb/open.png b/gitweb/open.png
new file mode 100644
index 0000000000000000000000000000000000000000..ea1f3a0d4affc87d570d36a960479efd07105c9c
GIT binary patch
literal 497
zcmV<N0S^9&P)<h;3K|Lk000e1NJLTq000gE000gM1^@s6A4o0H0005FNkl<Zc-pOx
zziU%b7>1v7?hmhtH#axwVB=!*Z)l)Y7mHI}>ehm!d(q7yItA=v(a_>Q(CVZ@aj-%_
z+HC3^2uX49c8vF)4n60@!A8>9Mev1h_+Flm_x&6IA%rW0kgn_auImLtAf=RU5L}M5
z)~7)bgn+QtYR)789zI(CytH)h27nY204e2|K}w0|c|=h}r_*UKFW;Yc0J`07Z}HCJ
z3M0@)V~s^f!C4!m<KX)~QB<T}f3TV)$9)GtDb)`P`P%ilxvJJ0V+}?dj5UD3^E~qT
zJcpfw_RANo27oiJGZ+kx7H%!9SZmRz8fz^hJHi;vCEur1Dzmm$UrmzZ{<%Y?RKFNU
zwMyk$bzD~)4I{|qa(w;vrQK?6HU9j~gx<Y<-y9ByWLZX*r6{FPN)d)38ynA>ldLnj
zD5ZKcGo`!ba=Bux#TbL@xeNyV_V(7R$CK>2M1Z}$59?W$lBT~W2m+pOZZ@VlXWBSX
zCr4r7N-d7#DvU^yAN#L&-#ne>{z?QmJm@sjpDD%|c6N3f7ctI7rc$aG6$|sm*zfxv
nKRw}J6vxGzv$I!k^S|{A;Yhe4$I~??00000NkvXXu0mjf*^uU~

literal 0
HcmV?d00001

--
1.5.2.58.g98ee
