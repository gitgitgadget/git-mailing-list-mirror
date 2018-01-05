Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDB11F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeAET71 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:59:27 -0500
Received: from mail-yb0-f174.google.com ([209.85.213.174]:44118 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeAET70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:59:26 -0500
Received: by mail-yb0-f174.google.com with SMTP id h189so2279922ybc.11
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 11:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=tiu3bRpffq70z3DGlxXnpCzUrFMGcARquw+qlr7kMvE=;
        b=cjpp0R27MaExj5YYrgG9OcA/Y8vtcA5QsrRvs/9VswEO22B85fTnVXorL9V/5FDHsd
         DJdzHCSbZk1SooFQqXeKu5+/fDOwIDlZWIZQQUD0zSF0BSG6W9po63DuRpSyGAVNOXIM
         YSCOXhKlM6vdSECniXVgXPTG5guQcSgI114Z1w47KbwOluoRan1FwXEZQNaxOpBpldQv
         p3JvO5WVTfcTgiUGtUewoIdlf6weFM6ncJk0mtu8IHvHadAV6gKW585ICBy7dSg5VOR1
         SmaQl2e01NWkm0G8ffF8aMGZ6rarwTaYjT/vyDvEH+RpKsG57azZYkdvGeZATV6ygOXJ
         h1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=tiu3bRpffq70z3DGlxXnpCzUrFMGcARquw+qlr7kMvE=;
        b=OjTmNXE4iAzWq593vLRh83JENVoLDZbuTlVSOvykWtqa3X+neMo5Jzcm/OtpGcZrsz
         eEYq4tw5VzaHjNhJoTTjVELJOyyExt2Tq8wGASTKl60deZkVsif/LEpQ0b3hhJ3Tu9Vf
         DYfu9sXvr9hWVmQ8YcTGkE4q+J27fMqmKN7nJhlA3D7vVjPUJFKDikrqbBDC8PtmvQlE
         ILtV7EZnUdrJ7v5dVZqrtxGBlYoynYgv53F7HelkQOD6ofUBrVyOxaa5vdzBozxlsyMR
         cHQYYali5t8zEXTpN3QZ5Pi2ch2SYQVQooQUD02hz9ButcFts2JCGIOFnYiPYMXNFyxj
         titg==
X-Gm-Message-State: AKGB3mJdn9gBiB26F15c6qOFp6zhQJjKC81HKvLxTahTDrnORSdRzee5
        ue9WhrXnCMSodGIDZuxDGxN1ugMxZ1ZYf3vrEjLOzOpN
X-Google-Smtp-Source: ACJfBovRnAzKABE258E7qkqZd7FNwmsRWbABDLeDlLbeh+JZAUq2S5qGnpq+uNK/3dysLCFawHY/TXMu/GrzCv3utFw=
X-Received: by 10.37.162.131 with SMTP id c3mr3925678ybi.213.1515182365843;
 Fri, 05 Jan 2018 11:59:25 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.103.65 with HTTP; Fri, 5 Jan 2018 11:59:25 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 5 Jan 2018 13:59:25 -0600
X-Google-Sender-Auth: 3ITGHuJ9h0C_yIMSFnYMGyPs-TI
Message-ID: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
Subject: Can't squash merge with merge.ff set to false
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure if this is intended or a bug, but with the following configuration:

$ git config --global merge.ff false

I am not able to merge my topic branch into master with squash option:

$ git checkout master
$ git merge --squash topic
fatal: You cannot combine --squash with --no-ff.

I'm not sure why a non-fast-forward merge would prevent a squash
merge, since by its very nature a squashed merge is not a fast forward
merge (or maybe it is if you only have one commit).

Is there an issue here? I like fast forward merges to be off by
default, since I want to control when they happen. Most of my merges
do not use --squash, so I'm catering to the common case.

Need advice on how to get past this issue. Thanks in advance.
