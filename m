Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9351F424
	for <e@80x24.org>; Sun,  8 Apr 2018 11:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeDHL7c (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 07:59:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42043 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeDHL7b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 07:59:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id s18so5581872wrg.9
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=z9Vco/s6X6z7FknGoNd3x1gqwyAbhfBfTPCr5sKXQ08=;
        b=lm0zjyO5gGMPz0VdGBw4vI4V/WhjUrPxGd1WOiTYNf6tSa7wgBRg1LmYrHmwVh4IAg
         2H2UiTd3ol8J2NmaHb16FANq7xIvWFiBVCfM1dhMES1v2Ynp1/0R7lSaSMy1yT70+YPW
         J1EEpJBFd5JMHRH9VvpLyZrhiEusQN9R1VJDY8SinIghrCWtivJTbNdQFm/U6iB1Teqn
         R+RlXo4XKPuAkAwwPLR4KzmWEIarlD7boH9OOo6K3b9CtSDZGGOci6hOs24uFurjVTZi
         eHjEjQg3NMMDJ7IUhM9aYDRZw4mIGkzQ1ShqeV9xBvCjyd2E8Yz/eYKZr1+awUNCBUr6
         owpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=z9Vco/s6X6z7FknGoNd3x1gqwyAbhfBfTPCr5sKXQ08=;
        b=F8VTLNArCpew1pHbgTh+ddI8IyQoW/4Zqh03lqnxjb2J66U5/awyhyBbI8m/Pn9ip0
         X/NOPbEJo4RMzZYQsMIH41jLgHICUYhd1pVE9SMAAbMFe/KIFeFN0pdDciJx+JaM2Ft0
         jHdvuvgvA5R+U+Og2dAoa+CzvD/FQTpqk0Btd3tWvTBJ7StywyFXiQH/pCBHsxiJacKK
         6He/VssCGqWuyezjRkJOxDKFzQlcsZUkuPHvjnA5gSFp7ZBmStS3q8QvDC4Eq7xYXoWJ
         4DdPFQfoyibsvcCebdH5enklovyrtfUFIf3UfEe2nv8FTxF7NP/rOK9xa3fpctLHtoPC
         JEuw==
X-Gm-Message-State: ALQs6tCTRU/W8yv3MW14SYa95mgvyMPQDSwAIwk/qpPytIk8WYkiw90o
        kEqWrBUOOBIC95hj0Pq1Zkc=
X-Google-Smtp-Source: AIpwx4+BZKJuU3YT70wtxktxpcSXOa7ZLyGOWr8rvWD3cLrlRaiy8MY4TCcrCbLprwV9BXIHEUPSWA==
X-Received: by 2002:a19:9384:: with SMTP id w4-v6mr9615734lfk.30.1523188770408;
        Sun, 08 Apr 2018 04:59:30 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id j74-v6sm2923079lfi.97.2018.04.08.04.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 04:59:29 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 07/14] commit-graph: implement git-commit-graph write
References: <20180314192736.70602-1-dstolee@microsoft.com>
        <20180402203427.170177-1-dstolee@microsoft.com>
        <20180402203427.170177-8-dstolee@microsoft.com>
Date:   Sun, 08 Apr 2018 13:59:25 +0200
In-Reply-To: <20180402203427.170177-8-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Apr 2018 16:34:20 -0400")
Message-ID: <861sfpewo2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +# Current graph structure:
> +#
> +#   __M3___
> +#  /   |   \
> +# 3 M1 5 M2 7
> +# |/  \|/  \|
> +# 2    4    6
> +# |___/____/
> +# 1

Good, so we are testing EDGE chunk, because the commit graph has octopus
merge in it (with more than two parents).

Do we need to test multiple roots, and/or independent (orphan) branches
cases?

Best,
--=20
Jakub Nar=C4=99bski
