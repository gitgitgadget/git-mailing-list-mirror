Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B767C38142
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 01:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAVBvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 20:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVBvN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 20:51:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A431F913
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:51:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id bj3so8941213pjb.0
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qB49tKtypGgwg8urc9U5TcIuDXUQuI91SatKmkQ3//c=;
        b=MZBxHSzSzYFb+lPvy3ZvxI94dnGCQzf1XtShTqYaDv7HXZ5K4DUzCvTrqMoU8Ws7BA
         5k0cS2CoJ2kTfWW0ho5F7BzLijxPNRqvkeEQb+410UnY6YARwTeBufciNEhayHCywyrP
         3PbVss3nK5UYm1CaGF+9HYohyU+KPnF8OJ+N5msUyYmRmR5dfegMOrmeqjdknurDje8x
         jrel5TGhDId9CUMHjjKKRNNBxPYYgzXp4UYSnGT7Gcz8G1c3iJKA6MjIgNUwfX9w9dvG
         pUNfIfILn7ufT9yWLFIiCbaSsmnMmLKKNMsjKzYGf8lyn5E6F2pvyxE3P3K4JFi0LsxW
         fZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qB49tKtypGgwg8urc9U5TcIuDXUQuI91SatKmkQ3//c=;
        b=2WOVhB17HB7bRUuR6/YWKla5BxPSUj6H/rMuraOP5LH6HV4LUGd8rRnI9GZRAgDlVn
         t8k3sQxsPN4fsEyTKdZuyFdL7dZ19MPLvL8QIlJMQoAy6ZmUCwk4vKDXzyFziVychFRy
         x3C76hPaPuMghJBF6H3rktjHA+Ov9uYM71QBNjoIagXG7YIHmilYGHWCIeAc/cQvwJep
         7fhhGxEbuwgPbGkiXuf3f39Lihf6fpqOKFGeWWZwFGZOph0AfK/0m86162bdws+Wo0T6
         wFx2G4Xt9VIohBp2THMjzzDHlM02wva8u9Frfb9jxJ0iM9DQrSBbIN3Tq8uCf+XWlDiO
         NQCQ==
X-Gm-Message-State: AFqh2kqZpcHDiss2yCw1lCpPMcV4tZMiDzK7JaGUBVDtP/xQ3XAgFVyi
        yql2CnYY3Uqi+Qmiux9Io4IO8v+oevQ=
X-Google-Smtp-Source: AMrXdXunPSiq5laxBFyfll8Cj/Sc1G4oEepPVZN4Ao4orQ8Lw6HlwEZISRp1LJvgpj+CmLRrNfwhiQ==
X-Received: by 2002:a17:903:28e:b0:193:335a:98ac with SMTP id j14-20020a170903028e00b00193335a98acmr23247347plr.68.1674352271794;
        Sat, 21 Jan 2023 17:51:11 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902b60100b0019312dd3f99sm177887pls.176.2023.01.21.17.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 17:51:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] MyFirstContribution: refrain from self-iterating too much
Date:   Sat, 21 Jan 2023 17:51:11 -0800
Message-ID: <xmqq3583uyk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finding mistakes in and improving your own patches is a good idea,
but doing so too quickly is being inconsiderate to reviewers who
have just seen the initial iteration and taking their time to review
it.  Encourage new developers to perform such a self review before
they send out their patches, not after.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFirstContribution.txt
index 7c9a037cc2..81dcaedf0c 100644
--- c/Documentation/MyFirstContribution.txt
+++ w/Documentation/MyFirstContribution.txt
@@ -1136,6 +1136,26 @@ index 88f126184c..38da593a60 100644
 [[now-what]]
 == My Patch Got Emailed - Now What?
 
+You should wait for your patch to be reviewed by other people in the
+development community.  While you are waiting, you may want to
+re-read what you wrote in the patch you already have sent, as if you
+are a reviewer who is helping you to improve your patch.  But resist
+the temptation to update the patch and send a new one, until other
+people had enough time to digest your original patch and give you
+their reviews.  They may be taking time to give you a carefully
+written review responses and haven't finished it yet.  Bombarding
+them with new versions before they have a chance to react to the
+first iteration is being rude to them.
+
+Of course, you still may spot mistakes and rooms for improvements
+after you sent your initial patch.  Learn from that experience to
+make sure that you will do such a self-review _before_ sending your
+patches next time.  You do not have to send your patches immediately
+once you finished writing them.  It is not a race.  Take your time
+to self-review them, sleep on them, improve them before sending them
+out, and do not allow you to send them before you are reasonably
+sure that you won't find more mistakes in them yourself.
+
 [[reviewing]]
 === Responding to Reviews
 
