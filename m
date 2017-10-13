Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EDF20437
	for <e@80x24.org>; Fri, 13 Oct 2017 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758219AbdJMNjT (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 09:39:19 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:56302 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758217AbdJMNjR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 09:39:17 -0400
Received: by mail-qt0-f178.google.com with SMTP id v41so9383265qtv.12
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZtrXlDZ5/XEqJb7JKW314vabVeNWNYCZ66CK7LaVV8o=;
        b=uA9hIQVrkvYXiQHO18BoTb35gERuBeUDmqTtlFpFpFPlAk6t1VqBtGnoygTUTOLPZ1
         SWDjrDQfI9KI9wCuZnGPldourtcYbvkisE4wgniWE2YmS4Egc9XqkJ7vRrgtZZP6tZ2a
         voY5SVdN5EZIUFMv5rkmYNuNQrDQWHxZgT4EoATLbd0jRzXBHeWJRTCvlL/wgOdtWkdY
         cZOGLifCDgCT1QxVB7BTrPH0BJSH9kiebRqpKJAk3wyYrlkgWWOA7NKWpppdyzH/0MN8
         sv3S7XubkeW9rk9p/IR8siLzZawNT9pVOUw488XtGAM7Oc7gEjrM6ymNwbH8Sb637xmx
         u8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZtrXlDZ5/XEqJb7JKW314vabVeNWNYCZ66CK7LaVV8o=;
        b=aTbx0dvAVPKvb3N0P7Xh/GsUle96w8b0gWglxuOxTzZjmPn8mFBLU+NoPgtkm25cA8
         Mji4m+kmWoeHn3kcbBRi67ji72KBxqcOr8cWMh2jjH2pfPLN6FynZcsGblEl8/fFD53i
         S8FjtANWKpIZw7tyciHKkOT1dZ5ovspOAu+oVJbd06s/ZpyC3nEjoyEppFwFAXm+VgA5
         KvCpSod0vuEjdIzL/6q61xMLmD20wotE9EvyfaPP0QkI/bId6fD4zHeMN3GJ7CdIBbPB
         0Z2CBMX8hfFrMaegM6tWW50H43h3s9ep9IIpaD3Ul6rZzM5xYvDDrQRSQ34kECugfJ4L
         mXtg==
X-Gm-Message-State: AMCzsaWL5I7OXiF3tcBUTi0v75V/C7PlFdhhhFcIiMNMc4IublarvuP2
        UamEH+RlQUKIGW7LYAmA7juhwqav
X-Google-Smtp-Source: ABhQp+TvFiNUYpmPjKAqAzcwOu3aKZwHfZofhBlWRMa1EAQuERLvpiPyiJcLGVcbqz2LqosJkBuQrw==
X-Received: by 10.237.52.198 with SMTP id x64mr118701qtd.326.1507901956110;
        Fri, 13 Oct 2017 06:39:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id f126sm543803qkd.37.2017.10.13.06.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2017 06:39:15 -0700 (PDT)
Subject: Re: git-clone causes out of memory
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>, Constantine <hi-angel@yandex.ru>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
 <20171013100603.5eed26sjjigph2il@glandium.org>
 <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
 <20171013103722.rvr7536mu2hoo4wb@glandium.org>
 <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
 <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
 <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
 <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
Message-ID: <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
Date:   Fri, 13 Oct 2017 09:39:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2017 9:15 AM, Derrick Stolee wrote:
> On 10/13/2017 8:44 AM, Jeff King wrote:
>> On Fri, Oct 13, 2017 at 03:12:43PM +0300, Constantine wrote:
>>
>>> On 13.10.2017 15:04, Junio C Hamano wrote:
>>>> Christian Couder <christian.couder@gmail.com> writes:
>>>>
>>>>> Yeah, but perhaps Git could be smarter when rev-listing too and avoid
>>>>> processing files or directories it has already seen?
>>>> Aren't you suggesting to optimize for a wrong case?
>>>>
>>> Anything that is possible with a software should be considered as a 
>>> possible
>>> usecase. It's in fact a DoS attack. Imagine there's a server that 
>>> using git
>>> to process something, and now there's a way to knock down this 
>>> server. It's
>>> also bad from a promotional stand point.
>> But the point is that you'd have the same problem with any repository
>> that had 10^7 files in it. Yes, it's convenient for the attacker that
>> there are only 9 objects, but fundamentally it's pretty easy for an
>> attacker to construct repositories that have large trees (or very deep
>> trees -- that's what causes stack exhaustion in some cases).
>>
>> Note too that this attack almost always comes down to the diff code
>> (which is why it kicks in for pathspec limiting) which has to actually
>> expand the tree. Most "normal" server-side operations (like accepting
>> pushes or serving fetches) operate only on the object graph and _do_
>> avoid processing already-seen objects.
>>
>> As soon as servers start trying to checkout or diff, though, the attack
>> surface gets quite large. And you really need to start thinking about
>> having resource limits and quotas for CPU and memory use of each process
>> (and group by requesting user, IP, repo, etc).
>>
>> I think the main thing Git could be doing here is to limit the size of
>> the tree (both width and depth). But arbitrary limits like that have a
>> way of being annoying, and I think it just pushes resource-exhaustion
>> attacks off a little (e.g., can you construct a blob that behaves badly
>> with the "--patch"?).
>>
>> -Peff
>
> I'm particularly interested in why `git rev-list HEAD -- [path]` gets 
> slower in this case, because I wrote the history algorithm used by 
> VSTS. In our algorithm, we only walk the list of objects from commit 
> to the tree containing the path item. For example, in the path 
> d0/d0/d0, we would only walk:
>
>     commit --root--> tree --d0--> tree --d0--> tree [parse oid for d0 
> entry]
>
> From this, we can determine the TREESAME relationship by parsing four 
> objects without parsing all contents below d0/d0/d0.
>
> The reason we have exponential behavior in `git rev-list` is because 
> we are calling diff_tree_oid() in tree-diff.c recursively without 
> short-circuiting on equal OIDs.
>
> I will prepare a patch that adds this OID-equal short-circuit to avoid 
> this exponential behavior. I'll model my patch against a similar patch 
> in master:
>
>     commit d12a8cf0af18804c2000efc7a0224da631e04cd1 unpack-trees: 
> avoid duplicate ODB lookups during checkout
>
> It will also significantly speed up rev-list calls for short paths in 
> deep repositories. It will not be very measurable in the git or Linux 
> repos because their shallow folder structure.
>
> Thanks,
> -Stolee

Since I don't understand enough about the consumers to diff_tree_oid() 
(and the fact that the recursive behavior may be wanted in some cases), 
I think we can fix this in builtin/rev-list.c with this simple diff:

---

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ded1577424..b2e8e02cc8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -285,6 +285,9 @@ int cmd_rev_list(int argc, const char **argv, const 
char *prefix)

         git_config(git_default_config, NULL);
         init_revisions(&revs, prefix);
+
+       revs.pruning.flags = revs.pruning.flags & ~DIFF_OPT_RECURSIVE;
+
         revs.abbrev = DEFAULT_ABBREV;
         revs.commit_format = CMIT_FMT_UNSPECIFIED;
         argc = setup_revisions(argc, argv, &revs, NULL);

