Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_FM_MR_MRS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1561C20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbeLNVEx (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:04:53 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38637 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVEx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:04:53 -0500
Received: by mail-yb1-f193.google.com with SMTP id d187so2826893ybb.5
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tNJwzyBYom4DnLhYBWlwPH3Xj//PAqbUZ7IPT2nuCV4=;
        b=hoe3WhPEDIzUPHDyhf5Ya3uWiHQuKEfR1arHvcNdzLh7Rr6/hXEplgyTpgKzOP5jEF
         h/XbVygRdp5Pqb5mhVocl+/S1ULoKF20t61GFPsuJMrXcC6bEg0KMjxaZKIUkKj9IjVC
         2rFazaFfRLDJuC+8/dY3MWdsX3LFlFTdCnRJRsPz4E0P38k89lKdvAZCcjbXrvbCRlPE
         QxtYbSdgfGXp0EbWLycHXufT19OfwcbfAhY/SjVTkvR+nGSwWbvUbxscyDputGfL8+to
         kHy2jgooX+CT954h5Ob8a7UWUZK4842puGgzZZ9O6k5P7JIg65x04cB2LAqqyc3V6jhx
         E+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tNJwzyBYom4DnLhYBWlwPH3Xj//PAqbUZ7IPT2nuCV4=;
        b=fTm4DMgdZ5byKuOSj1MYaC9OE0E04FaPzsTU0KFXc/5x6kTjZ0VbzI864iMapi4DF6
         rcIzgwBe5R4XQjcEgZc0CSd2KZoO74mk8vQwvb3FzSrTxHJHvt/+n5epBlhjRBc24Gv8
         aQYekWjU8WHWEf4iAKv3+JyIVS4x9FvgaMzs/1QTEz0jzldahTYkrDyoDgBOq5ZmC4Nn
         DOvYqzxZYp4Q6XX0om2goViXiGOZhLooDFGDHYEU+HT2CSn3PineGmVhHqOgyVYlxQlP
         huHwLQfqMWJiAfxyR34wqjWnXt5YU9H77bOR6XtUuwSIl50U+WBgYHikh0z7Fj2cho/w
         WxWQ==
X-Gm-Message-State: AA+aEWYyAbz6udJim/gDMZ6lJgMDqkrs9q/lSl+A0vXIsvdTYq9hXf1F
        svUgaOxM98tVce4vKEDUX2QUO2vh+doYfBPwOPUe89zk
X-Google-Smtp-Source: AFSGD/UIxFZEBQYIQT2MscueDb4d9+qPDknfFxKeeCmTNdDL/4Rb9yTjYcHsqv6H0IOT63w9bnbDP3sF93wednXTqEQ=
X-Received: by 2002:a25:185:: with SMTP id 127mr4688850ybb.41.1544821492117;
 Fri, 14 Dec 2018 13:04:52 -0800 (PST)
MIME-Version: 1.0
From:   "Mr&Mrs D" <the.ubik@gmail.com>
Date:   Fri, 14 Dec 2018 16:04:15 -0500
Message-ID: <CABRG_PEy9H7za9cTdXMvFB37GfDvpBvsDDoLZ5-Bpm=9NWzLiw@mail.gmail.com>
Subject: Bug in lineendings handling that prevents resetting checking out,
 rebasing etc
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I maintain a python project you can clone from:

git@github.com:wrye-bash/wrye-bash.git

For reasons unknown git sees a particular file as changed
(Mopy/Docs/Bash Readme Template.html, sometimes others too). This file
was probably committed to the svn repository this git repo was created
from with CRLF line endings. When we moved to git we added a
gitattributes file (
https://github.com/wrye-bash/wrye-bash/blob/dev/.gitattributes ) and
this file was edited to explicitly state htms are text - all to no
avail. From time to time - on windows - as in when checking out an old
commit - git would see that file as changed. The only workaround that
worked for me was

    git rm -r . --cached -q && git reset --hard

For more details and discussion see this SO question I posted almost
five years ago:

https://stackoverflow.com/questions/21122094/git-line-endings-cant-stash-re=
set-and-now-cant-rebase-over-spurious-line-en

I used to work in windows and the bug was tolerable as there was that
workaround. Now I moved to mac and no workaround works anymore - we
have a special page on our wiki  with workarounds for this one btw:

https://github.com/wrye-bash/wrye-bash/wiki/%5Bgit%5D-Issues-with-line-endi=
ngs-preventing-checking,-merge,-etc

Well after 5 years and countless hours trying to solve this I reach
out to you guys and girls - _this is a full-time bug in git line
endings handling_. When someone issues a git reset --hard this should
work no matter what - well it does not. So this bug may be really a
can of worms.

Please someone clone this repo on linux or mac - probably just cloning
will have the files appear as changed (by the way hitting refresh on
git gui I have different sets of files appear as changed). If not then

git checkout utumno-wip
git rebase -i dev

and then select a commit to edit should be enough to trigger this bug

Needless to say I am  well aware of things like `git add --renormalize
.` - but renormalizing is not the issue. The issue is that _files show
as changed and even a git reset --hard won't convince git that
nothing's changed_.

$ git reset --hard
HEAD is now at e5c16790 Wip proper handling of ini tweaks encoding - TODOs:
$ git status
interactive rebase in progress; onto 02ae6f26
Last commands done (4 commands done):
   pick 3a39a0c0 Monkey patch for undecodable inis:
   pick e5c16790 Wip proper handling of ini tweaks encoding - TODOs:
  (see more in file .git/rebase-merge/done)
Next commands to do (19 remaining commands):
   edit a3a7b237 Amend last commit and linefixes:  =CE=95=CE=95=CE=95=CE=95
   edit 432fd314 fFF handle empty or malformed inis
  (use "git rebase --edit-todo" to view and edit)
You are currently editing a commit while rebasing branch 'utumno-wip'
on '02ae6f26'.
  (use "git commit --amend" to amend the current commit)
  (use "git rebase --continue" once you are satisfied with your changes)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

modified:   Mopy/Docs/Bash Readme Template.html

Untracked files:
  (use "git add <file>..." to include in what will be committed)

.DS_Store
.idea.7z

no changes added to commit (use "git add" and/or "git commit -a")
$

I really hope someone here can debug this
Thanks!
