Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CBA1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 22:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRW1G (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 17:27:06 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54323 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRW1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 17:27:06 -0500
Received: by mail-wm1-f53.google.com with SMTP id z26so996097wmi.4
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=hJ/+RKHhTlJRNHtH4Jxpy6AeplD2NtfuLPCfAL3GXD0=;
        b=B23r5MFX6LHNQ2uBhReYaGpOBR2DB6mUNsm3lbFPD1Fc4lJsXTdeHcJML05Th2zTeT
         Yp6wDsgY1Dukfq8sjekBMgOZM3FEQeSr23lozfDYNvqvLhACGFPoJbTU2EsVd1XsJQAs
         fO2jOJfKLVpbgregP6nfZfh5En/kdyG1pKdZno1mrdVZymj7YepfjMfQyRYh60AZl5GJ
         31NaEWyLStqCOIi607DnbSqzpSHGQZT9SM72n8qHSmpKdZgOzUgrjzloeiPc0QHOexG4
         WcA11miXNY6Qkwlaf/JIstzyp3kfGAh8zcl7CUohfNspdhHRDnvPoe6bRIgNEAKE6tzB
         YDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hJ/+RKHhTlJRNHtH4Jxpy6AeplD2NtfuLPCfAL3GXD0=;
        b=lj8ExqvTUEJyJZvndVIk9qx+PP7uy1R13GqALce+KK81O5RzgsGbqwrklvtepZdCs1
         ZyEovLa5eSyyGQYWvFehfjhHsplk7gzzwU3WUyzjts3ZQ7Afz+9MR4agzB5Ap7rEx2n7
         lxv7lKfh7RATpF6QSBBkmczk+95oW0x6S0zvUaHb4jhixJ9puKhysOKXk8GU8yCvbvGG
         BLikTtVMecBLnGbGPw6HfPikTHEfuTpmZwwi/2YKiJGaSjjKOi3Yl6OVF6BvXK48OCJV
         LUSSAxy2BNiofJE5ecsUi0Zi3rvCCAVrjE22h37/s25vjLieAWZEShsrGQUCa1oGDzel
         5RsA==
X-Gm-Message-State: APjAAAW4IfFOBkxm+BNMo/dt7Atv0SH5p90OT6dxV0A8svBerzjoyx+V
        juGD4g12zDY/LLtVOglLKp8/ef6VOuQta/GTiJa6kCoC
X-Google-Smtp-Source: APXvYqyQZtFOp8yijZGeu0oJbuJzK/40WrFWuxRqowQ9rBGlbCLDt0XQxch7KzLOf0I8/FijhBJE+J3M/H90oOxVh+U=
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr1906203wmc.164.1574116024604;
 Mon, 18 Nov 2019 14:27:04 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 18 Nov 2019 14:26:53 -0800
Message-ID: <CA+dzEBmrMavFJeyPSQr2wA9kFZwz_Kfr6PFBLRfLJ-EuCVXJnA@mail.gmail.com>
Subject: git rev-parse --show-toplevel inside `.git` returns 0 and prints nothing
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would expect it to either:
- exit nonzero
- produce the full path to the root of the repository

would a patch be accepted which changes it to do one of those two
things? I'd be happy to contribute such a patch

Anthony
