Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC69520248
	for <e@80x24.org>; Fri, 22 Mar 2019 14:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfCVOgk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 10:36:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46945 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbfCVOgj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 10:36:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so1852161edd.13
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EfkBb7jsSrwGz7Z2LdCMV/B/0mVqzXhDTv1/KiaZAh4=;
        b=NOhXOj4lD9f+4ntyc+RvNgICiODBusaJohN6zvr/b/rPC12MXLAFYTIeS7eArLpCiM
         0Ky+hs8hqErXP/gVrlVJxqwUVXdv3fd2Z8P+1F+UYDjotLhVaALcSSl4cgkbDaFQf4w2
         o+apmcjbLTfG2j00cwkswTZVadLoDzZLyNwVjrJE9ylV9Z14pc00PokWvfw7TA/XgFV9
         g4OiY1yCjC4hupBykt7hWcNTrTkdGo31KafwnYyay4q1m9lm8khKgraUbLcZmMDq2tEt
         P3ONB3wPfD1G2NKZLCilyRyTddvKYsb3ETeIQ7AW1rdtQIOCnIFovytMMgthl/rqSC6t
         kx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EfkBb7jsSrwGz7Z2LdCMV/B/0mVqzXhDTv1/KiaZAh4=;
        b=BqL3CEDtI2uHb6pIiDkYQM5QrpE4tw9rekIduo0Gi5rX43qlOSsDCWyrVwqqwdYZJ8
         MmQ5mutbCTcmMkPKeaGBspvpJTLYWCaIk7uJdEdkWojzqUcmk9/vuKJPc8CHERbZHhtw
         RFOAc/lgKjEC5vA+RyseKSgZvQtWy7Sq8lfjN7lIu52ZZEsDIfpSJxLTov5O6/q37gFy
         lbXMJQuhytwPSSlFlu/zswMz3GWCVMjx/bnZL5sCzvah1/W7/zfMpNRG7GqO2pc/R++O
         CvjvIdQkVsuC09a6Uq3PiGdWoeWK1KftEb4LCCjdpV3zs/Zy64v/tW78nFtEXTWSS0P9
         ogbA==
X-Gm-Message-State: APjAAAXTcf+Bh9i5j8Quau8HFpnUAw5Hqr+QpYKImHqqZXDJPTrMm15v
        vN/dev5gpddJu2DLdZ9JY74yE3WMJSE=
X-Google-Smtp-Source: APXvYqw8QFzk8YXrM75R9uUjIKN7gSu87u36xORGRXZIqphS+2XxoW/S2eUUU3q7AI/IY87W5TSEwg==
X-Received: by 2002:a17:906:28c7:: with SMTP id p7mr5858753ejd.235.1553265397393;
        Fri, 22 Mar 2019 07:36:37 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id m4sm1737243ejl.49.2019.03.22.07.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 07:36:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: don't show progress percentages while expanding reachable commits
References: <20190119202121.3590-11-avarab@gmail.com> <20190322102817.19708-1-szeder.dev@gmail.com> <87lg17cgf5.fsf@evledraar.gmail.com> <20190322111829.GC22459@szeder.dev> <87k1grc7al.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87k1grc7al.fsf@evledraar.gmail.com>
Date:   Fri, 22 Mar 2019 15:36:35 +0100
Message-ID: <87imwbc6x8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 22 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Mar 22 2019, SZEDER G=C3=A1bor wrote:
>
>> On Fri, Mar 22, 2019 at 12:11:26PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>>
>>> On Fri, Mar 22 2019, SZEDER G=C3=A1bor wrote:
>>>
>>> > Commit 49bbc57a57 (commit-graph write: emit a percentage for all
>>> > progress, 2019-01-19) was a bit overeager when it added progress
>>> > percentages to the "Expanding reachable commits in commit graph" phase
>>> > as well, because most of the time the number of commits that phase has
>>> > to iterate over is not known in advance and grows significantly, and,
>>> > consequently, we end up with nonsensical numbers:
>>> >
>>> >   $ git commit-graph write --reachable
>>> >   Expanding reachable commits in commit graph: 138606% (824706/595), =
done.
>>> >   [...]
>>> >
>>> >   $ git rev-parse v5.0 | git commit-graph write --stdin-commits
>>> >   Expanding reachable commits in commit graph: 81264400% (812644/1), =
done.
>>> >   [...]
>>> >
>>> > Therefore, don't show progress percentages in the "Expanding reachable
>>> > commits in commit graph" phase.
>>>
>>> There's indeed a bug here as your examples show, but there *are* cases
>>> where it's correct, as the commit message for my patch on "master" shows
>>> there's cases where we correctly.
>>>
>>> So this "fixes" things by always removing the progress, why not instead
>>> pass down the state to close_reachable() about what we're walking over,
>>> so we can always show progress, or at least in some cases?
>>
>> The cases where it does display correct percentages are exceptional,
>> and doesn't worth the effort to try to find out whether ther current
>> operation happens to be such a case.
>
> It's the "write" entry point without arguments that displays the correct
> progress. So not exceptional, but yeah, it's not what we use on "gc".
>
> In any case, the problem is that sometimes we've walked the full set of
> commits already, and some other times we haven't.
>
> So in cases where we have we can show progress, and as a TODO (I think
> this came up in previous discussions), we could do better if we had a
> approximate_commit_count().
>
> In any case, the below fix seems correct to me, but I haven't poked it
> much. It *does* suffer from a theoretical race with the progress bar
> similar to d9b1b309cf ("commit-graph write: show progress for object
> search", 2019-01-19), but I work around it in the same way:

So double brainfart there, I meant "race with new objects being
added/removed", but ....

> diff --git a/commit-graph.c b/commit-graph.c
> index 47e9be0a3a..0fab3d8b2b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -693,7 +693,8 @@ static void add_missing_parents(struct packed_oid_lis=
t *oids, struct commit *com
>  	}
>  }
>
> -static void close_reachable(struct packed_oid_list *oids, int report_pro=
gress)
> +static void close_reachable(struct packed_oid_list *oids, int report_pro=
gress,
> +			    uint64_t oids_count_for_progress)
>  {
>  	int i;
>  	struct commit *commit;
> @@ -717,7 +718,8 @@ static void close_reachable(struct packed_oid_list *o=
ids, int report_progress)
>  	 */
>  	if (report_progress)
>  		progress =3D start_delayed_progress(
> -			_("Expanding reachable commits in commit graph"), oids->nr);
> +			_("Expanding reachable commits in commit graph"),
> +			oids_count_for_progress);
>  	for (i =3D 0; i < oids->nr; i++) {
>  		display_progress(progress, i + 1);
>  		commit =3D lookup_commit(the_repository, &oids->list[i]);
> @@ -725,6 +727,8 @@ static void close_reachable(struct packed_oid_list *o=
ids, int report_progress)
>  		if (commit && !parse_commit(commit))
>  			add_missing_parents(oids, commit);
>  	}
> +	if (oids->nr < oids_count_for_progress)
> +		display_progress(progress, oids_count_for_progress);


...that race exists for the approximate_object_count case in d9b1b309cf
because in the time between approximate_object_count() and our second
walk via for_each_packed_object() the packs may have changed
(e.g. concurrent "git push").

But this won't happen in this case, because we already know the commits
we want to seed from, and the only thing that will "change" is that we
haven't walked the parents of some of those commits when we e.g. seed
from just HEAD.

But when oids_count_for_progress is >0 here we've walked all the commits
we found in the relevant packs already, it's not possible that they've
gained new parents in the interim, so this "oids->nr <
oids_count_for_progress" case here is pointless cargo-culting.

>  	stop_progress(&progress);
>
>  	if (report_progress)
> @@ -829,6 +833,7 @@ void write_commit_graph(const char *obj_dir,
>  	uint64_t progress_cnt =3D 0;
>  	struct strbuf progress_title =3D STRBUF_INIT;
>  	unsigned long approx_nr_objects;
> +	uint64_t oids_count_for_progress =3D 0;
>
>  	if (!commit_graph_compatible(the_repository))
>  		return;
> @@ -934,9 +939,10 @@ void write_commit_graph(const char *obj_dir,
>  		if (oids.progress_done < approx_nr_objects)
>  			display_progress(oids.progress, approx_nr_objects);
>  		stop_progress(&oids.progress);
> +		oids_count_for_progress =3D oids.nr;
>  	}
>
> -	close_reachable(&oids, report_progress);
> +	close_reachable(&oids, report_progress, oids_count_for_progress);
>
>  	if (report_progress)
>  		progress =3D start_delayed_progress(
