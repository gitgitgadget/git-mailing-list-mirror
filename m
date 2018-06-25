Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980CE1F597
	for <e@80x24.org>; Mon, 25 Jun 2018 22:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeFYWJU (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 18:09:20 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:45436 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbeFYWJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 18:09:19 -0400
Received: by mail-qk0-f202.google.com with SMTP id f132-v6so8212429qkb.12
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PwpYhodqgMkqSceqenwgfIjJyMroaw4myLOeBVbgThk=;
        b=nLdlhrS0XJ87Vuh/jE+MqGcaitNLdRCdlRc2vcFYegEIb5AVEyBDHSS0n0DuS9mcw1
         p//kNvKzQXMOEAgCtrLSQSukgGwLsGLDpgemgYJgVFz5tWslZzMTt3+v8YPKgdI4MXlI
         Y4Igs4YXqoQDJM9AuYmandsw1IWE6k/xJyfnvaho3VwGWNtdTqRY97D1uqMW6+054y5Q
         +Js1WaW0+M8NOPPo0SLNw2PX8b9EC1pbmb5D4QeqmPwUxzwK11UDicHuE1zxfb2Lo2PB
         fkl6I9WvfQs4voZiESPhvTDEM0CNZnlRVK5Ced+hZ8vLHl0KVgmoalHbCRiaAM4tI2dy
         K1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PwpYhodqgMkqSceqenwgfIjJyMroaw4myLOeBVbgThk=;
        b=cH4BwlTWXOQYNS8grwoFLC3ygOLkqXUTKqvl1zuVOzflPvGOqsnV+tF6kwxL9tNMeo
         lzJXcLK6wb7TFDQywKpxUcg8ncFRsLXChglHI8EPl16xtmidJbiGWRe7I+BimzYK3L8A
         xAZYq6RaCbjrGBmcNgTRrh4jqb7fak/a5/DGPlkwgOpQTxslmdouPiHvZljoC4BfKIJE
         HSIHGhkJRkOuRs3D8uNUfE5nJh+U4i0szSDAcx6vwYQOGJ5177AEyXXFA8gp9o+IPUrN
         MGtarrSi44jwT4ofbOj5/tSF8wJRNtlwXLUZnH2KAGMmMMhX+FKUTF1ru6bCjimK0303
         UPLQ==
X-Gm-Message-State: APt69E2aWpgZJSo9nWDdo7RFh7aomAMputm55SFGW+GT/M3XAcuuSVAq
        /2+Se5uNy7v+hdbutWR81ZvaLgmcI9xMbot0yzla
X-Google-Smtp-Source: AAOMgpcgEwFNhZWpUBY3UW2dN0Y4b8RNuQUuNatFsYhEOEvdo34m8rDsIOaEjWgO2wFIWwkvA2BtlHsRAzBOgvsnXcjt
MIME-Version: 1.0
X-Received: by 2002:ac8:5041:: with SMTP id h1-v6mr4687987qtm.55.1529964558964;
 Mon, 25 Jun 2018 15:09:18 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:09:15 -0700
In-Reply-To: <xmqqwoummvmw.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180625220915.198932-1-jonathantanmy@google.com>
References: <xmqqwoummvmw.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH 4/5] commit-graph: store graph in struct object_store
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I was looking at semantic merge conflicts between this and your
> e2838d85 ("commit-graph: always load commit-graph information",
> 2018-05-01), the latter of which I planned to merge to 'master' as a
> part of the first batch in this cycle, and noticed that there are
> two very similar functions, without enough document the callers
> would not know which one is the correct one to call.  Needless to
> say, such a code duplication would mean the work required for
> resolving semantic conflict doubles needlessly X-<.
> 
> 
> int parse_commit_in_graph(struct commit *item)
> {
> 	uint32_t pos;
> 
> 	if (!core_commit_graph)
> 		return 0;
> 	if (item->object.parsed)
> 		return 1;
> 	prepare_commit_graph();
> 	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> 		return fill_commit_in_graph(item, commit_graph, pos);
> 	return 0;
> }
> 
> void load_commit_graph_info(struct commit *item)
> {
> 	uint32_t pos;
> 	if (!core_commit_graph)
> 		return;
> 	prepare_commit_graph();
> 	if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
> 		fill_commit_graph_info(item, commit_graph, pos);
> }

Thanks for letting me know - when I reroll, I'll ensure that I reroll on
top of this change.

As for whether both these functions are necessary in the first place, I
think they are: we could have a load_commit_graph_info() that ignores
the parsedness of the commit and just copies everything over, but that
means that we can't have the optimization of returning immediately
without consulting the graph when attempting to reparse a parsed object.

So we can't delete parse_commit_in_graph(). And we can't delete
load_commit_graph_info() either, because after reading the documentation
in commit-graph.h, looking at the places where it is used, and observing
some test failures when I make parse_object_buffer() not use the graph,
I see that there are code paths in Git in which we use both
parsed-from-buffer and parsed-without-buffer commits at the same time.

So, I now look at the code duplication, and I see that it is mostly the
check-prepare-check step; my patch set reduces it a little, but I'll try
to reduce it nearly completely when I reroll too.

Maybe when the object store becomes more pervasive, we can more clearly
separate out the buffers that come from a repository (and maybe, when
obtaining those buffers, we should obtain graph information at the same
time) and buffers that we obtain from some arbitrary non-repository
source, but that will take some time. In the meantime, I'll do what I
suggested above when I reroll, maintaining these 2 functions.
