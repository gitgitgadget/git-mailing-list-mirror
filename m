Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99751F453
	for <e@80x24.org>; Fri,  3 May 2019 15:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfECP4I (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 11:56:08 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:44578 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfECP4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 11:56:08 -0400
Received: by mail-lj1-f171.google.com with SMTP id c6so221147lji.11
        for <git@vger.kernel.org>; Fri, 03 May 2019 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Qba4PpWy4J1BlmbbRVoNIu9RC9JXZFvx78PMYM+QgPk=;
        b=JAMppErs13XLnOAJKwj5cznLcHErzFDJ8tgSpiKgEWTJTJmy/SOgsW9l+E1e1w+snU
         o26uVfztyLih+Jm9laS8cCkh/jH1avGV36KGCqPEJaWogFXbKQNFsf2nKefpTYHhmeQy
         68QR6JGu2GpJg1OVkWDDrzK6la2l7DKWTxPdeUVI0UXuIDHF7g/ilCYQlHiOWR4xBY5v
         yr5upjzknM5IhTkrVRar9S5W8VUggeSSU2Vp1ChHv0TUUM1RbIubXR1E1iWyH+q7JKfj
         ++OFnvTJvg3mHw8hL+HXNJxazQdBGcCei6H076QSPJX5ydFaQMzIPe6ZmcBeufdyphes
         cVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Qba4PpWy4J1BlmbbRVoNIu9RC9JXZFvx78PMYM+QgPk=;
        b=aQW7IaGP9Eavho8yxIa4pPPENC4eWL95HWJYge0gvh0cy6+gPt/k07Lut/Dhk5DklC
         Ajg6UtLNtyeN9M4SrDg1HhYut8kbD700JDLOuBEHPfiJSiOOSr/jPr4+FAIedMNLMrAj
         1vbpxLgK5DqQZLgdUKpcvmnUDsQH5mJLGgO12GYd1p3xgdMEv+oS4RLf7TU2Q0ZwFpO3
         UhTXWk/be/4FvSaLzwHI6jYtkm6Apzn/I6fPCKRHOBhj/OhUsw79SoSqaeFZTGNp65wp
         ooYQFRecOxZ8Mpkw5b35IW3IqRwV+7IId3/o8NcvOOG4cluIwJYPCnvt1vt+gzvXdQ1F
         Z0Ew==
X-Gm-Message-State: APjAAAVhdE4CEpVoX3O7rfNr00H7iNg/dtbFYe7LWaoI4TFcGQE0ZiCK
        6daNLPOGfMhorHdaw4Z+pN0WGs+7Jbd9+9iNgwGIhZum
X-Google-Smtp-Source: APXvYqzvBCqF1dl8Zt2/ImjsB0KFQA2d0lVyL9V5IjNDHqcZUpeE1wp74OI2KtKhowAvvYRITKQ+8/2vSsPAif6ZCbM=
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr5459379ljn.147.1556898965989;
 Fri, 03 May 2019 08:56:05 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 3 May 2019 10:55:54 -0500
X-Google-Sender-Auth: SNseyGHd-I8ZQqg8yLtgves5oQ8
Message-ID: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
Subject: Merge commit diff results are confusing and inconsistent
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm hoping this is mostly a learning opportunity for me. I'm assuming
things are working as designed, but I just don't understand something
fundamental.

I have a merge commit. HEAD is currently pointing at this merge
commit. To be exact, HEAD points to master, which points to the merge
commit. My goal is to diff only the changes in the merge commit (stuff
committed directly in the merge commit, such as conflict resolutions).
To start out, I learned about @^@, @^!, and @^-. @^! sounded like what
I wanted. It gives me this output:

$ git rev-parse @^!
21f5a4b9fee4f12e7793919f65361d2c16f7d240
^14bd840c1d591c9dc066ed1aab59b5ec14d502bb
^944af379480826764f2f31b67848e2885b95b4a6

Perfect. This should give me just the diff of 21f5... and exclude
everything else, right? So I did this:

$ git diff @^!

However, I get *all* changes on the branch (second parent) and changes
in the merge commit itself. Basically it acts as if I used @^-, which
seems wrong to me. So to test another angle, I used the revisions
output by rev-parse directly:

$ git diff 21f5a4b9fee4f12e7793919f65361d2c16f7d240
^14bd840c1d591c9dc066ed1aab59b5ec14d502bb
^944af379480826764f2f31b67848e2885b95b4a6

Interestingly, this showed me only the changes in the merge commit
(21f5a4) and nothing else. Between this command and @^!, I feel the
two are exactly the same. So why does @^! not work as I expect, but
explicitly specifying the revisions does? What am I missing here?

When I use @^! in `git log`, I do only see the merge commit and no
other commits. So at least log is treating it correctly.

$ git version
git version 2.20.1.windows.1
