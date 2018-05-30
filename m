Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35861F42D
	for <e@80x24.org>; Wed, 30 May 2018 20:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeE3U04 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 16:26:56 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35130 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbeE3U0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 16:26:54 -0400
Received: by mail-qt0-f176.google.com with SMTP id j1-v6so25024742qtp.2
        for <git@vger.kernel.org>; Wed, 30 May 2018 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AJz+Fi84lNBhilTN2+VMZVViKb1DqCCmB7OAVe9FbQ0=;
        b=hWB0wraXkILacPsWPTXjYFICrmh2y/BMkkCOcP6J7DsKDAbN64f0nVCxZFSnLDoe7Y
         D6KePeC/eJn0HVZ4rO5iiatwH1Q51vSaZ4ZVjBzAzCgXP8b3b0q4TKea6MaamtNBbcur
         uttyxY0B+E+4KdGT+a2dICOD2K4tFnOb+R28f/dKAGmKm61DmHhsGJoJ7haooQKdLlBA
         kwqNS4BpqkWBEOQOSuelGYoPoACBW2Pt5w18/kpR6h/TxKVKjSPyo63h00B+X0Eyvij2
         sUfV6/zN5ZLA3Kai7aSBgQiPjY1bEBDV7hRcxTVe5/ejjSu/F3iTEzOzzXxlWZCcohut
         j/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AJz+Fi84lNBhilTN2+VMZVViKb1DqCCmB7OAVe9FbQ0=;
        b=X9KMLC09A1FJ/cLxrJx5g0SgEqDfFcMpYzdV+IecoaD/oBQRrNd4Hgw6UYA0GIBD24
         gY5nB6z0Pn1p8I7GlpBdELRgs8JlKuNQT9D3NIyqw5x70s8QyM5pQhbnUf+hzeCpUya4
         H49/U6hxXWKXIYaw7+KScxg9r6//+0FP+o+Zs6Y2EJc+RVghwR4Rot6OGRfaI25xnr4x
         B9h78X24B+NUs9MlYbns/PYL6H2cpIaU///kVBqLBmh0Qx3TsajPETnUF6A0t6n4Lz1c
         lK0qDKB69ks4+9NTYFQrsFZ8L4/qrnQcLoSngXZVqH195Zfem2SSGIt0W1Tr5h1fNllf
         0WfA==
X-Gm-Message-State: APt69E34PiB8urYL6kUFvGf86BFHDsIQZBjyjiFLQA9+Kg6Re5yS4ciM
        fq6kpZD92+/gS/HQfWB9zfiYDDy4Pjaq8RN+Xl4=
X-Google-Smtp-Source: ADUXVKJhmOVGVljX5n3G8/JsE5tjzqqj3GN5KFP8+XM7dRdzMoA5xu43f5LDnR/qeZ2VKE76OTQIxCtN+x4MiN3fDks=
X-Received: by 2002:a0c:b7af:: with SMTP id l47-v6mr4133095qve.110.1527712013670;
 Wed, 30 May 2018 13:26:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Wed, 30 May 2018 13:26:53
 -0700 (PDT)
In-Reply-To: <CAGZ79kZSjwsk-YE1G3sGX-sfdu17NjMo-Jbrw2E5AbpbNGSGyg@mail.gmail.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <20180530080325.37520-4-sunshine@sunshineco.com> <CAGZ79kZSjwsk-YE1G3sGX-sfdu17NjMo-Jbrw2E5AbpbNGSGyg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 May 2018 16:26:53 -0400
X-Google-Sender-Auth: AHkgmdmavbLg5-40F03gdiujDgs
Message-ID: <CAPig+cQEFQah4VM3keTE94Yj9aXp1oKhgLwsz6=m8jJMTTmecQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] format-patch: extend --range-diff to accept
 revision range
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 2:58 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, May 30, 2018 at 1:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> When submitting a revised a patch series, the --range-diff option embeds
>> a range-diff in the cover letter showing changes since the previous
>> version of the patch series. The argument to --range-diff is a simple
>> revision naming the tip of the previous series, which works fine if the
>> previous and current versions of the patch series share a common base.
>>
>> However, it fails if the revision ranges of the old and new versions of
>> the series are disjoint. To address this shortcoming, extend
>> --range-diff to also accept an explicit revision range for the previous
>> series. For example:
>>
>>     git format-patch --cover-letter --range-diff=v1~3..v1 -3 v2
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>  static void infer_diff_ranges(struct argv_array *args,
>>                               const char *prev,
>> +                             struct commit *origin,
>>                               struct commit *head)
>>  {
>> -       argv_array_pushf(args, "%s...%s", prev,
>> -                        oid_to_hex(&head->object.oid));
>> +       if (strstr(prev, "..")) {
>> +               if (!origin)
>> +                       die(_("failed to infer range-diff ranges"));
>
>>  static int get_range_diff(struct strbuf *sb,
>> @@ -1059,7 +1069,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>>         /* might die from bad user input so try before creating cover letter */
>>         if (range_diff) {
>>                 struct argv_array ranges = ARGV_ARRAY_INIT;
>> -               infer_diff_ranges(&ranges, range_diff, head);
>> +               infer_diff_ranges(&ranges, range_diff, origin, head);
>
> This is way before the check for 'if (origin) emit_diffstat' as done in
> patch 1, as we want to do this early. We need to check the non-NULLness
> in infer_diff_ranges [...]

Correct.

> Would it make sense to give a better error message in:
>
>> +               if (!origin)
>> +                       die(_("failed to infer range-diff ranges"));
>
> above? (The failure sounds like it could be anything, but the
> reason for it is actually well understood: The origin was
> computed and as the boundary commit of the given range,
> or NULL if there is no boundary commit or multiple commits.

I'm not entirely happy with the generic error message either but
didn't come up with anything better which was both succinct and
actually helpful. I was hoping that a reviewer might suggest something
better.

> If we find not exactly one boundary, we cannot compute the
> range to give to the range-diff tool.

I considered allowing the argument to --range-diff to be much more
complex: to provide a way for the user to supply all information
needed for the invocation of git-range-diff (basically, to manually
supply arguments to git-range-diff) for cases when inference wasn't
possible. I even went so far as to consider allowing the
'creation-weight' to be specified as part of the --range-diff
argument. However, that sort of complexity is both difficult to
explain (document) and tends to be painful for users to specify (type
correctly).

Therefore, in the end, I opted for simplicity: namely, handle the
common cases with straight-forward minimal-learning-curve standard
options. Both --range-diff=v3 and --range-diff=v3~4..v3 are easy to
document and understand, as is the distinct --creation-weight= option.
This seems a good balance between extreme flexibility and relative
simplicity for handling common needs. (And, --range-diff is just a
convenience, after all; more complex scenarios can still be handled
manually by invoking git-range-diff followed by copy/paste.)

> Stepping back to the error message, I have no good
> suggestion on what to say there. Maybe we'd want to
> refactor the code in cmd_format_patch, that computes the
> origin:
>
>         if (prepare_revision_walk(&rev))
>                 die(_("revision walk setup failed"));
>         rev.boundary = 1;
>         while ((commit = get_revision(&rev)) != NULL) {
>                 if (commit->object.flags & BOUNDARY) {
>                         boundary_count++;
>                         origin = (boundary_count == 1) ? commit : NULL;
>                         continue;
>                 }
>
> We could prefix that with
>
>     need_origin = (range_diff && strstr(prev, "..")  || emit_diff_stat;
>
> and then if need_origin is about to be unset again we could issue
> a warning and die early after the loop warning about bad DAG form?
>
> I guess that can wait for a follow up patch.

I agree. The feature can be improved and made more fancy incrementally
as we gain better understanding of areas which need improvement. As a
first step, I wanted to keep it minimal but usable for the most common
cases.

Thanks for the review.
