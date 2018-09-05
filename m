Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093E61F404
	for <e@80x24.org>; Wed,  5 Sep 2018 12:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIEQhu (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 12:37:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33387 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIEQht (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 12:37:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so7431770wrc.0
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YNRwEV952vUcyYQxiFJDcgfDsQkgsL7xavkkWGLBJc4=;
        b=CSadO3fhj/CTuxgSv3pot4BmPLx7FqldfLt64cUegf+3AXs1giNiaHTui9ab0UvU3a
         uB77k/AWmMiE7Bacdm9X2RiDwWuIV59TYb6ye+L6o35hCd8H7lOEZpq1+qgqEQD3vHlz
         uHLhMyV2VmLd4lva0e5rNEvp+dgroP8U7LWkysf5NrFMgTJCSEMP+5Gr9/KaZWdLfh5y
         e5dAGRTFdOc78K/r6lD3PFE3xcmBRP0XWo8ExlD/8qFnfaPjvOecgdvOIgeCSpg1LceI
         WzWkXTn9Xz/TZHmTgAOKX6bMbgGc1CIwQksAYsW3HrAOpNl6giFITX0KboO1mMIpWa3U
         992w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YNRwEV952vUcyYQxiFJDcgfDsQkgsL7xavkkWGLBJc4=;
        b=jC0Y7iqR6AueedMLlsFKZcL514XjPAxxypPTLbpVBfG8Cb+VeodXowPFXwByY658z+
         b4/bX10rKMccVUZvSWCgWh3GhL/QCz4N82wKY1oltcMBx8mYRwqutNqdgAQhLjqsj9dB
         apuF6mVv4Q5m3JWPXAQxC9q7eqHDueDxwNEG0dXBsXxKLyAiwQX3guShKyC4uKRX1yCn
         loGxM2Rz9uAsYKsSTVd9ubh9bPvC+pbnB1lUPRU5nfGNBnQKA0tD/bMEtpDcgLxtvPjy
         Qo3oit2+CqONybvsKJroDrRWOiMdAjXRxntkxt5E01MPNtgLPUJaZM23OnWiyZJsZpbE
         G3fg==
X-Gm-Message-State: APzg51AWW1Pm/mnfe+ky2sHbVUNty0BDQYgLZFQB2BRPBGI1GbuOfrbP
        dL0FOB3/wWSg0HtdiqtfZIk=
X-Google-Smtp-Source: ANB0VdaSAPDjBnfA6HbkgSPaed1AoKg6FzmIxMk0TzlMWbkNQRMBO7Csk0lxzW3O3X/7u2XQQdMRTg==
X-Received: by 2002:a5d:490b:: with SMTP id x11-v6mr25410362wrq.114.1536149270850;
        Wed, 05 Sep 2018 05:07:50 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id x65-v6sm1995065wmg.39.2018.09.05.05.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 05:07:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
References: <20180904202729.13900-1-avarab@gmail.com> <20180904202729.13900-2-avarab@gmail.com> <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com> <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
Date:   Wed, 05 Sep 2018 14:07:49 +0200
Message-ID: <875zzkrvu2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 05 2018, Derrick Stolee wrote:

> On 9/4/2018 6:07 PM, Junio C Hamano wrote:
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> With --stdin-packs we don't show any estimation of how much is left to
>>> do. This is because we might be processing more than one pack. We
>>> could be less lazy here and show progress, either detect by detecting
>>> that we're only processing one pack, or by first looping over the
>>> packs to discover how many commits they have. I don't see the point in
>> I do not know if there is no point, but if we were to do it, I think
>> slurping the list of packs and computing the number of objects is
>> not all that bad.
>
> If you want to do that, I have nothing against it. However, I don't
> expect users to use that option directly. That option is used by VFS
> for Git to compute the commit-graph in the background after receiving
> a pack of commits and trees, but not by 'git gc' which I expect is how
> most users will compute commit-graphs.

Yeah, I suspected only one guy at Microsoft would potentially benefit
from this, but added it just so we'd have progress regardless of entry
point :)

>>>   static void compute_generation_numbers(struct packed_commit_list* commits)
>>>   {
>>>   	int i;
>>>   	struct commit_list *list = NULL;
>>> +	struct progress *progress = NULL;
>>>   +	progress = start_progress(
>>> +		_("Computing commit graph generation numbers"), commits->nr);
>>>   	for (i = 0; i < commits->nr; i++) {
>>> +		display_progress(progress, i);
>>>   		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
>>>   		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
>>>   			continue;
>> I am wondering if the progress call should be moved after this
>> conditional continue; would we want to count the entry whose
>> generation is already known here?  Of course, as we give commits->nr
>> as the 100% ceiling, we cannot avoid doing so, but it somehow smells
>> wrong.
>
> If we wanted to be completely right, we would count the commits in the
> list that do not have a generation number and report that as the 100%
> ceiling.
>
> Something like the diff below would work. I tested it in Linux by
> first deleting my commit-graph and running the following:
>
> stolee@stolee-linux:~/linux$ rm .git/objects/info/commit-graph
> stolee@stolee-linux:~/linux$ git rev-parse v4.6 | ~/git/git
> commit-graph write --stdin-commits
> Annotating commits in commit graph: 1180333, done.
> Computing commit graph generation numbers: 100% (590166/590166), done.
> stolee@stolee-linux:~/linux$ ~/git/git commit-graph write --reachable
> Annotating commits in commit graph: 1564087, done.
> Computing commit graph generation numbers: 100% (191590/191590), done.
>
> -->8--
>
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Wed, 5 Sep 2018 11:55:42 +0000
> Subject: [PATCH] fixup! commit-graph write: add progress output
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> commit-graph.c | 15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 1a02fe019a..b933bc9f00 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -634,14 +634,20 @@ static void close_reachable(struct
> packed_oid_list *oids)
>
> static void compute_generation_numbers(struct packed_commit_list* commits)
> {
> - int i;
> + int i, count_uncomputed = 0;
>  struct commit_list *list = NULL;
>  struct progress *progress = NULL;
>
> + for (i = 0; i < commits->nr; i++)
> + if (commits->list[i]->generation ==
> GENERATION_NUMBER_INFINITY ||
> + commits->list[i]->generation == GENERATION_NUMBER_ZERO)
> + count_uncomputed++;
> +
>  progress = start_progress(
> - _("Computing commit graph generation numbers"),
> commits->nr);
> + _("Computing commit graph generation numbers"),
> count_uncomputed);
> + count_uncomputed = 0;
> +
>  for (i = 0; i < commits->nr; i++) {
> - display_progress(progress, i);
>  if (commits->list[i]->generation !=
> GENERATION_NUMBER_INFINITY &&
>  commits->list[i]->generation != GENERATION_NUMBER_ZERO)
>  continue;
> @@ -670,10 +676,11 @@ static void compute_generation_numbers(struct
> packed_commit_list* commits)
>
>  if (current->generation >
> GENERATION_NUMBER_MAX)
>  current->generation =
> GENERATION_NUMBER_MAX;
> +
> + display_progress(progress,
> ++count_uncomputed);
>  }
>  }
>  }
> - display_progress(progress, i);
>  stop_progress(&progress);
> }

Thanks! That looks good, and you obviously know this code a lot
better. I'll squash this into v2 pending further feedback I'll need to
address.
