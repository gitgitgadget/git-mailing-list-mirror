Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7408A2095B
	for <e@80x24.org>; Fri, 17 Mar 2017 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdCQKBV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 06:01:21 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36055 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdCQJ7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 05:59:23 -0400
Received: by mail-lf0-f48.google.com with SMTP id y193so30912746lfd.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tyobbhGKcq10PcWcQWBWbHj16+vh8kH4vbfa0WI6V9M=;
        b=bCigqbTqKLrC8c3X44UYD9DiW0hQAwoZXydJ50y/QracEqOKKqax9ZEpUjB1IItQU5
         09gWmYo30h3m+GXFdS6TQX7hCrYkb2oHEP/hGPnGyEzkzA9tYff8EBY5WFbSKu+UDfl5
         F4OJvoxK9GB2ygCwM8gbQRc4sZoiLDvD1Sg8H9ML8tJQL3jpS1LT0HAQfdl+zMmmlbN+
         PCOnxcowWyW0rreWyckhgk27zO0+7hxYmnzLiQN9+N5OQAXNvoFhYofSIrg3bh1j7qzf
         2c+vFR3+vHT3SggNVe9FkSIC5bQsd0AjXiL4nOgXF66DzyKLklywABJ6A50JOrxSt11C
         X2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tyobbhGKcq10PcWcQWBWbHj16+vh8kH4vbfa0WI6V9M=;
        b=AREgISPDRfMKgBuieFk/73yW2Jj2eBsmXDcDRlJoy6glTOIGwRRYwNT1SlKYMaW6yJ
         bQCgc87VJATeWteR+CjKN3W9mzxJW6JY1aoa0+heaYkXphtajXGqjLpwH2kv/gobAmRa
         Wnyuh0ew96TeU6cZasnuExTCX1Ol4Xkjcl5Do2yEybFmhtdvxG4BCchy7bIVx7TphuWM
         OlWDLpTwn713do+9tDzw70zYkvFNF1vS3I8szPxm5qE0x3MRhThOokfaAyZ/x5Yh/dnd
         LieIPZo5DBVjyfJkI9vuktoxpzYECjzV0PIemKZWWDeL4a2HXF2TsQAfCAMQe73Xp/h5
         Mahg==
X-Gm-Message-State: AFeK/H0kJ8jFT71LCX3El7Yoi2wOAs//Wd/EhTunKwiF9zYzDFo/SL2JT5QAJcxhSbhacRKrXdgZzUqUalsB5g==
X-Received: by 10.46.15.9 with SMTP id 9mr4674159ljp.108.1489742929346; Fri,
 17 Mar 2017 02:28:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.33.9 with HTTP; Fri, 17 Mar 2017 02:28:28 -0700 (PDT)
From:   Vish Gite <vishgite@gmail.com>
Date:   Fri, 17 Mar 2017 14:58:28 +0530
Message-ID: <CA+vHbJL5QMmtzRjQ8tV9Ntrh8=2bspPLeu=34RVFeDTVUhEuWw@mail.gmail.com>
Subject: File names are considered case insensitive in a folder. (aBcd.py
 ==AbcD.py) Inbox x
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git 2.10.1 on Apple mac is treating different(uppercase/lowercase)
files as same name(e.g ABCD.py and abcd.py)

In a project where file name is same but case is different, either
ABCD.py or abcd.py. There is always one of these files is modified.

Below is the git version on my mac.
snappy:myproject$ git version
git version 2.10.1 (Apple Git-78)

Where as git 2.7.4 on Linux Ubuntu xenial is treating ABCD.py and
abcd.py as different files.

To reproduce the issue on mac. Clone a project that has two files in
same directory with same name but different case. ClassTest.py and
classtest.py


Thanks,
Vishnu
