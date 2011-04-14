From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] Documentation: summarize how format-patch output is
 consumed
Date: Thu, 14 Apr 2011 16:11:25 -0500
Message-ID: <20110414211125.GA15277@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:11:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATpJ-00017A-9X
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab1DNVLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Apr 2011 17:11:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61330 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab1DNVLd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 17:11:33 -0400
Received: by ywj3 with SMTP id 3so483265ywj.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 14:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xQ4La0AhI5wHvaVit8Ho7UWjoVr45Gb1LC3dKLgAKAE=;
        b=Sd0ygyI95SgLcIr4Sna7jXdlMO93B7bS2Om7dfnd+Z1MLt0aKYKllSOno7GEgmJ53x
         W8qKUSJU14nTLzUmwfs5I8tSh13F2YIIW4vRdPi6oDLMfcbrBpaTOJtKgKUeicbUW66t
         ueiTUX9vkx0hTItk9Us0ZX6o+/KaGN4/lj0d8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nP43SI6EwviKNrcMdzSYXVMhN/dMESi7aKQll/GJbTmu/xGt6yYp1joIcoWtmCPLCU
         DpAXYICWh4+t4adiJSeWu4QsbbFWcMimR94x/ybAXUAgOa/ClPEa38PfibKXqkT3y7q4
         Tp+vQfw4HW7SU+AFiqACnwmcA7eG2fDNytQiQ=
Received: by 10.236.185.193 with SMTP id u41mr93209yhm.374.1302815492529;
        Thu, 14 Apr 2011 14:11:32 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.sbcglobal.net [69.209.64.230])
        by mx.google.com with ESMTPS id u75sm737438yhn.20.2011.04.14.14.11.29
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 14:11:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171557>

Add a DISCUSSION section to encourage people to send patches in a
form that can be applied by "git am" automatically.  There are two
such forms:

 1. The default form in which most metadata goes in the mail header
    and the message body starts with the patch description;

 2. The snipsnip form in which a message starts with pertinent
    discussion and ends with a patch after a "scissors" mark.

Use an example requiring QP encoding in the "Subject:" field intended
for the mailer, to give the reader a chance to reflect on that (rather
than being startled later).  By contrast, in-body "From:" and
"Subject:" lines should be human-readable and not QP encoded.

A patch following "How about this patch?" is most likely to be written
by the same person as the message is coming from, so you would rarely
need a "From:" after the scissors.  On the other hand, such a message
typically presents a potential solution to a problem raised in
discussion and the original subject is likely to be a description of
the problem or a request for help while the patch title is about the
solution, so it is very likely that you would want a "Subject:" line
after the scissors.  It would be nice to clarify use of the "From:",
"Date:", and "Subject:" fields after the scissors in general, but this
patch avoids the topic in hope of leading the reader to look to
git-am(1) for a detailed discussion.

While at it, include a pointer to Documentation/SubmittingPatches
for MUA-specific hints.

Inspired-by: Jim Meyering <jim@meyering.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano wrote:

> It still is preferred to remove the magic "From xxxx Mon Sep 17 00:00=
:00
> 2001" we placed to help somebody who is inclined to write an /etc/mag=
ic
> entry to detect files of format-patch output type if you use the scis=
sors
> format.
[and many useful suggestions]

Thanks.  Changes since v1:

 - no more inline "From:" field
 - different patch to demonstrate qp-encoding in "Subject:" instead
 - use right-handed scissors

I didn't find a way to sneak in a comment about "file" magic; that can
come another day.

 Documentation/git-format-patch.txt |   50 ++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index a5525e9..875ea9b 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -274,9 +274,57 @@ as e-mailable patches:
 $ git format-patch -3
 ------------
=20
+DISCUSSION
+----------
+The patch produced by 'git format-patch' is in UNIX mailbox format,
+like so:
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
+'git am --scissors' accepts an alternative format with the patch
+inline in the message:
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
+See linkgit:git-am[1] for details.
+
 SEE ALSO
 --------
-linkgit:git-am[1], linkgit:git-send-email[1]
+linkgit:git-am[1], linkgit:git-send-email[1], linkgit:git-imap-send[1]=
,
+Documentation/SubmittingPatches
=20
 GIT
 ---
--=20
1.7.5.rc0
