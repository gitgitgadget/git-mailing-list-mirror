Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB9E1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 16:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbfA3Qrg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 11:47:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53390 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfA3Qrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 11:47:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so219994wmb.3
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 08:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=DzvDyBT6c9UNvuvWWZRZ+gWLpletZWtESsDihCK3QWo=;
        b=KZs46PSzZGubuBTFKaDUos/tCrbr2xUqOC1fqHpyV1kh1veElCj4giTrme+pV8vq6H
         eoIicr9GPzYi8C+lKr15udmpt90ZVAWXQRhRiK23JGcih9mhjpeMBZQR9L+o6HtzH+CC
         AwCoANCzg8lvQOTsyfHP3/Wz3YBTLbtnfqxVLAQ2k9fbcRUdagjkY4xBwuLZQLRSWeT2
         h8b6VgOGjLV1YJblnK9wmiphsHBmR9w7L1Y874cXIvJbRsVKA2/xyZW+S9FWcEGS+PYl
         27WDPmqxMQyKt0GA1C6U+CgU0a5sac2UhsLnwP/vnutfZyQC+uQZS69Yrnu3v8+sNhMt
         hPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=DzvDyBT6c9UNvuvWWZRZ+gWLpletZWtESsDihCK3QWo=;
        b=eCQBftGP3AY+kS6pRnL1mb25Rbp80oCDuvQNxb7qGcivcxgmIFgP0xi5SJpvPzZsTP
         ZOTAQ7XuIkbGitUMTNfCcsyd6YkVO4NKpHscMcjSD+A0+knh5GQxu6b4LIT432AHG1xk
         4X01XIJnn6J4Njy1PIz7U52oPkSBeAxEb8wiYuezVW1sqbI1PqzNA/qdv+t8aJCth1ej
         9GgPXPqaAO9R27erCqAx1O/rsblRtsef3pR7MS/bNfkkDwK747uLA3sDNwgp/YDLXTUW
         0ZsBCv/quOPbSG1yd7mwfH8+3JvBJEDQqhVLvBPIlSDDcENLo7/Rooakf9aETGOu3qct
         Cq4A==
X-Gm-Message-State: AJcUukc5SAKDZn25OdCCoW/tnnmAaQR4tVkNwCFLvDqDdM/LvJCkcLoU
        UuR/bQKbI1MZxe1d7lkxb6k=
X-Google-Smtp-Source: ALg8bN5YkKwQB0h8e8kwYI8mgLJOgA5mmALfAKQxaNf51weTIEEhdiacbswKBBBs7vePR+I80T4ddw==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr27441144wmb.145.1548866854428;
        Wed, 30 Jan 2019 08:47:34 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c202sm2666391wmd.40.2019.01.30.08.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:47:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches *.S on case insensitive filesystem
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-2-jeremyhu@apple.com>
Date:   Wed, 30 Jan 2019 08:47:33 -0800
Message-ID: <xmqqy3723xei.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

> This was causing problems with ppc/sha1ppc.S

"causing problems"?  How?  The source file is already tracked so
"git add" to record updates to it would work just fine, and "git
status" would report "modified" for it, with or without "*.S" in the
.gitignore file, no?

    To emulate, I just added ".*S" to .gitignore and modified
    ppc/sha1ppc.S to double check whta happens.

We still have the build rule for %.s in our Makefile, so ignoring
".s" is still the right thing to do to make sure "git add dir/"
won't add "dir/frotz.s" by accident.  I sense the downside of doing
so outweighs whatever benefit it would have on case incapable
filesystems (and it is unclear what problem this change is trying to
work around).

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> ---
>  .gitignore | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitignore b/.gitignore
> index 0d77ea5894..a5db584576 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -195,7 +195,7 @@
>  *.deb
>  /git.spec
>  *.exe
> -*.[aos]
> +*.[ao]
>  *.py[co]
>  .depend/
>  *.gcda
