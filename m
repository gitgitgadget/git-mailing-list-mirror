From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Few doublequoted strings cleanups
Date: Sun, 1 Apr 2007 22:22:59 +0200
Message-ID: <200704012223.00087.jnareb@gmail.com>
References: <200704012221.01676.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 00:56:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HY8xr-0004B4-AA
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 00:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbXDAWzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 18:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbXDAWzj
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 18:55:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:42353 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbXDAWzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 18:55:25 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1386144uga
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 15:55:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=p+5M3TD3pUpKBBXklRv7ZrNwUkZjW8PP/WPsJTZi7OVwKkZ53WqUu3AFzPWFIjqmaAW7Rzb+EjDM0Eze43t9tJvVP7rKjZo74ZmyFLxYSmoU4KTOZ9oRqOgkhpU40cI6frhm/W7fykrD43JVHSL2kDUbo1VsoZIBVMnud57TDCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Dd5MtrOr6OrmFL2NnP84veRA10B7p2WHVkyUltMBds/viY13owu6o5txh3hXKWPVfGi8zYGe6apKEEB92gP4GLR8L45kg5XcDgn6yjPdo51mVl/WOB9b3ZKGqIe0B8YZbjgyHOoDT5JBxtWEsiOZYkFXKJhRqZQbP3UR82amTks=
Received: by 10.67.24.18 with SMTP id b18mr3809606ugj.1175468124141;
        Sun, 01 Apr 2007 15:55:24 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm17434124mue.2007.04.01.15.55.21;
        Sun, 01 Apr 2007 15:55:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200704012221.01676.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43593>

Replace a few doublequoted strings by theirs singlequoted equivalent,
lose doublequotes around variable in string containing only
of a variable name, use '' consistently as an empty string (and not
sometimes as "").

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   86 ++++++++++++++++++++++++++--------------------------
 1 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index eab8f3f..9f116a2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -36,7 +36,7 @@ our $GIT = "++GIT_BINDIR++/git";
 our $projectroot = "++GITWEB_PROJECTROOT++";
 
 # target of the home link on top of all pages
-our $home_link = $my_uri || "/";
+our $home_link = $my_uri || '/';
 
 # string of the home link on top of all pages
 our $home_link_str = "++GITWEB_HOME_LINK_STR++";
@@ -377,7 +377,7 @@ if (defined $searchtype) {
 # now read PATH_INFO and use it as alternative to parameters
 sub evaluate_path_info {
 	return if defined $project;
-	my $path_info = $ENV{"PATH_INFO"};
+	my $path_info = $ENV{'PATH_INFO'};
 	return if !$path_info;
 	$path_info =~ s,^/+,,;
 	return if !$path_info;
@@ -403,7 +403,7 @@ sub evaluate_path_info {
 		# we got "project.git/branch:filename" or "project.git/branch:dir/"
 		# we could use git_get_type(branch:pathname), but it needs $git_dir
 		$pathname =~ s,^/+,,;
-		if (!$pathname || substr($pathname, -1) eq "/") {
+		if (!$pathname || substr($pathname, -1) eq '/') {
 			$action  ||= "tree";
 			$pathname =~ s,/$,,;
 		} else {
@@ -515,10 +515,10 @@ sub href(%) {
 	for (my $i = 0; $i < @mapping; $i += 2) {
 		my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
 		if (defined $params{$name}) {
-			push @result, $symbol . "=" . esc_param($params{$name});
+			push @result, $symbol . '=' . esc_param($params{$name});
 		}
 	}
-	$href .= "?" . join(';', @result) if scalar @result;
+	$href .= '?' . join(';', @result) if scalar @result;
 
 	return $href;
 }
@@ -876,7 +876,7 @@ sub format_ref_marker {
 	if ($markers) {
 		return ' <span class="refs">'. $markers . '</span>';
 	} else {
-		return "";
+		return '';
 	}
 }
 
@@ -900,17 +900,17 @@ sub format_diff_line {
 	my $line = shift;
 	my ($from, $to) = @_;
 	my $char = substr($line, 0, 1);
-	my $diff_class = "";
+	my $diff_class = '';
 
 	chomp $line;
 
 	if ($char eq '+') {
 		$diff_class = " add";
-	} elsif ($char eq "-") {
+	} elsif ($char eq '-') {
 		$diff_class = " rem";
-	} elsif ($char eq "@") {
+	} elsif ($char eq '@') {
 		$diff_class = " chunk_header";
-	} elsif ($char eq "\\") {
+	} elsif ($char eq '\\') {
 		$diff_class = " incomplete";
 	}
 	$line = untabify($line);
@@ -1052,7 +1052,7 @@ sub git_get_projects_list {
 		my $dir = $projects_list . ($filter ? "/$filter" : '');
 		# remove the trailing "/"
 		$dir =~ s!/+$!!;
-		my $pfxlen = length("$dir");
+		my $pfxlen = length($dir);
 
 		my ($check_forks) = gitweb_check_feature('forks');
 
@@ -1074,7 +1074,7 @@ sub git_get_projects_list {
 					$File::Find::prune = 1;
 				}
 			},
-		}, "$dir");
+		}, $dir);
 
 	} elsif (-f $projects_list) {
 		# read from file(url-encoded):
@@ -1166,7 +1166,7 @@ sub git_get_last_activity {
 }
 
 sub git_get_references {
-	my $type = shift || "";
+	my $type = shift || '';
 	my %refs;
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
@@ -1261,7 +1261,7 @@ sub parse_tag {
 		} elsif ($line =~ m/--BEGIN/) {
 			push @comment, $line;
 			last;
-		} elsif ($line eq "") {
+		} elsif ($line eq '') {
 			last;
 		}
 	}
@@ -1323,7 +1323,7 @@ sub parse_commit_text {
 
 	foreach my $title (@commit_lines) {
 		$title =~ s/^    //;
-		if ($title ne "") {
+		if ($title ne '') {
 			$co{'title'} = chop_str($title, 80, 5);
 			# remove leading stuff of merges to make the interesting part visible
 			if (length($title) > 50) {
@@ -1346,7 +1346,7 @@ sub parse_commit_text {
 			last;
 		}
 	}
-	if ($co{'title'} eq "") {
+	if ($co{'title'} eq '') {
 		$co{'title'} = $co{'title_short'} = '(no commit message)';
 	}
 	# remove added spaces
@@ -1781,7 +1781,7 @@ EOF
 	my ($have_search) = gitweb_check_feature('search');
 	if ((defined $project) && ($have_search)) {
 		if (!defined $searchtext) {
-			$searchtext = "";
+			$searchtext = '';
 		}
 		my $search_hash;
 		if (defined $hash_base) {
@@ -1803,7 +1803,7 @@ EOF
 		                       -values => ['commit', 'author', 'committer', 'pickaxe']) .
 		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
 		      " search:\n",
-		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
+		      $cgi->textfield(-name => 's', -value => $searchtext) . "\n" .
 		      "</div>" .
 		      $cgi->end_form() . "\n";
 	}
@@ -2003,7 +2003,7 @@ sub git_print_log ($;%) {
 		shift @$log;
 	}
 	# remove leading empty lines
-	while (defined $log->[0] && $log->[0] eq "") {
+	while (defined $log->[0] && $log->[0] eq '') {
 		shift @$log;
 	}
 
@@ -2027,7 +2027,7 @@ sub git_print_log ($;%) {
 
 		# print only one empty line
 		# do not print empty line after signoff
-		if ($line eq "") {
+		if ($line eq '') {
 			next if ($empty || $signoff);
 			$empty = 1;
 		} else {
@@ -2220,7 +2220,7 @@ sub git_difftree_body {
 			$from_file_type = file_type($diff{'from_mode'});
 		}
 
-		if ($diff{'status'} eq "A") { # created
+		if ($diff{'status'} eq 'A') { # created
 			my $mode_chng = "<span class=\"file_status new\">[new $to_file_type";
 			$mode_chng   .= " with mode: $to_mode_str" if $to_mode_str;
 			$mode_chng   .= "]</span>";
@@ -2242,7 +2242,7 @@ sub git_difftree_body {
 			              "blob");
 			print "</td>\n";
 
-		} elsif ($diff{'status'} eq "D") { # deleted
+		} elsif ($diff{'status'} eq 'D') { # deleted
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
@@ -2270,8 +2270,8 @@ sub git_difftree_body {
 			              "history");
 			print "</td>\n";
 
-		} elsif ($diff{'status'} eq "M" || $diff{'status'} eq "T") { # modified, or type changed
-			my $mode_chnge = "";
+		} elsif ($diff{'status'} eq 'M' || $diff{'status'} eq 'T') { # modified, or type changed
+			my $mode_chnge = '';
 			if ($diff{'from_mode'} != $diff{'to_mode'}) {
 				$mode_chnge = "<span class=\"file_status mode_chnge\">[changed";
 				if ($from_file_type ne $to_file_type) {
@@ -2320,10 +2320,10 @@ sub git_difftree_body {
 			              "history");
 			print "</td>\n";
 
-		} elsif ($diff{'status'} eq "R" || $diff{'status'} eq "C") { # renamed or copied
+		} elsif ($diff{'status'} eq 'R' || $diff{'status'} eq 'C') { # renamed or copied
 			my %status_name = ('R' => 'moved', 'C' => 'copied');
 			my $nstatus = $status_name{$diff{'status'}};
-			my $mode_chng = "";
+			my $mode_chng = '';
 			if ($diff{'from_mode'} != $diff{'to_mode'}) {
 				# mode also for directories, so we cannot use $to_mode_str
 				$mode_chng = sprintf(", mode: %04o", $to_mode_oct & 0777);
@@ -2434,14 +2434,14 @@ sub git_patchset_body {
 			}
 			$from{'file'} = $diffinfo->{'from_file'} || $diffinfo->{'file'};
 			$to{'file'}   = $diffinfo->{'to_file'}   || $diffinfo->{'file'};
-			if ($diffinfo->{'status'} ne "A") { # not new (added) file
+			if ($diffinfo->{'status'} ne 'A') { # not new (added) file
 				$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 				                     hash=>$diffinfo->{'from_id'},
 				                     file_name=>$from{'file'});
 			} else {
 				delete $from{'href'};
 			}
-			if ($diffinfo->{'status'} ne "D") { # not deleted file
+			if ($diffinfo->{'status'} ne 'D') { # not deleted file
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
 				                   file_name=>$to{'file'});
@@ -2577,12 +2577,12 @@ sub git_project_list_body {
 		}
 		($pr->{'age'}, $pr->{'age_string'}) = @aa;
 		if (!defined $pr->{'descr'}) {
-			my $descr = git_get_project_description($pr->{'path'}) || "";
+			my $descr = git_get_project_description($pr->{'path'}) || '';
 			$pr->{'descr_long'} = to_utf8($descr);
 			$pr->{'descr'} = chop_str($descr, 25, 5);
 		}
 		if (!defined $pr->{'owner'}) {
-			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
+			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || '';
 		}
 		if ($check_forks) {
 			my $pname = $pr->{'path'};
@@ -2926,10 +2926,10 @@ sub git_search_grep_body {
 		my $comment = $co{'comment'};
 		foreach my $line (@$comment) {
 			if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
-				my $lead = esc_html($1) || "";
+				my $lead = esc_html($1) || '';
 				$lead = chop_str($lead, 30, 10);
-				my $match = esc_html($2) || "";
-				my $trail = esc_html($3) || "";
+				my $match = esc_html($2) || '';
+				my $trail = esc_html($3) || '';
 				$trail = chop_str($trail, 30, 10);
 				my $text = "$lead<span class=\"match\">$match</span>$trail";
 				print chop_str($text, 80, 5) . "<br/>\n";
@@ -3056,7 +3056,7 @@ sub git_summary {
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
 		print "<tr><td>$url_tag</td><td>$git_url</td></tr>\n";
-		$url_tag = "";
+		$url_tag = '';
 	}
 	print "</table>\n";
 
@@ -3381,7 +3381,7 @@ sub git_blob_plain {
 		}
 	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		# blobs defined by non-textual hash id's can be cached
-		$expires = "+1d";
+		$expires = '+1d';
 	}
 
 	my $type = shift;
@@ -3391,7 +3391,7 @@ sub git_blob_plain {
 	$type ||= blob_mimetype($fd, $file_name);
 
 	# save as filename, even when no $file_name is given
-	my $save_as = "$hash";
+	my $save_as = $hash;
 	if (defined $file_name) {
 		$save_as = $file_name;
 	} elsif ($type =~ m/^text\//) {
@@ -3399,8 +3399,8 @@ sub git_blob_plain {
 	}
 
 	print $cgi->header(
-		-type => "$type",
-		-expires=>$expires,
+		-type => $type,
+		-expires => $expires,
 		-content_disposition => 'inline; filename="' . "$save_as" . '"');
 	undef $/;
 	binmode STDOUT, ':raw';
@@ -3423,7 +3423,7 @@ sub git_blob {
 		}
 	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		# blobs defined by non-textual hash id's can be cached
-		$expires = "+1d";
+		$expires = '+1d';
 	}
 
 	my ($have_blame) = gitweb_check_feature('blame');
@@ -3616,7 +3616,7 @@ sub git_snapshot {
 
 	print $cgi->header(
 		-type => "application/$ctype",
-		-content_disposition => 'inline; filename="' . "$filename" . '"',
+		-content_disposition => 'inline; filename="' . $filename . '"',
 		-status => '200 OK');
 
 	my $git = git_cmd_str();
@@ -3744,7 +3744,7 @@ sub git_commit {
 	# non-textual hash id's can be cached
 	my $expires;
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		$expires = "+1d";
+		$expires = '+1d';
 	}
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
@@ -4129,7 +4129,7 @@ sub git_commitdiff {
 	# non-textual hash id's can be cached
 	my $expires;
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		$expires = "+1d";
+		$expires = '+1d';
 	}
 
 	# write commit message
@@ -4157,7 +4157,7 @@ sub git_commitdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => 'inline; filename="' . "$filename" . '"');
+			-content_disposition => 'inline; filename="' . $filename . '"');
 		my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 		print <<TEXT;
 From: $co{'author'}
-- 
1.5.0.5
