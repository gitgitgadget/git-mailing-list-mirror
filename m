Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955D5211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 16:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbeLBQ4Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 11:56:24 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36316 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBQ4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 11:56:24 -0500
Received: by mail-wm1-f53.google.com with SMTP id a18so3394741wmj.1
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k2EQvkVWhKy8B0nM4zkQpugTeAomh4nKIW1qbpET82E=;
        b=n0AULAdwAOaNiD/4BQBLtOlIXtQ3iat8gylZ3S38EyxUraTisUviExLF4Kpzw+3JjC
         pWtkE4lnUC+W3nwchpV0Y0zHgzTfs0pjIfHAoP91EQ6Sz0VUOsh11opZI7X2ZdvT2sMC
         UoX+wV8Nv/IF9YfpCVAxbguYLXOSLGEKd8p3I2YCp0gQdgAaElNOwbyMP4CBxlaUPRjv
         shsohNAUU1bRcrCYeWjPVPDXGkVaclFozEX7OMnvzrJr1vvR/Fc7+Lcf7+gIEBM1wf/r
         j8v20FuXFM30EO6cQElaoNKZb4pSiJCoBk7rBhLsQP1q65KIN16jW2iGoPqYRjtlBPyY
         I3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k2EQvkVWhKy8B0nM4zkQpugTeAomh4nKIW1qbpET82E=;
        b=J1hKtTGhqtN4dpIwpOPfbC5bUZwOdtU6EX3/fdvZosk7Rz1DHZ66byw3KAt85JiOen
         ZcIxuvknBIG5boohSqcXkJBabvSfa+4FlDYSv1FLAOykRz4gjISbxGsQ+G+I75J782Bn
         V4hCGltwIqwV2aEvpwolnulO2/p764u1sJnW65tyZaa/GCLaVyJRX5fQUDeAzdYK/Kxl
         1BMEffXONIqGiDmorvqI1PO55tQTDQX5DKmjlMkCoPd9wWHk718U/i4AeG+c+I0+Asq9
         w8TRI71TO/NoO3Fp7+cPN/pB2cwaESsZ3ch9oQJv91DvwF+SJDCxJJtJbTbPGe5qCCVx
         VkiA==
X-Gm-Message-State: AA+aEWYP1F8SrQa0wMDA8MR9FDpivspKkRWjuoec2QCb3sI03Qy1uAX3
        o2tlBm1V3hJa3vaZETM4f7E=
X-Google-Smtp-Source: AFSGD/XVmFWfgwD2SrBWaPNROrm+5dUpZUnT1J0g11hMM+qTkgILJ/Eijs9R/L4oYyENkrxYP2YeZQ==
X-Received: by 2002:a1c:2981:: with SMTP id p123mr5413868wmp.19.1543769780556;
        Sun, 02 Dec 2018 08:56:20 -0800 (PST)
Received: from szeder.dev (x4db96d38.dyn.telefonica.de. [77.185.109.56])
        by smtp.gmail.com with ESMTPSA id j20sm3735551wme.20.2018.12.02.08.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 08:56:19 -0800 (PST)
Date:   Sun, 2 Dec 2018 17:56:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git add -p" versus "git add -i", followed by "p"
Message-ID: <20181202165617.GG30222@szeder.dev>
References: <alpine.LFD.2.21.1812021124350.5509@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.21.1812021124350.5509@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 02, 2018 at 11:30:19AM -0500, Robert P. J. Day wrote:
> 
>   testing adding by patch for the very first time (i've just never
> needed this), and reading the "progit" book and reading the man page,
> and the impression i'm getting is that running "git add -p" (going
> straight to patch mode) is supposed to be equivalent to running "git
> add -i", then typing "p" to switch to patch mode.
> 
>   that is most emphatically not what i'm seeing. if i run "git add
> -p", then i get to what i expect -- the patch subsystem:
> 
>   $ git add -p
>   diff --git a/README.asc b/README.asc
>   index fa40bad..840e85b 100644
>   --- a/README.asc
>   +++ b/README.asc
>   @@ -1,3 +1,9 @@
>   +change 1
>   +
>   +
>   +
>   +
>   +
>    = Pro Git, Second Edition
> 
>    Welcome to the second edition of the Pro Git book.
>   Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]?
> 
> but if i start with "git add -i", there seems to be no way to get to
> patch mode -- certainly "p" doesn't do it. am i stupidly missing
> something trivial? is the explanation misleading or inncomplete?

Worksforme™:

  $ echo "New content" >>README.md 
  $ echo "New content" >>t/README
  $ echo "New content" >>contrib//README
  $ git add -i
             staged     unstaged path
    1:    unchanged        +1/-0 README.md
    2:    unchanged        +1/-0 contrib/README
    3:    unchanged        +1/-0 t/README
  
  *** Commands ***
    1: status       2: update       3: revert       4: add untracked
    5: patch        6: diff         7: quit         8: help
  What now> p
             staged     unstaged path
    1:    unchanged        +1/-0 README.md
    2:    unchanged        +1/-0 contrib/README
    3:    unchanged        +1/-0 t/README
  Patch update>> 1
             staged     unstaged path
  * 1:    unchanged        +1/-0 README.md
    2:    unchanged        +1/-0 contrib/README
    3:    unchanged        +1/-0 t/README
  Patch update>> 2
             staged     unstaged path
  * 1:    unchanged        +1/-0 README.md
  * 2:    unchanged        +1/-0 contrib/README
    3:    unchanged        +1/-0 t/README
  Patch update>> 

Here I hit enter.  Did you?

  diff --git a/README.md b/README.md
  index f920a42fad..63dee5cfc3 100644
  --- a/README.md
  +++ b/README.md
  @@ -62,3 +62,4 @@ and the name as (depending on your mood):
   [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
   [Documentation/gitcvs-migration.txt]:
  Documentation/gitcvs-migration.txt
   [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
  +New content
  Stage this hunk [y,n,q,a,d,e,?]? y
  
  diff --git a/contrib/README b/contrib/README
  index 05f291c1f1..2b152dfcff 100644
  --- a/contrib/README
  +++ b/contrib/README
  @@ -41,3 +41,4 @@ submit a patch to create a subdirectory of contrib/
  and put your
   stuff there.
   
   -jc
  +New content
  Stage this hunk [y,n,q,a,d,e,?]? n
  
  *** Commands ***
    1: status       2: update       3: revert       4: add untracked
    5: patch        6: diff         7: quit         8: help
  What now> q
  Bye.
  $ git diff --cached 
  diff --git a/README.md b/README.md
  index f920a42fad..63dee5cfc3 100644
  --- a/README.md
  +++ b/README.md
  @@ -62,3 +62,4 @@ and the name as (depending on your mood):
   [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
   [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
   [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
  +New content
  $


Arguably the documentation could make it clear that the user can
choose multiple files at once, e.g.:

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index c9623854bf..061f9cbb0d 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -317,9 +317,9 @@ add untracked::
 
 patch::
 
-  This lets you choose one path out of a 'status' like selection.
-  After choosing the path, it presents the diff between the index
-  and the working tree file and asks you if you want to stage
+  This lets you choose one or more paths out of a 'status' like selection.
+  After choosing the path(s), it presents the diff between the index
+  and the working tree file(s) and asks you if you want to stage
   the change of each hunk.  You can select one of the following
   options and type return:
 
And perhaps we could have a dedicated menu entry for "I'm done with
selecting paths"?  Dunno; I'm a 'git add -p' user myself.

