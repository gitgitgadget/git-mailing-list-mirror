Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7051F462
	for <e@80x24.org>; Tue, 11 Jun 2019 12:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfFKMvx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 08:51:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46138 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfFKMvx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 08:51:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so14273880qtn.13
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PdZFGRst+j5571oHe8i5WsTygZhWIJiZY4EHzyJS0qk=;
        b=prLmSwsNg04Qi1B8Kycmu0OvsDwXBxITH0E5TH7z0hSgRz9k87KcZZkHC/zwJngaxb
         nUJchxHxujxZigCJ5+ztcaCj7nK3eEJiWy+m9GI7WvU1WmOjYt8iKlDDzyb5Ae+0Q6V+
         X3K92zCshMKWyFIBvVQaU39Wv9xuUbAdPo0iJ4O/84TdxOQ/nlYrilCM2Vj01UTquCzv
         sBQ+vymd1QAaRDzfjndj8umhZTwW20jhb2GvXryftXDOJwNJa4XdHI3oVI+zrzbUx6+G
         aoorj/SX115NEwyTqlbEE7kjylLg9Vk6rlgyBSp2bJiO1JoLrCNlDNZ/yB28UTTJArRn
         Zbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PdZFGRst+j5571oHe8i5WsTygZhWIJiZY4EHzyJS0qk=;
        b=BPj82OOeQKVlRUKlY/oBFjr3pcVy5NKpQBIctbVHoxJiCKEci+Ui6WFmf2EaMjP8Te
         ve44pWpd317Ah6HUY7Loxfq/Y5sYK5FqdJxrYD3BGqjIKEc2oVNyd0IfZ4ZBTw+TEMSW
         Hdenn/DK6hqsB7NKGhUwVuhlwAVeqmfbcBbbH25Hv+HpiFXdV6WegTU/5/fYq9CTM2JO
         DCr+D+qnyfKyvp1jZwxvpieuOnUNHR93jxhRh8kbf7xlum0aTRcLj1V/G16zN3Hfj8gG
         fIVuTpYStJsqNS2GubX6QKtE4ne0SSohYoWh2wuaS4V+Mo/EQfuaAYIqJaBTkXg0/dCq
         BAjA==
X-Gm-Message-State: APjAAAUl84kBO3rE4xspZ7Jx4moo+9rN3+EpiMwWCcBiKrbRfg8zgZ3V
        JEu9ZOhYYLaiFJ6xYfdcAGTVFSfGTH4=
X-Google-Smtp-Source: APXvYqxetUU8ygWkWrB02HYC7zMcLPJYkG0BRbzaYDKkaQuVIcRiX/RFQ5FcgGH7etWiGd+C5ys8Yg==
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr52334292qtf.139.1560257512179;
        Tue, 11 Jun 2019 05:51:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a8d5:9520:fdfe:9e75? ([2001:4898:a800:1010:5a0b:9520:fdfe:9e75])
        by smtp.gmail.com with ESMTPSA id p40sm7504968qte.93.2019.06.11.05.51.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 05:51:51 -0700 (PDT)
Subject: Re: [PATCH v4 08/14] commit-graph: add --split option to builtin
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
 <pull.184.v4.git.gitgitgadget@gmail.com>
 <c42e683ef644e7d34614eb74156e5a2b31392758.1559830527.git.gitgitgadget@gmail.com>
 <xmqqwohxnjmu.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2dd1552f-72a3-c676-f46c-1393717ffd82@gmail.com>
Date:   Tue, 11 Jun 2019 08:51:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqwohxnjmu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2019 5:57 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> -	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
>> +	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
> 
> Not a comment on the essential part of this feature, but are append
> and split meant to be mutually exclusive?

I think the more correct thing to say is that `--split` implies `--append`:
As we write a new tip graph, we do not discard any commits from the lower
layers, even if we merge them together.

However, the interaction between the two features is not currently
guarded well. If both `--split` and `--append` are specified, we
will allocate a larger initial array to store commit ids and then
scan the existing commit-graph for commits.

Likely the following diff would be the correct place to guard against
a combined set of options, since these are passed to the method from
other builtins. This block is inside an if (ctx->split) condition.

diff --git a/commit-graph.c b/commit-graph.c
index 8842f93910..9cf5296e4e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1756,6 +1756,13 @@ int write_commit_graph(const char *obj_dir,
                struct commit_graph *g;
                prepare_commit_graph(ctx->r);

+               /*
+                * Writing a split graph only adds commits, implying
+                * a similar behavior to 'append' without scanning the
+                * existing commit-graph files.
+                */
+               ctx->append = 0;
+
                g = ctx->r->objects->commit_graph;

                while (g) {


> One thing that is somewhat curious is that this commit itself does
> not do much that would affect the correctness of how GRAPH_SPLIT
> works, as the actual machinery was introduced in the previous step
> and this step merely makes it accessible from the outside.  So I had
> to look at the previous step to see if the internal machinery had
> some safety valve to catch the combination and flag it as an error
> or something like that, but if I am not mistaken, there is nothing
> that prevents both from being specified.

There is nothing that stops them both from being specified, so this
usage describes a strictness that is not enforced. I can change this
to be "[--append] [--split]" if that is preferred.

Thanks,
-Stolee

