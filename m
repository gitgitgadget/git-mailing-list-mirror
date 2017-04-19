Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36581FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 06:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933240AbdDSGtw (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 02:49:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33535 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933227AbdDSGtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 02:49:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so3156383wmb.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kR+FStRahrS6B+PHKj2QGX/1VW8JGO8ULEZ10LQSInA=;
        b=btWVb9JM2z08oGZWlgmq4fyK1ks568AStIbBxEypRRiSlbgSaPI0yy63jIx7wn1+1L
         k8yBbrvMHQbtaFEaW1mfwCtNpmm3lX2ADYYvtw0k5N5BbAM+ZgtK7oz8ngOf3/LMHC43
         RPaFQ2pS9Ak0Qrk4cWjI/SYwPQIi8EiI+czSm12Gjcaz3SajNSppPCLVur0vNGOyPtPK
         MeY6qJk/JPtlpP71UUFYU1IncQ1Fee3rDEV34EpHx5AYg5QVFJh+FVy8ZdLAO9MyUgoG
         WvHOSyIVUfS7Sggroyeu7gKk87Io78J9G3Z8lyTzmzK8Fqz29NFoLU5K2jJiPi7ZQ6ud
         CueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kR+FStRahrS6B+PHKj2QGX/1VW8JGO8ULEZ10LQSInA=;
        b=KBj4rmYVw7KgRbTJ3H5mE5y5KLKv15fiQI2JcpA37euIvHtglvU2nr3eL2fmsMIGZ3
         2EFIAdl7brskSgMfbKm4oGnkfNcMSN0UR7GhU0OL0sDQPG8W5IjtLeNa2khdx+gsuxED
         xT9ghu2xKkCYL2h8QNdPivex+Yc0qJEdOmkFsC1s1llCL1z4sdseNRCpKAA7wBUkFY02
         M799SndVUxt3XTlnmKmX0rotAgi3JhUqbD/vZWXtqMXwNf3tAhhhpB3xLnsSxoMAd+rd
         HXf/MftFNItJEoD3PBYZbdVruGABMeFtFqgYhNwnFBqak+QF5JdLS8rJAkfSaTDESnMS
         XNCw==
X-Gm-Message-State: AN3rC/49V1dJcpyW/MV55rWwNzC08JjZPY3nWy+YXRDgkI88dXDfkfXS
        rlsJLv+WN819EA==
X-Received: by 10.28.11.208 with SMTP id 199mr1389603wml.24.1492584588956;
        Tue, 18 Apr 2017 23:49:48 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id o1sm851030wmd.16.2017.04.18.23.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Apr 2017 23:49:47 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] gitweb: expose tags feed in appropriate places
Date:   Wed, 19 Apr 2017 08:49:16 +0200
Message-Id: <20170419064916.18663-3-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.822.g5451c77231
In-Reply-To: <20170419064916.18663-1-giuseppe.bilotta@gmail.com>
References: <20170419064916.18663-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4adea84006..8be7444988 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -851,6 +851,8 @@ our %actions = (
 	"summary" => \&git_summary,
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
+	"tags_rss" => \&git_tags_rss,
+	"tags_atom" => \&git_tags_atom,
 	"tree" => \&git_tree,
 	"snapshot" => \&git_snapshot,
 	"object" => \&git_object,
@@ -2599,7 +2601,7 @@ sub get_feed_info {
 	return unless (defined $project);
 	# some views should link to OPML, or to generic project feed,
 	# or don't have specific feed yet (so they should use generic)
-	return if (!$action || $action =~ /^(?:tags|heads|forks|tag|search)$/x);
+	return if (!$action || $action =~ /^(?:heads|forks|search)$/x);
 
 	my $branch = undef;
 	# branches refs uses 'refs/' + $get_branch_refs()[x] + '/' prefix
@@ -2614,8 +2616,10 @@ sub get_feed_info {
 		}
 	}
 	# find log type for feed description (title)
-	my $type = 'log';
-	if (defined $file_name) {
+	my $type = "log";
+	if ($action eq 'tag' || $action eq 'tags') {
+		$type = "tags";
+	} elsif (defined $file_name) {
 		$type  = "history of $file_name";
 		$type .= "/" if ($action eq 'tree');
 		$type .= " on '$branch'" if (defined $branch);
@@ -4007,6 +4011,7 @@ sub print_feed_meta {
 			$href_params{'-title'} = 'log';
 		}
 
+		my $tag_view = $href_params{-title} eq 'tags';
 		foreach my $format (qw(RSS Atom)) {
 			my $type = lc($format);
 			my %link_attr = (
@@ -4016,7 +4021,7 @@ sub print_feed_meta {
 			);
 
 			$href_params{'extra_options'} = undef;
-			$href_params{'action'} = $type;
+			$href_params{'action'} = ($tag_view ? 'tags_' : '') . $type;
 			$link_attr{'-href'} = href(%href_params);
 			print "<link ".
 			      "rel=\"$link_attr{'-rel'}\" ".
@@ -4025,15 +4030,17 @@ sub print_feed_meta {
 			      "type=\"$link_attr{'-type'}\" ".
 			      "/>\n";
 
-			$href_params{'extra_options'} = '--no-merges';
-			$link_attr{'-href'} = href(%href_params);
-			$link_attr{'-title'} .= ' (no merges)';
-			print "<link ".
-			      "rel=\"$link_attr{'-rel'}\" ".
-			      "title=\"$link_attr{'-title'}\" ".
-			      "href=\"$link_attr{'-href'}\" ".
-			      "type=\"$link_attr{'-type'}\" ".
-			      "/>\n";
+			unless ($tag_view) {
+				$href_params{'extra_options'} = '--no-merges';
+				$link_attr{'-href'} = href(%href_params);
+				$link_attr{'-title'} .= ' (no merges)';
+				print "<link ".
+				      "rel=\"$link_attr{'-rel'}\" ".
+				      "title=\"$link_attr{'-title'}\" ".
+				      "href=\"$link_attr{'-href'}\" ".
+				      "type=\"$link_attr{'-type'}\" ".
+				      "/>\n";
+			}
 		}
 
 	} else {
@@ -4217,8 +4224,9 @@ sub git_footer_html {
 		}
 		$href_params{'-title'} ||= 'log';
 
+		my $tag_view = $href_params{-title} eq 'tags';
 		foreach my $format (qw(RSS Atom)) {
-			$href_params{'action'} = lc($format);
+			$href_params{'action'} = ($tag_view ? 'tags_' : '') . lc($format);
 			print $cgi->a({-href => href(%href_params),
 			              -title => "$href_params{'-title'} $format feed",
 			              -class => $feed_class}, $format)."\n";
@@ -8409,10 +8417,18 @@ sub git_rss {
 	git_feed('rss');
 }
 
+sub git_tags_rss {
+	git_feed('rss', 'tags')
+}
+
 sub git_atom {
 	git_feed('atom');
 }
 
+sub git_tags_atom {
+	git_feed('atom', 'tags')
+}
+
 sub git_opml {
 	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
@@ -8457,6 +8473,9 @@ XML
 		my $rss  = href('project' => $proj{'path'}, 'action' => 'rss', -full => 1);
 		my $html = href('project' => $proj{'path'}, 'action' => 'summary', -full => 1);
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
+		# and now the tags rss feed
+		$rss  = href('project' => $proj{'path'}, 'action' => 'tags_rss', -full => 1);
+		print "<outline type=\"rss\" text=\"$path tags\" title=\"$path tags\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
 	print <<XML;
 </outline>
-- 
2.12.2.822.g5451c77231

