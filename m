From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 2/6] Remove function prototypes from git-send-email.perl
Date: Wed, 29 Apr 2009 09:12:19 -0400
Message-ID: <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
Cc: gitster@pobox.com, Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 15:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9eb-0003wt-Qa
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760219AbZD2NMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760205AbZD2NMb
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:12:31 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:37679 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760197AbZD2NM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:12:26 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id DE15E5703E; Wed, 29 Apr 2009 09:12:23 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117883>

Use of function prototypes is considered bad practice in perl.  The
ones used here didn't accomplish anything anyhow, so they've been
removed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 git-send-email.perl |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4f62c59..067aaf0 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -131,9 +131,6 @@ my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
 
-sub unique_email_list(@);
-sub cleanup_compose_files();
-
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,
@@ -443,7 +440,7 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 ($sender) = expand_aliases($sender) if defined $sender;
 
 # returns 1 if the conflict must be solved using it as a format-patch argument
-sub check_file_rev_conflict($) {
+sub check_file_rev_conflict {
 	return unless $repo;
 	my $f = shift;
 	try {
@@ -509,7 +506,7 @@ if (@files) {
 	usage();
 }
 
-sub get_patch_subject($) {
+sub get_patch_subject {
 	my $fn = shift;
 	open (my $fh, '<', $fn);
 	while (my $line = <$fh>) {
@@ -1150,13 +1147,13 @@ foreach my $t (@files) {
 
 cleanup_compose_files();
 
-sub cleanup_compose_files() {
+sub cleanup_compose_files {
 	unlink($compose_filename, $compose_filename . ".final") if $compose;
 }
 
 $smtp->quit if $smtp;
 
-sub unique_email_list(@) {
+sub unique_email_list {
 	my %seen;
 	my @emails;
 
-- 
1.6.0.6
