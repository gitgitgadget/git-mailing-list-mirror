Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463791F597
	for <e@80x24.org>; Tue, 31 Jul 2018 14:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbeGaPtz (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 11:49:55 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:42649 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732222AbeGaPtz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 11:49:55 -0400
Received: by mail-ua0-f181.google.com with SMTP id w7-v6so10353026uan.9
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eDcAw4P/IYRbRF+7NamQThslLHYp1Pxj1WpKr8y08sE=;
        b=OtWnyatD7XNqV8d5LgguZrOyDtaCKv4rqmE8ttWoeiUUiHovU8ayzCkXLYpdVeFk3u
         Lf222XwXt9jnXb1RvbzbjUELzR8L2VXIYRt6KkoMyQcAceSenHkau8tRSTWEOg2u454O
         8nDdYNSuNH4/nF1ISRMHqTYtlduaKMxD2k23oCvwmLGL+RkdsF91um2MRJsPrZfMT62N
         7kyzSDA21rZ/pqBjiGRqiKD5TX1btYYnoAf3YAAjz8gDUKcJwapsZ6NSfyMv8thNbexw
         BZNKpbc33e2LDu46XvxEz6fd7TMiLkaMY1d+Friq4HwrZImQ0wbnQHuxbJIqBuHaxDtF
         ryRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eDcAw4P/IYRbRF+7NamQThslLHYp1Pxj1WpKr8y08sE=;
        b=KFMX3KN3E/DqjW29lZTH+pza7bEvFU3LJ2CGTb92DUyo3yUGTjWh0DHcsNC/Ak2gNb
         9v8yhY9OqdefiYkAMyKHolBxpPKOfwyiTlTOKMuwiFN9zmQ33691zz7/5ALN2cL67nes
         XzYQdNR0rFHwhBCZQ34xA3NjNfK3i/FPL4rsD3CIN0rcvteToBnuCETwcJcnJWEETpCz
         feiFYQWxLIcm2X6II4T/ASm4VFlY/sKOM+E67zLpzfKsgP3hPTZtdO/coh9sUVPOdCHp
         ZIQaudd0LYY2K06VfWhfIW/ZVRPvGvGHl6OW7FRwS6tTsImAlvyFdqsJKaM941Um5R3I
         qc2w==
X-Gm-Message-State: AOUpUlFl/6iCUhog8rnqOsx588muC6bp7uP6Hf3ZmTMOuLx4XPfj+zDm
        5PZfpq9qtm6BPge2LqZiGErSyLtWbjaxqPRfSwCrIgQQ
X-Google-Smtp-Source: AAOMgpepn8NP4a+pcuzyHG2JW98GtXpJOmeQKFZeffZQ2J+oxJ6rEfocAn2fKkHwFEK5gvC8j5mj0hnk77hmv1EPQe0=
X-Received: by 2002:ab0:4dce:: with SMTP id b14-v6mr15586154uah.27.1533046164155;
 Tue, 31 Jul 2018 07:09:24 -0700 (PDT)
MIME-Version: 1.0
From:   George Shammas <georgyo@gmail.com>
Date:   Tue, 31 Jul 2018 10:09:12 -0400
Message-ID: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
Subject: git merge -s subtree seems to be broken.
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000009f08905724c2047"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000009f08905724c2047
Content-Type: text/plain; charset="UTF-8"

At work, we recently updated from a massively old version of git (1.7.10)
to 2.18. There are a few code bases that use subtrees, and they seem to
have completely broke when trying to merge in updates.

I have confirmed that it works correctly in 1.7.10.  The 2.18 behavior is
clearly incorrect.

git init
echo init > test
git add test
git commit -m init

git remote add tig https://github.com/jonas/tig.git
git fetch tig
git merge -s ours --no-commit --allow-unrelated-histories tig-2.3.0
git read-tree --prefix=src/ -u tig-2.3.0
git commit -m "Get upstream tig-2.3.0"
# Notice how the history are merged, and that the source from the upstream
repo is in src

echo update > test
git commit -a -m "test"

git merge -s subtree tig-2.4.0
# Boom, in 2.18 instead of merging into the subtree, it just deletes
everything in the repository, which is clearly the wrong behavior.

--00000000000009f08905724c2047
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">At work, we recently updated from a massively old version =
of git (1.7.10) to 2.18. There are a few code bases that use subtrees, and =
they seem to have completely broke when trying to merge in updates.<div><br=
></div><div>I have confirmed that it works correctly in 1.7.10.=C2=A0 The 2=
.18 behavior is clearly incorrect.<br><br></div><div>git init</div><div>ech=
o init &gt; test</div><div>git add test</div><div>git commit -m init</div><=
div><br></div><div>git remote add tig <a href=3D"https://github.com/jonas/t=
ig.git">https://github.com/jonas/tig.git</a><br></div><div>git fetch tig<br=
></div><div>git merge -s ours --no-commit --allow-unrelated-histories tig-2=
.3.0<br></div><div>git read-tree --prefix=3Dsrc/ -u tig-2.3.0<br></div><div=
>git commit -m &quot;Get upstream tig-2.3.0&quot;<br></div><div># Notice ho=
w the history are merged, and that the source from the upstream repo is in =
src<br></div><div><br></div><div>echo update &gt; test</div><div>git commit=
 -a -m &quot;test&quot;</div><div><br></div><div>git merge -s subtree tig-2=
.4.0<br></div><div># Boom, in 2.18 instead of merging into the subtree, it =
just deletes everything in the repository, which is clearly the wrong behav=
ior.<br></div></div>

--00000000000009f08905724c2047--
