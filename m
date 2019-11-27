Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E5C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E60F20715
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfK0TER (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:04:17 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35840 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0TER (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:04:17 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so26123777ioe.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=03sR69ooxMIEC2KVe1k+D0RLRWl4m3/NYpGf8nQ38XY=;
        b=EZsfDueAzt6vM3yXzV1gQVJY1z0kuh59i06WT2OA+3Ktk20u16cEXU+3M3tXMlzXoZ
         bHepUrMmr8alQ7Xip0vYa730uxZdA6YSVpzOYhJyrvuMTQAF9AnSySMEvALB+DqeAyz/
         hTg+u4KAELjZeBi6DCqALnPO+dE7VkXd2LnIp05UQ78gROLdT0x4i0LHFm7CyQ4/ILPI
         WDeKjRdRFi+b8VxRHfRYzDe9/KVGF9A7odGe7hmQlv5WbfUi8eJ2bswb1ASTe30i5d/t
         i5D01YKwwHioufwRmCsE46tsH2dfeP0mzJShuEytpT7ad/wLNG/qpW7bYixkKKPMyUbL
         uONw==
X-Gm-Message-State: APjAAAV5hZ/j89ydkgeYXa+xIPqVAtyI+Lw/seea4HluUrXt4iNa3iLY
        0PaDI968KjXPIgwEVvt5ME9La3OP60sE02iVFQY=
X-Google-Smtp-Source: APXvYqzVfKG/trrY2PGsm9cmg20wXNecrjLhLePhheEZgQ9M+oCFkYExI/n6B5i0rwKxRYn+UeSlO4XQXMmGyVLSy40=
X-Received: by 2002:a6b:7511:: with SMTP id l17mr8132359ioh.115.1574881455263;
 Wed, 27 Nov 2019 11:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20191125203740.72249-1-emaste@freefall.freebsd.org>
 <20191126004419.GE2404748@camp.crustytoothpaste.net> <CAPyFy2DLYHZnzrwA27JQRxGkpf=+Z8ND-6AX3+oepAL+RNwQGg@mail.gmail.com>
In-Reply-To: <CAPyFy2DLYHZnzrwA27JQRxGkpf=+Z8ND-6AX3+oepAL+RNwQGg@mail.gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Wed, 27 Nov 2019 10:17:41 -0500
Message-ID: <CAPyFy2CN6LvL36yVB_JkLovTgO=2qQxAEqUGwxEev=d1R_Wo_g@mail.gmail.com>
Subject: Re: [PATCH] ci: add Cirrus-CI config for FreeBSD CI
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Nov 2019 at 09:01, Ed Maste <emaste@freebsd.org> wrote:
>
> After some further investigation I believe these tests are technically
> invalid but work with glibc because of its looser requirements. I've
> sent a patch (t4210: skip i18n tests that don't work on FreeBSD) to
> address the failures.

And a now-passing test run on FreeBSD with the change :
https://cirrus-ci.com/task/5657957240406016
