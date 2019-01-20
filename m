Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803871F453
	for <e@80x24.org>; Mon, 21 Jan 2019 08:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfAUI2b (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 03:28:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41705 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfAUI2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 03:28:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so9781481pfi.8
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 00:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=keioi2CmF3UZ/vmNozImCAUT4sH/x8kkmLX0cJMGGxQ=;
        b=fQ0DtcxE3Ksq/hn9QTf6JS4NvjGqcK6fvwACcUUTO9fFlW6wANcpQy9t10cPdVDLCO
         kMX8dKpgqQyYj2JfzgMWzck8l7e7rbIYozAw9XUlagEDU72PDkRd3yWUril2Ck0PDfiQ
         D+YguXeaVmERNMF/RDfqIWzneIhtgYKVRJAj7+0nhkc6I+72LnOVSTpr7qZm7+aFvLL2
         EDSsc1JhjKxk9xaA6PSE58tjTu08iBEXb+HvI6udSB/5C9c+eHhCE/PAaRDMl74e9maj
         jluCbD4YnHfajlop+ePw4nhrocx9pkmmPtv9z3Nwo9C430KNtQ8W20gEc/v6+7OLgE26
         gl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=keioi2CmF3UZ/vmNozImCAUT4sH/x8kkmLX0cJMGGxQ=;
        b=qpivq0Pi7wTGkplQqBJUX6oh6qBA3o3lbA95qYUeq0VH4Tfoj84CM0KzjiKaUzLVV0
         47z2+PQbaYmtjD1sc+jcTYzaGwtGRg7zVeUzCbyw60Bcypfmgwwl2wyN6f8YnkeCwbed
         46wL1cFBLEnwMtksYrpEXn/FMtCKLD+H+q09BcHTFsB1DnuYtOTwlCVLtMCLAzewATHH
         eCM/fr3GJlIW8r0vu9xyUvUZVf1kdKcgRkGFlEUISdaBseXMkEsvAI2vptv0NxRoKtOx
         1zkY+EH8xwJlORL2fnSyQ9VlTOP8PD6izBbnJeMSWJ6JdQfh4bidKzQBQ94iyEmslZE3
         5XFA==
X-Gm-Message-State: AJcUukddr6lpTqMrbMyQyWkD9PEjgr0joBkIqd6LwpTHSn9Ru+YYFtEi
        6S+Dj0l56rDh7MwCLQDPu0tXTzGM37w=
X-Google-Smtp-Source: ALg8bN4/IBEObeRQZfZq27ACozC1chMSNlRJrZ53bRn+9qKhJXuPlV+dx8EeV0PVdAeUwkmRjdOI6Q==
X-Received: by 2002:a63:3287:: with SMTP id y129mr25827996pgy.337.1548019848772;
        Sun, 20 Jan 2019 13:30:48 -0800 (PST)
Received: from lglitch-pc ([27.62.81.101])
        by smtp.googlemail.com with ESMTPSA id e123sm18214608pgc.58.2019.01.20.13.30.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 13:30:47 -0800 (PST)
Message-ID: <d8ef0c1e5f48952c6190672bc26244a02b8e9bcd.camel@gmail.com>
Subject: protocol v2: More data transmitted between client and server since
 v2.20.0
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 21 Jan 2019 03:00:38 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I recently came across a blog[1] about how protocol v2 speeds up the
transfer between the client and the server. It states that the amount
of data transmitted between the client and the server is less when
using the protocol v2.

To demonstrate the difference between v0 and v2 two commands were
mentioned in the blog. The results hold true for me when I test using
Git v2.18.1. The commands given there worked as mentioned in the blog
until Git v2.18.1. But when I run the same commands using Git v2.19.2
or the one I built from source in the 'next' branch (at aa96b0ce6b).
I'm not sure why this is the case. Some observations below:

Protocol v0
===========
# Git version: 2.18.1
$ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote git@gitlab.com:gitlab-org/gitlab-ce.git master 2>git_protocol_0_git_2.18.1_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13	refs/heads/master

$ wc -l git_protocol_0_git_2.18.1_stderr.txt
36848 git_protocol_0_git_2.18.1_stderr.txt


# Git version: 2.19.0
$ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote git@gitlab.com:gitlab-org/gitlab-ce.git master 2>git_protocol_0_git_2.19.0_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13	refs/heads/master

$ wc -l git_protocol_0_git_2.19.0_stderr.txt 
36848 git_protocol_0_git_2.19.0_stderr.txt


# Git version: 2.20.0
$ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote git@gitlab.com:gitlab-org/gitlab-ce.git master 2>git_protocol_0_git_2.20.0_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13	refs/heads/master

$ wc -l git_protocol_0_git_2.20.0_stderr.txt 
36848 git_protocol_0_git_2.20.0_stderr.txt


# Git version: 2.20.1.495.gaa96b0ce6b
$ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote git@gitlab.com:gitlab-org/gitlab-ce.git master 2>git_protocol_0_git_2.20.1-source_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13	refs/heads/master

$ wc -l git_protocol_0_git_2.20.1-source_stderr.txt 
36848 git_protocol_0_git_2.20.1-source_stderr.txt 


Protocol v2
===========
# Git version: 2.18.1
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote git@gitlab.com:gitlab-org/gitlab-ce.git master 2>git_protocol_2_git_2.18.1_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13	refs/heads/master

$ wc -l git_protocol_2_git_2.18.1_stderr.txt
22 git_protocol_2_git_2.18.1_stderr.txt


# Git version: 2.19.0
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote git@gitlab.com:gitlab-org/gitlab-ce.git master 2>git_protocol_2_git_2.19.0_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13	refs/heads/master

$ wc -l
22 git_protocol_2_git_2.19.0_stderr.txt


# Git version: 2.20.0
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote git@gitlab.com:gitlab-org/gitlab-ce.git master 2>git_protocol_2_git_2.20.0_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13	refs/heads/master
04845fdeae75ba5de7c93992a5d55663edf647e0	refs/remotes/remote_mirror_630f74462b3b08a952486da866d5e702/master
04845fdeae75ba5de7c93992a5d55663edf647e0	refs/remotes/remote_mirror_655ad545056a2ad17e7ebc5461a986e4/master
d4d4ebadfb373518013382560b1f505eb6217f13	refs/remotes/remote_mirror_d612bbe5bee4fbc624df371bc7caa759/master

$ wc -l git_protocol_2_git_2.20.0_stderr.txt 
160971 git_protocol_2_git_2.20.0_stderr.txt


# Git version: 2.20.1.495.gaa96b0ce6b
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote git@gitlab.com:gitlab-org/gitlab-ce.git master 2>git_protocol_2_git_2.20.1-source_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13	refs/heads/master
04845fdeae75ba5de7c93992a5d55663edf647e0	refs/remotes/remote_mirror_630f74462b3b08a952486da866d5e702/master
04845fdeae75ba5de7c93992a5d55663edf647e0	refs/remotes/remote_mirror_655ad545056a2ad17e7ebc5461a986e4/master
d4d4ebadfb373518013382560b1f505eb6217f13	refs/remotes/remote_mirror_d612bbe5bee4fbc624df371bc7caa759/master

$ wc -l git_protocol_2_git_2.20.1-source_stderr.txt
160971 git_protocol_2_git_2.20.1-source_stderr.txt


Also, note that there are more refs printed when using v2 which is
spooky too. I thought of running a bisect to find the actual culprit
but wanted to know if this was *actually* an issue or not? Any
thoughts?


References
==========
[1]: 
https://about.gitlab.com/2018/12/10/git-protocol-v2-enabled-for-ssh-on-gitlab-dot-com/

--
Sivaraam

