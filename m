Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C98920437
	for <e@80x24.org>; Tue, 31 Oct 2017 19:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932557AbdJaTGB (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 15:06:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:54540 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdJaTGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 15:06:00 -0400
Received: by mail-qt0-f194.google.com with SMTP id z19so3237qtg.11
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AMARYwB2bqmsuo4iIjWH7Oosn4Ir/YSUj4/SIjrE29E=;
        b=HAlt0Bz9mi6P5nj3lUpKZYegB0y1zDSuCekGWncL7FXjiFlVwyRdBxjQCgVKxq8+9z
         xiQ33sUgMDgMP3Tna+D9vZuE1QFmPs8Sk7mHaM20TfCMY/+QHSFVyqbmu7B+MkRgWn2w
         VNEyzMxMyVe0VnXLi+K4uMR+QxQQxmZ5dOVCV79u/32K7D3xjZVow9Dtf1cfsYuLl23q
         9SLLAuT62pugnNq3qVbd1b0cewq4serS5D66PwVR6CyZaZt2i7SXEpuBv7AetXlV1rgw
         /O5D76tQSFj61hVmE/m1PtC5e6CaP8KleVVMr98C1whyvhvWGb+kPtn5dHmnZvDBqTHG
         L5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AMARYwB2bqmsuo4iIjWH7Oosn4Ir/YSUj4/SIjrE29E=;
        b=ZjNw7CGKteneZJ4EvUsFn0VOV6qUJgKD2z7WbCo4eedsktKwrbr3tu/HFRWGiivLHv
         JF70gyIVfQ8VPzJfs6tLPJcTQU1po0i57cLfTjDdjEg8us7pje2pyazqkoTUyATdJJAZ
         rO7QmZyBQLEASui0CzqK+y6PZ/Qo8iTkbBENGCeI8Rmipvq3NYzoSydMuAjUMpoUzsjl
         YSNtT5Xp+u/vzEJ4hjb0L07/gYMkzb+gcqg5UoS+V+zsIG8LcfqYvqn3wnHdBtXdQ3Ct
         7l2kmSxo0dNDs+NU2OqIvwfMP+LLRgHNNkIIMbylPdUZn0tM5MU3XZOE+rk2Kh/xSoS7
         Yj5w==
X-Gm-Message-State: AMCzsaU2ZWsSWxzYxvrl2OUPHgJUqdgpBhZ9VaI8SAg+y5lI61wpoqc1
        MkD41gRy3I8FLsXSGUrpA3yh6FvsqYGcAsL+uAHvmovxiJQ=
X-Google-Smtp-Source: ABhQp+Qw7Hq5UJ3cd9gPBm7GYK72ReEapbfA2Q5/7fL4VUd4EPH6GOTffuj62tGIpbCxSm/SYHkGEOnzLIBdLpUvoPY=
X-Received: by 10.237.34.201 with SMTP id q9mr4530750qtc.198.1509476759058;
 Tue, 31 Oct 2017 12:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 31 Oct 2017 12:05:58 -0700 (PDT)
In-Reply-To: <xmqq60avztm4.fsf@gitster.mtv.corp.google.com>
References: <20171028004419.10139-1-sbeller@google.com> <20171031003351.22341-1-sbeller@google.com>
 <20171031003351.22341-5-sbeller@google.com> <xmqq60avztm4.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Oct 2017 12:05:58 -0700
Message-ID: <CAGZ79kYgeShgCfgm0-D6D0r8ndZFBuxKBXcaVPEo0T5eoPBQEQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] builtin/describe.c: print debug statements earlier
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 12:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> For debuggers aid we'd want to print debug statements early, so
>> introduce a new line in the debug output that describes the whole
>> function, and the change the next debug output to describe why we need
>> to search. Conveniently drop the arg from the second line; which will
>> be useful in a follow up commit, that refactors the describe function.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Adding an eary "entry" log may indeed be a good idea.  This is not a
> new issue, but I do not think it is a good trade-off to burden i18n
> teams to translate debug-only messages, though.

The original motivation here is to use the 'arg' argument so early in the
function that the next patch can omit passing in 'arg' as the lines
using 'arg' are not in the factored out function.

8713ab3079 (Improve git-describe performance by reducing
revision listing., 2007-01-13) added the --debug flag, and also
exposed it to the man page, so it is user visible, which is why we cannot
keep these messages untranslated.

>
>>  builtin/describe.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index fd61f463cf..3136efde31 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -293,6 +293,9 @@ static void describe(const char *arg, int last_one)
>>       unsigned long seen_commits = 0;
>>       unsigned int unannotated_cnt = 0;
>>
>> +     if (debug)
>> +             fprintf(stderr, _("describe %s\n"), arg);
>> +
>>       if (get_oid(arg, &oid))
>>               die(_("Not a valid object name %s"), arg);
>>       cmit = lookup_commit_reference(&oid);
>> @@ -316,7 +319,7 @@ static void describe(const char *arg, int last_one)
>>       if (!max_candidates)
>>               die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
>>       if (debug)
>> -             fprintf(stderr, _("searching to describe %s\n"), arg);
>> +             fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
>>
>>       if (!have_util) {
>>               struct hashmap_iter iter;
