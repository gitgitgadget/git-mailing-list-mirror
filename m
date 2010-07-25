From: Jens Seidel <jensseidel@users.sf.net>
Subject: Re: [PATCH/WIP] git-svn: tweak log format to match "svn log" output
Date: Sun, 25 Jul 2010 19:52:39 +0200
Message-ID: <20100725175237.GB7930@merkur.sol.de>
References: <20100423134611.GA3440@merkur.sol.de> <20100426132710.GA9930@progeny.tock> <20100427112656.GB16323@merkur.sol.de> <20100725023114.GB18606@burratino> <20100725081057.GA22373@dcvr.yhbt.net> <20100725083708.GB22213@burratino> <20100725084057.GA23621@dcvr.yhbt.net> <20100725090943.GA1998@merkur.sol.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KFztAG8eRSV9hGtP"
Cc: Jens Seidel <jensseidel@users.sf.net>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 19:53:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od5OV-000262-FX
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab0GYRxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:53:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38012 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab0GYRxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:53:41 -0400
Received: by wyf19 with SMTP id 19so1588514wyf.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mail-followup-to:references:mime-version
         :content-type:content-disposition:in-reply-to:sender:user-agent;
        bh=EWz3796zob1InGOPcuWuOddBYz9jdaz9ka/10fl3hBg=;
        b=mP/Exc6ng7AsEFi67Q3aEVqULOF8dbVBGoY8EVJYckv2oz15wP+X9AD4szl6/KGGqD
         ZeWjO3t9PKigtwp8IvD8sHfG7fkrLFDmCRr9fbeejxDHz/bk6gBy43R6dbfoUJwm9MzB
         nD+VzvCbDZJhwpEDlVIDypSSXHGHmKT7Tcto0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to:sender
         :user-agent;
        b=nnuvZcT/fqlWM94NbIBqUZC5t/E4NJVp4l0nvUjrLbjceddLQEypXQYfjrIdMRdQ9l
         1jKbVSHPx7Jjf7Nn7AqdqICaDM+ziSS6ZUEtoQ8cA1bUtjSwq+VlFd1x/fkykHZ98jeT
         R5hsx11DxtTRMRb0no4fhUbDmmo6oWBim0n7Y=
Received: by 10.227.30.31 with SMTP id s31mr976046wbc.93.1280080419746;
        Sun, 25 Jul 2010 10:53:39 -0700 (PDT)
Received: from merkur.sol.de (p4FD7103F.dip0.t-ipconnect.de [79.215.16.63])
        by mx.google.com with ESMTPS id b18sm2306774wbb.7.2010.07.25.10.53.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:53:38 -0700 (PDT)
Received: from jens by merkur.sol.de with local (Exim 4.69)
	(envelope-from <tux-master@web.de>)
	id 1Od5NQ-00028U-4w; Sun, 25 Jul 2010 19:52:40 +0200
Mail-Followup-To: Jens Seidel <jensseidel@users.sf.net>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Disposition: inline
In-Reply-To: <20100725090943.GA1998@merkur.sol.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151774>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 25, 2010 at 11:09:46AM +0200, Jens Seidel wrote:
> No, this is still wrong, we have to use $d->nget as some languages can have
> multiple plural forms. Russian e.g. has two: one if the last digit ends with
> 2-4 and a second one if it ends with 5-9. Exact rule:
> "Plural-Forms:  nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 &&
> n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);\n"
> 
> That's why it's wrong to use $plur_fmt at all (and also "10" from above
> makes no sense). Let's use:
> $d->nget(" | %d line", " | %d lines", $nr_line), $nr_line)
> where $nr_line is the variable.
> 
> Sorry for not providing a patch now but I need more time ... I suggest one
> of you try it again and I check it :-)

Here is a new patch:

(Please check the last stanza, Jonathan introduced $nr_line for the
output where 1 was used before. I reverted it.)

Since the partial patches get difficult to handle I attached also the
combined patch which includes everything from this thread.

And a further minor issue. The current locale for the test is extracted from
$LANG. It's possible that this variable isn't set but another one such as
LC_MESSAGES. So the test doesn't determine the locale but $LANG :-))

commit 239c97380df384162ebe8399754d072300d8b52f
Author: Jens Seidel <jensseidel@users.sf.net>
Date:   Sun Jul 25 18:35:28 2010 +0200

    Proper use of plural forms

diff --git a/git-svn.perl b/git-svn.perl
index f9b7711..71c2c9a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5639,14 +5639,22 @@ sub show_commit_normal {
 	print "$c->{c} | " if $show_commit;
 	print "$c->{a} | ", format_svn_date($c->{t_utc});
 	my $nr_line = 0;
-	my $sing_fmt = " | %d line";
-	my $plur_fmt = " | %d lines";
 
-	if ($can_localize) {
-		my $d = Locale::gettext->domain("subversion");
-		$sing_fmt = $d->nget($sing_fmt, $plur_fmt, 1);
-		$plur_fmt = $d->nget($sing_fmt, $plur_fmt, 10);
-	}
+	# returns " | $1 lines" properly translated
+	local *get_line_msg = sub {
+		my $n = shift;
+		if ($can_localize) {
+			my $d = Locale::gettext->domain("subversion");
+			return sprintf($d->nget(" | %d line", " | %d lines", $n), $n);
+		} else {
+			if ($n == 1) {
+				return " | 1 line";
+			} else {
+				return " | " . $n . " lines";
+			}
+		}
+	};
+
 	if (my $l = $c->{l}) {
 		while ($l->[$#$l] eq "\n" && $#$l > 0
 		                          && $l->[($#$l - 1)] eq "\n") {
@@ -5654,23 +5662,15 @@ sub show_commit_normal {
 		}
 		$nr_line = scalar @$l;
 		if (!$nr_line) {
-			print sprintf($sing_fmt, 1), "\n\n\n";
+			print get_line_msg(1), "\n\n\n"; 
 		} else {
-			if ($nr_line == 1) {
-				print sprintf($sing_fmt, $nr_line), "\n";
-			} else {
-				print sprintf($plur_fmt, $nr_line), "\n";
-			}
+			print get_line_msg($nr_line), "\n";
 			show_commit_changed_paths($c);
 			print "\n";
 			print $_ foreach @$l;
 		}
 	} else {
-		if ($nr_line == 1) {
-			print sprintf($sing_fmt, $nr_line), "\n";
-		} else {
-			print sprintf($plur_fmt, $nr_line), "\n";
-		}
+		print get_line_msg(1), "\n";
 		show_commit_changed_paths($c);
 		print "\n";
 

--KFztAG8eRSV9hGtP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="git-svn.diff"

diff --git a/git-svn.perl b/git-svn.perl
index c416358..71c2c9a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -45,6 +45,7 @@ sub _req_svn {
 	}
 }
 my $can_compress = eval { require Compress::Zlib; 1};
+my $can_localize = eval { require Locale::gettext; 1};
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
 push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
 push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
@@ -5535,7 +5536,12 @@ sub format_svn_date {
 	my $gm = timelocal(gmtime($t));
 	my $sign = qw( + + - )[ $t <=> $gm ];
 	my $gmoff = sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
-	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
+	my $format = " (%a, %d %b %Y)";
+	if ($can_localize) {
+		my $d = Locale::gettext->domain("subversion");
+		$format = $d->get($format);
+	}
+	return strftime("%Y-%m-%d %H:%M:%S $gmoff$format", localtime($t));
 }
 
 sub parse_git_date {
@@ -5631,9 +5637,24 @@ sub show_commit_normal {
 	my ($c) = @_;
 	print commit_log_separator, "r$c->{r} | ";
 	print "$c->{c} | " if $show_commit;
-	print "$c->{a} | ", format_svn_date($c->{t_utc}), ' | ';
+	print "$c->{a} | ", format_svn_date($c->{t_utc});
 	my $nr_line = 0;
 
+	# returns " | $1 lines" properly translated
+	local *get_line_msg = sub {
+		my $n = shift;
+		if ($can_localize) {
+			my $d = Locale::gettext->domain("subversion");
+			return sprintf($d->nget(" | %d line", " | %d lines", $n), $n);
+		} else {
+			if ($n == 1) {
+				return " | 1 line";
+			} else {
+				return " | " . $n . " lines";
+			}
+		}
+	};
+
 	if (my $l = $c->{l}) {
 		while ($l->[$#$l] eq "\n" && $#$l > 0
 		                          && $l->[($#$l - 1)] eq "\n") {
@@ -5641,20 +5662,15 @@ sub show_commit_normal {
 		}
 		$nr_line = scalar @$l;
 		if (!$nr_line) {
-			print "1 line\n\n\n";
+			print get_line_msg(1), "\n\n\n"; 
 		} else {
-			if ($nr_line == 1) {
-				$nr_line = '1 line';
-			} else {
-				$nr_line .= ' lines';
-			}
-			print $nr_line, "\n";
+			print get_line_msg($nr_line), "\n";
 			show_commit_changed_paths($c);
 			print "\n";
 			print $_ foreach @$l;
 		}
 	} else {
-		print "1 line\n";
+		print get_line_msg(1), "\n";
 		show_commit_changed_paths($c);
 		print "\n";
 
@@ -5727,6 +5743,9 @@ sub cmd_show_log {
 			push @{$c->{stat}}, $_;
 			$stat = undef;
 		} elsif (/^${esc_color}    (git-svn-id:.+)$/o) {
+			if (@{$c->{l}} && $c->{l}->[-1] eq "\n") {
+				pop @{$c->{l}};
+			}
 			($c->{url}, $c->{r}, undef) = ::extract_metadata($1);
 		} elsif (s/^${esc_color}    //o) {
 			push @{$c->{l}}, $_;
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 0374a74..586f64b 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -16,6 +16,7 @@ test_expect_success 'setup repository and import' '
 		done && \
 		svn_cmd import -m test . "$svnrepo"
 		cd .. &&
+	svn_cmd checkout "$svnrepo"/branches/a checkout &&
 	git svn init "$svnrepo" -T trunk -b branches -t tags &&
 	git svn fetch &&
 	git reset --hard trunk &&
@@ -36,7 +37,38 @@ test_expect_success 'setup repository and import' '
 	git commit -a -m spy &&
 	echo try >> README &&
 	git commit -a -m try &&
-	git svn dcommit
+	git svn dcommit &&
+	(
+		cd checkout &&
+		svn_cmd update
+	) &&
+
+	if test -n "$ORIGINAL_LANG" && test "$ORIGINAL_LANG" != C
+	then
+		test_set_prereq NONCLOCALE
+	fi
+	'
+
+test_expect_success 'log matches svn log' '
+	git reset --hard a &&
+	(
+		cd checkout &&
+		svn_cmd log >../expected
+	) &&
+	git svn log >actual &&
+	test_cmp expected actual
+	'
+
+test_expect_success NONCLOCALE 'log matches svn log, original locale' '
+	(
+		LC_ALL=$ORIGINAL_LANG &&
+		(
+			cd checkout &&
+			svn_cmd log >../expected
+		) &&
+		git svn log >actual
+	) &&
+	test_cmp expected actual
 	'
 
 test_expect_success 'run log' "
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e5523dd..62aa48c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -34,6 +34,9 @@ esac
 # Keep the original TERM for say_color
 ORIGINAL_TERM=$TERM
 
+# Keep the original locale for tests
+ORIGINAL_LANG=$LANG
+
 # For repeatability, reset the environment to known value.
 LANG=C
 LC_ALL=C

--KFztAG8eRSV9hGtP--
