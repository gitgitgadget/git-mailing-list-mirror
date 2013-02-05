From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 15:58:16 -0800
Message-ID: <7vtxpqnwiv.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
 <87ehgvua6h.fsf@lifelogs.com> <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <7vhalqsfkf.fsf@alter.siamese.dyndns.org>
 <8738xaqy40.fsf_-_@lifelogs.com> <7vip66qu0u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 00:58:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2sPS-000883-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 00:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab3BEX6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 18:58:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053Ab3BEX6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 18:58:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88A41BAE6;
	Tue,  5 Feb 2013 18:58:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8bVJqVh3v0bDhTSouzvC45y9ycU=; b=Tx4Na7
	i22B0qPPNCeAOwIXw+KDXCG/wTjmtRd0PoMAvNxd7m9LoEEdOAfRv6O7piFklTn1
	JYm93Hma1CLsBRyXO7GPLV/YkSKBYDpMjfC9CGFqsU1ZRSMKinq/XyBkgmtlBCAW
	cO1nVAVhpKRgjb3e9iyJWjQinUzoNeMqChgFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mSihPSaVPLg4ZZ14OU0/EEtgyDNKA+Pp
	WBJtBvil3xyo+Top2J0Rg5/FNDOdhKDjzJbQtqpEGidN4O+qUE0HX4Haug63sCjW
	jiWFcr/jbIVdScBLahT8gAaEIIsE7FFyOG4GfKFm0FbnxE1/bOJ32vYARl7/0+T4
	a7hsXcdJh2U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76451BAE4;
	Tue,  5 Feb 2013 18:58:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC145BAE0; Tue,  5 Feb 2013
 18:58:17 -0500 (EST)
In-Reply-To: <7vip66qu0u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 05 Feb 2013 14:24:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E955E632-6FEF-11E2-A24C-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215552>

Junio C Hamano <gitster@pobox.com> writes:

> Otherwise, looks almost ready to me.

For now, I've queued this as a minimum fix-up on top of your patch
and pushed the result out.  It is an equivalent of the previous
review comments in a patch form.  Please review and incorporate in
your reroll as appropriate.

I haven't looked at the part that interacts with the credential
subsystem itself, though.

 contrib/credential/netrc/git-credential-netrc | 35 ++++++++++++---------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 8298564..30e05fb 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -74,6 +74,10 @@ Options:
                        first matching entry found is returned via the credential
                        helper protocol (see below).
 
+                       When no -f option is given, .authinfo.gpg, .netrc.gpg,
+		       .authinfo, and .netrc files in your home directory are used
+		       in this order.
+
   -k|--insecure      : ignore bad file ownership or permissions
 
   -d|--debug         : turn on debugging (developer info)
@@ -206,8 +210,7 @@ foreach my $file (@$files) {
 	unless (scalar @entries) {
 		if ($!) {
 			log_verbose("Unable to open $file: $!");
-		}
-		else {
+		} else {
 			log_verbose("No netrc entries found in $file");
 		}
 
@@ -230,15 +233,10 @@ sub load_netrc {
 
 	my $io;
 	if ($gpgmode) {
-		# typical shell character escapes from http://www.slac.stanford.edu/slac/www/resource/how-to-use/cgi-rexx/cgi-esc.html
-		my $f = $file;
-		$f =~ s/([;<>\*\|`&\$!#\(\)\[\]\{\}:'"])/\\$1/g;
-		# GPG doesn't work well with 2- or 3-argument open
-		my $cmd = "gpg --decrypt $f";
-		log_verbose("Using GPG to open $file: [$cmd]");
-		open $io, "$cmd|";
-	}
-	else {
+		my @cmd = (qw(gpg --decrypt), $file)
+		log_verbose("Using GPG to open $file: [@cmd]");
+		open $io, "-|", @cmd;
+	} else {
 		log_verbose("Opening $file...");
 		open $io, '<', $file;
 	}
@@ -257,6 +255,9 @@ sub load_netrc {
 		my %entry;
 		my $num_port;
 
+		if (!defined $nentry->{machine}) {
+			next;
+		}
 		if (defined $nentry->{port} && $nentry->{port} =~ m/^\d+$/) {
 			$num_port = $nentry->{port};
 			delete $nentry->{port};
@@ -302,8 +303,7 @@ sub net_netrc_loader {
 		while (@tok) {
 			if ($tok[0] eq "default") {
 				shift(@tok);
-				undef $mach; # ignore 'default' lines
-
+				$mach = { machine => undef }
 				next TOKEN;
 			}
 
@@ -313,8 +313,7 @@ sub net_netrc_loader {
 				my $host = shift @tok;
 				$mach = { machine => $host };
 				push @entries, $mach;
-			}
-			elsif (exists $options{tmap}->{$tok}) {
+			} elsif (exists $options{tmap}->{$tok}) {
 				unless ($mach) {
 					log_debug("Skipping token $tok because no machine was given");
 					next TOKEN;
@@ -329,8 +328,7 @@ sub net_netrc_loader {
 				# Following line added by rmerrell to remove '/' escape char in .netrc
 				$value =~ s/\/\\/\\/g;
 				$mach->{$tok} = $value;
-			}
-			elsif ($tok eq "macdef") { # we ignore macros
+			} elsif ($tok eq "macdef") { # we ignore macros
 				next TOKEN unless $mach;
 				my $value = shift @tok;
 				$macdef = 1;
@@ -380,8 +378,7 @@ sub find_netrc_entry {
 				unless ($query->{$check} eq $entry->{$check}) {
 					next ENTRY;
 				}
-			}
-			else {
+			} else {
 				log_debug("OK: any value satisfies check $check");
 			}
 		}
-- 
1.8.1.2.641.g0b90ac4
