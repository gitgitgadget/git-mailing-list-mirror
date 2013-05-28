From: Misty De Meo <misty@brew.sh>
Subject: 1.8.3 - gitignore not being parsed correctly on OS X; regex support
 is broken?
Date: Tue, 28 May 2013 12:54:15 -0500
Message-ID: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 19:54:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhO6H-0003nj-KM
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916Ab3E1RyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:54:17 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:44687 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964881Ab3E1RyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:54:16 -0400
Received: by mail-wi0-f179.google.com with SMTP id hq7so2748254wib.0
        for <git@vger.kernel.org>; Tue, 28 May 2013 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=dHhuaRg4Zk6R43GWDQqTDx8BMHUJ2S2IWdBTRXcFeVU=;
        b=Ro5SGcINiE8qVf1c9vGF85AdQHzIdcLMvCeRD2Qvtrx2NGAdS3B3z0dHeIV6SQ7fgP
         KEcUsvQkMuFC3ecHocLE+0KpFCK9lO0n3sjSWRlacdjuZuaqo9XZOSBs0iRDEqNvPlSM
         m2WXccYQVMSswOSmHPso57tqj8Kk9RK/jPdZao3UuJIiDWehvaHwyl9zuvQUzHbGCORC
         J2IC/DPEwde5BTGFnbK/7tEop6EW/eCPCJbtUBI2ACN53y5jGRPiwLAaH73P2/bTHxvc
         pdeNhevdN72r+KnGGyD0bw9UnaALWZQv00Q0Tw9S95/3Bz284VopWNJcqd/RlgZaqf7V
         F5xQ==
X-Received: by 10.180.9.80 with SMTP id x16mr12864914wia.63.1369763655443;
 Tue, 28 May 2013 10:54:15 -0700 (PDT)
Received: by 10.180.163.140 with HTTP; Tue, 28 May 2013 10:54:15 -0700 (PDT)
X-Google-Sender-Auth: Ckge5GKCTol-3wWmFCeohGrdaB4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225675>

Hi,

Gitignore parsing no longer seems to work properly in git 1.8.3.

One of my repositories has the following gitignore:

/*
!/.gitignore
!/Library/
!/CONTRIBUTING.md
!/README.md
!/SUPPORTERS.md
!/bin
/bin/*
!/bin/brew
!/share/man/man1/brew.1
.DS_Store
/Library/LinkedKegs
/Library/PinnedKegs
/Library/Taps
/Library/Formula/.gitignore

In 1.8.2.3 and earlier, this works as expected. However, in 1.8.3 I'm
seeing every file in /bin/ being marked as an untracked file.

I asked about this in #git, and was told that the culprit was the
regex support; apparently recompiling without regex support fixes the
specific gitignore issue. However, this doesn't seem to have been
reported anywhere on the mailing list that I can see. I was also told
that the issue is OS X-specific, and doesn't happen on other
platforms.

Thanks,
Misty De Meo
