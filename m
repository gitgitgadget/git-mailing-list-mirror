Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E60D20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 06:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLGGKv (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 01:10:51 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:45818 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGGKv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 01:10:51 -0500
Received: by mail-vk1-f173.google.com with SMTP id n126so690569vke.12
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 22:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ouENCbiDs/G4lG+x6pQfrTwmrXLmhvAiMzLrdSv9ihE=;
        b=JuZQA2lsm0WtW2wLElPJ6/b0FcsHfWN5FilQyuDcD5bOdXTGCETcQOh846F7bnLKfH
         DcHJ+0zuSsmNly5iyW3Z0KubuhBEl6Nls6wNxjfoLEbiDIfvxUHBA1hDJqQDivpv8Zgp
         mVDvPcSZekXqlFo8oBW0Mj797m6BO8Q8n8iTwxb+Vtmo3LAzOrhU0U+B7k4ghSi+NzGa
         FW23PEHO4pgbWCrjf/CxNA3greTMBbPtSzXiyc9phOIRSnjIUb7h4PVoKIalF3EzT87F
         vcB+669f2WEZ/C2JPU0+j8+uqMiYQNMukKwxOtXM+SSkRona6V2dPuKVtN+M3VYtqf2w
         rnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ouENCbiDs/G4lG+x6pQfrTwmrXLmhvAiMzLrdSv9ihE=;
        b=VTxHID34F4DT0ctc6P2u71YFxSIMsqnoeh11A7KHK373nLaGybgefMfXKHwKU4L90m
         N92d9Ng579la6yORNQBAsW7RcpVtxMr6YvHinS36QyoqUDYLTgKanYBEH4b7kBJcVFuw
         rHpQr+usURwWvDdIzJ+2qrawIttT/QU8j34mRkiLLwLdknNUxfRhCwcE8mOPg1lOFGOJ
         ih/yfGuwqQpZ9Y9la1fGr5ZddqpXV7wcFuzLfg6FBBkDZnjcVS8FkBg4QF3BFkLIFxi+
         WSwZK4U5wPsmVwdiCZNDMCf+gsJICkQZD0GkF09hqDLpRtZ9/TDV/HANHFV12LcoCoZ0
         b4Pw==
X-Gm-Message-State: AA+aEWatDPI6wK+v3aIjUE2CHX5Um//u73Mm8fQpLqzC8v1MUbn/YtaW
        TdCkZouAj9Vgrp+i45IxBefbWkimdYTwoL/NYFebUPwrUYo=
X-Google-Smtp-Source: AFSGD/WdeRWC5vJ1GSTABiLXd5/Rbb8ZneZBdXH0jHW2pWCpGd8K3XGpucoAVTCqRcSgmSp+990gTnCa7IATKXmpihU=
X-Received: by 2002:a1f:24d3:: with SMTP id k202mr344856vkk.45.1544163049780;
 Thu, 06 Dec 2018 22:10:49 -0800 (PST)
MIME-Version: 1.0
From:   Eric Work <work.eric@gmail.com>
Date:   Thu, 6 Dec 2018 22:10:38 -0800
Message-ID: <CAGqRQN8XmCJ=_qqPNxmt3B=KUWNs6Yx8Y0q7hLNWJrP6=4rgKw@mail.gmail.com>
Subject: Issue with git-gui and font used for widgets
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have set my UI font in the git-gui preferences, but it only affects
the menus and certain widgets.  It does not apply the font to labels
and buttons.  This creates a problem for my HiDPI display because the
fonts are quite small.  I've never programmed in TCL/TK before so I
don't know exactly what is wrong, but looking at the code I see where
it's supposed to apply the font option to the widgets in a foreach
loop.

foreach class {Button Checkbutton Entry Label
    Labelframe Listbox Message
    Radiobutton Spinbox Text} {
  option add *$class.font font_ui
}

But that doesn't seem to work.  As an experiment I added the -font
parameter (according to the docs) to where the branch label is created
and that worked as expected.

${NS}::label .branch.l1 \
  -text [mc "Current Branch:"] \
  -anchor w \
  -justify left \
  -font font_ui

I don't know what is the expected behavior in terms of setting fonts,
but I would assume that is not expected?  It appears to be using
TkDefaultFont instead.  The default font being small is really a tk
problem, where as setting the widget font is a git-gui problem.  I
created the following bug report against tk to get some feedback on
the small default font issue as well as documented a workaround to
allow per user default fonts.

https://core.tcl-lang.org/tk/tktview/dccd82bdc70dc25bb6709a6c14880a92104dda43

Any suggestions?

-Eric
