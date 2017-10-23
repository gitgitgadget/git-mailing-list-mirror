Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D391FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 11:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbdJWL1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 07:27:09 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50802 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdJWL1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 07:27:08 -0400
Received: by mail-wm0-f51.google.com with SMTP id u138so8829235wmu.5
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+f+OA1ShI4xKi5ppGTis4SiOO19sZyQttoFeWSRHntY=;
        b=lY53yk2NPVSyr7VPSki8zqxSNARD92ZyYGl8GiaehwlWY+l8BloJxi4B7WIjfltijd
         mSJTrUxxUEdZ3FQhgeYhbLlvTB6wFk0aue37NYEckmHSSvsXxMAaLI/Aobz932cYTmCk
         lnTIAbwUzT4CDGY7SSt6XXpHeeTheYQ2VflXcgT5pDfKEb6ndSnuZ5vhaYw2DkzeF59+
         +oORo3vgJ+Zo3tJ4xBR2w1QZfESim3fD8LWRJfnQQ9NraU3laPIgesHh7Nla4PbzN2Kr
         5A9ZgRrFqq2H91zhAR8FzlsLNW7ULbA+j8kCstnz3M3W01RQV2ZWqAX2n/qPwZZVwDdc
         M/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+f+OA1ShI4xKi5ppGTis4SiOO19sZyQttoFeWSRHntY=;
        b=IuhFyf7PKR+Nvp73K72vWsL+prp2e0Za3I2nsUpMmpwAb+9Hl4wJeeIYRWqkceR6Kz
         KNNo+hWgJwsxazcaKah6THUTLjqoL3d9cV5fF3cPYKYPIvXg0OpPVN95vGem/6vU1U8c
         cxrf+Ywwg9aZ447VMI0xfrJN7lethWV9rSvCaRi57ARj1C7XQaZTWfnHw//LRm61coHo
         WvUKRWVbfCSAX+BgjjNUJwY95J0TrX96PhzlPNzQuxscfG1wV5VrtZl1pOKmCNpWWqXv
         OdR5YxZwI+2oxw96RVbDn4eZOwdqvApmjcsF0Fy+iSc1P0BdPKoFhHuGfgZdMWBcq2fo
         WIYg==
X-Gm-Message-State: AMCzsaU4MNkXmVGBcpU7smmWxIkv3ulklLiZApGNa1u7W3/EIEwjzh4j
        yyxJkBuSxCiNJoCfFoGLQGzPEEwWU8xZtSxJJg==
X-Google-Smtp-Source: ABhQp+T2qgM6DqAdhKSN9bfpx3LWFOoL0nWHZMw2SQxAekqIgJY/vlBgylBZ1ZuWewDeJn22hori8Xkw7RwBXhp3nHU=
X-Received: by 10.80.215.209 with SMTP id m17mr2536947edj.63.1508758027206;
 Mon, 23 Oct 2017 04:27:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.137.123 with HTTP; Mon, 23 Oct 2017 04:27:06 -0700 (PDT)
From:   Yubin Ruan <ablacktshirt@gmail.com>
Date:   Mon, 23 Oct 2017 19:27:06 +0800
Message-ID: <CAJYFCiMJLL-gq5rwHRx1NYZP2iev3g4vXKXh1rDcxW6dCifoJA@mail.gmail.com>
Subject: checking out from branch A to branch B brings along a folder from A. Why
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I got three branch: master, A, B.

I have a directory in branch A: "/path/to/repo/somefolder" (and that
folder is in the working tree, not working directory), but that folder
doesn't exist in either branch B or master. When in branch A, if I do

    $ git checkout B

that "somefolder" will be brought to branch B (this is weird)

But when I do

    $ git checkout master

then it will not be brought along (this works as expected)

That is weird because AFAIK checkout out to branch B will not bring
any file from the working tree from other branch.

I have tried to updated git from 1.5.4.7 to 2.9.

I am in a CI server so there might be some mis-configuration. What
should I check for? Has anyone ever encountered such a situation?

Yubin
