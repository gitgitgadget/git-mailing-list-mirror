Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502181F42D
	for <e@80x24.org>; Mon, 23 Apr 2018 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeDWRtm (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:49:42 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:37785 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932379AbeDWRtf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:49:35 -0400
Received: by mail-pf0-f180.google.com with SMTP id p6so9919556pfn.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8oi8ugowldnshn+6VYOKzxQbNSY3+1avPYPy2KcHPE=;
        b=pC9QxRyRK4SsWrElfP4rqABm5W5FedSgmfSzzVSW5IjgCpwqcVhalhU+GAfc/kMQDl
         nOzOugeH2IBD9LLGa2rhCkw82qB4mgLOMOhzgISs7hnBoUgXYiPW7bEciLShPG8OrKyQ
         aezz5VKTWPVAPESOuAUodInm+S+SSnDHk+a3dNhPV71YXarSmU0NShbXvBrMgelz8c9b
         5V7aNLL+gWfEfXLY17kMDItbxDz3IWMjj8m7PZPW+ODPyDWm31eDRSlnuZxnEJV9EDNf
         eTdCRa2M/oBikoy3X6gaYL0SYLcuBdcZ/ghItnHSMhD2HB7vKBbl3yoQfDN5yimfFN8j
         touw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8oi8ugowldnshn+6VYOKzxQbNSY3+1avPYPy2KcHPE=;
        b=gax1MvWK/Z9yK4mIt1MacsR+G3iDYvrYV4p9iL6sE1ETU/uqHgsGaZaTm9IwK4+Yj+
         R6qkTOer7Kj474VhGwqKrIJkX2GoXqQV7UZSc0aaJPdvCbYbVcOxyrOoNqaV4YywbcDK
         FTToJd+JQrDwWNMyomYYde9AF8wzj9IqfNN1HHLy8Vuf/TtgCEaciVmhV49sy8gu+sLe
         uT467sSfNPz8zLGLFF9hlTEDiz9EvllhWR8bcaSQ6RUOCDsoIJkXZUVJgesRHXQegQ/k
         kLqmI+Xey99PsOIVb5yfoC9BgC0BL9+GkYvk3t+N2roE5h+pVLGmqHU8fJifAz4KnP2M
         O/RA==
X-Gm-Message-State: ALQs6tCxOQ6x4oZneJ9SeP6fgUTxOkWFIrNsYd2EZ6eEfzP2pwYPJ+IF
        2vnutm6qXdu+fbQpe464aQa63pRjNEg=
X-Google-Smtp-Source: AIpwx48mYlOPaBTDwwi1GKjBYMv9iNfIaHUUH1GNRkdHBVQs5ExND4aAyMVfmOz1qKLppoOyGOspUw==
X-Received: by 2002:a17:902:820d:: with SMTP id x13-v6mr21054336pln.225.1524505773514;
        Mon, 23 Apr 2018 10:49:33 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id p8sm20603254pgf.75.2018.04.23.10.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 10:49:32 -0700 (PDT)
Date:   Mon, 23 Apr 2018 10:49:31 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v1 3/5] mem-pool: fill out functionality
Message-Id: <20180423104931.c465b6a260219c96feba41ff@google.com>
In-Reply-To: <898c0b43-b090-fb1f-45d5-ea4041843cdb@gmail.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
        <20180417163400.3875-5-jamill@microsoft.com>
        <20180420162136.144ac5529072f22067abb3b9@google.com>
        <898c0b43-b090-fb1f-45d5-ea4041843cdb@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Apr 2018 13:27:09 -0400
Jameson Miller <jameson.miller81@gmail.com> wrote:

> > This seems overly complicated - the struct mem_pool already has a linked
> > list of pages, so couldn't you create a custom page and insert it behind
> > the current front page instead whenever you needed a large-size page?
> 
> Yes - that is another option. However, the linked list of pages includes 
> memory that *could* have space for an allocation, while the "custom" 
> region will never have left over memory that can be used for other 
> allocations. When searching pages for memory to satisfy a request, there 
> is no reason to search through the "custom" pages. There is a trade-off 
> between complexity and implementation, so I am open to suggestions.
> 
> This was discussed in [1], where it originally was implemented closer to 
> what you describe here.
> 
> > Also, when combining, there could be some wasted space on one of the
> > pages. I'm not sure if that's worth calling out, though.
> 
> Yes, we bring over the whole page. However, these pages are now 
> available for new allocations.
> 
> [1]
> https://public-inbox.org/git/xmqqk1u2k91l.fsf@gitster-ct.c.googlers.com/

Ah, I didn't realize that the plan was to search over all pages when
allocating memory from the pool, instead of only searching the last
page. This seems like a departure from the fast-import.c way, where as
far as I can tell, new_object() searches only one page. If we do plan to
do this, searching all pages doesn't seem like a good idea to me,
especially since the objects we're storing in the pool are of similar
size.

If we decide to go ahead with searching all the pages, though, the
"custom" pages should probably be another linked list instead of an
array.
