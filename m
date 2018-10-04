Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0491F453
	for <e@80x24.org>; Thu,  4 Oct 2018 21:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJED42 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 23:56:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39516 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeJED41 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 23:56:27 -0400
Received: by mail-it1-f195.google.com with SMTP id w200-v6so16095836itc.4
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=lk9HbP6/dAhE63rh78RtVsp0PYhn9kBK/E15VLtNTJk=;
        b=cIxP8azsHEClBfuh4ozSrMTXExVO/oOdhpADpt5lWcVEoK6/UAWUDhaGWYY1hSIXE0
         wFuTCTNd6/eQXi+RnO9/FF/gWt53N/4Swq7GCUnxhQ6MtrSFB9h/3P7x+3XWBCgEkJfq
         eom+tkTd4mxKZlckYIEHUQ6sqPhvkgTI3n1g4GsTTD+Ha4Y5GafLWjVVKEkl0/vH2jb0
         6O6uOi4RPvx2/V8NgOrSfR9Qv4bMe/B/RUCjaB9d4a1KDFnIAayunJBBIkJMfZBMfDS2
         9aH3lk1aWcLytrK56DF9fzjkNvxukH8dh2nGepYSWWASzBxQN3/aNaoWiDPXSP48R5xE
         f/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lk9HbP6/dAhE63rh78RtVsp0PYhn9kBK/E15VLtNTJk=;
        b=pmfarKh5mtfbOlhFvLBUn5uA+iNYvrPAAH6O5jkZw6wFbSSY2iUfrKjxF6mE1ns6gO
         W87rU7n8zqijbtKo1MhUafr6co9ULBrP3fIV79psTjeDYAw89wmnbj62izJbkyfZ2ua6
         AG9cnCfGaar+B8GCU/XJIhM3VhCTX4lcOH3Ot0zDheFKoEvmWqWvrGhHnMIx3ajg1LBD
         WHr6YTRtBy4zQApKXJzNvMfgKkyJU4vqjwlcQJxXY+LSYTtLdSWi5UKjI/V5I4zewuGX
         fRrF0ukll1sgU2+ohmshkrQhCyEu+8YnxccPiUH3krkdyJnycfD7k/GqIcxX53bNFmQk
         hKOg==
X-Gm-Message-State: ABuFfojbG6MEaiZS6Tknmt6zJ+7hBazpkfWtMbZNmgcOB/8GRe05Cg0k
        G9+Ccnew46LB9D4hr42BU9V54BGEKUkNFIhCntm6Jd/3
X-Google-Smtp-Source: ACcGV62/Oh78MzUeDHEiqNW3+f7hAuQAl0AFQ7knldT3zQO95p/bnC8dgtLEHMoACgy20fTsTWaqUXj6GXuNuGhLxxI=
X-Received: by 2002:a24:141:: with SMTP id 62-v6mr6283905itk.97.1538686882587;
 Thu, 04 Oct 2018 14:01:22 -0700 (PDT)
MIME-Version: 1.0
From:   Eneas Queiroz <cotequeiroz@gmail.com>
Date:   Thu, 4 Oct 2018 18:01:11 -0300
Message-ID: <CAPxccB1VnDV5BjkcFcoPVmegJSg6iN_tD3o0e9G2XKXaM_=4KA@mail.gmail.com>
Subject: [BUG] Error while trying to git apply a patch; works with patch -p1
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've sent this to the list 2 days ago, but I can't find it in the list
archives, so I'm sending it again without files attached.  I apologize
if this is a duplicate. One should be able to reproduce this with the
current PR files, but if not, I can provide them.

I've hit a strange error while trying to apply a patch from github
here: https://github.com/openwrt/openwrt/pull/965

965.patch:452: trailing whitespace.

965.patch:559: space before tab in indent.
             -o $(SHLIBNAME_FULL) \
965.patch:560: space before tab in indent.
             $$ALLSYMSFLAGS $$SHOBJECTS $$NOALLSYMSFLAGS $$LIBDEPS; \
965.patch:564: space before tab in indent.
        -o $(SHLIBNAME_FULL) \
965.patch:2334: trailing whitespace.

error: package/libs/openssl/patches/100-Configure-afalg-support.patch:
No such file or directory
error: package/libs/openssl/patches/110-openwrt_targets.patch: No such
file or directory
error: package/libs/openssl/patches/120-fix_link_segfault.patch: No
such file or directory
error: package/libs/openssl/patches/1.1.0/100-Configure-afalg-support.patch:
No such file or directory
error: package/libs/openssl/patches/1.1.0/110-openwrt_targets.patch:
No such file or directory

If you get the patch file from
https://github.com/openwrt/openwrt/pull/965.patch and apply it with
git apply, it fails.  If I apply the same file with patch -p1, it
works fine.  I've tried it with git 2.16.4 and 2.19, and they both
fail with the same error, and at least 2 more people have confirmed
it.

git apply fails even when using git format-patch -13 --stdout as a
source, so it is not github doing something weird.

The file is a series of 13 patches.  If I split the series after the
3rd patch, it works.
Also, if I use https://github.com/openwrt/openwrt/pull/965.diff, it also works.

I'm not subscribed to the list, so please CC me.

Cheers,

Eneas
