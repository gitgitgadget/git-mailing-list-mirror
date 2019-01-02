Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3FE1F6A9
	for <e@80x24.org>; Wed,  2 Jan 2019 23:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfABXP1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 18:15:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40442 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfABXP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 18:15:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so32009334wrt.7
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 15:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aMDHW7ouCojXpaPfymDg4S0i1bCOfDEEVY87+J0R97A=;
        b=Pz9x8PryinN/KHkSbDCQvuv/5kik+Qz71DZsmrprHF+4wWUZk/u3BuArjCtyD6qPCG
         Ay1cRzfxakke6RWmDT06RQWOdVVkKzJtbHDQbKBaGopDWCEENgVqojX8IWQvrccChzrY
         Da6tEHN5n5NAxpBpMiF+fEcTQf1AgmFCYeeEnIGIimxsknLDnfwtb8pSk4UvOW36F8BG
         HmvNfOaZg9v3io7T23B3cajGX1Ky06u3vd3PQsFQNLIeKspPzshnmcExMFCcRlzKx4aa
         cq1NIyu/CflrM4WqCXKiV771LgZps78xGzwqU225rcXD1jAIEqsYuVNFjjH5AmURDSXB
         1iQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aMDHW7ouCojXpaPfymDg4S0i1bCOfDEEVY87+J0R97A=;
        b=fgm+HRB2qFdMRn3jEzVfGeLoNkg1pw5jeIUN9CsX/NAfOfObzqHaRgPFjxKTjwZx0p
         63C3SYDpmmqUCUK8+L1cbaJFDxYJ8wkdwrVIfvXtny/+q85ld0WrexkhX/HnJZSGJd81
         YqNiKaeu3fpV1onIJODLy0cecTyT/X56MY7wa7eMDhPH4AvmcDqC864GzCOgDS3MTyKR
         jOFNEzN6Kwykc1sA1mwqdjZso8rro1zR24png0UaqLbSc55r+d4pQwG8CRvuJ8nR50Ur
         Vf0YsSH934jNvXf94fIvoJqCq/KhLNuGt9o50fj13fugMgAmU+TQo30YPMbhGXN8xMTD
         g6sw==
X-Gm-Message-State: AJcUukd4H4uBCFYLx9kv6dIg7JiMnmmyHnbN3MY0wDEcR+qb5M56i4r7
        vWtuQM7UTXf0q4d3gOTUOigEd2Qm
X-Google-Smtp-Source: ALg8bN5URk9c/jzgUshtAdS530ro4X8CJjx+/CGs4h0ieVN4sfbsjQTnwzbKTvRSCEeqaMJ6zdO+SQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr38243001wrh.250.1546470925729;
        Wed, 02 Jan 2019 15:15:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k23sm30706733wmj.32.2019.01.02.15.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 15:15:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] filter-options: Expand abbreviated numbers
References: <cover.1545261186.git.steadmon@google.com>
        <d324e7836928940a4df0b43da3ffeb8526feac61.1545261186.git.steadmon@google.com>
Date:   Wed, 02 Jan 2019 15:15:24 -0800
In-Reply-To: <d324e7836928940a4df0b43da3ffeb8526feac61.1545261186.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 19 Dec 2018 15:21:18 -0800")
Message-ID: <xmqqsgyaircj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> When communicating with a remote server or a subprocess, use expanded
> numbers rather than abbreviated numbers in the object filter spec (e.g.
> "limit:blob=1k" becomes "limit:blob=1024").
>
> Update the protocol docs to note that clients should always perform this
> expansion, to allow for more compatibility between server
> implementations.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/technical/protocol-v2.txt |  5 ++++-
>  builtin/clone.c                         |  6 +++++-
>  builtin/fetch.c                         |  7 ++++++-
>  fetch-pack.c                            | 15 ++++++++++++---
>  list-objects-filter-options.c           | 20 ++++++++++++++++++--
>  list-objects-filter-options.h           | 17 +++++++++++++++--
>  t/t6112-rev-list-filters-objects.sh     | 17 +++++++++++++++++
>  transport-helper.c                      | 13 +++++++++----
>  upload-pack.c                           |  7 +++++--
>  9 files changed, 91 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 09e4e0273f..d001372404 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -296,7 +296,10 @@ included in the client's request:
>  	Request that various objects from the packfile be omitted
>  	using one of several filtering techniques. These are intended
>  	for use with partial clone and partial fetch operations. See
> -	`rev-list` for possible "filter-spec" values.
> +	`rev-list` for possible "filter-spec" values. Clients MUST
> +	translate abbreviated numbers (e.g. "1k") into fully-expanded
> +	numbers (e.g. "1024") on the client side, so that the server
> +	does not need to implement unit parsing.

I suspect that it is too late now to retroactively say "MUST" here.
The best we may be able to do is to say "The sender SHOULD send a
plain integer without unit and the receiver SHOULD be prepared to
scale an integer with unit".

