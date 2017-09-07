Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705332082D
	for <e@80x24.org>; Thu,  7 Sep 2017 09:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755094AbdIGJUh (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 05:20:37 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34386 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755082AbdIGJUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 05:20:36 -0400
Received: by mail-pf0-f177.google.com with SMTP id e1so2915619pfk.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ljm7BKIAWTe9dIKUuZTmVcRWbiq95tebkKzhL9G6/KI=;
        b=pXG5HrxWYKuQSMCsuh33nm7+XM0DcnMbSXmSet29LO6CSzwRFVZFIyE4r+BW31/90v
         b+Ahai18gFbUH/BzUnbhpsk+86qtXyh84+GMzrlaIW2p1i36L93wPnB7iZdkVaSaiHX2
         KMOslIyvp1dIibp0qPcjrGUFuDQ0RbyJxFyCb9OqaIMu4kWWT2e+V/TXWW5jtBfo/7D/
         qU48YObHblWQrGj2lCA4IuYjNL0p7guCxZwiFXMoVGQWsVQx2Sl8F9+u0LAWpbwMr559
         Cp3fo6u72shhWyx/7XoIkM1jjLF3VNrWqfwakCshqTaos4eP5x3RFRkTsid9UmLrqeYj
         UCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=ljm7BKIAWTe9dIKUuZTmVcRWbiq95tebkKzhL9G6/KI=;
        b=fI7wYgSnpDlO+4UeEGGRcLQ34yMBHTpJvfeQ9Isd4fHI86gbCWyXN9MguUxwyBKsq0
         7x+QFmILnhvOda65FOHpc2oCihrUophh7XOYtGp3KekJvOXbXuNsZtFfrFSDR+O9OY8e
         zc+pzj8w4kLzEwdBqj/bIOz4J8+kZj3MOJO5vkY1jVbudRKDjUE8hso3GpQy3Mishsa9
         ULTzJJ2g0cah6bOb28gM1J6fxwaa4o6YxdgYJ+SOLwGiFRPdG60UxWUgWM1YFF69zqZe
         ycXk2H5aX2XZ1CmEN/1J50zS30nIFoTKfi/zB5gPcphlqw63hp5rr7u3NYSO3WMDvNiX
         UMqA==
X-Gm-Message-State: AHPjjUjJFK7M2CKbqymFBaB21HJHRXgNy1N075+AOmP4vmBGQ1xI+4j6
        SJdr+6FKUIUcUQH19gSleRkgxvU//1PE
X-Google-Smtp-Source: ADKCNb4QUkfUOmVOw3gin/VR/izZm4gQtL5hisV9EBjfBvQojp1u4XOjhElphZ+9xLsh0g7AXiBhMKqAXy9glB0ODTc=
X-Received: by 10.84.210.7 with SMTP id z7mr2212553plh.371.1504776035523; Thu,
 07 Sep 2017 02:20:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.154.129 with HTTP; Thu, 7 Sep 2017 02:20:15 -0700 (PDT)
From:   =?UTF-8?Q?Pawe=C5=82_Marczewski?= <pwmarcz@gmail.com>
Date:   Thu, 7 Sep 2017 11:20:15 +0200
X-Google-Sender-Auth: kRfIkYYyubhRSHO1TiJ-CX9uGYk
Message-ID: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
Subject: Strange behavior of git rev-list
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I have an interesting case. In my repository, there are two commits,
'one' and 'two'. 'one' is reachable from 'two' (as evidenced by 'git
rev-list two | grep $(giv rev-parse one)'). However, the output of
'git rev-list two..one' is not empty, as is 'git rev-list ^two one'.

Here is the repository: https://github.com/pwmarcz/git-wtf/

It seems that the commit dates influence this behavior, because when I
edit all the dates to be the same, the output of 'git rev-list
two..one' is empty. Pruning seemingly irrelevant parents also makes it
empty.

I verified the behavior on git versions 2.14.1, 2.11.0, and on the
'next' branch (2.14.1.586.g1a2e63c10).

Pawe=C5=82 Marczewski
