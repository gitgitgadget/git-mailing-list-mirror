From: "jarek z." <yaras6@gmail.com>
Subject: Invalid initial git gui message encoding
Date: Tue, 23 Feb 2016 19:36:55 +0100
Message-ID: <CABvS4Ogs9biYxs-yNVxO9S5_nWiKcUO8dySWHWEfFAyaqCviJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Tue Feb 23 19:37:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYHpU-0001kS-61
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 19:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbcBWSg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 13:36:56 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35067 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbcBWSgz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 13:36:55 -0500
Received: by mail-ig0-f171.google.com with SMTP id hb3so105111388igb.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=zAQkArDS+4aRupi+B9Mmq79J3yEX/UfiqTsi4hHje4k=;
        b=OzuSLbeC255laWv90ZBf9d0FkB5WLmCMIM8JHSvI2C29rG4r8tb0ieukNrkG2k1pYS
         gq3LLFXli4PNR/xV5bZ+sO9PgQrREa7wN8Nuc83EJP0kzJP2vefBO+mXiEkDH+2xPwji
         9qqPmaSCDjC0USrOXMbNvajRHFJWiB7p2TnO32a/xrM7Uux2njLbkVp0sXfrByyCdquv
         ADZpRv4ExI6J6nXjCF5cfWsewnSO2o7TcwLM6Xdz3epH/0isYLGw1E8U/5/RbAFvAMtN
         ZBnCZyjs/uHctYBq8ufBOWtrL7VauJO8kH4R2bsx0mwpwcs0NlK8RMLbrp157AWICqGv
         SCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=zAQkArDS+4aRupi+B9Mmq79J3yEX/UfiqTsi4hHje4k=;
        b=g/Dxt6yYukcYnz2ru7Q1RUO0l2peiYnu1S/j91w93qODaME0lPw7H1yM6QOapflijo
         +bz+0vZrrv9bGI956cAUVrX9xEMxStq9Ha9wtapZBiXzGL2/6GIsXf3blORSujoMd/SL
         2QX7BwGziyFTK80LNCsMvdIp+fp1i/dCwS/AWAkxE8b1hb05RSmjz1bbEcyM8bnTdeRT
         tIKerWp+AQQYl2idDakT6JBiPJWbfd0LjrFXiNJJER/Rc3vxzu+jGuMIE+nFZ+NlcgU9
         varg21RU35z02iqQNts6L1HgzZ74zEG7bEEbsvWpW85gYlKeM4aohZqPE7Hf0ep9mfat
         i6NQ==
X-Gm-Message-State: AG10YORvkX/cPFGgKABEgXCW+iP/8usjHlt1tNyYhM++8SaRSdg2XtJ9W+rY+uq9+cm+rV3ci9Fh846HZfZB1w==
X-Received: by 10.50.61.147 with SMTP id p19mr16011270igr.10.1456252615101;
 Tue, 23 Feb 2016 10:36:55 -0800 (PST)
Received: by 10.36.211.202 with HTTP; Tue, 23 Feb 2016 10:36:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287099>

Hello.

Working with Git for Windows on git gui I noticed an issue on reading
initial message to git gui message prompt.

Steps to reproduce:

  git init .
  echo 'a' > a && git add . && git commit -m 'added A'
  git checkout -b devel
  echo 'b' > b && git add . && git commit -m 'added B (=C4=99=C3=B3=C4=85=
=C5=9B=C5=82=C5=BC=C5=BA=C4=87=C5=84)'
  echo 'bbb' >> b && git add . && git commit -m 'changed B (=C5=BC=C5=BA=
=C4=87=C5=84=C4=85=C5=9B=C5=82=C3=B3=C4=99)'
  git checkout master
  git merge --squash devel

after above commands I run git gui where I get initial message with
invalid encoding. I described it more widely on github:
https://github.com/git-for-windows/git/issues/664#issuecomment-18766407=
2.

I prepared a fix on https://github.com/git-for-windows/git/pull/665.
Before I send a patch based on git://repo.or.cz/git-gui.git may I ask
you to review my changes? I also attach them to this message below.

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 1834f00..5771973 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1599,11 +1599,13 @@ proc run_prepare_commit_msg_hook {} {
  if {[file isfile [gitdir MERGE_MSG]]} {
  set pcm_source "merge"
  set fd_mm [open [gitdir MERGE_MSG] r]
+ fconfigure $fd_mm -encoding utf-8
  puts -nonewline $fd_pcm [read $fd_mm]
  close $fd_mm
  } elseif {[file isfile [gitdir SQUASH_MSG]]} {
  set pcm_source "squash"
  set fd_sm [open [gitdir SQUASH_MSG] r]
+ fconfigure $fd_sm -encoding utf-8
  puts -nonewline $fd_pcm [read $fd_sm]
  close $fd_sm
  } else {

---
Yours sincerely,
Jarek Z.
