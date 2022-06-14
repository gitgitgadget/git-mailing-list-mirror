Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45347C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 11:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiFNL3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbiFNL3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 07:29:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560563EBA9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 04:29:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so6838679pjl.5
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dL0Lvv9k4w0KanLzmawwZldT1dXyzaf+YotmmC+dd0s=;
        b=lk8bdIiv6In3+PY6wT85psnllUVn9gM994GfSmWqYcOw50x4dcQi1JPwOAXFoNBo/6
         lcSwsrNp01dmnU8QTXO+bgMCt5/6fMsQ5gTGaBXrKpqhsDWlRLT73dTeccfOcg8u2/fy
         yTJzqLpDd2Fv7MWlAK9BHmdb7tCcaHjM+HyfNj2l7jW+elITc0Yc7eJc0nqm9F2yf2FC
         fVsiD0XIsm3Zp3Uc5BFDj5cjhL/gllIv1L1/aVIl67rbcY5jo5Ds2pLFpGfQSkDeP46j
         gpKRaAsSpbGKHgYyagl0YDC5Kh6POFkHGRmTPlOCfZr5VTeZVkEyi6ZkUdPzeMfxHYSp
         kM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dL0Lvv9k4w0KanLzmawwZldT1dXyzaf+YotmmC+dd0s=;
        b=AjY9ZyfXzwCSpLLOGHJh5VW3UyYMX2HpTOURu416XQcDmhNV9yL7nThgc9H6qb8d4X
         Dgrd/SATzIM8TtAnXT9zF4/IOFHnb3KemQH+pna3rDcuaECgLPd2wPHqB/Bm4wFy8ybC
         JGM85e2rQKHjvLyMBnypRuyuHzR9BUYUhMeims3GzKqNzzGu5N6iNq+DbzVi6dQK/fCN
         RRBXxQVOGgxkng5Y4IfQ/PofeRZBngRdIritKw6cMhde5+1+OBpuM50KJSl5KqvE9wzM
         sakzx7EzK2ic+jE1jvFZ/TiT/PG9XmA6inGkFiBb74enKuaTyrLhNY3EGu7tkB15DANu
         rH/Q==
X-Gm-Message-State: AOAM530T8ITMvYvvrJP/V+71BdMyyoj5D0cf3daGgDIb2bdanPs4vFU3
        wcwL3K9sJsSMhgcjUmrntRc=
X-Google-Smtp-Source: AGRyM1v8BUYRliYPY744J0iSS2KctFWcvgjgy7UTTwteCeacE/meGK0Lrp+2p4tRmzyi09vg0QUEnA==
X-Received: by 2002:a17:902:aa8f:b0:168:b18c:5e16 with SMTP id d15-20020a170902aa8f00b00168b18c5e16mr3899297plr.64.1655206142733;
        Tue, 14 Jun 2022 04:29:02 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a27-20020a637f1b000000b0040898e7e30csm2900211pgd.94.2022.06.14.04.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2022 04:29:02 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git l10n discussion group <git-l10n@googlegroups.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: [L10N] Kickoff for Git 2.37.0 round #1
Date:   Tue, 14 Jun 2022 19:28:58 +0800
Message-Id: <20220614112858.16576-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.37.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 92 updated messages need to be translated
since last release. Please send your pull request to the l10n coordinator's
repository below before this update window closes on Sun, June 26, 2022. 

    https://github.com/git-l10n/git-po/

As of git 2.37, we (git l10n contributors) have a new l10n workflow. The
following description of the new l10n workflow is from the "po/README.md"
file.


## The "po/git.pot" file is a generated file, no longer in the repository

The l10n coordinator does not need to generate the "po/git.pot" file every
time to start a new l10n workflow, and there is no "po/git.pot" file at all.

Everyone can generate the "po/git.pot" file with the command below:

    make po/git.pot

But we can also forget about it. By updating our corresponding "po/XX.po"
file, the "po/git.pot" file is automatically generated.


## Update the "po/XX.po" file, and start to translate

Before updating the "po/XX.po" file, l10n contributors should pull the latest
commits from the master branch of "git.git". E.g.:

    git pull --rebase git@github.com:git/git.git master

Then update the cooresponding "po/XX.po" file using the following command:

    make po-update PO_FILE=po/XX.po

Translate the uptodate "po/XX.po" file, and create a new commit.


## Refine your commits, send pull requests

In the "po/XX.po" file, there are location lines in comments like below:

    #: add-interactive.c:535 add-interactive.c:836 reset.c:136 sequencer.c:3505
    #: sequencer.c:3970 sequencer.c:4127 builtin/rebase.c:1261
    #: builtin/rebase.c:1671

These comments with file locations are useful for l10n contributors to locate
the context easily during translation. But these file locations introduce a
lot of noise and will consume a lot of repository storage. Therefore, we
should remove these file locations from the "po/XX.po" file.

To remove file locations in the "po/XX.po" file, you can use one of the
following two ways, but don't switch back and forth.

 * Keep the filenames, only remove locations (need gettext 0.19 and above):

        msgcat --add-location=file po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

 * Remove both filenames and locations:

        msgcat --no-location po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

After squashing trivial commits and removing file locations in the "po/XX.po"
file, send pull request to the l10n coordinator's repository below:

    https://github.com/git-l10n/git-po/


## Resolve errors found by the l10n CI pipeline for the pull request

A helper program hosted on "https://github.com/git-l10n/git-po-helper" can
help git l10n coordinator and git l10n contributors to check the conventions
of git l10n contributions, and it is also used in GitHub actions as l10n CI
pipeline to validate each pull request in the "git-l10n/git-po" repository.
Please fix the issues found by the helper program.


** Please note: The update window will close on Sun, June 26, 2022. **


--
Jiang Xin
