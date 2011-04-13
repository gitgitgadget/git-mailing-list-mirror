From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] Documentation/format-patch: summarize patch-sending
 workflow
Date: Wed, 13 Apr 2011 17:17:36 -0500
Message-ID: <20110413221736.GA773@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA8Ni-0007bb-Ch
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 00:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269Ab1DMWRp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 18:17:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63483 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933125Ab1DMWRo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 18:17:44 -0400
Received: by gyd10 with SMTP id 10so293377gyd.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lypLE/QsvBa1pG5mPzN5mHnkxbDKDJUI0zLV2TaSZdE=;
        b=cWwDoYPIa/AFL3uvOLvtcEYbH/3ykCfkiEx19HL0zwaLH2fAQZAWDcA3T+Re/JpbC9
         KHmHZ5vYptj8C6fKBMnDWWgjwDJ3GyRt1QErHaf7cfeiBqvOtHnwy+Gy2f5ynsFRRAWJ
         LJ+x5I99+KdtCXJJBUsf1xtQQNEr7XgHBUoEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=w7E/imohoA5IxDMs3woIEABNXbKK4RlEe1nx2EL7XJR1gl4JILrfhSo7KiLzWjYFV3
         dh0podlOsz0BiN1tjc6bmrd7gmc9Qm/d6ns5QCg+J8RwfgHxE9CA7JqZZVaIbZQVF65a
         lHvzS+czUAnlvu5WSdY4/anLHTMl0drqJo8zQ=
Received: by 10.236.182.100 with SMTP id n64mr10170269yhm.385.1302733063649;
        Wed, 13 Apr 2011 15:17:43 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.sbcglobal.net [69.209.64.230])
        by mx.google.com with ESMTPS id x68sm469031yhn.57.2011.04.13.15.17.41
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 15:17:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87mxjtn8x7.fsf@rho.meyering.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171492>

Hi Jim,

Jim Meyering wrote:

> I hope I haven't caused Junio or anyone else undue trouble.
> I know well how format-patch output can be used, but in the vast
> majority of patch-including messages I send, I include format-patch
> output mainly as an FYI, *following* commentary that does not
> belong in the log, so it's ok there -- desirable, even.

Sure, that's true.  The main problem with including a patch in mbox
format inline is that the "From " line tends to get corrupted.  How
about something like patch?

-- 8< --
Subject: Documentation/format-patch: summarize patch-sending workflow

Add a DISCUSSION section to encourage people to send patches in a
form that can be applied by "git am" automatically.  There are two
such forms:

 1. The default form in which most metadata goes in the mail header
    and the message body starts with the patch description;

 2. The snipsnip form in which a message starts with pertinent
    discussion and ends with a patch after a "scissors" mark.

While at it, include a pointer to Documentation/SubmittingPatches
for MUA-specific hints.

Inspired-by: Jim Meyering <jim@meyering.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-format-patch.txt |   48 ++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index a5525e9..5118fdb 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -274,9 +274,55 @@ as e-mailable patches:
 $ git format-patch -3
 ------------
=20
+DISCUSSION
+----------
+The patch produced by 'git format-patch' is in UNIX mailbox format,
+like so:
+
+------------
+From f97e66080296c741200eacf1eaeb73f05b19e140 Mon Sep 17 00:00:00 2001
+From: =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bja=
rmason?=3D <avarab@gmail.com>
+Date: Sun, 10 Apr 2011 19:37:01 +0000
+Subject: [PATCH] Makefile: extract Q_() source strings as ngettext()
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+The patch adding the Q_() wrapper function around ngettext[1] didn't
+contain a corresponding update to the "pot" target in the Makefile. As
+...
+------------
+
+Typically it will be placed in a MUA's drafts folder, edited to add
+timely commentary that should not go in the changelog after the three
+dashes, and then sent as a message whose body starts with "The patch
+adding the Q_() wrapper function ...".  On the receiving end, readers
+can save interesting patches in a UNIX mailbox and apply them with
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
+-- 8< --
+From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
+Subject: Makefile: extract Q_() source strings as ngettext()
+
+The patch adding the Q_() wrapper function around ngettext[1] didn't
+....
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
