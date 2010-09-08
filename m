From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: git am cannot handle patches created with -B -M?
Date: Wed, 8 Sep 2010 15:00:00 +0200
Message-ID: <AANLkTinX=52AofapdhEmAZX3ergn-JKtTc5_3ZCa9G_0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Ungerer <gerg@snapgear.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 15:00:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtKG0-000668-9Q
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 15:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab0IHNAC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 09:00:02 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42240 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387Ab0IHNAB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 09:00:01 -0400
Received: by iwn5 with SMTP id 5so6379444iwn.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CBSP9vDS84HN6hBEI4JLwEW/TLSh+WYvKuyWX1rHpiI=;
        b=M5yE09io2rx6UZXtcdgJ9w+cRs7QNuNWWif0Eg4cVozJiT6qBDMORLqPZpUSC377yB
         3tFp3laAHbB75ltIK7C1jHSAtA5xmNvqinbK1mdwW+YhpGugzLKvyTzLLDjS9F2Jrrez
         6JFsV6XluN4/ulGrqjdDuc8KbsrWogRbIsxxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        b=LC7PHWhR+EPiGJeG0E8TZC+FUpNfC1ugg5Usl6N38yxv3j8qbkQq76ow0N0zR1+vs1
         NiK0gXIt+khS6v7TYUcX62tRKN7VVUmmXHqkjftarhgxAgVKJCDvIeCYazo1Yh4tCFKJ
         22gj+nQHRFrYy2QApnlSDzrY7MwdAAVxtKc3I=
Received: by 10.231.157.195 with SMTP id c3mr2260680ibx.155.1283950800462;
 Wed, 08 Sep 2010 06:00:00 -0700 (PDT)
Received: by 10.231.148.208 with HTTP; Wed, 8 Sep 2010 06:00:00 -0700 (PDT)
X-Google-Sender-Auth: OLoWfZz0h8JmeXi9i2qx62nZsq4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155782>

Hi,

I tried applying the patch in
http://www.spinics.net/lists/linux-m68k/msg03012.html
using `git am', but it failed:

| Applying: m68k/m68knommu: merge MMU and non-MMU string.h
| error: arch/m68k/include/asm/string.h: already exists in index
| Patch failed at 0001 m68k/m68knommu: merge MMU and non-MMU string.h
| When you have resolved this problem run "git am --resolved".
| If you would prefer to skip this patch, instead run "git am --skip".
| To restore the original branch and stop patching run "git am --abort"=
=2E

And according to `git status' no files have conflicts??

Greg said he created the patch using `git format-patch -M -B'.

The examples in the docs for format-patch say:

|       =C2=B7   The same as the previous one:
|
|               $ git format-patch -M -B origin
|
|           Additionally, it detects and handles renames and complete r=
ewrites
|           intelligently to produce a renaming patch. A renaming patch=
 reduces
|           the amount of text output, and generally makes it easier to=
 review.
|           Note that non-git "patch" programs won't understand renamin=
g
|           patches, so use it only when you know the recipient uses gi=
t to
|           apply your patch.

so I'd expect `git am' to handle it.

My git is 1.7.0.4. Is this bug fixed in a later version?

Thanks in advance!

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
