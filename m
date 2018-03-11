Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23AB01F404
	for <e@80x24.org>; Sun, 11 Mar 2018 13:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeCKN7W (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 09:59:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36996 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKN7V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 09:59:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id z12so13126563wrg.4
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zH9ji5QkKaQP7Cj9N4KxhdG56Q2f3ot8mX3gLfGlazE=;
        b=jDsRKJEZw0iIPuQq7R5BIzrrOTPRiIKKouY6zWC8iCtsa2R6bQp74KO5XeyxM5CChf
         X9rAASEiU5MYeNE7GidogiNWsZ69zqE7B9H3rblQ7sfOqPwnLNmHuT8rQMfMxjNUPuo1
         U8Ob9kac8rNky238n/LgikHcOBmxmBJN1/BHR4C63fGHcvo2ckpUSa/UhSXM3zI7Ydug
         e7XxIZBnb2/cccHdW5EadbJuvbszX0FLmMZFbmcBx2CUfXvFBLl/l9MUIFJsEpezAFJ/
         pDpxbIz6DeDldZBfZrFk6evt7v1S+a5DLBnT51p+blaLDO4vBmPHPv5AFpdF+WkP0SG6
         jNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zH9ji5QkKaQP7Cj9N4KxhdG56Q2f3ot8mX3gLfGlazE=;
        b=qgTqjVpgE4BrF2jOYnKLwpSerWau9PJ8d31t22/hEpwWErKOUvKc0vkKBfCtUpsxom
         OVtrAzkHUi3EunA71Wjl8BZ7dpQluojTUJ2uKEasq9YrWT+c2bc8nfPElG12OcKnFv2G
         VEg22f1jXwbhlBJxhGDM61nYbi2XcCK1IU2OrFKP42woAjqcqsVMANbz8YB6MVcHEjT7
         hoyPsjbMADN7XS0qf53nUMdHXbWFBxW3Aq7ZqmDl3yyVbgovJaFhgf9wHaPyJzigZSWJ
         +88gTUh4M0S1nfSMp5ck1wsnYo0WyLQbT51cC00S3gPC1MinWh8uamokkc6AVPdUnnTd
         mAyQ==
X-Gm-Message-State: AElRT7HnWrZn9hqPtcpByf9kcJnmghWnwGdT0HgRFIYSNxD6IcKa5dP+
        5k8jH6ZV2OeIT7vTx2DNA06L3A==
X-Google-Smtp-Source: AG47ELtFOemt8WmQPcQI1L9kjONIr7grIYNTSgqVJMZvppVFLPJL3wC7uRL/UdkYxXFxu3oAPAnLXA==
X-Received: by 10.223.143.65 with SMTP id p59mr4144569wrb.31.1520776759538;
        Sun, 11 Mar 2018 06:59:19 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:6470:d27b:6b84:5144])
        by smtp.gmail.com with ESMTPSA id c192sm3505133wma.12.2018.03.11.06.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Mar 2018 06:59:18 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2 2/2] git-svn: allow empty email-address in authors-prog and authors-file
Date:   Sun, 11 Mar 2018 14:58:35 +0100
Message-Id: <20180311135835.9775-3-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311135835.9775-1-asheiduk@gmail.com>
References: <20180311135835.9775-1-asheiduk@gmail.com>
In-Reply-To: <20180304112237.19254-1-asheiduk@gmail.co>
References: <20180304112237.19254-1-asheiduk@gmail.co>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The email address in --authors-file and --authors-prog can be empty but
git-svn translated it into a syntethic email address in the form
$USERNAME@$REPO_UUID. Now git-svn behaves like git-commit: If the email
is explicitly set to the empty string, the commit does not contain
an email address.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-svn.txt       |  8 +++++---
 perl/Git/SVN.pm                 | 13 ++++++-------
 t/t9130-git-svn-authors-file.sh | 14 ++++++++++++++
 t/t9138-git-svn-authors-prog.sh | 25 ++++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b858374649..d59379ee23 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -635,7 +635,8 @@ config key: svn.findcopiesharder
 
 -A<filename>::
 --authors-file=<filename>::
-	Syntax is compatible with the file used by 'git cvsimport':
+	Syntax is compatible with the file used by 'git cvsimport' but
+	an empty email address can be supplied with '<>':
 +
 ------------------------------------------------------------------------
 	loginname = Joe User <user@example.com>
@@ -654,8 +655,9 @@ config key: svn.authorsfile
 	If this option is specified, for each SVN committer name that
 	does not exist in the authors file, the given file is executed
 	with the committer name as the first argument.  The program is
-	expected to return a single line of the form "Name <email>",
-	which will be treated as if included in the authors file.
+	expected to return a single line of the form "Name <email>" or
+	"Name <>", which will be treated as if included in the authors
+	file.
 +
 Due to historical reasons a relative 'filename' is first searched
 relative to the current directory for 'init' and 'clone' and relative
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index bc4eed3d75..945ca4db2b 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1482,7 +1482,6 @@ sub call_authors_prog {
 	}
 	if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
 		my ($name, $email) = ($1, $2);
-		$email = undef if length $2 == 0;
 		return [$name, $email];
 	} else {
 		die "Author: $orig_author: $::_authors_prog returned "
@@ -2020,8 +2019,8 @@ sub make_log_entry {
 		remove_username($full_url);
 		$log_entry{metadata} = "$full_url\@$r $uuid";
 		$log_entry{svm_revision} = $r;
-		$email ||= "$author\@$uuid";
-		$commit_email ||= "$author\@$uuid";
+		$email = "$author\@$uuid" unless defined $email;
+		$commit_email = "$author\@$uuid" unless defined $commit_email;
 	} elsif ($self->use_svnsync_props) {
 		my $full_url = canonicalize_url(
 			add_path_to_url( $self->svnsync->{url}, $self->path )
@@ -2029,15 +2028,15 @@ sub make_log_entry {
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
-		$email ||= "$author\@$uuid";
-		$commit_email ||= "$author\@$uuid";
+		$email = "$author\@$uuid" unless defined $email;
+		$commit_email = "$author\@$uuid" unless defined $commit_email;
 	} else {
 		my $url = $self->metadata_url;
 		remove_username($url);
 		my $uuid = $self->rewrite_uuid || $self->ra->get_uuid;
 		$log_entry{metadata} = "$url\@$rev " . $uuid;
-		$email ||= "$author\@" . $uuid;
-		$commit_email ||= "$author\@" . $uuid;
+		$email = "$author\@$uuid" unless defined $email;
+		$commit_email = "$author\@$uuid" unless defined $commit_email;
 	}
 	$log_entry{name} = $name;
 	$log_entry{email} = $email;
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index 41264818cc..6af6daf461 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -108,6 +108,20 @@ test_expect_success !MINGW 'fresh clone with svn.authors-file in config' '
 	)
 '
 
+cat >> svn-authors <<EOF
+ff = FFFFFFF FFFFFFF <>
+EOF
+
+test_expect_success 'authors-file imported user without email' '
+	svn_cmd mkdir -m aa/branches/ff --username ff "$svnrepo/aa/branches/ff" &&
+	(
+		cd aa-work &&
+		git svn fetch --authors-file=../svn-authors &&
+		git rev-list -1 --pretty=raw refs/remotes/origin/ff | \
+		  grep "^author FFFFFFF FFFFFFF <> "
+	)
+	'
+
 test_debug 'GIT_DIR=gitconfig.clone/.git git log'
 
 test_done
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 7d7e9d46bc..0cec56128f 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -9,7 +9,9 @@ test_description='git svn authors prog tests'
 
 write_script svn-authors-prog "$PERL_PATH" <<-\EOF
 	$_ = shift;
-	if (s/-sub$//)  {
+	if (s/-hermit//) {
+		print "$_ <>\n";
+	} elsif (s/-sub$//)  {
 		print "$_ <$_\@sub.example.com>\n";
 	} else {
 		print "$_ <$_\@example.com>\n";
@@ -68,6 +70,27 @@ test_expect_success 'authors-file overrode authors-prog' '
 git --git-dir=x/.git config --unset svn.authorsfile
 git --git-dir=x/.git config --unset svn.authorsprog
 
+test_expect_success 'authors-prog imported user without email' '
+	svn mkdir -m gg --username gg-hermit "$svnrepo"/gg &&
+	(
+		cd x &&
+		git svn fetch --authors-prog=../svn-authors-prog &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep "^author gg <> "
+	)
+'
+
+test_expect_success 'imported without authors-prog and authors-file' '
+	svn mkdir -m hh --username hh "$svnrepo"/hh &&
+	(
+		uuid=$(svn info --show-item=repos-uuid "$svnrepo") &&
+		cd x &&
+		git svn fetch &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep "^author hh <hh@$uuid> "
+	)
+'
+
 test_expect_success 'authors-prog handled special characters in username' '
 	svn mkdir -m bad --username "xyz; touch evil" "$svnrepo"/bad &&
 	(
-- 
2.16.2

