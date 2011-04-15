From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] Documentation: describe the format of messages with
 inline patches
Date: Thu, 14 Apr 2011 21:22:02 -0500
Message-ID: <20110415022202.GB19829@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
 <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
 <20110415021100.GA19829@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAYg0-00040W-30
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 04:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab1DOCWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 22:22:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58426 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab1DOCWI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 22:22:08 -0400
Received: by gwaa18 with SMTP id a18so975294gwa.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 19:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=chLq4pzXW+1eUok6TcDh0cSuNs5jBMBcH8Vky+mhRiw=;
        b=cn4axpSugmmsGzjrp8liW6OMEbCzLKYCDc73cU+9ssDMUOqc1h+zQgsmSPGpnNQifG
         B6NDB7CLX3+DMB2que8vs4AqnjjcyhxrEAUtOby66PxKokOq2ot9VYEUxtoqxls9jdPf
         4b7qqRRnbNUuPJfcyEjGOoDdPRFUgxDx1TMQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xG9TWBNj7/dJn6ohutcnOPNLHLnZOhAjQVzT2kv3w7vxK2zJm0zlYJz3cUrv6hagK0
         stqyGLOgk/R8RpE0zaqCfjMoswpM4ngPBfKpoFpaOHgsba2NBJUO9lGGV8w3Anwt1UbY
         dvmwdvS8WStRcYdZNFmnuR2d+wUlXddV1A0d0=
Received: by 10.91.72.7 with SMTP id z7mr2196391agk.12.1302834127148;
        Thu, 14 Apr 2011 19:22:07 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.sbcglobal.net [69.209.64.230])
        by mx.google.com with ESMTPS id d14sm2214887ana.0.2011.04.14.19.22.05
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 19:22:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110415021100.GA19829@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171577>

Add a DISCUSSION section to the "git format-patch" manual to encourage
people to send patches in a form that can be applied by "git am"
automatically.  There are two such forms:

 1. The default form in which most metadata goes in the mail header
    and the message body starts with the patch description;

 2. The snipsnip form in which a message starts with pertinent
    discussion and ends with a patch after a "scissors" mark.

The example requires QP encoding in the "Subject:" header intended for
the mailer to give the reader a chance to reflect on that, rather than
being startled by it later.  By contrast, in-body "From:" and
"Subject:" lines should be human-readable and not QP encoded.

Inspired-by: Jim Meyering <jim@meyering.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt |   58 ++++++++++++++++++++++++++++=
++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index a5525e9..a4a9813 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -229,6 +229,64 @@ attachments, and sign off patches with configurati=
on variables.
 ------------
=20
=20
+DISCUSSION
+----------
+
+The patch produced by 'git format-patch' is in UNIX mailbox format,
+with a fixed "magic" time stamp to indicate that the file is output
+from format-patch rather than a real mailbox, like so:
+
+------------
+From 8f72bad1baf19a53459661343e21d6491c3908d3 Mon Sep 17 00:00:00 2001
+From: Tony Luck <tony.luck@intel.com>
+Date: Tue, 13 Jul 2010 11:42:54 -0700
+Subject: [PATCH] =3D?UTF-8?q?[IA64]=3D20Put=3D20ia64=3D20config=3D20fi=
les=3D20on=3D20the=3D20?=3D
+ =3D?UTF-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig=3D20diet?=3D
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+arch/arm config files were slimmed down using a python script
+(See commit c2330e286f68f1c408b4aa6515ba49d57f05beae comment)
+
+Do the same for ia64 so we can have sleek & trim looking
+...
+------------
+
+Typically it will be placed in a MUA's drafts folder, edited to add
+timely commentary that should not go in the changelog after the three
+dashes, and then sent as a message whose body starts with "arch/arm
+config files were".  On the receiving end, readers can save
+interesting patches in a UNIX mailbox and apply them with
+linkgit:git-am[1].
+
+When a patch is part of an ongoing discussion, the patch generated by
+'git format-patch' can be tweaked to take advantage of the 'git am
+--scissors' feature.  After your response to the discussion comes a
+line that consists solely of "`-- >8 --`" (scissors and perforation),
+followed by the patch with unnecessary header fields removed:
+
+------------
+...
+> So we should do such-and-such.
+
+Makes sense to me.  How about this patch?
+
+-- >8 --
+Subject: [IA64] Put ia64 config files on the Uwe Kleine-K=C3=B6nig die=
t
+
+arch/arm config files were slimmed down using a python script
+...
+------------
+
+When sending a patch this way, most often you are sending your own
+patch, so in addition to the "`From $SHA1 $magic_timestamp`" marker yo=
u
+should omit `From:` and `Date:` lines from the patch file.  The patch
+title is likely to be different from the subject of the discussion the
+patch is in response to, so it is likely that you would want to keep
+the Subject: line, like the example above.
+
+
 EXAMPLES
 --------
=20
--=20
1.7.5.rc0
