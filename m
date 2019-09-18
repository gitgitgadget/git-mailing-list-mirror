Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA90E1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 11:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfIRL10 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 07:27:26 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:42260 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfIRL10 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 07:27:26 -0400
Received: by mail-lf1-f49.google.com with SMTP id c195so5401377lfg.9
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ak0kIudHJnoxcBHEhcpHYIOU1uszqjWN+zFvJXTKfLc=;
        b=QwNMwjuao/CYmhqH2YqbxBrBGib9bts4+sjGzwtPSS2OPVZy/SCpneMqt3WA6TOl5e
         qFlAMhNPBXFHVXSmLLR++t8qhsGTe1rJbU2s+23q9TsYZvakc2m2DdGqhvbRBOm4efKW
         dvHhoQant3I2CQDyXOmHtQMPArB9JCGPZeP/HVDV1rTF9F7oDIalyFDAD2mu0zyRbl5q
         VDqi5si621Vtwc2gtBB/z/b9otVXQJkrTSTqvqy6ScrNJl16HCgQaeIiGDXmqTNahpLj
         kzruakk2gMpOfa4DvZh3OdDJ5S4FOXl5WY8a9M593WVqI1huLkOYgnHeg2zdF7XXeTET
         vQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ak0kIudHJnoxcBHEhcpHYIOU1uszqjWN+zFvJXTKfLc=;
        b=juwVUJtQSY/YcqcEwkn/XB6+7o1Lef6ThnPL6FCQ3DRzmBB75OhCI6zu80d49Q7nSF
         Q/QZA0uJeB13QflnXRTYTCxoQSx73mEAQRTe6Qvier/bydxa4AGVFyc7lzN2j/lLHesr
         rvym83wm9POxLvugNJDsPbpY08jzh/cKQByCNLqYw28pG/xwa9mUjJhmyKkGSWvVltFV
         RogIJQ8Q3JyPax9k4QRUuTGW2OBVjnuLWtTVYagWffMbifJKOLRfuS3FpnAIan/HPRZK
         6L709SzvaEIUIb43vcPNu8QZ5FpzKD+mpR4Pr0FLZACdLr67up/VIJpt7uPXGDk5YdBK
         VyZQ==
X-Gm-Message-State: APjAAAXzXL+1MUslH/leQtLPbsie2/dJ6Ck/+mIHs+dOkLPD2rEAD29V
        CG6O8UWnc/okmLT7L0wqjGeuO/scEMFbyP52Ud1IIv5nASg=
X-Google-Smtp-Source: APXvYqzu/wwJuWDaueqYdmNz8vcvdpS0U6JGbrn8faRMoejh4d3VT2g/TvBNQOpMjsaadSNZUwaTulKikG2ctfJAXhg=
X-Received: by 2002:a19:f801:: with SMTP id a1mr1688616lff.166.1568806044282;
 Wed, 18 Sep 2019 04:27:24 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 18 Sep 2019 13:24:40 +0200
Message-ID: <CAGr--=KC=OPMJZB883MWys=J068cdZNHL=eOYK81fNBEv9MhvA@mail.gmail.com>
Subject: git-gui: duplicated key binds?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


It looks to me like there are a lot of key binds duplicated in the
git-gui source.

For instance, Ctrl/Cmd+Enter are bound in two lines:
bind $ui_comm <$M1B-Key-Return> {do_commit;break}
and
bind .   <$M1B-Key-Return> do_commit

I guess the first one is specified to work in the commit message
widget. The second one is for all widgets(?).

Also, I see that some binds are with the "all" tag, while most are
with just a dot as tag.

Is this a mistake (aka something I could write a patch for)? Or am I
just missing something?

[0] https://github.com/prati0100/git-gui/blob/master/git-gui.sh#L3835-L3928


I propose:
- replace "bind .   " with "bind all "
- remove duplicated bind entries, if a key is bound to "all" then it
shouldn't be bound with another tag


Birger
