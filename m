Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B2F1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 21:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeH1BMX (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 21:12:23 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36234 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeH1BMX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 21:12:23 -0400
Received: by mail-wr1-f53.google.com with SMTP id m27-v6so348794wrf.3
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sgm4XJgdSer4ZOsWk/KIW2FMZBTQndOrDroT3+qBsLY=;
        b=vAW3uw+p2ftBd+qiA1EW9YiFZYltf2pkSf8pVSbRKA9JwpVi3rqpOtG+9d1tgz/WqR
         6bQqRyMXi/DVfX2kln+NayOF4XrdGzkWoHsOmUrweE69vJzjAOigy5zrjI3GlT9x0e56
         83qM/8gSLXMlUJ6Y3lzilbO3q7HoA6FJM1RwGL9J4YKmLbklP1Xc3RHngT8aOf/Pp4x4
         /0WkGvElyA2CzDVKynyjyMgK741TXpgvA5Fpj2tVyEFEkJHlimGhxoGQUShYLRtghYzl
         03sN/3gKlzVraumovfWDcyGr4xuMm6Kq2PBHeb7THEmJBNv8/U5W7yYnUM9KSvX/weGN
         HNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sgm4XJgdSer4ZOsWk/KIW2FMZBTQndOrDroT3+qBsLY=;
        b=S7kUKEJy6wvHiXn6ol003SglEEm6KAZlpEclm96hagAm4779Xb7i4UBtceKuGXX5oQ
         zf+PPZB2PjxbzNwWHRDWj5FyfhtQ8xEWcc+iZgIzfJcbPTDhCJj/24GdoXnnKixi9fDu
         6NdDU1iw6mb3XLLqdcrVpsoE+YHhsKhHE7Pb7y35PLY7YJwYonna2qw6UmlTYH2kqvV5
         4bOOYLclKD/C15aYjiiuyHpM2GFTA6byYUPuMqj13ZrkxM+UTmN7ZYFyS03l0SQcqigK
         BEr/fRfZzrvjmYUJH38yoqneAlHk/tfxaU0AqbFljIceCG+pA+AQ3GErBt6eMoxnjYPg
         /4MA==
X-Gm-Message-State: APzg51AZe49v11b9RDCVZpOkEoqYOCIVRZUI9gFfPEuha9bMQ4rzYpyM
        eCXhOaXof9TIqGbHS+9nV0E=
X-Google-Smtp-Source: ANB0VdawMY0LuhGZW4HgjQN6W+j/gSsZQX1zICgJ9ddLJwckxdeb90hRnpEP+ZyNLbge2eKs7OullA==
X-Received: by 2002:adf:b2f3:: with SMTP id g106-v6mr10365067wrd.53.1535405038358;
        Mon, 27 Aug 2018 14:23:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a37-v6sm632653wrc.21.2018.08.27.14.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 14:23:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use generation numbers for --topo-order
References: <pull.25.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Aug 2018 14:23:57 -0700
In-Reply-To: <pull.25.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Mon, 27 Aug 2018 13:41:21 -0700 (PDT)")
Message-ID: <xmqqh8jfijv6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series performs a decently-sized refactoring of the revision-walk
> machinery. Well, "refactoring" is probably the wrong word, as I don't
> actually remove the old code. Instead, when we see certain options in the
> 'rev_info' struct, we redirect the commit-walk logic to a new set of methods
> that distribute the workload differently. By using generation numbers in the
> commit-graph, we can significantly improve 'git log --graph' commands (and
> the underlying 'git rev-list --topo-order').

Finally ;-).
