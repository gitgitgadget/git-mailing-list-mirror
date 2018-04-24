Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228ED1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 19:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeDXT5j (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 15:57:39 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:45581 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeDXT5i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 15:57:38 -0400
Received: by mail-lf0-f50.google.com with SMTP id q5-v6so22101565lff.12
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q5oXuuyrxyoxxtrJeHt4RnFhDjX+0ROrDnLn6DRerZo=;
        b=SHyqlRzEAC2+axxVIFzAD7hqCpUj5/NsWddw5ap4qYwhoR+Gwc8q37+br0ZyVPUQjV
         uucsuUsVrhX5oTCEbHItQGi7GDsFwwj4a0jsRM9Q9v2DdqZi5wh5OFC8Mg9ZyDnyAoRX
         T7wDJHkgKc2DF0AA09u1yPsRgi8K6Jk6UjEKz2M6F1mlcBdsPvTP9gxTCIZloSgnMwBx
         PxjrvjPEP63/Pqw80uI7OPQidvqRdLvZ7cbqjlUeMtmP1g/xKVMITu5X7h1Y53xEBzsW
         p1mSVsqfRUMuXHBSsTaUHiKPuhDOi9gP2GMyYEojw+gTT6R7NOnZBhdToR+1hOMxslHC
         RcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q5oXuuyrxyoxxtrJeHt4RnFhDjX+0ROrDnLn6DRerZo=;
        b=NHwPWnQ0NwEh1ukpr+ahwcPhZSAfvgcnp8j/Dd30S17BFh+LToSOU5DHkF1bsLF+nM
         CjTKUzygP7Ad4lAowOrN+iLaty38fCUm/nkK/WMz+/U9AOfITpm4cZOvjOUFBg1YNd2F
         bGsQTayKP1huaiE2GtX7BNZ1P1y45/pKraLM2Pm94LGIhTLesmNQuP2Ht+zCdMan7Edb
         rm5v+7jfjhC0fTpXYf+0AIfT6SJLN5E4PD17YKvQ2Kixnwi7PWORiYVckUsAMgbT4RVG
         FTYMl3zXKolGDmEEU+nUCFIa7MiJJ53O3IrKhiLZlUaHTk3CfxneFdHURB6BTs0jAhBJ
         JWiA==
X-Gm-Message-State: ALQs6tC2vBrPh5KgtZO5HD0TniY8FDAaf6L9to55sYbaWp+4VlS5Riyt
        oZ6l4fPKcTwCsZZ84CCJcH6U9pgXlUAK49tOqd47QI09lN0=
X-Google-Smtp-Source: AB8JxZrSEmzcPdpmbFYxpBFeq7/IrIKR6htBsigVFUTpVBW3LZ8dDkpFefrwj2KAYC6Lu8l15gKZovNKXeC8qJxfvHo=
X-Received: by 2002:a19:1462:: with SMTP id k95-v6mr12867473lfi.23.1524599856989;
 Tue, 24 Apr 2018 12:57:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 12:57:16
 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
Date:   Tue, 24 Apr 2018 12:57:16 -0700
Message-ID: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
Subject: Fetching tags overwrites existing tags
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If have a repository with a tag "v1.0.0" and I add a remote repository
which also has a tag "v1.0.0" tag is overwritten.

Google found [1] from 2011 and option 3 is what I'd like to see. Has it been
implemented and I just don't see it?

[1]: https://groups.google.com/forum/#!topic/git-version-control/0l_rJFyTE60


Here is an example demonstrating what I see:

$ echo abc > abc.txt
$ git init .
Initialized empty Git repository in
/home/wink/prgs/git/investigate-fetch-tags/.git/
$ git add *
$ git commit -m "Initial commit"
[master (root-commit) 1116fdc] Initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 abc.txt
$ git tag v1.0.0
$ git remote add gbenchmark git@github.com:google/benchmark
$ git log --graph --format="%h %s %d"
* 1116fdc Initial commit  (HEAD -> master, tag: v1.0.0)
$ git fetch --tags gbenchmark
warning: no common commits
remote: Counting objects: 4400, done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 4400 (delta 5), reused 5 (delta 3), pack-reused 4382
Receiving objects: 100% (4400/4400), 1.33 MiB | 2.81 MiB/s, done.
Resolving deltas: 100% (2863/2863), done.
From github.com:google/benchmark
 * [new branch]      clangtidy       -> gbenchmark/clangtidy
 * [new branch]      iter_report     -> gbenchmark/iter_report
 * [new branch]      master          -> gbenchmark/master
 * [new branch]      releasing       -> gbenchmark/releasing
 * [new branch]      reportercleanup -> gbenchmark/reportercleanup
 * [new branch]      rmheaders       -> gbenchmark/rmheaders
 * [new branch]      v2              -> gbenchmark/v2
 * [new tag]         v0.0.9          -> v0.0.9
 * [new tag]         v0.1.0          -> v0.1.0
 t [tag update]      v1.0.0          -> v1.0.0
 * [new tag]         v1.1.0          -> v1.1.0
 * [new tag]         v1.2.0          -> v1.2.0
 * [new tag]         v1.3.0          -> v1.3.0
 * [new tag]         v1.4.0          -> v1.4.0
$ git log --graph --format="%h %s %d"
* 1116fdc Initial commit  (HEAD -> master)

As you can see the tag on 1116fdc is gone, v1.0.0 tag has been updated
and now its pointing to the tag in gbenchmark:

$ git log -5 --graph --format="%h %s %d" v1.0.0
*   cd525ae Merge pull request #171 from eliben/update-doc-userealtime
 (tag: v1.0.0)
|\
| * c7ab1b9 Update README to mention UseRealTime for wallclock time
measurements.
|/
* f662e8b Rename OS_MACOSX macro to new name BENCHMARK_OS_MACOSX. Fix #169
*   0a1f484 Merge pull request #166 from disconnect3d/master
|\
| * d2917bc Fixes #165: CustomArguments ret type in README
|/

Ideally I would have liked the tags fetched from gbenchmark to have a prefix
of gbenchmark/, like the branches have, maybe something like:

$ git fetch --tags gbenchmark
...
 * [new branch]      v2              -> gbenchmark/v2
 * [new tag]         v0.0.9          -> gbenchmark/v0.0.9
 * [new tag]         v0.1.0          -> gbenchmark/v0.1.0
 * [new tag]         v1.0.0          -> gbenchmark/v1.0.0
 * [new tag]         v1.1.0          -> gbenchmark/v1.1.0
 * [new tag]         v1.2.0          -> gbenchmark/v1.2.0
 * [new tag]         v1.3.0          -> gbenchmark/v1.3.0
 * [new tag]         v1.4.0          -> gbenchmark/v1.4.0


-- Wink
