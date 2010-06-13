From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] add-interactive: =?utf-8?Q?Clarify?=
	=?utf-8?Q?_=E2=80=9Cremaining_hunks_in_the_file=E2=80=9D?=
Date: Sat, 12 Jun 2010 22:32:51 -0500
Message-ID: <20100613033251.GA2488@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>,
	William Pursell <bill.pursell@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 05:33:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONdwa-0004NN-FE
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 05:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab0FMDdF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 23:33:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54660 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab0FMDdC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 23:33:02 -0400
Received: by iwn9 with SMTP id 9so1968830iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 20:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=c4QEuyeCr2HzWPiKYh1NoKNcTtCPJNDu3WV0eujG0R4=;
        b=MkhTJVZOmMn0iGbhuTsdgK5mE8FjhuviFYXDHVcPlK1qmvJBxor/dTqxvAfhuecg31
         DxXayyfTCbk2FoqorFSp8ctSRuyzBf5k+Siz+J8qHyjaFghxI2vdSNCfi+/773DRtZg8
         ID3D2YhfGmkUW41FsF8s7a5UxAUoWwNkqKnEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=BaKb2huBeN37TlCIvv72xH8i5bfj8MUaHg4yQitiPBxxixknoK2RAiPsJAw83gxFrJ
         nYKzlceiuAPFaljCkiDGZNvAOBn3T+VbVxWDWD9qi6OUdZIKsDIX5Hm76ny8NhbHsoZp
         kh/n4uu/mgTWGCTeg9udpArHJhrrWwcHj36v0=
Received: by 10.231.200.24 with SMTP id eu24mr4293398ibb.186.1276399981230;
        Sat, 12 Jun 2010 20:33:01 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm13451528ibi.5.2010.06.12.20.32.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 20:32:59 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149035>

The "a" and "d" commands to =E2=80=98add --patch=E2=80=99 (accept/rejec=
t rest of file)
interact with "j", "g", and "/" (skip some hunks) in a perhaps
confusing way: after accepting or rejecting all _later_ hunks in the
file, they return to the earlier, skipped hunks and prompt the user
about them again.

This behavior can be very useful in practice.  One can still accept or
reject _all_ undecided hunks in a file by using the "g" command to
move to hunk #1 first.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=46rom <http://bugs.debian.org/526014>.  Thanks, Fr=C3=A9d=C3=A9ric.

 Documentation/git-add.txt |    6 +++---
 git-add--interactive.perl |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 51cbeb7..74741a4 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -266,9 +266,9 @@ patch::
=20
        y - stage this hunk
        n - do not stage this hunk
-       q - quit, do not stage this hunk nor any of the remaining ones
-       a - stage this and all the remaining hunks in the file
-       d - do not stage this hunk nor any of the remaining hunks in th=
e file
+       q - quit; do not stage this hunk nor any of the remaining ones
+       a - stage this hunk and all later hunks in the file
+       d - do not stage this hunk nor any of the later hunks in the fi=
le
        g - select a hunk to go to
        / - search for a hunk matching the given regex
        j - leave this hunk undecided, see next undecided hunk
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 21f1330..27fc793 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1111,9 +1111,9 @@ sub help_patch_cmd {
 	print colored $help_color, <<EOF ;
 y - $verb this hunk$target
 n - do not $verb this hunk$target
-q - quit, do not $verb this hunk nor any of the remaining ones
-a - $verb this and all the remaining hunks in the file
-d - do not $verb this hunk nor any of the remaining hunks in the file
+q - quit; do not $verb this hunk nor any of the remaining ones
+a - $verb this hunk and all later hunks in the file
+d - do not $verb this hunk nor any of the later hunks in the file
 g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
--=20
1.7.1
