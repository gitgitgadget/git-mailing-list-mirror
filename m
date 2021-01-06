Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2558C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B4A23142
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAFXIi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 6 Jan 2021 18:08:38 -0500
Received: from elephants.elehost.com ([216.66.27.132]:41765 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAFXIi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 18:08:38 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 106N7ol7010209
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Jan 2021 18:07:51 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Daniel Troger'" <random_n0body@icloud.com>,
        "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
Cc:     <git@vger.kernel.org>
References: <20210106214737.qwlp4jvg3x2voafs@tb-raspi4> <A342FAE0-A363-4280-848C-162F38C22C8E@icloud.com>
In-Reply-To: <A342FAE0-A363-4280-848C-162F38C22C8E@icloud.com>
Subject: RE: git-bugreport-2021-01-06-1209.txt (git can't deal with special characters)
Date:   Wed, 6 Jan 2021 18:07:44 -0500
Message-ID: <002601d6e480$c193bd00$44bb3700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHDe6GxGwoXxNqqXXZLzD6v+OK7mwGvpJIPqjSMSoA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 6, 2021 5:22 PM, Daniel Troger wrote:
> Hi, maybe this helps you reproduce. I think I should have committed before
> doing the second changes but I still got the error message and the two
> names for one folder:
> 
> me@iMac:/tmp$ mkdir git_bug
> me@iMac:/tmp$ cd git_bug
> me@iMac:/tmp/git_bug$ git init
> hint: Using 'master' as the name for the initial branch. This default branch
> name
> hint: is subject to change. To configure the initial branch name to use in all
> hint: of your new repositories, which will suppress this warning, call:
> hint:
> hint: 	git config --global init.defaultBranch <name>
> hint:
> hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
> hint: 'development'. The just-created branch can be renamed via this
> command:
> hint:
> hint: 	git branch -m <name>
> Initialized empty Git repository in /private/tmp/git_bug/.git/
> me@iMac:/tmp/git_bug$ ls -la total 8
> drwxr-xr-x   4 daniel  wheel   128 Jan  6 23:13 .
> drwxrwxrwt  27 root    wheel   864 Jan  6 23:13 ..
> drwxr-xr-x   9 daniel  wheel   288 Jan  6 23:12 .git
> -rw-r--r--@  1 daniel  staff  1283 Jan  6 23:13 paulbrunngård-springyard.zip
> me@iMac:/tmp/git_bug$ unzip paulbrunngård-springyard.zip
> Archive:  paulbrunngård-springyard.zip
>    creating: paulbrunnga??rd-springyard/
>   inflating: paulbrunnga??rd-springyard/.DS_Store
>    creating: __MACOSX/
>    creating: __MACOSX/paulbrunnga??rd-springyard/
>   inflating: __MACOSX/paulbrunnga??rd-springyard/._.DS_Store
>  extracting: paulbrunnga??rd-springyard/empty me@iMac:/tmp/git_bug$ rm
> -rf __MACOSX/ *.zip me@iMac:/tmp/git_bug$ ls -la total 0
> drwxr-xr-x   4 daniel  wheel  128 Jan  6 23:15 .
> drwxrwxrwt  27 root    wheel  864 Jan  6 23:13 ..
> drwxr-xr-x   9 daniel  wheel  288 Jan  6 23:15 .git
> drwxr-xr-x@  4 daniel  wheel  128 Jan  6 12:20 paulbrunngård-springyard
> me@iMac:/tmp/git_bug$ cd paulbrunngård-springyard/
> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ nano empty
> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cat empty Initial
> content me@iMac:/tmp/git_bug/paulbrunngård-springyard$ git add empty
> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ nano empty
> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cat empty Initial
> content
> 
> 
> Line I want to keep
> 
> Line I want gone
> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ git restore -p .
> BUG: pathspec.c:495: error initializing pathspec_item Cannot close git diff-
> index --cached --numstat --summary
> 4b825dc642cb6eb9a060e54bf8d69288fbee4904 --
> :(,prefix:27)paulbrunngård-springyard/ () at
> /usr/local/Cellar/git/2.30.0/libexec/git-core/git-add--interactive line 183.
> me@iMac:/tmp/git_bug/paulbrunngård-springyard$ cd ..
> me@iMac:/tmp/git_bug$ git status
> On branch master
> 
> No commits yet
> 
> Changes to be committed:
>   (use "git rm --cached <file>..." to unstage)
> 	new file:   "paulbrunnga\314\212rd-springyard/empty"
> 
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
> 	modified:   "paulbrunnga\314\212rd-springyard/empty"
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	.DS_Store
> 	"paulbrunng\303\245rd-springyard/"
> 
> me@iMac:/tmp/git_bug$

Is it possible that the å character is coming from a UTF-16 encoding and is not representable in UTF-8? I'm wondering whether the name has a double-byte representation where one of the bytes is null, resulting in a truncated file name coming from readdir(). The file name would not be representable on some platforms that do not support UTF-16 path names.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



