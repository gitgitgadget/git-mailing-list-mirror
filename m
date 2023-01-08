Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C833C46467
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 01:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjAHBaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 20:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAHB36 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 20:29:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE0534769
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 17:29:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n12so5307286pjp.1
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 17:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Stg6F+vqjYPQylsFcmjf2dmjpnSewHXYHAnlAtG7HIU=;
        b=i/ExP8x7IO/rJe7idu1aziaVlBRU7RPV1xiioQA5Pv6/LIDEUAPsvREabxGwl/Hk4G
         33RAxpLp0sKLJHiVoIovDk4bgtGW0egsY8bW2JGHMXsKzcNN9jXgCbGO6OqhriruiVtZ
         SomdRU0YWBsy5R5Q3SCn6E1ofY4Q7hQfjayy+nm8hnDXKcOHgF2Vmfk1lbgomHWGNc6T
         118K2MqkR99Oe4jYerX8DOa+PQq1igY/LkP/xPe/BTzVmNLrZrW16aJflIOybdNg05S4
         0d8bYgStjrZ/Rr6dd4tS9TVsUY2qMl7LxuX0FSYO2yRbcccz+r1KBFhkEjuJV80wCIuh
         PmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Stg6F+vqjYPQylsFcmjf2dmjpnSewHXYHAnlAtG7HIU=;
        b=IyrblhTA/Qi3ypeKjlHxqwjRMx84Wu+Na3eglQc8vb1RPUsep8F5NiHzdJvWsFOBo7
         ROvXGu5zIjnSZhXz0n2vfLxYlkWCKV3ZXZd6KfK9ISsnYW9/xGUnzAybLLX0oPOMspTt
         LaxZksl3yrkqIu8cNNDAvjWqUWYZ4vYKy3tIf8Uv7FctPTwcwYtcgS1pXO6XNXBuNCBL
         Bh0n85MS9Fa0WAWNCWBx2ZCjDgWIFMoGL5vgUy9CwFu3hAqMSQN/E3uS1eruC5Bwvh4X
         na2bX0X3Z04Bs/iUSHnKGzhsfODGPFp9OCoEnFOx4G80hzV7pcD2RKaa9h5TNkzF+Oic
         WgHA==
X-Gm-Message-State: AFqh2kpIU6BjIw09Gq+jEQWvID2n6T2eTnQ9xS8JfxCWEtuJP77XQoBf
        Ebblx/wtznPu5VeRHjlvZUjD6yzzEbbPjg==
X-Google-Smtp-Source: AMrXdXsm0E9ALfwZStMpdNiFVoV8L2/mrGqqrlFGRcaMAGPvxVtkthGwQKcEw7PlTqWIlJoTcCz3mQ==
X-Received: by 2002:a17:902:eb84:b0:192:8e8b:59ab with SMTP id q4-20020a170902eb8400b001928e8b59abmr43742189plg.9.1673141397464;
        Sat, 07 Jan 2023 17:29:57 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o9-20020a170903210900b0017fe9b038fdsm3411270ple.14.2023.01.07.17.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 17:29:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] *: fix typos which duplicate a word
References: <20230107135655.149892-1-rybak.a.v@gmail.com>
Date:   Sun, 08 Jan 2023 10:29:56 +0900
In-Reply-To: <20230107135655.149892-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Sat, 7 Jan 2023 14:56:55 +0100")
Message-ID: <xmqqlemd24q3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Here's a v2 with "that the" and a corresponding update to the commit message.

Looks good.  Will queue.  Thanks.
