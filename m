Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868711F404
	for <e@80x24.org>; Sat,  3 Feb 2018 03:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeBCDSQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 22:18:16 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33378 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBCDSP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 22:18:15 -0500
Received: by mail-wr0-f173.google.com with SMTP id s5so24383570wra.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 19:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aGV5vyjbr/RqjLR7DI/O7PORwKKgObEG70QDxF3QLJc=;
        b=BJjyhSiJhDKfOrOB0a8xxVPY5l6Dp07K3I4JnQdrqX8TaN9ZMk8I3/GaUFZ96s34Kq
         XaYDjf/iN3ycVcdJhn7Gb1jMB/ufjf4l+dr4hQGPBKU1qgYa9D6SgNMFDIUmpaj/3a04
         vdX4neYPhoKqoiCcRSp+h4rq60uSIPcp2srpagvekeGFw597trxzvFYnWcBij+WeshNL
         1iMIPV8ef8UCrVSGL3PCSPHxeVfOTWbDPPxtE9SJucTjW+5ts7+wVypaLPpO0uaMS3Zm
         mm7zelvv9qZtb2ihiXneDWotM7MJnSvY83QJs2p/A4GkoX43FARD2loGo2b0WDtL+X6/
         FQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aGV5vyjbr/RqjLR7DI/O7PORwKKgObEG70QDxF3QLJc=;
        b=Ov8RzbARdeOqG/6z4MKSSjk7N7NPvF2uxo05o10mQzhxqAuOkyeREHoEVbmpO7Je1y
         t9O3BMbNaBuBT++w4kyoCr+PQLVTj5k9h/BMrlu5qCUqExZqp3cGRf5M7lE9zVWsQyxe
         ulYRj0unjFHyMyMhYwzdl5sWe4A2PLd4/uivbUYGODS3UJeGZO4P4uKR4zb1n//LB41+
         kCyRSrmX4HMAg8NnS35uxKEHjar/+9hNkkqyNt7qIpPG+U32Vt7B5QGtZ/sMNzwokFq5
         ZWTTSa5ZfBrv7HtK0SbJQywM5MjOuf7JVjGemXW1Z/ItidtGj+BA3hFeqkeSpFn2PYSQ
         WDAA==
X-Gm-Message-State: AKwxytfyyMJGFc102OuTa5UV6c5Ffb/0a/68XRCT5IK12gTeR99GpDcB
        p8Vz5p2lNq6eOn7kWXRW0UD0NUJwz2+8fIUJ570W1aRl
X-Google-Smtp-Source: AH8x2265gyLzOhsnV/ToqSg4uSP3x/rdR0eP27fgcxxDIGb5DUpIKm4hhT2HHhaMYK+o5xOVS1u7RD35HfkmgZ/2c3s=
X-Received: by 10.223.157.6 with SMTP id k6mr21408247wre.273.1517627893907;
 Fri, 02 Feb 2018 19:18:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.142.77 with HTTP; Fri, 2 Feb 2018 19:17:33 -0800 (PST)
From:   Brian Buchalter <bal711@gmail.com>
Date:   Fri, 2 Feb 2018 19:17:33 -0800
Message-ID: <CAANr7CBNhkYJ=u8Bq-NG3KkSYY8yczJCt_25KcZU4VMFsS399A@mail.gmail.com>
Subject: error: unable to create file: Illegal byte sequence
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am attempting to repair a git repo which has an illegal byte
sequence but am not sure how to proceed. Steps to reproduce: `git
clone https://github.com/christopherpow/nes-test-roms.git` results in:

```
Cloning into 'nes-test-roms'...
remote: Counting objects: 1049, done.
remote: Total 1049 (delta 0), reused 0 (delta 0), pack-reused 1049
Receiving objects: 100% (1049/1049), 5.23 MiB | 8.97 MiB/s, done.
Resolving deltas: 100% (406/406), done.
error: unable to create file other/Duelito - L=EF=BF=BDeme.txt: Illegal byt=
e sequence
fatal: unable to checkout working tree
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry the checkout with 'git checkout -f HEAD'
```

Running macOS 10.13.3, git version 2.16.1

Thank you!
