Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2652F1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 23:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeDTXeq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 19:34:46 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:43134 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeDTXeo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 19:34:44 -0400
Received: by mail-pl0-f51.google.com with SMTP id a39-v6so6021810pla.10
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qv5Nh15cy8ZpsGGE1kNxW7OlZgWDoa8doMIcSWJOux0=;
        b=Rp/UG8xAuY58mKI3UuqO1AVb9MapNaMFiKeTSd/3dCgz3nFSQ8LjExJTZpaymCy4bX
         SpZ1w7/DSfrD7SqhKy3/JPOas7KBt6ZXT+0MRYq9g6aeC2JubNUFfw+5sAPeljtv1np+
         jxD/tBHJ1BBLiRZJBQdmYKgqgkbpfLW3LwyoxSuylqOIM/5ifCIQMuQ7My08/CnF+2JV
         yCZ/oXtLyb4W2Y21OLVYBEB45StLDsGOWjDFpc2KVYHk2ElVZ4rOmiu9kc0MTfE7ux5K
         IEwA3YcaUIvTtf7dZj6AlzBjuxNIs8cNkJFum6hLFWF/bldhGAtoAEUQe5AjmVWNonJR
         Z7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qv5Nh15cy8ZpsGGE1kNxW7OlZgWDoa8doMIcSWJOux0=;
        b=uFO0FaTlpe0wg5F/yvB6kXY8CTKn5eVpDMbcNsI4kdGrDt7Q4U5Mh0BMcNIEBJ4SYz
         PEauqCxnzu49tFIjIJ4RTmRDUiC+bjrD/oAYDhp3AajCzQVeyQsk94d94DJdtvb96Ez/
         zH5Dl2GX0PTDo7EeqEjgr9PNZYSucY3EZUL+WTqVysIZSzooILGXZFS/0kGHXFCN/tk+
         Ey7dYQTjiec0fVdudUL0C91aOJEdewIc01wKETGgCLFpEJcLIFekvMxUwXIq2wVuGcaD
         binF9ybDrZNuBoaZLa2xN3toBDqVqg5RruPcPhD1rKlNrz4aqA4ib1cy5Cq6DrwGZrV9
         CQfg==
X-Gm-Message-State: ALQs6tA3Gvp2X1VRhRh2+cvSNsLD2/OLtwXTaktcO+mySIOX1qo9hG6r
        mgK/ef8nIfcCNG7DjqNMxWCFJQ==
X-Google-Smtp-Source: AIpwx4/p2sGvFXBUoa57g4Iblbvvw0UpxdyPz49AYrZPJV1Q9h7IXfXXb0WRDvEYKwi1HeWjZebPcQ==
X-Received: by 2002:a17:902:228:: with SMTP id 37-v6mr11702097plc.141.1524267283560;
        Fri, 20 Apr 2018 16:34:43 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id n8sm11992813pfj.24.2018.04.20.16.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 16:34:42 -0700 (PDT)
Date:   Fri, 20 Apr 2018 16:34:41 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
Message-Id: <20180420163441.208644d772a25ddbbdbb1616@google.com>
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Apr 2018 16:34:39 +0000
Jameson Miller <jamill@microsoft.com> wrote:

> Jameson Miller (5):
>   read-cache: teach refresh_cache_entry to take istate
>   Add an API creating / discarding cache_entry structs
>   mem-pool: fill out functionality
>   Allocate cache entries from memory pools
>   Add optional memory validations around cache_entry lifecyle

In this patch set, there is no enforcement that the cache entry created
by make_index_cache_entry() goes into the correct index when
add_index_entry() is invoked. (Junio described similar things, I
believe, in [1].) This might be an issue when we bring up and drop
multiple indexes, and dropping one index causes a cache entry in another
to become invalidated.

One solution is to store the index for which the cache entry was created
in the cache entry itself, but that does increase its size. Another is
to change the API such that a cache entry is created and added in the
same function, and then have some rollback if the cache entry turns out
to be invalid (to support add-empty-entry -> fill -> verify), but I
don't know if this is feasible. Anyway, all these alternatives should be
at least discussed in the commit message, I think.

The make_transient_cache_entry() function might be poorly named, since
as far as I can tell, the entries produced by that function are actually
the longest lasting, since they are never freed.

Along those lines, I was slightly surprised to find out in patch 4 that
cache entry freeing is a no-op. That's fine, but in that case, it would
be better to delete all the calls to the "discard" function, and
document in the others that the entries they create will only be freed
when the memory pool itself is discarded.

[1] https://public-inbox.org/git/xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com/
