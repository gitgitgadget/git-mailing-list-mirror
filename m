Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD6C12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 06:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A0C61182
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 06:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhGSG6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhGSG6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 02:58:12 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5546EC061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 23:55:13 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d9so18738887ioo.2
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bTrbU4qhsIclu4qHRn6Srm57oJ3vDUjd2Hic2lcZNm4=;
        b=IE0AkdyU1uspiC6J9gqu/127rNGBfYeK7fS9IffdglFtuZU4QYMhON863J/JnHN9IN
         mGv1JrbvFUQxVT5CzZUz3dmrvPs/5ckfcj0afwVOuhDlFh1gdLoA7QAa2kD0/x6Y2kTW
         FIyU0aJ9HOOdA7V0VTniDAbDHi1rEcQD4ApgoY1l0pMORV55PpJMJuHnc0RBKp2PKPJe
         +bnpc4zUd/Bw0GvWUTGUaD8OpiMbFXjorj/65zW4pAjpNw7Za5nmvjXTaXm41KdoAM8F
         ZczrfBs4gukDlSIzzRLYiVza5FKaQ9pej4UvIhrf0Kk8Y3ECIpf+LR5kU482xJ1s3euO
         Og2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bTrbU4qhsIclu4qHRn6Srm57oJ3vDUjd2Hic2lcZNm4=;
        b=O0P8YOmMcNq9TmvqDO08cTvMbKh0pZ2hzMSUoHxf0iO8WeG1GEF3BQIQ6L8UD/O82D
         nFYcM1s7jwsjZJyW3rNNCWDEPc6Mx474PAjTxUTxrwB4CGWyKw8qwYsZeyqNvLP+Oe4+
         Uyycnjh8ktLgX21DRH7WLCPdNybX8Ef9Du8Eu0G96ExsW+0x5lx6kSFoOCPMgyJLxR5g
         PjCwKnsupNKVvJDq+bO3k1HWTUA7bYHb1+w1cG15A1i/Sl/B4rh/k6MOCH31ohn4mVW2
         WyzGk3HUt8CIYcAjQQu/9gR0FM9oClgYgeBvhf4QYQ9iYs3JWvVNLTAGxIIQy3NSmM45
         HWVw==
X-Gm-Message-State: AOAM532NV5K9YSNt0i0LBvtjbieQcpaD/xAYhd45osm09PB0YNW4kwwp
        8f3MuzVmeLOWZ+FIaVFJslXrEObvkRCNp0vbw/Dau+FdjHuz0e7F
X-Google-Smtp-Source: ABdhPJyvE+HW6XZ3cnHA8n8pb8gqqiyIQzbfNWc+lVloKfDZ4aHrIMWAnXUnipr1y0/8LcXKU1TiKdI9K1EiksYyALU=
X-Received: by 2002:a6b:1642:: with SMTP id 63mr8063882iow.68.1626677711176;
 Sun, 18 Jul 2021 23:55:11 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 19 Jul 2021 14:55:20 +0800
Message-ID: <CAOLTT8QLrG+R3sOHpMsAiveOT1wTKR-_Nw8Ro6iXL1_MTMZ6eA@mail.gmail.com>
Subject: [GSoC] Git Blog 9
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My ninth week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-9/

## Week9 BUG REPORT

### BUG REPORT 1

* What did you do before the bug happened? (Steps to reproduce your issue)

Because someone told me that `git cherry-pick` can't gave useful
prompt information like `git rebase -i` does:

```
You can amend the commit now, with

git commit --amend

Once you are satisfied with your changes, run

git rebase --continue
```

I found that I can take use of "GIT_CHERRY_PICK_HELP" environment variable,

```
$ GIT_CHERRY_PICK_HELP="git cherry-pick --continue" ggg cherry-pick v1
```

which will output prompt information "git cherry-pick --continue", good!

* What did you expect to happen? (Expected behavior)

I could use `git cherry-pick --abort` to exit cherry-pick normally.

* What happened instead? (Actual behavior)

Then I couldn't use `git cherry-pick --abort` to exit cherry-pick normally.

* Anything else you want to add:

See the print_advice() in sequencer.c, `CHERRY_PICK_HEAD` will be removed
if we use the env "GIT_CHERRY_PICK_HELP". It is used by `git rebase
-i` and somewhere else.

Here may have two solutions:
1. Prevent users from using the environment variable "GIT_CHERRY_PICK_HELP".
2. check if we are truly cherry-pick.

```c
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38..c01b0b9e9c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -409,8 +409,9 @@ static void print_advice(struct repository *r, int
show_hint,
* (typically rebase --interactive) wants to take care
* of the commit itself so remove CHERRY_PICK_HEAD
*/
- refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
- NULL, 0);
+ if (opts->action != REPLAY_PICK)
+ refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
+ NULL, 0);
return;
}
```

* [System Info]

```
git version:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.12.15-arch1-1 #1 SMP PREEMPT Wed, 07 Jul 2021 23:35:29
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/zsh
```

* [Enabled Hooks]

None.

### BUG REPORT 2

* What did you do before the bug happened? (Steps to reproduce your issue)

Normally execute the test under git/t.

* What did you expect to happen? (Expected behavior)

Pass the test t/t0500-progress-display.sh.

* What happened instead? (Actual behavior)

```zsh
$ sh t0500-progress-display.sh -d -i -v
...
expecting success of 0500.3 'progress display breaks long lines #1':
sed -e "s/Z$//" >expect <<\EOF &&
Working hard.......2.........3.........4.........5.........6: 0%
(100/100000)<CR>
Working hard.......2.........3.........4.........5.........6: 1%
(1000/100000)<CR>
Working hard.......2.........3.........4.........5.........6: Z
10% (10000/100000)<CR>
100% (100000/100000)<CR>
100% (100000/100000), done.
EOF

cat >in <<-\EOF &&
progress 100
progress 1000
progress 10000
progress 100000
EOF
test-tool progress --total=100000 \
"Working hard.......2.........3.........4.........5.........6" \
<in 2>stderr &&

show_cr <stderr >out &&
test_cmp expect out

--- expect 2021-07-19 06:09:39.800189433 +0000
+++ out 2021-07-19 06:09:39.803522767 +0000
@@ -1,6 +1,5 @@
Working hard.......2.........3.........4.........5.........6: 0%
(100/100000)<CR>
Working hard.......2.........3.........4.........5.........6: 1%
(1000/100000)<CR>
-Working hard.......2.........3.........4.........5.........6:
- 10% (10000/100000)<CR>
- 100% (100000/100000)<CR>
- 100% (100000/100000), done.
+Working hard.......2.........3.........4.........5.........6: 10%
(10000/100000)<CR>
+Working hard.......2.........3.........4.........5.........6: 100%
(100000/100000)<CR>
+Working hard.......2.........3.........4.........5.........6: 100%
(100000/100000), done.
not ok 3 - progress display breaks long lines #1
#
# sed -e "s/Z$//" >expect <<\EOF &&
# Working hard.......2.........3.........4.........5.........6: 0%
(100/100000)<CR>
# Working hard.......2.........3.........4.........5.........6: 1%
(1000/100000)<CR>
# Working hard.......2.........3.........4.........5.........6: Z
# 10% (10000/100000)<CR>
# 100% (100000/100000)<CR>
# 100% (100000/100000), done.
# EOF
#
# cat >in <<-\EOF &&
# progress 100
# progress 1000
# progress 10000
# progress 100000
# EOF
# test-tool progress --total=100000 \
# "Working hard.......2.........3.........4.........5.........6" \
# <in 2>stderr &&
#
# show_cr <stderr >out &&
# test_cmp expect out
#
```

* What's different between what you expected and what actually happened?

It seems that the progress display is not working normally.

* Anything else you want to add:

I am thinking:
1. Is this bug caused by my own patches?
So I switched to other branches, including upstream/master, see the bug too.
2. Is this bug caused by zsh?
So I switched to bash, and saw the bug too.
3. Does this bug only appear on my Arch-Linux?
So I asked my classmates (who use arch linux too) to download git/git
from github and perform the test, see the bug too.
4. Does Ubuntu also have this bug?
No. In the case of using Ubuntu's docker and Centos's virtual machine,
after cloning git/git from github, they actually passed the test!!!

So what's wrong with Arch-Linux?

* [System Info]

```
git version:
git version 2.32.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.12.15-arch1-1 #1 SMP PREEMPT Wed, 07 Jul 2021 23:35:29
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/zsh
```

* [Enabled Hooks]

None.


### project progress

I am still thinking about how to improve the performance of `git
cat-file --batch`.
This cannot be solved quickly, keep patient.

My mentors told me to split my main patch series into a few smaller
patch series, but how?
In other words, there is a certain correlation between these patches,
If they are really split into
multiple patches, how can I send them to the mailing list without repeating?

I just received half of the GSoC bonus, and felt a burden of responsibility...
