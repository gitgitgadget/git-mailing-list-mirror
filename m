Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5922DC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E561355
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhGVIIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhGVIIh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 04:08:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB1C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:49:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t3so5817374edc.7
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7wJJRCXkmS1dsPdo5C2Ius21SaofGSqN5lNjnXERqJc=;
        b=ft4n/uxoF6iEtvQnJ6tJukn4L49wpZh0akfkJB+uuz7EVwb6551CwVAvGqVbsT9c30
         d76VyMrg3q93frs2bG4kG5x2BaGcxflXgsNMAjvS7n0MfxZ2MduIIYmvsA0dwTrF350Z
         f/w1AWPsDBBNjakdlcN56GsgTtIqAaacOSdP4Vz6O9lfrKavk02rHUb14ZHw7+mKZ31u
         x+kUidVhU7uCYNDvo+NSTRIXGjKUpMpp/uiA7HzsQ6t88ezJK722jAh2GSIsWSPZpEBd
         A9WAtWkxN8F4STrHvwLpCVB2/vzoXF2qtnUxN+lB7PHl6n8Hhuv3IDBrIeX/eBD9V+c+
         mQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7wJJRCXkmS1dsPdo5C2Ius21SaofGSqN5lNjnXERqJc=;
        b=q1TRxobUwW+cK2X/Ed50ybBV0BNrMKWno20yij4IGLj83FTaumKyODINuXigu0/ybr
         xiCs5Q/pmM2NoEpZHLEdqkPLRSJnYKPhDRz3C/FVRzYkoDIvpwhz50MNn1T59jE5Uf+b
         CeJSaTQJHykpOGStSP+VwynWTCoXG26LnhEme2rzyyjYGbOUzf+UnPU/+dXTdDX0t7ny
         KnyeMEn2zvTe5reyg6/4yzESZFlIGomLMpCyKWmxiwG44K8hdRkCX/M2LOQB/YxzWvJE
         7QOnsDANhWuzsqsrYJpjZZ+Cm1qo1hMPbX8wjYEWh0YrTXC+1O/0r1Sbg5zYLQpENBwj
         dOFA==
X-Gm-Message-State: AOAM530idU/DbbYv+/KHiee3iHhtFyLcBnXYmNzVIwv+hw10nyzx1tSt
        UlkaBOMyFzMHd8E2ws1dhubWwbo6/DPIQERGT32WpLAJ70A=
X-Google-Smtp-Source: ABdhPJzdS+WC32Zk/5nTczZ7lR2bEpMsGj662+/vs9e9Lf0H2j4kpqpqMsc6LjzmEmc/w+7jincfjCPqzkjYPEUzXVA=
X-Received: by 2002:aa7:d8d0:: with SMTP id k16mr52303467eds.202.1626943750785;
 Thu, 22 Jul 2021 01:49:10 -0700 (PDT)
MIME-Version: 1.0
From:   Angelo Borsotti <angelo.borsotti@gmail.com>
Date:   Thu, 22 Jul 2021 10:48:59 +0200
Message-ID: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
Subject: Extracting a file
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

sometimes there is a need to extract a file from a commit.
E.g. some changes have been applied to it in the work directory,
and the app being implemented no longer works properly.
It would be fine to have a look at that file, some commits ago,
when all worked fine.
Of course, it is possible to recover the entire old commit, or to
make a new branch, or checkout the file (which requires to save
the new one before), but the most simple and safe way is to
extract the file, giving it a new name.
That is possible, using this (hard to remember) trick:

git show HASH:file/path/name.ext > some_new_name.ext

Would not be better to have a "copy" command to copy a file from a commit
to a new one in the current directory?
This would make a git repository resemble a (readonly) filesystem, which
actually it is.
Note also that the ability to get from a repository what one has stored
in it is the most basic feature anyone wants from a repository.

Thank you
-Angelo Borsotti
