Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501782021E
	for <e@80x24.org>; Wed,  9 Nov 2016 18:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbcKISYG (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 13:24:06 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34336 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbcKISYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 13:24:05 -0500
Received: by mail-yw0-f172.google.com with SMTP id t125so215464835ywc.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 10:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BmznTYy258dH7Jz2yaPDlA2knzPlnMZn5bUy8eCW5nM=;
        b=zV8YwcLk9vrlgD4Xb1R0D2M8+H7wOkoG5qtSTpp00jq88p2yEbKqvctpA4FdDtbHms
         5SLAa74HXC/is4mZ8ok9u98oCVtAoXYAjgM4pXiGbo2xP7cozGARjNjIt+n4LUKmyTXq
         bRF/Gs5FEgI6ZWWySlLEop8S4HXRoi7p6MEUZj1GcuOPAMPES/IXRfqi3nfrRAi7uAni
         cSNPYGw5517lxvpWwKGMwpF85t7VWOsf44FJ4ysywvC09OKwcXVfZ718xvAgy9pDFh+D
         J+MrghxjzfxGzTGavph6NHwLSL9BRsM/Dvz8x2mSdopSdUrE0c6g8AtWV23loxfSYXeG
         d6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BmznTYy258dH7Jz2yaPDlA2knzPlnMZn5bUy8eCW5nM=;
        b=ak1yLjXFOU2+8Hf3RS9nTFWBGHQoZOnHGlGGWwSI64KTG7Zx2+H7a7dGOK2+kwwDJu
         /eQ6EwwW7LWCq7jMYUbyLJMK8dRJasQ+OmIdJCd3QxFxmuyPtr8wHB1DxIDJxsg/b0zB
         q9jrOF4WGo8ffeyNR8pfFYFT+CXpsuzi1XuKx4V7BHYedIlSxak6yks9oU0qX3WNUmvq
         lzbqo/2n2Ql5SNVcylcbdmi1ge2QyLWqrzP7Gm1AoYMdPA4ZOQKI5ris44WqTSiDGJQr
         f3zIjb2ZJVrzmCCGWgnJWt1p0ckjhCWSaKIkSNzvQUqQfiLD4QTm+7jIXDhl6MmdCGNs
         Uo9g==
X-Gm-Message-State: ABUngvdUPxfU3K54qbK/Fl21QsXYZLzrcVD/9w01En9wSsK3SFoYH7kWS6+MVkB8YviUYwOGfLjWG6nD1u1R2w==
X-Received: by 10.202.75.88 with SMTP id y85mr796537oia.154.1478715844281;
 Wed, 09 Nov 2016 10:24:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.202.55.195 with HTTP; Wed, 9 Nov 2016 10:23:33 -0800 (PST)
From:   Roman Terekhov <roman.terekhov@gmail.com>
Date:   Wed, 9 Nov 2016 19:23:33 +0100
Message-ID: <CALbGNxUahc0b151niqS3Qd6N8wapY5RWJs1w0ZSf6ZW1=id6vA@mail.gmail.com>
Subject: Cleaning ignored files
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I want to ask about git clean -dXf command behaviour.

I do the following:

$ mkdir gitignore_test
$ cd gitignore_test/
$ git init
Initialized empty Git repository in ~/gitignore_test/.git/

$ echo *.sln > .gitignore
$ git add .gitignore
$ git commit -m "add gitignore"
[master (root-commit) ef78a3c] add gitignore
 1 file changed, 1 insertion(+)
 create mode 100644 .gitignore

$ mkdir src
$ touch test.sln
$ touch src/test.sln
$ tree
.
=E2=94=9C=E2=94=80=E2=94=80 src
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test.sln
=E2=94=94=E2=94=80=E2=94=80 test.sln

1 directory, 2 files

$ git clean -dXf
Removing test.sln

$ tree
.
=E2=94=94=E2=94=80=E2=94=80 src
    =E2=94=94=E2=94=80=E2=94=80 test.sln

1 directory, 1 file


Why git clean -dXf does not remove all my test.sln files, but just one of t=
hem?

Roman Terekhov
