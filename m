Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB8C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 16:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjAZQVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 11:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjAZQVD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 11:21:03 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC2E55BC
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 08:21:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z31so1426098pfw.4
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbecmYZaxYJTebNOVcmJRYou4QzabkrLXHo9L2kSsTQ=;
        b=cyrDvjwh51T2Tfv+6KmT1jrp8MBbEc4brQBqYpySv4zDvwEHdh1wMBaNGkAXFV/I4s
         3wCREC/zwO9UFN9OAnK4LtPuYtTBLjj7Dz9uRQlkMiRKFBzmRRdEFzvbVeuppNMP3MoJ
         xXrfn6srFfSo+3EA0WAU/tsH7/ovNZyPG4vyhlpQ0OqVEyZUbMBuvEvQ4a25HfPEvdP8
         x581/iLaYwjGif0+HzwDZoEnKnVgQ+mZ8ZQBbkplXeJYQ71ta9vL7W+F+nhU1a4mH2Hw
         L2nK/fLKJEP7lDYpjjOtyOwkMy2vxbnbBBhw5kj6/uzDqKKU4hyEk8RbteY5yYENYaQW
         390A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gbecmYZaxYJTebNOVcmJRYou4QzabkrLXHo9L2kSsTQ=;
        b=MEFBqiAZ6BBR8No3uF2/7bJ/RWo8yXAvDls6pa8E3+E4UzPSfdhoppX/5Iyl8GHlL2
         knKp+6aG6gVeVOazUPcvGYPKAAoNocyy/Bhu390WNBns+etnP7En1rwVa41ee0/l7h2p
         Ok/XEqrj8cvno4uQfM+2cvab4OHHrDaRyb0ZIXQVKDyyrCyftHER5WOJsSqjEUcZjDlG
         BA44ESYVtUlbqjT3O5lZPXTKaLFugMYhrqUOuuw5xfaZZkCpTYpfDKuxjKLP8hZeIclG
         TqPZ3C/rDOJ0xrqLwrsFHe574ZgvMCRE+QgzSr0ImZjBK7f/nG4rjAxl/KL274iCj3ls
         FWTA==
X-Gm-Message-State: AFqh2krfYvLOMkCU090BHR7Z5VL0CPjEafE9DFnQKcwtJ3xhYJBIhNwA
        EIo8q2k5lQ2CWrfYY3VbAqQ=
X-Google-Smtp-Source: AMrXdXtjZgci7Haco7koiP6zmI+61zVrWciT/MjE9rCecZIL9pmNtDbT7ql9l6cMWxbzAPfVZqMWRw==
X-Received: by 2002:a05:6a00:2a04:b0:575:fd73:fc94 with SMTP id ce4-20020a056a002a0400b00575fd73fc94mr39753845pfb.23.1674750062302;
        Thu, 26 Jan 2023 08:21:02 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id f136-20020a62388e000000b0058bf2ae9694sm1006293pfa.156.2023.01.26.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:21:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal Aron <aronmgv@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request - GIT config - Reference value of
 init.defaultBranch in alias
References: <CAHoQa4-o-=pB4zPR-1SG96KB02rixQG23mFgh0H9ojWrQ_pREg@mail.gmail.com>
Date:   Thu, 26 Jan 2023 08:21:01 -0800
In-Reply-To: <CAHoQa4-o-=pB4zPR-1SG96KB02rixQG23mFgh0H9ojWrQ_pREg@mail.gmail.com>
        (Michal Aron's message of "Thu, 26 Jan 2023 10:33:20 +0100")
Message-ID: <xmqqbkmlcln6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Aron <aronmgv@gmail.com> writes:

> 1) global config having init.defaultBranch = master
> 2) global config having alias com = checkout [ init.defaultBranch ]

I do not think it is a good idea to special case just a single
configuration variable and come up with a special syntax to refer to
it.

Isn't

  [alias]
	com = !git checkout $(git config init.defaultBranch)

sufficient?
