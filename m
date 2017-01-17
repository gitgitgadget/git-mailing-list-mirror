Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9333520756
	for <e@80x24.org>; Tue, 17 Jan 2017 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdAQPbK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 10:31:10 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35545 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbdAQPbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 10:31:09 -0500
Received: by mail-yw0-f178.google.com with SMTP id l19so90219253ywc.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QGlP82Eu25B5hGZnnT9A9UklfdtidyshYVusVAvyY3M=;
        b=aJ927QSSD+QUCm0wWGUjM8Y2wfoZ6NQ8OpdaJbjubaT68TOR3x90Ek+0+XusakzhzT
         gDoH1bxmV89yWp+wgxRkw9+tE+4CAVLdEOmA29C4AN1vYlpOCVa5wguRZLZG6TyjH2G5
         NqtmEccSMZTdxnkUWzvDdw8qoWUj1rfPUf8hjLBZTyNav/WzXUu1p1zhqzcG3UaprJmm
         DDIIfv96uC5CKaWEZy/XVe5/MoD84XbkAVzNVjJuaS/DZnDZt3Hg2nYpvD4ZVi+NZ3JM
         MDBI/P8J/RBz26Tkbgz6ubLPOyQ90FICQ0LfU6IZe126z6/QepPX2uWumXqfG1DoGTy6
         Vn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QGlP82Eu25B5hGZnnT9A9UklfdtidyshYVusVAvyY3M=;
        b=D1wWaoXxgxHen3yK8HWeIHJ1gBs9ly+Apq2TganozlCux6+8Wnzb9SdpPT5FA/S5fH
         Ffm9imMJ75UpfNIa2104St4ONq2Mn8PjLW6pYGo+khoNJPt6/Gkn5L8JUXET3gr15zUN
         9y6daeQevVpoJfkYZ6QNOqGQU/U52fWqNRTEvx0K/7PU4+fLrKsK6mPjUxxj71C9QCoU
         KHb61GuguHrhv48AuZgEGtsdpkZH2sVS+NV8UVEQxdRzjMzu3QOH78v3R7ACaPVcRfUa
         dQ4sWrf2lGg5LCImKJ2DDfCijB2X3LiOr4lKL8kYM68TV0NCLunPzoCT5Wq5+H5sGz1h
         6Lqg==
X-Gm-Message-State: AIkVDXIZB4LEuzt7/e6wcBn41Yp834tQjCxNj8ujdYKBplhraNErnxe4JI9qMgl/L9jFx81nKEztivzUnAnWkg==
X-Received: by 10.55.180.129 with SMTP id d123mr34569606qkf.158.1484667068748;
 Tue, 17 Jan 2017 07:31:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.66 with HTTP; Tue, 17 Jan 2017 07:30:48 -0800 (PST)
From:   jean-christophe manciot <actionmystique@gmail.com>
Date:   Tue, 17 Jan 2017 16:30:48 +0100
Message-ID: <CAKcFC3aqjLNUNKPDZ08rO_SBkY84uvHBerCxnSchAe8rH0dnMg@mail.gmail.com>
Subject: fatal: bad revision 'git rm -r --ignore-unmatch -- folder'
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I'm trying to purge a complete folder and its files from the
repository history with:

git-Games# git filter-branch 'git rm -r --ignore-unmatch --
Ubuntu/16.04/' --tag-name-filter cat -- --all HEAD
fatal: bad revision 'git rm -r --ignore-unmatch -- Ubuntu/16.04/'

git does not find the folder although it's there:

git-Games# ll Ubuntu/16.04/
total 150316
drwxr-x--- 2 actionmystique actionmystique     4096 Nov 19 13:40 ./
drwxr-x--- 4 actionmystique actionmystique     4096 Oct 30 14:02 ../
-rwxr-x--- 1 actionmystique actionmystique  2190394 May  9  2016
residualvm_0.3.0~git-1_amd64.deb*
...
-rw-r--r-- 1 actionmystique actionmystique 67382492 Oct 13 09:15
scummvm-dbgsym_1.9.0_amd64.deb

What is going on?

-- 
Jean-Christophe
