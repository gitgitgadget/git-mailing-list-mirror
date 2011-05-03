From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 2/2 (PoC)] gitweb: Create Gitweb::Util module
Date: Tue,  3 May 2011 16:04:10 +0200
Message-ID: <1304431450-23901-3-git-send-email-jnareb@gmail.com>
References: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	"Alejandro R. Sedeno" <asedeno@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 16:04:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHGDb-000530-NV
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 16:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab1ECOEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 10:04:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57473 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab1ECOEl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 10:04:41 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so83361wya.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=LEPTpi3a6Db4+8yyxcteQtGXpkw++L8Q2VQKZYgxH8Q=;
        b=lKaS3casQzJ7A28eavSGC15rXuKOwAJZkosv8KkChpew8IFRhhhsiWxSNFqX+rmMa9
         U0k/+CdiUI5Jm62nE7PShYLwkTdQsLtm/QwqF5qSIBMSGXSySCYe2m3SVln9HYXhENBR
         4iC6mKH6wTo4utnL1WXoMf3wtOvd/Q0JOlwqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I+Cs/iTb+LgG+8UxMxecdiTNH+Fq5PXkiW/4o34KYDPahSzSLHyIxVfbhnN6mf1q+v
         t/B1KBMaEdeEmoOdwZomxjjG9qdH9sIMV4fWaYNc06EIq76g9x+ffUDNb8xAtYQsscrO
         ZTllJYxF80h/8r6Tr/jFrmi2yZ6oGzC8sbgzc=
Received: by 10.227.201.148 with SMTP id fa20mr196830wbb.39.1304431480491;
        Tue, 03 May 2011 07:04:40 -0700 (PDT)
Received: from roke.localdomain (abvt77.neoplus.adsl.tpnet.pl [83.8.217.77])
        by mx.google.com with ESMTPS id ed10sm78669wbb.32.2011.05.03.07.04.37
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 07:04:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172661>

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

Create a Gitweb::Util module, which is meant to contain internal
utilities used by gitweb.  Currently it includes all the
quoting/unquoting and escaping subroutines that are used by the
gitweb.

Update gitweb/Makefile to install Gitweb::Util module alongside gitweb

This was sort of part of [unfinished] Google Summer of Code 2010
project "Splitting gitweb and developing write functionalities
(Integrated web client for git)" by Pavan Kumar Sunkara, mentored by
Christian Couder and co-mentored by Petr Baudis.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from previous version:

  [PATCH (proof of concept) 2/2] gitweb: Create Gitweb::Util module
  http://thread.gmane.org/gmane.comp.version-control.git/165824/focus=165828


This patch serves two purposes.  First, it serves as test that earlier
"gitweb: Prepare for splitting gitweb" patch actually work correctly.
This can be checked by running "make -C gitweb test-installed" after
installing gitweb ("make install-gitweb" or "make -C gitweb install").

Second, it might be good starting point to splitting gitweb.
Refactoring well defined parts into separate modules (Perl packages)
could be a better, easier way than trying to come with good separation
(split) into modules upfront.  Such leisure approach to splitting
gitweb has more chance to be accepted.  Perhaps if such approach were
proposed on GSoC 2010, maybe "gitweb write" project wouldn't fail
midterm evaluations...


This module was taken out of unfinished GSoC 2010 project with
Pavan Kumar Sunkara as a student

  git://repo.or.cz/git/gsoc2010-gitweb.git

The module was renamed from Gitweb::Escape to Gitweb::Util.  Currently
the contents is the same, but it might change.

Code was updated to more modern codebase; since then esc_path_info and
esc_attr were added to gitweb - both of those are now in Gitweb::Util.

There were also required some changes and conflicts resolved due to
the fact that creating Gitweb::Util (formerly Gitweb::Escape) is no
longer in the middle of larger patch series.  In particular lack of
Gitweb::Config means that $fallback_encoding needed to be added to
Gitweb::Util module.

While at it do not export quot_cec and quot_upr helper subroutines by
default, but mark them exportable nevertheless.

 gitweb/Makefile           |    3 +
 gitweb/gitweb.perl        |  140 +-----------------------------------
 gitweb/lib/Gitweb/Util.pm |  177 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 137 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Util.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index b353d15..1b35808 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -114,6 +114,9 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+# Modules: Gitweb::*
+GITWEB_MODULES += Gitweb/Util.pm
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f094471..967ad64 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -24,11 +24,13 @@ use lib __DIR__ . '/lib';
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
-use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
 use Time::HiRes qw(gettimeofday tv_interval);
+
+use Gitweb::Util;
+
 binmode STDOUT, ':utf8';
 
 our $t0 = [ gettimeofday() ];
@@ -1391,128 +1393,6 @@ sub validate_refname {
 	return $input;
 }
 
-# decode sequences of octets in utf8 into Perl's internal form,
-# which is utf-8 with utf8 flag set if needed.  gitweb writes out
-# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
-sub to_utf8 {
-	my $str = shift;
-	return undef unless defined $str;
-	if (utf8::valid($str)) {
-		utf8::decode($str);
-		return $str;
-	} else {
-		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
-	}
-}
-
-# quote unsafe chars, but keep the slash, even when it's not
-# correct, but quoted slashes look too horrible in bookmarks
-sub esc_param {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# the quoting rules for path_info fragment are slightly different
-sub esc_path_info {
-	my $str = shift;
-	return undef unless defined $str;
-
-	# path_info doesn't treat '+' as space (specially), but '?' must be escaped
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;:@&= +]+)/CGI::escape($1)/eg;
-
-	return $str;
-}
-
-# quote unsafe chars in whole URL, so some characters cannot be quoted
-sub esc_url {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# quote unsafe characters in HTML attributes
-sub esc_attr {
-
-	# for XHTML conformance escaping '"' to '&quot;' is not enough
-	return esc_html(@_);
-}
-
-# replace invalid utf8 character with SUBSTITUTION sequence
-sub esc_html {
-	my $str = shift;
-	my %opts = @_;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
-	}
-	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
-	return $str;
-}
-
-# quote control characters and escape filename to HTML
-sub esc_path {
-	my $str = shift;
-	my %opts = @_;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
-	}
-	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
-	return $str;
-}
-
-# Make control characters "printable", using character escape codes (CEC)
-sub quot_cec {
-	my $cntrl = shift;
-	my %opts = @_;
-	my %es = ( # character escape codes, aka escape sequences
-		"\t" => '\t',   # tab            (HT)
-		"\n" => '\n',   # line feed      (LF)
-		"\r" => '\r',   # carrige return (CR)
-		"\f" => '\f',   # form feed      (FF)
-		"\b" => '\b',   # backspace      (BS)
-		"\a" => '\a',   # alarm (bell)   (BEL)
-		"\e" => '\e',   # escape         (ESC)
-		"\013" => '\v', # vertical tab   (VT)
-		"\000" => '\0', # nul character  (NUL)
-	);
-	my $chr = ( (exists $es{$cntrl})
-		    ? $es{$cntrl}
-		    : sprintf('\%2x', ord($cntrl)) );
-	if ($opts{-nohtml}) {
-		return $chr;
-	} else {
-		return "<span class=\"cntrl\">$chr</span>";
-	}
-}
-
-# Alternatively use unicode control pictures codepoints,
-# Unicode "printable representation" (PR)
-sub quot_upr {
-	my $cntrl = shift;
-	my %opts = @_;
-
-	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
-	if ($opts{-nohtml}) {
-		return $chr;
-	} else {
-		return "<span class=\"cntrl\">$chr</span>";
-	}
-}
-
 # git may return quoted and escaped filenames
 sub unquote {
 	my $str = shift;
@@ -1549,20 +1429,6 @@ sub unquote {
 	return $str;
 }
 
-# escape tabs (convert tabs to spaces)
-sub untabify {
-	my $line = shift;
-
-	while ((my $pos = index($line, "\t")) != -1) {
-		if (my $count = (8 - ($pos % 8))) {
-			my $spaces = ' ' x $count;
-			$line =~ s/\t/$spaces/;
-		}
-	}
-
-	return $line;
-}
-
 sub project_in_list {
 	my $project = shift;
 	my @list = git_get_projects_list();
diff --git a/gitweb/lib/Gitweb/Util.pm b/gitweb/lib/Gitweb/Util.pm
new file mode 100644
index 0000000..a213d3f
--- /dev/null
+++ b/gitweb/lib/Gitweb/Util.pm
@@ -0,0 +1,177 @@
+# Gitweb::Util -- Internal utilities used by gitweb (git web interface)
+#
+# This module is licensed under the GPLv2
+
+package Gitweb::Util;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(to_utf8
+                 esc_param esc_path_info esc_url
+                 esc_html esc_path esc_attr
+                 untabify
+                 $fallback_encoding);
+our @EXPORT_OK = qw(quot_cec quot_upr);
+
+use Encode;
+use CGI;
+
+# ......................................................................
+# Perl encoding (utf-8)
+
+# decode sequences of octets in utf8 into Perl's internal form,
+# which is utf-8 with utf8 flag set if needed.  gitweb writes out
+# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning of gitweb.perl
+our $fallback_encoding = 'latin1';
+sub to_utf8 {
+	my $str = shift;
+	return undef unless defined $str;
+	if (utf8::valid($str)) {
+		utf8::decode($str);
+		return $str;
+	} else {
+		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
+	}
+}
+
+# ......................................................................
+# CGI encoding
+
+# quote unsafe chars, but keep the slash, even when it's not
+# correct, but quoted slashes look too horrible in bookmarks
+sub esc_param {
+	my $str = shift;
+	return undef unless defined $str;
+
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+
+	return $str;
+}
+
+# the quoting rules for path_info fragment are slightly different
+sub esc_path_info {
+	my $str = shift;
+	return undef unless defined $str;
+
+	# path_info doesn't treat '+' as space (specially), but '?' must be escaped
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;:@&= +]+)/CGI::escape($1)/eg;
+
+	return $str;
+}
+
+# quote unsafe chars in whole URL, so some characters cannot be quoted
+sub esc_url {
+	my $str = shift;
+	return undef unless defined $str;
+
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+
+	return $str;
+}
+
+# ......................................................................
+# (X)HTML escaping
+
+# replace invalid utf8 character with SUBSTITUTION sequence
+sub esc_html {
+	my $str = shift;
+	my %opts = @_;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str = CGI::escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
+	return $str;
+}
+
+# quote unsafe characters in HTML attributes
+sub esc_attr {
+
+	# for XHTML conformance escaping '"' to '&quot;' is not enough
+	return esc_html(@_);
+}
+
+# quote control characters and escape filename to HTML
+sub esc_path {
+	my $str = shift;
+	my %opts = @_;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str = CGI::escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
+	return $str;
+}
+
+# ......................................................................
+# Other
+
+# escape tabs (convert tabs to spaces)
+sub untabify {
+	my $line = shift;
+
+	while ((my $pos = index($line, "\t")) != -1) {
+		if (my $count = (8 - ($pos % 8))) {
+			my $spaces = ' ' x $count;
+			$line =~ s/\t/$spaces/;
+		}
+	}
+
+	return $line;
+}
+
+# ----------------------------------------------------------------------
+# Showing "unprintable" characters (utility functions)
+
+# Make control characters "printable", using character escape codes (CEC)
+sub quot_cec {
+	my $cntrl = shift;
+	my %opts = @_;
+	my %es = ( # character escape codes, aka escape sequences
+		"\t" => '\t',   # tab            (HT)
+		"\n" => '\n',   # line feed      (LF)
+		"\r" => '\r',   # carrige return (CR)
+		"\f" => '\f',   # form feed      (FF)
+		"\b" => '\b',   # backspace      (BS)
+		"\a" => '\a',   # alarm (bell)   (BEL)
+		"\e" => '\e',   # escape         (ESC)
+		"\013" => '\v', # vertical tab   (VT)
+		"\000" => '\0', # nul character  (NUL)
+	);
+	my $chr = ( (exists $es{$cntrl})
+		    ? $es{$cntrl}
+		    : sprintf('\%2x', ord($cntrl)) );
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
+}
+
+# Alternatively use unicode control pictures codepoints,
+# Unicode "printable representation" (PR)
+sub quot_upr {
+	my $cntrl = shift;
+	my %opts = @_;
+
+	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
+}
+
+1;
-- 
1.7.3
