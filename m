Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E2D20401
	for <e@80x24.org>; Sat, 24 Jun 2017 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdFXQ4K (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 12:56:10 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:35678 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbdFXQ4K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 12:56:10 -0400
Received: by mail-ot0-f173.google.com with SMTP id u13so48070990otd.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TQkRoIbu1vC0jyIECBSSH2X+j8fHQlh3zG/NzIv0wUA=;
        b=tEkOKjvIqvRunp/yQyHRbAPSu52WI8bRsFVQ/TyQSvNqmrOwKkjFBpK1GOdlbQQGZq
         mk2fWSgaue2O8Th5Ys/zd5I1O0IJm1amiNpHlHM17CPqLJHk0pp9fmRntp8o0o9Drkvq
         L+v0UCqidxNk5DKuPsrdv5Bd8AFBFqLGO3qSutRUD4Hh2NecaBK3t0BPQLngXIDPqXtl
         ssn6pHpbHUMvhED331kfCFqx+dM/nTTwsaiHgFooKhx13ueV1pdSEfKlCWbEKM1d89nP
         h4IfY9ywSnvqonQWDvCZx/5ppuNt4klKPEvHHLbVJ5Gl9CyKRpuuANv98YoNehn17+8+
         ZBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TQkRoIbu1vC0jyIECBSSH2X+j8fHQlh3zG/NzIv0wUA=;
        b=mMj2tqIs8z3N4QNNl4ivdwgf13mE+f25IO14qlSveooVTxx0c2CV/ddH+dfOQZqpvv
         LErD0JxYlKIUqyZEZz8TAgtAuhdBX1pAGU0gRiVRbTYMDtw2qx3FCeCS/Hv+ESXTTEKd
         el+Q+LPIIkokN39ekWT4GoH7gLqYoQsErIs9nn5qfuU2QAqICKL8PL9uBslnOihn8uqd
         vUlwsnJ8yrBbNgXj23hYCRvhXlmIa8i1AvP7p0XQCdOH92FTOOPv8wCBh4ObVCyRFr9g
         NuU+/+kTRxfrqi6zE6uX12EAhP8R0UJVNs26Wv9bC/Vz/vZ181BJEG8yMeBnLSLtunCs
         /ytA==
X-Gm-Message-State: AKS2vOzV11s/Am3N6n7a2i9WpPk75dUOHc2DLoiY37urrtsKwAOHJHtq
        dth2MzcZw59PxO3M+B4UuOb5oEDmVRfPxPnObQ==
X-Received: by 10.157.63.8 with SMTP id m8mr7578429otc.4.1498323369191; Sat,
 24 Jun 2017 09:56:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.89.15 with HTTP; Sat, 24 Jun 2017 09:56:08 -0700 (PDT)
From:   Filip Kucharczyk <fil.kucharczyk@gmail.com>
Date:   Sat, 24 Jun 2017 18:56:08 +0200
Message-ID: <CADtLFZcQNziGJx-aW9pvUU-NTHcbRN8pHXecMtRgaYwqTjGZWQ@mail.gmail.com>
Subject: EOL LF Windows auto.crlf issue
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm on Windows 10.
auto.crlf in .gitconfig is set to
[core]
autocrlf = true
I've got a git (git version 2.13.1.windows.2) repo.
A linux guy emails me a text with with line endings LF.
I paste this file into my repo.
Now every time I introduce changes to this file and stage it, git tell me:
"warning: LF will be replaced by CRLF in a.txt.
The file will have its original line endings in your working directory."
But when I commit the file git does not replace anyline endings - they
stay LF in the commited file and in my working direcotry.
I'm sort of misleaded by this message.

Filip
