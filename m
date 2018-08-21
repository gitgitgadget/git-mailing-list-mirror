Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC851F954
	for <e@80x24.org>; Tue, 21 Aug 2018 18:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeHUV5H (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 17:57:07 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45942 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHUV5H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 17:57:07 -0400
Received: by mail-qk0-f194.google.com with SMTP id z125-v6so1910638qkb.12
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oDRqh7evBjaZw2Vare9cu5JtJrwgkstxS0AI4P8RIFs=;
        b=J3Ry57O64Vjk5oz9HZOJ/xO1HHD3rBIafyFP75SK2WrNvAS97VBZv2dVrhxSenGwup
         VB1sWRQz6ib4eaqFep3D5xmE6gLRVv+GOJ+RtUOy39YkdHrVfPKenB2l+ZJrJbSPNw6S
         G6vbRshcwau/insuCaPcw6rVxfsGKHOUFXUoNgKi+n+WywLldT1bR/wlS9cu/ybu2qLO
         OwX4YqL6Nxa1mj8GMe0liAQPe/BGdc26m5G6SbQd3lnOEWqkgcXDDnPZpaPNK950Zdyl
         xoIj0ZuyBiGu8yfayd+w2RHnOUrX6+2TOjrIiY6dNLJcQ8/sPdzScTqsrCxuZncqllLH
         XenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oDRqh7evBjaZw2Vare9cu5JtJrwgkstxS0AI4P8RIFs=;
        b=qguCjJAqPom8tdrVFc+A/VbCNttNlch0/2399F0v3iFGq7CYftkd800gN2f7DpcMOZ
         ER9s0YbXFCGdsJENQ9LRsVxaLumNQ25ggW5OOs5+DcLXw3saGLErqpA0Anwy9Kpyk1hr
         4SXlkF2Z6qLeMFqc9FfGOTxq1KU8S42kwY5hwPL9MEERGI3ENvGiEo0tMRf1MtoCzt1q
         nC6cl8KwoKV1fdMQFoz8pJEXYGAtTKqMxpX9XwKHdCcLUlOqQBbWi0WasRx7nZaNfMSi
         iJOKvCs1tqtJf4dZz24UucznbAlCox2uqf9Qx+u+jUK4S4EI68mCpK179Msq99tXLUW+
         S77g==
X-Gm-Message-State: AOUpUlH6Z/i/cLfDQrJwognUu04hVzvdcWW8eRZ29WyrZGr8zfvX4gaY
        nnDp/BRZCWS0f4vOCVtiUC59uvU/
X-Google-Smtp-Source: AA+uWPzcN0cabe1SlxggmT4ojt0QCbKBqE2vrql9+WvVOg0YAOW0WvuQUuQgaSu6Hs0UbjaKYMDiUw==
X-Received: by 2002:a37:7d85:: with SMTP id y127-v6mr47447997qkc.335.1534876549808;
        Tue, 21 Aug 2018 11:35:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bcc1:4ea1:6a05:dc2a? ([2001:4898:8010:0:a5f7:4ea1:6a05:dc2a])
        by smtp.gmail.com with ESMTPSA id h68-v6sm7128591qkc.97.2018.08.21.11.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 11:35:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] Clarify commit-graph and grafts/replace/shallow
 incompatibilities
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
 <CAGZ79kaAAo+=nrcipfd4kp2iHXFPdo_zNxv8mEgQkN3JbTwicg@mail.gmail.com>
 <xmqq6003a9r3.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <76ef06b5-87cb-ff40-a424-01a3b0ed435a@gmail.com>
Date:   Tue, 21 Aug 2018 14:35:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq6003a9r3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2018 1:51 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Mon, Aug 20, 2018 at 11:24 AM Derrick Stolee <dstolee@microsoft.com> wrote:
>>> Because of the change of base, it is hard to provide a side-by-side diff
>>> from v1.
>> I thought that was the whole point of range-diff. ;-)
> I thought so, too.  Was there any change that confused range-diff
> machinery?

I've just been out of the loop and didn't realize what range-diff did. 
Here is the range-diff:

1:  43ddcc9ef9 = 1:  c8edae4179 refs.c: migrate internal ref iteration 
to pass thru repository argument
2:  22dc9ce836 = 2:  f89451e884 refs.c: upgrade for_each_replace_ref to 
be a each_repo_ref_fn callback
3:  5e90d36f84 ! 3:  d95aa3472c commit-graph: update design document
     @@ -19,7 +19,7 @@
         so a future change of hash algorithm does not require a change 
in format.

      +- Commit grafts and replace objects can change the shape of the 
commit
     -+  history. These can also be enabled/disabled on the fly using
     ++  history. The latter can also be enabled/disabled on the fly using
      +  `--no-replace-objects`. This leads to difficultly storing both 
possible
      +  interpretations of a commit id, especially when computing 
generation
      +  numbers. The commit-graph will not be read or written when
4:  88711a3cf4 = 4:  ec89c88e14 test-repository: properly init repo
5:  7f596c1718 ! 5:  0321a3cf10 commit-graph: not compatible with 
replace objects
     @@ -6,10 +6,34 @@
          repository r is compatible with the commit-graph feature. Fill the
          method with a check to see if replace-objects exist. Test this
          interaction succeeds, including ignoring an existing 
commit-graph and
     -    failing to write a new commit-graph.
     +    failing to write a new commit-graph. However, we do ensure that
     +    we write a new commit-graph by setting read_replace_refs to 0, 
thereby
     +    ignoring the replace refs.

          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

     +diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
     +--- a/builtin/commit-graph.c
     ++++ b/builtin/commit-graph.c
     +@@
     +   return 0;
     + }
     +
     ++extern int read_replace_refs;
     ++
     + static int graph_write(int argc, const char **argv)
     + {
     +   struct string_list *pack_indexes = NULL;
     +@@
     +   if (!opts.obj_dir)
     +           opts.obj_dir = get_object_directory();
     +
     ++  read_replace_refs = 0;
     ++
     +   if (opts.reachable) {
     +           write_commit_graph_reachable(opts.obj_dir, opts.append);
     +           return 0;
     +
      diff --git a/commit-graph.c b/commit-graph.c
      --- a/commit-graph.c
      +++ b/commit-graph.c
     @@ -26,11 +50,15 @@
         return g;
       }

     ++extern int read_replace_refs;
     ++
      +static int commit_graph_compatible(struct repository *r)
      +{
     -+  prepare_replace_object(r);
     -+  if (hashmap_get_size(&r->objects->replace_map->map))
     -+          return 0;
     ++  if (read_replace_refs) {
     ++          prepare_replace_object(r);
     ++          if (hashmap_get_size(&r->objects->replace_map->map))
     ++                  return 0;
     ++  }
      +
      +  return 1;
      +}
     @@ -110,7 +138,7 @@
      +          test_cmp expect actual &&
      +          rm -rf .git/objects/info/commit-graph &&
      +          git commit-graph write --reachable &&
     -+          test_path_is_missing .git/objects/info/commit-graph
     ++          test_path_is_file .git/objects/info/commit-graph
      +  )
      +'
      +
6:  94dd91ac35 ! 6:  d18ecc0124 commit-graph: not compatible with grafts
     @@ -7,24 +7,25 @@
          situations we ignore existing commit-graph files and we do not 
write new
          commit-graph files.

     +    Helped-by: Jakub Narebski <jnareb@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      diff --git a/commit-graph.c b/commit-graph.c
      --- a/commit-graph.c
      +++ b/commit-graph.c
      @@
     +                   return 0;
     +   }

     - static int commit_graph_compatible(struct repository *r)
     - {
      +  prepare_commit_graft(r);
      +  if (r->parsed_objects && r->parsed_objects->grafts_nr)
      +          return 0;
      +  if (is_repository_shallow(r))
      +          return 0;
      +
     -   prepare_replace_object(r);
     -   if (hashmap_get_size(&r->objects->replace_map->map))
     -           return 0;
     +   return 1;
     + }
     +

      diff --git a/commit.c b/commit.c
      --- a/commit.c
     @@ -66,7 +67,9 @@
      +          cd graft &&
      +          git commit-graph write --reachable &&
      +          test_path_is_file .git/objects/info/commit-graph &&
     -+          git replace --graft HEAD~1 HEAD~3 &&
     ++          H1=$(git rev-parse --verify HEAD~1) &&
     ++          H3=$(git rev-parse --verify HEAD~3) &&
     ++          echo "$H1 $H3" >.git/info/grafts &&
      +          git -c core.commitGraph=false log >expect &&
      +          git -c core.commitGraph=true log >actual &&
      +          test_cmp expect actual &&
7:  5314a5a93d ! 7:  87d3397700 commit-graph: not compatible with 
uninitialized repo
     @@ -14,6 +14,6 @@
      +  if (!r->gitdir)
      +          return 0;
      +
     -   prepare_commit_graft(r);
     -   if (r->parsed_objects && r->parsed_objects->grafts_nr)
     -           return 0;
     +   if (read_replace_refs) {
     +           prepare_replace_object(r);
     +           if (hashmap_get_size(&r->objects->replace_map->map))
8:  f4ab234ed2 ! 8:  a26c175897 commit-graph: close_commit_graph before 
shallow walk
     @@ -2,8 +2,6 @@

          commit-graph: close_commit_graph before shallow walk

     -    Make close_commit_graph() work for arbitrary repositories.
     -
          Call close_commit_graph() when about to start a rev-list walk that
          includes shallow commits. This is necessary in code paths that 
"fake"
          shallow commits for the sake of fetch. Specifically, test 351 in

