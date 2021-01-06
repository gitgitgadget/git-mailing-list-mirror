Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8EBC433E9
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C4822BEA
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbhAFWW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:22:56 -0500
Received: from pv50p00im-hyfv10021501.me.com ([17.58.6.48]:49373 "EHLO
        pv50p00im-hyfv10021501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727721AbhAFWW4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jan 2021 17:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1609971720;
        bh=b6WRWKeM3mpa3r7YT6D7wdSMKuSRDuTW6DIBCwqL2iM=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=ubiZH1WEfvvFBlCb6clHSN3dnFClSlLFUIL/BpIQkGrx33vikufcbXqTpHLSMzNvK
         d7+5omXCnmsVabh1kbldxZRIHaeWaB1iLtnSK8v7qHPjZp5z1F9DiiuNqJZ60H5oZd
         MpIPg8MRyV7TG/JsHdfOV6vaUlFR506re59EE/+VurahytQQfV6wQJpYWCf5utGV9S
         +CFx4WI1SmRhXH2deg4hO7nYeDQceKoWCf0pKvUx7IoSh+sqAOhyUOcnrMIJG6SqT2
         WypfquwJ++R8ZQu4IEG5vnzuLBSLpjLUdEAVKyUualaSfhKqHjlS1w+4DN+CZLlu9h
         DuBYnHmC2t4Dw==
Received: from [192.168.1.114] (unknown [90.129.214.206])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id D3F4AB40571;
        Wed,  6 Jan 2021 22:21:59 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Daniel Troger <random_n0body@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special characters)
Date:   Wed, 6 Jan 2021 23:21:54 +0100
Message-Id: <A342FAE0-A363-4280-848C-162F38C22C8E@icloud.com>
References: <20210106214737.qwlp4jvg3x2voafs@tb-raspi4>
Cc:     git@vger.kernel.org
In-Reply-To: <20210106214737.qwlp4jvg3x2voafs@tb-raspi4>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: iPad Mail (17F75)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_12:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101060125
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, maybe this helps you reproduce. I think I should have committed before d=
oing the second changes but I still got the error message and the two names f=
or one folder:

me@iMac:/tmp$ mkdir git_bug
me@iMac:/tmp$ cd git_bug
me@iMac:/tmp/git_bug$ git init
hint: Using 'master' as the name for the initial branch. This default branch=
 name
hint: is subject to change. To configure the initial branch name to use in a=
ll
hint: of your new repositories, which will suppress this warning, call:
hint:=20
hint: 	git config --global init.defaultBranch <name>
hint:=20
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command=
:
hint:=20
hint: 	git branch -m <name>
Initialized empty Git repository in /private/tmp/git_bug/.git/
me@iMac:/tmp/git_bug$ ls -la
total 8
drwxr-xr-x   4 daniel  wheel   128 Jan  6 23:13 .
drwxrwxrwt  27 root    wheel   864 Jan  6 23:13 ..
drwxr-xr-x   9 daniel  wheel   288 Jan  6 23:12 .git
-rw-r--r--@  1 daniel  staff  1283 Jan  6 23:13 paulbrunng=C3=A5rd-springyar=
d.zip
me@iMac:/tmp/git_bug$ unzip paulbrunng=C3=A5rd-springyard.zip=20
Archive:  paulbrunng=C3=A5rd-springyard.zip
   creating: paulbrunnga??rd-springyard/
  inflating: paulbrunnga??rd-springyard/.DS_Store =20
   creating: __MACOSX/
   creating: __MACOSX/paulbrunnga??rd-springyard/
  inflating: __MACOSX/paulbrunnga??rd-springyard/._.DS_Store =20
 extracting: paulbrunnga??rd-springyard/empty =20
me@iMac:/tmp/git_bug$ rm -rf __MACOSX/ *.zip
me@iMac:/tmp/git_bug$ ls -la
total 0
drwxr-xr-x   4 daniel  wheel  128 Jan  6 23:15 .
drwxrwxrwt  27 root    wheel  864 Jan  6 23:13 ..
drwxr-xr-x   9 daniel  wheel  288 Jan  6 23:15 .git
drwxr-xr-x@  4 daniel  wheel  128 Jan  6 12:20 paulbrunng=C3=A5rd-springyard=

me@iMac:/tmp/git_bug$ cd paulbrunng=C3=A5rd-springyard/
me@iMac:/tmp/git_bug/paulbrunng=C3=A5rd-springyard$ nano empty=20
me@iMac:/tmp/git_bug/paulbrunng=C3=A5rd-springyard$ cat empty=20
Initial content
me@iMac:/tmp/git_bug/paulbrunng=C3=A5rd-springyard$ git add empty=20
me@iMac:/tmp/git_bug/paulbrunng=C3=A5rd-springyard$ nano empty=20
me@iMac:/tmp/git_bug/paulbrunng=C3=A5rd-springyard$ cat empty=20
Initial content


Line I want to keep

Line I want gone
me@iMac:/tmp/git_bug/paulbrunng=C3=A5rd-springyard$ git restore -p .
BUG: pathspec.c:495: error initializing pathspec_item
Cannot close git diff-index --cached --numstat --summary 4b825dc642cb6eb9a06=
0e54bf8d69288fbee4904 -- :(,prefix:27)paulbrunng=C3=A5rd-springyard/ () at /=
usr/local/Cellar/git/2.30.0/libexec/git-core/git-add--interactive line 183.
me@iMac:/tmp/git_bug/paulbrunng=C3=A5rd-springyard$ cd ..
me@iMac:/tmp/git_bug$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   "paulbrunnga\314\212rd-springyard/empty"

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   "paulbrunnga\314\212rd-springyard/empty"

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.DS_Store
	"paulbrunng\303\245rd-springyard/"

me@iMac:/tmp/git_bug$=20

