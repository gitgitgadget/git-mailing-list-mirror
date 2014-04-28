From: Gergely Polonkai <gergely@polonkai.eu>
Subject: git-svn: Out of memory while cloning large (cca. 48000 commits) SVN repo
Date: Mon, 28 Apr 2014 23:26:34 +0200
Message-ID: <CACczBUL0N0D2rqwQ0p=that4ejN-aa-er_DTJvJVh-hax5mxmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 23:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wet4l-0005dN-Gt
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 23:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbaD1V0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 17:26:55 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:36282 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaD1V0z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 17:26:55 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so8614273veb.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 14:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=c7fJdX+TvthKUDoyzcg9yQhjK8ieuccuNoWyBiXRAxA=;
        b=Bdui8B00dMQRXGkqzng90OFhu6nBw/El7LeckjHvzMQCiRpa5CrGEb74TieLSgmMpV
         2fvUnkepSnN87AdqQdUgCt/5beZgvLS4lLGiE7bE2Vxo4BsaxcGR1EVaijjThDGAPvZj
         z3UGVvp7moLuiyG8mkkMtLfgLB1HpfMPHfaF7vveZrhimYmv40dSlK8fRSabZLJ5s61O
         Xg4l1KaXdOvYjOueUdosI/ylDIcFvNoo7x0QRGhlkle8hhr2pAtpJ1dtKIcF12YcVrpF
         uxgCOogp2eBD4Hed/EgurTakR5voE+iu2poaJBnNJX0tGGCyVh1gafsNYDJ8YoGojO4h
         P50g==
X-Gm-Message-State: ALoCoQl+7v3N1wBtgZ3pjEwvkM7Xx78YE9x9/whVF2xVrJIxaewSydyzF3ueF69E0sF+X96W1Lkv
X-Received: by 10.58.77.238 with SMTP id v14mr3773460vew.27.1398720414275;
 Mon, 28 Apr 2014 14:26:54 -0700 (PDT)
Received: by 10.221.65.2 with HTTP; Mon, 28 Apr 2014 14:26:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247455>

Hello,

I=E2=80=99m trying to clone an SVN repository with around 48000 revisio=
ns,
several branches and tags (svn://svn.zabbix.com). After a few
thousands commits, Git failed (complaining something about sed, I
haven=E2=80=99t wrote that down), so I svnrdumped the whole repository =
onto my
filesystem.

After that, I used this command:

git svn clone -s --prefix=3Dorigin/ file://`pwd`/zabbix-svn zabbix-git/

to dump all the repo into a new Git repository. It ran for around 24
hours to report an Out of memory error at the end. Although I realised
since then that this was a somewhat bad idea, I still don=E2=80=99t thi=
nk
it should happen this way. Or should it?

Best,
Gergely
