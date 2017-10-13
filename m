Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9A720445
	for <e@80x24.org>; Fri, 13 Oct 2017 13:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbdJMNQD (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 09:16:03 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:55576 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753394AbdJMNQA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 09:16:00 -0400
Received: by mail-qt0-f174.google.com with SMTP id v41so9250586qtv.12
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zUmlZ19GU+Gnp8k41B1Ijna9FaYswS4Li1MOi4jqNF0=;
        b=XFqs/aL+3CryndNkd126NwZooCV4AW9Ew+JsiXAkPwJW5tLCHoMX1dU0jz2v2E5U9X
         hz/54SBZ1Kg/MQ1ALHngT6ppDJu5iEdry67tZkXcyqzIWktfw3GwhYkwhYsEimypRKzy
         ZC8yyZvJiOdr8GrUzvUx2PAOp6h49+8SwUuw28gY8vJbjOplftaeol7uT4m9aajBqpa9
         DbgA6upwuOEcP+Vf6aBWWirMpJSlxXwjdrY62Tf5LFC1I2xpP8zgcLYl7xF9w4RLJrc8
         EF7dKFUlwO8wa7JGsjintD/+Jc55jh5/k78PW3hANh/gZCNvDasMFZoHsHwIASJn/A+F
         SJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zUmlZ19GU+Gnp8k41B1Ijna9FaYswS4Li1MOi4jqNF0=;
        b=aaw9Y1vRJOseVzw6w/QbUy4kuoAyApskpzzn+Wh06MYwStQev4SQvvUiqbt/bizXqQ
         tOdB0K6QANaOAX8eKASCz9e8aUv7XeZQnXu3Hopga9l1jQrvx2ojCQyVSQCU2hblFaC9
         tnbOu1dBu02kOYpA2y0/0g4WzOhKx1jf2kELz+ZfLOzapVIXV49L6LUGT+m3bOMGuGDW
         smmUt/0IBylO9xqhgI/uV7d6ZWIzDErQjCRpFrXd++wWjbMfsDBwZrAcQF+wDJ+I9URI
         GwttVxxnTVnhYbbCpeaefYxM7qjdVgJz9Tdj8XlyDNFAoKKLsnGe7R/WuB/E1q7PfaFh
         4S/Q==
X-Gm-Message-State: AMCzsaUqPHMPop+FO4SXgWEjJ1Zgsnc2oorSQFjbCS5heppS93vfyQ/e
        1RrcsQ0qvcb5gvTOmbjvQTax8tTP
X-Google-Smtp-Source: ABhQp+Sd6W4udwyUebomNecHHeZFZ3JuO6CbwgiWLpQTp9abH9L/8zsGB9dZ6iDl7jCqBD10Pva7ow==
X-Received: by 10.237.53.92 with SMTP id b28mr2032346qte.280.1507900559344;
        Fri, 13 Oct 2017 06:15:59 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id t84sm525996qki.13.2017.10.13.06.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2017 06:15:58 -0700 (PDT)
Subject: Re: git-clone causes out of memory
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
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
Date:   Fri, 13 Oct 2017 09:15:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2017 8:44 AM, Jeff King wrote:
> On Fri, Oct 13, 2017 at 03:12:43PM +0300, Constantine wrote:
>
>> On 13.10.2017 15:04, Junio C Hamano wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> Yeah, but perhaps Git could be smarter when rev-listing too and avoid
>>>> processing files or directories it has already seen?
>>> Aren't you suggesting to optimize for a wrong case?
>>>
>> Anything that is possible with a software should be considered as a possible
>> usecase. It's in fact a DoS attack. Imagine there's a server that using git
>> to process something, and now there's a way to knock down this server. It's
>> also bad from a promotional stand point.
> But the point is that you'd have the same problem with any repository
> that had 10^7 files in it. Yes, it's convenient for the attacker that
> there are only 9 objects, but fundamentally it's pretty easy for an
> attacker to construct repositories that have large trees (or very deep
> trees -- that's what causes stack exhaustion in some cases).
>
> Note too that this attack almost always comes down to the diff code
> (which is why it kicks in for pathspec limiting) which has to actually
> expand the tree. Most "normal" server-side operations (like accepting
> pushes or serving fetches) operate only on the object graph and _do_
> avoid processing already-seen objects.
>
> As soon as servers start trying to checkout or diff, though, the attack
> surface gets quite large. And you really need to start thinking about
> having resource limits and quotas for CPU and memory use of each process
> (and group by requesting user, IP, repo, etc).
>
> I think the main thing Git could be doing here is to limit the size of
> the tree (both width and depth). But arbitrary limits like that have a
> way of being annoying, and I think it just pushes resource-exhaustion
> attacks off a little (e.g., can you construct a blob that behaves badly
> with the "--patch"?).
>
> -Peff

I'm particularly interested in why `git rev-list HEAD -- [path]` gets 
slower in this case, because I wrote the history algorithm used by VSTS. 
In our algorithm, we only walk the list of objects from commit to the 
tree containing the path item. For example, in the path d0/d0/d0, we 
would only walk:

     commit --root--> tree --d0--> tree --d0--> tree [parse oid for d0 
entry]

 From this, we can determine the TREESAME relationship by parsing four 
objects without parsing all contents below d0/d0/d0.

The reason we have exponential behavior in `git rev-list` is because we 
are calling diff_tree_oid() in tree-diff.c recursively without 
short-circuiting on equal OIDs.

I will prepare a patch that adds this OID-equal short-circuit to avoid 
this exponential behavior. I'll model my patch against a similar patch 
in master:

     commit d12a8cf0af18804c2000efc7a0224da631e04cd1 unpack-trees: avoid 
duplicate ODB lookups during checkout

It will also significantly speed up rev-list calls for short paths in 
deep repositories. It will not be very measurable in the git or Linux 
repos because their shallow folder structure.

Thanks,
-Stolee
