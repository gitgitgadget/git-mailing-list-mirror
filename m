Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A13C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 19:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiGKTwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 15:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKTwR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 15:52:17 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE8564D4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 12:52:17 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10c0d96953fso8025740fac.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=CU1l4twsN4X6sGFJ9zQZ4ATPXyPQQ0DHLbYw5tcifww=;
        b=CNrj/7f97k6oflCrXpNUE2MjdIf2SFRyB6EbbDleLXgr6zSmnfnIhPbNj79hv+ld+6
         76XrSl2O333/ITQ3tw47wgiFMiC3hjpauR1LGG6csJV8pLBjJ1BGBbL+0J791t/ncg4G
         WQSh5Nup1Qq4SGr0mxl8WOBxEtmfAgB2RqUwvs6OZeCgsPG2qfNs1sJ8eo6EPMAPpYaC
         paK00D2vszAJCALdeDAvMb2l/xQNl9qC+SpSDdrqZMGSc+t98Wzb9B/qigweKHWjhOEa
         CS4D5JYcpiKB74oSc4pGXxGHRiFkdBf/kDrxDAIMHoAjkVqzEDu+i0vn48fhKx7/6v8G
         pAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CU1l4twsN4X6sGFJ9zQZ4ATPXyPQQ0DHLbYw5tcifww=;
        b=sHc2U77Qox813NvfD56H9g5xdf8Sd+SsFROZSGFhtRjcq0TJG3J6dtdM0KjVnTZr5U
         ABuDDmd7zFc4JQ0EUziLxiqMCHz7g0ALBe8F33yTABMIg/z1gssFUThCJmGRy/rJIG3W
         Tr8b5lg9+kscxkWjlfeUcHwJdGf7Y4itUtzZ0rYpkdu6+a3JQsHC3OOK/KQflkfhF6/F
         S4I9QIGsY/Il1wKU3EPRM86Jh+1tWdgmClRr36dnJXyRplTYA6oylzIhf/MXyZwRPU2M
         dJjO0OewFzPbAzgaiv4Fmycx4FGEmnTBc0KL/9MkcKfeHD2/Kmd9w/z+YKby1aE6Pw4I
         djJw==
X-Gm-Message-State: AJIora85zvhQvWXjfhIWkIy2PgPg/DyEkcp2SSAoKjPwzb5xXzCfK54F
        WZ+Yj4YQrCtgAC3FQEPPZxQ4n1U3kWfyIduXFX2MaSLb
X-Google-Smtp-Source: AGRyM1vpMcp717HMJc/iBaYNgJ+4ge8FDJodLMilv+ES+RctLdEybGflBLuwU1yS8shXkZtKF+xTib1ifap+Nm0eu/Q=
X-Received: by 2002:a05:6870:ec92:b0:10c:9df7:2928 with SMTP id
 eo18-20020a056870ec9200b0010c9df72928mr14472oab.200.1657569136097; Mon, 11
 Jul 2022 12:52:16 -0700 (PDT)
MIME-Version: 1.0
From:   Gerriko io <gerriko.iot@gmail.com>
Date:   Mon, 11 Jul 2022 20:52:05 +0100
Message-ID: <CALF=2AMDTa48sYdrPjc_i9UyaZfvGKhR9OvknYfLywgtj8AM_g@mail.gmail.com>
Subject: Revert and reset and very damaging Git commands
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a noob I have managed to completely delete all my local folder
contents just by misusing reset and revert commands. Un-be-lievable!
And no matter how many times I've tried I cannot return to where I
was. The git reflog is not that helpful either... and only shows
resets and not revert histories.

Gosh this is not good.

Why are these commands bypassing all the fundamentals of a computer
OS. Surely if a file is deleted it should end up in the computer's
rubbish bin. Not deleted permanently without a trace.

If that is the intent then there needs to be warnings etc. for deletes
and overwrites.

I'm just amazed that all the basics of software design are ignored for
the sake of convenience and speed.
