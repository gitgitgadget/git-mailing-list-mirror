From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH resend] git-pull: fix fetch-options.txt to not document 
	--quiet and --verbose twice in git-pull.txt
Date: Mon, 7 Sep 2009 14:34:35 +0200
Message-ID: <9f50533b0909070534q2375a793mf5d676b519eae69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 07 14:35:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkdQk-0008CY-St
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 14:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbZIGMeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 08:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbZIGMeg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 08:34:36 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:56641 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZIGMef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 08:34:35 -0400
Received: by ewy2 with SMTP id 2so2020164ewy.17
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vJDYmVDUcbb7kmZh+Eml/JW6gjxcJhZ4Zaeq4ShAP8k=;
        b=j43nqC5NNOSq4DR6YLDR8rBiaD1T/lIwr2nPoXsFk7ypw957cXt0SZZv7ZLeJvox/H
         1jk0wH/4jfqs9pPK5deOSFxVaf/+GnjL3ATWTSNJzFq6aF0fl+sZ51bjDYt9dKbFv21g
         Z6u4KYF0J5cNVjxf3NDQfva1vfdDsIRYYt1IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=HwBlqyBV6zy6t6MLHuUFSWavshixlZ8wXW/qb8M3JNTVPSDChWYkZwqyMRDKjKL/QF
         ICLY3ygvFacvMa2ojJ71cyniPiuHxq14uBxZN/1QqDbnp0MOPkmY/fMf1gWzsJDQNYDY
         B8YfqC/zU/R7NYsSSfO4LoMphBF3h+s/KYaO8=
Received: by 10.216.88.65 with SMTP id z43mr1467058wee.5.1252326876296; Mon, 
	07 Sep 2009 05:34:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127924>

Hello all,
In git-pull(1) we can read :

OPTIONS
=C2=A0 =C2=A0 =C2=A0 -q, --quiet
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Operate quietly.

=C2=A0 =C2=A0 =C2=A0 -v, --verbose
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Be verbose.
=2E..

=C2=A0 =C2=A0 =C2=A0 -q, --quiet
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Pass --quiet to git-fetch-pack and s=
ilence any other
internally used git
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commands.

=C2=A0 =C2=A0 =C2=A0 -v, --verbose
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Be verbose.

The first part is included by merge-option.txt and the second by
fetch-options.txt.
I choose to "suppress" the fetch-options part because IMHO we don't
need that level
of precision. But if you prefer, I can provide a patch to "ifndef" the
merge-options.txt part.

Best regard


git-pull.txt includes fetch-options.txt and merge-options.txt which bot=
h
document the --quiet and --verbose parameters. So we supress the
--quiet and --verbose paragraphs if fetch-options.txt is included by
git-pull.txt

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
Documentation/fetch-options.txt | =C2=A0 =C2=A02 ++
1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index ea3b1bc..5eb2b0e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,3 +1,4 @@
+ifndef::git-pull[]
-q::
--quiet::
Pass --quiet to git-fetch-pack and silence any other internally
@@ -6,6 +7,7 @@
-v::
--verbose::
Be verbose.
+endif::git-pull[]

-a::
--append::
--
1.6.4.2.253.g0b1fac
