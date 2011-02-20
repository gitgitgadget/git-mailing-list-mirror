From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Sat, 19 Feb 2011 23:21:37 -0800
Message-ID: <7vy65bkw72.fsf@alter.siamese.dyndns.org>
References: <4D0ED5EC.9020402@burntmail.com>
 <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com>
 <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino>
 <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com>
 <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
 <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com>
 <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 08:22:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr3cV-0006YP-9N
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 08:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677Ab1BTHV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 02:21:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1BTHV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 02:21:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A6884BC6;
	Sun, 20 Feb 2011 02:23:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uv12g2aILn2SZEy9NZ4DBhgvXtU=; b=n7z0JI
	UPwlpSj0NP1ibikKPVbXM89M1KEntKQVLxetuCd5zwebfuMZhCKOuKopNQqPRY/m
	4gr+sfq+reYUfLOeHtv4+G5IfExbWepD11WvLDAsr4bozn8P9u7PDxTdKaUGFYbj
	YEjyvbjwPp+rdZIAPvI00grn9TFVIgrxx5w3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n39QL+eahK+ubwWe7bOhQIkfsLCdKqKf
	L9MPJG851xrtXzqCeqy5YbE0mBSC0jHqpqRn3v+vAHBQelndJo/X+cF2ZyWcs6cr
	wUcr0S3WQYTz6dpcCmrsQrz3E+yIcbglBedl+9AX/tU/5aHBJADGTpIkTXCyN9vL
	YWm8aRU+RHA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97B194BC5;
	Sun, 20 Feb 2011 02:22:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 210E94BC1; Sun, 20 Feb 2011
 02:22:47 -0500 (EST)
In-Reply-To: <4D5F6E97.4000402@burntmail.com> (Guy Rouillier's message of
 "Sat\, 19 Feb 2011 02\:17\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D980562-3CC2-11E0-A42E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167404>

Guy Rouillier <guyr@burntmail.com> writes:

> The two clients use a different delimiter to separate the CVS
> repository name from the user password.  The original CVS
> client separates the two entries with a space character, while
> CVSNT separates them with an equal (=) character.  Hence,
> the regular expression used to split these two tokens is
> altered to accept either delimiter.

That sounds like a wrong approach.  If there are two clients, one reads
from one location with one syntax, and the other one reads from another
different location with a different syntax, shouldn't the code using the
original syntax when reading the original file, and the other syntax when
reading the file for the other client?

I personally don't even like the sloppiness of the original code before
your patch that discards the version information ("/<digits>") and hopes
the file format stays the same for some time to come, but "one uses space
and the other uses equal, so lets mix them up and split at space-or-equal
when we know we are reading from the file that uses space (iow the one we
know we shouldn't be splitting at equal)" is making it even worse.

In practice, I would imagine that the cvsroot part wouldn't contain an
equal sign, so this looser regexp would not hurt in the real life, but it
does feel yucky.

Here is a totally untested patch.  I think the original code used
$pass="A" as a fall-back when it didn't find any password entry, and I
tried to retain that instead of dying.  Also this does not error out if
you merely have two cvspass files, as long as you do not have the wanted
entry for both of them.

 git-cvsimport.perl |   52 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8e683e5..0a25926 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -227,6 +227,31 @@ sub new {
 	return $self;
 }
 
+sub find_password_entry {
+	my ($cvspass, @cvsroot) = @_;
+	my ($file, $delim) = @$cvspass;
+	my $pass;
+	local ($_);
+
+	if (open(my $fh, $file)) {
+		# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
+	      CVSPASSFILE:
+		while (<$fh>) {
+			chomp;
+			s/^\/\d+\s+//;
+			my ($w, $p) = split($delim,$_,2);
+			for my $cvsroot (@cvsroot) {
+				if ($w eq $cvsroot) {
+					$pass = $p;
+					last CVSPASSFILE;
+				}
+			}
+		}
+		close($fh);
+	}
+	return $pass;
+}
+
 sub conn {
 	my $self = shift;
 	my $repo = $self->{'fullrep'};
@@ -259,19 +284,22 @@ sub conn {
 		if ($pass) {
 			$pass = $self->_scramble($pass);
 		} else {
-			open(H,$ENV{'HOME'}."/.cvspass") and do {
-				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
-				while (<H>) {
-					chomp;
-					s/^\/\d+\s+//;
-					my ($w,$p) = split(/\s/,$_,2);
-					if ($w eq $rr or $w eq $rr2) {
-						$pass = $p;
-						last;
-					}
+			my @cvspass = ([$ENV{'HOME'}."/.cvspass", qr/\s/],
+				       [$ENV{'HOME'}."/.cvs/cvspass", qr/=/]);
+			my @loc = ();
+			foreach my $cvspass (@cvspass) {
+				my $p = find_password_entry($cvspass, $rr, $rr2);
+				if ($p) {
+					push @loc, $cvspass->[0];
+					$pass = $p;
 				}
-			};
-			$pass = "A" unless $pass;
+			}
+			if (1 < @loc) {
+				die("More than one cvs password files have ".
+				    "entries for CVSROOT $opt_d: @loc");
+			} elsif (!$pass) {
+				$pass = "A";
+			}
 		}
 
 		my ($s, $rep);
