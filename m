Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1BCB1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdBHWOI (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:14:08 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35656 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdBHWOH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:14:07 -0500
Received: by mail-yw0-f193.google.com with SMTP id l16so12990630ywb.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 14:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bSOa0UcLJtTnrb34vHnxSMhruTpUSQFfol4lY9pul3g=;
        b=OL4Zgnpu6zoYFs6S/yX0LK0rYWlH08EsPqJuclptgHxPjLnUPpmib3LsRifQ91EA0h
         u4RYZ5nJziT8C2INBIn0R/swRoFSqHm3bTJw1tOn6epGRkmW8c1v0mWnDg/bWwt3+UV9
         vgLRUd74MjT5QwWNSPkTeiNStpKGLgoasOucXKf5EzhbQH5ZMzh154grr5kyGcJs4Dof
         xnbiMMYTrxsxd8CuDQdG8g2ZCMDuNw42o3Butp/2r1XNEzkhuWY7TucgaVK1KBkzmTJr
         AOC5kmbawVXbYcof2MethHyBXW39G6uGlDAtEyL6H7RatUfEjABYBtoV0j11WZrSWnpH
         avXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bSOa0UcLJtTnrb34vHnxSMhruTpUSQFfol4lY9pul3g=;
        b=RHGxelQd/IGf78AtF3xrGW1EilpUrD025CtEJwc80sGcvpARPvi+iAqG/nKeQhijQJ
         /6YIxmyBCVtxsnR+1lY/V0LBFveK+XhfzXI8OBmwztq+Fk1UUeHySDqmo/uq2TkqGk/0
         oliRQFFJl+/Ro2KcxdyjYGtOZK7T7qo7JCDwww+X8MtFDeKjFagxnga9hr2xH3WNXpNp
         i5/Z9l8kl1nBIBkEbV5eXLKmUvoiyi925xtOOvBI4DWjpHllVBWKdBI+XAnBdJ2qJCPl
         GYh23aXat0uto5hW9hhFtrzgVOnIa2PQLf5hmx7+oM7k73d+r1KLKAOF2OjQELCF3r5L
         hX0A==
X-Gm-Message-State: AMke39kNy2Od9A5wFIIGqHM/6nCfac4ilX/mpEchO4xt94ShKliLzhBHydThZJExqKxmI0qWtXhZOkjkK2JEXQ==
X-Received: by 10.129.94.212 with SMTP id s203mr16482886ywb.181.1486580729039;
 Wed, 08 Feb 2017 11:05:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.83.88.78 with HTTP; Wed, 8 Feb 2017 11:05:28 -0800 (PST)
From:   Thangalin <thangalin@gmail.com>
Date:   Wed, 8 Feb 2017 11:05:28 -0800
Message-ID: <CAANrE7rmUZcJkw+thMczv3D=7sqcUHBsorzvEZgYg=6AEfrU=w@mail.gmail.com>
Subject: Automatically Add .gitignore Files
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I frequently forget to add .gitignore files when creating new .gitignore files.

I'd like to request a command-line option to always add .gitignore
files (or, more generally, always add files that match a given file
specification).

Replicate

0. git init ...
1. echo "*.bak" >> .gitignore
2. touch file.txt
3. git add file.txt
4. git commit -a -m "..."
5. git push origin master

Expected Results

The .gitignore file is also added to the repository. (This is probably
the 80% use case.)

Actual Results

The .gitignore file is not added to the repository.

Additional Details

At step 4, there should be a prompt, warning, or (preferably) either a
command-line or configuration option to add the .gitignore file prior
to commit, automatically. Such as:

git commit --include-all-gitignore-files -a -m "..."

Or:

echo "**/.gitignore" >> .git/config/add-before-commit
