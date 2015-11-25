From: Raymundo <gypark@gmail.com>
Subject: 'git log --source' seems to fail to show ref name after the first tag
 comes out.
Date: Wed, 25 Nov 2015 19:29:02 +0900
Message-ID: <CAAe7MbAwWHXxVOu-CU7QpN0K3XTKJ1=xp4-dzSwBQatdAZ1vaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 11:29:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1XKH-0005T7-9T
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 11:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbbKYK3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 05:29:23 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38017 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbbKYK3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 05:29:22 -0500
Received: by igbxm8 with SMTP id xm8so34831807igb.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 02:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=fE2SJA1MlTsVY6KqnvcnFi0Cz6/nTzfdor2y1CUVnxU=;
        b=XMwBgouSLp7rAj+YxE4l3kaElEM+yNJs8q2zHoXdOLepqpkvQTsZ/743VsH9oZ6zJP
         +ckeWHM8WgYoVneuWuLbtzbLy7UnHmnIr9VePkfDKc6b9BdSi3ZEEl8aI9cq8uCq1IKQ
         PdWoARPCeao0CiM+R89lYuh2J2zLC8qbHaQmzbXOmdTYYvMLYpwebQnTpt7+Koz9Qpl9
         y5SgmuNoLdz5VSZhVbwN/JxAATj7tM08E/47b11LkXRZlFz9pElPqlwgvI0EWT2XXl8B
         5QPDy2fGEM947pbKjsugPJsOec3Dti7VQwbn1rIkQXWFxv8ViaLedCUAnMCwIvsqwoxM
         jmhg==
X-Received: by 10.50.80.14 with SMTP id n14mr3084683igx.56.1448447361449; Wed,
 25 Nov 2015 02:29:21 -0800 (PST)
Received: by 10.36.26.200 with HTTP; Wed, 25 Nov 2015 02:29:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281697>

Hello,

At first, I'm sorry I'm not good at English.


When I execute this command:

git log --oneline --source --all --decorate

I get the output below: (I replaced commit messages written in Korean
with "COMMIT MSG")

295c670 refs/heads/gyparkwiki_base (gyparkwiki_base) COMMIT MSG
c130d61 refs/heads/master (HEAD -> master, origin/master, origin/HEAD)
version 2.27a
6f6f40c refs/heads/gyparkwiki (gyparkwiki) COMMIT MSG
...
a37772f refs/heads/gyparkwiki COMMIT MSG
afeaa51 refs/heads/gyparkwiki COMMIT MSG
af2676e  (tag: last_CVS_utf) COMMIT MSG   <- ref name is not shown
from this line
b4d27c9  COMMIT MSG
4f834f8  COMMIT MSG
...
7534d49  COMMIT MSG
e5c8a6c  *** empty log message ***
596aa3e refs/tags/urlprefix (tag: urlprefix) COMMIT MSG  <- ref name
appears again from this line
8fc4de3 refs/tags/urlprefix COMMIT MSG
...
a0b587 refs/tags/urlprefix COMMIT MSG
f8526f9 refs/tags/urlprefix COMMIT MSG
277478b  (tag: last_CVS_testwiki) COMMIT MSG <- ref name disappear
again from this line
65919c8  *** empty log message ***
...

As you can see, ref names in the second column repeats to disappear
and come back, at every lines that contain tags.

I tested using Git version 2.6.3

For reference, Git version 1.7.9.rc0 does not have this problem. It
shows ref names on all lines well.


Maybe is this a bug?

Thank you.
G.Y.Park from South Korea
