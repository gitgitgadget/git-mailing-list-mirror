Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E08C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 08:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhKVIpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 03:45:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:45951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhKVIpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 03:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637570558;
        bh=Tun/svUvBMsgdnhO2vv5ivVPh+qA9JW+n8FaXhCsUb8=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=doT4x6+/kj5MtoUeviPHzpro0Q/3VGVZqOFmtqnRkKf15nXFd0Es7FPhHOIBkgMuJ
         Mp6AmSCqcQOU9gZRBAhcJIl5Q17pMlWEjjbQMUsZK+N3RH1a793qZFA6bPoWimORg8
         vlzOnwbiBzJMmBa1l3ZrYNwPEl7KgD6yLC8Wq9gA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mail ([91.59.107.238]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1mUntn3m4g-00thCq; Mon, 22
 Nov 2021 09:42:37 +0100
From:   Alexander Veit <alexander.veit@gmx.net>
Subject: Update to Git 2.34.0 breaks application
To:     git@vger.kernel.org
Cc:     thomas.wolf@paranor.ch
Message-ID: <ee302c98-da27-da43-e684-c7ec8b225360@gmx.net>
Date:   Mon, 22 Nov 2021 09:42:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S2SPzbIM3PDK+y7q7kNL6kO6v4jugFsSCPS6kC197LPjXb/SiYc
 Bzx0c/3P+jIxVswHT+d4Xz+R+goBpOnsiqRlppQoTrKbzMQKgSIjFC3Z94yeo2yX8EhawSt
 3jVlKND7ZdWi9hpbn17ly74OAV91nDHo6tg1W2NsF/GXIi6CstcgGQ/Bkqb1hyhPTpNXfO2
 bfQT0nIoO0zSyvVBe2B6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1rk+j5skjgM=:u7y29tfwEACa2wVIoAO3Co
 mnAJuGQtYQlKaBXmefXCisXyXgCL1oI9Ht9ZHyg8lNqOz9iCRZdXhV5jyIFry1Xz5EtAyEB5w
 5nFhJPk87WLafk4xTDoUUsCtO2tx87oCLeJH5x/MZX973mlXiEhQlJJ0DbKlnqhoOh2pFH+xe
 zr0Gj2/rztj4pO8PXAcHKttfhpZYFmi45fKXRzSoYcku96mBDCIj1xadBqw5v6RDG3fQNKgbb
 fQXK/Zhp6j1bJ+IuatqGF+LehOcAsR9M53cKIGTiaN26f5jp6/dyZjWA+hFf6l9PAa2xkyygo
 aOMykxeWnyZwBpCB1652MTNwE9gfG3VBSLkRB4FUVuVmkoAFFzTY8L5ndjSoqmfG5+1WnY3MT
 zAMN1q9gXu32aaDwflsd8Kt43nmeYg7e2M0nZ54GEq4FV4AQRiPDiqYYoFt8szoEgly+D32VF
 +3jcXvcOR8Ng3QYVfp/vEIdjn4aBRbC5s8ZKsfV9Z7mixDoX3Iz5mKy8HU3XlMWevqpHyRTLD
 Z0KGE7Y8E0hgqb03nXX1PlFSkJgjC2iv/iwmpHf1f/8kdeIA+SH+dW2HKjy7NosmqBOqbypwE
 Pe5e8nPUzDNBqMETfO+/Vu+m95CQ/k+rBJZn+p4nGYThwOioxs4MjmHCgGvv4FLsqQutkbyX1
 q9nqXL12TYJsSxwe+lcaShNwIgK20NXGdAN37EPllnjhR1KAt90vmL2FB8Xu/iI/CeUfcdEJe
 i/lGxQE1q24fLtlqozknPfxcmfh5b0AOcJJcAW3iZGm6oWQnnpnPlWTFwsPd3QhlEEXFWdgaX
 9FbWNEEpF/HmkLzwAFuikuZRoUXq7TTm0mCVMudQReIqzzrbQ653F3+iyvuJb9J5hDABijyYd
 kG+zL88TC8OR49bK7mlA95sNaQShktQNSZfjZJCwjAGt1caG/hXx+dXR9s1BsRw4Dtlls4Sqa
 CUkFpUn6eWx9ZWS6ABZ+ZQ4c8w5ciFjfl6x0yvunAFUofnreNMmf6vEMvYJ/BoWbwN/0rAJde
 ZJx9uTwxhFIrf4hgpX+BJNjZfmn6y6twBu8+8ILa61y8h6JrXAF6oB0+48caX10XohNeWwlKq
 dcN2ImlOVVtVIw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After an update from Git 2.25.1 to 2.34.0 the Java application that uses the Eclipse JGit library freezes.

Strace suggests that the JVM receives a SIGTTOU from the child process "git config --system --edit" created with java.lang.ProcessBuilder.

Upstream[1] has identified 3d411afa[2] as the possible commit that introduced the problem.

The problem does not occur on all Linux systems.


-Alex

Environment:
OS: Linux Mint 20
Kernel: 5.4.0-90-generic
Git 2.34.0 from http://ppa.launchpad.net/git-core/ppa/ubuntu
Java: OpenJDK 64-Bit Server VM AdoptOpenJDK (build 11.0.10+9, mixed mode)


Ref.:
[1] https://bugs.eclipse.org/bugs/show_bug.cgi?id=577358
[2] https://github.com/git/git/commit/3d411afabc9a96f41d47c07d6af6edda3d29ec92#diff-01b59b6a71e42b9c1251ffbf76a1119b965be087a78538e80e01f9239c8e5880
