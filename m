Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F69C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0825D2075D
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJcRjDx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgAZMy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 07:54:28 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33920 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgAZMy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 07:54:28 -0500
Received: by mail-oi1-f180.google.com with SMTP id l136so4201608oig.1
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 04:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=igs9g5q4CPD63zXsTU41lxarP8z/4AAACjp9SBFm5KU=;
        b=BJcRjDx8UNoYqsAuTxS/Oox6C1bqiTlVKEFFmrH1HdRjrB7mPXw5gncd0oDKVFdqkI
         OeyaifPN9hGxprjOvh/Y7XiVPFq32DTLY8Jw/OyG2bDanvYT4Y9oHw31hR4as+pcbHEs
         LpR9et2j2deT8kzELAzPIPj8SRwQHPZvFsvx6S+Xfpg1mHYqYHynCkqouF3XnUUdiquj
         FrVYaTQXM8W1kM1bi1E9k0mVQ+FqcpA8VORDoai3ZXPgBRDH8q/ueTssVg00AhVWEd6f
         Rae8VOKtaDHZvcW0tAZXf/oAs2fv7Lweh/7OefyCTkxqaHs8QM62IcwcwuaqsTw2sRay
         KFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=igs9g5q4CPD63zXsTU41lxarP8z/4AAACjp9SBFm5KU=;
        b=MCobfgRQoe3rNG23O/ng9AAT2EG0mUMTlEGb9wH/N37Q2dvS4qryWrhqfR2P7BIy6X
         jQ5qeC6kv4bRGqChdmGk0bPsxVtqmwvIlENzr4LKUbJURdqAd2u8CzY4XhN4PP8OvMUj
         LP8cZLK7x2wniV9p5XXevL/Nf5nlNaWnuSfZBGtDbB5q/W5vP7HLhIWuMG7Ie86k3CIS
         sQiX1j6SgvMSIKVRGrj7Xr1FWYXnZwkEyDI0sjgEXkobEjF6u2d7ymrLnNOOrBMZz5Lx
         j8Xcff3I3xSjZ8jYv9FIlWjrCvZI3fQMVCrRQs6NVqdxo6XoEC8gXG8YFktjGXjLOmHu
         lmWg==
X-Gm-Message-State: APjAAAUVmwKiQe/wYiMLvvVmic3m52eIalAuXN9nNwbXDdmznr9TEhcy
        NF69BCpoyz3yJZofS+oZl4pXSE/lwprvwEStdxoBlFl9fho=
X-Google-Smtp-Source: APXvYqxhm8wsyS3ldBOpjPtdxGItENouDMI0QTopJ6v+RBMBT7K7EQHVCVXd+qyupaXnI3optfiZVK4QgJFOwuH9vK4=
X-Received: by 2002:aca:f1c6:: with SMTP id p189mr4876808oih.159.1580043267656;
 Sun, 26 Jan 2020 04:54:27 -0800 (PST)
MIME-Version: 1.0
From:   Deepak <deepakpaliwal2013@gmail.com>
Date:   Sun, 26 Jan 2020 18:23:51 +0530
Message-ID: <CAN1xNPi2o5DO+_+ae+LbnJAkjPN3X1a_T5ELJGZdxherf+ZzMQ@mail.gmail.com>
Subject: Question about private repository
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sir/Madam
I was access to some private repository and i made commit in that repository.
My question is that if the person who allowed to me to work together,
but now he withdrawn my access.
1. Does my user name and contribution would be shown in his private
repository or not?
2.And does my contribution chart will show my contribution on specific date?

-- 
Thanks
Deepak Paliwal
Mob 8619437133
