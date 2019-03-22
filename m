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
	by dcvr.yhbt.net (Postfix) with ESMTP id A75A520248
	for <e@80x24.org>; Fri, 22 Mar 2019 15:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfCVPL3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 11:11:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37907 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCVPL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 11:11:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id q14so1977285edr.5
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4vPkIZMLqI6QrQU+jY5WwEAZq96URynqmI4uRW/3Xr4=;
        b=YdPoXjJZhnwlKq11tUyvaMbRL+7p3FkesmrSRg+lh84YoJaa/J35gZbVDDBXXB1x6M
         iQ+FwjdXtcQek3U7cCK2SX7oOcXJ9fgxbhgtqN1md1WirkGv3ggjT4Z3OhWAuMj6UXIT
         MLebo5rsUkUCE1GSGCJadCwCJBxNzmmRCqW+xVUUCEh7rvmfAbY2JUrcIyNRKQuy/xeV
         0Acq6JLzhJx/4vU6/R0KLjExu6FcP1rQGuVjNlo4R/fW7QsNYwCKBQH5GPzscGJpOgKk
         dmwgS7EUfS5K+Xnasv43n3KVBAILwdPDk2AZ7S4xfOhvlx+kOF/V3fZYlXVw12dVe7iJ
         P2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4vPkIZMLqI6QrQU+jY5WwEAZq96URynqmI4uRW/3Xr4=;
        b=GGs24PfdpaG4WuwCjFo421RYKLT7HywBTMyyXZApAicgcHaFQwgFf5BW1nN2gpHA0a
         5y9Lim7jJ8S0WRwbrLP238u5bZuBEjuEK5cfaIPXf8rEvXepTpjxoJ2k15KOJp8PHY4/
         9Zsc58xO30dMJFf9VoR3oaDXYULNsjMez8YaSR2hC++irlLsiRKWmuB1bDSEMztwu1rr
         AFnxxp/XyXJbTZJJaO2xxMu8mny5DHChDiH6v+Cz0dizH3acRdy+0WDUKjCs/tzqDox7
         0J+coP4BzO5Urah7VhUWCqsGTdUtImk6e0VJ+yY8CE8xfTVjCzZdtUIR2G2iU4i6K+ZP
         nbww==
X-Gm-Message-State: APjAAAXArKRinpZmuz5Yhg9oggIcgXK0mCtJRFMcnw9zqJKnjoGd6+h0
        DXfwvo3SSbA2oM9KFIcvvq7xgubzWfo=
X-Google-Smtp-Source: APXvYqzGeQ45F1ZkZMU90fz2O/kShXDvCmjt1CWgeiE1XbUcZEoGjt7jXHWD8jfaErQnguLkL7Ynhw==
X-Received: by 2002:a17:906:2989:: with SMTP id x9mr5889858eje.218.1553267487387;
        Fri, 22 Mar 2019 08:11:27 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id x18sm2682655edd.4.2019.03.22.08.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 08:11:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: don't show progress percentages while expanding reachable commits
References: <20190119202121.3590-11-avarab@gmail.com> <20190322102817.19708-1-szeder.dev@gmail.com> <87lg17cgf5.fsf@evledraar.gmail.com> <20190322111829.GC22459@szeder.dev> <87k1grc7al.fsf@evledraar.gmail.com> <20190322145550.GE22459@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190322145550.GE22459@szeder.dev>
Date:   Fri, 22 Mar 2019 16:11:24 +0100
Message-ID: <87ftrfc5b7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 22 2019, SZEDER G=C3=A1bor wrote:

> On Fri, Mar 22, 2019 at 03:28:34PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Fri, Mar 22 2019, SZEDER G=C3=A1bor wrote:
>>
>> > On Fri, Mar 22, 2019 at 12:11:26PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>
>> >> On Fri, Mar 22 2019, SZEDER G=C3=A1bor wrote:
>> >>
>> >> > Commit 49bbc57a57 (commit-graph write: emit a percentage for all
>> >> > progress, 2019-01-19) was a bit overeager when it added progress
>> >> > percentages to the "Expanding reachable commits in commit graph" ph=
ase
>> >> > as well, because most of the time the number of commits that phase =
has
>> >> > to iterate over is not known in advance and grows significantly, an=
d,
>> >> > consequently, we end up with nonsensical numbers:
>> >> >
>> >> >   $ git commit-graph write --reachable
>> >> >   Expanding reachable commits in commit graph: 138606% (824706/595)=
, done.
>> >> >   [...]
>> >> >
>> >> >   $ git rev-parse v5.0 | git commit-graph write --stdin-commits
>> >> >   Expanding reachable commits in commit graph: 81264400% (812644/1)=
, done.
>> >> >   [...]
>> >> >
>> >> > Therefore, don't show progress percentages in the "Expanding reacha=
ble
>> >> > commits in commit graph" phase.
>> >>
>> >> There's indeed a bug here as your examples show, but there *are* cases
>> >> where it's correct, as the commit message for my patch on "master" sh=
ows
>> >> there's cases where we correctly.
>> >>
>> >> So this "fixes" things by always removing the progress, why not inste=
ad
>> >> pass down the state to close_reachable() about what we're walking ove=
r,
>> >> so we can always show progress, or at least in some cases?
>> >
>> > The cases where it does display correct percentages are exceptional,
>> > and doesn't worth the effort to try to find out whether ther current
>> > operation happens to be such a case.
>>
>> It's the "write" entry point without arguments that displays the correct
>> progress. So not exceptional, but yeah, it's not what we use on "gc".
>
> Bit it displays the correct number only if all the reachable commits
> are in packfiles, which is not necessarily the case (e.g. unpacked
> small packs during 'git fetch').

No, argument-less "write" only considers packed commits.

>> In any case, the problem is that sometimes we've walked the full set of
>> commits already, and some other times we haven't.
>
> ... and that we can't really be sure whether we've walked the full set
> of commits until after this loop.

I'm fairly sure we can when we start with a full walk. See my
explanation in <87imwbc6x8.fsf@evledraar.gmail.com>, but I may have
missed something.

>> So in cases where we have we can show progress, and as a TODO (I think
>> this came up in previous discussions), we could do better if we had a
>> approximate_commit_count().
>>
>> In any case, the below fix seems correct to me, but I haven't poked it
>> much. It *does* suffer from a theoretical race with the progress bar
>> similar to d9b1b309cf ("commit-graph write: show progress for object
>> search", 2019-01-19), but I work around it in the same way:
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 47e9be0a3a..0fab3d8b2b 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -693,7 +693,8 @@ static void add_missing_parents(struct packed_oid_li=
st *oids, struct commit *com
>>  	}
>>  }
>>
>> -static void close_reachable(struct packed_oid_list *oids, int report_pr=
ogress)
>> +static void close_reachable(struct packed_oid_list *oids, int report_pr=
ogress,
>> +			    uint64_t oids_count_for_progress)
>>  {
>>  	int i;
>>  	struct commit *commit;
>> @@ -717,7 +718,8 @@ static void close_reachable(struct packed_oid_list *=
oids, int report_progress)
>>  	 */
>>  	if (report_progress)
>>  		progress =3D start_delayed_progress(
>> -			_("Expanding reachable commits in commit graph"), oids->nr);
>> +			_("Expanding reachable commits in commit graph"),
>> +			oids_count_for_progress);
>>  	for (i =3D 0; i < oids->nr; i++) {
>>  		display_progress(progress, i + 1);
>>  		commit =3D lookup_commit(the_repository, &oids->list[i]);
>> @@ -725,6 +727,8 @@ static void close_reachable(struct packed_oid_list *=
oids, int report_progress)
>>  		if (commit && !parse_commit(commit))
>>  			add_missing_parents(oids, commit);
>>  	}
>> +	if (oids->nr < oids_count_for_progress)
>> +		display_progress(progress, oids_count_for_progress);
>>  	stop_progress(&progress);
>>
>>  	if (report_progress)
>> @@ -829,6 +833,7 @@ void write_commit_graph(const char *obj_dir,
>>  	uint64_t progress_cnt =3D 0;
>>  	struct strbuf progress_title =3D STRBUF_INIT;
>>  	unsigned long approx_nr_objects;
>> +	uint64_t oids_count_for_progress =3D 0;
>>
>>  	if (!commit_graph_compatible(the_repository))
>>  		return;
>> @@ -934,9 +939,10 @@ void write_commit_graph(const char *obj_dir,
>>  		if (oids.progress_done < approx_nr_objects)
>>  			display_progress(oids.progress, approx_nr_objects);
>>  		stop_progress(&oids.progress);
>> +		oids_count_for_progress =3D oids.nr;
>>  	}
>>
>> -	close_reachable(&oids, report_progress);
>> +	close_reachable(&oids, report_progress, oids_count_for_progress);
>>
>>  	if (report_progress)
>>  		progress =3D start_delayed_progress(
>>
