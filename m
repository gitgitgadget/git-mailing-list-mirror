From: Leo Razoumov <slonik.az@gmail.com>
Subject: "git fsck" hanging (v1.7.3.2)
Date: Sun, 24 Oct 2010 12:45:21 -0400
Message-ID: <AANLkTinFRnK=NnnUPX1VUE1aY_MHCR=OZ99RuQ1G3nSG@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 24 18:45:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA3hI-0004gJ-Tv
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 18:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758745Ab0JXQpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 12:45:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35323 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757984Ab0JXQpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 12:45:22 -0400
Received: by eye27 with SMTP id 27so3405067eye.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to:date
         :message-id:subject:from:to:content-type;
        bh=GS32uDh+2kgDGYBhJ2dR6kYG7xzEzPSdcJEtMuhzjrA=;
        b=Fxth9td6XswkhjIW2+4azpC6JZnjVzFbaAc6AP4MBQ/etmTwijcYWEEWpfmCrRz6A3
         kXfH4uWD0LhtjNeJmIJwhWt4EjN6Y/p+0CD3sPwez7JVwTJHiHvi7mH+QO1f8VMchmph
         Qw/oPj1kRdjDudpfF54XPJ3wR/FMAYp5CWUqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=GJcHjovH4q/dvNEU18wql2QUU+3u7w0gXtpQIdYTlku3gP9KLklpcudmO4tSDm5hNj
         d05z1rF10gfTq8qgXJTK0bnCr6Dl1+4KM1ITtAZzfKx8NusxotrSvlv1eDH3tDrm9+QW
         s5lKLmV9vmeSFZ/zZ4WrWeawR0ATlhvmwIyKU=
Received: by 10.213.22.10 with SMTP id l10mr441950ebb.32.1287938721055; Sun,
 24 Oct 2010 09:45:21 -0700 (PDT)
Received: by 10.14.29.75 with HTTP; Sun, 24 Oct 2010 09:45:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159885>

Hi List,
I compiled git-1.7.3.2 from official git-repo (tag v1.7.3.2) on my
Ubuntu 9.04 x86 32 bits Linux laptop (gcc-4.3.3, linux kernel 2.6.28,
libc6 version 2.9). No failed tests from "make test":

success 6656
failed  0
broken  39
total   6721

However, when I type "git fsck" within the repo where I  built git it
hangs for several minutes

Below is the output of the

~/git-1.7.3.2> git fsck -v

Checking HEAD link
Checking object directory
Checking directory .git/objects/03
Checking directory .git/objects/05
Checking directory .git/objects/16
Checking directory .git/objects/19
Checking directory .git/objects/1e
Checking directory .git/objects/32
Checking directory .git/objects/38
Checking directory .git/objects/3f
Checking directory .git/objects/45
Checking directory .git/objects/55
Checking directory .git/objects/57
Checking directory .git/objects/5d
Checking directory .git/objects/64
Checking directory .git/objects/68
Checking directory .git/objects/74
Checking directory .git/objects/7e
Checking directory .git/objects/85
Checking directory .git/objects/96
Checking directory .git/objects/97
Checking directory .git/objects/a3
Checking directory .git/objects/a4
Checking directory .git/objects/db
Checking directory .git/objects/dc
Checking directory .git/objects/e4
Checking directory .git/objects/ec
Checking directory .git/objects/f1
Checking directory .git/objects/f7
Checking directory .git/objects/f8
Checking directory .git/objects/f9
Checking directory .git/objects/fa
Checking tag 035318261839a925a63ec5d3acc35912ec6c8566
Checking blob 05d7c18232ecade9b1662bb86fc69260d08def6b
Checking tree 167dff444e15caa18274b811828a1ffcefc0b933
Checking blob 19b3f4a6f64c74c7d1dad2635ad42600089e12cc
Checking blob 1ee7c83f4f14f993304e20b4952602f726efbf78
Checking blob 325ae2d1c45e9f52408fbda146218f09d7e6e9d5
Checking tree 3838c40c6838a01d876a2355bcfbf7ea1157b055
Checking commit 3f05fc67f541837a3f9ce21268a26a891b0c60f8
Checking commit 45c1fc50cf69682e246b6e6047efc19757a0379f
Checking commit 555f66991a7f4d071adc0259dec718065f1e409a
Checking blob 5740410a187bf6d49a0930e00cfd7e5bf120ff1b
Checking tree 5dde10493e5d2eec61374ff7d6a418ebd91cc192
Checking blob 64c613cb4efc552d4b43d3ffa0bd4a147a8155f7
Checking blob 68d3214e88d5e133259946420bfb3f783b4d27a4
Checking commit 74f9f8408d4139ea4919199e28e9bd7c3b633fb1
Checking commit 7e298bf4ad79a895f5cfc26f708075e8da01aa7e
Checking blob 854f035fed475baba8b85e6e7233fd337102fc42
Checking tree 96bdc2eafd8e2c41611169c8195e52f0dfc2dec8
Checking blob 970aba5a01abca62883d291c79b27a63c674ddc8
Checking commit a3d1909bf70686319b27fdab96d5ca65c18320e8
Checking blob a4e7ed791ef2b7d800ad729f0525b7b48a61906c
Checking tag db5299534db4a7bf90c2fd4bda746ec60276fdb5
Checking blob dc1f0d199f2c4424ddd8242aff04ef0fb20af88f
Checking tag e4610e12761bf839b3d459d0d32cbdc3c178562f
Checking tree ecf6ac0d37e1bb136572c85e7fc4f396777f69fd
Checking tree f1c78c7b9833a8e78220f945605102a51d6c51ad
Checking tree f796adec95cb05f149d1182172e827934e0fde53
Checking blob f856036fc669613b78a6839ac3b028b152f8915b
Checking tree f9daf07045a5ca7d9ac52a736998aa8d1e2ee8dc
Checking tree fa2e8d0e42db9f96a58d690925e94f5fbdec4b02

And then it sits there spinning CPU (99%) and nothing happening for
over a minute or so and then it proceeds to conclusion. The whole
thing takes about 2 minutes

~/git-1.7.3.2> time git fsck
git fsck  98.27s user 2.78s system 98% cpu 1:42.48 total

I previously compiled git-1.6.5.8 in exactly the same way on the same
system and had no problems of any kind.
"git fsck" was completing in seconds even for large repos.

Any ideas on what is going on?

--Leo--
