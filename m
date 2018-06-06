Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC2D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 10:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeFFK1c (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 06:27:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36195 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbeFFK1b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 06:27:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so5703680wrm.3
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOu5hgnuDHuuB7jTeQ6DUELiIxfS5Sw2qtoPBmVc2os=;
        b=NeCVMteTxdVl+OxOaHNymcTLM/lp74HSt1nzWfYRdLNeb6aXm3jNOk8vkfCbuXXHhK
         yWpHs9vcCBN68EzGM55vRFf9g0F0gANsA8pyLjFL9KFbXkSMQn383pFwiT9IsFR4S1wF
         x2Di0rE8geunrbWXUNQQ3EjnAfvAkEX8yHICwV1xIgUHCqkR4/+QJBpta1mn6AA4lTEb
         h37/ncVKlEJOlGtbf0DldnSiRztDgDZZP5ve6nAbdPzkizT2ADkZcbU2KoecuxEhLbDv
         Ux0invs6OlG2Xq0SD21tru5ye+SDHbNQyCJDOY/Pm0gP45xV/pGhHC09zas/k562UFb/
         xINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOu5hgnuDHuuB7jTeQ6DUELiIxfS5Sw2qtoPBmVc2os=;
        b=rv0wvMc7nLO9xLfYm7QSMAtLDRrNSTaHaoVX5CRB/LC/0mjgUV0yOs4Y+OarXs53KW
         slo3SAF7tYkpxxp7Y2kQv8tuTpyj4EKgjdJdtOL9l0MbxmwBAPsU0ZwypnvF3CNwlRBx
         pXRjkGKXM6VGntRdSvBgcwJhynLRuye6jWyoR0rFV9ju+kyOyY/fzjzLwI1f3NR8sf9E
         jhlZxSu6YYfPR5cFEM96LuA5Y1aUjAEq09ZbZuZv0EnDEsMZEPd7HkVEQfGENdxnRVBw
         YSQ2gyUaSEXx1+DtaJV/OMRZKbGmdTQ8KtAlgI7UYx/awsjA1gycyVkijVKf7q+Nr1Sj
         agaA==
X-Gm-Message-State: APt69E3PtyjIRxkZLbcaOswBZueQbVCPI/MUIGAdThfQU11agdMdwx5U
        +cZwYuHO5uThCHY47w7gpU2S0hlz
X-Google-Smtp-Source: ADUXVKI1A8gQcZjnhLZT02cPjPVMzJWujvdIDQsXNjKMakMpWRcdWUQltjplKOYH3OKUwMe9k3DRhg==
X-Received: by 2002:adf:adcb:: with SMTP id w69-v6mr1994544wrc.101.1528280849874;
        Wed, 06 Jun 2018 03:27:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u108-v6sm63722766wrc.40.2018.06.06.03.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 03:27:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/2] unconditional O(1) SHA-1 abbreviation
Date:   Wed,  6 Jun 2018 10:27:17 +0000
Message-Id: <20180606102719.27145-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <87lgbsz61p.fsf@evledraar.gmail.com>
References: <87lgbsz61p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 06 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Jan 08 2018, Derrick Stolee wrote:
>
>> On 1/7/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Sun, Jan 07 2018, Derrick Stolee jotted:
>>>
>>>>      git log --oneline --raw --parents
>>>>
>>>> Num Packs | Before MIDX | After MIDX |  Rel % | 1 pack %
>>>> ----------+-------------+------------+--------+----------
>>>>          1 |     35.64 s |    35.28 s |  -1.0% |   -1.0%
>>>>         24 |     90.81 s |    40.06 s | -55.9% |  +12.4%
>>>>        127 |    257.97 s |    42.25 s | -83.6% |  +18.6%
>>>>
>>>> The last column is the relative difference between the MIDX-enabled repo
>>>> and the single-pack repo. The goal of the MIDX feature is to present the
>>>> ODB as if it was fully repacked, so there is still room for improvement.
>>>>
>>>> Changing the command to
>>>>
>>>>      git log --oneline --raw --parents --abbrev=40
>>>>
>>>> has no observable difference (sub 1% change in all cases). This is likely
>>>> due to the repack I used putting commits and trees in a small number of
>>>> packfiles so the MRU cache workes very well. On more naturally-created
>>>> lists of packfiles, there can be up to 20% improvement on this command.
>>>>
>>>> We are using a version of this patch with an upcoming release of GVFS.
>>>> This feature is particularly important in that space since GVFS performs
>>>> a "prefetch" step that downloads a pack of commits and trees on a daily
>>>> basis. These packfiles are placed in an alternate that is shared by all
>>>> enlistments. Some users have 150+ packfiles and the MRU misses and
>>>> abbreviation computations are significant. Now, GVFS manages the MIDX file
>>>> after adding new prefetch packfiles using the following command:
>>>>
>>>>      git midx --write --update-head --delete-expired --pack-dir=<alt>
>>>
>>> (Not a critique of this, just a (stupid) question)
>>>
>>> What's the practical use-case for this feature? Since it doesn't help
>>> with --abbrev=40 the speedup is all in the part that ensures we don't
>>> show an ambiguous SHA-1.
>>
>> The point of including the --abbrev=40 is to point out that object
>> lookups do not get slower with the MIDX feature. Using these "git log"
>> options is a good way to balance object lookups and abbreviations with
>> object parsing and diff machinery.[...]
>
> [snip]
>
>> [...]And while the public data shape I shared did not show a
>> difference, our private testing of the Windows repository did show a
>> valuable improvement when isolating to object lookups and ignoring
>> abbreviation calculations.
>
> Replying to this old thread since I see you're prepearing the MIDX for
> submission again and this seemed like the best venue.
>
> Your WIP branch (github.com/git/derrickstolee/midx/upstream) still only
> references the speedups in abbreviation calculations, but here you
> allude to other improvements. It would be very nice to have some summary
> of that in docs / commit messages when you submit this.
>
> I've been meaning to get around to submitting something like I mentioned
> in https://public-inbox.org/git/87efn0bkls.fsf@evledraar.gmail.com/
> i.e. a way to expand the abbrev mode to not check disambiguations, which
> would look something like:
>
>     core.abbrev = 20
>     core.validateAbbrev = false
>
> Or:
>
>     core.abbrev = +2
>     core.validateAbbrev = false
>
> So, using the example from the above referenced E-Mail +2 would make
> linux.git emit hashes of 14 characters, without any abbreviation
> checking (just trusting in statistics to work in your favor).
>
> As noted by JS in this thread that wouldn't be acceptable for your
> use-case, but there's plenty of people (including me) who'd appreciate
> the speedup without being a 100% sure we're emitting unambiguous hashes,
> since that trade-off is better than time spent generating another index
> on-disk. So I see it as a complimentary & orthogonal feature.
>
> But with that implemented I wouldn't get any benefit from things that
> use the MIDX that aren't abbreviations, so what are those?

I won't have time to finish this today, but it's already in a shape
that I think is useful for discussion to see what others think.

I still need to make this be supported by --abbrev=* and have
e.g. --abbrev=+2 work. I got as far as this with that:

    diff --git a/parse-options-cb.c b/parse-options-cb.c
    index 0f9f311a7a..7cc9d3dfe6 100644
    --- a/parse-options-cb.c
    +++ b/parse-options-cb.c
    @@ -16,13 +16,23 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
     	if (!arg) {
     		v = unset ? 0 : DEFAULT_ABBREV;
     	} else {
    +		const char *origarg = arg;
     		v = strtol(arg, (char **)&arg, 10);
     		if (*arg)
     			return opterror(opt, "expects a numerical value", 0);
    -		if (v && v < MINIMUM_ABBREV)
    +		if (*origarg == '+' || *origarg == '-') {
    +			if (v == 0) {
    +				return opterror(opt, "relative abbrev must be non-zero", 0);
    +			} else {
    +				default_abbrev_relative = v;
    +				v = -1;
    +			}
    +		} else if (v && v < MINIMUM_ABBREV) {
     			v = MINIMUM_ABBREV;
    -		else if (v > 40)
    +		} else if (v > 40) {
     			v = 40;
    +		}
     	}
     	*(int *)(opt->value) = v;
     	return 0;

But e.g. blame would print 40 character SHA-1s on +2, I didn't have
time to dig into why.

This'll also need tests, I haven't added any yet, and finally it's
probably a good idea to split off the core.abbrev=[+-]NUM feature into
a seperate patch from core.validateAbbrev, although with my 2/2 the
two can be used in isolation, or together.

Ævar Arnfjörð Bjarmason (2):
  config.c: use braces on multiple conditional arms
  sha1-name: add core.validateAbbrev & relative core.abbrev

 Documentation/config.txt | 46 ++++++++++++++++++++++++++++++++++++++++
 cache.h                  |  2 ++
 config.c                 | 18 ++++++++++++++--
 environment.c            |  2 ++
 sha1-name.c              | 15 +++++++++++++
 5 files changed, 81 insertions(+), 2 deletions(-)

-- 
2.17.0.290.gded63e768a

