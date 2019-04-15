Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E063D20248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfDOVGt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:06:49 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:45278 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfDOVGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:06:49 -0400
Received: by mail-qk1-f201.google.com with SMTP id w124so15801071qkb.12
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 14:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a+3ZTcclO0mYZv+KnnlanT0BOGoSjcZttOxqoYwbb+s=;
        b=XS8vSCjt2Jsne5pz78Hl71LYyxCkvwbush6MDT3MfqaITc3VAL4uf92losXG08nzdc
         4FwJdH+ZoP9JU+YOqDNqEjIik3Bn6WsNEpN/cu11MMLwGeQOLgCQPDU71hM5Wz7rTNni
         KCETdCXqVaV/+Rij9FR7vCaSwQRcg0Zsa6AICpTdzE0ty6xmb59m9oItftEbAOgPo9Z2
         t5Wn2wgxphr2EvAvq6RtdURdV/PgQgyhLunTpSusX26B4S+XUMZZ97IJl+3U5zUQ1x8+
         V6iPNsf9YU6U79UU8B4n16Zwbkre0e5IwI8Zj/hTeU2+SfiPnQAjJRBBbOqVY1pF+A/i
         o8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a+3ZTcclO0mYZv+KnnlanT0BOGoSjcZttOxqoYwbb+s=;
        b=V90KQf03uG2ENIiB5bUnTE4PlMip40IedAFyFf6LVWDDUs4WRqe9wbJLz6pz3ygP4z
         YDn7NLbWElatzmIY0TxUFld0ueE5vER+IF50V2So0gd97mZCGFGFbP0uCMxG1WJuPJFw
         SVkWc4caRLu0xStC9MHoZTyF6RWxxi/QcB19WVQ3DFiCYN61O4a+YhWrtaayCcM08b9y
         FLudJRBktF2n3f2Srssgt6V/m7/sY0M5Ie7mF/Qgq6kVzlaQ2M9E1LRwBsf7C4fu/eHD
         fjpbnToyliWWEW613Da84tWvWnBVBBsP0Z7PsODM1SpR6aMMp7VER/GOxXM8cJnUQwFr
         id6A==
X-Gm-Message-State: APjAAAVQH8fIYnkWk3OosbkgyWmEf22AfknpqLBrAyWncLl7xo245Ian
        bbFmjVjhC7FfQSi4+XKjoU4y8a197iRkR3k7o1CH
X-Google-Smtp-Source: APXvYqxFcQO1oNEk1ZNj04/deZo/vkLJd70+OEMXl5KomdSAIVnEPtzavf3L3EjcC3xkv1y7LBsdigxD9/ucNw4gAARB
X-Received: by 2002:ac8:277d:: with SMTP id h58mr9972551qth.31.1555362408594;
 Mon, 15 Apr 2019 14:06:48 -0700 (PDT)
Date:   Mon, 15 Apr 2019 14:06:45 -0700
In-Reply-To: <20190413055127.GA32340@sigill.intra.peff.net>
Message-Id: <20190415210645.100478-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190413055127.GA32340@sigill.intra.peff.net>
X-Mailer: git-send-email 2.21.0.314.g8007d49101.dirty
Subject: Re: [PATCH 0/7] some fetch reachability-error fixes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>   [1/7]: t5516: drop ok=sigpipe from unreachable-want tests
>   [2/7]: t5530: check protocol response for "not our ref"
>   [3/7]: upload-pack: send ERR packet for non-tip objects
>   [4/7]: pkt-line: prepare buffer before handling ERR packets
>   [5/7]: fetch: use free_refs()
>   [6/7]: remote.c: make singular free_ref() public
>   [7/7]: fetch: do not consider peeled tags as advertised tips

All these look good to me. Thanks for catching the issue that you fixed
in patch 4.
