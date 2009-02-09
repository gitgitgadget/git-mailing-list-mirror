From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/3] git-gui: generic and robust worktree/gitdir support
Date: Mon,  9 Feb 2009 03:00:47 +0100
Message-ID: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 03:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWLTm-0004WI-5P
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 03:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbZBICBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 21:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZBICBD
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 21:01:03 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:59249 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbZBICBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 21:01:01 -0500
Received: by bwz5 with SMTP id 5so816233bwz.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 18:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kn3YsWc4FZBIwXH4/ttBmpghlX0a/GezCC24zmi5/aY=;
        b=kPgGRgyvDNcD1bLECLnlps6L49nee8Wcb1mmmYGqxoC/mE2hVvHbbbud6ATwiq8GsW
         okVoPC6aOJV9sEnZEXxFBsYt5K+GPpDsoTWGrCA9yHefj1lbQbba+hC44sGMPI3ps4Ht
         kK+8CBU0dfTT+T1GYDn5DucErALv+QPLy9xMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=visN7fUD8QHSNrFpi+qEIdjUnLXpQcAjpBQFxeqjMZdRIl6cowLX7CrgeEimSTk7EU
         YSjkq1u0kBTdEx2bwrNsIzBRnpAMAQkzLvv8LM+CjO31BYTwg1RLR7T/Tli/aXUIqTos
         NXJZLcwJHibKs5o66TSNKXtndebQNxOcUBhVA=
Received: by 10.103.240.5 with SMTP id s5mr918420mur.133.1234144857607;
        Sun, 08 Feb 2009 18:00:57 -0800 (PST)
Received: from localhost (host-78-15-9-200.cust-adsl.tiscali.it [78.15.9.200])
        by mx.google.com with ESMTPS id 23sm1191608mum.7.2009.02.08.18.00.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 18:00:57 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.173.g5e148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109035>

A-hem.

<intro class="shameless plug">
I've recently restarted using (and thus working on) my Zit project, the
Git-based single-file content tracker ( http://git.oblomov.eu/zit ),
adding support for importing RCS history (via my rcs-fast-export
project, http://git.oblomov.eu/rcs-fast-export ), and even managed to
run a successful rebase (which turned out to be somewhat clumsier due to
the inevitably longer command lines, but perfectly feasible). My next
step was looking for ways to support the graphical utilities, in
particular git-gui and gitk
</intro>

It turns out that while gitk works pretty fine out of the box, git-gui
makes a lot of guesses and assumptions about the nature and relation
between the git dir and its worktree. The following three patches try to
remedy the problems I came across with some simple testing.

Giuseppe Bilotta (3):
  git-gui: properly check for a bare repo
  git-gui: use the actual worktree
  git-gui: define correct GIT_DIR for gitk
