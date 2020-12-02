Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E1C71155
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 10:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E098221FA
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 10:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbgLBKIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 05:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388089AbgLBKIy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 05:08:54 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E675C0613D4
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 02:08:14 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id i62so265172vkb.7
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 02:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YF9NHDZNTqaWBkPxiVWpfaTJErM1PTNnY71m4ydmfrs=;
        b=mh1o2Phmfi3lZB0b6kqnFCQK5TD4qMummSJ3RmCC6kjX5MhGXmvOioNX3nt6gZ2rm2
         mHe0ibJG9F/05jZ9RdYQ+ouwVkq7vbcFSJ94uhGqGRybaiRme0/cLlsOCine/DvE23TD
         SUTk62pffgzVMUEsKrKSKCtksAqP9FlbxLjFJ7lm3JbF2xXrKXTBazUj6wht2380G6Yq
         SQFErzpZeNZUWQVxJk0Tr/21LMW/ZQKixiV3mEgg2kok5WNQqsCUfSlupgsyhp5F0qQ9
         iR/HX/4aY6TDQcnfrx82xCtqOTlEaKXMHQOnI3NLr23MGiobwCrw3Su5dLuZBIVaPmaF
         vBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YF9NHDZNTqaWBkPxiVWpfaTJErM1PTNnY71m4ydmfrs=;
        b=TGAnQIJkpW6a4u5oifO8ZZrKRllkfEx8byrEAObxCVTsdLDhwQEP698IO03epma+S9
         QlbcNb2VN1LcanTE/DeD8CFou7A7/R+ev1RRB/76d8YHtml6ZNcVuubP3j9FfrNdRuLk
         p4FOUYDwJDKb/ZWm5IXxdo3N0FkhVugtHjUND9/OgmS1T0HLTPbqhJ1Ulyelf8SG5jIC
         coKbm0WUdXjqd+IwGVELUrznsaQVLso1+kmgwOvapdAWBx2EyzJjxM0OMsdzriqcDXg9
         6oLNvSZbl7uxJ9jb1sZ466jy3fkP2mOZ0CFuDV2L5Vkt1HOcXhGZe8nr7gflMNBCswqx
         yVjQ==
X-Gm-Message-State: AOAM531IgvH9Lk/37tV08Isc1cnjHm7R8feDayMfNyIs3rcLViBwZNqJ
        kIxFU1tq3N+37yPINhURgb2T2cPll+6CKK5sZvLFI6U1cW2vDw==
X-Google-Smtp-Source: ABdhPJydVKEzJr4nZei+K8nIAX0C/kmk7Do0dfD6MSO2k+kKOPEG3XCdLcbRrH2vfD7ab9Pg0WK7QQj0pZDk5y+fBW0=
X-Received: by 2002:a1f:5c4a:: with SMTP id q71mr885845vkb.1.1606903693051;
 Wed, 02 Dec 2020 02:08:13 -0800 (PST)
MIME-Version: 1.0
From:   Ole M <superole2@gmail.com>
Date:   Wed, 2 Dec 2020 11:08:02 +0100
Message-ID: <CAAhqouLmyfj=c58mFmvkBOtTtyoM_c9uO4T==h2T9y6_tb0nrQ@mail.gmail.com>
Subject: bugreport
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
* open Git Gui in a repository from git bash ($ git gui&)
* select some text in the diff pane

What did you expect to happen? (Expected behavior)
* selected text should be highlighted with white text on blue
background (maybe it used to use system defined colors?)

What happened instead? (Actual behavior)
* selected text is highlighted with white text on black background

What's different between what you expected and what actually happened?
* The contrast has increased to a level that is painful for me to look
at, making it difficult to read the selected text.
* It also makes the experience of this tool different from gitk,
making me focus on the tool rather than the content and workflow.

Anything else you want to add:


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.29.2.windows.2
cpu: x86_64
built from commit: 3464b98ce6803c98bf8fb34390cd150d66e4a0d3
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 18363
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
