Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E121F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 10:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbcJDKTO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 06:19:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34985 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbcJDKTN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 06:19:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so14284850wmg.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=JRqEirEEiD/af/W0MdOLgKOMcxYoqTCNDEQuojHwavo=;
        b=svWbvhCuf6/puyq9b4199UGtiL1a+BnsmsMHpkywKZ+iLrOA8CIBJZGkAh3FBnCdgI
         lBxlBkittT2pU4+CUCRTyFTZ7lri+gsUgg4HvVpGqcEql9dr+r1QyU6X7rsM5q9674RU
         qy2cb7vdN+FvDnAngcDMNXOVdUTRqPErpYEIAGML3z3PyNwd0msBopnWQdKvVc0nwYCx
         zOWmPeTIF9/G9T7pwjYsyxrhATiHeQpXNPE1h00xE+/zUKJ6LXHDyoHSWtxIWnaYuHHB
         8E65jfmNFeHS7huDOgnqeihSO7EVDoRk+hrnmjv+i8jLYSNCJWcn3tywveo3lALyjgjG
         NS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=JRqEirEEiD/af/W0MdOLgKOMcxYoqTCNDEQuojHwavo=;
        b=nHtXdA4RFEyCZQX4J1gSu0nLZT9/s2bPjobDxtIw9vDRCIZdWnBUDgZtd7dCzo4TR5
         XmkecHslunWjVo2e/db5cON/O6T4ZnB0hbcYFOHiiEw0H/9wsNAK7SoAFpdc2/Q1CiiZ
         +63R6+Q4/lOiUbt0E9VgRTcCLRyr5qnQVO+Cy+Y+X8oAwikuFbO5oOVpewi2nEfIAvUT
         cTkRdoXxFnY6C6ql8IuyCFxBoEyB53IJVm0kgSiQZ+wBJECM1B0cP6g4aCadPdEegfyJ
         1ZYct1DITPKdmoqcacII3JTN3tucuo0aWsslpKYyaQm/QHkEyEbMaj0J3CPHJhmaCCpX
         y/Fw==
X-Gm-Message-State: AA6/9RnUUnC9wHJbLFfGeKz984gFGYWIb+L42vdMm3a7SrXd22r5tmvstaKbw9413OknzQ==
X-Received: by 10.28.137.212 with SMTP id l203mr14423528wmd.26.1475576352494;
        Tue, 04 Oct 2016 03:19:12 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w9sm2689425wjf.47.2016.10.04.03.19.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 03:19:11 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Merge conflicts in .gitattributes can cause trouble
Date:   Tue, 4 Oct 2016 12:19:09 +0200
Message-Id: <248A6E81-8D5C-4183-9756-51A0D5193E3E@gmail.com>
Cc:     Jeff King <peff@peff.net>, Johannes.Schindelin@gmx.de,
        me@ttaylorr.com
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


If there is a conflict in the .gitattributes during a merge then it =
looks=20
like as if the attributes are not applied (which kind of makes sense as =
Git=20
would not know what to do). As a result Git can treat e.g. binary files=20=

as text and they can end up with changed line endings in the working =
tree.=20
After resolving the conflict in .gitattributes all files would be marked=20=

as binary, again, and the user can easily commit the wrongly changed =
line=20
endings.

Consider this script on Windows:

$ git init .
$ touch first.commit
$ git add .
$ git commit -m "first commit"

$ git checkout -b branch
$ printf "*.bin binary\n" >> .gitattributes
$ git add .
$ git commit -m "tracking *.bin files"

$ git checkout master
$ printf "binary\ndata\n" > file.dat # <-- Unix line ending!
$ printf "*.dat binary\n" >> .gitattributes # <-- Tell Git to keep Unix =
line ending!
$ git add .
$ git commit -m "tracking *.dat files"
$ git cat-file -p :file.dat | od -c
0000000   b   i   n   a   r   y  \n   d   a   t   a  \n=20
                                ^^^^                ^^^^  <-- Correct!
$ git checkout branch
$ git merge master # <-- Causes merge conflict!
$ printf "*.bin binary\n*.dat binary\n" > .gitattributes # <-- Fix merge =
conflict!
$ git add .
$ git commit -m "merged"
$ git cat-file -p :file.dat | od -c
0000000   b   i   n   a   r   y  \r  \n   d   a   t   a  \r  \n
                                ^^^^^^^^                ^^^^^^^^  <-- =
Wrong!

Possible solutions:

1. We could print an appropriate warning if we detect a merge conflict=20=

   in .gitattributes

2. We could disable all line ending conversions in case of a merge =
conflict
   (I am not exactly sure about all the implications, though)

3. We could salvage what we could of the .gitattributes file,=20
   perhaps by using the version from HEAD (or more likely, the ours =
stage of
   the index) -- suggested by Peff on the related GitHub issue mentioned =
below

Thoughts?

Thanks,
Lars


PS: I noticed that behavior while working with Git LFS and started a =
discussion
about it here: https://github.com/github/git-lfs/issues/1544=20=
