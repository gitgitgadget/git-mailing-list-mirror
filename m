Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DEC1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 11:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeIEQ2K (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 12:28:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46476 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeIEQ2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 12:28:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id j7-v6so4597628qkd.13
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 04:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WjkThPQiYkZCiJ/ygy4gnbgbl1L1QVDffVruHvtYN3Y=;
        b=GGX+KUNujSeDzdmqxvtfXJ6x2sTp1aq44ZRPf8OfSnp8KGZpDKhldqFnbUx7hgT+/0
         YBKJ2tN8eWwQIATWghdUyWAo2sxczVjxI7TcNzG2MfbJgxKXKuwEeFbmTO63kP4VHyhv
         ulWkJsjbuz6x1aUQHtV2gJ/oKQRgzhpDVTlgEO2ITwuftp2en0Yf8cRncWDnGcdUg29u
         EryMge03p4K9ME8SUeppU27m52jNpYLpJLDki8VTyt/n7dthoiusOlu1/jD55dpwKglr
         zBOJAOJR8wMeIRkwj2SK2s3MmgJSCBGZQSL1x82j8pHD9SkQZlFyn0It7d2SslxPrwWg
         3mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WjkThPQiYkZCiJ/ygy4gnbgbl1L1QVDffVruHvtYN3Y=;
        b=NlW0xPCYCcNvL/KbzcVYtGSgZCVSCJpcuam2dJxM4VcdhVfhltyLySEBCsv8Ck3CSs
         0rnCyzefXnYdWITsKKy32Mo1xbAWhGfMt53duULuRmf3L3+emtp2NFaL6HnPfYphCdIt
         eikoUhtetxsEt/Vrks/KfAaT5C1OGq+b6piIx0QJXsgu12BSCm8AFqZEtPJ4MBbvoD0x
         Oql9dMXc1VCr+OOXnPfvPzx8VXn8mN5Jx7vmonbl7JFR5qJiyQMlaM54vYMyE2zpkxJ8
         3RxgbZUZq8qjknQ6l0vboG/Xw6xAbUGtYUm+KU6gQs6rzhcIuzbVv+CP/wO+0JdCUk7d
         e7kg==
X-Gm-Message-State: APzg51COfBhG0aKISZBRoWf9w6O8bHxBfOnOQkX3g+v09TXQqj1CnVqh
        BM5yJaarO5a2V8mV5sUZ2hajWEyG
X-Google-Smtp-Source: ANB0VdYB9v9Cx5dghew9UPfPH+B+Fzm0Fp0yHQwEJ9eQGcHBkxVkRJWcOHKZI/21TO+fBlwpE2iqMQ==
X-Received: by 2002:a37:af42:: with SMTP id y63-v6mr32319665qke.87.1536148693699;
        Wed, 05 Sep 2018 04:58:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:846:acea:77a8:94b8? ([2001:4898:8010:0:f17b:acea:77a8:94b8])
        by smtp.gmail.com with ESMTPSA id g37-v6sm950295qte.36.2018.09.05.04.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 04:58:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20180904202729.13900-1-avarab@gmail.com>
 <20180904202729.13900-2-avarab@gmail.com>
 <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
Date:   Wed, 5 Sep 2018 07:58:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/4/2018 6:07 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> With --stdin-packs we don't show any estimation of how much is left to
>> do. This is because we might be processing more than one pack. We
>> could be less lazy here and show progress, either detect by detecting
>> that we're only processing one pack, or by first looping over the
>> packs to discover how many commits they have. I don't see the point in
> I do not know if there is no point, but if we were to do it, I think
> slurping the list of packs and computing the number of objects is
> not all that bad.

If you want to do that, I have nothing against it. However, I don't 
expect users to use that option directly. That option is used by VFS for 
Git to compute the commit-graph in the background after receiving a pack 
of commits and trees, but not by 'git gc' which I expect is how most 
users will compute commit-graphs.

>>   static void compute_generation_numbers(struct packed_commit_list* commits)
>>   {
>>   	int i;
>>   	struct commit_list *list = NULL;
>> +	struct progress *progress = NULL;
>>   
>> +	progress = start_progress(
>> +		_("Computing commit graph generation numbers"), commits->nr);
>>   	for (i = 0; i < commits->nr; i++) {
>> +		display_progress(progress, i);
>>   		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
>>   		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
>>   			continue;
> I am wondering if the progress call should be moved after this
> conditional continue; would we want to count the entry whose
> generation is already known here?  Of course, as we give commits->nr
> as the 100% ceiling, we cannot avoid doing so, but it somehow smells
> wrong.

If we wanted to be completely right, we would count the commits in the 
list that do not have a generation number and report that as the 100% 
ceiling.

Something like the diff below would work. I tested it in Linux by first 
deleting my commit-graph and running the following:

stolee@stolee-linux:~/linux$ rm .git/objects/info/commit-graph
stolee@stolee-linux:~/linux$ git rev-parse v4.6 | ~/git/git commit-graph 
write --stdin-commits
Annotating commits in commit graph: 1180333, done.
Computing commit graph generation numbers: 100% (590166/590166), done.
stolee@stolee-linux:~/linux$ ~/git/git commit-graph write --reachable
Annotating commits in commit graph: 1564087, done.
Computing commit graph generation numbers: 100% (191590/191590), done.

-->8--

From: Derrick Stolee <dstolee@microsoft.com>
Date: Wed, 5 Sep 2018 11:55:42 +0000
Subject: [PATCH] fixup! commit-graph write: add progress output

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
  commit-graph.c | 15 +++++++++++----
  1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1a02fe019a..b933bc9f00 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -634,14 +634,20 @@ static void close_reachable(struct packed_oid_list 
*oids)

  static void compute_generation_numbers(struct packed_commit_list* commits)
  {
-       int i;
+       int i, count_uncomputed = 0;
         struct commit_list *list = NULL;
         struct progress *progress = NULL;

+       for (i = 0; i < commits->nr; i++)
+               if (commits->list[i]->generation == 
GENERATION_NUMBER_INFINITY ||
+                   commits->list[i]->generation == GENERATION_NUMBER_ZERO)
+                       count_uncomputed++;
+
         progress = start_progress(
-               _("Computing commit graph generation numbers"), 
commits->nr);
+               _("Computing commit graph generation numbers"), 
count_uncomputed);
+       count_uncomputed = 0;
+
         for (i = 0; i < commits->nr; i++) {
-               display_progress(progress, i);
                 if (commits->list[i]->generation != 
GENERATION_NUMBER_INFINITY &&
                     commits->list[i]->generation != GENERATION_NUMBER_ZERO)
                         continue;
@@ -670,10 +676,11 @@ static void compute_generation_numbers(struct 
packed_commit_list* commits)

                                 if (current->generation > 
GENERATION_NUMBER_MAX)
                                         current->generation = 
GENERATION_NUMBER_MAX;
+
+                               display_progress(progress, 
++count_uncomputed);
                         }
                 }
         }
-       display_progress(progress, i);
         stop_progress(&progress);
  }

--
2.19.0.rc2

