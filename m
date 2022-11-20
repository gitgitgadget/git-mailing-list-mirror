Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002EFC4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 21:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKTVpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 16:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTVpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 16:45:14 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7FC2CCA9
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 13:45:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d20so8934250plr.10
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 13:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/PXoZVEJhU5rZ0HS1YIS4xZj8xM76dXxOJX2pNGgfk=;
        b=YZZwpPl2vq779ZDfFQrRYqZbHaqQ36N7lS7xNm74r5f+kkb1wi+lAlvIScn0R2Pn4/
         u4iguKaTd5hmwMtGONRJjiQXkh3fXB+mVbqgwQvIwHU38NVwKfngbSHvZHJYqZvYCN4X
         tWv0+yqsP/bZ5YqZyTFRRK4rapOS7L35/UaJjGaIGMK0UX1Yq4lUSebw4jvvLZS8wvc2
         L4SzdoE2eFKslsOHCXXHIfyDtlfB6bvPMaMEMxRRf0X6tzte3zlPdOnZz9Nq57TC4++4
         4gLQM0pV4bAgMIxdZXlDyZM0DoWnyFBJ9yZfCtkA3aklVrg4L0xMXaYWJ70UX1nWkEqJ
         L8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/PXoZVEJhU5rZ0HS1YIS4xZj8xM76dXxOJX2pNGgfk=;
        b=PpCaonoG3Nav7ouoRXptZNs4QOQJG+XuHx/pjZ3tzDTwi8Pjqicz6iFK8TwwaFx/6U
         oSH6aCldEuh2u9rxa0fk3Hp60Ig5aVku9A8VouTDCI5ePu3oYbQLXT3Ig7SjbDfilRJa
         yHAEaOGtbfwcjsemKSEugvVAsHznN8uJN8ID3HzJCpLmvLwc4KP3t6g1855cS7/d1/Ci
         wHvvdg9klLvrYeZ55+I1QEU2bOZhxqTNd7So7tLeG0lmqxp1A9ujf1eWhm2gfckQZb5I
         A7L/gcryfTFAGHi2hnp+xEJy0RRluSN9QUGR3gleFTG/eSmsYuCz4IiJ4rl71dkazchJ
         CS9Q==
X-Gm-Message-State: ANoB5pmQ2LHI8uIAqtAE9wIKzXcCg2s978XXg5n6lc6WszYk34AWsq+P
        V67/uBnrw6ikeDD6QQ/AHMI=
X-Google-Smtp-Source: AA0mqf6shY8R3ZxaTTrjeo4dCc3unneBrpXZ3E3xIRaeL5QBIqW/Letbn8qgiEBn0cuZgw+brO+CNg==
X-Received: by 2002:a17:902:7898:b0:186:5f54:18cf with SMTP id q24-20020a170902789800b001865f5418cfmr8861893pll.141.1668980712966;
        Sun, 20 Nov 2022 13:45:12 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b4-20020a62cf04000000b005668b26ade0sm7026753pfg.136.2022.11.20.13.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 13:45:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
References: <Y3g95OYdwzq2OP3z@nand.local>
Date:   Sun, 20 Nov 2022 13:45:11 -0800
In-Reply-To: <Y3g95OYdwzq2OP3z@nand.local> (Taylor Blau's message of "Fri, 18
        Nov 2022 21:22:28 -0500")
Message-ID: <xmqq7czpjo60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a future
> release).  Commits prefixed with '-' are only in 'seen', and aren't
> considered "accepted" at all.  A topic without enough support may be
> discarded after a long period of no activity.
>
> Junio appears to be back online, so I expect this will be my last
> push-out as interim maintainer. Thanks, everybody, for all of their
> patience while I juggled all of the merges.

s|appears to be|& ready to come|

My immediate goal for the coming few days before tagging -rc0 is to
catch up with topics you have collected and described here, become
familiar enough to be able to tell which ones in 'next' are for the
upcoming release.

Thanks again for taking good care of the project.
