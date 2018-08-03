Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB991F597
	for <e@80x24.org>; Fri,  3 Aug 2018 15:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeHCRy0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 13:54:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33450 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCRy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 13:54:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so5888477wrp.0
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8h83CuMtQvP2gmPLs5d3Qruyr4AFi1nXB0cuCoSiBDg=;
        b=UWuG/P3WAbhC5fitbFHYjGWmQDqUmFMAmfXShYXnOWXBb/fsl58k31MkZJtTncSAo2
         vGq6uSNFd+B7Zx7Os4bPk5Qd1676ATuHXWLFpjdqHUN0/Sjcie42lHjI4q6pMJpgzaCt
         v6vNx/JRETNiyKcr7SEboUZwOo/hfPV4m4HQIpchBrpI7vlnj1cgMyhqpeu3Z7Dj7AiI
         7s+Q8NqQ58HWYXOpkaMGFzL2oiLB9cPyuRdVCbXMpNguI1LYqecevvQmhOjaaY36dUS7
         9+YsgjcmQyuQShwU9hDrtUN5wae8Z00lnZrrPDqrNSH7ZyeriHY7+0GwuVMMPbVNAKwC
         JVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8h83CuMtQvP2gmPLs5d3Qruyr4AFi1nXB0cuCoSiBDg=;
        b=cIn0VWdjrNTfSmPo9H4HMx1UGWZAxTwKX1db/c/ArrRePbq05iElKJvhEf9yO1/c1H
         8zxaBDp6cv93TL+QXjiAAsSgGc9Az41v+d/9DUzr82x8UiUkITQ3WPa9YJ3oyogQWyV6
         zM6hKZTyzp2b8HCnzLDPtEx49ukCYvWfSNNlQudgKDklVUHyQjm7zO6EXo121nqgP5bi
         14cQ4QRt8j8oYPWn51lJSmhh3v+tQHfluHNldI5t7QSZmDj6AAikUZWgfRJ0Vmg+RKPE
         ynznEa0F8+18bwC/11Y/GX1b6v4ng5fceBNX8OKpVV+nk3UamkiSipD2xIAHyX8bVQwj
         IvHw==
X-Gm-Message-State: AOUpUlGErOqpp/fZ+nq5lu2dVAdQ1XrXsYd6rrb3I3ahn+6Y2Yu4+lBw
        +0irhQfGuwNvXCPHsClhLw8=
X-Google-Smtp-Source: AAOMgpe8E3rw+s3vgCLKGPQqRfD5qHRhED8pzzeQ35ln8bSD1qOUh8djsGIhMmL+5pSrSlvNk2gJvg==
X-Received: by 2002:adf:a963:: with SMTP id u90-v6mr3229184wrc.248.1533311851285;
        Fri, 03 Aug 2018 08:57:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v5-v6sm3562018wru.60.2018.08.03.08.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 08:57:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] config: document git config getter return value.
References: <20180802121308.17371-1-hanwen@google.com>
        <20180802121308.17371-2-hanwen@google.com>
        <20180803032948.GG197924@aiede.svl.corp.google.com>
        <20180803130509.GB4671@sigill.intra.peff.net>
Date:   Fri, 03 Aug 2018 08:57:30 -0700
In-Reply-To: <20180803130509.GB4671@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 3 Aug 2018 09:05:09 -0400")
Message-ID: <xmqqpnyzzbmd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is returning the value of git_config_from_file(), which is 0/-1. I
> think it should be left where it is in the original, and not part of
> this block of functions.
>
> Other than that, the patch seems sane to me (I think the 0/1 return
> value from these "get" functions is unnecessarily inconsistent with the
> rest of Git, but changing it would be a pain. Documenting it is at least
> a step forward).

I do not think changing it would be in the scope of this series.

It makes sense to document (1) that zero is success, non-zero is
failure, to help those who are reading the current callers and
adding new callers, and (2) that we are aware that the exact
"non-zero" value chosen for these are not in line with the rest of
the system.  The latter can just be a "NEEDSWORK" comment.

