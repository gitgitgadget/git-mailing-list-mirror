From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/5] gettext docs: add a "Testing your changes" section to po/README
Date: Fri, 10 Sep 2010 19:35:49 +0000
Message-ID: <1284147353-18000-2-git-send-email-avarab@gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 21:36:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9Om-0006Xz-F0
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab0IJTgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:36:15 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57467 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab0IJTgO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:36:14 -0400
Received: by wwb13 with SMTP id 13so104223wwb.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LnTzz/N41NkG4VEl1dAgqBeijgTZGyuy/mHX702OVmw=;
        b=wUJailROr8H6L6W7ePHLdu1hXmNGYhRhetA3tP0fQcS4woDMXHYSOBRl39OwT/EeEU
         /NGGnbMH+++iudrL7Zo3YofxtCE67ikj2rSFGpiLkuRBzHlB7atHAX1SeoyqoiyJULde
         CTK427z0gKMIKdP8us2QjYe7XhOvCWr9sdMp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=R3XwG019qCB6PcXgU64HUHbPU0772yZk8p2NOXcQGEDrs3DT3fWvV7VHBVuw339XV+
         WvgTKiltqTe0yWWGM4i53NpCQjtjN6+4BrJpb1O8xmZXharaYhevm5r14uBSV1r/bILF
         M8mXcYJBpoXsHTyRRq29ySJc9zXZ/d6o7nqkw=
Received: by 10.227.155.143 with SMTP id s15mr563392wbw.154.1284147364072;
        Fri, 10 Sep 2010 12:36:04 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2534921wbb.8.2010.09.10.12.36.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:36:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155961>

Change po/README to tell translators that they should do `make` at the
top-level before submitting their translations. Many common errors
will be caught with the `msgfmt --check` run that the Makefile will
compile the message catalogs with.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/README |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/po/README b/po/README
index cca8012..4d23ca6 100644
--- a/po/README
+++ b/po/README
@@ -66,3 +66,17 @@ But then you need remember to remove the comments be=
fore you submit
 the file upstream:
=20
     perl -pi -e 's/^#: .*\n//' XX.po
+
+
+Testing your changes
+--------------------
+
+Before you submit your changes go back to the top-level and do:
+
+    make
+
+On systems with GNU gettext (i.e. not Solaris) this will compile your
+changed PO file with `msgfmt --check`, the --check option flags many
+common errors, e.g. missing printf format strings, or translated
+messages that deviate from the originals in whether they begin/end
+with a newline or not.
--=20
1.7.2.3.313.gcd15
