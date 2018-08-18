Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65011F97E
	for <e@80x24.org>; Sat, 18 Aug 2018 11:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeHROmO (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 10:42:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37705 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROmO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 10:42:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so5883902eds.4
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zACPI1Otl1VJX9z/oXSHDSQfLd4MdmsAcwWlnxSlz4c=;
        b=J0rFckhe8c+Q+1XRJvXXHWJ4CrcnQ2gavlH8J2YINAwoyhjhaYlYdgwGzYp+yNofs5
         FBEWI2R/x4lAq+ofTQKpYPjihHxh1RzKcsE494Of2Lbg743x9oRET2zhCpWq4Mg3W18x
         YkQcpsWG/L3/d70/eoy+wrl7Bcb5UJjpSqqbUDQ3teNmBTItc3VUmo6nsVaKl1ClDR8g
         YNtt6tgRrBBA4fNOPEOLNQntSaRfkCmljD+DzScwNtto2z8gvo//eVGOrhh3P06I/Qd/
         W6wRLLVDuiy9MiulwSl5//yu0lbCERb8TeL0d28wOUsWI8Hfsq7IBqN8AJRVG3Ew7aYp
         qVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zACPI1Otl1VJX9z/oXSHDSQfLd4MdmsAcwWlnxSlz4c=;
        b=DnFYU0+/2xUkfD/gVAvyLooaL9Na2KIEH0Q9jceNdbiG/nofBltwq5uTMPm58uU/om
         fjJ36ILsnfbfhhjHtBNujSLoBaloId7kTXI5QOtyPVE6qIBXHzXAr3y0rCaA4oXU1MDD
         UzGvkpwGmJBJJKgn8wHvX69WV1gDC+9fuE6CDONjQgnub2mgqUrtAYS8WtVfg2DSwIG7
         Q+3aMPKCMdTLSjpA20jLsUYlPkOymt6zt77aTGKR8MT3re5yJNcNYwLiedOvNBuGCxlJ
         SP4stENQ+IziTkvt5N2UxHVdRMC3xVJs9OO6iJVhDO7QTHLACw7+UTonAKoCchF144gO
         L3rw==
X-Gm-Message-State: AOUpUlFnxVVdcQRzgB8Ls7MgeAr2n95jjR9qCE31Hb6QmoIfvPDC8hnD
        c2+Pl5jCW9SI63ux04DUiB4=
X-Google-Smtp-Source: AA+uWPxGhzX9A7UHmohV7sl47AhTI6yyFJD+5rZrJHFW6lmUa10z3OqvFNfUB18bwj3wrTJmB857Xw==
X-Received: by 2002:a50:9935:: with SMTP id k50-v6mr44720033edb.45.1534592092664;
        Sat, 18 Aug 2018 04:34:52 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id s27-v6sm4845922edb.73.2018.08.18.04.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 04:34:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #04; Fri, 17)
References: <xmqqva88aa0c.fsf@gitster-ct.c.googlers.com> <CAP8UFD1BOqGER4-gnv8VQfsRbZ3yYFEx-ScL3s_WfoKgV=rk6A@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAP8UFD1BOqGER4-gnv8VQfsRbZ3yYFEx-ScL3s_WfoKgV=rk6A@mail.gmail.com>
Date:   Sat, 18 Aug 2018 13:34:51 +0200
Message-ID: <876007rjqc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 18 2018, Christian Couder wrote:

> On Sat, Aug 18, 2018 at 12:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * cc/delta-islands (2018-08-16) 7 commits
>>  - pack-objects: move 'layer' into 'struct packing_data'
>>  - pack-objects: move tree_depth into 'struct packing_data'
>>  - t5320: tests for delta islands
>>  - repack: add delta-islands support
>>  - pack-objects: add delta-islands support
>>  - pack-objects: refactor code into compute_layer_order()
>>  - Add delta-islands.{c,h}
>>
>>  Lift code from GitHub to restrict delta computation so that an
>>  object that exists in one fork is not made into a delta against
>>  another object that does not appear in the same forked repository.
>>
>>  What's the doneness of this topic?
>
> All the suggestions by Peff, you, Duy, Dscho, Ramsay and Szeder Gabor
> have been taken into account in the v5 that is in pu.
>
> Except the suggestion by Duy to move 2 fields from 'struct
> object_entry' to 'struct packing_data' (which is implemented in
> patches 6/7 and 7/7) the suggestions have all been about relatively
> small things (documentation, code modernization, regex check,
> translation strings, ...) So the code is very similar to the original
> code in https://github.com/peff/git/commits/jk/delta-islands which has
> been used for years by GitHub in production.
>
> FYI this has been requested from GitLab by Drupal (as well as others)
> see https://www.drupal.org/drupalorg/blog/developer-tools-initiative-part-5-gitlab-partnership
> which contains:
>
> "The timeline for Phase 2 is dependent on GitLab’s resolution of a
> diskspace deduplication issue, which they have committed to on our
> behalf: https://gitlab.com/gitlab-org/gitlab-ce/issues/23029"

This is not a critique of the delta islands feature, just something I'm
curious about.

Why is Drupal blocked on something like delta-islands? The blog post
mentions they have 45k projects, which can be browsed at
https://cgit.drupalcode.org

Almost all of those are completely independent projects, so they
wouldn't benefit from delta islands, and I'd guess >98% are of them are
in an obscure long tail and probably won't have even a single fork.

That leaves forks of say drupal.git, which is ~150MB, the mirror on
GitHub has 1500 forks: https://github.com/drupal Even if there were 5000
forks of that that would be 750G of disk space.

So accounting for backups, me being off by a lot etc. let's say that's
5TB. That's relatively cheap today. Are they really just holding up
their GitLab migration plans to save something on the order of that disk
space, or have I missed something here?

Again, not a critique of delta-islands, because it's most certainly
useful for the likes of github/gitlab, but I wonder if for this
particular problem it wouldn't be more straightforward of a solution for
GitLab to allow anyone to push to
refs/for-merge/<their-username>/<some-name-they-pick> on any
repository. Then they could open a MR for an existing branch in the repo
(which GitLab already supports).
