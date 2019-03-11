Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EDA120248
	for <e@80x24.org>; Mon, 11 Mar 2019 20:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfCKUc0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 16:32:26 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:55784 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfCKUcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 16:32:25 -0400
Received: by mail-it1-f181.google.com with SMTP id z131so791068itf.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=D3Jpi7n5Wsh5xXF+5P7vmyBfGv8jMNs1+tu1bKHD+vI=;
        b=kCRc7dvwBh+r/XCed+vcume5DwPUUHPDlpH7fOd/HHK2CsELsZcwoWNrtPmxrhw/Nd
         +Hs8F50b2IZYUV8arKO2Iw19JPq4gNf7EkRb7BWflyCipP84QPgIASltyoNM9vcAt5uy
         lb33i16tDWnIkrGkU/AvGUIiK6FR5HV4YWfxwhuP6xE4X8QcInKzJSwo1SR3xrv7Ffch
         Mnc+XmgV/SSEI4RSlLkmCSPQBTEiDr5HcN8zSNc3t7/hJ/tMULU96niwoXIt4GWsFD93
         G0s4Hl7msBg6FjS5YNh3iTJoBvlIBw2LclVYlxjwofDG3twT/P/kRZKOuNdXbXO9tsVB
         DS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=D3Jpi7n5Wsh5xXF+5P7vmyBfGv8jMNs1+tu1bKHD+vI=;
        b=hsi1kcN8HEVRi1ODAQu7mjfTLhUmClSEt0/xLNeTuLcXQFn7gIgAM3tzCDUccGs+S7
         EYtmR9Ibjg7VPIc3ADdlL/juAPbCx5UQ6T30CLNSPduT4gMzEspCH/Rg5WJNh6flk4Ml
         NA/z/WwMtGwIYYm+j4AUXMlaeJzFJ0DQKXxE5gSo8qm0Pwm53Dbv4eb60O6u+Ld069Jv
         /LyxwA05oM7ghgv5ClhcLt70Y4r/b2Ch6D/e2LXeyv4nBD/S0KNRWNoMUDEet2V5iwFP
         kOYwZ2AyBTZNdPhHLgASltHObgOl/3b4EJxzL2fQGyVkRHs8UQ967lBMcqeE0RTIgcKW
         tZVw==
X-Gm-Message-State: APjAAAUuk+R3C6D52Yg59UOnCXehQMJFE7pMqu8wp3+bSUxOxdoARrrX
        TODMxAV+8Dc8jlzpUwoKtG/7Bcf6l2XX+atW1IJMMJoJ
X-Google-Smtp-Source: APXvYqzw5uTdmN0qk6frEXeVYlkEn995Gp8BsIlzgbwtNMLr1yNyv0EwpU32bWHc+0EPNgwX9f9J4ejeAvanD6OJwdM=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr73876ita.10.1552336344526;
 Mon, 11 Mar 2019 13:32:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 16:31:55 -0400
Message-ID: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
Subject: Solaris and sed: Too many commands, last: s/\n//
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I enabled self tests for Solaris. Solaris has some anemic utilities so
I put /usr/gnu/bin first on-path.

make test is resulting in a lot of:

gmake -C templates  SHELL_PATH='/bin/bash' PERL_PATH='/usr/bin/perl'
gmake[1]: Entering directory
`/export/home/jwalton/Build-Scripts/git-2.21.0/templates'
: no custom templates yet
gmake[1]: Leaving directory
`/export/home/jwalton/Build-Scripts/git-2.21.0/templates'
gmake -C t/ all
gmake[1]: Entering directory `/export/home/jwalton/Build-Scripts/git-2.21.0/t'
rm -f -r 'test-results'
sed: Too many commands, last: s/\n//
--- chainlint/arithmetic-expansion.expect       2019-02-24
11:31:46.000000000 -0500
+++ chainlinttmp/arithmetic-expansion.actual    2019-03-11
12:20:16.880610011 -0400
@@ -1,9 +0,0 @@
-(
-       foo &&
-       bar=$((42 + 1)) &&
-       baz
->) &&
-(
-?!AMP?!        bar=$((42 + 1))
-       baz
->)
sed: Too many commands, last: s/\n//
--- chainlint/bash-array.expect 2019-02-24 11:31:46.000000000 -0500
+++ chainlinttmp/bash-array.actual      2019-03-11 12:20:16.902186323 -0400
@@ -1,10 +0,0 @@
-(
-       foo &&
-       bar=(gumbo stumbo wumbo) &&
-       baz
->) &&
-(
-       foo &&
-       bar=${#bar[@]} &&
-       baz
->)
sed: Too many commands, last: s/\n//

A more complete output is available at https://pastebin.com/gpZMUVmQ,
but it is more of the same.

Solaris in a VM sucks. I can provide SSH access to the hardware if
anyone is interested. It is just an Solaris i86pc on an older Ivy
Bridge.

Jeff
