Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3169E2095D
	for <e@80x24.org>; Wed, 22 Mar 2017 22:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbdCVWq7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:46:59 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34830 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbdCVWq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:46:56 -0400
Received: by mail-io0-f175.google.com with SMTP id z13so73057551iof.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aqC0UHi6aR5k1CMChGPSCEE0528Su+l4bW4twfB5/8Q=;
        b=CSS/cbPo1oF/952vf9sL1c3zN7wz/8KxWasYv+rZ95zlK0s+ReN7LCJvLguTij4fTl
         Zul+vJjrAmq4sJcMVDDfSw/NwzpkWc6W8DRwn+S+zfTX2tbi6xxTDscOdyiC472XkBCw
         yxGMY28XjfoS2GI5CBGrLXfGZKGG7IYaFTGJOb6+kk3g96T2NAx/lNZSMyXobx1gakeu
         cCxt3xCyu4ytbHupB0eiS7I2o0xiUXOCQOBqv40OdiFVlhrUSVYQOjAH2+4oMywACitv
         Ct7fygqUyi554zzKlS25fXH3/EZZ0is+nGrnomENtEmL77NVyW+9ir6x8Tu16sG+8VLN
         8ZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aqC0UHi6aR5k1CMChGPSCEE0528Su+l4bW4twfB5/8Q=;
        b=jOtRXuRlkTlCnF98DSepEjLoXBOLvCoKs9VDDWKJnhk4oje6/gthfrLXXC3b9mYr8z
         jfrDWNe+yB3CDpUB+snwgFGhiqOkpnWvd1+O1YMHVbkldPNh0pVwUopT+D77y1P0GQZ7
         bBfN6e6ZHleo9xKLn6yqT+7miKJWzSqfeD2NStgDma0l2CKVxMnvV4oSiLH4iSMdJVSM
         xMda75hGQRxn6TJhwXb1LgrCpRd8Mze8xcMZhmcw1IVoEAjf4tDakrwIR2TOw1R2QMZr
         wuaHEfFZsNMgfiT+TMsl5VUWejIn6QsfiU/wBItmwkTxmkknENNgfuRca49ArflyXEJ9
         iesQ==
X-Gm-Message-State: AFeK/H05j+r/msCymMGn68drHzMSKsHuCPyCKvwgqRsNlTU3cRqFGsA4orwM2kcwh0egrdknn3/1G1Gcz85Ivg==
X-Received: by 10.107.32.199 with SMTP id g190mr17955320iog.117.1490222795330;
 Wed, 22 Mar 2017 15:46:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 22 Mar 2017 15:46:14 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 22 Mar 2017 23:46:14 +0100
Message-ID: <CACBZZX7NDa5o1xSu4HgZ4=kG3mx3U6ja7f3E4yAkFOHDsLdMjA@mail.gmail.com>
Subject: How do I copy a branch & its config to a new name?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I start work on a new series I have e.g. avar/various-tag-2 with
its upstream info set to origin/master.

When I start avar/various-tag-3 just:

    git checkcout -b avar/various-tag-3 avar/various-tag-2

I don't get the correct tracking info. As far as I can tell there's no
way to do this in a single command, either you do:

    git checkout -b avar/various-tag-4 avar/various-tag-3 && git
branch --set-upstream-to origin/master

Or:

    git checkout -b avar/various-tag-3 -t origin/master && git reset
--hard avar/various-tag-2

But both of these are really just a limited special case for what I'd
really like, which is given branch "foo", copy it and all its
configuration to a new name "bar". I.e. both of the hacks above only
set up the correct tracking info, but none of the other branch.*
variables I may have set.

So I have this relative horror-show as an alias:

    $ git config alias.cp-branch
    !f() { git checkout -b $2 $1 && for line in $(git config --list
--file .git/config | grep "^branch\.$1"); do key=$(echo $line | cut
-d= -f1); newkey=$(echo $key | sed "s!$1!$2!"); value=$(echo $line |
cut -d= -f2); git config $newkey $value; done; }; f

Turned into a more readable tiny shell-script you can call git-cp-branch that's:

    #!/bin/sh -e
    git checkout -b $2 $1
    for line in $(git config --list --file $(git rev-parse
--git-dir)/config | grep "^branch\.$1");
    do
        key=$(echo $line | cut -d= -f1)
        newkey=$(echo $key | sed "s!$1!$2!")
        value=$(echo $line | cut -d= -f2)
        git config $newkey $value
    done

I couldn't find any previous list discussion about this, but if not I
think something like:

    git [checkout|branch] --copy src dest

Would make sense as an interface for this.
