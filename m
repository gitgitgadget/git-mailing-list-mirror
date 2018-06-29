Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D851F516
	for <e@80x24.org>; Fri, 29 Jun 2018 12:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755496AbeF2MsA (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 08:48:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39758 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbeF2Mr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 08:47:59 -0400
Received: by mail-qk0-f196.google.com with SMTP id f3-v6so4811349qkd.6
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+IRszk0ekXfFuy5F6fwz9YamwFhiSsJUe3vNIRyweYY=;
        b=rvQoSM+gO7qJXm/rgTWLbDZ7Prw66vUff6+JtLoPfeicgFp5WgmxKcfTpTM1+Jjo8f
         2qk4oXwVC8RXEiYY2TQFbGvUXRGd4lkm5BXBtdoCMplel1vm5LxJn4rUMP6zXbZOelWL
         Lh0fXIhUa7g6mlrIbMZ7xq1J1TDffZqvkRq4pv91YOR0X8q4jCNMrPPg/xKM0zrSBeP+
         Pr5U1R8R6avgYndvVX3NScDhSxmh8lAbx6siibMihEK4uGdxEn2+slWqmIfmNeY6XSK3
         D/qNSLxznGjC18x0ccLTo3A/oC/v64al80pdPariNrdO93edRqoeR6dMlzoY7ukOXao0
         HdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+IRszk0ekXfFuy5F6fwz9YamwFhiSsJUe3vNIRyweYY=;
        b=ZfKs9dNoHHhzfp8kEMh1dZ4cUszjW+PPEg2JcxuCfH7SE64+cmNf0DA+HyhFr6Uz8Z
         MdQIjm65qxZ0+5XO51FREC8bozaCKs2UpF12U+LtGbGDZW61pv6qG6PIYuUIGbZafeqH
         ZIYdoxjJD73Ee4e+3hhKSCRwosE7JGlxF+s253yhuatQyOQ25EdfSdDtKbKMJNM2yTOl
         2XOMXLYQC2liXPtnaFO5VES/Ded4MO8WeSit19EKb+S2LOxX5iCR3lKUmNp8VRZBuUEN
         U566SjlxKZcjIa+XfSH66v2U/0iB88fVdph6dXo1DOraOohOlybMlQF+iJ78uMn6ukzh
         y3TA==
X-Gm-Message-State: APt69E3ZCnSwMQm38sCnaw996eTK5cuXEGsw0qUw+elURPEt8iN8AukY
        iy2w9tpN7D0pL60O4GLeGTw=
X-Google-Smtp-Source: AAOMgpf4xZer/cahjxJRTuw8kLKHS7e2Mx1ZVjTNhY2ZIjllsclSfr+wxwQT/cETdq67hL00/VssMQ==
X-Received: by 2002:a37:2dc7:: with SMTP id t190-v6mr12098231qkh.229.1530276479211;
        Fri, 29 Jun 2018 05:47:59 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id t27-v6sm5019068qkl.11.2018.06.29.05.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 05:47:58 -0700 (PDT)
Subject: Re: [PATCH v7 07/22] commit-graph: add 'verify' subcommand
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        sbeller@google.com, jnareb@gmail.com, marten.agren@gmail.com,
        dstolee@microsoft.com
References: <20180627132447.142473-8-dstolee@microsoft.com>
 <20180627215926.119376-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f6116a1b-8e5a-9cb9-9c8f-53f56a9b79da@gmail.com>
Date:   Fri, 29 Jun 2018 08:47:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180627215926.119376-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2018 5:59 PM, Jonathan Tan wrote:
>> +int verify_commit_graph(struct repository *r, struct commit_graph *g)
> I haven't had the time to review this patch set, but I did rebase my
> object store refactoring [1] on this and wrote a test:
>
>      static void test_verify_commit_graph(const char *gitdir, const char *worktree)
>      {
>      	struct repository r;
>      	char *graph_name;
>      	struct commit_graph *graph;
>      
>      	repo_init(&r, gitdir, worktree);
>      
>      	graph_name = get_commit_graph_filename(r.objects->objectdir);
>      	graph = load_commit_graph_one(graph_name);
>      
>      	printf("verification returned %d\n", verify_commit_graph(&r, graph));
>      
>      	repo_clear(&r);
>      }
>
> However, it doesn't work because verify_commit_graph() invokes
> parse_commit_internal(), which tries to look up replace refs in
> the_repository.
>
> I think that verify_commit_graph() should not take a repository argument
> for now. To minimize churn on the review of this patch set, and to
> minimize diffs when we migrate parse_commit_internal() (and likely other
> functions) to take in a repository argument, I would be OK with
> something like the following instead:
>
>      int verify_commit_graph(struct commit_graph *g)
>      {
> 	    /*
> 	     * NEEDSWORK: Make r into a parameter when all functions
> 	     * invoked by this function are not hardcoded to operate on
> 	     * the_repository.
> 	     */
> 	    struct repository *r = the_repository;
> 	    /* ... */
>
> As for my rebased refactoring, I'll send the patches to the mailing list
> once Junio updates ds/commit-graph-fsck with these latest changes, so
> that I can rebase once again on that and ensure that everything still
> works.
>
> [1] https://public-inbox.org/git/cover.1529616356.git.jonathantanmy@google.com/

Thanks for looking into this, Jonathan. At some point I took my series 
and moved it on top of Stefan's lookup_object() series, but then moved 
off of it since those commits were not in 'pu'. This 'struct repository 
*r' didn't get removed in that process.

Thanks,

-Stolee

