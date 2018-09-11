Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0381F404
	for <e@80x24.org>; Tue, 11 Sep 2018 15:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIKUZa (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 16:25:30 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:42864 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKUZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 16:25:30 -0400
Received: by mail-ua1-f43.google.com with SMTP id w7-v6so20945120uan.9
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Qdvn7napmM+Xa13/0XkBY2WUGPafDKQPWG9r5q9jEQE=;
        b=Ag3u75BZfzZ8U0m5fIQPSs0xuY+8MshpZtbK9OgBQMVsLo4XzsI+CjtY0aU9RZm9F3
         uqCbxsQOcIgd2oexuAPYw2G857EKRjue70vQluC6ojFf316iAuhhPKu5TAiz1dOI6aSo
         usCUQIZxPKfEMP8NBLjPMUv7cy752Uet/PsA11QQ9bgDgTB3dGhO2TIiusTyGoqsflzm
         Fjz+fDxGrOHDJ92cOtvRZAcsD89xJgRjd+HSGHLnTPESAu8pFzbWizjZljdq5xg1mK+0
         SkH8Ar8MwPJfb3ez7nEd+liR1iY8XaTL6fPhQvwJLUlG9u0A66HluNdsUHA2xLh6t2xh
         GEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Qdvn7napmM+Xa13/0XkBY2WUGPafDKQPWG9r5q9jEQE=;
        b=lq5kC0tJ106DRFQuEYyElpaxOjtDGm8HmRyWmHMzB+YFY7SCZXmDCYY1Th/kmSMbB8
         ramULla6GbxTWrinoPCDww42kkbI/3OrEHUCp1Zu+8dQWFxOZlG77kOeICXDjHcFVxMa
         bK0qv4dzXgeBBycJycIWLuohCUT0dYVG6c3QceQILQwWh02EQ78WkXkqKf2D7/JEHguU
         QwCEK+0Y8XkIfpJXYQidXLV37MNlitjC9xaFIx+Lui82Adg24iOII/WuHkQi2z+wVpX/
         dNwGXSQn7+NbMJ6kNcU0tWEul7fZvksR8893of/S7QQOlID+Lq7kfA/pISr7Zmw9POmd
         nL3A==
X-Gm-Message-State: APzg51B/T9GhCU5Yz7DiE8vD+yzapp6q8Xw9l+LntbU6O2Qjv/VexE++
        sj16VBDrUTxNdQn0BV1xORTAjo2+8cFVXkkhw56L3RkDsSA=
X-Google-Smtp-Source: ANB0VdZBGqL1E115jLA07YSbekGQ5b1xOmP3VG0x/G2cp3gKZciaQD895RYgKk9AIMqG0F1pI1ZgsS7jUcyEh+afmhk=
X-Received: by 2002:ab0:4902:: with SMTP id z2-v6mr9009895uac.14.1536679541719;
 Tue, 11 Sep 2018 08:25:41 -0700 (PDT)
MIME-Version: 1.0
From:   ryenus <ryenus@gmail.com>
Date:   Tue, 11 Sep 2018 23:25:30 +0800
Message-ID: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
Subject: Git 2.19 Segmentation fault 11 on macOS
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just updated to 2.19 via Homebrew, git range-diff seems cool, but I
only got a Segmentation fault: 11

    $ git version; git range-diff origin/master  HEAD@{2} HEAD
    git version 2.19.0
    Segmentation fault: 11

Both origin/master and my local branch each got two new commits of their own,
please correct me if this is not the expected way to use git range-diff.

FYI, I've created a sample repo here:
https://github.com/ryenus/range-diff-segfault/
