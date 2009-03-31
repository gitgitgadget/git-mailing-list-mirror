From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 4/4] send-email: ensure quoted addresses are rfc2047 encoded
Date: Tue, 31 Mar 2009 12:22:14 -0400
Message-ID: <15408fd6016806764cbd501cfcb54c726662f359.1238516122.git.jaysoffian@gmail.com>
References: <cover.1238516122.git.jaysoffian@gmail.com>
 <e439cc23328dc25d153baed21f6ad7d90106eb03.1238516122.git.jaysoffian@gmail.com>
 <77c8a8123cb66821775b03fa0f3d2744de82b79b.1238516122.git.jaysoffian@gmail.com>
 <232681e20e15a61defb73a1645fd2c6b6aadd751.1238516122.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	=?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 18:25:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loglg-0007sD-Nv
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761287AbZCaQXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 12:23:10 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761063AbZCaQXJ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:23:09 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:46070 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760739AbZCaQXF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 12:23:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3180189qwh.37
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=nQysePVki2iY8C1RkybhWP4l+eojXb+SomHLZJxjQP0=;
        b=uAm4Zp8vH62O/nXoVpLswVOI+T8McE0oEkOz2qmJFrB8rpiejilLI/E2PB5MrvU4w9
         4+DEyvt982+oYaqoBYGCV4iwLZ3MVUKeJeDXEnTlYqKhHdbKNYGd/R1AnDVUnlLGAs85
         ZcmYVC6B0Ej9fD2abP3xaOCX//r95aPwG+6HI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kpuJx9mhWa8qBB2CYVXwsAKoCk72E6j5QNuTyM7oUBz+KUqD6Iux/rQc3f1brhVnqG
         pdJBYNVh9ij1PxByvkslUg2173JFLqipTfjmx8bcR9bV83KJ9nx2cuKkLQ8gxktN3oaZ
         xd49iV1SLP6/dldjWlyDS8tJQVaCweWRbOc7g=
Received: by 10.224.45.210 with SMTP id g18mr8403817qaf.171.1238516584336;
        Tue, 31 Mar 2009 09:23:04 -0700 (PDT)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 26sm7452564qwa.42.2009.03.31.09.23.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 09:23:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.427.g15408
In-Reply-To: <232681e20e15a61defb73a1645fd2c6b6aadd751.1238516122.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1238516122.git.jaysoffian@gmail.com>
References: <cover.1238516122.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115279>

sanitize_address assumes that quoted addresses (e.g., "first last"
<first.last@example.com) do not need rfc2047 encoding, but this is
not always the case.

=46or example, various places in send-email extract addresses using
parse_address_line. parse_address_line returns the addresses already
quoted (e.g., "first last" <first.last@example.com), but not rfc2047
encoded.

This patch makes sanitize_address stricter about what needs rfc2047
encoding and adds a test demonstrating where I noticed the problem.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-send-email.perl   |    3 ++-
 t/t9001-send-email.sh |   13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fc153f9..6bbdfec 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -776,12 +776,13 @@ sub sanitize_address
 	}
=20
 	# if recipient_name is already quoted, do nothing
-	if ($recipient_name =3D~ /^(".*"|=3D\?utf-8\?q\?.*\?=3D)$/) {
+	if ($recipient_name =3D~ /^("[[:ascii:]]*"|=3D\?utf-8\?q\?.*\?=3D)$/)=
 {
 		return $recipient;
 	}
=20
 	# rfc2047 is needed if a non-ascii char is included
 	if ($recipient_name =3D~ /[^[:ascii:]]/) {
+		$recipient_name =3D~ s/^"(.*)"$/$1/;
 		$recipient_name =3D quote_rfc2047($recipient_name);
 	}
=20
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 84238f7..192b97b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -505,6 +505,19 @@ test_expect_success 'confirm doesnt loop forever' =
'
 	test $ret =3D "0"
 '
=20
+test_expect_success 'utf8 Cc is rfc2047 encoded' '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git format-patch -1 -o outdir --cc=3D"=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA =
<utf8@example.com>" &&
+	git send-email \
+	--from=3D"Example <nobody@example.com>" \
+	--to=3Dnobody@example.com \
+	--smtp-server=3D"$(pwd)/fake.sendmail" \
+	outdir/*.patch &&
+	grep "^Cc:" msgtxt1 |
+	grep "=3D?utf-8?q?=3DC3=3DA0=3DC3=3DA9=3DC3=3DAC=3DC3=3DB6=3DC3=3DBA?=
=3D <utf8@example.com>"
+'
+
 test_expect_success '--compose adds MIME for utf8 body' '
 	clean_fake_sendmail &&
 	(echo "#!$SHELL_PATH" &&
--=20
1.6.2.1.427.g15408
