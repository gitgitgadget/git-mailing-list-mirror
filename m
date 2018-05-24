Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004A31F42D
	for <e@80x24.org>; Thu, 24 May 2018 21:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971542AbeEXVLU (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 17:11:20 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:44582 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967133AbeEXVLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 17:11:19 -0400
Received: by mail-qt0-f177.google.com with SMTP id d3-v6so3948666qtp.11
        for <git@vger.kernel.org>; Thu, 24 May 2018 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ri2aiHKiS4aFZw77Dfjq7ESFLFRAc/DvtapWM3gRtiI=;
        b=WGCOxVg411XvcW8YliB1+c4ESs66dzmwTIAlamb8u+gFNP9WbM0eb8h6QyDEdZlJGQ
         +EmFcy4gdKOiUvv8bGhjeP+nCP2lagWPabAiWvmz37J6tUq0vGa/RUK1eZTl8UEF8Pl5
         v+FQwPVti5VabQcV98GG5JCchofxgO/ue9j68kB9DTDcqWPVM7sgI4ZVggiTFT3KT0+j
         R2CLKi/oGYDEBo/hld29cH4qINoGG21+ePx7jSHerrnY3JxOD3qpyBdAN6vOvS0DQ16y
         v0L/xzkR4CuphejxckjYVyYxhLlbz3RjGPyQfQ6e0NfN6Emn3mh4nt+CbbzZC24zyj3s
         SYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ri2aiHKiS4aFZw77Dfjq7ESFLFRAc/DvtapWM3gRtiI=;
        b=b+nWzcIxkoh3HZdxzE+BHKq7INh9AdFDwvWfYTIE52wy0Af/2CdIz1eC67OYdnrLiY
         UO0dZEJab1JtSbjsh4nVD+MOz0mKAHNfuqTHjBMM3Lu540u9BmQQdfu5/dYrKs2BOsoQ
         ykdRezMzCz5vLG0pb31cnT1I1xLvfancnon9NSZPl4Jv9xswzAE1hLx4YFAMZuFIWge2
         6UqSDJ8xRpirBgMpW1B15CAxx5twKDt/LKJNDneM8eLutQk9rp0q84quVEwD30DySC+7
         t3lqcXGZ543Ypve0/7iVTu337Ms2jxT/9Svl8RwqcoKLdUuU9YxmyfAJkcdgf+tSA3ds
         4w/A==
X-Gm-Message-State: ALKqPwfWMAf4tuuywWyLk5DjrAG5jo6QEOcwWBOBqIkv3yxBhxxD7FLH
        vLgSIABhUbt7dmdf/EvI50E6nHasYI1IUdHMU06MKDjb
X-Google-Smtp-Source: ADUXVKKRRjdfuzG0pPCwgYmgUP6P3SDws05xapRlU9CWFrBDanMZB6wm4wxHva5/oz1j8HoPwtPOsJtai4YRbLLuLJw=
X-Received: by 2002:ac8:2c01:: with SMTP id d1-v6mr9279887qta.125.1527196278484;
 Thu, 24 May 2018 14:11:18 -0700 (PDT)
MIME-Version: 1.0
From:   "Etienne d'Hautefeuille" <sagoum.kakoum@gmail.com>
Date:   Thu, 24 May 2018 23:11:07 +0200
Message-ID: <CAFazEUP5QJ+WzTkDK6qcgvW5Xwx79KYJWeb1vg41=pS8E8vypQ@mail.gmail.com>
Subject: git difftool with symlink to readonly jar failed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In my repo, I have some symlink to readonly jar, I can't make difftool
between 2 commit

Steps to reproduce :

> git --version
     git version 2.17.0

> id
uid=3D1000(sagoum) gid=3D1000(sagoum)
groupes=3D1000(sagoum),5(tty),10(wheel),14(uucp),18(audio),20(dialout),27(v=
ideo),35(games),78(kvm),85(usb),100(users),104(plugdev),992(android),993(do=
cker),997(vboxusers)



# readonly jar
> ls -l /home/tempogit/jenkins_war
total 510012
-rwxr----- 1 root users 74585998 24 mai   21:08 jenkins-2.110.war
-rwxr----- 1 root users 74612387 24 mai   21:08 jenkins-2.114.war
-rwxr----- 1 root users 74606954 24 mai   21:08 jenkins-2.116.war
-rwxr----- 1 root users 74737297 24 mai   21:08 jenkins-2.121.war
-rwxr----- 1 root users 74525235 24 mai   21:08 jenkins-LTS-2.107.1.war
-rwxr----- 1 root users 74568464 24 mai   21:08 jenkins-LTS-2.107.2.war
-rwxr----- 1 root users 74576216 24 mai   21:08 jenkins-LTS-2.107.3.war


#create a repo with symlink to this jar

mkdir ~/tempo_2.17.0
cd  ~/tempo_2.17.0
git init
ln -s /home/tempogit/jenkins_war/jenkins-2.110.war jenkins.war
git add jenkins.war
git commit -a -m " add symlink on jenkins-2.110.war"

rm jenkins.war
ln -s /home/tempogit/jenkins_war/jenkins-2.114.war jenkins.war
git add jenkins.war
git commit -a -m " add symlink on jenkins-2.114.war"

rm jenkins.war
ln -s /home/tempogit/jenkins_war/jenkins-2.116.war jenkins.war
git add jenkins.war
git commit -a -m " add symlink on jenkins-2.116.war"


#detail of the repo
git log
commit ac1bc44d899ffd5406a7b0c413cf6c2e3497d496 (HEAD -> master)
Author: kakoum <sagoum.kakoum@gmail.com>
Date:   Thu May 24 22:47:09 2018 +0200

      add symlink on jenkins-2.116.war

commit 0244799661b993b1f78fa5afb621de3fe4c4a39c
Author: kakoum <sagoum.kakoum@gmail.com>
Date:   Thu May 24 22:47:09 2018 +0200

      add symlink on jenkins-2.114.war

commit 4cb98b4a307ce97d9e6b8e4b03211fa5ca8af7e7
Author: kakoum <sagoum.kakoum@gmail.com>
Date:   Thu May 24 22:47:09 2018 +0200

      add symlink on jenkins-2.110.war



#try  a diff
git difftool --dir-diff 4cb98b4a307ce97d9e6b8e4b03211fa5ca8af7e7
0244799661b993b1f78fa5afb621de3fe4c4a39c
fatal: impossible d'ouvrir '/tmp/git-difftool.UQ4mqo/left/jenkins.war' en
=C3=A9criture: Permission non accord=C3=A9e

#temporary file
  find /tmp/git-difftool.UQ4mqo/ -ls
    412444      0 drwx------   4  sagoum sagoum       80 mai 24 22:48
/tmp/git-difftool.UQ4mqo/
    412446      0 drwx------   2  sagoum sagoum       40 mai 24 22:48
/tmp/git-difftool.UQ4mqo/right
    412445      0 drwx------   2  sagoum sagoum       60 mai 24 22:48
/tmp/git-difftool.UQ4mqo/left
    412449      0 lrwxrwxrwx   1  sagoum sagoum       44 mai 24 22:48
/tmp/git-difftool.UQ4mqo/left/jenkins.war ->
/home/tempogit/jenkins_war/jenkins-2.110.war

# I have no problem to launch a bcompare between
/tmp/git-difftool.UQ4mqo/left and /tmp/git-difftool.UQ4mqo/right (which is
empty)

Thank
