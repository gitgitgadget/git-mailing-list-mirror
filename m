Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9971F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161781AbeBNSPR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:15:17 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:46229 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161741AbeBNSPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:15:15 -0500
Received: by mail-qk0-f176.google.com with SMTP id g129so13243169qkb.13
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6CWTI2S/nG45wq4JLub3g6UDtwvXOIMbyi2hDkwWpwk=;
        b=A72SNYGsOP7jth+DfJX3meb2/yQeM9s9233OqfvsMvJjJV30uwisu8VXsZdDiOR+DE
         RPaO1w1g6FinJSbNNpI90Z1l0wlholFjxXSnCV75qKNZXm04g8Nu3QkbEZ0tJszlIm+f
         OyX7CToN7PHwAq4x9/IkWN8soRKuspr/ffoALRZViiOY46KUBb237/ni5JysJn3c+1pU
         8L8/uxU7dKoeOrodmJ6IGYur2QRjyqjaJuAFDHAGpSKUX+G66dbVapsnNjdI+Ls3zsVD
         juU9P0vsZPx6qITG+K6rlDfgBbCZ2z/u2EFg8G7IAWwF5Z+vqudqVE/rDrw9H9yjuscH
         j7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6CWTI2S/nG45wq4JLub3g6UDtwvXOIMbyi2hDkwWpwk=;
        b=nraVib1aRotjRAiDVHRsdz9TBCNO/zv+rd51FGHU0QXQeBhjqHAodDtCsfzKmr7aya
         2KEwXnGDZ7Rk06VXHkp8YLRDWJjMyqvkTgt6hyQ9Nze9ojBxSCEnXeuKUXYIZMf4uIIS
         X/lGnVQIvSoX0WQNjDEwfSREPJYHvaomGv7Cl1Vvq21mYcVgJTJR9/qBpMjajSOmsrJ9
         vORmH9w42ovBsx/ZhZU1YnUeqBIGKtd2/2DZU9+xk29f7mrRvXqrWpc72vf5ViZfEN13
         AyhRj1LoKxXivLCDzEg0JCG7lSHmm7srvigqqwHFR/S+fCCUNvDreIo0MhqQ9mBKqSZ/
         Po3g==
X-Gm-Message-State: APf1xPDQwhtOQhPdsJQIcGDsqR9WyHTr74KzGjji+piv2jKHIBoBMh7u
        8xmScHKzg0HjrHLi0EGWuVo=
X-Google-Smtp-Source: AH8x2246j5jTBZV4UT+CWMjT8t9OF4GqoWXOOzg0I8KdLQCrZ3vaaqUyHLsbFFyjuurofTiTWr5KOA==
X-Received: by 10.55.217.73 with SMTP id u70mr8632021qki.223.1518632114854;
        Wed, 14 Feb 2018 10:15:14 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id a1sm942387qtb.74.2018.02.14.10.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 10:15:14 -0800 (PST)
Subject: Re: [PATCH v3 00/14] Serialized Git Commit Graph
From:   Derrick Stolee <stolee@gmail.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Message-ID: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
Date:   Wed, 14 Feb 2018 13:15:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has been a lot of interesting discussion on this topic. Some of 
that involves some decently significant changes from v3, so I wanted to 
summarize my understanding of the feedback and seek out more feedback 
from reviewers before rolling v4.

If we have consensus on these topics, then I'll re-roll on Friday, Feb 
16th. Please let me know if you are planning on reviewing v3 and need 
more time than that.


* Graph Storage:

     - Move the graph files to a different directory than the "pack" 
directory. Currently considering ".git/objects/info"

     - Change the "--pack-dir" command-line arguments to "--object-dir" 
arguments.

     - Keep a "graph_head" file, but expand on the reasons (as discussed 
[1]) in the commit message.

     - Adjust "graph_head" and the "--graph-id" argument to use a full 
filename (assuming based in {object-dir}/info/).

     - Remove "pack_dir" from struct commit_graph and 
load_commit_graph_one().

     - Drop "git commit-graph clear" subcommand.


* Graph format:

     - remove redundant hash type & length bytes in favor of a combined 
type/length enum byte.

     - emphasize the fact that the file can contain chunk ids unknown to 
Git and will be ignored on read. Also fix the read code to not die() on 
unknown chunk ids.

     - Don't write the large-edge chunk if it is going to be empty. 
Modify tests to verify this.


* Tests:

     - Format (last apostrophe on new line)

     - Bug check (--stdin-commits should limit by reachability)


* Other style fixes.


[1] 
https://public-inbox.org/git/99543db0-26e4-8daa-a580-b618497e48ba@gmail.com/
